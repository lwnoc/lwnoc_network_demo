# 问答压缩总结（2026-04-25）

## 一、目标
- 把此前多轮问答压缩成可复用 md，并保留关键技术决策、已完成项、未完成项与下一步顺序。

## 二、核心结论
- 生成框架方向已统一到“聚合 wrapper 优先、避免物理 merge 单实例 RTL”。
- ATB 关键修复已落地：filelist 入口应基于源侧 `vc/*_comp.f`，不依赖 `work/*` 后处理产物。
- DTI 拓扑已重写为 4-switch 结构并可再生通过；Node 架构已完成去 factory 与 cfg 注入改造。
- 技能规则已强化，但曾出现文档内前后冲突（Node.py 是否允许导入 Template.py），本轮已修正一致。

## 三、已完成事项
- STS/ATB/DTI 的 `gen_*_topo.py` 迁移到聚合式生成思路。
- ATB filelist 依赖路径修复完成。
- DTI：
  - 端点配置补齐
  - 4-switch 连接重建
  - prefix 与 node-id 冲突问题清理
  - Node.py 结构纠偏完成（无 factory、无 Template 反向导入、cfg 从 Topo 注入）
- lwnoc-topo skill 增加并固化多项门禁。

## 四、未闭环事项（按优先级）
1. INTR 仍是主缺口：结构、依赖方向、文件组织需系统整改。
2. STS/ATB 需按最新 Node 依赖方向门禁做完整复查。
3. DTI 遗留 `DtiSharedTcuSwitch*` 需清理或隔离，避免域名硬编码复用受限。
4. 你先前要求的全面修改计划文件仍需按约定路径生成并执行。

## 五、过程中的高价值经验
- 拓扑类任务容易出现“能跑但不规范”的假闭环，必须以 source -> regen -> ingress compile 作为唯一闭环证据。
- Node/Template/Topo 的依赖方向必须严格单向，否则会反复返工。
- 规则文档自身一致性很重要；同一文件内冲突会直接放大执行偏差。

## 六、建议执行顺序
1. 先完成 INTR 架构合规改造与再生验证。
2. 再做 STS/ATB 依赖方向一致性复查。
3. 最后清理 DTI legacy 节点并做全量回归检查。

## 七、本轮实际产物
- 复盘与改进报告已生成（含 Findings/Proposals/Priority）。
- 压缩版问答摘要已落地为本文件。

## 八、主要任务总览（本次更新）

### 已完成（与当前 todo 对齐）
- P1a: ATB dn_harden 已补充 debug_tniu top_wrap。
- P1b: ATB soc_topo filelist.f 已修复。
- P1c: ATB 已完成 sed 路径思路向 source-level 方案迁移。
- STS driver 结构重构已独立保留。
- 已完成重新生成并通过门禁检查。

### 仍需推进（跨 demo 规范收口）
1. INTR: 按最新门禁完成 Node/Template 依赖方向与工厂函数问题整改。
2. STS/ATB: 继续按统一门禁做 Node 层一致性复查，消除旧模式残留。
3. DTI: 清理或隔离 DtiSharedTcuSwitch 相关 legacy 代码，避免域特化硬编码继续外溢。
4. 计划落地: 把整改步骤、验收命令、完成判据固化到既定计划文件并按顺序执行。

### 验收口径（保持一致）
- 以可再生为先: topo build + wrapper 生成 + filelist 入口有效。
- 以可编译为证: 入口 compile 不报新阻断错误。
- 以规范一致为准: 依赖方向、命名和 filelist 分层符合统一 gate。
