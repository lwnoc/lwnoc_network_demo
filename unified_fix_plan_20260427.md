# 4-NoC 深度审查与统一修复计划

Date: 2026-04-27
审计基准: `lwnoc-topo` skill gates + `aichip_memnoc` golden pattern

---

## 一、Memnoc Golden 关键指标

| 指标 | Memnoc Golden | 我们的目标 |
|------|-------------|-----------|
| gen 脚本行数 | 118 (3 defs, 全为可视化) | 尽量简洁 |
| Template.py defs | 0 (纯声明) | 0 包装函数 |
| Node.py Component 子类 | 3 | 0 (迁移至 subs RTL) |
| build_logic 目录数 | 9 | 按 config type 聚合，非按 instance |
| 配置复用 | 5 NPU 共享 1 个 `npu_sys_config` | 同类型 SS 共享 config |
| Harden 分区时钟 | 有 (PD 版) | 必须有 |
| Harden 数据通路连线 | 内部 connect() | 必须在 harden wrapper 内 |

---

## 二、深度审计发现（超出前次审计的新问题）

### 发现 1: Config-per-instance 爆炸 → build_logic 目录过多

**Memnon pattern**: 5 个 NPU INIU 实例共享 1 个 `npu_sys_config`，每个实例差异（node_id, node_name）通过 Node 构造函数参数传入，而非创建不同 TemplateIPConfig。

**DTI 违规 (最严重)**:
- `dsp0~5` 6 个实例各自创建独立的 `TemplateIPConfig`，尽管 `param_overrides` 完全相同 (`TBU_NUM=1, TRANSACTION_MAX_NUM=8`)
- 导致 6 个 `dsp*_iniu_sys` 目录，而 memnoc 只需 1 个
- 类似问题: `gpu0/gpu1`, `usb_ufs` vs `noc_tbu1` 等重复配置
- 28 个 build_logic 目录 vs memnoc 的 9 个

**INTR 违规**:
- 每个 SS (aon, audio, camera, cpu, ddr, ...) 各自一个 sys 目录
- 31 个 build_logic 目录 — 是所有 demo 中最多的
- 大量 SS 使用相同的 RTL (相同的 `vc/*.f` filelist)，仅仅是 `PREFIX` 不同

**根因**: `_new_cfg()` 包装函数使创建"per-instance config"过于简单，缺少复用意识。

### 发现 2: Build 目录名与 Topo ID 不匹配 (DTI)

| Topo node ID | Build dir 名 | 状态 |
|-------------|-------------|------|
| `cpu_iniu_node` | `cpu_iniu_sys` | ✅ 近似匹配 |
| `pcie_iniu_node` | `pcie_eth_iniu_sys` | ❌ 名称漂移 |
| `ufs_iniu_node` | `usb_ufs_iniu_sys` | ❌ 名称漂移 |
| `mipi_iniu_node` | `mipi0_iniu_sys` | ❌ 名称漂移 |
| (none) | `dsp0~5_iniu_sys` | ❌ Topo 中无对应 ID |

DSP 节点在 DtiTreeTopo.py 中使用 `make_dsp*_iniu_node()` 工厂函数创建，这些函数内部调用的 `DtiIniuSysNode(id=...)` 的 id 未在 Topo 中显式出现。

### 发现 3: INTR 已清除 postgen patch，但 SocIntrNode.py 仍有 Component 子类

```
L18-55: ParamInstTemplateComponent(TemplateComponent) — verilog_inst 重载
L67-112: SocIntrXbarRoutingLutComponent(Component) — circuit() + BFS
L114-155: SocIntrXbarRoutingLutNode — build_uhdl() 重载
```

**同时 INTR 有最好的 gate 合规性**:
- ✅ G6: 无数据端口泄漏
- ✅ G9: 正确的 clk_up_func/clk_dn_func 分区时钟
- ✅ G2: 零 postgen patch

### 发现 4: ATB/DTI/STS 的 gen 脚本有 dead import

- ATB: `import subprocess` (L9) — sed 移除后无用
- STS: `import subprocess` (L9) — 从未使用

### 发现 5: STS 缺少拓扑描述文件

- `soc_sts_noc_topo` 不存在 (G5 违规)
- 对照: ATB 有 `soc_atb_topo`, DTI 有 `soc_dti_noc_topo`, INTR 有 `soc_intr_noc_topo`

---

## 三、统一修复计划

### 执行顺序: 从简单到复杂，逐步建立 momentum

---

### Step 1: 死代码清理 (Low, ATB + STS)

**文件**: `soc_atb_noc/gen_soc_atb_topo.py` L9
- 删除 `import subprocess, sys` → `import sys`

**文件**: `soc_atb_noc/AtbTemplate.py` L45-75
- 删除 `def _sys_filelist(...)` 函数体（无调用者）

**文件**: `lwnoc_sts_noc_demo/gen_sts_soc_topo.py` L9
- 删除 `import subprocess, sys` → `import sys`

**验证**: `grep "subprocess\|_sys_filelist"` 无匹配

---

### Step 2: STS Component 子类迁移 (Med, STS)

**当前违规** (`lwnoc_sts_noc_demo/StsNode.py`):
- L30-40: `StsReqSinkComponent(Component)` + `circuit()`
- L50-61: `StsReqZeroSourceComponent(Component)` + `circuit()`

**操作**:
1. 创建 `subs/lwnoc_sts_noc/rtl/sts_req_sink.sv` — req 通路终结器
2. 创建 `subs/lwnoc_sts_noc/rtl/sts_req_zero_source.sv` — req 零值源
3. 更新 `subs/lwnoc_sts_noc/vc/*.f` 添加新文件
4. `StsReqSinkNode` → `TemplateComponent(config=cfg, top="sts_req_sink")`
5. `StsReqZeroSourceNode` → `TemplateComponent(config=cfg, top="sts_req_zero_source")`
6. 删除 StsNode.py 中两个 Component 子类定义

**验证**: `grep "class.*Component(Component)" StsNode.py` = 0

---

### Step 3: DTI Component 子类迁移 (Med, DTI)

**当前违规** (`soc_dti_noc_demo/DtiNode.py`):
- L144-157: `DtiIniuTopExtTieoffComponent(Component)` + `circuit()`
- L179-192: `DtiTniuTopExtTieoffComponent(Component)` + `circuit()`
- L206-213: `DtiBufWriteReqExtTieoffComponent(Component)` + `circuit()`

**操作**:
1. 创建 `subs/lwnoc_dti_noc/rtl/dti_iniu_top_tieoff.sv`
2. 创建 `subs/lwnoc_dti_noc/rtl/dti_tniu_top_tieoff.sv`
3. 创建 `subs/lwnoc_dti_noc/rtl/dti_buf_wr_req_tieoff.sv`
4. 更新 `subs/lwnoc_dti_noc/vc/dti_network.f` 添加新文件
5. 在 DtiNode.py 中替换为 `TemplateComponent(top="dti_*_tieoff")`
6. 删除三个 Component 子类定义

**验证**: `grep "class.*Component(Component)" DtiNode.py` = 0

---

### Step 4: DTI Template 直接声明 + Config 合并 (Low→Med, DTI)

**Part A**: 替换 `_new_cfg()` 包装函数
- 展开所有 `_new_cfg(...)` 调用为直接 `TemplateIPConfig(...)` 声明
- 展开所有 `_switch_cfg(...)` 调用为直接声明
- 删除 `_new_cfg()` (L53) 和 `_switch_cfg()` (L256) 函数
- 保留 `_pack_u32_ranges()` 和 `_resolve_fl()` (纯数据计算)

**Part B**: 合并 per-instance configs → 同类型共享
- `dsp0~5_iniu_sys_config` → **一个** `dsp_iniu_sys_config`（6 个 DSP 共享）
- `gpu0_iniu_sys_config` + `gpu1_iniu_sys_config` → **一个** `gpu_iniu_sys_config`
- 所有 `{TBU_NUM: 1, TRANSACTION_MAX_NUM: 8}` 的 INIU → 一个共享 config
- 仅当 `param_overrides` 实际不同时才创建不同 config

**Part C**: 对齐 build 目录名与 Topo ID
- 修正 `_new_cfg(name=...)` 参数使 name 与 Topo ID 一致

**验证**: `ls build_logic/ | wc -l` 应大幅减少（目标: <15 个目录）

---

### Step 5: INTR Component 子类迁移 (High, INTR)

**当前违规** (`lwnoc_intr_noc_demo/soc_intr_noc/SocIntrNode.py`):

**5a. ParamInstTemplateComponent (verilog_inst 重载)**:
- 检查 `lwnoc_topo/topo_core/` 中 TemplateComponent 是否已有参数化实例化支持
- 如有 → 直接使用标准 TemplateComponent
- 如无 → 保留为临时例外 (user-override)，标记待框架修复

**5b. SocIntrXbarRoutingLutComponent (circuit + BFS)**:
- 核心逻辑: 根据 `lut_data: Dict[(src,tgt), sel]` 生成组合逻辑 LUT
- 方案 A (推荐): 写 `subs/lwnoc_interrupt_noc/rtl/intr_xbar_routing_lut.sv` 参数化 RTL
  - 参数: `NODE_ID_WIDTH`, `NUM_CHANNELS`
  - 端口: 输入 src_id + tgt_ids[NUM_CHANNELS-1:0], 输出 sel_bit
  - LUT 表通过 `generate` + `if/else` 实现
- `SocIntrXbarRoutingLutNode` → `UhdlComponentNode` + `TemplateComponent(top="intr_xbar_routing_lut")`
- 删除 `build_uhdl()` 重载和 BFS

**验证**: `grep "def build_uhdl\|def circuit\|def verilog_inst" SocIntrNode.py` = 0 (除 5a 例外)

---

### Step 6: INTR Template 直接声明 + Config 合并 (Low→Med, INTR)

**Part A**: 替换 `_new_cfg()` 包装函数
- 展开所有调用为直接 `TemplateIPConfig(...)` 声明
- 删除 `_new_cfg()` 函数
- 保留 `_resolve_fl()` 和 `_effective_prefix()` (路径工具)

**Part B**: 合并同类型 configs
- 所有使用相同 `vc/*.f` filelist + 相同 `param_overrides` 的 SS 共享一个 config
- 仅当 RTL 参数实际不同时才创建不同 config
- 目标: 减少 build_logic 目录从 31 → ~15

**验证**: `ls build_logic/ | wc -l` 应减少

---

### Step 7: Harden 时钟分区 (Med, ATB + DTI + STS)

**参照**: INTR 模式 (`gen_soc_intr_topo.py` L65-83)

**7a. ATB** (`soc_atb_noc/gen_soc_atb_topo.py` L46-63):
```python
up_harden = UhdlWrapperNode("atb_up_harden")
up_harden.add_interface("clk_up_func", is_global=True)
up_harden.add_interface("rst_up_func_n", is_global=True)
# 所有 up_harden 子节点: connect(node.clk_noc, up_harden.clk_up_func)
# 所有 up_harden 子节点: connect(node.rst_noc_n, up_harden.rst_up_func_n)

dn_harden = UhdlWrapperNode("atb_dn_harden")  
dn_harden.add_interface("clk_dn_func", is_global=True)
dn_harden.add_interface("rst_dn_func_n", is_global=True)
# 所有 dn_harden 子节点: connect(node.clk_noc, dn_harden.clk_dn_func)
```

**7b. DTI** — 同样模式

**7c. STS** — 同样模式

**验证**: `grep "clk_up_func\|clk_dn_func" build_logic/*harden*/*.v` 必须有匹配

---

### Step 8: ATB Harden 数据通路连线 (High, ATB)

**问题**: `atb_up_harden.v` 泄漏 ~144 数据端口, `atb_dn_harden.v` 泄漏 ~90 数据端口

**根因**: `AtbFunnelIngressAggNode` 使用单一 `ss_side` packed 接口, 无法做标量 connect()

**方案**:
1. 重写 `AtbFunnelIngressAggNode`: 将 `ss_side` 改为 `in0_chan..inN_chan` per-input 接口
2. 在 gen 脚本中添加数据通路 connect():
```python
# up_harden 内部数据通路
for i in range(6):
    connect(up_harden.dsp_ss{i}_top_wrap.m_chan, up_harden.left_agg.in{i}_chan)
connect(up_harden.left_agg.out_bus, up_harden.left_funnel.input)
connect(up_harden.left_funnel.output, up_harden.async_bridge_slv_side.s_chan)
# dn_harden 内部数据通路  
connect(up_harden.async_bridge_mst_side.m_chan, dn_harden.right_agg.in{0}_chan)
# ... etc
```

**验证**: `grep -c "porting_m_\|porting_s_" build_logic/atb_*_harden/*.v` = 0

---

### Step 9: STS 拓扑描述文件 + INTR postgen patch 追踪 (Low-Med)

**9a**. 创建 `lwnoc_sts_noc_demo/soc_sts_noc_topo`
- 格式参照 `soc_dti_noc_topo`: 节点列表 + 连接关系 + 时钟域 + 异步桥切点

**9b**. INTR postgen patch 状态确认
- 本次审计确认: `grep -c "_patch_\|_cast_\|_flatten_" gen_soc_intr_topo.py` = 0 ✅
- 无需额外操作

---

## 四、优先级与依赖

| # | 步骤 | Demo | Effort | 阻塞项 |
|---|------|------|--------|--------|
| 1 | 死代码清理 | ATB, STS | Low | — |
| 2 | STS Component 迁移 | STS | Med | — |
| 3 | DTI Component 迁移 | DTI | Med | — |
| 4 | DTI Template 直接声明+合并 | DTI | Low→Med | 依赖 Step 3 (改同一文件) |
| 5 | INTR Component 迁移 | INTR | High | — |
| 6 | INTR Template 直接声明+合并 | INTR | Low→Med | 依赖 Step 5 |
| 7 | Harden 时钟分区 | ATB, DTI, STS | Med | — |
| 8 | ATB harden 数据通路连线 | ATB | High | 依赖 Step 7 (ATB 部分) |
| 9 | STS topo 文件 + INTR 追踪 | STS, INTR | Low-Med | — |

**核心原则**:
- 每步完成后 `python3 gen_*_topo.py` regen 验证
- 不跨 demo 并行改动（避免交叉调试困难）
- Config 合并前先确认 RTL 是否支持参数化（如不支持，可能需改 subs RTL）

---

## 五、Meta: Skill 文档新增需求

基于本次深度审计，建议新增以下 skill 约束:

1. **Config 复用原则** (应加入 `lwnoc-topo/SKILL.md` per-instance-config gate):
   > 多个使用相同 RTL filelist + 相同 param_overrides 的实例必须共享一个 TemplateIPConfig。Per-instance 差异（如 node_id）通过 Node 构造函数参数传入，而非重复声明配置。

2. **Build-dir 数量上限** (应加入 compliance_audit.md):
   > demo 的 build_logic 目录数不应超过 golden memnoc 的 2x (即 ≤18)。超出应触发 config-per-instance 爆炸检查。

3. **gen 脚本 dead import 检查** (应加入 compliance_audit.md):
   > gen_*.py 中每个 import 必须有对应的实际使用。
