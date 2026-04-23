# Soc Intr Topology Parameter Guide

Date: 2026-04-21

## 1. 先回答结论

- 如果目标是修改不同 node 的参数传递入口，主要改三层：
  1) 配置层: SocIntrTemplate.py
  2) 绑定层: SocIntrNode.py
  3) 生成验证层: build_logic 下对应 node 目录与生成 wrapper 实例
- 目前 soc_intr 不是“所有参数都已注册到 Node.py”的状态。
  - Node.py 里显式传参只有少量结构/深度参数。
  - Template.py 目前没有 set_macro 或 set_param_override 调用。
  - 很多 define 来自上游 RTL 默认宏，不等于已在 topo/node 层被显式注册。

## 2. 文件级职责地图

### 2.1 SocIntrTemplate.py (参数所有权的首选位置)

- 作用:
  - 创建 TemplateIPConfig
  - 选择 filelist
  - 绑定 env_var 和 prefix
- 当前关键对象:
  - INIU_SYS_CONFIGS
  - TNIU_SYS_CONFIGS
  - soc_intr_iniu_top_config
  - soc_intr_tniu_top_config
  - soc_intr_ring_*_config

推荐改法:
- 全局同类参数(同一类 node 都一样): 在对应 config 对象处统一设置。
- 按 node 差异参数(不同 ss 不同值): 在 INIU_SYS_CONFIGS / TNIU_SYS_CONFIGS 构建循环内按 node_name 条件分配。

示例思路(伪代码):
- 在 for node_name in INIU_NODE_NAMES 循环里:
  - cfg = _new_cfg(...)
  - if node_name in override_map: cfg.set_macro("PARAM_NAME", value)
  - INIU_SYS_CONFIGS[node_name] = cfg

### 2.2 SocIntrNode.py (拓扑绑定层)

- 作用:
  - 定义 UhdlComponentNode / UhdlWrapperNode
  - 把 config 绑定到 TemplateComponent
  - 连接接口
- 当前已显式传的参数(来自实测):
  - ASYNC_FIFO_DEPTH (INIU/TNIU sys 和 top)
  - RING_ID
  - NODE_NUM
  - HAS_INIU
  - HAS_TNIU

推荐改法:
- 只有当参数确实属于“拓扑实例绑定语义”时，才在 Node.py 的 TemplateComponent(...) 里直接传。
- 业务/协议特征参数优先放 Template.py 的 config.set_macro。

### 2.3 gen_soc_intr_topo.py (生成/发布流程)

- 作用:
  - generate("dv") / generate("pd")
  - filelist bootstrap
  - postprocess / publish
- 使用方式:
  - 参数逻辑改完后，用该入口重新生成，再做 build_logic 证据检查。

## 3. 参数修改实操流程

1) 明确参数归属
- 协议/功能宏: 优先 Template.py
- 拓扑结构实例参数: Node.py

2) 在 SocIntrTemplate.py 加入或更新参数
- 全局参数: 直接在配置对象赋值
- 分 node 参数: 在 INIU_SYS_CONFIGS/TNIU_SYS_CONFIGS 循环内按 node_name 赋值

3) 若需要，在 SocIntrNode.py 绑定参数到 TemplateComponent
- 避免重复把同一语义参数同时放在 Template.py 和 Node.py 两处

4) 重新生成
- 调用 gen_soc_intr_topo.py 的 generate("dv") 或 generate("pd")

5) 校验
- 看对应 node 的 build_logic/<node>_sys/*_filelist.f
- 看对应 wrapper 实例是否出现期望参数覆盖
- 必要时检查 top wrapper 中相关端口与连线

## 4. 关于“memnoc define 很全，intr 不是”

这两件事不能直接画等号。

- memnoc 的 ocm_lwmnoc_define.sv 宏很多，主要因为:
  - 上游 mnoc RTL 自身定义宏体系完整
  - MemTemplate.py 有大量 set_macro 覆盖
- soc_intr 的 ddr6_iniu_soc_intr_niu_ring_noc_define.sv 目前很简，是因为:
  - 该 define 文件更多承担 prefix/define 桥接
  - SocIntrTemplate.py 当前未做 set_macro 覆盖
  - 上游 interrupt_noc 的默认宏不等于已被 topo/node 显式注册

所以结论是:
- 当前 soc_intr 仍是“部分参数显式注册 + 大量参数走源 RTL 默认”的状态。
- 若要达到 memnoc 那种“参数可见、可控、可按 node 定制”的程度，需要把目标参数系统性迁移到 Template.py 的配置层，并仅在必要时由 Node.py 传实例绑定参数。

## 4.1 为什么现在不把所有参数都放到模板层 set_macro

不是不能放，而是没必要把所有参数都升级成 topo 层可配项。

推荐判定规则:
- 保留上游 RTL 默认值（先不 set_macro），当且仅当同时满足:
  1) 不需要按 node 做差异化
  2) SoC 集成接口不要求把该参数暴露为可配置项
  3) 现有默认值已满足功能/时序目标
- 升级到 Template.py set_macro，只要满足任一条件:
  1) 需要按 node/场景做不同值
  2) 需要集成层显式可控和可审计
  3) 默认值已不满足目标，需要可重复覆盖

这样做的好处:
- 避免把“稳定不变的内部实现参数”都暴露出来，减少配置面和维护负担。
- 把真正需要配置治理的参数集中到模板层，便于审计和跨 demo 对齐。

## 4.2 当需求明确为“按 ai memnoc 一样做”时

如果需求同时包含两点:
1) 需要支持不同 node 提供不同 param
2) 目标是与 ai memnoc 参数治理风格对齐

则应采用覆盖规则（高于 4.1 的默认保守策略）:
- 语义参数统一上收到 Template.py（`set_macro` + override map）
- Node.py 尽量保持 bind-only，只承载拓扑结构绑定，不重复承载语义参数策略

可执行落地建议:
- 在 `INIU_SYS_CONFIGS` / `TNIU_SYS_CONFIGS` 构建过程中维护每个 node 的参数覆盖表
- 对需要差异化的参数逐项迁移到 config 层，并在生成后用 wrapper 实例证据回归验证

## 4.3 soc intr noc 对齐 ai memnoc 的验收标准

当需求是“soc intr noc 应该和 ai memnoc 一样做”时，建议按以下 3 项同时通过才算完成:

1) 模板层所有权成立
- 需要按 node 差异化的语义参数，必须在 `SocIntrTemplate.py` 的配置映射中可见（例如 `INIU_SYS_CONFIGS` / `TNIU_SYS_CONFIGS` 覆盖表）。

2) Node 层不重复承载语义策略
- `SocIntrNode.py` 保持 bind-only，不再为同一语义参数保留重复策略入口（结构绑定参数除外）。

3) 生成证据闭环
- 重新生成后，在目标 node wrapper 的实例参数中能看到差异化结果，并可用命令行做机器可读验证。

## 4.4 当前状态结论（截至 2026-04-21）

针对“现在 intr soc noc 对 param 的设置是否已对齐 ai memnoc”这个问题，当前结论是：
- 还没有完全对齐（not-yet-aligned）。

依据（机器可读）:
- `SocIntrTemplate.py` 当前未检出 `set_macro` / `set_param_override`。
- ai memnoc 的 `MemTemplate.py` 与 `ai_ring/MemTemplate.py` 已有大量按 node 的 `set_macro`。
- `SocIntrNode.py` 仍承载一部分语义参数直传（例如 `ASYNC_FIFO_DEPTH`），尚未形成“模板层统一语义治理 + Node 层 bind-only”的完整形态。

增量更新（本轮已完成）:
- `ASYNC_FIFO_DEPTH` 已迁移到 `SocIntrTemplate.py` 的 `set_macro`（INIU/TNIU sys + top），`SocIntrNode.py` 不再直传该参数。
- `NODE_NUM` 已迁移到 ring config 的 `set_macro`。

仍未完成的全量对齐项:
- `RING_ID` / `HAS_INIU` / `HAS_TNIU` 目前仍在 `SocIntrNode.py` 的 `TemplateComponent(...)` 直传。
- 因此当前状态应标记为 `partially-aligned`，还不能标记为 `fully-aligned`。

## 5. 快速自检命令

- 检查 soc_intr 是否有 config 宏覆盖:
  - rg -n "set_macro\(|set_param_override\(" lwnoc_intr_noc_demo/soc_intr_noc
- 检查 Node.py 显式传参:
  - rg -n "ASYNC_FIFO_DEPTH|RING_ID|NODE_NUM|HAS_INIU|HAS_TNIU" lwnoc_intr_noc_demo/soc_intr_noc/SocIntrNode.py
- 对比 memnoc 参数覆盖密度:
  - rg -n "set_macro\(" /home/lgzhu/dev/noc_work/aichip_memnoc_aichip_dev/MemTemplate.py /home/lgzhu/dev/noc_work/aichip_memnoc_aichip_dev/ai_ring/MemTemplate.py

## 6. 路径关系与是否可删（lwnoc_intr_noc_demo vs soc_intr_noc_demo）

当前状态（基于本仓机器可读检查）:
- 本轮更新主要落在 `lwnoc_intr_noc_demo/soc_intr_noc/`（当前为未跟踪新目录）。
- `soc_intr_noc_demo/` 仍是 git 已跟踪目录，且包含大量已跟踪文件（含生成物）。

删除建议:
- 在未获得“接受大规模 tracked delete”的明确授权前，不建议直接删除 `soc_intr_noc_demo/`。
- 若要删除，应先走一次“迁移闭环 + 引用清零 + 提交策略确认”，再执行物理删除。

## 7. build_logic/soc_intr_noc_wrap 是做什么的

目录: `lwnoc_intr_noc_demo/soc_intr_noc/build_logic/soc_intr_noc_wrap/`

它的角色:
- 它是 DV 主拓扑的“编译入口适配 wrapper（compile-ingress adapter）”。
- `soc_intr_noc_wrap.v` 外层只做一层端口透传，把内部生成顶层（例如 `soc_intr_ring_top`）包起来。
- `filelist.f` 先引入内部 top 的 filelist，再把 wrapper 本身加入编译入口。

为什么需要它:
- 稳定编译入口名字：上层编译脚本只盯一个固定 wrapper 入口，不受内部 top 命名调整影响。
- 入口解耦：把“功能 RTL 生成”与“发布给编译系统的入口形态”分离。
- 便于 shared build_logic packaging：DV live ingress 通过 `soc_intr_noc_wrap/filelist.f` 进入 full-top publish root；PD 不再额外发布 `soc_intr_noc_wrap_pd` 薄壳，`filelist_pd/filelist_harden.f` 直接指向 `soc_intr_ring_top_pd/filelist.f`，只保留切出来的 harden 分区和其 assembly top。

证据链（源码）:
- 生成 wrapper 的核心函数在 `gen_soc_intr_topo.py`：`_publish_named_top_wrapper(...)`
- 发布 DV 入口的函数在 `gen_soc_intr_topo.py`：`_publish_top_filelist(...)`
- 最终 compile 入口在 `filelist/filelist.f`，会 `-f build_logic/soc_intr_ring_top/filelist.f`

如果要改，应该怎么改:

1) 不要直接手改 `build_logic/soc_intr_noc_wrap/soc_intr_noc_wrap.v`
- 该目录是生成产物，重跑生成会覆盖。

2) 按改动类型改“源”
- 端口/连接逻辑改动: 改 `SocIntrNode.py` / `SocIntrTopoDv.py` / `SocIntrTopoPd.py`
- wrapper 命名、发布 filelist 结构改动: 改 `gen_soc_intr_topo.py` 里的 `_publish_named_top_wrapper` / `_publish_top_filelist`
- 编译入口组合顺序改动: 改 `filelist/filelist.f`（若策略要长期生效，优先回写到生成逻辑而不是只改产物）

3) 重新生成并验证
- 重新执行 `gen_soc_intr_topo.py`（DV/PD 对应 flow）
- 验证 `build_logic/soc_intr_ring_top/filelist.f` 与 `filelist/filelist.f` ingress 一致
- 验证 `build_logic/soc_intr_noc_wrap/filelist.f` 仅作为同根附加 wrapper 发布物存在，不再作为 live DV ingress
- 验证 `soc_intr_noc_wrap.v` 端口与内部 top 实例映射满足预期
