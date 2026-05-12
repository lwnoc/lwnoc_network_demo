# STS SoC Address Map Table (auto-generated)

| start_addr    | end_addr      | tgt_id  | resource_key |
|-------------- |--------------|---------|--------------|
0x4CA00000 | 0x4CBFFFFF | 0x026 | nocss
0x4CA00000 | 0x4CA00FFF | 0x0E6 | nocss
0x57250000 | 0x5725FFFF | 0x026 | nocss
0x57251000 | 0x57251FFF | 0x066 | 
0x57250000 | 0x57250FFF | 0x0A6 | 
0x4C800000 | 0x4C9FFFFF | 0x025 | mcuss
0x4C800000 | 0x4C800FFF | 0x0E5 | mcuss
0x57240000 | 0x5724FFFF | 0x025 | mcuss
0x57241000 | 0x57241FFF | 0x065 | 
0x57240000 | 0x57240FFF | 0x0A5 | 
0x4C600000 | 0x4C7FFFFF | 0x024 | debug_ss
0x4C600000 | 0x4C600FFF | 0x0E4 | debug_ss
0x57230000 | 0x5723FFFF | 0x024 | debug_ss
0x57231000 | 0x57231FFF | 0x064 | 
0x57230000 | 0x57230FFF | 0x0A4 | 
0x4C400000 | 0x4C5FFFFF | 0x023 | periss
0x4C400000 | 0x4C400FFF | 0x0E3 | periss
0x57220000 | 0x5722FFFF | 0x023 | periss
0x57221000 | 0x57221FFF | 0x063 | 
0x57220000 | 0x57220FFF | 0x0A3 | 
0x4C200000 | 0x4C3FFFFF | 0x021 | ufsss
0x4C200000 | 0x4C200FFF | 0x0E1 | ufsss
0x57210000 | 0x5721FFFF | 0x021 | ufsss
0x57211000 | 0x57211FFF | 0x061 | 
0x57210000 | 0x57210FFF | 0x0A1 | 
...（表格内容过长，仅展示部分，完整内容见 regen 文件）...

## Address Map Table 导出说明

- 本工程已自动导出全量 addr→tgtid 映射表：
  - [sts_soc_addr_map_table_20260513.md](sts_soc_addr_map_table_20260513.md)（markdown，便于 review）
  - [sts_soc_addr_map_table_20260513.csv](sts_soc_addr_map_table_20260513.csv)（csv，便于脚本/表格处理）

### 字段说明
| 字段         | 说明                       |
|--------------|----------------------------|
| start_addr   | 区间起始物理地址（十六进制）|
| end_addr     | 区间结束物理地址（十六进制）|
| tgt_id       | 匹配目标 tniu_id/target id  |
| resource_key | 资源名（如 mipiss、ddrss0） |

### 用法示例
- 可用 Excel/脚本直接分析 csv 文件，或用 markdown 版做集成 review。
- 若需批量查找某 SS 的所有映射区间，可筛选 resource_key 字段。
- 若需核查 offset 匹配，可直接定位对应 start_addr/end_addr。

---
如需导出其他格式、补充字段或自动化脚本，请随时告知。