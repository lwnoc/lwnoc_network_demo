# STS NoC 集成指南

> 本文档基于 `integration-guide` skill 从 RTL 源码提取。  
> STS（System Trace Switch）NoC 用于 AXI4 事务跨时钟域路由，支持地址映射、流控和调试。  
> 四个核心模块构成完整 INIU/TNIU 通道。

---

## 模块关系总览

```
clk_src 域 (AXI/源端)                               clk_dst 域 (NOC 目标端)
─────────────────────────────────────────────────────────────────────────────
AXI Master ──[AXI4-S]──► sts_iniu_sys ──[async FIFO req]──►
                                          sts_iniu_noc ──[req_vld/pld]──► NOC Switch
                          sts_iniu_sys ◄──[async FIFO rsp]──
                                          sts_iniu_noc ◄──[rsp_vld/pld]── NOC Switch
─────────────────────────────────────────────────────────────────────────────
NOC Switch ──[in_req]──► sts_tniu_top ──[async FIFO]──►
                                         [APB Master] ──► PMC / NIU APB 从端 (clk_dst)
─────────────────────────────────────────────────────────────────────────────
```

**INIU 侧**（发起方，AXI 事务 → NoC Switch）：
- `sts_iniu_top`   ← INIU 完整 wrapper（内部包含 sts_iniu_sys + sts_iniu_noc）
- `sts_iniu_sys`   ← clk_src 端，承载 AXI4 slave 接口 + 地址映射 + 异步 FIFO 写侧
- `sts_iniu_noc`   ← clk_dst 端，异步 FIFO 读侧 + NOC 请求/响应接口

**TNIU 侧**（目标方，NoC Switch → APB 输出）：
- `sts_tniu_top`   ← TNIU 完整 wrapper（内部包含 sts_tniu_sys）
- `sts_tniu_sys`   ← clk_dst 端，承载 APB master + 异步 FIFO 读侧
- （NOC 接口在 sts_tniu_top 直接挂载，通过内部异步 FIFO 连至 sts_tniu_sys）

---

## 包常量参考（◆ 固定，不可每实例覆盖）

来源：`lwnoc_sts_pack`，通过 `import lwnoc_sts_pack::*` 引入。

| 常量 | 值 | 影响的端口/功能 |
|------|----|----------------|
| `SRC_ID_WIDTH` ◆ | 8 | `node_id` 端口宽度；AXI id 字段宽度 |
| `TGT_ID_WIDTH` ◆ | 8 | ADDR_MAP_TGT_ID_TABLE 条目宽度；路由目标 ID |
| `TXN_ID_WIDTH` ◆ | 8 | AXI 事务 ID（awid/arid）宽度 |
| `AXI_DATA_WIDTH` ◆ | 32 | AXI 数据总线宽度（wdata/rdata） |
| `AXI_ADDR_WIDTH` ◆ | 32 | AXI 地址总线宽度 |
| `AXI_USER_WIDTH` ◆ | 8 | AXI user 字段宽度 |
| `AXI_STRB_WIDTH` ◆ | 4 | AXI strobe 宽度 |
| `STS_INIU_NUM` ◆ | 16 | 系统中最大 INIU 实例数 |
| `STS_TNIU_REQ_FIFO_DEPTH` ◆ | 16 | TNIU 请求 FIFO 缺省深度 |
| `CTI_EVENT_WIDTH` ◆ | 8 | CTI 事件/通道信号宽度 |

**async FIFO payload 类型**：
- `sts_req_typ`：NOC 请求结构，宽度 = `$bits(sts_req_typ)`（由包定义）
- `sts_rsp_typ`：NOC 响应结构，宽度 = `$bits(sts_rsp_typ)`（由包定义）
- `pld_sync` 宽度 = `$bits(sts_req_typ) + 2`（含 bubble flag）

---

## 模块一：`sts_iniu_top`（INIU 完整 Wrapper）

### 概述

INIU 完整集成包装模块（`sts_iniu_sys` + `sts_iniu_noc` 的顶层 wrapper）。
同时持有 clk_src（AXI 侧）和 clk_dst（NOC 侧），两时钟域通过内部异步 FIFO 隔离。
支持表格式和线性两种地址映射模式，支持多路流控 (`NODE_NUM`)。

### 参数参考

| 参数 | 默认值 ★/◆ | 说明 |
|------|-----------|------|
| `DBG_TIMESTAMP_WIDTH` ★ | 64 | 调试时间戳宽度（bit） |
| `DBG_DATA_WIDTH` ★ | 32 | 调试数据宽度（bit） |
| `FIFO_DEPTH` ★ | 4 | 内部异步 FIFO 深度（req 和 rsp 方向） |
| `NODE_NUM` ★ | 2 | 支持的流控节点数；`flow_ctrl_busy` 向量宽度 |
| `ADDR_MAP_ENTRY_NUM` ★ | 1 | 表格式地址映射条目数 |
| `ADDR_MAP_BASE_TABLE` ★ | '0 | 地址基值表（AXI_ADDR_WIDTH × ENTRY_NUM bit） |
| `ADDR_MAP_MASK_TABLE` ★ | '0 | 地址掩码表（AXI_ADDR_WIDTH × ENTRY_NUM bit） |
| `ADDR_MAP_TGT_ID_TABLE` ★ | '0 | 目标 ID 表（TGT_ID_WIDTH × ENTRY_NUM bit） |
| `ADDR_MAP_LINEAR_EN` ★ | 0 | 0 = 表格式映射；1 = 线性映射 |
| `ADDR_MAP_LINEAR_BASE` ★ | '0 | 线性映射起始地址 |
| `ADDR_MAP_LINEAR_NUM` ★ | 1 | 线性映射条目数（每条目步长 = 2^STRIDE_LOG2） |
| `ADDR_MAP_LINEAR_STRIDE_LOG2` ★ | 0 | 线性映射步长对数 |
| `ADDR_MAP_LINEAR_TGT_BASE` ★ | '0 | 线性映射目标 ID 起始 |
| `ADDR_MAP_DEFAULT_TGT_ID` ★ | '0 | 未命中时的默认目标 ID |

### IO 参考

#### 时钟/复位

| 信号 | 方向 | 说明 |
|------|------|------|
| `clk_src` | input | 源端时钟（AXI slave 侧） |
| `clk_dst` | input | 目标端时钟（NOC 侧） |
| `rstn_src` | input | 源端异步低有效复位 |
| `rstn_dst` | input | 目标端异步低有效复位 |

#### AXI4 Slave 接口（clk_src）

**写地址通道（AW）：**

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `sts_iniu_s_awvalid` | input | 1 | |
| `sts_iniu_s_awready` | output | 1 | |
| `sts_iniu_s_awid` | input | [7:0] | |
| `sts_iniu_s_awaddr` | input | [31:0] | |
| `sts_iniu_s_awlen` | input | [7:0] | |
| `sts_iniu_s_awsize` | input | [2:0] | |
| `sts_iniu_s_awburst` | input | [1:0] | |
| `sts_iniu_s_awlock` | input | 1 | |
| `sts_iniu_s_awcache` | input | [3:0] | |
| `sts_iniu_s_awprot` | input | [2:0] | |
| `sts_iniu_s_awqos` | input | [3:0] | |
| `sts_iniu_s_awuser` | input | [7:0] | |

**写数据通道（W）：**

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `sts_iniu_s_wvalid` | input | 1 | |
| `sts_iniu_s_wready` | output | 1 | |
| `sts_iniu_s_wdata` | input | [31:0] | |
| `sts_iniu_s_wstrb` | input | [3:0] | |
| `sts_iniu_s_wlast` | input | 1 | |

**写响应通道（B）：**

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `sts_iniu_s_bvalid` | output | 1 | |
| `sts_iniu_s_bready` | input | 1 | |
| `sts_iniu_s_bid` | output | [7:0] | |
| `sts_iniu_s_bresp` | output | [1:0] | |

**读地址通道（AR）：**

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `sts_iniu_s_arvalid` | input | 1 | |
| `sts_iniu_s_arready` | output | 1 | |
| `sts_iniu_s_arid` | input | [7:0] | |
| `sts_iniu_s_araddr` | input | [31:0] | |
| `sts_iniu_s_arlen` | input | [7:0] | |
| `sts_iniu_s_arsize` | input | [2:0] | |
| `sts_iniu_s_arburst` | input | [1:0] | |
| `sts_iniu_s_arlock` | input | 1 | |
| `sts_iniu_s_arcache` | input | [3:0] | |
| `sts_iniu_s_arprot` | input | [2:0] | |
| `sts_iniu_s_arqos` | input | [3:0] | |
| `sts_iniu_s_aruser` | input | [7:0] | |

**读数据通道（R）：**

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `sts_iniu_s_rvalid` | output | 1 | |
| `sts_iniu_s_rready` | input | 1 | |
| `sts_iniu_s_rid` | output | [7:0] | |
| `sts_iniu_s_rdata` | output | [31:0] | |
| `sts_iniu_s_rresp` | output | [1:0] | |
| `sts_iniu_s_rlast` | output | 1 | |

#### NOC 请求/响应接口（clk_dst）

| 信号 | 方向 | 类型 | 说明 |
|------|------|------|------|
| `out_req_vld` | output | 1 | NOC 请求有效 |
| `out_req_rdy` | input | 1 | NOC 请求就绪 |
| `out_req_pld` | output | sts_req_typ | NOC 请求 payload |
| `in_rsp_vld` | input | 1 | NOC 响应有效 |
| `in_rsp_rdy` | output | 1 | NOC 响应就绪 |
| `in_rsp_pld` | input | sts_rsp_typ | NOC 响应 payload |

#### 控制接口（clk_src）

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `node_id` | input | [7:0] | 本 INIU 的源节点 ID |
| `flow_ctrl_busy` | input | [NODE_NUM-1:0] | 每节点流控状态，1 = 忙 |
| `flow_ctrl_update` | output | 1 | 流控状态更新通知 |

#### CTI 接口（clk_src / clk_dst 双侧）

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `sys_cti_event_in/out` | in/out | [7:0] | 系统侧 CTI 事件（clk_src） |
| `noc_cti_event_in/out` | in/out | [7:0] | NOC 侧 CTI 事件（clk_dst） |
| `sys_cti_channel_in/out` | in/out | [7:0] | 系统侧 CTI 通道（clk_src） |
| `noc_cti_channel_in/out` | in/out | [7:0] | NOC 侧 CTI 通道（clk_dst） |

#### 调试接口

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `dbg_timestamp_in` | input | [63:0] | 调试时间戳输入 |
| `dbg_timestamp_out` | output | [63:0] | 调试时间戳输出（clk_dst 域） |
| `dbg_data_in` | input | [31:0] | 调试数据输入 |
| `dbg_data_out` | output | [31:0] | 调试数据输出 |

---

## 模块二：`sts_iniu_sys`（INIU 系统侧子模块）

与 `sts_iniu_top` AXI 接口完全相同，但端口前缀改为 `s_` 而非 `sts_iniu_s_`。  
额外增加了异步 FIFO 接口（连接至 `sts_iniu_noc`）和 CTI 握手信号。

### 异步 FIFO 接口（写侧，clk_src 域）

**REQ 方向（clk_src 写 → clk_dst 读）：**

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `req_wptr_async` | output | [FIFO_DEPTH-1:0] | 写指针（灰码），驱动 `sts_iniu_noc.req_wptr_async` |
| `req_rptr_async` | input | [FIFO_DEPTH-1:0] | 读指针（灰码），来自 `sts_iniu_noc.req_rptr_async` |
| `req_rptr_sync` | input | [FIFO_DEPTH-1:0] | 同步读指针，来自 `sts_iniu_noc.req_rptr_sync` |
| `req_pld_sync` | output | [REQ_PLD_AFIFO_WIDTH+1:0] | 请求 payload（含 bubble flag） |

**RSP 方向（clk_dst 写 → clk_src 读）：**

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `rsp_wptr_async` | input | [FIFO_DEPTH-1:0] | 写指针（来自 `sts_iniu_noc`） |
| `rsp_rptr_async` | output | [FIFO_DEPTH-1:0] | 读指针，驱动 `sts_iniu_noc.rsp_rptr_async` |
| `rsp_rptr_sync` | output | [FIFO_DEPTH-1:0] | 同步读指针，驱动 `sts_iniu_noc.rsp_rptr_sync` |
| `rsp_pld_sync` | input | [RSP_PLD_AFIFO_WIDTH+1:0] | 响应 payload |

### CTI 握手接口（clk_src 域）

| 信号组 | 宽度 | 说明 |
|--------|------|------|
| `cti_event_in/out/in_req/out_req/in_ack/out_ack` | [7:0] each | CTI 事件六线握手 |
| `cti_channel_in/out/in_req/out_req/in_ack/out_ack` | [7:0] each | CTI 通道六线握手 |

---

## 模块三：`sts_iniu_noc`（INIU NOC 侧子模块）

运行于 clk_dst，异步 FIFO 读侧 + NOC 请求/响应驱动。

### 参数参考

同 `sts_iniu_sys`（FIFO_DEPTH, SYNC_STAGE, DBG_* 相同）。

> **注意**：`FIFO_DEPTH` 必须与 `sts_iniu_sys` 保持一致。

### 时钟/复位

| 信号 | 域 | 说明 |
|------|---|------|
| `clk_dst` | NOC 侧 | 目标时钟 |
| `rst_n_dst` | NOC 侧 | 异步低有效复位（目标） |
| `clk_src` | 用于 CDC 同步 | 源时钟（只传至同步器） |
| `rst_n_src` | 用于 CDC 同步 | 源复位 |

### NOC 接口（clk_dst）

| 信号 | 方向 | 说明 |
|------|------|------|
| `req_s_vld` | output | NOC 请求有效 |
| `req_s_rdy` | input | NOC 请求就绪 |
| `req_s_pld` | output (sts_req_typ) | NOC 请求 payload |
| `rsp_m_vld` | input | NOC 响应有效 |
| `rsp_m_rdy` | output | NOC 响应就绪 |
| `rsp_m_pld` | input (sts_rsp_typ) | NOC 响应 payload |

### 异步 FIFO 接口（读侧，接收来自 sts_iniu_sys 的写侧信号）

**REQ 方向（clk_src 写 → clk_dst 读）：**

| 信号 | 方向 | 说明 |
|------|------|------|
| `req_wptr_async` | input | 来自 `sts_iniu_sys.req_wptr_async` |
| `req_rptr_async` | output | 驱动 `sts_iniu_sys.req_rptr_async` |
| `req_rptr_sync` | output | 驱动 `sts_iniu_sys.req_rptr_sync` |
| `req_pld_sync` | input | 来自 `sts_iniu_sys.req_pld_sync` |

**RSP 方向（clk_dst 写 → clk_src 读）：**

| 信号 | 方向 | 说明 |
|------|------|------|
| `rsp_wptr_async` | output | 驱动 `sts_iniu_sys.rsp_wptr_async` |
| `rsp_rptr_async` | input | 来自 `sts_iniu_sys.rsp_rptr_async` |
| `rsp_rptr_sync` | input | 来自 `sts_iniu_sys.rsp_rptr_sync` |
| `rsp_pld_sync` | output | 驱动 `sts_iniu_sys.rsp_pld_sync` |

---

## 模块四：`sts_tniu_top`（TNIU 完整 Wrapper）

### 概述

TNIU 集成包装，包含 `sts_tniu_sys`。持有三个时钟域：
- `clk_src`：NOC 接口侧（来自 NOC Switch）
- `clk_dst`：APB 目标侧（连接 PMC 等 APB 从端）
- `clk_dbg_timer`：调试时间戳同步专用时钟（可接同一 clk_dst 或独立时钟）

### 参数参考

| 参数 | 默认值 ★ | 说明 |
|------|---------|------|
| `DBG_TIMESTAMP_WIDTH` ★ | 64 | 调试时间戳宽度 |
| `DBG_DATA_WIDTH` ★ | 32 | 调试数据宽度 |
| `APB_ADDR_WIDTH` ★ | 32 | APB 地址宽度 |
| `SYNC_STAGE` ★ | 2 | CDC 同步级数 |
| `ASYNC_FIFO_DEPTH` ★ | 4 | 内部异步 FIFO 深度 |
| `TGT_TYPE_WIDTH` ★ | 2 | 目标类型字段宽度 |
| `LOCAL_APB_TGT_TYPE` ★ | 2'b01 | 本地 APB 类型标识 |
| `LOCAL_RSC_TGT_ID` ★ | '0 | 本地资源目标 ID |
| `LOCAL_REGBANK_TGT_ID` ★ | 'd1 | 寄存器组目标 ID |
| `SYS_APB_MASTER_NUM` ★ | 2 | APB master 数量（决定 m_psel/m_pready/m_prdata/m_pslverr 宽度） |
| `SYS_APB_ROUTE_BASE` ★ | '0 | APB 路由基地址表 |
| `SYS_APB_ROUTE_MASK` ★ | '0 | APB 路由掩码表 |

### IO 参考

#### 时钟/复位

| 信号 | 方向 | 说明 |
|------|------|------|
| `clk_src` | input | NOC 接口侧时钟 |
| `clk_dst` | input | APB 目标侧时钟 |
| `clk_dbg_timer` | input | 调试时间戳同步时钟（可接 clk_dst） |
| `rstn_src` | input | NOC 侧异步低有效复位 |
| `rstn_dst` | input | APB 侧异步低有效复位 |
| `rstn_dbg_timer` | input | 调试时间戳侧复位 |

#### NOC 接口（clk_src，接收来自 NOC Switch 的事务）

| 信号 | 方向 | 说明 |
|------|------|------|
| `in_req_vld` | input | NOC 请求有效 |
| `in_req_rdy` | output | NOC 请求就绪 |
| `in_req_pld` | input (sts_req_typ) | NOC 请求 payload |
| `out_rsp_vld` | output | NOC 响应有效 |
| `out_rsp_rdy` | input | NOC 响应就绪 |
| `out_rsp_pld` | output (sts_rsp_typ) | NOC 响应 payload |

#### APB Master 接口（clk_dst）

**PMC 专用 APB 口：**

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `pmc_psel` | output | 1 | |
| `pmc_penable` | output | 1 | |
| `pmc_paddr` | output | [31:0] | |
| `pmc_pwrite` | output | 1 | |
| `pmc_pwdata` | output | [31:0] | |
| `pmc_prdata` | input | [31:0] | |
| `pmc_pready` | input | 1 | |
| `pmc_pstrb` | output | [3:0] | |
| `pmc_pprot` | output | [2:0] | |
| `pmc_pslverr` | input | 1 | |

**多路 NOC NIU APB master 接口（SYS_APB_MASTER_NUM 组）：**

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `m_psel` | output | [SYS_APB_MASTER_NUM-1:0] | 每路 APB select |
| `m_paddr` | output | [31:0] | 共享地址 |
| `m_pready` | input | [SYS_APB_MASTER_NUM-1:0] | 每路就绪 |
| `m_prdata` | input | [SYS_APB_MASTER_NUM*32-1:0] | 每路读数据 |
| `m_pslverr` | input | [SYS_APB_MASTER_NUM-1:0] | 每路错误 |
| `m_pprot` | output | [2:0] | 共享保护 |
| `m_penable` | output | 1 | 共享使能 |
| `m_pwrite` | output | 1 | 共享写使能 |
| `m_pwdata` | output | [31:0] | 共享写数据 |
| `m_pstrb` | output | [3:0] | 共享写 strobe |

#### CTI 接口（clk_src/clk_dst 双侧）

与 `sts_iniu_top` 的 CTI 条目定义相同（事件 + 通道，各 8 bit）。

#### 调试接口

| 信号 | 方向 | 宽度 | 说明 |
|------|------|------|------|
| `dbg_timestamp_in` | input | [63:0] | 时间戳输入 |
| `dbg_timestamp_out` | output | [63:0] | 时间戳输出 |
| `dbg_data_in/out` | in/out | [31:0] | 调试数据 |
| `timing_bus1/2/3` | output | [31:0] | 时序调试总线 |
| `dbg_en` | output | [31:0] | 调试使能标志 |

---

## 模块五：`sts_tniu_sys`（TNIU 系统侧子模块）

### 概述

TNIU 内部子模块，运行于 (`clk_src` + `clk_dst` + `clk_dbg_timer`) 三域。  
承载异步 FIFO 读侧（接收 NOC 端写入的请求）和 APB master 输出逻辑。

### 参数参考

与 `sts_tniu_top` 共享：`ASYNC_FIFO_DEPTH`、`SYS_APB_MASTER_NUM` 等。

### 异步 FIFO 接口（读侧，clk_src 写 → clk_dst 读）

**REQ 方向：**

| 信号 | 方向 | 说明 |
|------|------|------|
| `req_wptr_async` | input | 来自 NOC/TNIU-noc 侧 |
| `req_rptr_async` | output | 驱动 NOC side |
| `req_rptr_sync` | output | 同步后读指针 |
| `req_pld_sync` | input | 请求 payload |

**RSP 方向：**

| 信号 | 方向 | 说明 |
|------|------|------|
| `rsp_wptr_async` | output | 响应写指针 |
| `rsp_rptr_async` | input | 来自 NOC side |
| `rsp_rptr_sync` | input | 同步后读指针 |
| `rsp_pld_sync` | output | 响应 payload |

---

## 集成规则与注意事项

### 规则 1：FIFO_DEPTH 一致性

```
sts_iniu_sys.FIFO_DEPTH == sts_iniu_noc.FIFO_DEPTH  （INIU 对内）
sts_tniu_sys.ASYNC_FIFO_DEPTH == (内部连线深度)     （TNIU wrapper 内部由 top 控制）
```

### 规则 2：地址映射参数配置

**表格式映射**（`ADDR_MAP_LINEAR_EN = 0`，推荐）：
```
ADDR_MAP_ENTRY_NUM     = N（映射条目数）
ADDR_MAP_BASE_TABLE    = {base_N-1, ..., base_0}   // 每个 32-bit 拼接
ADDR_MAP_MASK_TABLE    = {mask_N-1, ..., mask_0}   // 每个 32-bit 拼接
ADDR_MAP_TGT_ID_TABLE  = {tgt_N-1, ..., tgt_0}    // 每个 TGT_ID_WIDTH bit 拼接
```

命中条件：`(addr & mask[i]) == base[i]`，返回 `tgt_id[i]`。  
未命中时使用 `ADDR_MAP_DEFAULT_TGT_ID`。

**线性映射**（`ADDR_MAP_LINEAR_EN = 1`）：
```
ADDR_MAP_LINEAR_BASE       = 起始地址
ADDR_MAP_LINEAR_NUM        = 区间数量
ADDR_MAP_LINEAR_STRIDE_LOG2 = log2(步长)
ADDR_MAP_LINEAR_TGT_BASE   = 目标 ID 起始值
// 第 i 个 target：addr_range = [BASE + i*stride, BASE + (i+1)*stride - 1]
//                 target_id  = TGT_BASE + i
```

### 规则 3：node_id 配置

每个 `sts_iniu_top` 实例的 `node_id[7:0]` 必须全局唯一，范围 0 ~ `STS_INIU_NUM-1`（= 15）。

### 规则 4：`clk_dbg_timer` 处理

若无独立的调试时间戳时钟，可将 `clk_dbg_timer` 和 `rstn_dbg_timer` 绑定至 `clk_dst`/`rstn_dst`：
```systemverilog
.clk_dbg_timer  (clk_dst),
.rstn_dbg_timer (rstn_dst),
```

### 规则 5：`sts_iniu_sys` / `sts_iniu_noc` 直连时异步 FIFO 线命名

```systemverilog
// REQ 方向（sys 写 noc 读）
wire [FIFO_DEPTH-1:0] req_wptr, req_rptr, req_rptr_s;
wire [REQ_W  :0]      req_pld;
// RSP 方向（noc 写 sys 读）
wire [FIFO_DEPTH-1:0] rsp_wptr, rsp_rptr, rsp_rptr_s;
wire [RSP_W  :0]      rsp_pld;
```

---

## 典型实例化框架

```systemverilog
// 使用 sts_iniu_top（推荐：直接使用 wrapper，不需要手动连接异步 FIFO）
sts_iniu_top #(
    .FIFO_DEPTH            (4),
    .NODE_NUM              (2),
    .ADDR_MAP_ENTRY_NUM    (2),
    .ADDR_MAP_BASE_TABLE   ({32'h4000_0000, 32'h2000_0000}),
    .ADDR_MAP_MASK_TABLE   ({32'hF000_0000, 32'hF000_0000}),
    .ADDR_MAP_TGT_ID_TABLE ({8'd1,          8'd0}),
    .ADDR_MAP_DEFAULT_TGT_ID(8'd0)
) u_sts_iniu (
    .clk_src           (axi_clk),
    .clk_dst           (noc_clk),
    .rstn_src          (rstn_axi),
    .rstn_dst          (rstn_noc),
    .node_id           (8'd0),
    .flow_ctrl_busy    (2'b00),
    .flow_ctrl_update  (),
    // AXI4 slave ...
    .sts_iniu_s_awvalid(s_awvalid),
    // ... (省略其余 AXI 信号)
    // NOC interface
    .out_req_vld       (iniu_req_vld),
    .out_req_rdy       (iniu_req_rdy),
    .out_req_pld       (iniu_req_pld),
    .in_rsp_vld        (iniu_rsp_vld),
    .in_rsp_rdy        (iniu_rsp_rdy),
    .in_rsp_pld        (iniu_rsp_pld),
    // CTI（不使用时接 '0 / 悬空）
    .sys_cti_event_in  ('0),
    .noc_cti_event_in  ('0),
    .sys_cti_channel_in('0),
    .noc_cti_channel_in('0),
    // DBG
    .dbg_timestamp_in  (64'd0),
    .dbg_data_in       (32'd0)
);
```
