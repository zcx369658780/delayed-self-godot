# 《迟到的我 / Delayed Self》GPT Project Sources 同步包（CURRENT）

- 文档状态：`CURRENT / CONSOLIDATED SUCCESSOR FOR GPT PROJECT SOURCES`
- 同步日期：2026-07-22
- 仓库：`zcx369658780/delayed-self-godot`
- 分支：`main`
- 当前产品路线图接受裁决：`TASK_0023ZW_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_ACCEPTED_WITH_BINDING_SEQUENCE_POLICY`
- 当前技术验证门：`tasks/0024T_manifest_locked_complete_core_mechanics_final_validation_gate.md`
- 当前实现基线：8 个正式关卡
- 投稿目标：12 个核心关卡 + 2 个条件扩展关卡

## 1. 本文件的用途与权威边界

本文件是 2026-07-14 GPT Project Sources 三件套的 consolidated successor：

- `DELAYED_SELF_PROJECT_SOURCE_INDEX_CURRENT_2026_07_14.md`
- `DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT_2026_07_14.md`
- `DELAYED_SELF_PROJECT_RULE_SOURCE_CURRENT_2026_07_14.md`

旧文件继续作为历史种子，保留：

- 项目主题；
- 基础回合规则；
- 延迟 ECHO 核心；
- 数据驱动关卡；
- AI 求解器辅助；
- GitHub task-file 工作方式；
- 基础安全与发布边界。

以下内容如与旧文件冲突，以本文件和仓库 CURRENT 文档为准：

1. 目标关卡数量；
2. sequence 1–12 与终章迁移政策；
3. 核心机制扩展范围；
4. 表现、美术、语言和音频方向；
5. 2026-07-21 之后的开发路线图；
6. Godot headless 测试进程生命周期政策；
7. 当前活动任务和技术验收状态。

本文件不替代仓库事实。发生冲突时，优先级为：

```text
仓库实际状态
→ AGENTS.md
→ 当前 GitHub task 文件
→ docs/PROJECT_SOURCE_INDEX_CURRENT.md
→ 已接受设计重基线
→ 已接受扩展路线图
→ 本 consolidated 包
→ 旧 2026-07-14 种子
→ 对话记忆
```

## 2. 权威仓库文档

### 2.1 当前项目源索引

`docs/PROJECT_SOURCE_INDEX_CURRENT.md`

该索引明确：

- 旧 GDD 是历史/核心设计种子；
- `docs/game_design/DELAYED_SELF_GAME_DESIGN_REBASELINE_CURRENT.md` 是被接受的设计继任源；
- `docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md` 是当前日期化执行主轴；
- 当前任务文件控制具体可执行范围；
- CURRENT 文档优先于历史报告。

### 2.2 已接受设计重基线

`docs/game_design/DELAYED_SELF_GAME_DESIGN_REBASELINE_CURRENT.md`

它取代旧 GDD 中以下冲突部分：

- 目标关卡数；
- 关卡序列；
- 终章迁移；
- 机制扩展；
- 视觉身份；
- 投稿语言；
- 音频目标；
- 新路线图。

### 2.3 已接受扩展路线图

`docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md`

状态：

`GPT-ACCEPTED PRODUCT ROADMAP / IMPLEMENTATION REMAINS SEPARATELY GATED`

## 3. 游戏核心身份

《迟到的我》是一个小体量 2D 回合制延迟解谜游戏。

核心不变：

- YOU 每回合输入一次动作；
- ECHO 按各自延迟重放过去输入；
- 游戏世界以确定性回合快照结算；
- 谜题围绕 YOU、不同延迟的 ECHO、机关和局部房间状态之间的不对称；
- Simulation、replay 与 BFS solver 必须共享同一状态转移；
- 正式关卡必须有机器可验证的求解、回放、重开和必要性证据。

禁止把项目变成通用 Sokoban 或只靠地图变大提高难度。

## 4. 当前实现基线

当前正式 catalog 恰好包含 8 个稳定关卡：

1. `tutorial_reach_exit`
2. `tutorial_echo_bridge`
3. `vertical_slice_delay_3`
4. `door_one_turn_late`
5. `two_keys_one_door`
6. `staggered_doors`
7. `echo_spacing_bridge`
8. `two_echo_convergence`

绑定政策：

- 现有 ID 和 sequence 1–8 不得重排或替换；
- sequence 8 当前仍是唯一正式终章；
- 正式 catalog、8 个正式关卡 JSON 和 final flag 在独立 gate 前保持冻结；
- 现有 Profile 的 completed IDs、best turns、unlock progression 与 settings 不得重新解释或静默覆盖。

## 5. 已接受投稿目标

### 5.1 核心数量

- 稳定投稿目标：**12 个核心正式房间**；
- sequence 9–12 追加，不改写 1–8；
- 第 13–14 关：**条件扩展**，只在核心流程稳定且日期有余量时进入；
- 如果时间或稳定性不足，永久推迟 13–14。

### 5.2 终章政策

- sequence 8 在当前实现中保持唯一终章；
- 扩展完成后可成为第二章收束关；
- sequence 12 是否成为新的唯一正式终章，必须经过独立的 catalog、Profile 和 finale compatibility gate；
- 不得仅凭路线图移动 final flag。

## 6. 核心机制范围

### 6.1 投稿核心机制族

1. **YOU-only 推箱**
   - 只有当前 YOU 可以推动；
   - ECHO 被箱子阻挡；
   - ECHO 不重放推动动作。

2. **YOU-only 消耗钥匙与锁**
   - 只有 YOU 拾取、持有和消费；
   - ECHO 不拾取、不解锁。

3. **成组多格屏障 / 桥梁**
   - 使用稳定 group ID；
   - 多个格子共享状态；
   - 状态变化遵循确定的下一回合快照规则。

4. **类型化传感器**
   - `ANY_ACTOR`
   - `YOU_ONLY`
   - `ECHO_ONLY`
   - 显式声明箱子是否计入。

5. **房间内一次性 latch**
   - 首次触发后保持终态；
   - room-local；
   - restart 恢复初始状态。

所有机制必须共享：

- schema v2；
- LevelLoader；
- Simulation；
- canonical state；
- replay；
- BFS solver。

schema-v1 八关行为必须保持不变。

### 6.2 条件扩展机制

仅在核心稳定后考虑：

- paired portals / paired pads；
- 单向门；
- 易碎地板；
- 传送带。

这些机制不属于当前 12 关必需范围。

## 7. 谜题课程原则

- 扩展目标是增加机制广度，不是单纯提高难度；
- 每个机制族先形成清晰 vertical slice；
- 正式房间必须记录：
  - 可解性；
  - 最短步数；
  - 最短解数量或 capped 状态；
  - replay；
  - restart；
  - 机制必要性；
- 新房间不得在共享基础未验收前进入 catalog；
- 优先保持可读性、可验证性和稳定性；
- 发生压力时削减机制或关卡，不削弱验证门。

## 8. 表现方向

已接受视觉身份：

**手绘延迟笔记本 / 墨迹 ECHO**

目标包括：

- 暖色纸张；
- 手绘边框；
- 轻微不规则墨线；
- ECHO 使用延迟墨迹、残影或错位线条；
- 底层格子、碰撞与机关逻辑仍保持确定性；
- UI 使用形状、图标和文字冗余；
- 不得只依赖颜色传达状态。

候选字体：

`LXGW WenKai GB / 霞鹜文楷 GB`

但只有完成以下检查后才能导入：

- OFL / 许可证；
- 中文覆盖；
- fallback；
- 文本适配；
- 包体影响。

## 9. 语言与 Profile

投稿目标语言：

**简体中文**

未来可在独立兼容 gate 中将新 Profile 默认值设为：

`zh-Hans`

硬性约束：

- 现有 Profile 语言不得静默覆盖；
- completed IDs、best turns、unlock progression 与 settings 必须保留；
- 中文至少覆盖：
  - 标题；
  - 菜单；
  - 教程；
  - Help；
  - Timeline；
  - 关卡名；
  - 错误；
  - 结算；
  - 终章；
  - 设置；
  - Credits；
  - 归属声明；
- 完整英文属于投稿后范围，除非安全、有限且不妨碍中文完整度。

## 10. 音频目标

最小目标：

- 2 条循环音乐；
- 1 条可选、克制的终章 cue。

Crow Producer 素材只有在以下全部完成后才能导入：

- track identity；
- 来源；
- 许可证台账；
- 编辑/转换解释；
- 游戏内归属位置。

可见归属文字：

`音乐由[乌鸦Producer]提供`

许可证未闭环时，宁可保持静音或最小安全音频。

## 11. 日期化开发路线图

| Gate / 目标日期 | 退出证据 | 未通过时的硬 cut |
|---|---|---|
| 2026-07-23 scope finalization | 关卡数、终章、机制子集、Profile 政策接受 | 保留 8 关，不实施扩展 |
| 2026-07-30 shared mechanics + vertical slices | 机制合同、solver、测试 | 移除最弱机制族 |
| 2026-08-07 12 个核心房间批次 | 验证关卡、难度证据、owner 试玩 | 冻结稳定数量，不做 13–14 |
| 2026-08-12 stretch decision | 核心稳定、日期有余量 | 永久推迟 13–14 |
| 2026-08-17 表现 + zh-Hans | 可读 UI、字体、无语言覆盖 | 使用最小表现，英文推迟 |
| 2026-08-21 音乐试听/台账/导入 | 明确许可证与小包体 | 保持静音/最小安全音频 |
| 2026-08-25 Profile first-write/default/menu | 独立授权验收 | 不发布，不推断迁移 |
| 2026-08-29 完整流程机器验收 | 确定性 full-flow matrix | 移除可选 polish |
| 2026-09-01 owner walkthrough | owner 证据、阻断清零 | 先削减 stretch/content |
| 2026-09-03 Windows 包/视频准备 | 独立 build/package 证据 | 最终 scope freeze |
| 2026-09-06 投稿 | owner 明确投稿授权 | 不推断上传权限 |
| 2026-09-10 视频截止 | owner 明确视频投稿授权 | — |

日期是计划目标，不是自动授权。

## 12. 实施顺序

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

每个阶段仍需独立 GitHub task gate。

## 13. 当前技术状态

### 13.1 已接受 wrapper 资格

Task 0024S 已被 GPT 接受：

`TASK_0024S_WINDOWS_PATH_IDENTITY_AND_OWNED_WRAPPER_QUALIFICATION_ACCEPTED`

接受实现：

`7c0712d6a602dc23200ccb147d0096acc6333305`

已证明：

- Windows argv 解析；
- 精确 `--path` 与 `--script`；
- Windows canonical path equality；
- descendant ancestry + executable + command identity；
- exactly-once cleanup；
- deepest-first cleanup；
- unproven descendant 不关闭；
- 每个 case 后 Godot 为 0。

### 13.2 当前活动 gate

Task 0024T：

`tasks/0024T_manifest_locked_complete_core_mechanics_final_validation_gate.md`

当前状态：

`MANIFEST_LOCKED_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_READY_FOR_CODEX`

任务单提交：

`7ced06723f179dd455e8b34069b695d7c46de6ea`

Active authority：

`d16695acd21a281eb9990cba02567981352bd9bb`

Startup snapshot：

`f5bf9a7d580ee9c8c68803b4f691bc437a9a1e33`

### 13.3 Task 0024T 的关键边界

Task 0024T 是 validation-only：

- 先构建固定四用例 manifest；
- 静态验证完整覆盖；
- 生成外部 pre-execution seal；
- seal 后验证 artifact 不得修改；
- final driver 只允许执行一次；
- 每个固定 case 只运行一次；
- 失败后不修复、不重跑；
- mandatory owned-process cleanup 仍执行。

固定四用例：

1. schema-v1 / 8 正式关卡 aggregate regression；
2. Task 0012 独立回归；
3. 现有 focused v2 foundation；
4. 新的完整 v2 BFS / replay / canonical / malformed-input 验证。

旧的：

`TASK_0023ZX_COMPLETE_MATRIX_PASS`

覆盖不足，不得作为新的最终证据。

## 14. provisional schema-v2 基础

候选实现提交：

`fdaf2b81fc71c60e4b3548422be94953146f25f4`

包含：

- schema v2；
- LevelLoader v2；
- Simulation v2；
- BFS 集成；
- 5 个非正式 v2 fixtures；
- focused v2 tests；
- 66 个 reviewed UID sidecars；
- Task 0012 八关 catalog/progression/final 窄修正。

该实现尚未被 GPT 接受。Task 0024T 是其最终验收 gate。

## 15. Godot 测试进程生命周期政策

持久权威：

`docs/project_memory/HEADLESS_GODOT_TEST_PROCESS_LIFECYCLE_FAILURE_AND_POLICY_CURRENT.md`

绑定区别：

### 外部 / 预先存在的进程

- 不由当前 wrapper 启动；
- 归属不明时不得关闭；
- 编辑器、项目管理器、其他项目或人工进程保持不动；
- 需要零进程隔离时构成 blocker。

### 当前 wrapper 自己启动的进程

wrapper 记录：

- exact PID；
- start timestamp；
- executable；
- exact arguments；
- proven ancestry。

`finally` 中只清理：

- direct owned PID；
- proven owned descendants。

这属于原 invocation 的资源清理，不是：

- 第二次验证；
- 重试；
- 产品修复；
- 第二轮 external-process reconciliation。

## 16. Profile 与受保护数据

production Profile：

`user://delayed_self_profile.json`

已知 schema 只包括：

- completed level IDs；
- best turns；
- language；
- window mode；
- reduced motion。

没有授权时禁止：

- 读取内容；
- 解析；
- hash；
- copy；
- rename；
- backup；
- delete；
- reset；
- repair；
- write；
- 普通 sibling enumeration。

历史受控只读结果：

- progress counts：`7 / 7 / 8`；
- 生产读取授权已消耗；
- 没有新的 production read/write/recovery/default activation 权限。

## 17. 关闭的历史任务

以下任务已关闭，不得直接恢复：

- 0023ZX
- 0023ZY
- 0023ZZ
- 0024
- 0024R
- 0024S（已验收关闭）

它们的历史证据只用于解释当前 gate。

## 18. 当前启动顺序

新会话应依次读取：

1. 本文件；
2. `docs/PROJECT_SOURCE_INDEX_CURRENT.md`；
3. `docs/game_design/DELAYED_SELF_GAME_DESIGN_REBASELINE_CURRENT.md`；
4. `docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md`；
5. `docs/CODEX_ACTIVE_TASK_CURRENT.md`；
6. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`；
7. `tasks/0024T_manifest_locked_complete_core_mechanics_final_validation_gate.md`；
8. 最新交接文件。

推荐 Task 0024T 主模型：

- 首选：`GPT-5.6 Sol Max`
- 备选：`GPT-5.6 Sol High`
- 不建议 Terra 作为主线程。

Codex prompt：

```markdown
请读取并严格执行：tasks/0024T_manifest_locked_complete_core_mechanics_final_validation_gate.md
```

## 19. 硬性非声明

本文件不证明或授权：

- schema-v2 已验收；
- sequence 9–12 已实现；
- sequence 12 已成为终章；
- catalog 已扩展；
- Profile 已迁移或默认激活；
- zh-Hans 已设为默认；
- 字体、美术或音乐已导入；
- Windows 构建已完成；
- 发布、上传或投稿已授权。

## 20. GPT Project Sources 上传规则

将本文件作为 2026-07-14 三件套的 CURRENT successor 加入 GPT Project Sources。

旧文件应继续保留，但应视为 historical seeds。

新的会话或 GPT Project Sources advisor 在目标关卡数、序列政策、机制范围、表现、语言、音频、路线图或测试进程政策上遇到冲突时，应以本文件及其引用的仓库 CURRENT 文档为准。
