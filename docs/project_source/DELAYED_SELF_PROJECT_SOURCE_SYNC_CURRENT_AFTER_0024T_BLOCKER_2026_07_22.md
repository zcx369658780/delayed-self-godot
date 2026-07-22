# 《迟到的我 / Delayed Self》GPT Project Sources 当前同步包（0024T 阻断后）

- 文档状态：`CURRENT / CONSOLIDATED SUCCESSOR AFTER TASK 0024T BLOCKER`
- 同步日期：2026-07-22
- 仓库：`zcx369658780/delayed-self-godot`
- 当前产品路线图：已接受，未改变
- 当前技术状态：Task 0024T terminally blocked
- 当前活动任务：无；必须发布新 correction gate 后才能继续
- 当前实现基线：8 个正式关卡
- 投稿目标：12 个核心关卡 + 2 个条件扩展关卡

## 1. 权威与继任关系

本文件是 GPT Project Sources 的最新 CURRENT successor。

它继承并整合：

- 2026-07-14 三件套历史种子；
- `DELAYED_SELF_PROJECT_SOURCE_SYNC_CURRENT_2026_07_22.md`；
- 仓库 `docs/PROJECT_SOURCE_INDEX_CURRENT.md`；
- 已接受设计重基线；
- 已接受扩展提交路线图；
- Task 0024S wrapper 验收；
- Task 0024T terminal blocker。

发生冲突时，以以下顺序为准：

```text
仓库实际状态
→ AGENTS.md
→ 新发布的当前 GitHub task
→ docs/CODEX_ACTIVE_TASK_CURRENT.md
→ docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
→ docs/PROJECT_SOURCE_INDEX_CURRENT.md
→ 已接受设计重基线
→ 已接受扩展路线图
→ 本文件
→ 早期项目源种子
→ 对话记忆
```

本文件不授权实现、Profile 操作、构建、发布、上传或投稿。

## 2. 产品路线图仍然有效

Task 0024T 的失败发生在 final driver 的第一条 PowerShell 断言，任何 Godot case 都没有运行。

因此它：

- 没有推翻已接受的产品路线图；
- 没有证明 schema v2、Simulation、solver 或关卡存在缺陷；
- 没有改变 12 核心 + 2 条件扩展目标；
- 没有授权 sequence 9–12、catalog 扩展或终章迁移。

已接受裁决仍是：

`TASK_0023ZW_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_ACCEPTED_WITH_BINDING_SEQUENCE_POLICY`

## 3. 当前正式关卡基线

正式 catalog 仍恰好为 8 关：

1. `tutorial_reach_exit`
2. `tutorial_echo_bridge`
3. `vertical_slice_delay_3`
4. `door_one_turn_late`
5. `two_keys_one_door`
6. `staggered_doors`
7. `echo_spacing_bridge`
8. `two_echo_convergence`

绑定政策：

- sequence / ID 1–8 不得重排或替换；
- sequence 8 仍是当前唯一正式终章；
- sequence 9–12 只能在后续独立 gate 中追加；
- sequence 12 成为终章必须经过 catalog、Profile、finale compatibility gate；
- 正式 catalog、8 个 JSON 和 final flag 继续冻结。

## 4. 投稿目标

- 12 个核心正式房间；
- 13–14 仅为日期与稳定性允许时的条件扩展；
- 时间不足时先永久推迟 13–14；
- 不用降低 solver/replay/安全门换取关卡数量。

## 5. 核心机制族

投稿核心：

1. YOU-only 推箱；
2. YOU-only 消耗钥匙与锁；
3. 成组多格屏障 / 桥梁；
4. 类型化传感器：
   - `ANY_ACTOR`
   - `YOU_ONLY`
   - `ECHO_ONLY`
   - explicit crate eligibility
5. room-local one-shot latch。

条件扩展：

- paired portals / pads；
- 单向门；
- 易碎地板；
- 传送带。

核心机制必须共享：

- schema；
- LevelLoader；
- Simulation；
- canonical state；
- replay；
- BFS solver。

schema-v1 八关行为不得改变。

## 6. 谜题课程原则

- 增加机制广度，不单纯增加难度；
- 禁止退化为通用 Sokoban；
- 每个机制族先通过 vertical slice；
- 正式房间必须有：
  - 可解性；
  - 最短步数；
  - 最短解数量或 capped；
  - replay；
  - restart；
  - 机制必要性；
- 共享基础未验收前，sequence 9–12 不得进入 catalog。

## 7. 表现、语言与音频

### 表现

接受方向：

**手绘延迟笔记本 / 墨迹 ECHO**

包括：

- 暖纸；
- 手绘边框；
- 不规则墨线；
- 延迟墨迹 / 残影；
- 形状、图标、文字冗余；
- 不依赖颜色单独传达状态。

候选字体：

`LXGW WenKai GB / 霞鹜文楷 GB`

导入前必须完成 OFL、中文覆盖、fallback、文本适配与包体检查。

### 语言

- 投稿目标默认简体中文；
- 新 Profile 默认 `zh-Hans` 仍需独立兼容 gate；
- 现有 Profile 语言不得静默覆盖；
- 中文覆盖菜单、教程、Help、Timeline、关卡名、错误、结算、终章、设置、Credits 与归属；
- 完整英文属于投稿后范围。

### 音频

- 2 条循环音乐；
- 1 条可选克制终章 cue；
- Crow Producer 素材需 track identity、来源、许可证台账与归属闭环；
- 可见归属：`音乐由[乌鸦Producer]提供`；
- 无许可证闭环时保持静音或最小安全音频。

## 8. 日期化路线

| Gate | 目标日期 | 硬 cut |
|---|---|---|
| scope finalization | 2026-07-23 | 保留 8 关 |
| mechanics + vertical slices | 2026-07-30 | 移除最弱机制族 |
| 12 核心房间批次 | 2026-08-07 | 冻结稳定数量 |
| stretch decision | 2026-08-12 | 推迟 13–14 |
| presentation + zh-Hans | 2026-08-17 | 最小表现、英文推迟 |
| music ledger/import | 2026-08-21 | 静音/最小安全音频 |
| Profile/menu | 2026-08-25 | 不发布、不推断迁移 |
| full-flow machine acceptance | 2026-08-29 | 移除 optional polish |
| owner walkthrough | 2026-09-01 | 削减 stretch/content |
| Windows/video readiness | 2026-09-03 | 最终 scope freeze |
| submission | 2026-09-06 | 必须 owner 明确授权 |
| video deadline | 2026-09-10 | 必须 owner 明确授权 |

日期不是自动授权。

## 9. 已接受的 Task 0024S

GPT 接受：

`TASK_0024S_WINDOWS_PATH_IDENTITY_AND_OWNED_WRAPPER_QUALIFICATION_ACCEPTED`

实现提交：

`7c0712d6a602dc23200ccb147d0096acc6333305`

已证明：

- Windows argv 解析；
- 精确 `--path` / `--script`；
- canonical Windows path equality；
- ancestry、executable、creation time、headless 与 forbidden-mode；
- exactly-once cleanup；
- deepest-first cleanup；
- unproven descendant 不关闭；
- 每个资格 case 后 Godot 进程为 0。

## 10. Task 0024T terminal blocker

Task：

`tasks/0024T_manifest_locked_complete_core_mechanics_final_validation_gate.md`

结果：

`BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION`

执行提交：

`dde18872457c156741bbe861a5fa873a13cec84f`

报告：

`docs/reports/0024T_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_REPORT.md`

### 10.1 已通过的静态准备

Task 0024T 成功构建并静态验证：

- 4 个固定 case；
- 44 个唯一 coverage ID；
- 26 个 frozen hash；
- accepted wrapper blob；
- manifest；
- static validator；
- single-use driver；
- complete-v2 GDScript。

外部只读 seal：

`c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29`

### 10.2 exactly-once driver 失败

driver 被调用恰好一次，但在创建 attempt record 和调用 wrapper 之前失败。

错误表达式：

```powershell
Assert-True (Get-GodotCount -eq 0) 'Godot process exists at final-session start'
```

PowerShell 将其解释为：

- 调用 `Get-GodotCount`；
- 把 `-eq` 和 `0` 当作函数参数；
- 函数返回整数 `0`；
- `Assert-True` 将整数 0 转成 Boolean false；
- 于是抛出错误。

实际 Godot 进程数为 0。

### 10.3 硬事实

- final driver budget 已消耗；
- 0 / 4 wrapper case 执行；
- 没有 Godot validation case 运行；
- 没有 attempt record；
- 没有 per-case record；
- 没有 final summary；
- 没有关闭或触碰进程；
- 失败后 Godot 仍为 0；
- implementation / formal data / Profile 未改变；
- 没有建立产品缺陷；
- 没有建立基础验收。

### 10.4 当前禁止

不得在 Task 0024T 下：

- 修改 sealed artifacts；
- 修改旧 seal；
- reseal；
- rerun driver；
- rerun任一 case；
- 追认 attempt record；
- 声称基础通过。

继续需要新的 bounded correction gate。

## 11. provisional foundation

候选提交：

`fdaf2b81fc71c60e4b3548422be94953146f25f4`

包括：

- schema v2；
- LevelLoader v2；
- Simulation v2；
- BFS 集成；
- 5 个 v2 fixture；
- focused v2 test；
- 66 个 UID sidecar；
- Task 0012 八关窄修正。

它仍然是 provisional，不是 accepted。

## 12. 未来 correction gate 的最低要求

新任务必须：

1. 保留 0024T manifest、driver、seal 和 blocker evidence；
2. 不修改旧 sealed artifacts；
3. 新建不同路径与 identity 的 corrected driver / validator / manifest；
4. 将 PowerShell count 比较写成明确语义，例如：
   ```powershell
   $godotCount = Get-GodotCount
   Assert-True ($godotCount -eq 0) '...'
   ```
   或：
   ```powershell
   Assert-True ((Get-GodotCount) -eq 0) '...'
   ```
5. 静态 validator 必须拒绝裸函数调用伪装成 comparison；
6. 在不运行 Godot case 的 qualification 中证明 driver 前置断言语义；
7. 创建新的外部 seal；
8. 只授权一次新的 final driver；
9. 固定四个 case；
10. 失败后不重跑；
11. 所有 wrapper invocation 继续执行 mandatory owned-process cleanup。

## 13. Godot 进程生命周期政策

持久权威：

`docs/project_memory/HEADLESS_GODOT_TEST_PROCESS_LIFECYCLE_FAILURE_AND_POLICY_CURRENT.md`

当前 wrapper 自启进程的 `finally` 清理属于原 invocation，不是：

- 第二次验证；
- retry；
- 产品修复；
- external-process reconciliation。

预先存在或归属不明的进程不得关闭。

## 14. Profile 保护

production Profile：

`user://delayed_self_profile.json`

没有明确授权时，禁止：

- content read；
- parse；
- hash；
- copy；
- rename；
- backup；
- delete；
- reset；
- repair；
- write；
- sibling enumeration。

历史受控读取只确认：

- progress counts `7 / 7 / 8`；
- 该读取授权已消耗。

## 15. 当前任务状态

当前无活动任务。

Task 0024T 已 terminally blocked，不得直接恢复。

新的 GPT 会话必须先：

1. 读取本文件；
2. 读取 `docs/CODEX_ACTIVE_TASK_CURRENT.md`；
3. 读取 `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`；
4. 读取 0024T blocker report；
5. 由 GPT 发布新的 correction gate；
6. 再向 Codex 下达任务。

## 16. 模型建议

后续 corrected sealed final validation：

- 首选：`GPT-5.6 Sol Max`
- 备选：`GPT-5.6 Sol High`
- 不建议 Terra 作为主线程。

## 17. 非声明

本文件不证明或授权：

- schema v2 已验收；
- sequence 9–12 已实现；
- catalog 已扩展；
- final flag 已迁移；
- Profile 已迁移或默认激活；
- zh-Hans 已激活；
- 美术、字体或音乐已导入；
- 构建、发布、上传或投稿已授权。

## 18. GPT Project Sources 上传

将本文件作为最新 CURRENT successor 加入 GPT Project Sources。

保留：

- 2026-07-14 三件套历史种子；
- `DELAYED_SELF_PROJECT_SOURCE_SYNC_CURRENT_2026_07_22.md` 作为路线图同步基线。

但当前技术状态以本文件为准。
