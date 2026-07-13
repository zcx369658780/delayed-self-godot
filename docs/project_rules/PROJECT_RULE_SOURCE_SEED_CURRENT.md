# 《迟到的我 / Delayed Self》项目规则源（CURRENT）

- 文档状态：`CURRENT / PROJECT SOURCE SEED`
- 生成日期：2026-07-14
- 适用项目：GodotHub Festival 2026 参赛游戏《迟到的我》
- GitHub：`https://github.com/zcx369658780/delayed-self-godot`
- 本地 Codex 工作目录：`D:\Delayed_Self`
- 用途：由 Task 0000 将本文件拆分为 `AGENTS.md`、`docs/project_rules/`、`docs/agents/`、`docs/workflows/` 和 current docs。
- 规则来源：基于用户提供的 EliteSync 可迁移治理规则，已针对离线 Godot 解谜游戏重写。

> 本文件是仓库 bootstrap 阶段的规则母本。Task 0000 完成后，`AGENTS.md` 与 repo canonical docs 成为 Codex 的直接执行依据；本文件继续保留为规则来源与审计记录。

---

## 1. 项目目标

在 2026-08-10 前完成《迟到的我》的完整可玩候选版，并在 2026-09-06 23:59 前完成最终参赛提交。

项目优先级：

1. 可运行、可通关、可理解；
2. 主题“滞后”与玩法高度一致；
3. 谜题可解且难度可验证；
4. 完整菜单、设置、选关、结算、存档和退出流程；
5. 稳定导出与许可证合规；
6. 统一视觉、音效和情绪表达；
7. 最后才是额外机制和高技术力展示。

---

## 2. 项目角色

### 2.1 GPT 项目源顾问

负责：

- 策划基线；
- 路线图和阶段门；
- GitHub task-file；
- scope、non-goals、allowed files 和 protected surfaces；
- 验收标准；
- 风险裁决；
- 过度声明防护；
- GitHub diff、报告和证据审阅；
- 最终 acceptance 与下一任务。

GPT 顾问不把聊天记忆当作唯一事实源，重要决定必须进入项目源或仓库文档。

### 2.2 本地 Codex

负责：

- 读取 repo canonical docs 和当前 task；
- 本地实现；
- 受控命令执行；
- 自动测试；
- 谜题求解与验证；
- 文本证据；
- 单主题 commit；
- 在 task 明确授权时 push；
- 如实报告未运行项目、阻塞项和不确定性。

Codex 不得自行扩大玩法范围，不得以自评替代 GPT 最终验收。

### 2.3 独立评审者

负责：

- 玩家视角首次体验；
- 教程、核心循环、关卡难度和失败反馈；
- UI、音频、性能和完整流程；
- 最终构建或候选构建的独立复核。

Codex 自己调用的 reviewer/subagent 属于开发自查，不自动构成独立验收。

### 2.4 用户

负责：

- 产品和审美取舍；
- GitHub 账号和仓库授权；
- 必要的人工试玩；
- 第三方账号、平台报名、手机号实名；
- 最终公开提交；
- 任何高风险或不可逆动作的明确授权。

---

## 3. Canonical 项目源优先级

仓库建立后，默认读取顺序：

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`（若 active/blocked）
4. 当前 `tasks/<task>.md`
5. `docs/DOC_INDEX_CURRENT.md`
6. `docs/DEVELOPMENT_PLAN_CURRENT.md`
7. `docs/HANDOFF_MASTER_CURRENT.md`
8. `docs/project_memory.md`
9. `docs/version_plans/README.md`
10. `docs/project_rules/`
11. `docs/agents/`
12. `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`

优先级原则：

- `AGENTS.md` 冻结硬规则，不写易变进度；
- task-file 冻结本次 scope，但只能比硬规则更严格；
- current docs 记录动态状态；
- 历史报告不得覆盖 current；
- 聊天指令与 repo 事实冲突时，Codex 停止并报告，等待 GPT 顾问裁决；
- 新任务不得通过模糊授权推导出发布、删除、密钥或仓库管理权限。

---

## 4. 建议仓库结构

```text
<PROJECT_ROOT>/
├─ AGENTS.md
├─ README.md
├─ LICENSE
├─ project.godot
├─ tasks/
├─ docs/
│  ├─ CODEX_STARTUP_SNAPSHOT_CURRENT.md
│  ├─ CODEX_ACTIVE_TASK_CURRENT.md
│  ├─ DOC_INDEX_CURRENT.md
│  ├─ DEVELOPMENT_PLAN_CURRENT.md
│  ├─ HANDOFF_MASTER_CURRENT.md
│  ├─ project_memory.md
│  ├─ game_design/
│  ├─ level_design/
│  ├─ project_rules/
│  ├─ agents/
│  ├─ workflows/
│  ├─ version_plans/
│  ├─ reports/
│  ├─ licenses/
│  └─ archive/
├─ assets/
├─ audio/
├─ data/
│  └─ levels/
├─ scenes/
├─ scripts/
├─ shaders/
├─ tests/
└─ tools/
```

Godot 实际目录可由 Task 0000 调整，但必须保留：

- `tasks/`；
- current docs；
- `docs/project_rules/`；
- 关卡数据；
- 测试；
- 报告；
- 许可证台账。

---

## 5. 新任务启动协议

每个 Codex 任务开始先运行：

```powershell
git branch --show-current
git rev-parse HEAD
git status --short --untracked-files=all
```

然后：

1. 确认绝对工作目录；
2. 阅读 `AGENTS.md`；
3. 阅读启动快照；
4. 检查活动任务；
5. 读取完整 task-file；
6. 输出 scope、non-goals、allowed files、forbidden surfaces、测试和提交政策摘要；
7. tracked worktree 非预期 dirty 时停止；
8. 需要拉取任务文件时只允许安全 fast-forward；
9. 分叉、冲突、tracked drift 或远端漂移时停止并报告；
10. 在任何写操作前确认任务明确授权。

---

## 6. Git 硬规则

默认禁止：

- `git add .`
- `git add -A`
- `git reset --hard`
- repo-level `git restore`
- `git checkout .`
- 未授权删除 tracked 文件；
- 清理用户已有未跟踪文件；
- amend、rebase、squash、force push；
- 将多个主题混入一个 commit；
- 未授权改变默认分支、仓库可见性、保护规则或协作者；
- 把构建包、缓存、截图、长日志或本机配置误提交；
- 把秘密信息、账号信息和凭据提交或输出。

提交要求：

1. 每个 commit 只有一个主题；
2. 只显式暂存授权文件；
3. 输出 staged 文件列表；
4. 运行 `git diff --cached --check`；
5. task 明确授权后才能 commit；
6. task 明确授权后才能 push；
7. push 前 fetch 并检查远端漂移；
8. push 后报告 branch、start/final HEAD、origin、commit、文件和 final status。

---

## 7. Godot 项目硬规则

### 7.1 版本冻结

- Godot 精确版本必须在环境盘点后写入 current docs；
- 未经单独 task 不升级 Godot、导出模板、渲染器或关键插件；
- 不因“新版本可能更好”而在冲刺期间升级；
- 编辑器版本与 CI/命令行版本必须一致或明确记录差异。

### 7.2 生成文件与缓存

默认不得提交：

- `.godot/`
- 编辑器本地状态；
- 导出临时目录；
- 平台签名文件；
- 私有证书；
- 本机绝对路径配置；
- 崩溃转储；
- 大型原始捕获；
- 未经允许的导出包。

`.gitignore` 必须由 Task 0000 明确生成并审阅。

### 7.3 架构边界

- 模拟状态与视觉表现分离；
- 关卡状态转移必须确定；
- 动画不得成为唯一逻辑计时器；
- 求解器与运行时共享规则或共享可验证规范；
- 不在 UI 脚本中复制谜题规则；
- 不把关卡逻辑硬编码到单个场景；
- 不为一个关卡引入无法复用的大型框架；
- 不在首版引入 C#、GDExtension 或原生插件，除非单独授权并证明必要。

---

## 8. 核心玩法冻结规则

当前核心：

- 2D 俯视网格；
- 回合制；
- 玩家输入被记录；
- 时间回声在固定延迟后重放历史输入；
- 压力板、门、同步点等机关；
- 关卡可重开；
- 数据驱动；
- 自动可解性验证。

以下属于 scope expansion，必须有单独任务和 GPT 裁决：

- 箱子推动；
- 敌人 AI；
- 战斗；
- 实时平台跳跃；
- 关卡编辑器；
- 程序化无限生成；
- 多人；
- 联网；
- 排行榜；
- 云存档；
- 多结局；
- 配音；
- 大规模剧情系统。

机制进入正式范围的条件：

1. 至少支持两个非重复关卡；
2. 不破坏确定性；
3. 可被求解器表示；
4. 有教程和反馈设计；
5. 不威胁当前里程碑；
6. 已更新策划案和验收标准。

---

## 9. 谜题正确性规则

这是本项目的核心质量门。

### 9.1 正式关卡必须有验证证据

至少包含：

- 关卡 ID 和数据版本；
- 验证使用的 commit；
- 是否可解；
- 最短步数；
- 至少一条机器验证的解；
- 最短解数量或可计算的近似；
- 使用机制；
- 预期教学点；
- 已知捷径；
- 人工试玩状态。

### 9.2 禁止把 AI 输出当成正确性证明

- AI 提供的解法必须实际运行；
- AI 声称“唯一解”必须由搜索证据支持；
- AI 生成关卡必须经过格式校验和求解；
- AI 生成的难度标签只是候选；
- 求解器超时必须标记为 `UNVERIFIED`，不得标记为可解；
- 游戏运行时与求解器不一致时，关卡立即退出正式候选集。

### 9.3 规则变更的回归要求

任何影响状态转移的修改都必须：

1. 重跑所有正式关卡；
2. 比较最短解和可解性；
3. 标记发生变化的关卡；
4. 解释变化是预期还是回归；
5. 未完成回归前不得声称关卡集稳定。

### 9.4 难度不是只看步数

关卡评审还要检查：

- 玩家是否理解目标；
- 等待是否有意义；
- 是否存在无反馈的失败；
- 是否需要不合理试错；
- 是否只有冗长执行而没有推理；
- 是否与前后关难度曲线一致。

---

## 10. 存档与玩家数据

默认策略：

- 离线；
- 不收集个人数据；
- 不使用账号；
- 不接入遥测；
- 不接入广告、支付或内购；
- 只保存关卡进度、最佳步数、设置和叙事收集状态。

以下必须单独 task：

- 存档格式首次冻结；
- 存档版本字段；
- 旧存档迁移；
- 覆盖或清理存档；
- 云存档；
- 用户目录读写改变；
- 导入/导出玩家数据。

测试不得覆盖用户真实存档。使用隔离测试目录或明确的测试 profile。

---

## 11. 第三方素材与许可证

### 11.1 台账要求

每个外部素材必须记录：

- 文件或素材包名称；
- 来源页面；
- 作者；
- 下载日期；
- 许可证；
- 是否允许商业/比赛使用；
- 是否允许修改；
- 是否要求署名；
- 项目内使用位置；
- 是否经过二次加工；
- 原始许可证文本或快照位置。

建议文件：

```text
docs/licenses/THIRD_PARTY_ASSET_LEDGER_CURRENT.md
docs/licenses/ATTRIBUTION_CURRENT.md
```

### 11.2 禁止事项

- 不使用许可证不明素材；
- 不把“免费下载”视为可自由参赛；
- 不使用抓取自其他游戏的资源；
- 不使用需要未履行署名的素材；
- 不提交字体而忽略字体许可证；
- 不把 AI 生成来源和使用条款留空；
- 不在最终构建前才开始整理许可证。

### 11.3 素材替换

占位素材可以进入早期构建，但必须明确标记：

- `PLACEHOLDER_ALLOWED_IN_DEV`
- `NOT_CLEARED_FOR_RELEASE`

未完成许可审计的素材不得进入最终提交包。

---

## 12. AI 使用与内容来源

- AI 可辅助代码、关卡提案、文本、图标草案和测试；
- AI 输出必须经过人工审阅；
- AI 关卡必须经过求解器；
- AI 代码必须通过测试和 diff review；
- 不声称 AI 生成内容天然无版权风险；
- 最终提交说明是否需要披露 AI 使用，以赛事当时最新规则为准；
- 对第三方模型生成的音频、美术和字体，保留服务、日期和许可说明；
- 不把其他受版权保护游戏的具体角色、地图或美术风格做近似复制。

---

## 13. Fast Lane 与高风险 Gate

### 13.1 Fast Lane

可在一个清晰 task 中完成：

- 本地 UI；
- 场景布局；
- 关卡数据；
- 教程文案；
- 粒子和轻量 Shader；
- 音频接线；
- 可访问性；
- 自动测试；
- 文本报告；
- 不接触高风险面的局部重构。

### 13.2 高风险任务

必须单独 task/gate：

- Godot/插件/依赖升级；
- 存档格式和迁移；
- 文件系统权限；
- 原生插件；
- 联网、账号、排行榜和云存档；
- 构建签名；
- 平台账号；
- 公开发布；
- 游戏节正式提交；
- 删除或覆盖用户数据；
- 仓库可见性和权限；
- 第三方素材许可证最终裁定；
- 最终导出模板和发布包。

推荐高风险 bundle：

```text
A. 规划
B. 实现
C. 文本证据
D. 独立评审
E. 修复
F. GPT 最终验收
G. 用户执行或授权公开动作
```

---

## 14. GitHub task-file 机制

默认任务路径：

```text
tasks/<NNNN>_<topic>.md
```

用户给 Codex 的短指令：

```text
Read and execute the GitHub task file: tasks/<task>.md
```

task-file 至少包含：

- context；
- objective；
- scope；
- non-goals；
- allowed files；
- protected surfaces；
- required reads；
- implementation constraints；
- tests；
- evidence；
- commit policy；
- push policy；
- terminal verdict；
- stop conditions；
- next gate。

task-file 不自动授权：

- 建仓；
- 改仓库权限；
- 删除分支；
- 公开发布；
- 上传游戏；
- 使用账号；
- 访问秘密；
- 付费；
- 联网写入；
- 覆盖存档。

---

## 15. GPT—Codex—GitHub 闭环

```text
GPT 顾问生成 task-file
→ task-file 进入 main
→ Codex 安全同步
→ Codex 执行、测试、报告
→ Codex 在授权范围 commit/push
→ 用户回传 task/commit/PR
→ GPT 审阅 GitHub diff 和证据
→ GPT 给出 ACCEPT / REQUEST_CHANGES / BLOCKED
→ 进入下一 gate
```

Codex 的任务结论可以是：

- `PASS_FOR_GPT_REVIEW`
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`
- `BLOCKED`
- `FAIL`

Codex 不使用 `FINAL_ACCEPTED`。最终 acceptance 由 GPT 顾问给出。

---

## 16. Text-first 证据

仓库默认保存：

- 执行报告；
- 测试摘要；
- 关卡验证摘要；
- Action Matrix；
- 许可证台账；
- 独立评审报告；
- integrated acceptance；
- 外部证据索引；
- 构建哈希和环境信息。

仓库外证据目录保存：

- 截图；
- 录屏；
- 原始长日志；
- 性能捕获；
- 导出包；
- 临时测试文件；
- 独立评审工作目录。

少量关键截图只有在 task 明确授权时进入仓库。

---

## 17. 独立玩家视角评审

### 17.1 Blind review

评审者先不读实现说明，检查：

- 第一次启动；
- 主菜单；
- 教程是否自解释；
- 核心机制是否能在几分钟内理解；
- 失败是否可理解；
- 重开是否顺畅；
- 难度曲线；
- UI 可读性；
- 音效反馈；
- 设置；
- 关卡选择；
- 通关流程；
- 卡关风险；
- 严重 Bug。

### 17.2 Reveal review

再读取：

- 设计目标；
- non-goals；
- 机制说明；
- 已知问题；
- protected surfaces；
- 验证记录。

问题分类：

- P0：阻止运行、通关、保存或提交；
- P1：显著损害理解、体验、稳定性或主题；
- P2：重要但可延期；
- P3：润色建议。

评审 verdict：

- `PASS`
- `PASS_WITH_OBSERVATIONS`
- `CONDITIONAL_PASS`
- `FAIL`

只有前两者默认进入 GPT final acceptance。

---

## 18. AI 评审分块

大型评审拆为：

- Part A：核心模拟、确定性和回声规则；
- Part B：关卡可解性、难度和捷径；
- Part C：教程、UI、输入、设置和可访问性；
- Part D：视觉、音频、性能和导出；
- Part E：存档、许可证、赛事提交清单；
- Synthesis：整合报告与 Action Matrix。

每块必须输出：

- verdict；
- P0/P1/P2/P3；
- evidence；
- uncertainty；
- 未检查项；
- 是否需要 retry。

无有效输出时记录 `NO_USABLE_REVIEW_VERDICT`，不得伪造 PASS。

---

## 19. Cross-layer blocker

以下情况停止盲修：

- 编辑器运行正常但导出失败；
- 求解器可解但实际关卡不可解；
- 视觉状态与模拟状态冲突；
- 重开后残留旧状态；
- 同一输入序列结果不一致；
- 两次修复未降低不确定性；
- 涉及渲染驱动、导出模板、文件权限、存档或平台 SDK；
- 日志与现象互相矛盾。

blocker report 包含：

- symptom；
- affected layers；
- known facts；
- unknowns；
- tests run；
- files changed；
- untouched surfaces；
- suspected causes；
- safest next evidence；
- forbidden actions。

---

## 20. 上下文预算

- 单次 shell 输出默认不超过约 120 行或 12,000 字符；
- 先读 current docs 和 git facts；
- 不恢复完整旧 transcript；
- 不默认读取 session JSONL、history、超长日志或加密内容；
- 先看目录、文件清单、行数和 diff stat；
- 搜索限制路径、文件类型和结果数；
- 大文件按区段读取；
- 上下文压力高时更新活动任务或 handoff；
- 不为保持会话连续而牺牲代码审阅和测试证据。

---

## 21. 过度声明防护

不得声明：

- “功能完成”，除非实现和指定测试完成；
- “谜题可解”，除非求解器或等价证据完成；
- “唯一解”，除非搜索支持；
- “难度合理”，除非有指标和试玩；
- “无回归”，除非规定回归面已运行；
- “视觉通过”，除非有对应证据和评审；
- “性能达标”，除非在指定场景测量；
- “存档兼容”，除非迁移测试完成；
- “许可证合规”，除非台账审计完成；
- “可投稿/可发布”，除非导出、流程、许可证、赛事规则和提交包全部验收；
- “已上传”，除非用户或明确授权的动作实际完成。

---

## 22. 赛事规则监控

赛事页面明确说明规则可能调整。因此：

- 每个主要 milestone 开始前检查一次官方页面；
- 最终提交 gate 前必须重新检查；
- 记录检查日期和变化；
- 新规则与当前策划冲突时，暂停发布相关任务；
- 不把 8 月 10 日误作最终截止：它是提交通道开启日；
- 当前记录：报名截止 2026-08-30 23:59，作品截止 2026-09-06 23:59，视频需在 2026-09-10 前发布；
- 至少提交 Web 或 Windows 版本；
- 公开提交属于单独授权动作。

---

## 23. 推荐首批任务

### Task 0000：仓库初始化与规则落地

- 建立目录；
- 写入 `AGENTS.md`；
- 拆分规则；
- 写 `.gitignore`；
- 建 current pointers；
- 导入策划案；
- 不安装插件；
- 不创建正式游戏逻辑。

### Task 0001：环境与发行目标只读盘点

- Godot 安装版本；
- 导出模板；
- renderer；
- Windows/Web 可用性；
- Git、Python 和测试工具；
- 字体与音频工具；
- 本机路径；
- 仓库外证据路径；
- 不升级、不下载未知依赖。

### Task 0002：玩法规范与模拟合同冻结

- 状态模型；
- 回合结算顺序；
- 碰撞；
- 门和压力板；
- 回声延迟；
- 失败与重开；
- 关卡数据 schema；
- 求解器合同；
- 测试样例。

### Task 0003：最小垂直切片

- 一个房间；
- 玩家；
- 单回声；
- 压力板；
- 门；
- 出口；
- 重开；
- 一个自动验证关卡；
- Windows 本地运行。

后续任务由垂直切片结果决定，不预先生成大批实现任务。

---

## 24. 当前已冻结与待冻结信息

已冻结：

- GitHub owner/repository：`zcx369658780/delayed-self-godot`；
- 仓库可见性：public；
- 默认分支：main；
- 本地绝对路径：`D:\Delayed_Self`；
- 游戏方向：2D 俯视网格、回合制、延迟分身解谜；
- 单人离线；
- 首要平台：Windows；
- 公开发布和正式投稿必须单独授权。

待冻结：

- 仓库外 evidence root；
- Godot 精确版本；
- renderer；
- Windows/Web 最终目标；
- 逻辑分辨率；
- 输入设备；
- 像素或矢量美术；
- 独立评审者；
- 是否使用第三方插件；
- 最终中英文名称；
- LICENSE。

在这些内容冻结前，Codex 只能执行文档初始化和只读盘点，不得自行选择会带来长期兼容成本的方案。
