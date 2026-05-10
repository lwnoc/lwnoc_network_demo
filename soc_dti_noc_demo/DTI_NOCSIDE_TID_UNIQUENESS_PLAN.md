# DTI Noc-Side TID Uniqueness Plan

## Goal

Solve DTI response-routing ambiguity when multiple SoC leaf INIUs are instantiated from the same shared RTL and therefore cannot rely on per-instance sys-side parameterization such as unique `TTID_BASE`.

The required outcome is:

- shared sys-side INIU RTL may remain identical across multiple leaf instances
- each leaf still presents a unique, non-overlapping routable ID space to the DTI switch fabric
- switch REQ/RSP routing semantics remain unchanged: routing key is still `srcid`
- `dti_pr` ROB matching continues to operate on local TID semantics and does not need to become topology-aware

## Problem Statement

Current DTI semantics assume that each INIU instance emits a globally unique TTID on noc-side `req_srcid`.

Relevant current behavior:

- [dti_pr.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/iniu/dti_pr.sv#L196) computes `req_tid = req_ttid + TTID_BASE`
- [dti_to_gnpd_conv.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/iniu/dti_to_gnpd_conv.sv#L39-L47) forwards `req_ttid` to `req_srcid`
- [dti_noc_switch.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/network/dti_noc_switch.sv#L236-L256) routes RSP only by `rsp_srcid` range hit on `INIU_DECMIN/MAX`

If two leaf INIU instances share the same sys-side RTL instance configuration and therefore share the same effective TTID space, then they can emit identical `req_srcid` values onto the same switch domain. In that case the switch cannot uniquely return `rsp_srcid` to the correct leaf.

This means the uniqueness constraint must move away from shared sys-side parameterization and into noc-side leaf ownership.

## Chosen Architecture

Do not redefine DTI switch semantics.

Do not rely on unique per-instance sys-side `TTID_BASE`.

Instead, introduce a noc-side leaf-local ID translation layer:

- sys-side INIU continues to operate on local TID space
- INIU noc-side egress adds a leaf-specific `ROUTE_BASE` to outgoing `req_srcid`
- INIU noc-side ingress subtracts the same `ROUTE_BASE` from incoming `rsp_srcid`
- switch fabric sees only globally unique routed IDs
- sys-side `dti_pr` and ROB continue to see only local IDs

This is the closest DTI analogue to INTR's "leaf owns a stable noc-side identity" model, but without changing DTI switch protocol rules.

Primary implementation choice for this plan:

- do the ID lift/shrink directly inside the generated INIU leaf wrapper path in [DtiNode.py](/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo/DtiNode.py)
- do not add a standalone RTL translator module unless UHDL wrapper wiring proves unable to express the field-level add/sub cleanly

## Data Path Before And After

### Current path

1. TBU drives local `req_ttid`
2. sys-side INIU / `dti_pr` consumes `req_ttid`
3. top-side emits `req_srcid = local/global TTID` directly
4. switch routes by `req_srcid`
5. TNIU returns `rsp_srcid`
6. top-side passes `rsp_srcid` straight back to sys-side

### Planned path

1. TBU drives local `req_ttid`
2. sys-side INIU / `dti_pr` consumes local `req_ttid`
3. top-side emits local `req_srcid`
4. INIU leaf wrapper logic outputs `req_srcid + ROUTE_BASE`
5. switch routes by translated global `req_srcid`
6. TNIU returns translated `rsp_srcid`
7. INIU leaf wrapper logic outputs `rsp_srcid - ROUTE_BASE`
8. sys-side INIU sees local `rsp_srcid` again

## Why This Works

### REQ path

Top-side INIU wrapper already exposes `req_srcid` on noc side:

- [dti_pr_iniu_async_top_side.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/dti_pr_iniu_async_top_side.sv#L30)
- [dti_pr_iniu_async_top_side.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/dti_pr_iniu_async_top_side.sv#L119)

So the generated leaf wrapper can modify the routable ID without changing shared sys-side RTL.

### RSP path

Top-side INIU wrapper already receives `rsp_srcid` from the switch side and repacks it into the async FIFO payload:

- [dti_pr_iniu_async_top_side.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/dti_pr_iniu_async_top_side.sv#L21)
- [dti_pr_iniu_async_top_side.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/dti_pr_iniu_async_top_side.sv#L164)

So the same generated leaf wrapper logic can reverse the mapping before the response re-enters sys-side logic.

### ROB safety

`dti_pr` ROB matching remains local-TID based and does not need switch/topology awareness:

- [dti_pr.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/iniu/dti_pr.sv#L82-L89)
- [dti_pr.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/iniu/dti_pr.sv#L156-L170)

That is the main reason to keep translation out of `dti_pr` and out of `dti_pr_rob_state_entry`.

## RTL Change Set

### 1. Implement ID translation directly in the INIU leaf wrapper

Primary plan: do not add a new standalone RTL file.

Instead, extend the generated INIU leaf wrapper path so that the wrapper itself performs the `srcid` lift/shrink.

Modify:

- [DtiNode.py](/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo/DtiNode.py)

Current direct connection point is already local and narrow:

- [DtiNode.py](/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo/DtiNode.py#L361-L362)

Current structure is:

- `sys_wrap <-> async_fifo <-> top_wrap <-> switch-facing top_req/top_rsp`

Planned structure is still the same hierarchy, but the arithmetic now lives directly in wrapper-level wiring:

- `sys_wrap <-> async_fifo <-> top_wrap <-> wrapper-local req/rsp srcid lift-shrink <-> switch-facing top_req/top_rsp`

Required wrapper behavior:

- pass through `valid/payload/last/qos/tgtid/threshold/ready`
- on REQ export: `switch_req_srcid = top_wrap_req_srcid + ROUTE_BASE`
- on RSP import: `top_wrap_rsp_srcid = switch_rsp_srcid - ROUTE_BASE`

No additional state is required.

### 2. Insert wrapper-local lift/shrink logic into `DtiIniuNode`

Modify:

- [DtiNode.py](/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo/DtiNode.py#L326)

`DtiIniuNode.__init__` should accept a new leaf-local argument:

- `route_base: int`

Inside `DtiIniuNode`, add wrapper-local intermediate req/rsp signals or bundle objects between `top_wrap` and the exported `top_req` / `top_rsp` interfaces, then perform field-level mapping:

- `top_req.valid/payload/last/tgtid/qos/threshold/ready` remain direct pass-through
- `top_req.srcid` is exported as `top_wrap.top_req.srcid + route_base`
- `top_rsp.valid/payload/last/tgtid/qos/threshold/ready` remain direct pass-through
- `top_wrap.top_rsp.srcid` is driven from `top_rsp.srcid - route_base`

If the current UHDL layer can express those bundle-field arithmetic assignments cleanly, that is the preferred implementation.

### 3. Optional fallback: standalone translator only if wrapper arithmetic is awkward

If UHDL bundle-level arithmetic or code generation makes direct wrapper insertion unreadable or fragile, then a tiny standalone translator module remains an acceptable fallback.

That fallback should still be treated as demo/topology-owned glue logic, not as a change to the shared DTI protocol IP.

### 4. Keep shared sys-side DTI IP unchanged for TID uniqueness

Do not move uniqueness into these files:

- [dti_pr.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/iniu/dti_pr.sv)
- [dti_pr_rob_state_entry.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/iniu/dti_pr_rob_state_entry.sv)
- [dti_to_gnpd_conv.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/iniu/dti_to_gnpd_conv.sv)

These blocks should continue to operate in local ID space.

### 5. Update topology builder to assign route bases per leaf

Modify:

- [DtiTreeTopo.py](/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo/DtiTreeTopo.py)

Every `DtiIniuNode(...)` instantiation should pass an explicit `route_base`.

This route base is topology-owned, not IP-owned.

For the current frozen leaf plan, recommended route bases are:

| Leaf | Route Base | Covered Local TIDs | Exposed Switch Range |
| --- | ---: | --- | --- |
| `npu_ss0` | 0 | `[0..TBU_NUM-1]` | `[0..TBU_NUM-1]` |
| `npu_ss3` | 1 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[1*TBU_NUM .. 2*TBU_NUM-1]` |
| `npu_ss4` | 2 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[2*TBU_NUM .. 3*TBU_NUM-1]` |
| `npu_ss2` | 3 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[3*TBU_NUM .. 4*TBU_NUM-1]` |
| `npu_ss1` | 4 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[4*TBU_NUM .. 5*TBU_NUM-1]` |
| `peri_ss` | 5 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[5*TBU_NUM .. 6*TBU_NUM-1]` |
| `ufs_ss` | 6 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[6*TBU_NUM .. 7*TBU_NUM-1]` |
| `pcie_eth_ss` | 7 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[7*TBU_NUM .. 8*TBU_NUM-1]` |
| `gpu_ss0` | 8 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[8*TBU_NUM .. 9*TBU_NUM-1]` |
| `dspss0` | 9 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[9*TBU_NUM .. 10*TBU_NUM-1]` |
| `dspss1` | 10 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[10*TBU_NUM .. 11*TBU_NUM-1]` |
| `dspss2` | 11 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[11*TBU_NUM .. 12*TBU_NUM-1]` |
| `dspss3` | 12 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[12*TBU_NUM .. 13*TBU_NUM-1]` |
| `dspss4` | 13 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[13*TBU_NUM .. 14*TBU_NUM-1]` |
| `dspss5` | 14 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[14*TBU_NUM .. 15*TBU_NUM-1]` |
| `camera_ss` | 15 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[15*TBU_NUM .. 16*TBU_NUM-1]` |
| `mipi_ss` | 16 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[16*TBU_NUM .. 17*TBU_NUM-1]` |
| `gpu_ss1` | 17 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[17*TBU_NUM .. 18*TBU_NUM-1]` |
| `usb_dp_ss` | 18 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[18*TBU_NUM .. 19*TBU_NUM-1]` |
| `display_ss` | 19 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[19*TBU_NUM .. 20*TBU_NUM-1]` |
| `vpu_ss` | 20 x `TBU_NUM` | `[0..TBU_NUM-1]` | `[20*TBU_NUM .. 21*TBU_NUM-1]` |

For the current demo assumption `TBU_NUM=1`, this degenerates to the earlier `[0..20]` single-slot plan.

### 6. Recompute switch DEC tables in topology-owned global ID space

Modify:

- [DtiTemplate.py](/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo/DtiTemplate.py)

Switch DEC tables must be expressed in the translated global route space, not in shared local TID space.

For the already frozen `TBU_NUM=1` case, the current packed values remain valid.

For generic `TBU_NUM = N`, each leaf occupies a window of width `N`, and each merge subtree occupies the union of those windows.

That means the current plan's leaf ordering remains useful, but every scalar range becomes:

- leaf `k` owns `[k*N .. k*N + (N-1)]`
- merge ranges become contiguous unions of these windows

### 7. Keep TNIU unchanged unless a future design asks for symmetric translation

Current TNIU path already accepts whatever global `req_srcid` the switch provides and turns it into outgoing `req_ttid`:

- [gnpd_to_dti_conv.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/tniu/gnpd_to_dti_conv.sv#L37-L49)

No translator is required on TNIU side for this plan.

## Why Not Change The Switch Instead

Do not tie a leaf identity at each switch ingress and route RSP by ingress port number.

Reason:

- one switch ingress may represent a whole child subtree, not a single leaf
- collapsing that subtree to one ingress ID destroys the information needed by lower-level switches to return responses to the correct child leaf

Current switch implementation is intentionally stateless-by-range on the RSP path:

- [dti_noc_switch.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/network/dti_noc_switch.sv#L236-L256)

So the safe place to add uniqueness is the leaf noc-side boundary, not intermediate switches.

## Why Not Change `dti_pr_rob_state_entry`

`dti_pr_rob_state_entry` is only one ROB-entry state machine.

It does not own leaf identity or topology identity.

It only latches the incoming local `entry_tid_in` on connection allocate:

- [dti_pr_rob_state_entry.sv](/home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_dti_noc/rtl/iniu/dti_pr_rob_state_entry.sv#L107-L110)

Changing uniqueness here would push topology policy into the wrong abstraction boundary and would still not solve switch-facing response routing by itself.

## Validation Plan

### Structural checks

1. For two leaves sharing the same sys-side config and local TID space, confirm their exported noc-side `req_srcid` windows are disjoint after translation.
2. Confirm incoming `rsp_srcid` is mapped back into local `[0 .. TBU_NUM-1]` space before reaching sys-side logic.
3. Confirm switch `INIU_DECMIN/MAX` matches translated leaf windows, not local leaf windows.

### Behavioral checks

1. Instantiate two leaf INIUs from the same shared sys-side config.
2. Drive both with the same local `req_ttid` sequence.
3. Confirm noc-side emitted `req_srcid` values differ by `ROUTE_BASE`.
4. Confirm a TNIU response tagged with the translated `rsp_srcid` returns to the correct leaf.
5. Confirm the receiving leaf's sys-side ROB still sees the original local TID and matches the correct entry.

## Recommended Implementation Order

1. Extend [DtiNode.py](/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo/DtiNode.py) so `DtiIniuNode` accepts `route_base`
2. Insert wrapper-local `req_srcid` lift and `rsp_srcid` shrink logic into `DtiIniuNode`
3. Add `route_base` plumbing in [DtiTreeTopo.py](/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo/DtiTreeTopo.py)
4. Recompute switch DEC tables in [DtiTemplate.py](/home/lgzhu/dev/noc_work/lwnoc_network_demo/soc_dti_noc_demo/DtiTemplate.py)
5. Run one shared-config multi-instance sanity test
6. Only if wrapper arithmetic proves impractical, fall back to a tiny standalone translator module

## Out Of Scope

This plan does not redesign DTI switch routing to use ingress port identity.

This plan does not require each shared sys-side IP instance to carry a unique parameter value.

This plan does not change the internal meaning of `dti_pr` ROB local TIDs.

This plan does not require adding a new standalone RTL module as the primary implementation path.