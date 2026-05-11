# STS NoC Address Map Parameters - 2026-05-11

## Scope

This document records the adjusted SoC STS NoC address-to-target-id map and the parameters passed by `StsTemplate.py` into the generated STS INIU/TNIU wrappers.

The previous upstream `sts_tniu_sys.sv` decode blocker is resolved, and the later publish-filelist missing-module blocker is also resolved in the updated STS NoC repo at commit `54869c54dd236b092f7235ec867caf4a69619719`. Topology regeneration and the requested top-filelist-plus-`fcip.f` compile gate completed with the parameters below.

Source inputs:

- `build/temp/sts_latest_addr_to_tgtid_extraction.csv`
- `lwnoc_sts_noc_demo/sts_range_addr_map_migration_plan_20260511.md`
- `/home/lgzhu/dev/noc_fusa/lwnoc_sts_noc/doc/sts_noc_apb_addr_map_config.md`
- `lwnoc_sts_noc_demo/StsTemplate.py`

## Address And Target Encoding

- `AXI_ADDR_WIDTH = 32`
- `TGT_ID_WIDTH = 9`
- `STS_INIU_ADDR_MAP_ENTRY_NUM = 81`
- `STS_INIU_ADDR_MAP_DEFAULT_TGT_ID = 9'h1FF`
- Functional rows are shifted by `STS_SOC_FUNC_ADDR_OFFSET = 32'h0800_0000`.
- Debug rows keep the extracted debug address values.
- Audio has no standalone STS TNIU in this topology and maps to `periss`, TNIU ID `35`, `9'h023`.

Target ID classes:

| Target class | Formula |
| --- | --- |
| SYS APB | `9'h000 | tniu_id` |
| SYS REG | `9'h040 | tniu_id` |
| LOCAL REGBANK | `9'h080 | tniu_id` |
| LOCAL CTI | `9'h0C0 | tniu_id` |
| LOCAL INIU CTI | `9'h100 | tniu_id` |
| Reserved/default | `9'h1FF` |

## INIU Parameters

These are emitted for `aon_ss_iniu_sys_config` and `aon_ss_iniu_top_side_config`.

| Macro | Value |
| --- | --- |
| `STS_INIU_ADDR_MAP_ENTRY_NUM` | `81` |
| `STS_INIU_ADDR_MAP_START_TABLE` | packed 81 x 32-bit start addresses, row 00 first |
| `STS_INIU_ADDR_MAP_END_TABLE` | packed 81 x 32-bit end addresses, row 00 first |
| `STS_INIU_ADDR_MAP_TGT_ID_TABLE` | packed 81 x 9-bit target IDs, row 00 first |
| `STS_INIU_ADDR_MAP_DEFAULT_TGT_ID` | `9'h1FF` |

Exact packed literals generated from `StsTemplate.py`:

```systemverilog
STS_INIU_ADDR_MAP_ENTRY_NUM     = 81;
STS_INIU_ADDR_MAP_DEFAULT_TGT_ID = 9'h1FF;

STS_INIU_ADDR_MAP_START_TABLE =
2592'h08000000080100000802000008030000080400000805000008060000080700000808000008090000080A0000080B0000080C0000080D0000080E0000080F000008100000081100000812000008130000081400000815000008160000081700000818000008190000081A0000081B0000081C0000081D0000081E0000081F00000820000008210000082200000823000008240000082500000826000000000000004000000080000000C0000000C0100000C020000200000002800000030000000380000003E0000003E0100004000000044000000480000004C000000500000006000000066000000680000006E000000700000007004000070080000700C0000701000007014000070180000701C0000702000007024000070280000702C0000740000007401000078000000780400007808000078090000780A0000780B0000780C000;

STS_INIU_ADDR_MAP_END_TABLE =
2592'h0800FFFF0801FFFF0802FFFF0803FFFF0804FFFF0805FFFF0806FFFF0807FFFF0808FFFF0809FFFF080AFFFF080BFFFF080CFFFF080DFFFF080EFFFF080FFFFF0810FFFF0811FFFF0812FFFF0813FFFF0814FFFF0815FFFF0816FFFF0817FFFF0818FFFF0819FFFF081AFFFF081BFFFF081CFFFF081DFFFF081EFFFF081FFFFF0820FFFF0821FFFF0822FFFF0823FFFF0824FFFF0825FFFF0826FFFF003FFFFF007FFFFF00BFFFFF00C00FFF00C01FFF00C02FFF027FFFFF02FFFFFF037FFFFF03DFFFFF03E00FFF03E01FFF043FFFFF047FFFFF04BFFFFF04FFFFFF05000FFF065FFFFF06600FFF06DFFFFF06E00FFF07003FFF07004FFF0700BFFF0700CFFF07013FFF07014FFF0701BFFF0701CFFF07023FFF07024FFF0702BFFF0702CFFF07400FFF07401FFF07803FFF07807FFF07808FFF07809FFF0780AFFF0780BFFF0780CFFF;

STS_INIU_ADDR_MAP_TGT_ID_TABLE =
729'h0010100C08050301C10090502C180D0703C20110904C28150B05C30190D06C381D0F07C40211108C4823128984422110884422008040201008044A25128944A020100C061A0D06C361C0E0743A1E0F07C3E0A0508C46231188C4623;
```

## Adjusted Address Map Rows

| Row | Domain | Name | Start | End | Owner | TNIU ID | TGT ID |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 00 | func | CPU niu | `0x08000000` | `0x0800FFFF` | cpuss | 1 | `9'h001` |
| 01 | func | GPU0 niu | `0x08010000` | `0x0801FFFF` | gpuss0 | 2 | `9'h002` |
| 02 | func | GPU1 niu | `0x08020000` | `0x0802FFFF` | gpuss1 | 3 | `9'h003` |
| 03 | func | NPU0 niu | `0x08030000` | `0x0803FFFF` | npuss0 | 4 | `9'h004` |
| 04 | func | NPU1 niu | `0x08040000` | `0x0804FFFF` | npuss1 | 5 | `9'h005` |
| 05 | func | NPU2 niu | `0x08050000` | `0x0805FFFF` | npuss2 | 6 | `9'h006` |
| 06 | func | NPU3 niu | `0x08060000` | `0x0806FFFF` | npuss3 | 7 | `9'h007` |
| 07 | func | NPU4 niu | `0x08070000` | `0x0807FFFF` | npuss4 | 8 | `9'h008` |
| 08 | func | MIPI niu | `0x08080000` | `0x0808FFFF` | mipiss | 9 | `9'h009` |
| 09 | func | Camera niu | `0x08090000` | `0x0809FFFF` | camera_ss | 10 | `9'h00A` |
| 10 | func | DDR0 niu | `0x080A0000` | `0x080AFFFF` | ddrss0 | 11 | `9'h00B` |
| 11 | func | DDR1 niu | `0x080B0000` | `0x080BFFFF` | ddrss1 | 12 | `9'h00C` |
| 12 | func | DDR2 niu | `0x080C0000` | `0x080CFFFF` | ddrss2 | 13 | `9'h00D` |
| 13 | func | DDR3 niu | `0x080D0000` | `0x080DFFFF` | ddrss3 | 14 | `9'h00E` |
| 14 | func | DDR4 niu | `0x080E0000` | `0x080EFFFF` | ddrss4 | 15 | `9'h00F` |
| 15 | func | DDR5 niu | `0x080F0000` | `0x080FFFFF` | ddrss5 | 16 | `9'h010` |
| 16 | func | DDR6 niu | `0x08100000` | `0x0810FFFF` | ddrss6 | 17 | `9'h011` |
| 17 | func | DDR7 niu | `0x08110000` | `0x0811FFFF` | ddrss7 | 18 | `9'h012` |
| 18 | func | DDR8 niu | `0x08120000` | `0x0812FFFF` | ddrss8 | 19 | `9'h013` |
| 19 | func | DDR9 niu | `0x08130000` | `0x0813FFFF` | ddrss9 | 20 | `9'h014` |
| 20 | func | DDR10 niu | `0x08140000` | `0x0814FFFF` | ddrss10 | 21 | `9'h015` |
| 21 | func | DDR11 niu | `0x08150000` | `0x0815FFFF` | ddrss11 | 22 | `9'h016` |
| 22 | func | VPU niu | `0x08160000` | `0x0816FFFF` | vpuss | 23 | `9'h017` |
| 23 | func | Display niu | `0x08170000` | `0x0817FFFF` | display_ss | 24 | `9'h018` |
| 24 | func | PCIE_ETH niu | `0x08180000` | `0x0818FFFF` | pcie_ethss | 25 | `9'h019` |
| 25 | func | VDSP0 niu | `0x08190000` | `0x0819FFFF` | vdspss0 | 26 | `9'h01A` |
| 26 | func | VDSP1 niu | `0x081A0000` | `0x081AFFFF` | vdspss1 | 27 | `9'h01B` |
| 27 | func | VDSP2 niu | `0x081B0000` | `0x081BFFFF` | vdspss2 | 28 | `9'h01C` |
| 28 | func | VDSP3 niu | `0x081C0000` | `0x081CFFFF` | vdspss3 | 29 | `9'h01D` |
| 29 | func | VDSP4 niu | `0x081D0000` | `0x081DFFFF` | vdspss4 | 30 | `9'h01E` |
| 30 | func | VDSP5 niu | `0x081E0000` | `0x081EFFFF` | vdspss5 | 31 | `9'h01F` |
| 31 | func | USB_DP niu | `0x081F0000` | `0x081FFFFF` | usb_dpss | 32 | `9'h020` |
| 32 | func | UFS niu | `0x08200000` | `0x0820FFFF` | ufsss | 33 | `9'h021` |
| 33 | func | Safety niu | `0x08210000` | `0x0821FFFF` | safetyss_aon_local | 34 | `9'h022` |
| 34 | func | PERI niu | `0x08220000` | `0x0822FFFF` | periss | 35 | `9'h023` |
| 35 | func | Debug niu | `0x08230000` | `0x0823FFFF` | debug_ss | 36 | `9'h024` |
| 36 | func | Audio niu | `0x08240000` | `0x0824FFFF` | periss | 35 | `9'h023` |
| 37 | func | MCU niu | `0x08250000` | `0x0825FFFF` | mcuss | 37 | `9'h025` |
| 38 | func | Noc niu | `0x08260000` | `0x0826FFFF` | nocss | 38 | `9'h026` |
| 39 | debug | ROMTABLE | `0x00000000` | `0x003FFFFF` | safetyss_aon_local | 34 | `9'h022` |
| 40 | debug | SAFETY CL0 R52 ROM TABLE | `0x00400000` | `0x007FFFFF` | safetyss_aon_local | 34 | `9'h022` |
| 41 | debug | SAFETY CL1 R52 ROM TABLE | `0x00800000` | `0x00BFFFFF` | safetyss_aon_local | 34 | `9'h022` |
| 42 | debug | SAFETY CL0 Funnel8 | `0x00C00000` | `0x00C00FFF` | safetyss_aon_local | 34 | `9'h022` |
| 43 | debug | SAFETY CL1 Funnel8 | `0x00C01000` | `0x00C01FFF` | safetyss_aon_local | 34 | `9'h022` |
| 44 | debug | SAFETY Funnel2 | `0x00C02000` | `0x00C02FFF` | safetyss_aon_local | 34 | `9'h022` |
| 45 | debug | CPU CL0 ROM TABLE | `0x02000000` | `0x027FFFFF` | cpuss | 1 | `9'h001` |
| 46 | debug | CPU CL1 ROM TABLE | `0x02800000` | `0x02FFFFFF` | cpuss | 1 | `9'h001` |
| 47 | debug | CPU CL2 ROM TABLE | `0x03000000` | `0x037FFFFF` | cpuss | 1 | `9'h001` |
| 48 | debug | CPU CL3 ROM TABLE | `0x03800000` | `0x03DFFFFF` | cpuss | 1 | `9'h001` |
| 49 | debug | CPU Funnel2 | `0x03E00000` | `0x03E00FFF` | cpuss | 1 | `9'h001` |
| 50 | debug | CPU CTI | `0x03E01000` | `0x03E01FFF` | cpuss | 1 | `9'h001` |
| 51 | debug | MCU Core0 | `0x04000000` | `0x043FFFFF` | mcuss | 37 | `9'h025` |
| 52 | debug | MCU Core1 | `0x04400000` | `0x047FFFFF` | mcuss | 37 | `9'h025` |
| 53 | debug | MCU Core2 | `0x04800000` | `0x04BFFFFF` | mcuss | 37 | `9'h025` |
| 54 | debug | MCU Core3 | `0x04C00000` | `0x04FFFFFF` | mcuss | 37 | `9'h025` |
| 55 | debug | MCU Funnel | `0x05000000` | `0x05000FFF` | mcuss | 37 | `9'h025` |
| 56 | debug | GPU0 | `0x06000000` | `0x065FFFFF` | gpuss0 | 2 | `9'h002` |
| 57 | debug | GPU0 CTI | `0x06600000` | `0x06600FFF` | gpuss0 | 2 | `9'h002` |
| 58 | debug | GPU1 | `0x06800000` | `0x06DFFFFF` | gpuss1 | 3 | `9'h003` |
| 59 | debug | GPU1 CTI | `0x06E00000` | `0x06E00FFF` | gpuss1 | 3 | `9'h003` |
| 60 | debug | VDSP0 | `0x07000000` | `0x07003FFF` | vdspss0 | 26 | `9'h01A` |
| 61 | debug | VDSP0 CTI | `0x07004000` | `0x07004FFF` | vdspss0 | 26 | `9'h01A` |
| 62 | debug | VDSP1 | `0x07008000` | `0x0700BFFF` | vdspss1 | 27 | `9'h01B` |
| 63 | debug | VDSP1 CTI | `0x0700C000` | `0x0700CFFF` | vdspss1 | 27 | `9'h01B` |
| 64 | debug | VDSP2 | `0x07010000` | `0x07013FFF` | vdspss2 | 28 | `9'h01C` |
| 65 | debug | VDSP2 CTI | `0x07014000` | `0x07014FFF` | vdspss2 | 28 | `9'h01C` |
| 66 | debug | VDSP3 | `0x07018000` | `0x0701BFFF` | vdspss3 | 29 | `9'h01D` |
| 67 | debug | VDSP3 CTI | `0x0701C000` | `0x0701CFFF` | vdspss3 | 29 | `9'h01D` |
| 68 | debug | VDSP4 | `0x07020000` | `0x07023FFF` | vdspss4 | 30 | `9'h01E` |
| 69 | debug | VDSP4 CTI | `0x07024000` | `0x07024FFF` | vdspss4 | 30 | `9'h01E` |
| 70 | debug | VDSP5 | `0x07028000` | `0x0702BFFF` | vdspss5 | 31 | `9'h01F` |
| 71 | debug | VDSP5 CTI | `0x0702C000` | `0x0702CFFF` | vdspss5 | 31 | `9'h01F` |
| 72 | debug | Camera Funnel | `0x07400000` | `0x07400FFF` | camera_ss | 10 | `9'h00A` |
| 73 | debug | Camera CTI | `0x07401000` | `0x07401FFF` | camera_ss | 10 | `9'h00A` |
| 74 | debug | Audio Core0 | `0x07800000` | `0x07803FFF` | periss | 35 | `9'h023` |
| 75 | debug | Audio Core1 | `0x07804000` | `0x07807FFF` | periss | 35 | `9'h023` |
| 76 | debug | Peri dbg tsgen | `0x07808000` | `0x07808FFF` | periss | 35 | `9'h023` |
| 77 | debug | Peri dbg etf | `0x07809000` | `0x07809FFF` | periss | 35 | `9'h023` |
| 78 | debug | Peri dbg cti0 | `0x0780A000` | `0x0780AFFF` | periss | 35 | `9'h023` |
| 79 | debug | Peri dbg stm | `0x0780B000` | `0x0780BFFF` | periss | 35 | `9'h023` |
| 80 | debug | Peri dbg cti1 | `0x0780C000` | `0x0780CFFF` | periss | 35 | `9'h023` |

## TNIU Parameters

Each STS TNIU sys/noc config receives route parameters derived from its TNIU ID.

| Macro | Value rule |
| --- | --- |
| `STS_TNIU_SYS_APB_ROUTE_BASE` | `9'h000 | tniu_id` |
| `STS_TNIU_SYS_APB_ROUTE_MASK` | `9'h1C0` |
| `STS_TNIU_SYS_REG_ROUTE_BASE` | `9'h040 | tniu_id` |
| `STS_TNIU_SYS_REG_ROUTE_MASK` | `9'h1C0` |
| `STS_TNIU_LOCAL_REGBANK_TGT_ID` | `9'h080 | tniu_id` |
| `STS_TNIU_LOCAL_REGBANK_TGT_MASK` | `9'h1FF` |
| `STS_TNIU_LOCAL_CTI_TGT_ID` | `9'h0C0 | tniu_id` |
| `STS_TNIU_LOCAL_CTI_TGT_MASK` | `9'h1FF` |
| `STS_TNIU_LOCAL_INIU_CTI_TGT_ID` | `9'h100 | tniu_id` |
| `STS_TNIU_LOCAL_INIU_CTI_TGT_MASK` | `9'h1FF` |
| `STS_TNIU_HAS_INIU_CTI_APB` | `1` only for `safetyss_aon_local`, otherwise `0` |

Endpoint table:

| Owner | TNIU ID | SYS APB | SYS REG | Local regbank | Local CTI | Local INIU CTI | HAS INIU CTI APB |
| --- | --- | --- | --- | --- | --- | --- | --- |
| safetyss_aon_local | 34 | `9'h022` | `9'h062` | `9'h0A2` | `9'h0E2` | `9'h122` | 1 |
| cpuss | 1 | `9'h001` | `9'h041` | `9'h081` | `9'h0C1` | `9'h101` | 0 |
| gpuss0 | 2 | `9'h002` | `9'h042` | `9'h082` | `9'h0C2` | `9'h102` | 0 |
| gpuss1 | 3 | `9'h003` | `9'h043` | `9'h083` | `9'h0C3` | `9'h103` | 0 |
| npuss0 | 4 | `9'h004` | `9'h044` | `9'h084` | `9'h0C4` | `9'h104` | 0 |
| npuss1 | 5 | `9'h005` | `9'h045` | `9'h085` | `9'h0C5` | `9'h105` | 0 |
| npuss2 | 6 | `9'h006` | `9'h046` | `9'h086` | `9'h0C6` | `9'h106` | 0 |
| npuss3 | 7 | `9'h007` | `9'h047` | `9'h087` | `9'h0C7` | `9'h107` | 0 |
| npuss4 | 8 | `9'h008` | `9'h048` | `9'h088` | `9'h0C8` | `9'h108` | 0 |
| mipiss | 9 | `9'h009` | `9'h049` | `9'h089` | `9'h0C9` | `9'h109` | 0 |
| camera_ss | 10 | `9'h00A` | `9'h04A` | `9'h08A` | `9'h0CA` | `9'h10A` | 0 |
| ddrss0 | 11 | `9'h00B` | `9'h04B` | `9'h08B` | `9'h0CB` | `9'h10B` | 0 |
| ddrss1 | 12 | `9'h00C` | `9'h04C` | `9'h08C` | `9'h0CC` | `9'h10C` | 0 |
| ddrss2 | 13 | `9'h00D` | `9'h04D` | `9'h08D` | `9'h0CD` | `9'h10D` | 0 |
| ddrss3 | 14 | `9'h00E` | `9'h04E` | `9'h08E` | `9'h0CE` | `9'h10E` | 0 |
| ddrss4 | 15 | `9'h00F` | `9'h04F` | `9'h08F` | `9'h0CF` | `9'h10F` | 0 |
| ddrss5 | 16 | `9'h010` | `9'h050` | `9'h090` | `9'h0D0` | `9'h110` | 0 |
| ddrss6 | 17 | `9'h011` | `9'h051` | `9'h091` | `9'h0D1` | `9'h111` | 0 |
| ddrss7 | 18 | `9'h012` | `9'h052` | `9'h092` | `9'h0D2` | `9'h112` | 0 |
| ddrss8 | 19 | `9'h013` | `9'h053` | `9'h093` | `9'h0D3` | `9'h113` | 0 |
| ddrss9 | 20 | `9'h014` | `9'h054` | `9'h094` | `9'h0D4` | `9'h114` | 0 |
| ddrss10 | 21 | `9'h015` | `9'h055` | `9'h095` | `9'h0D5` | `9'h115` | 0 |
| ddrss11 | 22 | `9'h016` | `9'h056` | `9'h096` | `9'h0D6` | `9'h116` | 0 |
| vpuss | 23 | `9'h017` | `9'h057` | `9'h097` | `9'h0D7` | `9'h117` | 0 |
| display_ss | 24 | `9'h018` | `9'h058` | `9'h098` | `9'h0D8` | `9'h118` | 0 |
| pcie_ethss | 25 | `9'h019` | `9'h059` | `9'h099` | `9'h0D9` | `9'h119` | 0 |
| vdspss0 | 26 | `9'h01A` | `9'h05A` | `9'h09A` | `9'h0DA` | `9'h11A` | 0 |
| vdspss1 | 27 | `9'h01B` | `9'h05B` | `9'h09B` | `9'h0DB` | `9'h11B` | 0 |
| vdspss2 | 28 | `9'h01C` | `9'h05C` | `9'h09C` | `9'h0DC` | `9'h11C` | 0 |
| vdspss3 | 29 | `9'h01D` | `9'h05D` | `9'h09D` | `9'h0DD` | `9'h11D` | 0 |
| vdspss4 | 30 | `9'h01E` | `9'h05E` | `9'h09E` | `9'h0DE` | `9'h11E` | 0 |
| vdspss5 | 31 | `9'h01F` | `9'h05F` | `9'h09F` | `9'h0DF` | `9'h11F` | 0 |
| usb_dpss | 32 | `9'h020` | `9'h060` | `9'h0A0` | `9'h0E0` | `9'h120` | 0 |
| ufsss | 33 | `9'h021` | `9'h061` | `9'h0A1` | `9'h0E1` | `9'h121` | 0 |
| periss | 35 | `9'h023` | `9'h063` | `9'h0A3` | `9'h0E3` | `9'h123` | 0 |
| debug_ss | 36 | `9'h024` | `9'h064` | `9'h0A4` | `9'h0E4` | `9'h124` | 0 |
| mcuss | 37 | `9'h025` | `9'h065` | `9'h0A5` | `9'h0E5` | `9'h125` | 0 |
| nocss | 38 | `9'h026` | `9'h066` | `9'h0A6` | `9'h0E6` | `9'h126` | 0 |

## Validation Status

Completed:

- `StsTemplate.py` imports with the required environment variables.
- The source table has exactly 81 entries.
- The adjusted address ranges have no overlaps after the `0x0800_0000` functional offset.
- Owner/TNIU ID/TGT ID consistency is checked at import time.
- The upstream macro surface confirms the latest INIU uses `START_TABLE` and `END_TABLE` rather than the old `BASE_TABLE` and `MASK_TABLE`.
- External STS decode fix is present in generated TNIU sys RTL: `req_is_sys_reg` and `req_is_sys_apb` are assigned from high `tgt_id` endpoint-type bits.
- Topology regeneration completed and produced `build_logic/` plus `filelists/filelist_soc.f`.
- `filelists/sts_soc_publish_env.sh` is generated with `builtin cd` so shell `cd` hooks cannot pollute exported path variables.
- `fcip.f` plus `filelists/filelist_soc.f` expands to an 83-line flat filelist at `build/temp/sts_soc_compile.flat.f` with no unresolved include/path diagnostics and no nested `-f` directives.
- The updated flat filelist includes the previously missing generated copies of `sts_cti.sv` and `sts_tniu_apb_dec.sv`.
- VCS compile/elaboration/link passes with `+define+SYNTHESIS +define+FPGA_SIM`, producing `build/temp/sts_soc_vcs/simv`.
- VCS reports no `Error-` diagnostics. Remaining non-blocking diagnostics are one unsupported-kernel warning from VCS on WSL2 and twelve `Warning-[SIOB]` select-index warnings in generated `sts_cti.sv`.

Deferred: none for the requested parameter regeneration and compile gate.
