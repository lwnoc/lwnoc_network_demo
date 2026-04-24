# STS NOC 1 INIU + 3 TNIU 验证计划

## 1. 验证目标
验证目标是对当前仓库中的 STS NOC 组件进行系统级组合验证，覆盖 1 INIU + 3 TNIU 验证 DUT 中所有已实现 feature，并为后续 coverage closure 提供可扩展的 UVM 基础设施。

本轮验证不把 `pprot` 纳入功能需求，也不把完整 AXI4 burst/乱序/交织能力当作既有 feature 进行签核。

## 2. 测试平台架构
### 2.1 结构概述
- `uvm_test_top`
- AXI master agent：驱动 INIU AXI slave 端口
- 3 组 APB slave model / adapter：挂接各 TNIU 的 regbank/RSC 本地接口
- scoreboard：基于地址表和参考模型比较 AXI 侧观测与目标 slave 预期
- monitors：AXI、内部 req/rsp、APB、CTI、debug
- coverage collectors：地址命中、目标 TNIU、读写类型、错误响应、CTI/debug 连通性

### 2.2 VIP 选择
- AXI 侧优先参考 `taichi-ishitani/tvip-axi`
- 使用 master agent 作为激励源
- 如果 regbank 需要寄存器级验证，可复用现有生成的 RAL model

### 2.3 DUT 组成
- 1 × `sts_iniu_top`
- 3 × `sts_tniu_top`
- 1 × request router wrapper
- 1 × response mux wrapper
- 3 × regbank local slave
- 3 × RSC stub slave

### 2.4 wrapper 验证合同
- request router 必须按 `tgt_id` 精确分发到唯一目标 TNIU。
- illegal `tgt_id` 不得广播到任何 TNIU，而是直接形成错误响应。
- response mux 采用固定优先级 `TNIU0 > TNIU1 > TNIU2`。
- 单个 TNIU 内部返回顺序必须保持；跨 TNIU 全局返回顺序不作要求。
- scoreboard 以 `txn_id` 正确关联、无丢失/无重复为主判据。

## 3. 时序与调度规则
- AXI driver 在 `clk_src` 正沿采样/驱动。
- APB monitor 在 `psel && penable && pready` 握手点采样一次事务。
- scoreboard 以 APB 完成时刻作为参考提交点，以 AXI `B/R` 作为 DUT 可见完成点。
- CTI/debug/timestamp 检查采用容忍跨域同步延迟的窗口比较，不做零周期假设。
- reset 期间禁止 sequence 推送有效事务；reset 释放后至少等待 4 个 `clk_src` 周期再开始主测试。
- `rstn_src/rstn_dst/rstn_dbg_timer` 同时异步拉低；释放后分别等待至少 4 个本域时钟周期才允许该域相关检查生效。
- CTI/debug/timestamp 相关检查在全部复位释放后延迟 8 个 `clk_dst` 周期再开启。

## 4. 参考模型
### 4.1 地址到目标映射
参考模型与 spec 中表格完全一致：
- `0x0000_0000~0x0000_0FFF` -> TNIU0 regbank
- `0x0000_1000~0x0000_1FFF` -> TNIU0 RSC
- `0x0000_2000~0x0000_2FFF` -> TNIU1 regbank
- `0x0000_3000~0x0000_3FFF` -> TNIU1 RSC
- `0x0000_4000~0x0000_4FFF` -> TNIU2 regbank
- `0x0000_5000~0x0000_5FFF` -> TNIU2 RSC

### 4.2 数据模型
- regbank：根据现有寄存器 RTL 建立镜像模型
- RSC：第一版使用简单 APB memory/stub 模型，可配置只读/读写寄存器集合
- decode miss：期望返回错误响应

## 5. testcase 列表
| 编号 | 名称 | 激励描述 | 通过标准 |
|---|---|---|---|
| tc001 | reset_smoke | 仅做复位拉低/释放，检查接口稳定 | 无 X/Z；AXI/APB 无非法握手；所有 monitor 启动正常 |
| tc002 | regbank_rw_tniu0 | 对 TNIU0 regbank 执行基础读写 | AXI 读回值与 regbank 镜像一致 |
| tc003 | rsc_rw_tniu0 | 对 TNIU0 RSC 执行基础读写 | APB 命中 RSC0；AXI 返回值与 stub 一致 |
| tc004 | regbank_rw_tniu1 | 对 TNIU1 regbank 执行基础读写 | 请求只到 TNIU1，本地 regbank1 响应正确 |
| tc005 | rsc_rw_tniu1 | 对 TNIU1 RSC 执行基础读写 | 请求只到 TNIU1，本地 RSC1 响应正确 |
| tc006 | regbank_rw_tniu2 | 对 TNIU2 regbank 执行基础读写 | 请求只到 TNIU2，本地 regbank2 响应正确 |
| tc007 | rsc_rw_tniu2 | 对 TNIU2 RSC 执行基础读写 | 请求只到 TNIU2，本地 RSC2 响应正确 |
| tc008 | decode_miss | 访问未映射地址 | 返回错误响应；不得错误命中任意 local slave |
| tc009 | mixed_read_write | 对 6 个窗口交错执行读写 | scoreboard 全部匹配；无路由串扰 |
| tc010 | backpressure_rsp | 在 AXI B/R 通道施加 ready backpressure | 事务不丢失，不重排，不重复 |
| tc011 | cti_connectivity | 激励 CTI event/channel | 在修复 `cti_handle` reset bug 后执行；每条脉冲在 8 个 `clk_dst` 周期内到达，且 100 次激励无丢失/重复 |
| tc012 | debug_timestamp_path | 激励 debug/timestamp 路径 | `dbg_data` 1:1 透传；`dbg_timestamp` 在 8 个 `clk_dbg_timer` 周期内稳定到输出 |
| tc013 | random_addr_constrained | 在 6 个合法窗口内随机访问 | 随机 200 笔；6 个窗口全部命中；3 个 TNIU 全覆盖；读/写各至少 50 笔 |
| tc014 | random_illegal_addr | 在非法窗口随机访问 | 随机 100 笔；100% 返回 error；不得命中任意 local slave |
| tc015 | reset_during_idle | 空闲期间异步复位 | 复位后可继续正常访问 |
| tc016 | outstanding_stress | 对 8/16/32 三档 outstanding 逐级加压，统计请求接收与响应返回时间 | 输出每档 accepted-before-first-response 深度与完成时间；所有响应正确；不得超时 |

### 命名规则
- testcase 文件路径统一为 `testcase/tcXXX_<name>.sv`
- testcase 编号必须与文件名前缀完全一致

## 6. 参数测试矩阵
| 配置 | 说明 | 关联 testcase |
|---|---|---|
| cfg_default_1x3 | 默认 6 个 4KB table entry | tc001-tc015 |
| cfg_remap_shifted | 6 个窗口整体平移到 `0x0001_0000~0x0001_5FFF`，其他规则不变 | tc002-tc010, tc013, tc014 |
| cfg_default_target_err | default tgt 指向错误路径 | tc008, tc014 |
| cfg_default_outstanding_stress | 默认映射下对 9 个 stub window 做单拍读压力测试 | tc016 |

## 7. Coverage 目标
### 7.1 功能覆盖
- 地址窗口覆盖：6/6 命中
- 目标 TNIU 覆盖：3/3 命中
- slave 类型覆盖：regbank、RSC 全覆盖
- 访问类型覆盖：read、write 全覆盖
- 响应类型覆盖：OKAY、error 全覆盖
- CTI feature 覆盖：event/channel 双覆盖
- debug/timestamp 覆盖：输入变化、跨域传播、复位后恢复

### 7.2 代码覆盖目标
- line: 100%
- branch: 100%
- condition: 100%
- toggle: 100%
- FSM/assertion: 若 RTL 中存在，则目标 100%

说明：若因未实现功能、死代码或第三方依赖导致无法达到 100%，必须通过 waiver/exclusion 明确记录原因，不能口头跳过。

## 8. Coverage closure 策略
- 第一阶段：smoke + directed case 打通所有窗口/类型/路径
- 第二阶段：constrained-random 提升组合覆盖
- 第三阶段：分析 hole，补 directed test 或 exclusion
- 第四阶段：覆盖报告复核，确认 hole 是否来自 bug、未实现功能或不可达逻辑

### 8.1 代码覆盖范围
计入本轮 100% 目标的模块范围与 `spec.md` 中签核范围保持一致：INIU/TNIU/common 关键模块 + 新增 DUT wrapper。`fcip/` 第三方基础单元默认单独统计，不直接作为签核阻塞项。

## 9. UVM 结构要求
建议目录：
```text
testbench/
├── dut/
├── env/
├── agent/
│   ├── axi/
│   ├── apb/
│   └── internal/
├── seq/
├── cfg/
├── cov/
├── sb/
├── test/
└── top/
```

要求：
- sequence 与 env 解耦
- 所有地址规则通过 config object 下发
- scoreboard 不直接依赖具体 testcase
- coverage collector 与 scoreboard 分离
- 所有 log 输出统一放在 `log/`

## 10. 已知风险与待办
- 现有仓库没有完整 fabric，需要新增 verification wrapper。
- `cti_handle.sv` 需先修复 reset 接线错误，否则 `tc011` 不能进入签核回归。
- 真实 PNG 架构图尚未导出。
