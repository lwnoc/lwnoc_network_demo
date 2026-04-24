# STS NoC 路由架构

Date: 2026-04-03

---

## 1. 通用路由框架

### 1.1 参数化拓扑

STS NoC 采用 **INIU → dec_node → TNIU** 三级路由架构，所有路由逻辑均为纯 base/mask 参数化比较，无硬编码位域。RTL 中 `TGT_TYPE_WIDTH` / `LOCAL_APB_TGT_TYPE` 是死代码（声明但未使用于任何逻辑）。

```
                      AXI Slave
                         │
                    ┌────┴────┐
                    │  INIU   │   addr_map: AXI addr → tgt_id
                    │(addr_map)│  E entries, page-aligned
                    └────┬────┘
                         │ sts_req/rsp (tgt_id[W-1:0] in payload)
                         │
                  ┌──────┴──────┐
                  │  dec_node   │  1→T 路由节点
                  │ base/mask   │  ROUTE_BASE[T] / ROUTE_MASK[T]
                  └─┬────┬──┬──┘
                    │    │  │
              ┌─────┘    │  └─────┐
              │          │        │
         ┌────┴───┐ ┌───┴──┐ ┌──┴─────┐
         │ TNIU_0 │ │ ...  │ │TNIU_T-1│
         └───┬────┘ └──────┘ └───┬────┘
             │                    │
         ┌───┴───┐           ┌───┴───┐
         │local  │           │local  │    TNIU 内部 local apb_dec
         │apb_dec│           │apb_dec│    tgt_id 精确匹配 → L 个本地子目标
         └┬──┬─┬─┘           └┬──┬─┬─┘
          │  │ ...            │  │ ...    regbank / RSC / ...
          │  │                │  │
         CDC CDC             CDC CDC     async FIFO (NOC→SYS 跨时钟)
          │  │                │  │
       ┌──┴──┴──┐         ┌──┴──┴──┐
       │sys     │         │sys     │     TNIU 内部 sys apb_dec
       │apb_dec │         │apb_dec │     tgt_id base/mask → S 个 sys slave
       └┬──┬──┬─┘         └┬──┬──┬─┘
        │  │  ...           │  │  ...    stub slaves (SYS 侧)
```

### 1.2 三级路由链原理

| 级别 | 模块 | 功能 | 匹配方式 |
|------|------|------|---------|
| **Level 1** | INIU addr_map | AXI 地址 → tgt_id | base/mask 地址窗口，优先级匹配 |
| **Level 2** | dec_node | tgt_id → TNIU 选择 | `(tgt_id & MASK) == (BASE & MASK)` |
| **Level 3a** | local apb_dec | tgt_id → regbank/RSC | 精确匹配 (MASK=0xFF) |
| **Level 3b** | sys apb_dec | tgt_id → sys APB slaves | 精确匹配 (MASK=0xFF) |

dec_node 对无命中的 tgt_id 自动生成 DECERR 响应，该路径作为独立仲裁输入参与 round-robin，与正常 slave 响应公平竞争，不阻塞正常响应通道。

---

## 2. 通用公式

以下公式适用于任意 TNIU 数量 $T$、每 TNIU 本地子目标数 $L$、sys 子目标数 $S$ 的配置。

### 2.1 符号定义

| 符号 | 含义 |
|------|------|
| $W$ | `TGT_ID_WIDTH`（bit 位宽） |
| $T$ | TNIU 数量 |
| $L$ | 每 TNIU 的 local 子目标数（regbank + RSC 等） |
| $S$ | 每 TNIU 的 sys 侧 APB slave 数 |
| $n$ | TNIU 索引，$0 \le n < T$ |
| $\text{BASE\_LOCAL}$ | local type 基地址 |
| $\text{BASE\_SYS}$ | sys type 基地址 |
| $M$ | $\lceil \log_2(\max(L, S)) \rceil$ — sub_sel 位数 |
| $N$ | $\lceil \log_2(T) \rceil$ — tniu_sel 位数 |
| $P$ | type 位数（区分 local / sys / 扩展类型） |
| $\Delta$ | $2^M$ — 相邻 TNIU 的 tgt_id 步进 |
| $D$ | $\text{BASE\_SYS} \oplus \text{BASE\_LOCAL}$ — type 差异掩码 |

### 2.2 tgt_id 位域通用格式

```
tgt_id[W-1:0] = { reserved[W-1 : P+N+M], type[P+N+M-1 : N+M], tniu_sel[N+M-1 : M], sub_sel[M-1 : 0] }
```

**位宽约束**: $P + N + M \le W$，否则需增大 `TGT_ID_WIDTH`。

### 2.3 tgt_id 分配公式

$$\text{tgt\_id\_local}(n, j) = \text{BASE\_LOCAL} + n \times \Delta + j \quad (0 \le j < L)$$

$$\text{tgt\_id\_sys}(n, j) = \text{BASE\_SYS} + n \times \Delta + j \quad (0 \le j < S)$$

### 2.4 INIU addr_map 参数公式

$$\text{ADDR\_MAP\_ENTRY\_NUM} = T \times (L + S)$$

每个 entry 的 tgt_id 用 §2.3 公式生成。地址窗口按需分配（按页对齐）。

$$\text{ADDR\_MAP\_MASK\_TABLE}[i] = \sim(\text{PAGE\_SIZE} - 1)$$

### 2.5 dec_node 参数公式

$$\text{SLAVE\_NUM} = T$$

$$\text{ROUTE\_BASE}[n] = \text{BASE\_LOCAL} + n \times \Delta$$

$$\text{ROUTE\_MASK} = \sim\bigl((2^M - 1) \mid D\bigr) \;\&\; (2^W - 1)$$

含义：MASK 将 sub_sel 位（$2^M - 1$）和 type 差异位（$D$）置 0，其余为 1。

### 2.6 TNIU 内部 apb_dec 参数公式

**Local apb_dec** (精确匹配):

$$\text{ROUTE\_BASE\_LOCAL}(n) = \bigl\{ \text{tgt\_id\_local}(n, L-1),\; \ldots,\; \text{tgt\_id\_local}(n, 0) \bigr\}$$

$$\text{ROUTE\_MASK\_LOCAL} = \{0\text{xFF}, \ldots, 0\text{xFF}\} \quad (L \text{ 个})$$

**Sys apb_dec** (精确匹配):

$$\text{SYS\_APB\_ROUTE\_BASE}(n) = \bigl\{ \text{tgt\_id\_sys}(n, S-1),\; \ldots,\; \text{tgt\_id\_sys}(n, 0) \bigr\}$$

$$\text{SYS\_APB\_ROUTE\_MASK} = \{0\text{xFF}, \ldots, 0\text{xFF}\} \quad (S \text{ 个})$$

### 2.7 容量上限公式

| 维度 | 最大值 | 公式 |
|------|--------|------|
| TNIU 数量 $T_{\max}$ | $2^N$ | 受 $P+N+M \le W$ 约束 |
| 每 TNIU 子目标 | $2^M$ | $M = \lceil \log_2(\max(L,S)) \rceil$ |
| 总 tgt_id 数 | $2^{N+M} \times \text{type 种类数}$ | |
| addr_map entries | $T \times (L+S)$ | 每个 tgt_id 一条 |

当 $P+N+M > W$ 时需增大 `TGT_ID_WIDTH`。

---

## 3. 约束与配置规则

### 3.1 tgt_id 编码约束

1. **同一 TNIU 的所有 tgt_id 在 dec_node MASK 后必须映射到相同值**: $\text{tgt\_id}(n, j) \;\&\; \text{MASK} = \text{BASE}(n) \;\&\; \text{MASK}$，对该 TNIU 的所有 $j$ 成立。
2. **不同 TNIU 的 tgt_id 在 MASK 后必须不同**——否则 dec_node 的 hit 会多选。
3. **TNIU 内部的子目标区分靠 `sub_sel` 低 $M$ 位**，这些位被 dec_node MASK 屏蔽、在 TNIU 内部 apb_dec 精确匹配。
4. 编码不依赖固定前缀——RTL 全参数化，tgt_id 可从 0x00 起编（见 §4）。

### 3.2 INIU addr_map 约束

1. **每个 tgt_id 至少映射一个地址窗口**，否则该目标不可达。
2. **地址窗口不得重叠**——INIU addr_map 是优先级匹配，重叠会导致低优先级条目不可达。
3. **default tgt_id** 用于地址 miss → dec_node 无命中 → 自动 DECERR 响应。

### 3.3 dec_node base/mask 约束

1. **ROUTE_MASK** = $\sim((2^M - 1) \mid D)$，其中 $D = \text{BASE\_SYS} \oplus \text{BASE\_LOCAL}$。
2. **ROUTE_BASE[n]** = 该 TNIU 的第一个 tgt_id（$j=0$），即 $\text{BASE\_LOCAL} + n \times 2^M$。
3. **SLAVE_NUM = TNIU 数量**。
4. **slot 顺序必须与物理连接匹配**: slot[0] → TNIU0, slot[1] → TNIU1, ...
5. 所有 slot 的 MASK 相同（flat 拓扑下）。多级树拓扑下各级 MASK 不同（见 §4.4）。

### 3.4 TNIU 内部 apb_dec 约束

1. **local apb_dec**: MASK=0xFF 精确匹配。ROUTE_BASE 包含该 TNIU 的 local tgt_id。
2. **sys apb_dec**: MASK=0xFF 精确匹配。SYS_APB_ROUTE_BASE 包含该 TNIU 的 sys tgt_id。
3. **MASTER_NUM** = 该 TNIU 下挂的 APB slave 数量（local: regbank+RSC; sys: 按需配）。

### 3.5 DECERR 响应路径行为

dec_node 对无命中请求（`!hit_any`）就地生成 DECERR 响应，无需转发到任何 slave。

#### 实现方式（RTL）

DECERR 响应作为第 `SLAVE_NUM` 号输入送入同一个 `arb_vrp` round-robin 仲裁器，与正常 slave 响应公平竞争：

```
arb_vrp #(.WIDTH(SLAVE_NUM+1)) u_rsp_arb (
    .v_vld_s  ({decerr_rsp_vld, slv_rsp_vld}),   // [SLAVE_NUM]=DECERR
    .v_rdy_s  (arb_rdy_out),                      // [SLAVE_NUM]=decerr_rsp_rdy
    .v_pld_s  (arb_pld_in),                       // [SLAVE_NUM]=decerr_rsp_pld
    .vld_m    (mst_rsp_vld),
    .rdy_m    (mst_rsp_rdy),
    .pld_m    (arb_rsp_pld_flat)
);
```

#### 关键特性

| 属性 | 说明 |
|------|------|
| 优先级 | Round-robin，与正常 slave 响应公平共享带宽 |
| 阻塞性 | 不会因 DECERR pending 阻塞 `slv_rsp_rdy`（旧 bypass 方案存在此风险） |
| 延迟 | DECERR 可能需等待当前 round-robin 轮次，最多延迟 SLAVE_NUM 个周期 |
| req 侧 | `mst_req_rdy = decerr_rsp_rdy`（无命中时），即等仲裁器授权后才接受下一个 unmapped 请求 |

#### 历史背景：旧 bypass 方案的阻塞风险

早期实现将 DECERR 设为最高优先级 bypass：

```systemverilog
// ❌ 旧方案 — 已废弃
assign arb_rsp_rdy = ~decerr_rsp_vld & mst_rsp_rdy;  // DECERR pending 时锁死所有 slave rsp
```

当同时满足以下条件时会出现永久阻塞：
1. `mst_rsp_rdy = 0`（下游 B/R FIFO 满）
2. `decerr_rsp_vld = 1`（unmapped 地址请求到达）

此时 `arb_rsp_rdy = 0`，所有正常 slave 响应无法发送，整个响应通道死锁（需外部释放背压才能恢复）。

#### 约束

- **不适用多 in-flight unmapped 请求**: 当 `decerr_rsp_rdy=0`（仲裁器未授权）时，`mst_req_rdy=0`，INIU 请求 FIFO 出口被阻塞。多个连续 unmapped 请求需排队，不会出现并发多个 DECERR。
- **AXI 侧**: DECERR 响应的 `bresp=2'b11` / `rresp=2'b11`，符合 AXI DECERR 编码。

---

## 4. 扩展指南

> **核心前提**: RTL 中所有路由逻辑均为纯 base/mask 参数化比较。
> 扩展 **仅需调参数值，不改 RTL 逻辑**。

### 4.1 扩展操作通用步骤

1. **用 §2.3 公式计算新 tgt_id 值**
2. **用 §2.5 公式计算新 dec_node ROUTE_BASE / ROUTE_MASK**
3. **更新以下参数**（纯数值，不改逻辑）：

| 文件 | 改什么 |
|------|--------|
| DUT wrapper (或 SoC top) | INIU `ADDR_MAP_TGT_ID_TABLE`, dec_node `ROUTE_BASE/MASK`, 各 TNIU 参数 |
| `sts_tniu_top.sv` | `LOCAL_RSC_TGT_ID`, `LOCAL_REGBANK_TGT_ID`, `SYS_APB_ROUTE_BASE/MASK` |
| `sts_tniu_noc.sv` | 同上（向下传播） |

4. **用真值表脚本验证**（§2.5 的 Python 验证）

### 4.2 增加 TNIU

按 §2.3 公式 $\text{tgt\_id}(n, j) = \text{BASE} + n \times 2^M + j$，直接扩展。

容量取决于编码方案选取的 $P$、$N$、$M$：

| 子目标数 $\max(L,S)$ | M | 最大化编码下 TNIU 上限 ($D=0$) | dec_node MASK |
|----------------------|---|-------------------------------|---------------|
| 2 | 1 | 128 ($2^7$) | ~0x01 = 0xFE |
| 4 | 2 | 64 ($2^6$) | ~0x03 = 0xFC |
| 8 | 3 | 32 ($2^5$) | ~0x07 = 0xF8 |
| 16 | 4 | 16 ($2^4$) | ~0x0F = 0xF0 |

**TNIU 内部改动**: 仅增大 `SYS_APB_MASTER_NUM`，扩展 `SYS_APB_ROUTE_BASE/MASK` 数组。

### 4.3 增加每 TNIU 子目标数

增加 $M$（sub_sel 位数）即可，不需要改 RTL 逻辑。$M$ 增大会压缩 $N$（可用路由位），减少可支持的 TNIU 总数——见 §4.2 表格。

### 4.4 多级 dec_node 树

路由位可以分给多级 dec_node，不改模块逻辑（每级实例化同一个 `sts_noc_dec_node`，各自配不同 MASK）：

```
N-bit 路由位分配示例:
  Level 1: 用高 K 位分 2^K 组   → MASK 只保留高 K 位
  Level 2: 用低 N-K 位分路      → MASK 保留全部路由位
```

各级 MASK 推导: $\text{MASK}_{L} = \sim(2^M - 1) \;\&\; \sim B_L$，其中 $B_L$ 是本级不参与路由的 tniu_sel 位。

### 4.5 容量总结

| 编码方案 | 路由位 N | max TNIU | max 层级 | max 子目标/TNIU |
|---------|---------|----------|---------|----------------|
| 带 type 前缀 ($P=2$, $D \ne 0$) | $W - P - M$ | $2^{W-P-M}$ | $W - P - M$ | $2^M$ (local+sys) |
| 最大化 ($P=0$, $D=0$) | $W - M$ | $2^{W-M}$ | $W - M$ | $2^M$ |

**扩展不需要改 `TGT_ID_WIDTH`**——8-bit 足够支撑现实 NoC 规模。
当需要超过 $2^{W-M}$ 个 TNIU 时，才需增大 `TGT_ID_WIDTH`（涉及 `lwnoc_sts_pack.sv` 及整个 struct 定义）。

---

## 5. 当前实例：1-INIU + 3-TNIU 拓扑

以下所有具体值均由 §2 公式导出。

### 5.1 实例参数

| 符号 | 值 | 说明 |
|------|-----|------|
| $W$ | 8 | `TGT_ID_WIDTH` |
| $T$ | 3 | TNIU0, TNIU1, TNIU2 |
| $L$ | 2 | regbank + RSC |
| $S$ | 2 | sys_slave0 + sys_slave1 |
| $M$ | 1 | $\lceil \log_2(2) \rceil = 1$ |
| $N$ | 2 | $\lceil \log_2(3) \rceil = 2$（可支持 4 个 TNIU） |
| $P$ | 2 | `01`=local, `10`=sys |
| $\text{BASE\_LOCAL}$ | `0x40` | bit[5:4]=01 |
| $\text{BASE\_SYS}$ | `0x50` | bit[5:4]=10 |
| $D$ | `0x10` | $0\text{x}50 \oplus 0\text{x}40$ |
| $\Delta$ | 2 | $2^1 = 2$ |

### 5.2 拓扑图

```
                      AXI Slave
                         │
                    ┌────┴────┐
                    │  INIU   │   addr_map: 12 entries, 4K page
                    └────┬────┘
                         │
                  ┌──────┴──────┐
                  │  dec_node   │  MASK=0xEE, 3 slots
                  └─┬────┬────┬─┘
                    │    │    │
              ┌─────┘    │    └─────┐
              │          │          │
         ┌────┴───┐ ┌───┴────┐ ┌───┴────┐
         │ TNIU0  │ │ TNIU1  │ │ TNIU2  │
         └───┬────┘ └───┬────┘ └───┬────┘
             │          │          │
         ┌───┴───┐  ┌───┴───┐  ┌───┴───┐
         │local  │  │local  │  │local  │
         │apb_dec│  │apb_dec│  │apb_dec│
         └┬────┬─┘  └┬────┬─┘  └┬────┬─┘
          │    │      │    │      │    │
        reg  RSC    reg  RSC    reg  RSC   (NOC 侧, clk_dst 域)
          │          │          │
         CDC        CDC        CDC
          │          │          │
       ┌──┴──┐   ┌──┴──┐   ┌──┴──┐
       │sys  │   │sys  │   │sys  │
       │apb  │   │apb  │   │apb  │
       │_dec │   │_dec │   │_dec │
       └┬──┬─┘   └┬──┬─┘   └┬──┬─┘
        │  │      │  │      │  │
       s0  s1    s0  s1    s0  s1
```

### 5.3 tgt_id 编码

```
tgt_id[7:0] = { reserved[7:6], type[5:4], tniu_sel[3:1], sub_sel[0] }
```

| 字段 | Bit 位 | 含义 |
|------|--------|------|
| `type` | [5:4] | `01` = local (0x4X)，`10` = sys (0x5X) |
| `tniu_sel` | [3:1] | `000`=TNIU0, `001`=TNIU1, `010`=TNIU2 |
| `sub_sel` | [0] | `0`=regbank/slave0, `1`=RSC/slave1 |

**验证** (§2.3 公式, $\Delta = 2$):
- TNIU0 local: $0\text{x}40 + 0 \times 2 + \{0,1\} = \{0\text{x}40, 0\text{x}41\}$ ✅
- TNIU1 sys: $0\text{x}50 + 1 \times 2 + \{0,1\} = \{0\text{x}52, 0\text{x}53\}$ ✅
- TNIU2 local: $0\text{x}40 + 2 \times 2 + \{0,1\} = \{0\text{x}44, 0\text{x}45\}$ ✅

### 5.4 完整 tgt_id 分配表

| tgt_id | 二进制 | 目标 | 类型 |
|--------|--------|------|------|
| `0x40` | `0100_0000` | TNIU0 regbank | local |
| `0x41` | `0100_0001` | TNIU0 RSC | local |
| `0x42` | `0100_0010` | TNIU1 regbank | local |
| `0x43` | `0100_0011` | TNIU1 RSC | local |
| `0x44` | `0100_0100` | TNIU2 regbank | local |
| `0x45` | `0100_0101` | TNIU2 RSC | local |
| `0x50` | `0101_0000` | TNIU0 sys slave0 | sys |
| `0x51` | `0101_0001` | TNIU0 sys slave1 | sys |
| `0x52` | `0101_0010` | TNIU1 sys slave0 | sys |
| `0x53` | `0101_0011` | TNIU1 sys slave1 | sys |
| `0x54` | `0101_0100` | TNIU2 sys slave0 | sys |
| `0x55` | `0101_0101` | TNIU2 sys slave1 | sys |
| `0xFF` | `1111_1111` | default (DECERR) | — |

### 5.5 三级路由链（实例）

#### Level 1: INIU addr_map — AXI 地址 → tgt_id

| AXI 地址范围 | tgt_id | 目标 |
|-------------|--------|------|
| `0x0000_0000 - 0x0000_0FFF` | `0x40` | TNIU0 regbank |
| `0x0000_1000 - 0x0000_1FFF` | `0x41` | TNIU0 RSC |
| `0x0000_2000 - 0x0000_2FFF` | `0x50` | TNIU0 sys slave0 |
| `0x0000_3000 - 0x0000_3FFF` | `0x51` | TNIU0 sys slave1 |
| `0x0000_4000 - 0x0000_4FFF` | `0x42` | TNIU1 regbank |
| `0x0000_5000 - 0x0000_5FFF` | `0x43` | TNIU1 RSC |
| `0x0000_6000 - 0x0000_6FFF` | `0x52` | TNIU1 sys slave0 |
| `0x0000_7000 - 0x0000_7FFF` | `0x53` | TNIU1 sys slave1 |
| `0x0000_8000 - 0x0000_8FFF` | `0x44` | TNIU2 regbank |
| `0x0000_9000 - 0x0000_9FFF` | `0x45` | TNIU2 RSC |
| `0x0000_A000 - 0x0000_AFFF` | `0x54` | TNIU2 sys slave0 |
| `0x0000_B000 - 0x0000_BFFF` | `0x55` | TNIU2 sys slave1 |
| 其他 | `0xFF` | DECERR (default) |

参数：`ADDR_MAP_ENTRY_NUM=12`，`MASK=0xFFFFF000`（4K page）

#### Level 2: dec_node — tgt_id → TNIU 选择

由 §2.5 公式: MASK = $\sim(0\text{x}01 \mid 0\text{x}10) \;\&\; 0\text{xFF} = 0\text{xEE}$

| dec_node slot | ROUTE_BASE | ROUTE_MASK | 匹配的 tgt_id | 目标 |
|--------------|------------|------------|---------------|------|
| slot[0] | `0x40` | `0xEE` | `0x40, 0x41, 0x50, 0x51` | TNIU0 |
| slot[1] | `0x42` | `0xEE` | `0x42, 0x43, 0x52, 0x53` | TNIU1 |
| slot[2] | `0x44` | `0xEE` | `0x44, 0x45, 0x54, 0x55` | TNIU2 |
| 无命中 | — | — | `0xFF` 等 | DECERR |

**mask `0xEE` = `1110_1110`**: 屏蔽 bit0 (sub_sel) 和 bit4 (type 差异位)，仅按 bit[3:1] (tniu_sel) 路由。

#### Level 3a: local apb_dec — tgt_id → regbank / RSC

| TNIU | ROUTE_BASE | ROUTE_MASK | 目标 |
|------|------------|------------|------|
| TNIU0 | `{0x41, 0x40}` | `{0xFF, 0xFF}` | [0]=regbank, [1]=RSC |
| TNIU1 | `{0x43, 0x42}` | `{0xFF, 0xFF}` | [0]=regbank, [1]=RSC |
| TNIU2 | `{0x45, 0x44}` | `{0xFF, 0xFF}` | [0]=regbank, [1]=RSC |

#### Level 3b: sys apb_dec — tgt_id → sys APB slaves

| TNIU | SYS_APB_ROUTE_BASE | SYS_APB_ROUTE_MASK | 目标 |
|------|-------------------|-------------------|------|
| TNIU0 | `{0x51, 0x50}` | `{0xFF, 0xFF}` | [0]=sys_slave0, [1]=sys_slave1 |
| TNIU1 | `{0x53, 0x52}` | `{0xFF, 0xFF}` | [0]=sys_slave0, [1]=sys_slave1 |
| TNIU2 | `{0x55, 0x54}` | `{0xFF, 0xFF}` | [0]=sys_slave0, [1]=sys_slave1 |

### 5.6 RTL 参数配置速查表

#### INIU (u_iniu)

```systemverilog
.ADDR_MAP_ENTRY_NUM    (12),
.ADDR_MAP_BASE_TABLE   ({32'h0000_B000, 32'h0000_A000, ..., 32'h0000_0000}),
.ADDR_MAP_MASK_TABLE   ({32'hFFFF_F000, ...}),  // 所有 entry 均 4K page
.ADDR_MAP_TGT_ID_TABLE ({8'h55, 8'h54, 8'h45, 8'h44, 8'h53, 8'h52,
                          8'h43, 8'h42, 8'h51, 8'h50, 8'h41, 8'h40}),
.ADDR_MAP_DEFAULT_TGT_ID (8'hFF)
```

#### dec_node (u_noc_dec)

```systemverilog
.SLAVE_NUM   (3),
.ROUTE_BASE  ({8'h44, 8'h42, 8'h40}),   // slot[2]=TNIU2, [1]=TNIU1, [0]=TNIU0
.ROUTE_MASK  ({8'hEE, 8'hEE, 8'hEE})    // 屏蔽 bit0 + bit4
```

#### TNIU0 (u_tniu0)

```systemverilog
.LOCAL_RSC_TGT_ID      (8'h41),
.LOCAL_REGBANK_TGT_ID  (8'h40),
.SYS_APB_ROUTE_BASE    ({8'h51, 8'h50}),
.SYS_APB_ROUTE_MASK    ({8'hFF, 8'hFF})
```

#### TNIU1 (u_tniu1)

```systemverilog
.LOCAL_RSC_TGT_ID      (8'h43),
.LOCAL_REGBANK_TGT_ID  (8'h42),
.SYS_APB_ROUTE_BASE    ({8'h53, 8'h52}),
.SYS_APB_ROUTE_MASK    ({8'hFF, 8'hFF})
```

#### TNIU2 (u_tniu2)

```systemverilog
.LOCAL_RSC_TGT_ID      (8'h45),
.LOCAL_REGBANK_TGT_ID  (8'h44),
.SYS_APB_ROUTE_BASE    ({8'h55, 8'h54}),
.SYS_APB_ROUTE_MASK    ({8'hFF, 8'hFF})
```

### 5.7 当前编码容量与扩展空间

| 维度 | 当前值 | 当前编码上限 | 最大化编码上限 ($P=0, D=0$) |
|------|--------|-------------|--------------------------|
| TNIU | 3 | 8 ($N=3$, 受 010 前缀限制) | 64 ($N=6$, $M=2$) |
| local 子目标 | 2 | 2 ($M=1$) | 4 ($M=2$) |
| sys 子目标 | 2 | 2 ($M=1$) | 4 ($M=2$) |
| 总 tgt_id | 12+1 | 32+1 | 256 |

扩展至 >8 TNIU 只需去掉 type 前缀、从 0x00 起编——仅改参数值，不改 RTL。

### 5.8 DECERR 路径配置（当前实例）

dec_node 实例化参数 `SLAVE_NUM=3`，因此 `arb_vrp` 的 `WIDTH=4`（3 个 TNIU + 1 个 DECERR）。

```
arb_vrp 输入分配:
  v_vld_s[0] = tniu0_rsp_vld   → v_rdy_s[0] = tniu0_rsp_rdy
  v_vld_s[1] = tniu1_rsp_vld   → v_rdy_s[1] = tniu1_rsp_rdy
  v_vld_s[2] = tniu2_rsp_vld   → v_rdy_s[2] = tniu2_rsp_rdy
  v_vld_s[3] = decerr_rsp_vld  → v_rdy_s[3] = decerr_rsp_rdy
```

**DECERR 响应 pld 字段**（固定值）：

| 字段 | 值 | 来源 |
|------|-----|------|
| `rsp.resp` | `2'b11` | DECERR 编码 |
| `rsp.data` | `0x0000_0000` | 固定 |
| `rsp.last` | `1'b1` | 单 beat |
| `cmn.src_id` | 复制自 req | 回环 |
| `cmn.txn_id` | 复制自 req | 回环 |
| `cmn.tgt_id` | 复制自 req (`0xFF`) | 调试用 |
| `cmn.opcode` | `RdRsp` or `WrRsp` | 对应 req opcode |

**触发条件**: AXI 地址 ≥ `0x0000_C000`（当前地址映射），INIU 将其映射为 `tgt_id=0xFF`，dec_node 无命中 → `decerr_rsp_vld=1`。
