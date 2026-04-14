# LWNOC Low-Power 体系深度分析

本文档从第一性原理出发，推导该 LP 体系的运作原理、存在的风险，以及这种结构相比其他方案的优势。

---

## 1. 核心问题：N 个异构节点如何达成功耗切换共识

一个 NoC 内部有 N 个 NIU（包含 INIU 和多种 TNIU），分布在不同的时钟域中。当外部电源控制器发出降功耗请求时，系统必须：

1. **通知**所有 N 个节点"即将切换"
2. **等待**每个节点完成本地准备（排空事务、stall 流量等）
3. **确认**所有节点都已就绪后，才真正执行不可逆操作
4. 如果某个节点**无法就绪**（如事务排空超时），必须能**撤销**整个操作

这本质上是一个**分布式共识问题**。传统方案有三种：

| 方案 | 原理 | 代价 |
|------|------|------|
| 集中式控制器 | 一个 master 逐个轮询 N 个 slave | O(N) 时间，master 是单点故障 |
| 菊花链 | 请求沿链传播，每个节点确认后传给下一个 | O(N) 时间，任一节点卡住则下游全阻塞 |
| 广播+归约 | 请求广播到所有节点，响应归约回来 | O(1) 时间，需要归约硬件 |

本系统采用第三种，用一个纯组合逻辑的 Hub 做广播和归约。

---

## 2. OR/AND 双轨归约的数学本质

### 2.1 基本原理

每个节点 i 输出一个 1-bit 的请求值 `req_i ∈ {0, 1}`。它同时驱动两个信号：
```
tx_req.stg1_req_or  = req_i
tx_req.stg1_req_and = req_i
```

Hub（subhub）对一个终端的每个 peer 做归约：
```
hub_output_to_i.req_or  = OR(req_j)   对所有 j ≠ i
hub_output_to_i.req_and = AND(req_j)  对所有 j ≠ i
```

节点 i 观察到的 Hub 输出含义：

| hub.req_or | hub.req_and | 含义 |
|------------|-------------|------|
| 0 | 0 | 所有其他节点都是 0 |
| 1 | 0 | 某些（非全部）其他节点是 1 |
| 1 | 1 | 所有其他节点都是 1 |
| 0 | 1 | 不可能（AND ≤ OR） |

结合节点自身的 `req_i`，节点 i 可以完整判断全局状态：

- **"我是否是第一个 assert 的"**：`req_i=1 && hub.req_or=0` → 我是唯一 assert 的
- **"是否所有人都 assert 了"**：`req_i=1 && hub.req_and=1` → 全部已 assert
- **"是否所有人都 deassert 了"**：`req_i=0 && hub.req_or=0` → 全部已 deassert
- **"有没有人 deassert 了"**：`hub.req_and=0` → 存在至少一个 deassert

### 2.2 这等价于一个硬件 Barrier

在并行计算中，Barrier 是一个同步原语：所有线程到达 barrier 后才能继续。这里的 `req_and=1` 就是 barrier 完成的条件。传统 barrier 需要一个 counter 或 tree-reduce，而 OR/AND 双轨用纯组合逻辑实现了同样的功能，且不需要知道 N 是多少。

### 2.3 为什么需要 OR 和 AND 两个信号

单独用 AND 不够：你无法区分"还没有人开始"和"有人开始但还没全完成"。
单独用 OR 不够：你无法知道"是否所有人都完成了"。

FSM 需要这两种信息来驱动不同的状态转移：
- **STOP → ACT**：需要 OR（任何一个节点发起即可触发）
- **ACT → RUN**：需要 AND（所有节点就绪才能进入运行）
- **RUN → DEACT**：需要 ~AND（任何一个节点释放即触发退出）
- **DEACT → STOP**：需要 ~OR（所有节点都已释放才能完成）

---

## 3. 信号逐跳追踪：完整的 Power-Down 流程

以 3 个节点为例：INIU（I）、TNIU-A（A）、TNIU-B（B），通过一个 3-terminal hub 连接。假设系统处于 RUN 状态（Level 0），P-channel master 请求 Level 1 OFF。

### 3.1 初始稳态

所有节点都在 RUN 状态：

```
节点        stg1_req_or  stg1_req_and  stg2_req_or  stg2_req_and  state     deny
I (INIU)    1            1             1            1             NOP       0
A (TNIU-A)  1            1             1            1             NOP       0
B (TNIU-B)  1            1             1            1             NOP       0
```

Hub 输出（每个节点看到的是其余两个的归约）：
```
→ I 看到: or=1, and=1（A 和 B 都是 1）
→ A 看到: or=1, and=1（I 和 B 都是 1）
→ B 看到: or=1, and=1（I 和 A 都是 1）
```

各节点 stg1_fsm 状态：`LP_STG1_RUN`。
各 slv_adapter STG1 FSM 状态：`LP_SLV_FSM_IDLE`，tx_stg1_req=1。

### 3.2 Step 1：P-channel 触发

P-channel master: `preq=1, pstate=P_LEVEL1_OFF`

pchn_niu 检测到 `preq_rise` 且处于 stable_point（RUN）：
- 锁存 `dir_up=0`（下电），`target_lp_state_latched=LP_LEVEL1_OFF`
- FSM: `LP_PCH_RUN → LP_PCH_DEACT_STG1`

pchn_niu 在 DEACT_STG1 状态的输出：
```
tx_stg1_req = 0    （不在 ACT_STG1/ACT_STG2/RUN 中的任何一个）
tx_stg2_req = 1    （DEACT_STG1 在列表中）
tx_state    = LP_LEVEL1_OFF
tx_stg1_deny = rx_stg1_deny（透传）
```

### 3.3 Step 2：INIU 侧 niu_fsm 传播

pchn_niu 的 `tx_stg1_req=0` 传入 niu_fsm 作为 `internal_rx_stg1_req`。

stg1_fsm 输出到 LP 网络（通过 `assign tx_req.stg1_req_or = internal_rx_stg1_req`）：
```
I 的 tx_req: stg1_req_or=0, stg1_req_and=0, state=LP_LEVEL1_OFF
```

stg1_fsm 在 RUN 状态检查：`~tx_req.stg1_req_and = ~0 = 1` → 转移到 `LP_STG1_DEACT`。
master_mode 记录：`state==RUN && ~tx_req.stg1_req_and` → `master_mode=1`（自身触发）。

### 3.4 Step 3：Hub 广播

I 的 tx_req 变化后，Hub 立即（组合逻辑）更新输出：

```
A 看到的 Hub 输出:
  stg1_req_or  = I.or | B.or  = 0|1 = 1
  stg1_req_and = I.and & B.and = 0&1 = 0    ← 关键：AND 降为 0
  state        = I.state | B.state = LP_LEVEL1_OFF | NOP = LP_LEVEL1_OFF

B 看到的 Hub 输出:（对称地）
  stg1_req_or  = I.or | A.or  = 0|1 = 1
  stg1_req_and = I.and & A.and = 0&1 = 0
```

### 3.5 Step 4：TNIU 侧 stg1_fsm 响应

A 的 stg1_fsm 在 RUN 状态：检查 `~rx_req.stg1_req_and = ~0 = 1` → 转移到 `LP_STG1_DEACT`。
master_mode：`state==RUN && ~rx_req.stg1_req_and` → `master_mode=0`（外部触发，跟随者）。

在 DEACT 状态，stg1_fsm 输出给 slv_adapter：
```
internal_tx_stg1_req   = master_mode ? rx_req.stg1_req_or : 0 = 0（跟随者直接给 0）
internal_tx_stg1_state = rx_req.state = LP_LEVEL1_OFF
```

### 3.6 Step 5：slv_adapter 执行本地操作

A 的 slv_adapter 收到 `rx_stg1_req` 从 1→0（经过一拍延迟检测下降沿）：
- STG1 FSM: `IDLE → LP_SLV_FSM_REQ_OFF`
- 命令转换：`rx_stg1_req=0, rx_state=LP_LEVEL1_OFF` → `conv_cmd=LP_SLV_CMD_LEVEL1_OFF`
- 向功能模块发出：`mst_stg1_req=1, mst_cmd=LP_SLV_CMD_LEVEL1_OFF`
- 功能模块执行 stall/switch 操作，完成后返回 `mst_stg1_ack=1`

收到 ack：
```
slv_adapter: tx_stg1_req <= 0（确认下电）
STG1 FSM → IDLE
```

这个 `tx_stg1_req=0` 传回 niu_fsm 的 `internal_rx_stg1_req`，再到 stg1_fsm 的 `tx_req.stg1_req_or=0`。

### 3.7 Step 6：全局共识达成

B 完成同样的流程后，所有节点的 `stg1_req_or` 都变为 0。

Hub 输出到每个节点：`stg1_req_or=0, stg1_req_and=0`。

各节点 stg1_fsm 在 DEACT 状态检查：
```
~(tx_req.stg1_req_or || rx_req.stg1_req_or) = ~(0||0) = 1 → LP_STG1_STOP
```

**STG1 完成。** 所有节点进入 STOP。

### 3.8 Step 7-12：STG2 相同模式

stg2_fsm 检测到 STG1 完成（`~stg1_req_or`）后启动。INIU 释放 `stg2_req`，各 TNIU 跟随释放，Hub 归约确认全部完成。STG2 期间无 deny 机制，操作不可撤销。

### 3.9 Step 13：P-channel 返回

pchn_niu FSM 到达 `LP_PCH_STOP`，`accept_level` = `~dir_up && (fsm_cs==STOP)` = 1。
P-channel: `paccept=1` 返回给外部电源控制器。

---

## 4. 两阶段分离的设计推导

### 4.1 为什么不能只用一个阶段

考虑 async_bridge 的需求：
- **STG1**：设置 `stall_ptr=1`，阻止新事务进入；但需要等已有事务排空（`trans_idle`）
- **STG2**：设置 `clear_ptr=1`，清除 FIFO 指针；但需要等 FIFO 已空（`full_zero`）

如果只有一个阶段：stall 和 clear 同时执行，但 clear 需要在 stall 生效之后才安全。两阶段保证了严格的时序约束：

```
STG1: stall traffic → drain in-flight → ack（所有节点已安全）
STG2: clear pointers / apply reset → ack
```

### 4.2 为什么 STG2 没有 deny

设计决策：STG1 是"可协商的"，STG2 是"不可撤销的"。

逻辑推导：
- STG1 完成意味着所有节点都已确认安全（事务已排空，流量已 stall）
- STG2 操作（清指针、partial reset）执行后无法回退
- 如果 STG2 也允许 deny，会产生一半节点已 reset、一半回退的不一致状态

因此 STG2 所有 TNIU 直接 ack（`mst_stg2_ack <= mst_stg2_req`），不做条件判断。

### 4.3 为什么 Timeout 只在 Level 1

Level 1 是"条件性 stall"——仅当总线空闲时才 stall（`stall=trans_idle`）。这意味着如果有持续流量，该节点可能长时间无法就绪，需要超时机制安全退出。

Level 2/3 是"强制 stall"（`stall=1`），不等待总线空闲就直接 stall。因此理论上可以立即就绪，不需要超时。但这也意味着 **Level 2/3 的下电请求如果遇到节点无法响应（如时钟停止），系统将永久卡在 DEACT 阶段。**

---

## 5. 风险分析

### 5.1 [严重] DENY 状态自锁问题

**发现位置**：`lwnoc_lp_stg1_fsm.sv:80-83`

DENY 状态的退出条件：
```systemverilog
LP_STG1_DENY: begin
    if ((~(rx_req.deny_or | tx_req.deny_or)) &&  // deny deassert
        (tx_req.stg1_req_and && rx_req.stg1_req_and))
         state_n = LP_STG1_RUN;
end
```

同一模块中，DENY 状态的输出（`:108-125`）：
```systemverilog
LP_STG1_DENY: begin
    tx_req.deny_and = 1'b1;  // 硬编码为 1
    tx_req.deny_or  = 1'b1;  // 硬编码为 1
end
```

**问题**：`tx_req.deny_or` 在 DENY 状态被硬编码为 1，而退出条件要求 `~(rx_req.deny_or | tx_req.deny_or)`。由于 `tx_req.deny_or=1`，无论 `rx_req.deny_or` 是什么，条件恒为 FALSE。

**推导**：一旦 stg1_fsm 进入 DENY 状态，state_n 永远等于 state（DENY），状态机锁死。

**传播效应**：当一个节点 deny 后，deny 信号通过 Hub 传播到所有节点，最终所有节点的 stg1_fsm 都进入 DENY 状态。每个节点都因为自己的 `tx_req.deny_or=1` 而无法退出。整个 LP 网络永久锁死。

**可能的修复方向**：退出条件应该只检查外部 deny 是否清除（`rx_req.deny_or`），以及内部 adapter 是否已清除 deny（`internal_rx_stg1_deny`），而不是检查自身硬编码的输出：
```systemverilog
// 方案：只看外部和 adapter 是否 deny 已清除
if ((~rx_req.deny_or) && (~internal_rx_stg1_deny) &&
    (tx_req.stg1_req_and && rx_req.stg1_req_and))
     state_n = LP_STG1_RUN;
```

### 5.2 [严重] Endpoint 端口未连接

**发现位置**：`lwnoc_lp_hub_tiny_wrapper.sv:86-91`

```systemverilog
lwnoc_lp_endpoint u_endpoint (
    .tx_req (v_rx_req_hub[i]),
    .rx_req (v_tx_req_hub[i])
);
```

`lwnoc_lp_endpoint` 声明了 `input logic clk` 和 `output logic rst_n`，但 tiny_wrapper 实例化时未连接这两个端口。

**影响**：
- endpoint 内部包含 `fcip_sync_cell`（需要 clk/rst_n）、`always_ff @(posedge clk)`（需要 clk）
- 未连接的 clk 导致所有时序逻辑不工作，`tx_req_cdc` 保持初始值 X
- X 通过 Hub 传播到所有其他节点，污染 rx_req

**当前影响范围**：仅在 `NUM_TERMINAL < 3` 时触发（tiny_wrapper 需要 endpoint 填充空余端口）。当前 DUT 使用 `NUM_TERMINAL=5`（large_wrapper），不涉及 endpoint，因此不影响现有仿真。

**附带问题**：endpoint 将 `rst_n` 声明为 `output`，但模块内部将其当作输入使用（传给 sync_cell 和 always_ff）。这个端口方向声明可能有误。

### 5.3 [中等] Level 2/3 下电的无限等待

如果在 Level 2/3 下电过程中，某个 TNIU 的功能模块不返回 `mst_stg1_ack`（例如功能时钟已经被 gating 掉），`slv_adapter` 将永远停留在 `LP_SLV_FSM_REQ_OFF`，对应节点永远无法将 `tx_stg1_req` 降为 0。由于 Level 2/3 没有 timeout 机制，整个系统会卡死在 STG1 DEACT 阶段。

**本质原因**：timeout/deny 仅限 Level 1。Level 2/3 被设计为"无条件执行"，但如果目标模块的时钟在 LP 请求之前已经被外部 gating，就无法响应。

**可能的缓解**：
- 架构约束：保证功能模块的时钟在 LP 请求到达时仍然有效
- 或为 Level 2/3 也增加一个（更长的）timeout 机制

### 5.4 [中等] State 字段的 OR 聚合假设

Hub 对 `state` 字段使用 OR 聚合（`subhub.sv:49`）：
```systemverilog
assign tx_req.state = lwnoc_lp_state_t'(v_rx_req[0].state | v_rx_req[1].state);
```

`lwnoc_lp_state_t` 使用 one-hot 编码（001/010/100）。OR 聚合的隐含假设是**同一时刻只有一个有效的非零 state 值存在于网络中**。

如果两个 INIU 同时请求不同 level（如一个请求 Level 1 = 001，另一个请求 Level 2 = 010），OR 结果为 011，这不是合法的 one-hot 值，会导致 slv_adapter 的 `conv_cmd` 无法正确解码（落入 default 分支）。

**当前约束**：系统设计中每个 Hub 只有一个 INIU，由外部 P-channel master 协调。但如果未来扩展为多 INIU 架构，此约束需要被显式保证。

### 5.5 [低] Hub 级联的组合路径深度

对于 large_wrapper，N 个终端需要 N-4 个 internal hub + head + tail = N-2 个 hub_3terminal。最远的两个终端之间的组合路径经过 (N-2) 级 subhub 的 OR/AND 门。

每级 subhub 是一个 2-input 门（AND 或 OR），延迟约 1 gate delay。N=10 时约 8 级门延迟，通常不是关键路径。但如果 N 非常大（如 20+），可能需要考虑时序。

LP 信号本身是准静态的（只在功耗切换时变化），因此组合路径延迟只影响状态机的响应速度，不影响功能正确性。如果 Hub 的组合延迟超过一个时钟周期，FSM 可能多等一拍，但不会产生错误。

### 5.6 [低] master_mode 在同周期双触发时的优先级

`stg1_fsm.sv:92-103` 中的 master_mode 更新逻辑：
```systemverilog
else if ((state==LP_STG1_STOP) && tx_req.stg1_req_or)
    master_mode <= 1'b1;
else if ((state==LP_STG1_STOP) && rx_req.stg1_req_or)
    master_mode <= 1'b0;
```

如果在同一个时钟周期内，`tx_req.stg1_req_or`（本地 adapter 发起）和 `rx_req.stg1_req_or`（外部通过 Hub 传来）同时为 1，由于 `if-else` 优先级，`master_mode` 会被置为 1（本地优先）。

这种竞争在实际中极少发生（需要两个不同 INIU 在同一周期内发起 LP 请求），且 master_mode 只影响 ACT/DEACT 阶段的行为（master 等待所有人，follower 直接跟随），不影响最终结果的正确性。但理论上，如果两个 INIU 在不同 hub terminal 上同时发起，两者都认为自己是 master，会导致双方都等待对方先完成，形成暂时的 livelock（最终通过 timeout 或外部干预解决）。

### 5.7 [低] pchn_niu 缺少 `else` 分支

`lwnoc_lp_pchn_niu.sv:207-218`：
```systemverilog
if (~rst_n) begin
    paccept_r <= 1'b0;
    pdeny_r   <= 1'b0;
end if (transition_in_progress) begin  // ← 注意：这里是 "end if" 不是 "end else if"
    ...
end else begin
    ...
end
```

`end if` 而非 `end else if` 意味着 reset 和 transition_in_progress 的逻辑是**并列的**，不是互斥的。当 `rst_n=0` 且 `transition_in_progress=1` 时，两个分支都会匹配（但由于最后赋值优先，`transition_in_progress` 分支会覆盖 reset 分支）。在 reset 释放后的第一个周期这可能导致 paccept/pdeny 出现一拍毛刺。

---

## 6. 架构优势推导

### 6.1 O(1) 广播延迟 vs O(N) 轮询

集中式控制器需要 N 个周期逐个轮询，菊花链也需要 N 级传播。本系统中 Hub 是纯组合逻辑，所有节点在**同一个时钟周期**内看到相同的全局状态。实际达成共识的时间取决于最慢的节点（排空事务的时间），而不是节点数量。

### 6.2 无需知道 N：拓扑无关的协议

核心洞察：每个节点的 FSM 逻辑**完全不依赖于 N 是多少**。stg1_fsm 只观察 `rx_req.req_or`（有没有其他人）和 `rx_req.req_and`（是不是所有人都 OK）。增减节点只需要改变 Hub 的端口数量，所有节点的 RTL 完全不变。

这意味着：
- 同一套 niu_fsm + slv_adapter RTL 可以在任何规模的 NoC 中复用
- 节点的增减是 Hub 级别的配置变更，不是协议变更
- 验证复杂度不随 N 增长

### 6.3 Hub 无状态：没有单点故障

Hub（subhub）是纯组合逻辑，没有寄存器，没有时钟。它不可能"卡住"或"进入错误状态"。任何故障都只能来自端节点，而端节点的故障范围被 OR/AND 归约自然隔离：

- 一个节点卡住不响应：`req_and` 为 0，系统停留在 ACT/DEACT 等待（不会误切换）
- 一个节点错误地 assert deny：系统安全回退到 RUN（保守策略）

### 6.4 天然的"最慢者等待"语义

`req_and` 归约的语义是"所有人都完成"。这意味着系统自动等待最慢的节点，不需要额外的超时/重试机制（Level 1 的 timeout 是为了"放弃等待"，而不是"等待超时后重试"）。

### 6.5 两阶段提供安全/不可逆操作分离

类比分布式系统的 Two-Phase Commit (2PC)：
- **Phase 1 (Prepare)**：所有参与者投票 YES/NO（对应 STG1 的 assert/deny）
- **Phase 2 (Commit)**：协调者看到全部 YES 后发起 commit（对应 STG2 的 assert）

这是一个经过充分验证的协议模式，提供了原子性保证：要么所有节点完成切换，要么所有节点回退。

### 6.6 slv_wrapper 的复用架构

所有 TNIU 类型（async_bridge、func_tniu、func_iniu、default_slv、stall_logic、dummy_mst）共享完全相同的 `slv_wrapper`（niu_fsm + slv_adapter）。TNIU 的差异仅在于对 `mst_stg1_req/cmd/stg2_req` 的响应逻辑。

这意味着：
- 分布式协议的复杂性被封装在 niu_fsm + slv_adapter 中，只需验证一次
- 新增 TNIU 类型只需实现简单的 req/ack 响应逻辑
- Bug 修复和协议演进只需修改 slv_wrapper，所有 TNIU 自动受益

### 6.7 CDC 天然友好

LP 信号本质上是**准静态的**——它们只在功耗状态切换时变化（ms 级别的间隔），远低于时钟频率（ns 级别）。这使得简单的多级同步器（3-stage sync cell）即可可靠处理 CDC，不需要异步 FIFO 或握手协议。

每个 niu_fsm 内置了 CDC 同步，Hub 本身是纯组合逻辑不涉及 CDC。不同时钟域的节点可以直接挂在同一个 Hub 上，同步开销 = 每侧 3 拍延迟，对于 ms 级别的功耗切换操作完全可以接受。

### 6.8 Nest 实现层次化功耗域

Nest 模块使得一个 Hub 的端口可以连接到另一个 Hub，形成层次结构。关键设计点：

- 主域的 STG1 **绕过**子域（Nest 在主域 STG1 完成时才启动子域的 STG1+STG2）
- 子域的 STG1+STG2 映射到主域的 STG2 阶段

这保证了层次间的有序性：主域先稳定，子域再操作。Nest 是系统可组合性的关键——任意复杂的 NoC 拓扑都可以通过 Hub + Nest 层次化构建。

---

## 7. 与 ARM Q-channel / P-channel 的关系

本系统的 P-channel 接口（preq/pstate/paccept/pdeny/pactive）遵循 ARM 低功耗接口标准。但在 NoC 内部，它并不使用标准的 Q-channel 点对点握手，而是创造了自己的分布式协议。

| 维度 | ARM Q-channel 标准方案 | 本系统 |
|------|----------------------|--------|
| 拓扑 | 每对主从一条 Q-channel | 一个 Hub + N 条 LP 信号 |
| 协调 | 集中式 power controller 逐个控制 | Hub 自动归约，无需中心控制 |
| 线数 | O(N) 条独立 Q-channel | O(N) 条到 Hub 的 LP 信号（但协议统一） |
| 扩展性 | 每增加一个模块需要修改 controller | 只需增加 Hub 端口 |
| deny | 逐模块独立 deny | 全局原子 deny（一个 deny 则全部回退） |

---

## 8. 总结

### 核心机制

本系统用 OR/AND 双轨归约实现了一个**硬件级的分布式 Barrier**，通过纯组合逻辑的 Hub 完成 N 个节点的全局共识。两阶段握手（STG1 可协商 + STG2 不可逆）提供了类似 2PC 的原子性保证。

### 最突出的优势

1. 协议复杂度 O(1)，不随节点数增长
2. Hub 无状态，不可能成为故障源
3. slv_wrapper 封装了全部协议复杂性，TNIU 开发只需写 req/ack 逻辑
4. 天然支持跨时钟域（准静态信号 + 3 级同步器）

### 最关键的风险

1. **stg1_fsm DENY 状态自锁**：退出条件检查了自身硬编码为 1 的 deny_or 输出，导致 DENY 状态不可退出
2. **Level 2/3 无超时保护**：如果目标模块不响应，系统永久挂起
3. **Endpoint 端口未连接**：在 NUM_TERMINAL < 3 配置下，endpoint 的 clk/rst_n 未连接，导致输出 X 污染
