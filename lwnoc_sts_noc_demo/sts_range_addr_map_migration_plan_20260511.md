# STS range 地址映射迁移计划

## 1. 背景和目标

当前 STS 地址映射使用 `base/mask -> tgt_id` 表，`sts_iniu_addr_map` 的命中条件为：

```systemverilog
(in_addr & mask) == (base & mask)
```

最新 SoC 地址分配表是显式 `start_addr .. end_addr` 窗口，同一个窗口整体归属同一个 `tgt_id`。因此 STS INIU 地址映射需要迁移为：

```text
start_addr <= axi_addr <= end_addr  -> tgt_id
```

目标是：

1. 支持任意 range，不再要求窗口是 2 的幂或 mask 可表达。
2. 保留 STS 内部 local register/CTI 访问能力。
3. 明确扩展 endpoint type，避免 INIU sys regbank 与 INIU noc CTI 语义混用。
4. 调整 TNIU sys side：先按 `tgt_id` 在 vld/rdy request 层分流，再分别转换成 APB。
5. 让 generator、RTL、testbench、文档保持一致。

## 2. Endpoint 编码

保留 9-bit `tgt_id = {endpoint_type[2:0], id[5:0]}`。

| endpoint_type | 名称 | tgt_id 公式 | Consumer |
|---|---|---|---|
| `3'b000` | `SYS_APB(id)` | `9'h000 | id` | TNIU sys side 外部 APB `m_*` 端口 |
| `3'b001` | `TNIU_SYS_REG(id)` | `9'h040 | id` | TNIU sys side regbank |
| `3'b010` | `TNIU_NOC_REGBANK(id)` | `9'h080 | id` | TNIU noc side regbank |
| `3'b011` | `TNIU_NOC_CTI(id)` | `9'h0C0 | id` | TNIU noc side CTI |
| `3'b100` | `INIU_NOC_CTI(id)` | `9'h100 | id` | 选定 passthrough TNIU 到 AON INIU noc side CTI |
| `3'b101` | `INIU_SYS_REG(iniu_id)` | `9'h140 | iniu_id` | **暂不实现**（当前无 INIU sys regbank 硬件，无地址窗口映射到此 endpoint） |
| `3'b110..111` | reserved | 不分配 | 保留 |

说明：

- `SYS_APB(id)` 指向 `rtl/tniu/sts_tniu_sys.sv` 端口上的外部 APB master：`m_psel/m_paddr/m_pready/m_prdata/m_pslverr/...`。
- `INIU_NOC_CTI(id)` 并不表示所有 TNIU 都可以访问 INIU noc side CTI。SoC 集成时只选择一个 TNIU noc side 作为 passthrough。
- 当前推荐 passthrough TNIU 为 `SafetySS(Aon) / TNIU34`，因此 AON INIU noc side CTI 的 `tgt_id` 为 `9'h122`。
- **`INIU_SYS_REG(0)` 暂不实现**：当前 INIU 没有 sys-side regbank 硬件，SoC 地址表也没有 range 映射到此 endpoint。addr_map miss 走 `DEFAULT_TGT_ID=9'h1FF` → network `no-route → DECERR` 即可收敛。无需在 `sts_iniu_axi_iniu.sv` 中增加 local split。

## 3. 地址映射规则

`sts_iniu_addr_map` 只做 range 到 `tgt_id` 的转换。后级只消费 `tgt_id`，不再根据 AXI address 选择目标。

地址窗口按真实 consumer 分配 endpoint：

| 窗口类型 | target kind | tgt_id |
|---|---|---|
| 外部 func/debug component | `SYS_APB` | `9'h000 | tniu_id` |
| TNIU sys side regbank 4KB | `TNIU_SYS_REG` | `9'h040 | tniu_id` |
| TNIU noc side regbank 4KB | `TNIU_NOC_REGBANK` | `9'h080 | tniu_id` |
| TNIU noc side CTI 4KB | `TNIU_NOC_CTI` | `9'h0C0 | tniu_id` |
| AON INIU noc side CTI 4KB | `INIU_NOC_CTI` | `9'h100 | passthrough_tniu_id` |
| AON INIU sys side regbank 4KB | `INIU_SYS_REG` | `9'h140 | iniu_id` |

Audio 已确认没有独立 TNIU，属于 PERISS，因此：

```text
Audio func/debug ranges -> SYS_APB(35) = 9'h023
```

## 4. 地址表数据结构

建议把提取表扩展为以下列：

```text
domain,row_name,start_addr,end_addr,size,target_kind,owner_key,owner_id,tgt_id,consumer,notes
```

当前源数据文件：

```text
build/temp/sts_latest_addr_to_tgtid_extraction.csv
```

后续 generator 以该表或等价 Python data model 作为 canonical source，生成：

```text
STS_INIU_ADDR_MAP_ENTRY_NUM
STS_INIU_ADDR_MAP_START_TABLE
STS_INIU_ADDR_MAP_END_TABLE
STS_INIU_ADDR_MAP_TGT_ID_TABLE
STS_INIU_ADDR_MAP_DEFAULT_TGT_ID
```

range table 的 `start_addr` 和 `end_addr` 都是 inclusive。

## 5. RTL 修改计划

### 5.1 `sts_iniu_addr_map.sv`

目标文件：

```text
subs/lwnoc_sts_noc/rtl/common/sts_iniu_addr_map.sv
```

接口从旧的 base/mask 表：

```systemverilog
parameter logic [ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_BASE_TABLE = '0,
parameter logic [ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_MASK_TABLE = '0,
parameter logic [ENTRY_NUM*TGT_ID_WIDTH-1:0]   TGT_ID_TABLE    = '0
```

改为 range 表：

```systemverilog
parameter logic [ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_START_TABLE = '0,
parameter logic [ENTRY_NUM*AXI_ADDR_WIDTH-1:0] ADDR_END_TABLE   = '0,
parameter logic [ENTRY_NUM*TGT_ID_WIDTH-1:0]   TGT_ID_TABLE     = '0
```

比较逻辑改为：

```systemverilog
if (!table_hit &&
    (in_addr >= addr_start) &&
    (in_addr <= addr_end)) begin
    table_tgt_id = tgt_id;
    table_hit    = 1'b1;
end
```

仍然保持 entry0 first-match priority。

### 5.2 INIU 参数透传链

以下文件需要把 `ADDR_MAP_BASE_TABLE/ADDR_MAP_MASK_TABLE` 全链替换为 `ADDR_MAP_START_TABLE/ADDR_MAP_END_TABLE`：

```text
subs/lwnoc_sts_noc/rtl/iniu/sts_iniu_top.sv
subs/lwnoc_sts_noc/rtl/iniu/sts_iniu_sys.sv
subs/lwnoc_sts_noc/rtl/iniu/sts_iniu_axi_iniu.sv
subs/lwnoc_sts_noc/rtl/iniu/sts_iniu_wr_channel.sv
subs/lwnoc_sts_noc/rtl/iniu/sts_iniu_rd_channel.sv
```

读写 channel 中各有 main + shadow 两个 mapper 实例，四个实例都必须同步更新。

### 5.3 INIU sys local 分流 — **不需要改**

`INIU_SYS_REG(0)` 暂不实现：

- 当前 INIU 没有 sys-side regbank 硬件。
- SoC 地址表里没有任何 range 生成 `9'h140` 这个 tgt_id。
- 无 source → 无需 local split。

addr_map miss 统一走 `DEFAULT_TGT_ID=9'h1FF` → network `no-route → DECERR`，已由 `sts_noc_dec_node` 的 DECERR path 覆盖。`sts_iniu_axi_iniu.sv` 不需要任何修改。

### 5.4 TNIU sys request-level decode

目标文件：

```text
subs/lwnoc_sts_noc/rtl/tniu/sts_tniu_sys.sv
```

当前结构是：

```text
vld/rdy request -> sts_tniu_apb -> APB signals -> sts_tniu_apb_dec -> sys regbank / external m_* APB
```

计划改为：

```text
vld/rdy request
  -> decode by req.cmn.tgt_id
      -> TNIU_SYS_REG(id) -> sts_tniu_apb -> sys regbank
      -> SYS_APB(id)      -> sts_tniu_apb -> external m_* APB
      -> miss             -> local DECERR response
```

即 `sts_tniu_sys.sv` 内例化两个 `sts_tniu_apb`：

```text
u_tniu_sys_reg_apb
u_tniu_sys_ext_apb
```

`sts_tniu_apb_dec` 不再用于 sys side。这样 sys regbank 和 external IO APB 的 ready/response/error 各自独立。

实现约束：

- `!req_is_sys_reg && !req_is_sys_apb` 必须被第三路 miss responder 接收，并返回 DECERR，不能只让 `req_apb_tniu_rdy=0`。
- sys regbank、external APB、miss responder 三路 response 必须进入 ready-aware arbiter，不能用无 backpressure 的简单 mux。
- 未被 arbiter 选中的 response source 必须保持 valid，直到对应 ready 被拉高。
- `req_apb_tniu_rdy` 必须来自当前选中 request path 或 miss responder 的 ready，保证每个被接受 request 都有唯一 response。
- external `m_*` APB 如果系统集成不能保证 `pready` 最终返回，需要在 TNIU sys 侧或集成 wrapper 侧增加 APB timeout/default error slave。

### 5.5 TNIU noc passthrough 限制

目标文件：

```text
subs/lwnoc_sts_noc/rtl/tniu/sts_tniu_noc.sv
```

保留现有本地 endpoint 分流：

```text
TNIU_NOC_REGBANK(id)
TNIU_NOC_CTI(id)
INIU_NOC_CTI(passthrough_tniu_id)
```

要求：

- 只有 selected passthrough TNIU 设置 `HAS_INIU_CTI_APB=1`。
- 当前 selected passthrough TNIU 为 `SafetySS(Aon) / TNIU34`。
- 其他 TNIU 的 `HAS_INIU_CTI_APB=0`，即使错误收到 INIU CTI request，也由 default behavior 吸收或返回错误，不暴露真实 passthrough。
- `HAS_INIU_CTI_APB=0` 的 default behavior 建议返回 `pslverr=1`，避免错误 INIU CTI 访问被静默当成成功。

### 5.6 异常地址和错误 tgt_id 闭合规则

目标：reserved address、range miss、错误 endpoint type、错误 passthrough 配置都不能造成 NoC request/response 链路永久等待。

全局规则：

```text
每一级 decode/splitter 对每个输入 request 只能有两种结果：
    1. 接收 request，并保证在公平 downstream 条件下最终返回 response；或
    2. 本地接收 request，并立即或有限周期内返回 DECERR/SLVERR response。

禁止出现：
    - invalid request 被丢弃；
    - invalid request 永久 not-ready；
    - request 已接受但没有任何 response owner；
    - 两个 response 同时 valid 时被 mux 丢弃其中一路。
```

具体约束：

- `ADDR_MAP_DEFAULT_TGT_ID` 固定使用非法值 `9'h1FF`。
- generator 必须检查所有 network route 表中 `ROUTE_VLD_TABLE[9'h1FF] == 1'b0`。
- 如果某级 decoder 仍启用 base/mask fallback，必须检查 fallback 也不会命中 `9'h1FF`。
- `sts_iniu_addr_map` 的 `out_hit=0` 不直接阻塞 request；miss request 依赖 default tgt 进入 network DECERR，因此 default tgt 必须保持 no-route。
- `sts_noc_dec_node` 的 no-route DECERR 是 network 层闭合点，迁移后不能删除或 bypass。
- `INIU_SYS_REG(0)` local path 必须返回 response 并回到原 AXI ID/remap 流程；local path miss 也必须返回 DECERR。
- `sts_tniu_sys.sv` 的 request-level decode 必须包含 sys regbank、external APB、miss responder 三路，并用 response arbiter 汇合。
- `sts_tniu_noc.sv` local APB decode miss 必须返回 `pslverr=1` 或 DECERR 等价错误响应。
- selected passthrough TNIU 以外的 `INIU_NOC_CTI` 访问不得进入真实 INIU CTI APB，必须被 default/error path 吸收。
- 对“错误但合法”的 `SYS_APB(id)`，NoC 无法仅凭 `tgt_id` 判断语义错误；必须由 generator 静态校验 range owner 与 tgt owner，必要时由终端 APB firewall/default slave 返回错误。

错误路径预期行为：

| 场景 | 预期行为 | 不死锁依赖 |
|---|---|---|
| address 不命中任何 range | mapper 输出 `9'h1FF` | `9'h1FF` 不可 route |
| `9'h1FF` 到 network decoder | no-route DECERR | `sts_noc_dec_node` DECERR path 保留 |
| tgt_id 完全非法 | no-route DECERR | route LUT/base-mask 不误命中 |
| tgt_id route 到 TNIU sys 但 endpoint type 非 `SYS_APB/TNIU_SYS_REG` | TNIU sys local DECERR | request-level miss responder |
| tgt_id route 到 TNIU noc 但 local endpoint 不支持 | local `pslverr`/DECERR | APB decode miss/default slave |
| `INIU_NOC_CTI` route 到非 selected TNIU | default/error response | `HAS_INIU_CTI_APB=0` 返回错误 |
| `SYS_APB(id)` 指到错误但真实存在的 subsystem | NoC 不死锁，但可能访问错误目标 | generator owner 校验或 endpoint firewall |
| external APB 不返回 `pready` | 可能卡住该 TNIU sys path | APB timeout/default error slave |

## 6. Generator 修改计划

目标文件：

```text
lwnoc_sts_noc_demo/StsTemplate.py
```

### 6.1 endpoint helper

新增或整理 helper：

```python
def sys_apb(tniu_id):
    return 0x000 | tniu_id

def tniu_sys_reg(tniu_id):
    return 0x040 | tniu_id

def tniu_noc_regbank(tniu_id):
    return 0x080 | tniu_id

def tniu_noc_cti(tniu_id):
    return 0x0C0 | tniu_id

def iniu_noc_cti(passthrough_tniu_id):
    return 0x100 | passthrough_tniu_id

def iniu_sys_reg(iniu_id):
    return 0x140 | iniu_id
```

### 6.2 range entries

旧逻辑：

```python
STS_SOC_ADDR_MAP_ENTRIES = [(base, mask, tgt_id), ...]
```

新逻辑：

```python
STS_SOC_ADDR_MAP_ENTRIES = [(start_addr, end_addr, tgt_id, target_kind, owner_key), ...]
```

packed table 改为：

```python
STS_SOC_ADDR_MAP_START_TABLE_INT
STS_SOC_ADDR_MAP_END_TABLE_INT
STS_SOC_ADDR_MAP_TGT_ID_TABLE_INT
```

`_apply_iniu_macros()` 输出：

```python
"STS_INIU_ADDR_MAP_ENTRY_NUM"
"STS_INIU_ADDR_MAP_START_TABLE"
"STS_INIU_ADDR_MAP_END_TABLE"
"STS_INIU_ADDR_MAP_TGT_ID_TABLE"
"STS_INIU_ADDR_MAP_DEFAULT_TGT_ID"
```

### 6.3 passthrough TNIU 配置

增加集中配置：

```python
STS_SOC_INIU_NOC_CTI_PASSTHROUGH_TNIU_KEY = "safetyss_aon_local"
STS_SOC_INIU_NOC_CTI_PASSTHROUGH_TNIU_ID = 34
```

`HAS_INIU_CTI_APB` 不再散落手填，统一由 `entry["tniu_id"] == STS_SOC_INIU_NOC_CTI_PASSTHROUGH_TNIU_ID` 推导。

### 6.4 generator checks

生成前检查：

```text
start_addr <= end_addr
range overlap 检查并报告
INIU_NOC_CTI 只能使用 selected passthrough TNIU id
INIU_SYS_REG 只能使用已知 INIU id，当前为 0
SYS_APB/SYS_REG/NOC_REGBANK/TNIU_CTI 的 owner id 必须是已知 TNIU id
Audio rows 必须映射到 PERISS/TNIU35，不允许出现 Audio 独立 TNIU
```

## 7. Topology 修改计划

目标文件：

```text
lwnoc_sts_noc_demo/StsSocTopo.py
```

预计不需要大改 topology 图本身，因为没有新增 Audio TNIU，也没有新增 network slot。

可能需要的调整：

- 如果 selected passthrough TNIU 从 `SafetySS(Aon) / TNIU34` 改成其他 TNIU，则需要更新 generator 配置和对应 wrapper 暴露的 INIU CTI APB 连接。
- 当前计划保持 passthrough TNIU 为 `safetyss_aon_local`，因此 topology 层主要保持不变。

## 8. 文档更新计划

需要更新：

```text
/home/lgzhu/dev/noc_fusa/lwnoc_sts_noc/doc/sts_noc_apb_addr_map_config.md
lwnoc_sts_noc_demo/README.md
```

文档中必须说明：

1. `sts_iniu_addr_map` 改为 range compare，`end_addr` inclusive。
2. 新增 endpoint type `3'b101 INIU_SYS_REG`。
3. `SYS_APB(id)` 指向 `sts_tniu_sys.sv` 的外部 APB `m_*` 端口。
4. `INIU_NOC_CTI(id)` 的 `id` 是 selected passthrough TNIU id，不表示所有 TNIU 都能访问 INIU CTI。
5. 当前 selected passthrough TNIU 为 `SafetySS(Aon) / TNIU34`。
6. Audio 属于 PERISS，映射到 `SYS_APB(35) = 9'h023`。
7. reserved address / invalid tgt_id / unsupported endpoint 必须收敛为 DECERR/SLVERR，不允许造成永久 backpressure。

## 9. 验证计划

### 9.1 Address map unit test

更新：

```text
lwnoc_sts_noc_demo/sim/tb_sts_aon_addr_map.sv
```

测试内容：

- 每个 range 测 `start_addr`、`end_addr`、中间地址。
- 测 `end_addr + 1` 是否 miss 或命中下一段。
- 测 Audio -> PERISS / `9'h023`。
- 测 `INIU_SYS_REG(0) = 9'h140`。
- 测 `INIU_NOC_CTI(34) = 9'h122`。
- 测 miss -> default `9'h1FF`。

### 9.2 INIU local path test

验证：

- `INIU_SYS_REG(0)` 命中后不进入 network `out_req`。
- read/write response 能正确回到 AXI，ID 保持原始 AXI ID。
- 其他 endpoint 仍进入 network。

### 9.3 TNIU sys split test

验证：

- `TNIU_SYS_REG(id)` 走 sys regbank APB converter。
- `SYS_APB(id)` 走 external `m_*` APB converter。
- 两路 ready/response 不互相阻塞。
- 非法 endpoint 在 TNIU sys 返回 DECERR。

### 9.4 Passthrough restriction test

验证：

- 只有 selected passthrough TNIU 的 `HAS_INIU_CTI_APB=1`。
- `INIU_NOC_CTI(34)` 路由到 TNIU34。
- 非 selected TNIU 不暴露 INIU noc CTI passthrough。

### 9.5 Error-path no-deadlock test

验证：

- reserved address range miss 返回 DECERR，AXI read/write transaction 能 retire。
- `ADDR_MAP_DEFAULT_TGT_ID=9'h1FF` 不被任何 network route 命中。
- 手工注入非法 tgt_id，network decoder 返回 DECERR。
- 手工注入 route 到 TNIU sys 的非法 endpoint type，TNIU sys miss responder 返回 DECERR。
- TNIU sys regbank、external APB、miss responder 三路 response 同周期竞争时不丢 response。
- TNIU noc local APB decode miss 返回错误响应，不静默 OKAY。
- 非 selected TNIU 收到 `INIU_NOC_CTI` request 时返回错误或 default response，不访问真实 passthrough。
- external APB `pready` 被拉低的测试必须覆盖 timeout/default error slave 策略；如果系统假设 APB always respond，需在 testplan 中显式记录该假设。

## 10. 推荐实施顺序

1. 更新地址表数据结构和 endpoint 文档。
2. 修改 `sts_iniu_addr_map` 为 range compare。
3. 同步 INIU top/sys/channel 参数链。
4. 更新 generator 输出 start/end/tgt 表。
5. 增加 default tgt / route no-hit 静态校验，确保 `9'h1FF` 不可 route。
6. 修改 TNIU sys 为 vld/rdy request-level decode，两路 `sts_tniu_apb` 加一路 miss responder。
7. 给 TNIU sys 三路 response 增加 ready-aware arbiter。
8. 增加 INIU sys local `INIU_SYS_REG(0)` 消费路径和 local miss response。
9. 强化 TNIU noc selected passthrough 配置，default path 返回错误响应。
10. 更新 testbench，加入 error-path no-deadlock 用例。
11. 重新运行 `python3 gen_sts_soc_topo.py`。
12. 运行 compile/sanity，并检查旧 `ADDR_MAP_MASK_TABLE` 不再出现在新 INIU 参数链中。

## 11. Open items

| 项目 | 当前建议 | 需要确认 |
|---|---|---|
| AON INIU sys regbank 4KB 地址 | 暂不实现（无硬件） | — |
| AON INIU noc CTI 4KB 地址 | 使用 `INIU_NOC_CTI(34)=9'h122` | 需要确认最终 debug 地址窗口 |
| TNIU internal reg/CTI debug offsets | 每个 TNIU 显式 4KB range | 需要从最终地址表补齐具体地址 |
| APB paddr | 当前保持 absolute address 透传 | 如果 sys APB slave 需要 offset，需要另加 address translation |
| range overlap 策略 | generator 报错或显式 warning | 需要决定是否允许 first-match overlap |
| external APB no-response 策略 | 增加 timeout/default error slave，或记录 always-respond 集成假设 | 需要系统集成确认 |

## 12. 实际已完成 / 待改动文件清单

### RTL 改动（已完成 ✓）

| 文件 | 改动 |
|---|---|
| `lwnoc_sts_noc/rtl/common/sts_iniu_addr_map.sv` | base/mask → range compare（START/END table），first-match priority |
| `lwnoc_sts_noc/rtl/iniu/sts_iniu_sys.sv` | `ADDR_MAP_BASE/MASK` → `START/END`，端口不变 |
| `lwnoc_sts_noc/rtl/iniu/sts_iniu_top.sv` | 同上 |
| `lwnoc_sts_noc/rtl/iniu/sts_iniu_axi_iniu.sv` | 同上（无需 local split） |
| `lwnoc_sts_noc/rtl/iniu/sts_iniu_wr_channel.sv` | 同上（main + shadow mapper） |
| `lwnoc_sts_noc/rtl/iniu/sts_iniu_rd_channel.sv` | 同上（main + shadow mapper） |
| `lwnoc_sts_noc/rtl/iniu/sts_iniu_define.sv` | `STS_INIU_ADDR_MAP_BASE/MASK` → `START/END` |
| `lwnoc_sts_noc/rtl/iniu/sts_iniu_undefine.sv` | 同上 |
| `lwnoc_sts_noc/rtl/sts_noc_top_wrap.sv` | 同上 |
| `lwnoc_sts_noc/rtl/tniu/sts_tniu_sys.sv` | request-level tgt_id decode（双 `sts_tniu_apb`），删 `sts_tniu_apb_dec`，删 `SYS_*_ROUTE_*` 参数；`hw_dbg_sel` passthrough |
| `lwnoc_sts_noc/rtl/tniu/sts_tniu_define.sv` | `SYS_*_ROUTE_MASK` → `9'h1C0` |
| `lwnoc_sts_noc/rtl/tniu/sts_tniu_top.sv` | SYS_APB defaults 引用宏；`hw_dbg_sel` 端口+连线 |
| `lwnoc_sts_noc/rtl/tniu/sts_tniu_noc.sv` | 新增 `hw_dbg_sel[9:0]` 输出（占位 `'0`，待 regbank 重生成后接新寄存器） |
| `lwnoc_sts_noc/rtl/iniu/sts_iniu_noc.sv` | req_s_pld 驱动修复，rsp struct 重构 |
| `lwnoc_sts_noc/rtl/reg/build/reg_bank_table/` | 待：新增 `hw_dbg_sel` 寄存器（需改 .xlsx 并重生成） |
| `lwnoc_sts_noc/doc/sts_latest_topo_gen_param_basis.md` | SYS_*_ROUTE_* 移到公共参数；表格缩减 |
| `lwnoc_sts_noc/doc/sts_noc_apb_addr_map_config.md` | §7.3 MASK → 9'h1C0，§11 检查清单更新 |
| `lwnoc_sts_noc/vc/iniu_noc_pub.f` | 新增 |
| `lwnoc_sts_noc/vc/tniu_noc_pub.f` | 新增 |
| `lwnoc_interrupt_noc/vc/` | 新增 INIU/TNIU sys/noc pub filelist 四件 |

### 不需要改的 RTL

| 文件 | 原因 |
|---|---|
| `sts_iniu_axi_iniu.sv`（逻辑层） | `INIU_SYS_REG(0)` 无硬件，无需 local split；range 参数透传已通过 channel 连接完成 |

### 待完成

| 文件 | 改动 |
|---|---|
| `lwnoc_sts_noc_demo/StsTemplate.py` | §6: endpoint helper、START/END/TGT 三表、passthrough 集中配置 |
| `lwnoc_sts_noc_demo/StsSocTopo.py` | §7: 无大改 |
| `lwnoc_sts_noc_demo/README.md` | 更新 range compare、endpoint 编码 |
| `lwnoc_sts_noc/rtl/reg/build/reg_bank_table/*` | 改 .xlsx + 重生成 `hw_dbg_sel` 寄存器 |
