# STS NoC Topology Generation — 修改指南

## 文件职责

| 文件 | 职责 |
|------|------|
| `StsTemplate.py` | RTL 组件的 TemplateIPConfig 定义（filelist 路径、发布目录、参数覆盖、路由表） |
| `StsNode.py` | UHDL 节点类定义（接口映射、组件实例化） |
| `StsSocTopo.py` | SoC 级拓扑连接（节点间连线、harden 分组、时钟域分配） |
| `gen_sts_soc_topo.py` | 生成驱动（建拓扑 → 生成 Verilog/filelist → compile ingress / harden wrapper） |

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

**4. gen_sts_soc_topo.py** — 负责 `build -> generate_verilog -> generate_filelist`
```python
comp.generate_verilog(iteration=True)
comp.generate_filelist(abs_path=False, prefix="$STS_SOC_NOC")
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

### 改发布目录 / compile ingress 策略

- 发布目录名、filelist ingress 和 env 变量都由 `TemplateIPConfig(name/prefix/env_var)` 决定
- `gen_sts_soc_topo.py` 只负责触发生成和写 compile ingress，不再维护历史上的单例合并分支
- 如果需要改变某类节点的发布面，优先改 `StsTemplate.py` 的 config，而不是在 gen 脚本里做目录级特殊处理

## 关键约束（门禁）

1. **Node 类名不得编码配置参数**：`StsDecNode` 而非 `StsDec4Node`
2. **Route 表由 cfg 驱动**：不得在 node 代码中硬编码 `[0x30, 0x20, 0x10, 0x00]`
3. **当前生成流以独立 publish 目录为准**：历史上的单例合并方案不是现行门禁
4. **decoder config 必须使用 per-dec prefix**：这是为避免同 arity decoder 在同一 compile 域下发生 generic wrapper/module 冲突
5. **“prefix 必须为空”是旧约束，不再是全局规则**：它最初用于规避 `_PREFIX_` 改写 package namespace 后的 struct 类型不匹配；当前只应按具体发布面判断是否保留空 prefix
6. **STS 生成出的 filelist env 变量统一以 `STS_` 开头**：便于与其他 demo 的 family-scoped 环境变量约定对齐
7. **filelist 必须从 submodule 的 `vc/*.f` 引用**：不得手写本地 filelist

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

## 跨四个 demo 的 publish env_var 约束

1. 生成 filelist 中出现的 `TemplateIPConfig.env_var` 必须在源侧就是 family-scoped。当前四个 demo 的统一约定是：`STS_`、`SOC_DTI_`、`SOC_ATB_`、`SOC_INTR_`。
2. 这是一条 repo 级统一约束；本节内容要与另外三个 demo 的同名 README 章节，以及 `lwnoc-topo` skill 中的对应规则保持一致。
3. STS 本 demo 的 live ingress 必须使用 `STS_` 前缀变量，不能再依赖未带 family 前缀的旧名字。
4. 命名源头在 `StsTemplate.py`；如果 env_var 需要调整，应改 config 本身，而不是补丁式改生成后的 filelist。
5. 如果本地 compile helper 需要兼容别名，只能放在现有的 `Makefile`/`compile_check.sh` 这类消费脚本里；除非用户明确要求，否则不要新增独立 `publish_env.mk`、`publish_env.sh` 一类导出文件。
