# STS NOC 1 INIU + 3 TNIU 验证 DUT 规格说明

## 1. 场景概述
本项目基于已有 STS NOC 组件级 RTL，构建一个验证专用 DUT：1 个 AXI 源侧 INIU，连接 3 个目标侧 TNIU。该 DUT 的目标不是重新定义协议，而是把当前仓库中已经存在的组件行为组织成一个可验证、可覆盖、可闭环的最小系统。

本规格严格以现有 RTL 为基础，同时把验证封装需要新增的 wrapper/fabric 明确标出。`pprot` 明确不作为需求范围；覆盖目标为 100%，但仅针对确认后的验证范围和实现内容。

## 2. 工作边界
### 2.1 已实现能力
- INIU 顶层将 AXI AW/W/AR 请求打包为 `sts_req_typ`。
- INIU 支持 parameter 化地址到 `tgt_id` 映射。
- TNIU 基于 `tgt_id` 进行本地 APB / 远端转发判定。
- TNIU sys side 具备 1-to-2 APB decode，适合挂 2 个本地 slave。
- TNIU local regbank 已有现成 RTL。
- CTI/debug/timestamp 路径在组件中已有实现。

### 2.2 当前限制
- 现仓库无现成 1x3 interconnect/fabric 顶层。
- `sts_tniu_apb` 是单请求到 APB 的桥，当前更适合作为单拍 APB access 使用。
- `pprot` 现实现为临时旁带，不纳入本项目功能定义与检查。
- `cti_handle.sv` 当前存在 reset 接线 bug，后续实现阶段需修复。
- 旧版未使用的 TNIU 顶层写侧控制接口已确认移除。

## 3. 时钟与复位定义
| 名称 | 方向 | 说明 | 建议频率 | 周期 | 域 |
|---|---|---|---|---|---|
| `clk_src` | input | INIU AXI 侧、TNIU noc 侧工作时钟 | 500MHz | 2ns | src |
| `clk_dst` | input | TNIU sys side、本地 APB/寄存器侧时钟 | 250MHz | 4ns | dst |
| `clk_dbg_timer` | input | timestamp/debug timer 时钟 | 250MHz | 4ns | dbg |
| `rstn_src` | input | src 域低有效复位 | async assert | - | src |
| `rstn_dst` | input | dst 域低有效复位 | async assert | - | dst |
| `rstn_dbg_timer` | input | dbg 域低有效复位 | async assert | - | dbg |

## 4. DUT 顶层定义
建议新增验证专用顶层：`sts_noc_1iniu_3tniu_dut`。

该顶层包含：
- 1 个 `sts_iniu_top`
- 3 个 `sts_tniu_top`
- 1 个请求路由 wrapper：按 `tgt_id` 将 INIU 请求分发给目标 TNIU
- 1 个响应汇聚 wrapper：从 3 个 TNIU 汇聚响应回 INIU
- 6 个本地 APB slave stub/模型：3 个 regbank + 3 个 RSC

### 4.2 DUT 外部接口
验证 DUT 的外部可见端口定义如下。凡未列出的 APB 信号均视为 DUT 内部连线，不暴露到 testbench 顶层。

| 接口/信号 | 方向 | 位宽 | 时钟/复位 | 说明 |
|---|---|---:|---|---|
| `clk_src` | input | 1 | - | AXI/INIU source 域时钟 |
| `clk_dst` | input | 1 | - | TNIU system/APB 域时钟 |
| `clk_dbg_timer` | input | 1 | - | debug timestamp 域时钟 |
| `rstn_src` | input | 1 | - | src 域低有效复位 |
| `rstn_dst` | input | 1 | - | dst 域低有效复位 |
| `rstn_dbg_timer` | input | 1 | - | dbg 域低有效复位 |
| `axi_if` | inout | AXI4-like bundle | `clk_src/rstn_src` | 与 `sts_iniu_top` AXI slave 端口等价的单主接口 |
| `sys_cti_event_in` | input | 8 | `clk_src/rstn_src` | system-side CTI event 输入 |
| `sys_cti_event_out` | output | 8 | `clk_dst/rstn_dst` | system-side CTI event 输出 |
| `sys_cti_channel_in` | input | 8 | `clk_src/rstn_src` | system-side CTI channel 输入 |
| `sys_cti_channel_out` | output | 8 | `clk_dst/rstn_dst` | system-side CTI channel 输出 |
| `noc_cti_event_in[2:0]` | input | 3x8 | per TNIU | 三个 TNIU noc-side CTI event 输入 |
| `noc_cti_event_out[2:0]` | output | 3x8 | per TNIU | 三个 TNIU noc-side CTI event 输出 |
| `noc_cti_channel_in[2:0]` | input | 3x8 | per TNIU | 三个 TNIU noc-side CTI channel 输入 |
| `noc_cti_channel_out[2:0]` | output | 3x8 | per TNIU | 三个 TNIU noc-side CTI channel 输出 |
| `dbg_data_in` | input | 32 | `clk_src/rstn_src` | debug 数据输入 |
| `dbg_data_out[2:0]` | output | 3x32 | per TNIU | 三个 TNIU debug 数据输出 |
| `dbg_timestamp_in` | input | 64 | `clk_dbg_timer/rstn_dbg_timer` | timestamp 输入 |
| `dbg_timestamp_out[2:0]` | output | 3x64 | per TNIU | 三个 TNIU timestamp 输出 |
| `timing_bus1/2/3[2:0]` | output | 3x1 | `clk_dst/rstn_dst` | 三个 TNIU 本地静态/寄存器导出信号 |
| `dbg_en[2:0]` | output | 3x1 | `clk_dst/rstn_dst` | 三个 TNIU 的 debug enable 导出 |

### 4.1 模块层次
```text
sts_noc_1iniu_3tniu_dut
├── sts_iniu_top u_iniu0
├── sts_noc_req_router_1to3
├── sts_tniu_top u_tniu0
│   ├── local regbank0
│   └── local rsc0
├── sts_tniu_top u_tniu1
│   ├── local regbank1
│   └── local rsc1
├── sts_tniu_top u_tniu2
│   ├── local regbank2
│   └── local rsc2
└── sts_noc_rsp_mux_3to1
```

## 5. I/O 定义
### 5.1 AXI 主接口
| 信号 | 方向 | 位宽 | 时钟/复位 | 说明 |
|---|---|---:|---|---|
| `awid` | input | 8 | `clk_src/rstn_src` | 写地址 ID |
| `awaddr` | input | 32 | `clk_src/rstn_src` | 写地址 |
| `awlen` | input | 8 | `clk_src/rstn_src` | 写 burst 长度，当前要求固定为 0 |
| `awsize` | input | 3 | `clk_src/rstn_src` | 写 beat size，当前要求固定为 3'b010 |
| `awburst` | input | 2 | `clk_src/rstn_src` | 写 burst 类型，当前要求固定为 INCR |
| `awlock/awcache/awqos/awuser` | input | 1/4/4/8 | `clk_src/rstn_src` | 透传/记录字段 |
| `awprot` | input | 3 | `clk_src/rstn_src` | 可驱动但不纳入功能检查 |
| `awvalid/awready` | input/output | 1 | `clk_src/rstn_src` | 写地址握手 |
| `wdata` | input | 32 | `clk_src/rstn_src` | 写数据 |
| `wstrb` | input | 4 | `clk_src/rstn_src` | 字节使能 |
| `wlast` | input | 1 | `clk_src/rstn_src` | 当前要求固定为 1 |
| `wvalid/wready` | input/output | 1 | `clk_src/rstn_src` | 写数据握手 |
| `bid/bresp/bvalid/bready` | output/input | 8/2/1/1 | `clk_src/rstn_src` | 写响应通道 |
| `arid/araddr/arlen/arsize/arburst/arlock/arcache/arqos/aruser/arprot/arvalid/arready` | input/output | 同 AW/AR RTL 定义 | `clk_src/rstn_src` | 读地址通道，当前约束同写地址 |
| `rid/rdata/rresp/rlast/rvalid/rready` | output/input | 8/32/2/1/1/1 | `clk_src/rstn_src` | 读数据响应通道 |

### 5.2 本地 APB 接口
每个 TNIU 对应 2 个 APB slave 槽位：
- `M0`: local regbank
- `M1`: local RSC

`pprot` 虽然在 RTL 端口中存在，但本项目中不作为功能需求、记分或覆盖对象。

### 5.3 调试与 CTI
- `dbg_data_*`
- `dbg_timestamp_*`
- `sys_cti_*`
- `noc_cti_*`

这些信号在验证中作为 feature 覆盖对象，但首轮只检查连通性和跨域行为，不做协议增强假设。

## 6. 参数定义
### 6.1 INIU 地址映射参数
| 参数 | 默认 | 说明 |
|---|---|---|
| `ADDR_MAP_ENTRY_NUM` | implementation-defined | 不规则窗口表项数 |
| `ADDR_MAP_BASE_TABLE` | `'0` | 基地址平铺向量 |
| `ADDR_MAP_MASK_TABLE` | `'0` | 掩码平铺向量 |
| `ADDR_MAP_TGT_ID_TABLE` | `'0` | `tgt_id` 平铺向量 |
| `ADDR_MAP_LINEAR_EN` | `0` | 是否启用线性窗口 |
| `ADDR_MAP_LINEAR_BASE` | `'0` | 线性窗口起始地址 |
| `ADDR_MAP_LINEAR_NUM` | `1` | 线性窗口目标数 |
| `ADDR_MAP_LINEAR_STRIDE_LOG2` | `0` | 窗口跨度的 $log_2$ 字节数 |
| `ADDR_MAP_LINEAR_TGT_BASE` | `'0` | 第一个线性目标的 `tgt_id` |
| `ADDR_MAP_DEFAULT_TGT_ID` | `'0` | 未命中 fallback |

### 6.2 TNIU 路由参数
| 参数 | 默认 | 说明 |
|---|---|---|
| `TGT_TYPE_WIDTH` | `2` | `tgt_id` 高位 class 宽度 |
| `LOCAL_APB_TGT_TYPE` | `2'b01` | 进入本地 APB 的 class 编码 |
| `LOCAL_REGBANK_TGT_ID` | implementation-defined | 本地 regbank 精确 `tgt_id` |
| `LOCAL_RSC_TGT_ID` | implementation-defined | 本地 RSC 精确 `tgt_id` |
| `SYS_APB_M0_TGT_ID` | implementation-defined | sys side APB M0 decode 的 `tgt_id` |
| `SYS_APB_M1_TGT_ID` | implementation-defined | sys side APB M1 decode 的 `tgt_id` |

## 7. 验证 DUT 的地址规划
本次 1 INIU + 3 TNIU 验证 DUT 使用固定 4KB 对齐地址窗口，全部通过 parameter 配置实现。

| 地址范围 | 大小 | 目标 | `tgt_id` |
|---|---:|---|---|
| `0x0000_0000` - `0x0000_0FFF` | 4KB | TNIU0 regbank | `8'h40` |
| `0x0000_1000` - `0x0000_1FFF` | 4KB | TNIU0 RSC | `8'h41` |
| `0x0000_2000` - `0x0000_2FFF` | 4KB | TNIU1 regbank | `8'h42` |
| `0x0000_3000` - `0x0000_3FFF` | 4KB | TNIU1 RSC | `8'h43` |
| `0x0000_4000` - `0x0000_4FFF` | 4KB | TNIU2 regbank | `8'h44` |
| `0x0000_5000` - `0x0000_5FFF` | 4KB | TNIU2 RSC | `8'h45` |

说明：
- 所有窗口均满足 4KB 对齐。
- 验证用 router 以完整 `tgt_id` 范围做 1-to-3 路由：`40/41 -> TNIU0`，`42/43 -> TNIU1`，`44/45 -> TNIU2`。
- 本次 DUT 不使用 linear 区域作为主映射方式，因为 6 个窗口已可由 table 精确覆盖；linear 模式保留给后续更大规模目标数场景。

### 7.1 INIU 例化参数
```systemverilog
.ADDR_MAP_ENTRY_NUM      (6),
.ADDR_MAP_BASE_TABLE     ({32'h0000_5000, 32'h0000_4000, 32'h0000_3000,
                           32'h0000_2000, 32'h0000_1000, 32'h0000_0000}),
.ADDR_MAP_MASK_TABLE     ({32'hFFFF_F000, 32'hFFFF_F000, 32'hFFFF_F000,
                           32'hFFFF_F000, 32'hFFFF_F000, 32'hFFFF_F000}),
.ADDR_MAP_TGT_ID_TABLE   ({8'h45,         8'h44,         8'h43,
                           8'h42,         8'h41,         8'h40}),
.ADDR_MAP_LINEAR_EN      (1'b0),
.ADDR_MAP_DEFAULT_TGT_ID (8'hFF)
```

### 7.2 TNIU 例化参数
对三个 TNIU 分别配置：
- `u_tniu0`: regbank=`8'h40`, rsc=`8'h41`
- `u_tniu1`: regbank=`8'h42`, rsc=`8'h43`
- `u_tniu2`: regbank=`8'h44`, rsc=`8'h45`

## 8. 功能定义
### 8.1 AXI 写通路
- INIU 接收 AXI AW/W，并打包成一个 `sts_req_typ`。
- 地址映射器根据 `awaddr` 产生目标 `tgt_id`。
- wrapper 根据 `tgt_id` 路由到目标 TNIU。
- 目标 TNIU 将请求转换为 APB，并访问本地 regbank 或 RSC。
- APB 完成后返回 `WrRsp`，经响应汇聚回 INIU，最终输出 AXI `B`。

### 8.2 AXI 读通路
- INIU 接收 AR 并生成 `RdReq`。
- 地址映射器根据 `araddr` 产生 `tgt_id`。
- wrapper 路由到目标 TNIU。
- TNIU APB 读出本地 regbank/RSC 数据。
- 读响应返回至 INIU，最终输出 AXI `R`。

### 8.3 CTI/Debug/Timestamp
- CTI 事件与通道信号通过 async pulse bridge 跨域传递。
- `dbg_data` 使用 marker 透传。
- `dbg_timestamp` 通过同步单元跨域传递。

### 8.4 地址映射优先级
INIU 地址映射优先级固定为：
1. 表项命中
2. 线性区域命中
3. default target

### 8.5 支持的 AXI 子集
本轮签核只覆盖当前 RTL 可稳定承载的 AXI 子集，具体如下：

| 项目 | 约束 |
|---|---|
| 协议宽度 | 32-bit data, 4-bit strobe, 8-bit ID |
| 访问粒度 | 单拍访问 |
| `AWLEN/ARLEN` | 固定为 `0` |
| `WLAST` | 固定为 `1` |
| `AWSIZE/ARSIZE` | 固定为 `3'b010`（4 bytes） |
| `AWBURST/ARBURST` | 固定为 `2'b01`（INCR）；单拍下功能等价于定点访问 |
| 地址对齐 | 访问地址按 4-byte 对齐；窗口基地址按 4KB 对齐 |
| outstanding | 每个读/写方向最多允许 8 个 outstanding transaction ID |
| 响应匹配 | 以 `txn_id`/remap 后 ID 保证请求响应关联，不要求跨 TNIU 全局有序 |
| `pprot` | 可驱动但不做功能比较、scoreboard 检查或覆盖 |

超出上述子集的激励，不计入本轮签核范围。

### 8.6 wrapper 路由/汇聚合同
验证 DUT 中新增 wrapper 的行为合同定义如下：

| 项目 | 规则 |
|---|---|
| 请求路由键 | 使用完整 `tgt_id` 精确映射到 TNIU 实例 |
| 请求路由表 | `40/41 -> TNIU0`，`42/43 -> TNIU1`，`44/45 -> TNIU2` |
| 非法 `tgt_id` | 不发往任何 TNIU，由 wrapper 直接返回 decode error 响应 |
| 并发请求 | INIU 单一 req stream 按原始握手发送；wrapper 不重排请求 |
| 响应仲裁 | 3 路响应采用固定优先级 `TNIU0 > TNIU1 > TNIU2` |
| 响应有序性 | 保证单个 TNIU 内部响应顺序不被 wrapper 打乱；跨 TNIU 不保证全局顺序 |
| backpressure | INIU `out_req_rdy` 由目标 TNIU ready 或 decode-error response 通路决定；rsp mux 必须向未被选中的 TNIU 保持 `rdy=0` |
| scoreboarding | 以 `txn_id` 正确关联为主，不以跨目标返回顺序为通过条件 |

### 8.7 非功能项 / 不纳入闭环项
- `pprot` 不作为功能需求。
- 不以完整 AXI4 burst 支持作为本轮签核目标。
- 不假设现有 RTL 具备乱序响应、读交织、多主仲裁等高级行为。

## 9. 边界条件
- 未命中地址返回 default target；在验证 DUT 中 default target 应产生 decode error 路径。
- regbank 与 RSC 地址窗口不可重叠。
- 所有地址窗口必须 4KB 对齐。
- reset 释放后 first access 必须可重复、可预测。
- CTI 跨域期间不得产生持续锁死或未知态扩散。

## 10. 设计约束总结
- `clk_src` 与 `clk_dst` 为异步或准异步域，必须通过现有 async bridge 连接。
- 所有地址窗口采用 4KB 对齐。
- 1 个 TNIU 当前只定义 2 个本地 APB slave 槽位。
- 验证用 wrapper 仅承担 fabric 功能，不改变组件内部协议。

## 11. 参数表（验证 DUT 实例）
| 参数 | 类型 | 默认/计划值 | 合法范围 | 说明 |
|---|---|---|---|---|
| `ADDR_MAP_ENTRY_NUM` | `int unsigned` | `6` | `>=1` | 本次验证使用 6 个 table entry |
| `ADDR_MAP_BASE_TABLE` | `logic [6*32-1:0]` | 见 7.1 | 每项 4KB 对齐 | 6 个窗口的 base 地址 |
| `ADDR_MAP_MASK_TABLE` | `logic [6*32-1:0]` | 全 `32'hFFFF_F000` | contiguous high bits | 4KB mask |
| `ADDR_MAP_TGT_ID_TABLE` | `logic [6*8-1:0]` | `{45,44,43,42,41,40}` | 唯一、不重叠 | 窗口目标 ID |
| `ADDR_MAP_LINEAR_EN` | `bit` | `0` | `0/1` | 本次 DUT 不启用 linear 模式 |
| `ADDR_MAP_DEFAULT_TGT_ID` | `logic [7:0]` | `8'hFF` | 不与合法 target 重叠 | 未命中 fallback |
| `LOCAL_APB_TGT_TYPE` | `logic [1:0]` | `2'b01` | 固定 | 本地 APB class |
| `LOCAL_REGBANK_TGT_ID` | `logic [7:0]` | `8'h40/42/44` | 属于本 TNIU 映射组 | 各 TNIU regbank ID |
| `LOCAL_RSC_TGT_ID` | `logic [7:0]` | `8'h41/43/45` | 属于本 TNIU 映射组 | 各 TNIU RSC ID |
| `SYS_APB_M0_TGT_ID` | `logic [7:0]` | 同 regbank ID | 与 `LOCAL_REGBANK_TGT_ID` 一致 | sys side APB decode |
| `SYS_APB_M1_TGT_ID` | `logic [7:0]` | 同 RSC ID | 与 `LOCAL_RSC_TGT_ID` 一致 | sys side APB decode |

## 12. 覆盖率签核范围
| 范围 | 处理方式 |
|---|---|
| `rtl/iniu/*.sv` | 纳入签核范围 |
| `rtl/tniu/*.sv` | 纳入签核范围 |
| `rtl/common/lwnoc_sts_pack.sv` | 纳入签核范围 |
| `rtl/common/sts_iniu_addr_map.sv` | 纳入签核范围 |
| `rtl/common/sts_tniu_apb_dec.sv` | 纳入签核范围 |
| 新增 verification DUT wrappers | 纳入签核范围 |
| `fcip/` 第三方/共用基础单元 | 默认不计入 100% 代码覆盖签核，可单独统计 |
| 已确认 bug 或不可达逻辑 | 需通过 waiver/exclusion 记录后才可排除 |

## 13. 微架构图
- drawio 源文件：`doc/sts_noc_1x3_arch.drawio`
- PNG：当前环境无法自动导出，待补

当前建议拓扑：
```text
AXI Master
   |
   v
+----------------+
|  sts_iniu_top  |
+----------------+
   | req/rsp
   v
+-----------------------+
| req_router_1to3       |
| rsp_mux_3to1          |
+-----------------------+
   |          |          |
   v          v          v
+---------+ +---------+ +---------+
| tniu0   | | tniu1   | | tniu2   |
| reg+rsc | | reg+rsc | | reg+rsc |
+---------+ +---------+ +---------+
```
