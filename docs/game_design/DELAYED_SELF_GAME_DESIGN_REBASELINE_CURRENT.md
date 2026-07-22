# 《迟到的我 / Delayed Self》游戏设计重基线（CURRENT）

- 文档状态：`CURRENT / GPT-ACCEPTED DESIGN SUCCESSOR`
- 同步日期：2026-07-22
- 接受裁决：`TASK_0023ZW_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_ACCEPTED_WITH_BINDING_SEQUENCE_POLICY`
- 接受报告：`docs/reports/0023ZW_GPT_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_ACCEPTANCE.md`
- 旧基线：`docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`

## 1. 权威关系

本文是 2026-07-14 GDD 的继任补充源。旧 GDD 继续保留核心主题、基础回合、设计支柱、赛事目标和历史策划背景；以下内容如与旧 GDD 冲突，以本文为准：

- 目标关卡数量；
- 关卡序列与终章迁移政策；
- 核心机制扩展范围；
- 美术与表现方向；
- 默认语言目标；
- 音乐目标与许可证门；
- 2026-07-21 之后的提交路线图。

本文不授权产品实现、catalog 修改、Profile 写入、美术/字体/音乐导入、构建、发布或投稿。每个受保护面仍需独立任务门。

## 2. 当前实现基线

- 当前正式 catalog 恰好包含 8 关。
- 现有关卡 ID 与 sequence 1–8 必须保持稳定，不得重排或替换。
- 当前 sequence 8 `two_echo_convergence` 是唯一正式终章。
- 现有 Profile 的 completed IDs、best turns、unlock progression 和 settings 不得被重新解释或静默覆盖。
- 当前实现基线保持可运行，直到扩展内容通过后续独立门禁。

## 3. 已接受的投稿目标

- **12 个核心正式房间**，作为投稿稳定目标。
- **第 13–14 关仅为条件扩展**，只有在核心流程、日期余量和稳定性均满足时才进入。
- 新核心房间按 sequence 9–12 追加。
- sequence 8 在扩展后可成为第二章收束关，但在 catalog/finale gate 接受前仍保持当前唯一终章身份。
- sequence 12 是否成为新的唯一正式终章，必须通过后续 catalog、Profile 和终章兼容门。

## 4. 核心机制范围

### 4.1 投稿核心机制族

1. **YOU-only 推箱**：只有当前玩家能推动箱子；ECHO 只会被箱子阻挡，不重放推动。
2. **YOU-only 消耗钥匙与锁**：只有当前玩家能拾取、持有和消费钥匙；ECHO 不拾取、不解锁。
3. **成组多格屏障 / 桥梁**：以稳定 group ID 管理多个格子，状态变化从下一回合生效。
4. **类型化传感器**：`ANY_ACTOR`、`YOU_ONLY`、`ECHO_ONLY`，并显式声明箱子是否计入。
5. **房间内一次性 latch**：首次触发后保持终态，重开恢复初始状态。

这些机制必须共享同一 Simulation transition、canonical state、replay 与 BFS solver 逻辑，并保持 schema-v1 八关行为不变。

### 4.2 条件扩展机制

以下仅作为 13–14 关或日期余量充足时的候选：

- 成对传送门 / paired pads；
- 单向门；
- 易碎地板；
- 传送带。

不得为了增加机制数量牺牲核心 12 关的可读性、验证性和稳定性。

## 5. 谜题课程原则

- 扩展目标是增加**机制广度**，不是单纯提高难度。
- 禁止把项目变成通用 Sokoban；新谜题必须利用 YOU、ECHO、箱子与房间状态之间的不对称。
- 每个核心机制族至少应形成一个清晰 vertical slice，并能支撑多个高质量房间。
- 每个正式房间继续记录可解性、最短步数、最短解数量或 capped 状态、replay、restart 和机制必要性证据。
- 正式关卡数据只能在共享 schema/Simulation/solver 基础通过验收后进入 catalog。

## 6. 表现方向

接受的视觉身份为：**手绘延迟笔记本 / 墨迹 ECHO**。

- 暖色纸张、手绘边框、轻微不规则墨线；
- ECHO 使用延迟墨迹、残影或错位线条表达；
- 底层格子、碰撞和机关逻辑保持确定性；
- UI 必须同时使用形状、图标和文字，不得只依赖颜色；
- `LXGW WenKai GB / 霞鹜文楷 GB` 仅为候选字体，须完成 OFL、中文覆盖、fallback、文本适配和包体审查后才能导入。

## 7. 语言与 Profile

- 投稿目标默认语言为简体中文。
- 新 Profile 默认值可在后续兼容门中改为 `zh-Hans`。
- 现有 Profile 的语言设置不得静默覆盖。
- 中文范围至少覆盖：标题、菜单、教程、Help、Timeline、关卡名、错误、结算、终章、设置、Credits 和归属声明。
- 完整英文属于投稿后范围；若保留少量英文，必须不阻塞中文完整度与稳定性。

## 8. 音频目标

- 最小目标：2 条循环音乐，加 1 条可选克制终章 cue。
- Crow Producer 素材只有在 track identity、来源、许可证台账、编辑/转换解释与归属位置全部完成后才能导入。
- 必须使用可见归属：`音乐由[乌鸦Producer]提供`。
- 没有许可证闭环时，宁可保持静音或最小安全音频，也不得推断使用权。

## 9. 当前开发路线

权威路线图：`docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md`。

执行顺序：

```text
schema-v2 / Simulation / solver 基础验收
→ 机制 vertical slices
→ sequence 9–12 核心房间批次
→ 13–14 条件扩展判断
→ 手绘笔记本表现层
→ zh-Hans / 字体 / 文本适配
→ 音乐许可证台账与最小导入
→ Profile 默认激活与完整菜单
→ 完整流程机器验收
→ owner walkthrough
→ Windows 包、视频与投稿
```

当前执行点为 Task 0024T：对 provisional schema-v2/Simulation/solver 基础进行 manifest-locked 一次性完整验证。Task 0024T 通过前，不开始 sequence 9–12 正式关卡、catalog 扩展或表现层集成。

## 10. 硬性 scope cut

出现时间或稳定性压力时，按以下顺序缩减：

1. 永久推迟 13–14；
2. 移除最弱的核心机制族，而不是弱化验证；
3. 缩减英文、音频广度和装饰性表现；
4. 保留稳定的 8–12 关完整流程；
5. 不以修改既有 Profile、降低 solver/replay 证据或跳过 build 验收换取数量。

## 11. 非声明

本文不证明：

- schema-v2 基础已经验收；
- 9–12 已实现；
- sequence 12 已成为终章；
- zh-Hans 默认已经激活；
- 字体、音乐或美术已经导入；
- Windows 构建、发布、上传或投稿已获授权。
