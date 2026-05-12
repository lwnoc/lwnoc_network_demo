# STS NoC Address Map Parameters - Updated 2026-05-12

## Scope

This document records the SoC STS NoC address-to-target-id map parameters emitted by `StsTemplate.py` into the generated STS INIU/TNIU wrappers.

Current source and RTL state:

- STS submodule used for regeneration: `subs/lwnoc_sts_noc` at `f86d72d2d58c032be0eb0347ca298d013a0a33d9`.
- INIU address-map macro surface: `START_TABLE`, `END_TABLE`, `TGT_ID_TABLE`, `DEFAULT_TGT_ID`.
- Entry count: 212.
- NIU CFG address space: `0x5700_0000..0x573F_FFFF`.
- Debug address space: `0x4800_0000..0x4FFF_FFFF`.
- Default/reserved target ID: `9'h1FF`.

## Address Window Rules

The updated NIU CFG address space is 4 MB wide, so the demo uses 64 KB per TNIU config slot:

- `FUNC_BASE(idx) = 32'h5700_0000 + idx * 32'h0001_0000`
- Functional SYS APB window: `FUNC_BASE..FUNC_BASE+32'h0000_FFFF`
- Functional SYS REG window: `FUNC_BASE+32'h0000_1000..FUNC_BASE+32'h0000_1FFF`
- Functional local regbank window: `FUNC_BASE..FUNC_BASE+32'h0000_0FFF`

The updated debug address space is `0x4800_0000..0x4FFF_FFFF`; the demo uses 2 MB per TNIU debug slot:

- `DEBUG_BASE(idx) = 32'h4800_0000 + idx * 32'h0020_0000`
- Debug SYS APB window: `DEBUG_BASE..DEBUG_BASE+32'h001F_FFFF`
- Debug local CTI window: `DEBUG_BASE..DEBUG_BASE+32'h0000_0FFF`
- Debug INIU CTI window: `DEBUG_BASE+32'h0000_1000..DEBUG_BASE+32'h0000_1FFF`, generated only for `safetyss_aon_local`.

`StsTemplate.py` validates at import time that every generated functional and debug window stays inside the configured address-space bounds.

## Target ID Classes

| Target class | Formula |
| --- | --- |
| SYS APB | `9'h000 | tniu_id` |
| SYS REG | `9'h040 | tniu_id` |
| LOCAL REGBANK | `9'h080 | tniu_id` |
| LOCAL CTI | `9'h0C0 | tniu_id` |
| LOCAL INIU CTI | `9'h100 | tniu_id` |
| Reserved/default | `9'h1FF` |

## INIU Parameters

These macros are emitted for both `aon_ss_iniu_sys_config` and `aon_ss_iniu_top_side_config`:

| Macro | Value |
| --- | --- |
| `STS_INIU_ADDR_MAP_ENTRY_NUM` | `212` |
| `STS_INIU_ADDR_MAP_START_TABLE` | packed 212 x 32-bit start addresses |
| `STS_INIU_ADDR_MAP_END_TABLE` | packed 212 x 32-bit end addresses |
| `STS_INIU_ADDR_MAP_TGT_ID_TABLE` | packed 212 x 9-bit target IDs |
| `STS_INIU_ADDR_MAP_DEFAULT_TGT_ID` | `9'h1FF` |

Generated macro evidence is in `build_logic/aon_ss_iniu_sys/aon_ss_iniu_sys_macros_b35083806a.sv` and `build_logic/aon_ss_iniu_top_side/aon_ss_iniu_top_side_macros_b35083806a.sv`.

## Debug Offset Overlay Table (Base + Offset)

The following debug components use additive offsets relative to `STS_SOC_DEBUG_BASE` (`0x4800_0000`) and map to the corresponding TNIU target IDs:

| Component | Resource key | Offset range | Absolute range | Target class | Target ID source |
| --- | --- | --- | --- | --- | --- |
| camera funnel | `camera_ss` | `0x0740_0000..0x0740_0FFF` | `0x4F400000..0x4F400FFF` | SYS APB | `sys_apb_route_base` |
| camera cti | `camera_ss` | `0x0740_1000..0x0740_1FFF` | `0x4F401000..0x4F401FFF` | LOCAL CTI | `local_cti_tgt_id` |
| mipi cti | `mipiss` | `0x0740_2000..0x0740_2FFF` | `0x4F402000..0x4F402FFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr0 cti | `ddrss0` | `0x0740_3000..0x0740_3FFF` | `0x4F403000..0x4F403FFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr1 cti | `ddrss1` | `0x0740_4000..0x0740_4FFF` | `0x4F404000..0x4F404FFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr2 cti | `ddrss2` | `0x0740_5000..0x0740_5FFF` | `0x4F405000..0x4F405FFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr3 cti | `ddrss3` | `0x0740_6000..0x0740_6FFF` | `0x4F406000..0x4F406FFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr4 cti | `ddrss4` | `0x0740_7000..0x0740_7FFF` | `0x4F407000..0x4F407FFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr5 cti | `ddrss5` | `0x0740_8000..0x0740_8FFF` | `0x4F408000..0x4F408FFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr6 cti | `ddrss6` | `0x0740_9000..0x0740_9FFF` | `0x4F409000..0x4F409FFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr7 cti | `ddrss7` | `0x0740_A000..0x0740_AFFF` | `0x4F40A000..0x4F40AFFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr8 cti | `ddrss8` | `0x0740_B000..0x0740_BFFF` | `0x4F40B000..0x4F40BFFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr9 cti | `ddrss9` | `0x0740_C000..0x0740_CFFF` | `0x4F40C000..0x4F40CFFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr10 cti | `ddrss10` | `0x0740_D000..0x0740_DFFF` | `0x4F40D000..0x4F40DFFF` | LOCAL CTI | `local_cti_tgt_id` |
| ddr11 cti | `ddrss11` | `0x0740_E000..0x0740_EFFF` | `0x4F40E000..0x4F40EFFF` | LOCAL CTI | `local_cti_tgt_id` |
| npu0 cti | `npuss0` | `0x0740_F000..0x0740_FFFF` | `0x4F40F000..0x4F40FFFF` | LOCAL CTI | `local_cti_tgt_id` |
| npu1 cti | `npuss1` | `0x0741_0000..0x0741_0FFF` | `0x4F410000..0x4F410FFF` | LOCAL CTI | `local_cti_tgt_id` |
| npu2 cti | `npuss2` | `0x0741_1000..0x0741_1FFF` | `0x4F411000..0x4F411FFF` | LOCAL CTI | `local_cti_tgt_id` |
| npu3 cti | `npuss3` | `0x0741_2000..0x0741_2FFF` | `0x4F412000..0x4F412FFF` | LOCAL CTI | `local_cti_tgt_id` |
| npu4 cti | `npuss4` | `0x0741_3000..0x0741_3FFF` | `0x4F413000..0x4F413FFF` | LOCAL CTI | `local_cti_tgt_id` |
| ufs cti | `ufsss` | `0x0741_4000..0x0741_4FFF` | `0x4F414000..0x4F414FFF` | LOCAL CTI | `local_cti_tgt_id` |

## TNIU Address And Target Table

| Key | TNIU ID | Func window | Debug window | SYS APB | SYS REG | LOCAL REGBANK | LOCAL CTI | LOCAL INIU CTI |
| --- | ---: | --- | --- | --- | --- | --- | --- | --- |
| safetyss_aon_local | 34 | `0x57000000..0x5700FFFF` | `0x48000000..0x481FFFFF` | `9'h022` | `9'h062` | `9'h0A2` | `9'h0E2` | `9'h122` |
| cpuss | 1 | `0x57010000..0x5701FFFF` | `0x48200000..0x483FFFFF` | `9'h001` | `9'h041` | `9'h081` | `9'h0C1` | `9'h101` |
| gpuss0 | 2 | `0x57020000..0x5702FFFF` | `0x48400000..0x485FFFFF` | `9'h002` | `9'h042` | `9'h082` | `9'h0C2` | `9'h102` |
| gpuss1 | 3 | `0x57030000..0x5703FFFF` | `0x48600000..0x487FFFFF` | `9'h003` | `9'h043` | `9'h083` | `9'h0C3` | `9'h103` |
| npuss0 | 4 | `0x57040000..0x5704FFFF` | `0x48800000..0x489FFFFF` | `9'h004` | `9'h044` | `9'h084` | `9'h0C4` | `9'h104` |
| npuss1 | 5 | `0x57050000..0x5705FFFF` | `0x48A00000..0x48BFFFFF` | `9'h005` | `9'h045` | `9'h085` | `9'h0C5` | `9'h105` |
| npuss2 | 6 | `0x57060000..0x5706FFFF` | `0x48C00000..0x48DFFFFF` | `9'h006` | `9'h046` | `9'h086` | `9'h0C6` | `9'h106` |
| npuss3 | 7 | `0x57070000..0x5707FFFF` | `0x48E00000..0x48FFFFFF` | `9'h007` | `9'h047` | `9'h087` | `9'h0C7` | `9'h107` |
| npuss4 | 8 | `0x57080000..0x5708FFFF` | `0x49000000..0x491FFFFF` | `9'h008` | `9'h048` | `9'h088` | `9'h0C8` | `9'h108` |
| mipiss | 9 | `0x57090000..0x5709FFFF` | `0x49200000..0x493FFFFF` | `9'h009` | `9'h049` | `9'h089` | `9'h0C9` | `9'h109` |
| camera_ss | 10 | `0x570A0000..0x570AFFFF` | `0x49400000..0x495FFFFF` | `9'h00A` | `9'h04A` | `9'h08A` | `9'h0CA` | `9'h10A` |
| ddrss0 | 11 | `0x570B0000..0x570BFFFF` | `0x49600000..0x497FFFFF` | `9'h00B` | `9'h04B` | `9'h08B` | `9'h0CB` | `9'h10B` |
| ddrss1 | 12 | `0x570C0000..0x570CFFFF` | `0x49800000..0x499FFFFF` | `9'h00C` | `9'h04C` | `9'h08C` | `9'h0CC` | `9'h10C` |
| ddrss2 | 13 | `0x570D0000..0x570DFFFF` | `0x49A00000..0x49BFFFFF` | `9'h00D` | `9'h04D` | `9'h08D` | `9'h0CD` | `9'h10D` |
| ddrss3 | 14 | `0x570E0000..0x570EFFFF` | `0x49C00000..0x49DFFFFF` | `9'h00E` | `9'h04E` | `9'h08E` | `9'h0CE` | `9'h10E` |
| ddrss4 | 15 | `0x570F0000..0x570FFFFF` | `0x49E00000..0x49FFFFFF` | `9'h00F` | `9'h04F` | `9'h08F` | `9'h0CF` | `9'h10F` |
| ddrss5 | 16 | `0x57100000..0x5710FFFF` | `0x4A000000..0x4A1FFFFF` | `9'h010` | `9'h050` | `9'h090` | `9'h0D0` | `9'h110` |
| ddrss6 | 17 | `0x57110000..0x5711FFFF` | `0x4A200000..0x4A3FFFFF` | `9'h011` | `9'h051` | `9'h091` | `9'h0D1` | `9'h111` |
| ddrss7 | 18 | `0x57120000..0x5712FFFF` | `0x4A400000..0x4A5FFFFF` | `9'h012` | `9'h052` | `9'h092` | `9'h0D2` | `9'h112` |
| ddrss8 | 19 | `0x57130000..0x5713FFFF` | `0x4A600000..0x4A7FFFFF` | `9'h013` | `9'h053` | `9'h093` | `9'h0D3` | `9'h113` |
| ddrss9 | 20 | `0x57140000..0x5714FFFF` | `0x4A800000..0x4A9FFFFF` | `9'h014` | `9'h054` | `9'h094` | `9'h0D4` | `9'h114` |
| ddrss10 | 21 | `0x57150000..0x5715FFFF` | `0x4AA00000..0x4ABFFFFF` | `9'h015` | `9'h055` | `9'h095` | `9'h0D5` | `9'h115` |
| ddrss11 | 22 | `0x57160000..0x5716FFFF` | `0x4AC00000..0x4ADFFFFF` | `9'h016` | `9'h056` | `9'h096` | `9'h0D6` | `9'h116` |
| vpuss | 23 | `0x57170000..0x5717FFFF` | `0x4AE00000..0x4AFFFFFF` | `9'h017` | `9'h057` | `9'h097` | `9'h0D7` | `9'h117` |
| display_ss | 24 | `0x57180000..0x5718FFFF` | `0x4B000000..0x4B1FFFFF` | `9'h018` | `9'h058` | `9'h098` | `9'h0D8` | `9'h118` |
| pcie_ethss | 25 | `0x57190000..0x5719FFFF` | `0x4B200000..0x4B3FFFFF` | `9'h019` | `9'h059` | `9'h099` | `9'h0D9` | `9'h119` |
| vdspss0 | 26 | `0x571A0000..0x571AFFFF` | `0x4B400000..0x4B5FFFFF` | `9'h01A` | `9'h05A` | `9'h09A` | `9'h0DA` | `9'h11A` |
| vdspss1 | 27 | `0x571B0000..0x571BFFFF` | `0x4B600000..0x4B7FFFFF` | `9'h01B` | `9'h05B` | `9'h09B` | `9'h0DB` | `9'h11B` |
| vdspss2 | 28 | `0x571C0000..0x571CFFFF` | `0x4B800000..0x4B9FFFFF` | `9'h01C` | `9'h05C` | `9'h09C` | `9'h0DC` | `9'h11C` |
| vdspss3 | 29 | `0x571D0000..0x571DFFFF` | `0x4BA00000..0x4BBFFFFF` | `9'h01D` | `9'h05D` | `9'h09D` | `9'h0DD` | `9'h11D` |
| vdspss4 | 30 | `0x571E0000..0x571EFFFF` | `0x4BC00000..0x4BDFFFFF` | `9'h01E` | `9'h05E` | `9'h09E` | `9'h0DE` | `9'h11E` |
| vdspss5 | 31 | `0x571F0000..0x571FFFFF` | `0x4BE00000..0x4BFFFFFF` | `9'h01F` | `9'h05F` | `9'h09F` | `9'h0DF` | `9'h11F` |
| usb_dpss | 32 | `0x57200000..0x5720FFFF` | `0x4C000000..0x4C1FFFFF` | `9'h020` | `9'h060` | `9'h0A0` | `9'h0E0` | `9'h120` |
| ufsss | 33 | `0x57210000..0x5721FFFF` | `0x4C200000..0x4C3FFFFF` | `9'h021` | `9'h061` | `9'h0A1` | `9'h0E1` | `9'h121` |
| periss | 35 | `0x57220000..0x5722FFFF` | `0x4C400000..0x4C5FFFFF` | `9'h023` | `9'h063` | `9'h0A3` | `9'h0E3` | `9'h123` |
| debug_ss | 36 | `0x57230000..0x5723FFFF` | `0x4C600000..0x4C7FFFFF` | `9'h024` | `9'h064` | `9'h0A4` | `9'h0E4` | `9'h124` |
| mcuss | 37 | `0x57240000..0x5724FFFF` | `0x4C800000..0x4C9FFFFF` | `9'h025` | `9'h065` | `9'h0A5` | `9'h0E5` | `9'h125` |
| nocss | 38 | `0x57250000..0x5725FFFF` | `0x4CA00000..0x4CBFFFFF` | `9'h026` | `9'h066` | `9'h0A6` | `9'h0E6` | `9'h126` |

## Validation Status

- `python3 -m py_compile` passes for the STS demo Python sources.
- `StsTemplate.py` imports successfully and validates 212 generated address-map entries.
- Regeneration completed and produced 521 RTL/filelist files under `build_logic/`.
- Generated INIU macro files contain `STS_INIU_ADDR_MAP_START_TABLE`, `STS_INIU_ADDR_MAP_END_TABLE`, `STS_INIU_ADDR_MAP_TGT_ID_TABLE`, and no old `BASE_TABLE` / `MASK_TABLE` macros.
- `make -C lwnoc_sts_noc_demo/sim run_aon_addr_map run_aon_axi_access` passes: 192 addr-map checks and 382 AXI transactions.
- `fcip.f` plus `filelists/filelist_soc.f` expands to an 83-line flat filelist at `build/temp/sts_soc_compile.flat.f` with no unresolved include/path diagnostics and no nested `-f` directives.
- Top-level VCS compile/elaboration/link passes with `+define+SYNTHESIS +define+FPGA_SIM`, producing `build/temp/sts_soc_vcs/simv`.
- VCS reports no `Error-` diagnostics. Remaining non-blocking diagnostics are one unsupported-kernel warning from VCS on WSL2 and twelve `Warning-[SIOB]` select-index warnings in generated `sts_cti.sv`.
