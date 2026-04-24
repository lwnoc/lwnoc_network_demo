# STS NoC Topology Generation — 修改指南

## 文件职责

| 文件 | 职责 |
|------|------|
| `StsTemplate.py` | RTL 组件的 TemplateIPConfig 定义（filelist 路径、发布目录、参数覆盖、路由表） |
| `StsNode.py` | UHDL 节点类定义（接口映射、组件实例化） |
| `StsSocTopo.py` | SoC 级拓扑连接（节点间连线、harden 分组、时钟域分配） |
| `gen_sts_soc_topo.py` | 生成驱动（建拓扑 → 生成 Verilog/filelist → merge 单例 → harden wrapper） |

## 修改场景

### 加新 leaf 节点（如 wifi_ss_tniu）

四步：

**1. StsTemplate.py** — 加 config
```python
wifi_ss_tniu_sys_config = TemplateIPConfig(
    name="wifi_ss_tniu_sys",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="WIFI_SS_TNIU_SYS_OUT_DIR",
)
wifi_ss_tniu_top_side_config = TemplateIPConfig(
    name="wifi_ss_tniu_top_side",
    prefix="",
    filelist=str(STS_NOC_ROOT / "vc" / "tniu_filelist.f"),
    env_var="WIFI_SS_TNIU_TOP_SIDE_OUT_DIR",
)
wifi_ss_tniu_top_side_config.param_overrides = _tniu_params(3)  # next tniu_idx
wifi_ss_tniu_top_side_config.top_wrap = "sts_tniu_top"
```

**2. StsNode.py** — 节点类已存在则只需用 `StsTniuWrapNode`，无需新 class

**3. StsSocTopo.py** — 加节点 + 连线
```python
self.wifi_ss_tniu = StsTniuWrapNode(
    id="wifi_ss_tniu",
    sys_cfg=wifi_ss_tniu_sys_config,
    top_cfg=wifi_ss_tniu_top_side_config,
    top_wrap="sts_tniu_top",
)
# 连接到 decoder
connect_leaf(self.dec0, 2, "wifi_ss")
```

**4. gen_sts_soc_topo.py** — 如果单例则加进 `_SINGLE_INSTANCE`
```python
_SINGLE_INSTANCE = {"vpu_ss_tniu_top_side", ..., "wifi_ss_tniu_top_side"}
```

### 改路由关系

改 `StsSocTopo.py` 的 `connect()` 调用：
```python
# 把 vpu_ss 从 dec0.0 改到 dec0.1
connect_leaf(self.dec0, 1, "vpu_ss")
# 把 camera_ss 从 dec1.0 改到 dec0.2
connect_leaf(self.dec0, 2, "camera_ss")
```

### 改地址映射表

改 `_iniu_params` 中的三个表（base/mask/target_id）或改 `_tniu_window_bases` / `_tniu_target_ids` 函数。改前先画出：

```
TNIU idx | Window base | TGT ID base
0         | 0x0000       | 0x40
1         | 0xC000       | 0x50
2         | 0x18000      | 0x60
3         | 0x24000      | 0x70
```

然后对照公式调整函数。

### 改 decoder 路由表

改 `StsTemplate.py` 中 `soc_sts_dec4_config` 的属性：
```python
soc_sts_dec4_config._route_base_table = [0x40, 0x30, 0x20, 0x10]  # MSB-first slot IDs
soc_sts_dec4_config._route_mask_val = 0xF0
```

### 改 TNIU APB 路由

改 `_tniu_params()` 函数中的 `local_base` 偏移：
```python
def _tniu_params(tniu_idx: int) -> dict:
    local_base = tniu_idx << 4  # 每 TNIU 占 16 个 APB slot
    ...
```

### 改 harden 分组

改 `StsSocTopo.py` 的两个集合：
```python
harden_dn_leaf_names = {"vpu_ss", "camera_ss", "wifi_ss"}  # 加到 dn
harden_up_leaf_names = {"dspss0", ..., "dspss5"}
```

### 改单例/多例发布策略

- **单例化**（只例化一次）：在 `gen_sts_soc_topo.py` 的 `_SINGLE_INSTANCE` 集合中加入 config name
- **多例化**（例化多次）：不在 `_SINGLE_INSTANCE` 中，自动保留独立目录

**约束**：单例化组件的 RTL 必须合入 `soc_sts_noc/` 目录，这是永久方案，不是过渡方案。

## 关键约束（门禁）

1. **Node 类名不得编码配置参数**：`StsDecNode` 而非 `StsDec4Node`
2. **Route 表由 cfg 驱动**：不得在 node 代码中硬编码 `[0x30, 0x20, 0x10, 0x00]`
3. **单例合入是永久方案**：gen 脚本的 `_SINGLE_INSTANCE` + merge 逻辑不得删除
4. **所有 prefix 必须为 ""**：否则 `_PREFIX_` 宏产生不同的 package namespace → struct 类型不匹配
5. **filelist 必须从 submodule 的 `vc/*.f` 引用**：不得手写本地 filelist

## 设计模式

```
StsTemplate.py (cfg)  ────  StsNode.py (node classes)
       │                           │
       └────────── StsSocTopo.py (topology) ────── gen_sts_soc_topo.py (driver)
                              │
                     build_logic/
                     ├── soc_sts_noc/        ← 单例组件合入 + top wrapper
                     ├── dspss_tniu_top_side/ ← 多例组件的独立目录
                     ├── soc_sts_up_harden/  ← 上行 harden wrapper
                     └── soc_sts_dn_harden/  ← 下行 harden wrapper
```
