# LWNOC Low-Power Component 设计文档

## 1. 概述

LWNOC Low-Power Component 是一个用于 Network-on-Chip (NoC) 的分布式低功耗管理子系统。它通过 P-channel 接口接收外部电源管理控制器的请求，在 NoC 内部协调所有网络接口单元 (NIU)，实现多级低功耗状态的进入和退出。

核心设计思想：**基于 Hub 的分布式共识协议**。每个 NIU 通过 Hub 互连，利用 OR/AND 归约信号实现全局状态感知，无需点对点连接即可完成所有节点的两阶段握手。

---

## 2. 低功耗等级定义

系统支持 4 个功耗等级，每个等级对 NoC 各功能模块施加不同程度的约束：

| 等级 | P-channel 状态 | LP 网络状态 | 对功能模块的影响 |
|------|----------------|------------|-----------------|
| Level 0 | `P_POWER_ON` (2'd0) | `LP_LEVEL0_NOP` (3'b000) | 正常运行，无约束 |
| Level 1 | `P_LEVEL1_OFF` (2'd1) | `LP_LEVEL1_OFF` (3'b001) | 条件性 stall —— 仅当总线空闲时 stall；default slave 启用 soft_switch |
| Level 2 | `P_LEVEL2_OFF` (2'd2) | `LP_LEVEL2_OFF` (3'b010) | 强制 stall；default slave 启用 hard_switch |
| Level 3 | `P_LEVEL3_OFF` (2'd3) | `LP_LEVEL3_OFF` (3'b100) | 强制 stall + partial_reset；default slave 启用 hard_switch |

各 TNIU 类型在不同等级下的具体行为：

| 模块类型 | Level 1 | Level 2 | Level 3 |
|---------|---------|---------|---------|
| async_bridge | stall_ptr=1 | stall_ptr=1 | stall_ptr=1 |
| func_tniu | 无特殊操作 | 无特殊操作 | partial_reset=1 |
| func_iniu | stall=trans_idle | stall=1 | stall=1, partial_reset=1 |
| default_slv | soft_switch=trans_idle | hard_switch=1 | hard_switch=1 |
| stall_logic | stall=trans_idle | stall=1 | stall=1 |
| dummy_mst | hard_switch=1 | hard_switch=1 | hard_switch=1 |

---

## 3. 整体架构

### 3.1 系统拓扑

```
                          P-channel Master (外部电源控制器)
                               |
                          preq/pstate/paccept/pdeny
                               |
                         +----------+
                         |   INIU   |  (clk_sys)
                         +----+-----+
                              |
               +--------------+------ LP req_signal_t --------+
               |              |              |                 |
         +-----+-----+  +----+-----+  +-----+----+     +-----+-----+
         | main_hub[0]| |main_hub[1]| |main_hub[2]|     |main_hub[4]|
         +-----+------+ +----+-----+  +-----+----+     +-----+-----+
               |              |              |                 |
            [INIU]     [default_slv]   [func_tniu]      [stall_logic]

                              +--- main_hub[3] ---+
                              |                   |
                         +----+----+              |
                         |  NEST   |              |
                         +----+----+              |
                              |                   |
               +--------------+--- LP req (sub) --+
               |              |              |                |
         +-----+-----+ +-----+----+  +------+-----+  +------+-----+
         |sub_hub[0]  | |sub_hub[1]| |sub_hub[2]   | |sub_hub[3]   |
         +-----+------+ +----+----+  +------+-----+  +------+-----+
               |              |              |               |
       [ab_src_sys]    [ab_dst_sys]   [ab_dst_noc]    [ab_src_noc]
        (clk_sys)       (clk_sys)      (clk_noc)       (clk_noc)

                              +--- sub_hub[4] ---+
                              |                  |
                         +----+----+
                         |  NEST   | (sub side)
                         +---------+
```

### 3.2 信号总线 `lwnoc_lp_req_signal_t`

所有模块之间通过统一的结构体信号通信：

```
typedef struct packed {
    logic            stg1_req_or;   // Stage 1 请求 —— OR 归约
    logic            stg1_req_and;  // Stage 1 请求 —— AND 归约
    logic            stg2_req_or;   // Stage 2 请求 —— OR 归约
    logic            stg2_req_and;  // Stage 2 请求 —— AND 归约
    lwnoc_lp_state_t state;         // 目标功耗状态 (3-bit one-hot)
    logic            deny_and;      // 拒绝信号 —— AND 归约
    logic            deny_or;       // 拒绝信号 —— OR 归约
} lwnoc_lp_req_signal_t;
```

**OR/AND 双轨设计原理**：每个端节点将 `req_or` 和 `req_and` 置为相同的值（自身的 req 状态）。Hub 对所有输入执行 OR 和 AND 归约后发送给每个终端。任一终端观察到的 Hub 输出含义：
- `req_or = 1`：至少有一个节点已经 assert
- `req_and = 1`：所有节点都已经 assert
- `req_or = 0`：没有任何节点 assert
- 通过这两个信号，每个节点无需知道其他节点的个数和身份，即可判断全局共识状态

---

## 4. 两阶段握手协议 (Two-Stage Handshake)

### 4.1 协议总览

每次功耗状态切换（无论是 power-down 还是 power-up）都经历两个阶段：

- **Stage 1 (STG1)**：协调阶段 —— 通知所有节点准备切换，等待确认或拒绝
- **Stage 2 (STG2)**：执行阶段 —— 所有节点已同意，执行最终操作（如清除指针）

### 4.2 Power-Down 序列 (以 Level 1 OFF 为例)

```
时间轴 →

P-channel:     preq=1, pstate=P_LEVEL1_OFF
                   |
                   v
INIU pchn_niu: LP_PCH_STOP → LP_PCH_DEACT_STG1
               assert stg1_req=0 (释放), 设置 state=LP_LEVEL1_OFF
                   |
                   v  (通过 Hub 广播到所有 TNIU)

各 TNIU slv_adapter: 检测 stg1_req 下降沿
               → LP_SLV_FSM_REQ_OFF
               → 向功能模块发送 mst_cmd=LP_SLV_CMD_LEVEL1_OFF
               → 等待 mst_stg1_ack (需要 trans_idle=1)
               → 确认后释放 tx_stg1_req=0
                   |
STG1 FSM:      所有节点 stg1_req_and=0 && stg1_req_or=0
               → STG1 完成，进入 DEACT 状态
                   |
                   v
STG2 开始:     INIU 释放 stg2_req=0
               各 TNIU 检测 stg2_req 下降沿
               → 执行 Stage 2 操作（如 async_bridge 的 clear_ptr）
               → 确认后释放 tx_stg2_req=0
                   |
STG2 FSM:      所有节点 stg2_req_and=0 && stg2_req_or=0
               → 完成
                   |
                   v
INIU pchn_niu: LP_PCH_STOP → paccept=1
P-channel:     主机看到 paccept, 释放 preq=0
```

### 4.3 Power-Up 序列

```
P-channel:     preq=1, pstate=P_POWER_ON
                   |
                   v
INIU pchn_niu: LP_PCH_STOP → LP_PCH_ACT_STG1
               assert stg1_req=1, state=LP_LEVEL0_NOP
                   |
                   v  (Hub 广播)

各 TNIU slv_adapter: 检测 stg1_req 上升沿
               → LP_SLV_FSM_REQ_ON
               → 向功能模块发送 mst_cmd=LP_SLV_CMD_ON
               → 等待 mst_stg1_ack
               → 确认后 assert tx_stg1_req=1
                   |
STG1 FSM:      stg1_req_and=1 (所有节点已 assert)
               → STG1 完成
                   |
                   v
STG2 开始:     各节点 assert stg2_req=1
               → 等待 stg2_req_and=1
               → STG2 完成
                   |
                   v
INIU pchn_niu: LP_PCH_RUN → paccept=1
P-channel:     完成 power-up
```

### 4.4 Deny 机制

Deny 发生在 power-down 的 STG1 阶段。当某个 TNIU 的 `slv_adapter` 在 `LP_SLV_FSM_REQ_OFF` 状态等待 `mst_stg1_ack` 超时时：

```
slv_adapter: timeout_cnt 递减至 0
             → timeout_flag=1
             → 进入 LP_SLV_FSM_REVERT
             → tx_stg1_deny=1, tx_stg1_req 恢复到之前的值
             → mst_cmd 恢复为 LP_SLV_CMD_ON（撤销关断命令）
                |
                v  (deny 通过 Hub 传播)

STG1 FSM:   检测到 deny_or=1
             → LP_STG1_DENY 状态
             → 通知所有内部节点 deny

各节点:      恢复到 power-on 状态
             deny 清除后 → 回到 LP_STG1_RUN

INIU pchn_niu: LP_PCH_DENY → pdeny=1
P-channel:     deny 返回给主机
```

**注意**：Timeout 仅在 Level 1 OFF 时触发（`conv_cmd == LP_SLV_CMD_LEVEL1_OFF`），且需要配置 `HAS_TIME_OUT=1`。

### 4.5 主从模式 (master_mode)

`stg1_fsm` 维护一个 `master_mode` 标志，用于区分当前节点是发起方还是响应方：

- **master_mode=1**：本节点（或本节点侧）发起了本次 LP 操作
  - ACT 阶段等待 `rx_req.stg1_req_and`（等所有外部节点 assert）
  - DEACT 阶段观察 `rx_req.stg1_req_or`（等最后一个外部节点 deassert）
- **master_mode=0**：本节点是响应方
  - ACT 阶段直接标记 `internal_tx_stg1_req=1`
  - DEACT 阶段直接标记 `internal_tx_stg1_req=0`

这确保了发起方会等待所有响应方完成，而响应方直接跟随。

---

## 5. 模块详细设计

### 5.1 Hub 子系统 (`lp_hub/`)

#### 5.1.1 `lwnoc_lp_subhub`

Hub 的最小构建单元。接收 2 个 peer 的 `lwnoc_lp_req_signal_t`，输出 1 个聚合结果：

```
tx_req.stg1_req_or  = peer[0].stg1_req_or  | peer[1].stg1_req_or
tx_req.stg1_req_and = peer[0].stg1_req_and & peer[1].stg1_req_and
tx_req.stg2_req_or  = peer[0].stg2_req_or  | peer[1].stg2_req_or
tx_req.stg2_req_and = peer[0].stg2_req_and & peer[1].stg2_req_and
tx_req.deny_or      = peer[0].deny_or      | peer[1].deny_or
tx_req.deny_and     = peer[0].deny_and     & peer[1].deny_and
tx_req.state        = peer[0].state        | peer[1].state
```

纯组合逻辑，无时钟。`state` 使用 OR 聚合是因为 one-hot 编码下 OR 操作可以传播任何非零状态。

#### 5.1.2 `lwnoc_lp_hub_3terminal`

基础 3 端口 Hub。为每个终端 i 创建一个 subhub，该 subhub 的输入是其余两个终端的 `rx_req`：

```
terminal[i] 的 subhub 输入 = { terminal[(i+1)%3], terminal[(i+2)%3] }
```

每个终端看到的是其他所有终端信号的 OR/AND 聚合，这是实现分布式共识的关键。

#### 5.1.3 Hub 尺寸变体

`hub_wrapper` 根据 `NUM_TERMINAL` 参数自动选择拓扑：

**Tiny (NUM_TERMINAL <= 3)**：单个 `hub_3terminal`，未使用的端口由 `endpoint` 终结。

**Small (NUM_TERMINAL = 4)**：两个 `hub_3terminal` 级联，各暴露 2 个端口，第 3 个端口用于级联互连：
```
HUB[0].t0 → IF[0]    HUB[1].t0 → IF[2]
HUB[0].t1 → IF[1]    HUB[1].t1 → IF[3]
HUB[0].t2 ←→ HUB[1].t2  (级联)
```

**Large (NUM_TERMINAL >= 5)**：链式级联拓扑：
- Head hub：暴露 t0, t1，t2 级联到下一个
- Internal hub(s)：暴露 t1，t0/t2 用于上下级联
- Tail hub：t0 接最后一个级联，暴露 t1, t2
- Internal hub 数量 = NUM_TERMINAL - 4

### 5.2 FSM 子系统 (`lp_common/lp_fsm/`)

#### 5.2.1 `lwnoc_lp_niu_fsm`

每个 NIU（INIU 或 TNIU）的顶层 FSM 封装，包含：

1. **RX 侧 CDC 同步**：通过 `fcip_sync_cell`（3 级同步器）同步输入的 `rx_req`
2. **TX 侧 CDC Marker**：通过 `fcip_marker` 标记输出的 `tx_req`，用于 CDC 验证
3. **STG1 FSM** 实例
4. **STG2 FSM** 实例
5. **信号组装**：将 STG1 的 `stg1_req_or/and, state, deny_or/and` 与 STG2 的 `stg2_req_or/and` 组合成完整的 `tx_req`

内部接口连接 adapter（INIU 侧为 pchn_niu，TNIU 侧为 slv_adapter）。

#### 5.2.2 `lwnoc_lp_stg1_fsm`

Stage 1 状态机，5 个状态：

```
         ┌──────────────────────────────────┐
         │                                  │
         v                                  │
    LP_STG1_STOP ──(any req_or)──> LP_STG1_ACT
                                       │
                              (all req_and)
                                       │
                                       v
    LP_STG1_DENY <──(deny_or)── LP_STG1_DEACT <──(any ~req_and)── LP_STG1_RUN
         │                         │
         │               (all ~req_or)
         │                         │
         │                         v
         │                    LP_STG1_STOP
         │
         └──(deny cleared && all req_and)──> LP_STG1_RUN
```

**STOP → ACT**：检测到 `rx_req.stg1_req_or`（外部触发）或 `tx_req.stg1_req_or`（内部触发）
**ACT → RUN**：`tx_req.stg1_req_and && rx_req.stg1_req_and`（所有节点已就绪）
**RUN → DEACT**：任一方 `~stg1_req_and`
**DEACT → STOP**：所有方 `~stg1_req_or`
**DEACT → DENY**：检测到 `deny_or`
**DENY → RUN**：deny 清除且所有节点重新 assert `req_and`

关键输出逻辑（面向内部 adapter 的简化信号）：
- **STOP**：`internal_tx_stg1_req = rx_req.stg1_req_or`（任一外部触发即通知 adapter）
- **ACT**：master_mode 时等 `rx_req.stg1_req_and`，否则直接传 1
- **RUN**：`internal_tx_stg1_req = rx_req.stg1_req_and`（任一释放即通知 adapter）
- **DEACT**：master_mode 时观察 `rx_req.stg1_req_or`，否则传 0
- **DENY**：强制 `internal_tx_stg1_req = 1`，恢复上电状态

#### 5.2.3 `lwnoc_lp_stg2_fsm`

Stage 2 状态机，4 个状态（无 deny 能力）：

```
    LP_STG2_STOP ──(stg1 finished: all stg1_req_and)──> LP_STG2_ACT
                                                            │
                                                  (all stg2_req_and)
                                                            │
                                                            v
    LP_STG2_STOP <──(all ~stg2_req_or)── LP_STG2_DEACT <──(all ~stg1_req_or)── LP_STG2_RUN
```

STG2 FSM 的启动条件依赖 STG1 完成（`stg1_tx_req.stg1_req_and && rx_req.stg1_req_and`）。STG2 本身不支持 deny，一旦进入 STG2 阶段，操作将执行到底。

### 5.3 Slave Adapter (`lp_common/lwnoc_lp_slv_adapter`)

将 LP 网络侧的 `stg1_req/stg2_req/deny/state` 信号转化为面向功能模块的简单 req/ack 握手协议。每个 TNIU 都通过此 adapter 与其功能逻辑交互。

#### 接口

- **LP 网络侧**：`rx_stg1_req`, `rx_state`, `rx_stg1_deny`, `rx_stg2_req`（输入），`tx_stg1_req`, `tx_state`, `tx_stg1_deny`, `tx_stg2_req`（输出）
- **功能模块侧**：`mst_stg1_req/ack`, `mst_stg2_req/ack`, `mst_cmd`

#### 内部 FSM

STG1 和 STG2 各有独立的 4 状态 FSM：

```
LP_SLV_FSM_IDLE ──(req_rise)──> LP_SLV_FSM_REQ_ON ──(ack)──> IDLE
     │
     └──(req_fall)──> LP_SLV_FSM_REQ_OFF ──(ack)──> IDLE
                            │
                      (timeout | deny)
                            │
                            v
                     LP_SLV_FSM_REVERT ──(deny && req restored)──> IDLE
```

#### 命令转换

根据 `rx_stg1_req` 和 `rx_state` 生成 `mst_cmd`：
- `rx_stg1_req=1` → `LP_SLV_CMD_ON`（上电）
- `rx_stg1_req=0` + `state=LP_LEVEL1_OFF` → `LP_SLV_CMD_LEVEL1_OFF`
- `rx_stg1_req=0` + `state=LP_LEVEL2_OFF` → `LP_SLV_CMD_LEVEL2_OFF`
- `rx_stg1_req=0` + `state=LP_LEVEL3_OFF` → `LP_SLV_CMD_LEVEL3_OFF`

#### Timeout 逻辑

可配参数 `HAS_TIME_OUT` 和 `TIME_OUT_WIDTH`：
- 仅在 `stg1_fsm_state == LP_SLV_FSM_REQ_OFF` 且 `conv_cmd == LP_SLV_CMD_LEVEL1_OFF` 时递减计数器
- 计数器归零触发 `timeout_flag`，导致 FSM 进入 REVERT
- REVERT 状态：恢复 `tx_stg1_req` 到之前的值，assert `tx_stg1_deny=1`，并向功能模块发送 `LP_SLV_CMD_ON` 撤销关断

### 5.4 `lwnoc_lp_slv_wrapper`

将 `niu_fsm` 和 `slv_adapter` 组合为一个可复用的构建块。所有 TNIU 类型都基于此 wrapper 实现。

内部连接关系（注意交叉连接）：
```
niu_fsm.internal_tx_* ──> slv_adapter.rx_*
slv_adapter.tx_*      ──> niu_fsm.internal_rx_*
```

即 niu_fsm 的内部输出是 adapter 的输入，反之亦然。这形成了一个反馈环路，使 FSM 能感知 adapter 的确认状态。

### 5.5 `lwnoc_lp_endpoint`

用于终结 Hub 未使用的端口。作为"回声模块"，将收到的 LP 信号反射回去。

关键行为根据 `power_on_seq` 标志区分：
- **power_on_seq=1**（上电过程中）：将 `rx_req_sync.stg1_req_or` 同时赋给 `tx.stg1_req_or` 和 `tx.stg1_req_and`，表示"如果有任何请求，则本端点同意"
- **power_on_seq=0**（下电过程中）：如果检测到 `deny_or`，则清零 stg1_req，传播 deny；否则跟随 `stg1_req_and`

`power_on_seq` 切换条件：
- 所有 stg1/stg2 的 req_and 都为 1 → 清除（进入 run 状态）
- 所有 stg1/stg2 的 req_or 都为 0 → 置位（回到 idle 状态）

### 5.6 `lwnoc_lp_nest`

用于隔离子域（sub domain）和主域（main domain）的 LP 控制。设计核心：**主域的 STG1 绕过子域，子域通过自己的 STG1+STG2 与主域的 STG2 握手**。

内部维护一个 `lp_state_sub_domain` 状态机，6 个状态：

**Power-up 路径**：
```
STOP → (主域 stg1_req_and 完成) → ACT_STG1 → (子域 stg1_req_and 完成) → ACT_STG2 → (子域 stg2_req_and 完成) → RUN
```

**Power-down 路径**：
```
RUN → (主域 ~stg1_req_or) → DEACT_STG1 → (子域 ~stg1_req_or) → DEACT_STG2 → (子域 ~stg2_req_or) → STOP
```

信号映射逻辑：
- **对主域**：在 ACT_STG1/ACT_STG2 期间，持续 assert `stg1_req=1`（表示本端已就绪），当子域完成后释放 `stg2_req`
- **对子域**：在不同阶段注入或清除 `stg1_req` 和 `stg2_req`，驱动子域的独立握手流程

### 5.7 INIU 子系统 (`lp_iniu/`)

#### 5.7.1 `lwnoc_lp_iniu`

INIU 顶层模块，组合 `niu_fsm` 和 `pchn_niu`：

```
P-channel ←→ pchn_niu ←→ (internal signals) ←→ niu_fsm ←→ LP Network (Hub)
```

连接方式同 slv_wrapper，采用交叉连接：`niu_fsm.internal_tx_* → pchn_niu.rx_*`。

#### 5.7.2 `lwnoc_lp_pchn_niu`

P-channel slave，将 AMBA P-channel 协议转换为 LP 内部协议。7 个状态：

```
LP_PCH_STOP ──(preq+POWER_ON 或 外部 rx_stg1_req)──> LP_PCH_ACT_STG1
    ^                                                       │
    │                                           (stg1_all: rx && tx)
    │                                                       v
    │                                                LP_PCH_ACT_STG2
    │                                                       │
    │                                           (stg2_all: rx && tx)
    │                                                       v
    │                                                 LP_PCH_RUN
    │                                                       │
    │                                           (preq+OFF 或 ~rx_stg1_req)
    │                                                       v
    │          LP_PCH_DENY <──(deny_any)── LP_PCH_DEACT_STG1
    │               │                              │
    │         (~deny_any)                    (~stg1_any)
    │               │                              v
    │               └──> LP_PCH_RUN        LP_PCH_DEACT_STG2
    │                                              │
    │                                        (~stg2_any)
    └──────────────────────────────────────────────┘
```

**LP 网络输出**：
- `tx_stg1_req`：在 ACT_STG1, ACT_STG2, RUN 状态 assert
- `tx_stg2_req`：在 ACT_STG2, RUN, DEACT_STG1 状态 assert
- `tx_state`：ACT 路径传 `target_lp_state_latched`，RUN 传 NOP，DEACT 传 target，其他跟随 `rx_state`

**P-channel 输出**：
- `paccept`：上电请求到达 RUN 或下电请求到达 STOP 时 assert
- `pdeny`：进入 DENY 状态时 assert
- `pactive`：RUN 状态为 `P_ON`，STOP 状态为 `P_OFF`

**请求方向记录**：通过 `dir_up` 标志记录当前操作方向（上电/下电），仅在 stable point（STOP 或 RUN）且 `preq_rise` 时锁存。

### 5.8 TNIU 子系统 (`lp_tniu/`)

所有 TNIU 模块共享相同的架构模式：内部实例化 `slv_wrapper`，将其 `mst_stg1_req/ack/cmd` 和 `mst_stg2_req/ack` 接口映射到各自的功能控制逻辑。

#### 5.8.1 `lwnoc_lp_tniu_async_bridge`

用于异步时钟域桥接。

- **STG1 动作**：根据 `mst_cmd` 控制 `stall_ptr`（ON→释放，OFFx→stall），ack 条件为 `trans_idle`
- **STG2 动作**：根据 `mst_cmd` 控制 `clear_ptr`（ON→释放，OFFx→clear），ack 条件为 `full_zero`
- **Timeout**：禁用 (`HAS_TIME_OUT=0`)，异步桥不支持 deny

Reset 默认值：`stall_ptr=1, clear_ptr=1`（默认阻塞）。

#### 5.8.2 `lwnoc_lp_tniu_func_tniu`

用于功能 TNIU（目标网络接口单元）。

- **STG1 动作**：控制 `partial_reset`（仅 Level 3 时 assert），ack 条件为 `trans_idle`
- **STG2 动作**：无实际操作，直接 ack（`mst_stg2_ack <= mst_stg2_req`）
- **Timeout**：可配置

#### 5.8.3 `lwnoc_lp_tniu_func_iniu`

用于功能 INIU（发起网络接口单元）。

- **STG1 动作**：控制 `stall` 和 `partial_reset`
  - Level 1：`stall = trans_idle`（条件性 stall）
  - Level 2：`stall = 1`（强制 stall）
  - Level 3：`stall = 1, partial_reset = 1`
  - ON：全部释放
- **STG2 动作**：无实际操作，直接 ack
- **Timeout**：可配置
- Reset 默认值：`stall=1`（默认阻塞）

#### 5.8.4 `lwnoc_lp_tniu_default_slv`

用于 default slave（缺省从设备）。

- **STG1 动作**：控制 `hard_switch` 和 `soft_switch`
  - Level 1：`soft_switch = trans_idle`（条件性切换）
  - Level 2/3：`hard_switch = 1`（强制切换）
  - ON：全部释放
- **ACK 条件**：`switch_done && trans_idle`，需要功能模块确认切换完成
- **STG2 动作**：无实际操作，直接 ack
- **Timeout**：可配置
- Reset 默认值：`hard_switch=1, soft_switch=1`

#### 5.8.5 `lwnoc_lp_tniu_stall_logic`

用于 stall 控制逻辑。

- **STG1 动作**：控制 `stall`
  - Level 1：`stall = trans_idle`
  - Level 2/3：`stall = 1`
  - ON：`stall = 0`
- **ACK 条件**：`trans_idle`
- **STG2 动作**：无实际操作
- Reset 默认值：`stall=1`

#### 5.8.6 `lwnoc_lp_tniu_dummy_mst`

用于虚拟主设备。

- **STG1 动作**：控制 `hard_switch`（任意 OFF level 都 assert）
- **ACK 条件**：`switch_done`
- **STG2 动作**：无实际操作
- Reset 默认值：`hard_switch=1`

---

## 6. CDC 处理策略

系统中存在两类时钟域（`clk_sys` 和 `clk_noc`），CDC 处理策略：

1. **`niu_fsm` 内部**：所有 `rx_req` 输入经过 3 级 `fcip_sync_cell` 同步，所有 `tx_req` 输出经过 `fcip_marker` 标记（供 CDC 工具检查）
2. **`endpoint` 内部**：同上，独立的 sync_cell + marker
3. **`nest` 内部**：main 侧和 sub 侧的 `rx_req` 各有独立的 sync_cell
4. **Hub**：纯组合逻辑，不做 CDC 处理（Hub 两侧的时钟域由端节点负责同步）

LP 信号本身是准静态的（变化频率远低于时钟频率），3 级同步器足以保证可靠采样。

---

## 7. DUT 集成示例

当前验证 DUT 展示了一个典型的双域拓扑：

- **Main Hub**（5 端口）：连接 INIU、default_slv、func_tniu、nest（主域侧）、stall_logic
- **Sub Hub**（5 端口）：连接 4 个 async_bridge（2 个 sys 侧 + 2 个 noc 侧）、nest（子域侧）
- **Nest** 桥接 main hub 和 sub hub，实现主域/子域隔离

```
Main Hub 端口映射:
  [0] ←→ INIU           (clk_sys)
  [1] ←→ default_slv    (clk_noc)
  [2] ←→ func_tniu      (clk_noc)
  [3] ←→ nest (main)    (clk_sys)
  [4] ←→ stall_logic    (clk_noc)

Sub Hub 端口映射:
  [0] ←→ ab_src_sys     (clk_sys)
  [1] ←→ ab_dst_sys     (clk_sys)
  [2] ←→ ab_dst_noc     (clk_noc)
  [3] ←→ ab_src_noc     (clk_noc)
  [4] ←→ nest (sub)     (clk_sys)
```
