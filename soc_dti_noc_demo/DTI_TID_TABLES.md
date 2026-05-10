# DTI TID Tables

## Scope

This note records two related tables for the current `soc_dti_noc_demo` source:

- the current NoC routing TID table actually consumed by the switch fabric
- the INIU noc-side ID translation table that maps leaf-local TIDs into globally routable IDs

Current source assumptions:

- `SOC_DTI_TBU_NUM = 1`
- each leaf currently occupies a single NoC-side routable TID slot

Key source anchors:

- `soc_dti_noc_demo/DtiTemplate.py`
- `soc_dti_noc_demo/DtiTreeTopo.py`
- `subs/lwnoc_dti_noc/rtl/dti_pr_iniu_async_top_side.sv`
- `subs/lwnoc_dti_noc/rtl/network/dti_noc_switch.sv`
- `subs/lwnoc_dti_noc/rtl/iniu/dti_pr.sv`

## How Switch Params Reach RTL

Yes, the switch decode parameters are now delivered to the generated switch wrappers through defines/macros.

But those define values are still computed from the source-owned DTI truth tables, not hand-written independently.

The current generation path is:

1. `SOC_DTI_TTID_LEAF_ORDER` fixes the current actual leaf order.
2. `SOC_DTI_TTID_BASE_BY_LEAF` and `get_soc_dti_ttid_window()` compute each leaf or subtree window.
3. `SOC_DTI_SWITCH_TTID_LAYOUTS` builds each switch's `child_ranges` and aggregate `tniu_range`.
4. `_new_dti_switch_config()` copies those values into `param_overrides` and then calls `set_macro(...)` so the wrapper sees them through defines.

So the wrapper compile path is indeed define-based, but the define values still come from the current source-level TID order and window calculation.

## Return-Path Conclusion

For a leaf INIU with multiple TBUs in front of the same sys-side instance, the response can still return to the correct request path, but only if the leaf-local TID window width and the switch decode windows are updated consistently.

The controlling equations are:

- noc-side request route ID: `noc_req_srcid = local_tid + route_base`
- switch response return condition: `INIU_DECMIN[i] <= rsp_srcid <= INIU_DECMAX[i]`
- top-side response restore: `local_rsp_tid = rsp_srcid - route_base`

That means the switch only guarantees return to the correct leaf INIU. After the packet re-enters the leaf, the top-side wrapper subtracts `route_base`, and then the sys-side INIU/ROB matches the restored local TID back to the original request.

So the multi-TBU answer is:

1. If a leaf owns a non-overlapping routed window of width `TBU_NUM`, then RSP can return to the correct leaf and then to the correct local request.
2. If only the front-end TBU count changes but the routed windows and switch decode ranges are not widened consistently, correctness is not guaranteed.
3. The current checked source configuration is still `TBU_NUM = 1`, so the current live truth table is a single-slot-per-leaf table.

## Table 1: Current Routing TID Table

This table is the live NoC-side routing table seen by the switch fabric under the current source configuration.

| Current NoC routing ID | Leaf | Connection path | Exit TNIU |
| ---: | --- | --- | --- |
| 0 | `npu_ss0` | `top_spine.iniu0` | `cpu_ss_tniu1` |
| 1 | `npu_ss3` | `bottom_merge1.iniu0 -> top_spine.iniu1` | `cpu_ss_tniu1` |
| 2 | `npu_ss4` | `bottom_merge1.iniu1 -> top_spine.iniu1` | `cpu_ss_tniu1` |
| 3 | `npu_ss2` | `bottom_merge1.iniu2 -> top_spine.iniu1` | `cpu_ss_tniu1` |
| 4 | `npu_ss1` | `top_spine.iniu2` | `cpu_ss_tniu1` |
| 5 | `peri_ss` | `tl_merge0.iniu0` | `cpu_ss_tniu0` |
| 6 | `ufs_ss` | `bottom_merge0.iniu0 -> tl_merge0.iniu1` | `cpu_ss_tniu0` |
| 7 | `pcie_eth_ss` | `bottom_merge0.iniu1 -> tl_merge0.iniu1` | `cpu_ss_tniu0` |
| 8 | `gpu_ss0` | `bottom_merge0.iniu2 -> tl_merge0.iniu1` | `cpu_ss_tniu0` |
| 9 | `dspss0` | `dsp_merge0.iniu0 -> tl_merge0.iniu2` | `cpu_ss_tniu0` |
| 10 | `dspss1` | `dsp_merge0.iniu1 -> tl_merge0.iniu2` | `cpu_ss_tniu0` |
| 11 | `dspss2` | `dsp_merge0.iniu2 -> tl_merge0.iniu2` | `cpu_ss_tniu0` |
| 12 | `dspss3` | `dsp_merge0.iniu3 -> tl_merge0.iniu2` | `cpu_ss_tniu0` |
| 13 | `dspss4` | `dsp_merge0.iniu4 -> tl_merge0.iniu2` | `cpu_ss_tniu0` |
| 14 | `dspss5` | `dsp_merge0.iniu5 -> tl_merge0.iniu2` | `cpu_ss_tniu0` |
| 15 | `camera_ss` | `tr_merge0.iniu0 -> tl_merge0.iniu3` | `cpu_ss_tniu0` |
| 16 | `mipi_ss` | `tr_merge0.iniu1 -> tl_merge0.iniu3` | `cpu_ss_tniu0` |
| 17 | `gpu_ss1` | `tr_merge0.iniu2 -> tl_merge0.iniu3` | `cpu_ss_tniu0` |
| 18 | `usb_dp_ss` | `tr_merge0.iniu3 -> tl_merge0.iniu3` | `cpu_ss_tniu0` |
| 19 | `display_ss` | `tr_merge0.iniu4 -> tl_merge0.iniu3` | `cpu_ss_tniu0` |
| 20 | `vpu_ss` | `tr_merge0.iniu5 -> tl_merge0.iniu3` | `cpu_ss_tniu0` |

Current TNIU total windows:

- `cpu_ss_tniu1`: `[0..4]`
- `cpu_ss_tniu0`: `[5..20]`

## Current Actual TID Ordering

The current actual routed TID order is not an arbitrary numbering.

Because `SOC_DTI_TBU_NUM = 1`, the current routed TID is exactly the slot index in the leaf order table. The order is deliberately chosen so every merge subtree occupies one contiguous routed window.

Current actual leaf order:

1. `0  -> npu_ss0`
2. `1  -> npu_ss3`
3. `2  -> npu_ss4`
4. `3  -> npu_ss2`
5. `4  -> npu_ss1`
6. `5  -> peri_ss`
7. `6  -> ufs_ss`
8. `7  -> pcie_eth_ss`
9. `8  -> gpu_ss0`
10. `9  -> dspss0`
11. `10 -> dspss1`
12. `11 -> dspss2`
13. `12 -> dspss3`
14. `13 -> dspss4`
15. `14 -> dspss5`
16. `15 -> camera_ss`
17. `16 -> mipi_ss`
18. `17 -> gpu_ss1`
19. `18 -> usb_dp_ss`
20. `19 -> display_ss`
21. `20 -> vpu_ss`

Why it is arranged this way:

- `top_spine` is forced to be one contiguous window: `[0..4]`
- `bottom_merge1` sits inside that as `[1..3]`
- `tl_merge0` is forced to be another contiguous window: `[5..20]`
- inside `tl_merge0`, `bottom_merge0 = [6..8]`, `dsp_merge0 = [9..14]`, and `tr_merge0 = [15..20]`

That contiguous layout is what lets the switch return responses by simple range decode.

## Current Switch Decode Windows

This is the current actual decode content that ultimately gets passed into the switch wrappers via defines.

| Switch | Current ordered children | Current child routed windows | Current aggregate TNIU window |
| --- | --- | --- | --- |
| `bottom_merge1` | `npu_ss3`, `npu_ss4`, `npu_ss2` | `[1..1]`, `[2..2]`, `[3..3]` | `[1..3]` |
| `bottom_merge0` | `ufs_ss`, `pcie_eth_ss`, `gpu_ss0` | `[6..6]`, `[7..7]`, `[8..8]` | `[6..8]` |
| `dsp_merge0` | `dspss0`, `dspss1`, `dspss2`, `dspss3`, `dspss4`, `dspss5` | `[9..9]`, `[10..10]`, `[11..11]`, `[12..12]`, `[13..13]`, `[14..14]` | `[9..14]` |
| `tr_merge0` | `camera_ss`, `mipi_ss`, `gpu_ss1`, `usb_dp_ss`, `display_ss`, `vpu_ss` | `[15..15]`, `[16..16]`, `[17..17]`, `[18..18]`, `[19..19]`, `[20..20]` | `[15..20]` |
| `tl_merge0` | `peri_ss`, `bottom_merge0`, `dsp_merge0`, `tr_merge0` | `[5..5]`, `[6..8]`, `[9..14]`, `[15..20]` | `[5..20]` |
| `top_spine` | `npu_ss0`, `bottom_merge1`, `npu_ss1` | `[0..0]`, `[1..3]`, `[4..4]` | `[0..4]` |

## Example: Only `vpu_ss` Uses `TBU_NUM=2`

If only `vpu_ss` changes from `TBU_NUM=1` to `TBU_NUM=2`, and every other leaf stays at `TBU_NUM=1`, the routed-ID plan changes as follows.

### What Stays The Same

- `vpu_ss` is already the last leaf in the current leaf order.
- So all leaves before `vpu_ss` keep their current routed IDs.
- `top_spine`, `bottom_merge1`, `bottom_merge0`, and `dsp_merge0` do not need any routed-window change.
- `TID_WIDTH=6` is still enough because the largest routed ID only grows from `20` to `21`.
- `INIU_TBU_NUM_WIDTH` is currently fixed to `6` in the sub-IP defines, so no interface width widening is required for this case.

### Updated ID Mapping

`vpu_ss` keeps `route_base = 20`, but it now owns a 2-slot local TID window.

| Leaf | Local TID window | Route base | Routed NoC window |
| --- | --- | ---: | --- |
| `vpu_ss` | `[0..1]` | `20` | `[20..21]` |

All other leaves stay unchanged:

- `npu_ss0 .. display_ss` keep their current single-slot routed IDs `0..19`
- `vpu_ss` expands from `[20..20]` to `[20..21]`

### Updated Subtree Windows

Only the windows that contain `vpu_ss` need to grow.

| Node or exit | Old window | New window when only `vpu_ss` has `TBU_NUM=2` |
| --- | --- | --- |
| `tr_merge0` | `[15..20]` | `[15..21]` |
| `tl_merge0` | `[5..20]` | `[5..21]` |
| `cpu_ss_tniu0` | `[5..20]` | `[5..21]` |
| `cpu_ss_tniu1` | `[0..4]` | `[0..4]` |

### Updated Switch Child Windows

Only `tr_merge0` and `tl_merge0` need decode-range changes.

#### `tr_merge0`

Old child windows:

- `camera_ss  = [15..15]`
- `mipi_ss    = [16..16]`
- `gpu_ss1    = [17..17]`
- `usb_dp_ss  = [18..18]`
- `display_ss = [19..19]`
- `vpu_ss     = [20..20]`

New child windows:

- `camera_ss  = [15..15]`
- `mipi_ss    = [16..16]`
- `gpu_ss1    = [17..17]`
- `usb_dp_ss  = [18..18]`
- `display_ss = [19..19]`
- `vpu_ss     = [20..21]`

So `tr_merge0` becomes:

- `TNIU_DECMIN = 15`
- `TNIU_DECMAX = 21`
- `INIU child windows = [(15,15), (16,16), (17,17), (18,18), (19,19), (20,21)]`

#### `tl_merge0`

Old child windows:

- `peri_ss      = [5..5]`
- `bottom_merge0 = [6..8]`
- `dsp_merge0    = [9..14]`
- `tr_merge0     = [15..20]`

New child windows:

- `peri_ss       = [5..5]`
- `bottom_merge0 = [6..8]`
- `dsp_merge0    = [9..14]`
- `tr_merge0     = [15..21]`

So `tl_merge0` becomes:

- `TNIU_DECMIN = 5`
- `TNIU_DECMAX = 21`
- `INIU child windows = [(5,5), (6,8), (9,14), (15,21)]`

### Template Configuration Change

Under the current on-disk template structure, the first required change is to stop forcing all INIUs through the same `_SINGLE_TBU_PARAMS`.

Recommended shape:

```python
_DEFAULT_INIU_PARAMS = {"TBU_NUM": 1, "TRANSACTION_MAX_NUM": 8}
_VPU_INIU_PARAMS = {"TBU_NUM": 2, "TRANSACTION_MAX_NUM": 8}


def _iniu_sys_cfg(name: str, prefix: str, env_var: str, params: dict[str, int] | None = None) -> TemplateIPConfig:
	cfg = TemplateIPConfig(name=name, prefix=prefix, filelist=_INIU_SYS_FILELIST, env_var=env_var)
	cfg.param_overrides = dict(_DEFAULT_INIU_PARAMS if params is None else params)
	return cfg


vpu_iniu_sys_config = _iniu_sys_cfg(
	"vpu_iniu_sys",
	"vpu_",
	"VPU_INIU_SYS_DIR",
	params=_VPU_INIU_PARAMS,
)
```

That change updates the sys-side INIU instance only. It is the piece that makes `dti_pr_iniu_async_sys_side` instantiate `dti_pr` with `TBU_NUM=2` for `vpu_ss`.

### Route-Base Change

For this specific case, `vpu_ss` route base does not move.

Because `vpu_ss` is the last leaf in the current order, the correct routed plan is still:

- `route_base(vpu_ss) = 20`
- `vpu_ss` routed window = `[20..21]`

So if your flow already has per-leaf route-base plumbing, you do not change `vpu_ss` base from `20` to `21`. You keep the base at `20` and widen only the owned window.

### If You Keep The Old Manual Switch Config Style

If you are still on the older hand-written switch cfg style instead of the source-owned truth-table generator style, then the relevant template cfg changes are conceptually:

```python
tr_iniu_decmin, tr_iniu_decmax = _pack_u32_ranges([
	(15, 15),
	(16, 16),
	(17, 17),
	(18, 18),
	(19, 19),
	(20, 21),
])

dti_sw3_config.param_overrides = dict(
	_SWITCH_COMMON,
	NUM_INIU=6,
	TNIU_DECMIN=15,
	TNIU_DECMAX=21,
	INIU_DECMIN=tr_iniu_decmin,
	INIU_DECMAX=tr_iniu_decmax,
)

tl_iniu_decmin, tl_iniu_decmax = _pack_u32_ranges([
	(5, 5),
	(6, 8),
	(9, 14),
	(15, 21),
])

dti_sw4_config.param_overrides = dict(
	_SWITCH_COMMON,
	NUM_INIU=4,
	TNIU_DECMIN=5,
	TNIU_DECMAX=21,
	INIU_DECMIN=tl_iniu_decmin,
	INIU_DECMAX=tl_iniu_decmax,
)
```

Everything else can remain unchanged for the `vpu_ss = 2` case.

## Table 2: Generalized INIU Noc-Side ID Calculation Rule

This table is not the current live routing table again. It is the calculation rule used to derive the leaf-local to NoC-side mapping when `TBU_NUM` changes.

Under the current live source, `TBU_NUM = 1`, so the current routed ID collapses to the slot index shown above.

| Leaf | Slot index `s` | Current routed ID when `TBU_NUM=1` | Local TID window when `TBU_NUM=N` | Generalized `route_base` when `TBU_NUM=N` | Generalized NoC-side routable window when `TBU_NUM=N` |
| --- | ---: | ---: | --- | ---: | --- |
| `npu_ss0` | 0 | 0 | `[0 .. N-1]` | `0*N` | `[0*N .. 0*N + (N-1)]` |
| `npu_ss3` | 1 | 1 | `[0 .. N-1]` | `1*N` | `[1*N .. 1*N + (N-1)]` |
| `npu_ss4` | 2 | 2 | `[0 .. N-1]` | `2*N` | `[2*N .. 2*N + (N-1)]` |
| `npu_ss2` | 3 | 3 | `[0 .. N-1]` | `3*N` | `[3*N .. 3*N + (N-1)]` |
| `npu_ss1` | 4 | 4 | `[0 .. N-1]` | `4*N` | `[4*N .. 4*N + (N-1)]` |
| `peri_ss` | 5 | 5 | `[0 .. N-1]` | `5*N` | `[5*N .. 5*N + (N-1)]` |
| `ufs_ss` | 6 | 6 | `[0 .. N-1]` | `6*N` | `[6*N .. 6*N + (N-1)]` |
| `pcie_eth_ss` | 7 | 7 | `[0 .. N-1]` | `7*N` | `[7*N .. 7*N + (N-1)]` |
| `gpu_ss0` | 8 | 8 | `[0 .. N-1]` | `8*N` | `[8*N .. 8*N + (N-1)]` |
| `dspss0` | 9 | 9 | `[0 .. N-1]` | `9*N` | `[9*N .. 9*N + (N-1)]` |
| `dspss1` | 10 | 10 | `[0 .. N-1]` | `10*N` | `[10*N .. 10*N + (N-1)]` |
| `dspss2` | 11 | 11 | `[0 .. N-1]` | `11*N` | `[11*N .. 11*N + (N-1)]` |
| `dspss3` | 12 | 12 | `[0 .. N-1]` | `12*N` | `[12*N .. 12*N + (N-1)]` |
| `dspss4` | 13 | 13 | `[0 .. N-1]` | `13*N` | `[13*N .. 13*N + (N-1)]` |
| `dspss5` | 14 | 14 | `[0 .. N-1]` | `14*N` | `[14*N .. 14*N + (N-1)]` |
| `camera_ss` | 15 | 15 | `[0 .. N-1]` | `15*N` | `[15*N .. 15*N + (N-1)]` |
| `mipi_ss` | 16 | 16 | `[0 .. N-1]` | `16*N` | `[16*N .. 16*N + (N-1)]` |
| `gpu_ss1` | 17 | 17 | `[0 .. N-1]` | `17*N` | `[17*N .. 17*N + (N-1)]` |
| `usb_dp_ss` | 18 | 18 | `[0 .. N-1]` | `18*N` | `[18*N .. 18*N + (N-1)]` |
| `display_ss` | 19 | 19 | `[0 .. N-1]` | `19*N` | `[19*N .. 19*N + (N-1)]` |
| `vpu_ss` | 20 | 20 | `[0 .. N-1]` | `20*N` | `[20*N .. 20*N + (N-1)]` |

## Subtree Windows Under The Current Source

These are the current aggregated routed windows derived from the leaf order and tree connectivity.

| Subtree or exit | Current routed window |
| --- | --- |
| `bottom_merge1` | `[1..3]` |
| `bottom_merge0` | `[6..8]` |
| `dsp_merge0` | `[9..14]` |
| `tr_merge0` | `[15..20]` |
| `tl_merge0` | `[5..20]` |
| `top_spine` | `[0..4]` |
| `cpu_ss_tniu0` | `[5..20]` |
| `cpu_ss_tniu1` | `[0..4]` |

## Practical Interpretation

For the current live demo:

- every leaf owns one routed ID slot
- the switch response path is correct because each leaf's routed window is disjoint
- the top-side wrapper converts the returned routed ID back into the leaf-local ID before the sys-side logic sees it

For a future `TBU_NUM = N` configuration:

- every leaf must own a routed window of width `N`
- the switch decode windows must be regenerated from those widened windows
- once that is done, the same response-return logic remains valid