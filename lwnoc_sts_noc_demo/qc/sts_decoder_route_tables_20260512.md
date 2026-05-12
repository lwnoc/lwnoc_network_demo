# STS Decoder Route Tables

Date: 2026-05-12

## Scope

This note captures the current decoder slot expansion derived from `STS_SOC_DECODER_ROUTE_GROUPS` in `StsTemplate.py`, plus the verification status after publishing LUT macros into generated RTL.

## Literal Format

- Generator-side SV literal emission now keeps the declared width and drops padded leading zeros.
- Example: `1536'h000...0C400000000000006DB6C00003028` is now emitted as `1536'hC400000000000006DB6C00003028`.

## Integration Review Tables

### Decoder Summary

| Decoder | Slot count | Direct-leaf slots | Subtree slots | Integration review focus |
| --- | ---: | ---: | ---: | --- |
| `sts_dec_l0_root` | 10 | 8 | 2 | Confirm parent slot `s8/s9` each covers the full child subtree |
| `sts_dec_l1_upper_ctrl` | 7 | 6 | 1 | Confirm DDR fanout stays grouped on `s6` |
| `sts_dec_l2_left_ddr` | 6 | 6 | 0 | Pure singleton decoder |
| `sts_dec_l1_right_upper` | 7 | 6 | 1 | Confirm lower-right subtree stays grouped on `s6` |
| `sts_dec_l2_right_lower` | 7 | 6 | 1 | Confirm lower-mid subtree stays grouped on `s6` |
| `sts_dec_l3_lower_mid` | 6 | 6 | 0 | Pure singleton decoder |

### sts_dec_l0_root

| Slot | Leaf count | Leaves | `tniu_id` |
| --- | ---: | --- | --- |
| `s0` | 1 | `safetyss_aon_local` | `[34]` |
| `s1` | 1 | `npuss1` | `[5]` |
| `s2` | 1 | `display_ss` | `[24]` |
| `s3` | 1 | `vpuss` | `[23]` |
| `s4` | 1 | `usb_dpss` | `[32]` |
| `s5` | 1 | `mipiss` | `[9]` |
| `s6` | 1 | `gpuss1` | `[3]` |
| `s7` | 1 | `nocss` | `[38]` |
| `s8` | 12 | `camera_ss, mcuss, periss, npuss0, debug_ss, cpuss, ddrss0..5` | `[10, 37, 35, 4, 36, 1, 11, 12, 13, 14, 15, 16]` |
| `s9` | 18 | `vdspss0..5, ddrss6..11, npuss2..4, gpuss0, ufsss, pcie_ethss` | `[26, 27, 28, 17, 18, 19, 29, 30, 31, 20, 21, 22, 6, 7, 8, 2, 33, 25]` |

### sts_dec_l1_upper_ctrl

| Slot | Leaf count | Leaves | `tniu_id` |
| --- | ---: | --- | --- |
| `s0` | 1 | `camera_ss` | `[10]` |
| `s1` | 1 | `mcuss` | `[37]` |
| `s2` | 1 | `periss` | `[35]` |
| `s3` | 1 | `npuss0` | `[4]` |
| `s4` | 1 | `debug_ss` | `[36]` |
| `s5` | 1 | `cpuss` | `[1]` |
| `s6` | 6 | `ddrss0..5` | `[11, 12, 13, 14, 15, 16]` |

### sts_dec_l2_left_ddr

| Slot | Leaf count | Leaves | `tniu_id` |
| --- | ---: | --- | --- |
| `s0` | 1 | `ddrss0` | `[11]` |
| `s1` | 1 | `ddrss1` | `[12]` |
| `s2` | 1 | `ddrss2` | `[13]` |
| `s3` | 1 | `ddrss3` | `[14]` |
| `s4` | 1 | `ddrss4` | `[15]` |
| `s5` | 1 | `ddrss5` | `[16]` |

### sts_dec_l1_right_upper

| Slot | Leaf count | Leaves | `tniu_id` |
| --- | ---: | --- | --- |
| `s0` | 1 | `vdspss0` | `[26]` |
| `s1` | 1 | `vdspss1` | `[27]` |
| `s2` | 1 | `vdspss2` | `[28]` |
| `s3` | 1 | `ddrss6` | `[17]` |
| `s4` | 1 | `ddrss7` | `[18]` |
| `s5` | 1 | `ddrss8` | `[19]` |
| `s6` | 12 | `vdspss3..5, ddrss9..11, npuss2..4, gpuss0, ufsss, pcie_ethss` | `[29, 30, 31, 20, 21, 22, 6, 7, 8, 2, 33, 25]` |

### sts_dec_l2_right_lower

| Slot | Leaf count | Leaves | `tniu_id` |
| --- | ---: | --- | --- |
| `s0` | 1 | `vdspss3` | `[29]` |
| `s1` | 1 | `vdspss4` | `[30]` |
| `s2` | 1 | `vdspss5` | `[31]` |
| `s3` | 1 | `ddrss9` | `[20]` |
| `s4` | 1 | `ddrss10` | `[21]` |
| `s5` | 1 | `ddrss11` | `[22]` |
| `s6` | 6 | `npuss2, npuss3, npuss4, gpuss0, ufsss, pcie_ethss` | `[6, 7, 8, 2, 33, 25]` |

### sts_dec_l3_lower_mid

| Slot | Leaf count | Leaves | `tniu_id` |
| --- | ---: | --- | --- |
| `s0` | 1 | `npuss2` | `[6]` |
| `s1` | 1 | `npuss3` | `[7]` |
| `s2` | 1 | `npuss4` | `[8]` |
| `s3` | 1 | `gpuss0` | `[2]` |
| `s4` | 1 | `ufsss` | `[33]` |
| `s5` | 1 | `pcie_ethss` | `[25]` |

## Decoder Slot Expansion

### sts_dec_l0_root

- s0: leaves = safetyss_aon_local | tniu_id = [34]
- s1: leaves = npuss1 | tniu_id = [5]
- s2: leaves = display_ss | tniu_id = [24]
- s3: leaves = vpuss | tniu_id = [23]
- s4: leaves = usb_dpss | tniu_id = [32]
- s5: leaves = mipiss | tniu_id = [9]
- s6: leaves = gpuss1 | tniu_id = [3]
- s7: leaves = nocss | tniu_id = [38]
- s8: leaves = camera_ss, mcuss, periss, npuss0, debug_ss, cpuss, ddrss0, ddrss1, ddrss2, ddrss3, ddrss4, ddrss5 | tniu_id = [10, 37, 35, 4, 36, 1, 11, 12, 13, 14, 15, 16]
- s9: leaves = vdspss0, vdspss1, vdspss2, ddrss6, ddrss7, ddrss8, vdspss3, vdspss4, vdspss5, ddrss9, ddrss10, ddrss11, npuss2, npuss3, npuss4, gpuss0, ufsss, pcie_ethss | tniu_id = [26, 27, 28, 17, 18, 19, 29, 30, 31, 20, 21, 22, 6, 7, 8, 2, 33, 25]

### sts_dec_l1_upper_ctrl

- s0: leaves = camera_ss | tniu_id = [10]
- s1: leaves = mcuss | tniu_id = [37]
- s2: leaves = periss | tniu_id = [35]
- s3: leaves = npuss0 | tniu_id = [4]
- s4: leaves = debug_ss | tniu_id = [36]
- s5: leaves = cpuss | tniu_id = [1]
- s6: leaves = ddrss0, ddrss1, ddrss2, ddrss3, ddrss4, ddrss5 | tniu_id = [11, 12, 13, 14, 15, 16]

### sts_dec_l2_left_ddr

- s0: leaves = ddrss0 | tniu_id = [11]
- s1: leaves = ddrss1 | tniu_id = [12]
- s2: leaves = ddrss2 | tniu_id = [13]
- s3: leaves = ddrss3 | tniu_id = [14]
- s4: leaves = ddrss4 | tniu_id = [15]
- s5: leaves = ddrss5 | tniu_id = [16]

### sts_dec_l1_right_upper

- s0: leaves = vdspss0 | tniu_id = [26]
- s1: leaves = vdspss1 | tniu_id = [27]
- s2: leaves = vdspss2 | tniu_id = [28]
- s3: leaves = ddrss6 | tniu_id = [17]
- s4: leaves = ddrss7 | tniu_id = [18]
- s5: leaves = ddrss8 | tniu_id = [19]
- s6: leaves = vdspss3, vdspss4, vdspss5, ddrss9, ddrss10, ddrss11, npuss2, npuss3, npuss4, gpuss0, ufsss, pcie_ethss | tniu_id = [29, 30, 31, 20, 21, 22, 6, 7, 8, 2, 33, 25]

### sts_dec_l2_right_lower

- s0: leaves = vdspss3 | tniu_id = [29]
- s1: leaves = vdspss4 | tniu_id = [30]
- s2: leaves = vdspss5 | tniu_id = [31]
- s3: leaves = ddrss9 | tniu_id = [20]
- s4: leaves = ddrss10 | tniu_id = [21]
- s5: leaves = ddrss11 | tniu_id = [22]
- s6: leaves = npuss2, npuss3, npuss4, gpuss0, ufsss, pcie_ethss | tniu_id = [6, 7, 8, 2, 33, 25]

### sts_dec_l3_lower_mid

- s0: leaves = npuss2 | tniu_id = [6]
- s1: leaves = npuss3 | tniu_id = [7]
- s2: leaves = npuss4 | tniu_id = [8]
- s3: leaves = gpuss0 | tniu_id = [2]
- s4: leaves = ufsss | tniu_id = [33]
- s5: leaves = pcie_ethss | tniu_id = [25]

## Published Macro Evidence

- `build_logic/sts_dec_l1_upper_ctrl/sts_dec_l1_upper_ctrl_macros_5fda1f9853.sv`
  - `STS_NETWORK_DEC_ROUTE_DST_TABLE = 1536'hC400000000000006DB6C00003028`
  - `STS_NETWORK_DEC_ROUTE_VLD_TABLE = 512'h380001FC12`
- `build_logic/sts_dec_l0_root/sts_dec_l0_root_macros_e21e7b9154.sv`
  - emitted with compact width-qualified LUT literals after regen

## Narrow RTL Validation

Validation used a minimal VCS compile input set instead of the publish-root `filelist.f`, to avoid unrelated env-var/filelist noise:

- shared inputs:
  - `subs/lwnoc_sts_noc/rtl/network/sts_network_define.sv`
  - `subs/lwnoc_sts_noc/fcip/ip/basic/*.sv`
  - `subs/lwnoc_sts_noc/fcip/ip/arbiter/*.sv`
- l1 case:
  - `build_logic/sts_dec_l1_upper_ctrl/sts_dec_l1_upper_ctrl_macros_5fda1f9853.sv`
  - `build_logic/sts_dec_l1_upper_ctrl/lwnoc_sts_pack.sv`
  - `build_logic/sts_dec_l1_upper_ctrl/sts_ctm.sv`
  - `build_logic/sts_dec_l1_upper_ctrl/sts_noc_dec_node.sv`
  - `build_logic/sts_dec_l1_upper_ctrl/sts_noc_dec_node_1to7_wrap.sv`
- l0 case:
  - `build_logic/sts_dec_l0_root/sts_dec_l0_root_macros_e21e7b9154.sv`
  - `build_logic/sts_dec_l0_root/lwnoc_sts_pack.sv`
  - `build_logic/sts_dec_l0_root/sts_ctm.sv`
  - `build_logic/sts_dec_l0_root/sts_noc_dec_node.sv`
  - `build_logic/sts_dec_l0_root/sts_noc_dec_node_1to10_wrap.sv`

Results:

- `sts_noc_dec_node_1to7_wrap`: VCS parse/elab/link passed.
- `sts_noc_dec_node_1to10_wrap`: VCS parse/elab/link passed.
- No LUT-related width mismatch, part-select direction error, or parameter type error was reported in either compile.

## Minimal Simulation Testcase

Added standalone testcase and target:

- `sim/tb_sts_decoder_lut_min.sv`
- `make -C sim run_decoder_lut_min`

The testcase instantiates `sts_noc_dec_node` twice and drives the published wrap-specific LUT macros directly.

| DUT slice | Sample `tgt_id` | Expected slot | Purpose |
| --- | ---: | ---: | --- |
| `l0_root` | `34` | `s0` | direct singleton leaf |
| `l0_root` | `10` | `s8` | left subtree representative |
| `l0_root` | `25` | `s9` | right subtree representative |
| `l1_upper_ctrl` | `10` | `s0` | direct singleton leaf |
| `l1_upper_ctrl` | `16` | `s6` | grouped DDR subtree representative |
| `l0_root` | `9'h1FF` | miss | confirm no-route path |

Observed checks in the testcase:

- hierarchical `route_lut_hit`
- hierarchical `route_lut_dst_idx`
- external onehot `slv_req_vld`

## Conclusion

- Decoder subtree semantics are source-owned in `STS_SOC_DECODER_ROUTE_GROUPS`.
- Those subtree sets now publish into generated `ROUTE_VLD_TABLE` and `ROUTE_DST_TABLE` macros.
- Generated literals are now compact width-qualified hex values.
- Narrow VCS compilation confirms the emitted LUT macros are accepted by the decoder RTL for both 7-slot and 10-slot cases.