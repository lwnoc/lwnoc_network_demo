# Skill Improvement Report — STS NOC Debug/CTI Signal Propagation

Date: 2026-04-14
Scenario: 为 STS NOC demo 的 topology 生成器添加 debug timestamp / debug data / CTI 信号，使其暴露到顶层模块端口（模拟真实 SoC 信号通路）。

---

## Context

### Work Scenario

目标：在 `lwnoc_sts_noc_demo` 中给 4 个 TNIU 节点添加 dbg / CTI 端口，修改 RTL wrap 模板、`StsNode.py`，然后重新运行 `gen_sts_topo.py` 生成新的 `sts_logic_topo_1i4t.v`。

**涉及工具 / 环境：**
- Python topology 生成框架：`lwnoc_topo/topo_core` + `uhdl/uhdl/core/TemplateIP` + `VComponent`
- ip_builder CLI：用于 prefix 处理和 unity wrapper 生成
- Slang v10（第三方 SV elaborator）：用于端口 AST 推断
- 子模块：`lwnoc_topo/uhdl`（slangv8 branch）、`lwnoc_topo/ip_builder/submodule/{fexpand,sv_macro_prefixer}`

---

### Skill Inventory

| Skill | 本次使用? | 说明 |
|-------|----------|------|
| lwnoc-topo | ✅ | 主力 skill，覆盖 TemplateIPConfig / Node / WrapperNode 使用模式 |
| design-microarch | ✅ | 用于 RTL 源文件分析（wrap 模板改写） |
| rtl-coding-style | ❌ | RTL 端口改写时未触发（改动较小） |
| eda-toolchain-debug | ❌ | 子模块缺失、slang not in PATH 等问题应触发但未触发 |
| sw-install-self-test | ❌ | slang / ip_builder 问题属于工具链范畴，未触发 |
| ip-design | ❌ | 未触发（非新设计流程） |
| dev-skill-index | ❌ | 未使用 |

---

## Findings

### F1：`add_interface()` regex 语义陷阱 — fullmatch vs search

- **What happened**：`StsNode.py` 中所有 prefix 风格 pattern（`r"^in_req_"` 等）在 `aichip_memnoc/lwnoc_topo` 中使用 `re.search()` 可以匹配成功，但本 workspace 的 `topo_core` 已升级为 `re.fullmatch()`。结果：所有多信号接口映射到 0 IOs，生成的 `sts_logic_topo_1i4t.v` 顶层只有 7 个端口，AXI / APB / NOC / debug / CTI 全部 `()`。诊断过程中 slang elaboration 正确返回 0 错误，掩盖了问题出现在 Python 层。
- **Outcome**: ⚠️ Struggled（最终解决，但诊断消耗了大量轮次）
- **Iterations**: ~10+ 轮 slang AST 检查 → VComponent 源码分析 → `uhdlComponentNode.py` diff → 定位到 `fullmatch` → 修 `.*` 后才一次成功
- **Impact**：浪费了约半条对话（~15 轮工具调用）在诊断"slang 成功但 ports 全空"的错误上
- **Category**: `skill-gap`（lwnoc-topo Pitfall Reference 中未收录此陷阱）

---

### F2：topo_core 版本差异无感知 — lwnoc_network_demo vs aichip_memnoc

- **What happened**：两个 workspace 共享相同的 `lwnoc_topo` 子模块名称，但 `uhdlComponentNode.py` 的 `map_interface()` 实现不同（`re.search` vs `re.fullmatch`）。Agent 在多次确认 slang 成功之后，才通过 `diff` 发现版本差异，且这个方向是最后才想到的。
- **Outcome**: ⚠️ Struggled
- **Iterations**: 2 轮（主动 diff 前已浪费 8+ 轮 slang 诊断）
- **Impact**：如果早知道应该先 diff topo_core，可节省 8+ 次工具调用
- **Category**: `skill-gap`（缺少"跨 workspace topo_core 版本兼容性检查"的指导）

---

### F3：Git 子模块缺失 — 无预先检查步骤

- **What happened**：运行 `gen_sts_topo.py` 时遭遇 `ModuleNotFoundError: No module named 'uhdl.uhdl'`，原因是 `lwnoc_topo/uhdl/` 子模块为空。随后 `ip_builder/submodule/fexpand` 和 `sv_macro_prefixer` 也需要额外 init。这些问题属于可预防的环境前置检查。
- **Outcome**: ⚠️ Struggled
- **Iterations**: 3 次（uhdl → ip_builder fexpand → ip_builder sv_macro_prefixer 各一次）
- **Impact**：3 次独立的"发现 → 修复"循环，每次单独处理；如有 checklist 可一次性完成
- **Category**: `missing-skill`（lwnoc-topo 中没有"环境就绪检查"步骤）

---

### F4：Slang 不在 PATH — 重复需要手动注入

- **What happened**：slang 二进制位于 `aichip_memnoc/lwnoc_topo/uhdl/slang/build/bin/`，不在系统 PATH。每次 `gen_*.py` 调用都需要 `PATH="...slang/build/bin:$PATH" python3 ...`。本次对话重新发现并解决了这个问题，但之前的对话也遇到过。
- **Outcome**: ⚠️ Struggled（可查到历史中此问题反复出现）
- **Iterations**: 2（每次都重新解决）
- **Impact**：在每次对话中重复花时间处理同一个环境问题
- **Category**: `missing-skill`（缺少永久性 PATH 修复方案 / per-demo setup 文档）

---

### F5：Macro 宽度在 wrap 模板中导致 slang 失败

- **What happened**：最初将 `dbg_data_in` 等新端口宽度写成 `` `STS_DEMO_DBG_DATA_WIDTH ``（macro），slang 无法在单独 elaboration 阶段解析该 macro，导致宽度推断失败。需要改为字面量 `[31:0]`/`[63:0]`。
- **Outcome**: ⚠️ Struggled
- **Iterations**: 2（先加 macro，报错后改成字面量）
- **Impact**：额外 1 轮改写 + 1 轮重新测试
- **Category**: `skill-gap`（lwnoc-topo Section 2 的参数 delivery 模型指导未覆盖"wrap 模板中端口宽度不可用 macro"的限制）

---

## Proposals

### Proposal 1：新增 Pitfall P015 — `add_interface` fullmatch 语义（`re.fullmatch instead of re.search`）

- **Type**: Modify Existing Skill
- **Target**: `skills/lwnoc-topo/SKILL.md`（Section 5: Pitfall Reference）
- **Addresses findings**: F1, F2
- **Problem class**: 跨版本 topo_core API 行为变化导致接口映射全部返回 0 IOs，生成的 Verilog 端口全空，但 slang 诊断工具不会暴露此类问题（因为 slang 只验证 RTL，不验证 Python Interface→IO 绑定）
- **Change summary**：在 Pitfall Reference 表格末尾添加 P015 行，并在 Section 2 的 `add_interface` 示例后添加兼容性规则
- **Specific changes**:
  - File: `SKILL.md` — Section: 5 (Pitfall Reference 表) — Action: add
    ```
    | P015 | `add_interface` 全部返回 0 IOs，生成的 Verilog 所有端口 `()` | 使用了 `re.search` 风格的无尾 prefix pattern（如 `r"^prefix_"`），但当前 `topo_core` 的 `map_interface()` 已升级为 `re.fullmatch()`，要求 pattern 覆盖完整 IO 名称 | 所有前缀 pattern 末尾加 `.*`（`r"^prefix_.*"`）；或用精确全名 `r"^exact_name$"` |
    ```
  - File: `SKILL.md` — Section: 2 `UhdlComponentNode` 示例之后 — Action: add 警告块
    ```
    > ⚠️ **`add_interface` Pattern 兼容性规则**
    > 当前 `topo_core` 使用 `re.fullmatch()` 匹配 IO 名称。  
    > - ✅ `r"^clk_src$"` — 精确全名
    > - ✅ `r"^data_in.*"` — 前缀 + 通配符  
    > - ❌ `r"^data_in"` — 漏 `.*`，将匹配 0 个 IO（无报错，静默失败）  
    > 诊断方式：运行时加 `TOPO_DEBUG=1`，检查 `Mapped interface '...' -> N IOs`；N=0 表示 pattern 未命中。
    ```
- **Architecture notes**: 无需新建文件，追加到现有 Pitfall 表和 Section 2 示例
- **Estimated context cost**: +~25 tokens
- **Overlaps checked**: `eda-toolchain-debug` — 不覆盖（Python 层 API 非工具链 IT 类）；`design-microarch` — 不覆盖

---

### Proposal 2：新增 lwnoc-topo 环境就绪 Checklist（子模块 + PATH）

- **Type**: Modify Existing Skill
- **Target**: `skills/lwnoc-topo/SKILL.md`（新增 Section 6: 环境就绪检查）
- **Addresses findings**: F3, F4
- **Problem class**: 在新 workspace 首次运行 `gen_*.py` 时，gitsubmodule 缺失 + slang 未在 PATH 会分别造成独立的"发现-修复"循环。任何 `lwnoc_topo` workspace 都会有此问题
- **Change summary**：在 SKILL.md 末尾添加"Section 6: 运行前环境就绪检查"，包含一次性诊断命令和 slang PATH 永久修复方案
- **Specific changes**:
  - File: `SKILL.md` — Section: 末尾新增 Section 6 — Action: add
    ```markdown
    ## 6. 运行前环境就绪检查

    在 **新 workspace** 或 **CI 环境** 首次运行 `gen_<design>_topo.py` 前，执行以下一次性检查：

    ```bash
    # 1. 检查 lwnoc_topo 子模块是否已初始化
    ls lwnoc_topo/uhdl/uhdl/core/VComponent.py 2>/dev/null \
      || { echo "❌ uhdl 子模块缺失，执行："; \
           echo "   cd lwnoc_topo && git submodule update --init"; }

    ls lwnoc_topo/ip_builder/submodule/fexpand/fexpand 2>/dev/null \
      || { echo "❌ ip_builder 子模块缺失，执行："; \
           echo "   cd lwnoc_topo/ip_builder && git submodule update --init"; }

    # 2. 检查 slang 是否在 PATH
    which slang 2>/dev/null && slang --version \
      || echo "❌ slang 不在 PATH，需要在 gen 命令前注入：
         PATH=\"<aichip_memnoc_root>/lwnoc_topo/uhdl/slang/build/bin:\$PATH\" python3 gen_*.py"
    ```

    **永久修复 slang PATH（推荐）**：在 demo 目录下创建 `run_gen.sh`：
    ```bash
    #!/bin/bash
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    SLANG_BIN="$SCRIPT_DIR/../lwnoc_topo/uhdl/slang/build/bin"
    export PATH="$SLANG_BIN:$PATH"
    python3 "$(dirname "$0")/gen_${DESIGN}_topo.py" "$@"
    ```
    ```
- **Architecture notes**: 未来可扩展为独立 `scripts/check_env.sh` 放在 `lwnoc_topo/`
- **Estimated context cost**: +~50 tokens
- **Overlaps checked**: `sw-install-self-test` 覆盖通用工具安装检查，但不包含 lwnoc_topo 子模块特有的子模块状态检查；`eda-toolchain-debug` 覆盖 EDA IT 级别，不覆盖 Python 子模块；无重叠

---

### Proposal 3：新增 Pitfall P016 — Wrap 模板端口宽度不可用 Define Macro

- **Type**: Modify Existing Skill
- **Target**: `skills/lwnoc-topo/SKILL.md`（Section 5: Pitfall Reference）
- **Addresses findings**: F5
- **Problem class**: 在 `_PREFIX_` RTL wrap 模板中用 `` `define `` macro 定义端口宽度，slang 单独 elaborate 时无法解析 macro → 宽度变成 1-bit 或报错
- **Change summary**：在 Pitfall Reference 表格添加 P016，以及在 Section 2 "Key API Patterns" 下补充"Port Width 限制"规则
- **Specific changes**:
  - File: `SKILL.md` — Section: 5 (Pitfall Reference 表) — Action: add
    ```
    | P016 | Wrap 模板中新加端口的 slang 宽度推断错误（1-bit 或 unknown width） | 端口宽度写成了 `` `DEFINE_MACRO ``；slang elaboration 在 unity wrapper 流程中虽然包含 macros 文件，但 TemplateComponent 构造初期的 temp_build 阶段可能无宏上下文 | wrap 模板中的定制端口宽度使用字面量（`[31:0]`）或 SV package 常量（`CTI_EVENT_WIDTH-1:0`）；调试时检查 VComponent AST 的 port type 字段 |
    ```
  - File: `SKILL.md` — Section: 2 末尾（现有 Parameter Delivery Model 之后）— Action: add
    ```
    ### Wrap Template 端口宽度规则

    在 `_PREFIX_` RTL wrap 模板中添加新端口时：
    - ✅ 字面量宽度：`[31:0]`、`[63:0]`（推荐，保证 slang 总能解析）
    - ✅ SV package 常量：`[CTI_EVENT_WIDTH-1:0]`（已 import 的 package 中的常量）
    - ❌ **不要用 define macro** 作为端口宽度：`` [`MY_MACRO-1:0] `` 在 slang 单独 elaborate wrap 时无 macro 上下文，宽度恒为 1-bit
    ```
- **Architecture notes**: 无新文件
- **Estimated context cost**: +~25 tokens
- **Overlaps checked**: `design-microarch` — 未覆盖 ip_builder wrap 模板的 macro 限制；`rtl-coding-style` — 不涵盖工具链约束

---

### Proposal 4：新增 Pitfall P017 — topo_core 代版本差异检查

- **Type**: Modify Existing Skill
- **Target**: `skills/lwnoc-topo/SKILL.md`（Section 5: Pitfall Reference）
- **Addresses findings**: F2
- **Problem class**: 多 workspace 共用相同子模块名 `lwnoc_topo`，但实际版本（branch/commit）不同，导致 API 行为静默不兼容
- **Change summary**：在 Pitfall Reference 添加 P017，提示遇到"端口全空但 slang 成功"时应立即 diff topo_core 版本
- **Specific changes**:
  - File: `SKILL.md` — Section: 5 — Action: add
    ```
    | P017 | 生成的 Verilog 所有 non-clk/rst 端口为 `()`，slang 报 0 errors | 多个 workspace 共享相同子模块名但 topo_core 版本不同，API 行为（如 `map_interface` 的 regex 语义）已变更 | 立即执行 `diff <workspace_a>/lwnoc_topo/topo_core/node/uhdlComponentNode.py <workspace_b>/...` 对比关键实现；重点检查 `map_interface()` 里的 `re.fullmatch` vs `re.search` |
    ```
- **Architecture notes**: 无新文件
- **Estimated context cost**: +~20 tokens
- **Overlaps checked**: 无重叠

---

## Priority

| # | Proposal | Impact | Effort | Priority | Implemented? |
|---|----------|--------|--------|----------|-------------|
| 1 | P015 — fullmatch pattern 语义陷阱（Section 5 + Section 2） | High | Low | **P0** | ✅ Done — `SKILL.md` line 142–149 (warning block) + line 257 (P015 pitfall row) |
| 2 | P016 — Wrap 端口宽度不可用 Macro（Section 5 + Section 2） | Medium | Low | **P0** | ✅ Done — `SKILL.md` line 151–158 (Wrap Template 端口宽度规则) + line 258 (P016 pitfall row) |
| 3 | P017 — topo_core 跨版本 diff 指引（Section 5） | Medium | Low | **P0** | ✅ Done — `SKILL.md` line 259 (P017 pitfall row) |
| 4 | P2 — 环境就绪检查 Section（Section 6 新增） | Medium | Medium | P1 | ❌ Deferred — 需要较多编写，留待下次处理 |
