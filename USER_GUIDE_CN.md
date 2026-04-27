# NoC 生成用户手册

## 概述

本工作区包含 4 个 NoC（片上网络）拓扑生成 demo，均遵循 **四文件规则** 和 **三层发布模式**（以 `aichip_memnoc_aichip_dev/` 的 memnoc 为参考）。

每个 demo 从 Python 拓扑描述生成 RTL wrapper、filelist 和硬分区（harden partition）。生成流水线：

```
Topology description (Topo.py)
  → UHDL 图构建 (Node.py + Template.py params)
  → ip_builder RTL 前缀 + filelist 展开 (temp_build)
  → Verilog 生成 (build_uhdl + generate_verilog)
  → Filelist 生成 (generate_filelist)
  → 硬分区 + 聚合 (ring_top_wrap 模式)
```

---

## 1. Demo 总览

| Demo | 子模块 IP | 协议 | 独立仓库 | 入口脚本 |
|------|----------|------|---------|---------|
| **INTR** | `lwnoc_interrupt_noc` | 中断环 | `/home/lgzhu/dev/noc_work/lwnoc_interrupt_noc` | `gen_soc_intr_topo.py` |
| **STS** | `lwnoc_sts_noc` | APB/CTI 追踪 | `/home/lgzhu/dev/noc_work/lwnoc_sts_noc` | `gen_sts_soc_topo.py` |
| **ATB** | `lwnoc_atb_noc` | ATB 追踪 | `/home/lgzhu/dev/noc_work/lwnoc_atb_noc` | `gen_soc_atb_topo.py` |
| **DTI** | `lwnoc_dti_noc` | DTI (AXI 流) | `/home/lgzhu/dev/noc_work/lwnoc_dti_noc` | `gen_dti_topo.py` |

### 四文件结构

每个 demo 由且仅由以下 4 个 Python 文件组成：

| 文件 | 用途 | 内容 |
|------|------|------|
| `*Node.py` | 节点类定义 | `UhdlComponentNode` / `UhdlWrapperNode` 子类、`TemplateComponent` 实例化、`add_interface()` 端口映射 |
| `*Template.py` | IP 配置 | `TemplateIPConfig` 实例、filelist 路径、环境变量、`param_overrides`（所有设计尺寸常量） |
| `*Topo.py` | 拓扑类 | `UhdlWrapperNode` 子类、节点实例、`connect()` 连线、时钟域、harden leaf 列表 |
| `gen_*_topo.py` | 生成驱动 | build → generate_verilog → generate_filelist → harden partition → ring_top_wrap 聚合 |

### Filelist 解析策略

每个 demo 的 Template.py 定义了 RTL 源码的加载路径：

- **INTR/STS/DTI**: 优先检查 `EXTERNAL_*_ROOT`（独立仓库路径），回退到 `subs/` 目录
- **ATB**: 使用 `ATB_SUBIP_ROOT` 环境变量（默认指向 `/home/lgzhu/dev/noc_work/lwnoc_atb_noc`）

所有 `_pub.f` filelist 存储在**独立仓库的 `vc/` 目录**，不在 demo 目录中。

---

## 2. 环境配置

### 前置条件

```bash
# 设置 lwnoc_topo (UHDL 框架)
export PYTHONPATH=/path/to/lwnoc_topo:$PYTHONPATH

# 验证各 demo 的子模块路径正常：
cd lwnoc_sts_noc_demo && python3 -c "from StsTemplate import *; print('OK')"
cd soc_atb_noc      && python3 -c "from AtbTemplate import *; print('OK')"
```

### 生成流程详解

1. **TemplateIPConfig** — 描述一个 IP 实例（名称、前缀、filelist、参数）
2. **TemplateComponent** — 将 TemplateIP 与 VComponent（pyslang 解析器）包装成一个 UHDL 组件树
3. **UhdlComponentNode** — 单一 IP 节点（如一个 INIU sys-side）
4. **UhdlWrapperNode** — 组合节点，组装多个子节点和接口
5. **TopologySerializer** — 将节点图保存为 JSON（用于调试）
6. **`.build()`** — 递归在所有 wrapper 节点上调用 `build_uhdl()`，生成 `Component` 树
7. **`.generate_verilog()`** — 从 Component 树输出 `.v` 文件
8. **`.generate_filelist()`** — 输出 `filelist.f`（包含 `-f` 引用子 IP）

---

## 3. 修改指南

### 3.1 理解输入

各 demo 的输入：

| 输入 | 位置 | 说明 |
|------|------|------|
| RTL 源码 | 独立仓库 `rtl/` | INIU、TNIU、decoder、switch 等模块的 SystemVerilog |
| Filelists | 独立仓库 `vc/*.f` | 各 IP 组件的编译顺序和文件组 |
| `_pub.f` filelists | 独立仓库 `vc/*_pub.f` | 自包含发布 filelist（不含 FCIP/LP 依赖） |
| LP 包 | 独立仓库 `lwnoc_lowpower_component/` | 低功耗协议类型定义 |
| 节点类 | Demo 目录 `*Node.py` | UHDL 节点定义，将 RTL 模块映射到 UHDL |
| 模板 | Demo 目录 `*Template.py` | IP 配置（参数、环境变量、filelist 路径） |
| 拓扑 | Demo 目录 `*Topo.py` | 节点实例和连线 |
| 生成脚本 | Demo 目录 `gen_*_topo.py` | 构建流水线和输出布局 |

### 3.2 修改 RTL

修改 RTL 端口名或增减端口：

1. 在**独立仓库**中编辑 `.sv` 文件（例如 `/home/lgzhu/dev/noc_work/lwnoc_sts_noc/rtl/tniu/sts_tniu_top.sv`）
2. 更新对应节点的 `add_interface()` 正则表达式（在 `*Node.py` 中）
3. 重新生成：`cd demo_dir && python3 gen_*_topo.py`

**关键规则**：
- **顶层模块**（直接被 `TemplateComponent` 实例化的）：struct 类型端口必须转换为显式位宽（例如 `[118:0]`），内部添加 cast 信号——这可以避免 pyslang 的嵌套 struct 别名解析 bug
- **内部模块**（在顶层模块内部实例化的）：可以保留 struct 类型端口
- 修改 RTL 端口为 vector 后，从 `*Node.py` 中对应的 `TemplateComponent(...)` 调用中删除 `struct_mode="packed"`

### 3.3 修改节点配置

各 IP 的参数在 `*Template.py` 中定义为 `TemplateIPConfig` 对象：

```python
# 示例：STS sys-side 配置
vpu_ss_tniu_sys_config = TemplateIPConfig(
    name="vpu_ss_tniu_sys",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="VPU_SS_TNIU_SYS_OUT_DIR",
)
# 添加参数覆写
vpu_ss_tniu_sys_config.param_overrides = {
    "DBG_TIMESTAMP_WIDTH": 64,
    "DBG_DATA_WIDTH": 32,
}
```

修改参数：
- **设计尺寸常量**（WIDTH、DEPTH、NUM）：编辑 `*Template.py` 中的 `param_overrides`
- **Filelist 路径**：编辑 `filelist=` 参数或更新引用的 `.f` 文件
- **前缀/环境变量**：修改 `TemplateIPConfig` 构造函数中的对应参数

### 3.4 增删节点

添加新节点实例（例如为新子系统添加新 TNIU）：

1. **如果新节点类型**（新 RTL 模块）：在 `*Node.py` 中添加节点类和 `add_interface()` 调用
2. **如果新实例**（已有 RTL，新配置）：在 `*Template.py` 中添加新 `TemplateIPConfig`
3. **连接到拓扑**：在 `*Topo.py` 中添加 `setattr(self, "new_node_name", NewNodeClass(...))` 和 `connect(...)` 调用
4. **加入 harden**：更新 Topo 类中的 `harden_dn_leaf_names` / `harden_up_leaf_names`
5. **更新 gen 脚本**：如果 gen 脚本显式引用节点，添加引用

### 3.5 修改拓扑结构

拓扑（节点如何连接）在 `*Topo.py` 中定义：

```python
class StsSocLogicTopo(UhdlWrapperNode):
    def __init__(self):
        super().__init__(id=SOC_STS_NOC_TOP_ID)
        # 接口声明
        self.add_interface("clk_sys", is_global=True)
        # 节点实例
        self.aon_ss_iniu = StsIniuNode(...)
        self.dec0 = StsDecNode(...)
        # 连线
        connect(self.aon_ss_iniu.req, self.dec0.mst_req)
```

修改拓扑：
- 修改 `connect()` 调用来重新连线
- 通过 `setattr(self, "name", node)` 增删节点
- 时钟域：对扇出时钟使用 `is_global=True`

### 3.6 修改输出文件格式和布局

gen 脚本（`gen_*_topo.py`）控制输出布局：

```python
# 输出目录
BUILD_DIR = THIS_DIR / "build_logic"

# 主拓扑输出
comp.generate_verilog(iteration=True)
comp.generate_filelist(abs_path=False, prefix="$SOC_PREFIX")

# 硬分区输出 → top_wrap_dir（扁平聚合，memnoc 模式）
top_wrap_dir = str(BUILD_DIR / "sts_soc_top_wrap")
hc.output_dir = top_wrap_dir  # ← 所有 harden .v 输出到 top_wrap 目录
hc.generate_verilog(iteration=True)
hc.generate_filelist(abs_path=False, prefix="$SOC_PREFIX")

# 最终聚合 wrapper
rtw_comp = ring_top_wrap.build_uhdl()
rtw_comp.output_dir = top_wrap_dir
rtw_comp.generate_verilog(iteration=True)
```

修改输出布局：
- **修改输出根目录**：修改 `BUILD_DIR`
- **扁平 vs 分层**：harden `.v` 文件 → `top_wrap_dir`（扁平）；IP template `.v` 文件 → `BUILD_DIR/<ip_name>/`（分层）
- **Filelist 前缀**：修改 `generate_filelist()` 的 `prefix=` 参数
- **Filelist 格式**：`abs_path=False` 使用相对路径，`True` 使用绝对路径

### 3.7 增删拓扑结构（硬分区）

硬分区将 NoC 按时钟域分组：

```python
# 在 gen_*_topo.py 中：
dn_harden = UhdlWrapperNode("soc_sts_dn_harden")
dn_harden.add_interface("clk_harden_dn_func", is_global=True)
for name in sorted(logic_wrapper.harden_dn_leaf_names):
    setattr(dn_harden, f"{name}_top", node.top_side)
    connect(sub.clk_dst, dn_harden.clk_harden_dn_func)
```

`*Topo.py` 中定义的 `harden_dn_leaf_names` / `harden_up_leaf_names` 控制哪些节点进入哪个分区。

重新组织：
- 修改 `*Topo.py` 中的 leaf name 集合
- 硬分区使用 wrapper 节点的 `.top_side` 属性（在 `*Node.py` 中定义）
- 聚合 wrapper 通过 `u_dn_harden` / `u_up_harden` 嵌套硬分区

---

## 4. 各 Demo 特性

### 4.1 INTR (`lwnoc_intr_noc_demo/soc_intr_noc/`)

- **用途**: 中断环网络（INIU 收集中断 → 环 → TNIU 投递到 CPU）
- **特殊文件**: `filelist/` 含 LP 包包装器、`tools/intr_gen_preflight.py`（预检）、`tools/intr_gen_publish.py`（发布辅助）
- **节点类型**: `SocIntrIniuSysNode`、`SocIntrIniuTopNode`、`SocIntrIniuNode`（wrapper + .top_side）、环 station/buf/sp、xbar LUT
- **硬分区**: `soc_intr_ring_noc_dn_harden_wrap`、`soc_intr_ring_noc_up_harden_wrap`
- **环拓扑**: 环 station + 环 buf 节点形成环形总线

### 4.2 STS (`lwnoc_sts_noc_demo/`)

- **用途**: SoC 调试/追踪网络（APB 主机收集追踪数据）
- **特点**: TNIU sys/top 分离 + 正确分离的 INIU wrapper
- **节点类型**: `StsIniuSysNode`、`StsIniuTopNode`、`StsIniuNode`（wrapper）、`StsDecNode`（n-ary）、`StsTniuWrapNode`（wrap）
- **解码器**: n-ary 基于路由的解码器（`SLAVE_NUM` 参数化）
- **不需要 LP 包**（此协议无低功耗端口）

### 4.3 ATB (`soc_atb_noc/`)

- **用途**: ATB 追踪漏斗网络（DSP 追踪数据经 funnel → 异步桥）
- **特点**: Funnel + Aggregator 节点、异步桥用于时钟域交叉
- **节点类型**: `AtbIniuSysNode/TopNode/Node`、`AtbTniuSysNode/TopNode/Node`、`AtbFunnelNode`、`AtbAsyncBridgeNode`
- **Filelists**: `filelist/atb_async_bridge.f`、`filelist/atb_funnel.f`（本地）、`_pub.f` 在独立仓库 `vc/` 中
- **LP 包**: RTL 需要，通过自包含 `_pub.f` filelists 提供

### 4.4 DTI (`soc_dti_noc_demo/`)

- **用途**: DTI 数据传输网络（类似 AXI 流的数传器）
- **特点**: 基于 switch（4x）的拓扑 + 异步桥
- **节点类型**: `DtiIniuSysWrapNode`/`TopWrapNode`/`Node`、`DtiTniuSysWrapNode`/`TopWrapNode`/`Node`、`DtiSwitchNode`（3i1o、4i1o、5i1o、6i1o）、`DtiReqRspAsyncBridgeNode`
- **LP 包**: 需要，通过独立仓库 `vc/` 中的 `_pub.f` 提供

---

## 5. 常见操作参考

### 5.1 快速重新生成所有四个 Demo

```bash
cd /home/lgzhu/dev/noc_work/lwnoc_network_demo

# INTR
cd lwnoc_intr_noc_demo/soc_intr_noc
rm -rf build/temp build_logic build
python3 gen_soc_intr_topo.py

# STS
cd ../../lwnoc_sts_noc_demo
rm -rf build/temp build_logic build
python3 gen_sts_soc_topo.py

# ATB
cd ../soc_atb_noc
rm -rf build/temp build_logic build
python3 gen_soc_atb_topo.py

# DTI
cd ../soc_dti_noc_demo
rm -rf build/temp build_logic build
python3 gen_dti_topo.py
```

### 5.2 添加新 SS 实例（所有 demo）

1. `*Template.py`: 添加 `TemplateIPConfig(name="new_ss_iniu_sys", ...)`
2. `*Node.py`: 添加 `setattr(self, "new_ss_iniu", ...)`（如果使用已有节点类，直接实例化即可）
3. `*Topo.py`: 实例化 + 连线 + 添加到 harden leaf 列表
4. `gen_*_topo.py`: 无需修改（通过 `harden_dn_leaf_names` 自动处理）

### 5.3 修改输出 Filelist 前缀

编辑 `*_topo.py` 中的 `prefix=` 参数：
```python
comp.generate_filelist(abs_path=False, prefix="$NEW_PREFIX")
```

### 5.4 添加新硬分区

1. `*Topo.py`: 添加新的 `harden_new_leaf_names` 元组
2. `gen_*_topo.py`: 添加新 `UhdlWrapperNode("new_harden")` 块 + expose/build/generate
3. `gen_*_topo.py`: 通过 `setattr(ring_top_wrap, "u_new_harden", new_harden)` 嵌套到聚合 wrapper 中

---

## 6. 故障排查

### 6.1 生成 Verilog 中出现 `[-1:0]`

**根因**: pyslang 无法解析嵌套 struct typedef 别名的 `bitWidth`。**修复**: 在顶层 RTL 模块中将 struct 端口转换为显式位向量，内部添加 cast 信号。

参考 `lwnoc_sts_noc/rtl/tniu/sts_tniu_top.sv` 中 cast 模式的示例。

### 6.2 构建时出现 `ErrAttrMismatch`

**原因**: 连接的两个节点之间 `struct_mode="packed"` 不一致。一个节点的 IO 是 `UInt(N,0)`（packed），另一个是 `StructIO`（unpacked）。

**修复**: 确保所有连接节点要么都用 `struct_mode="packed"`，要么都不用。如果顶层 RTL 端口已经是 vector（非 struct 类型），从 `*Node.py` 中对应的 `TemplateComponent(...)` 调用中删除 `struct_mode`。

### 6.3 `_pub.f` 文件找不到

**修复**: 确保独立仓库（而非 demo 目录）的 `vc/` 中包含 `_pub.f` 文件。Demo 的 Template.py 从独立仓库路径读取：
```bash
# 检查你的 demo 使用哪个路径：
grep "EXTERNAL.*ROOT\|DEFAULT.*ROOT" *Template.py
```
