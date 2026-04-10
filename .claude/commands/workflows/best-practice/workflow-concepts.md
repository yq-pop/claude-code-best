---
description: 使用最新的 Claude Code 功能和概念更新 README 的 CONCEPTS 部分
argument-hint: [要检查的更新日志版本数量，默认 10]
---

# 工作流更新日志 — README 概念

你是 claude-code-best-practice 项目的协调员。你的工作是并行启动两个研究智能体，等待它们的结果，合并发现，并呈现关于 **README CONCEPTS 部分**（`README.md`）偏差的统一报告。

**要检查的版本：** `$ARGUMENTS`（默认值：如果为空或不是数字则为 10）

这是一个**先读取后报告**的工作流。启动智能体，合并结果，生成报告。仅在用户批准后才采取行动。

---

## 阶段 0：并行启动两个智能体

**立即**使用 Task 工具在**同一消息中**生成两个智能体（并行启动）：

### 智能体 1：workflow-concepts-agent

使用 `subagent_type: "workflow-concepts-agent"` 生成。给它这个提示：

> 研究 claude-code-best-practice 项目的 README CONCEPTS 部分偏差。检查最近 $ARGUMENTS 个版本（默认：10）。
>
> 获取这 3 个外部来源：
> 1. Claude Code 文档索引：https://code.claude.com/docs/en
> 2. Claude Code 更新日志：https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
> 3. Claude Code 功能概述：https://code.claude.com/docs/en/overview
>
> 然后读取本地的 README.md（特别是 CONCEPTS 表）、CLAUDE.md 和 `reports/claude-global-vs-project-settings.md`。分析官方文档中列出的 Claude Code 概念/功能与我们的 README CONCEPTS 表文档之间的差异。返回涵盖缺失概念、已更改概念、已弃用概念、URL 准确性、描述准确性和徽章准确性的结构化发现报告。

### 智能体 2：claude-code-guide

使用 `subagent_type: "claude-code-guide"` 生成。给它这个提示：

> 研究最新的 Claude Code 功能和概念。我需要你找到应该记录的所有 Claude Code 概念/功能的完整列表。对于每一个，提供：
> 1. 官方功能名称
> 2. 官方文档 URL
> 3. 文件系统位置（例如，`.claude/commands/`、`~/.claude/teams/`）
> 4. 简要描述（一行）
> 5. 引入时间（版本/日期，如果已知）
>
> 特别检查这些可能缺失的概念：
> - **Worktrees** — 用于并行开发的 git worktree 隔离
> - **Agent Teams** — 多智能体协调
> - **Tasks** — 跨会话的持久任务列表
> - **Auto Memory** — Claude 自写的项目学习内容
> - **Keybindings** — 自定义键盘快捷键
> - **Remote Connections** — SSH、Docker、云开发
> - **IDE Integration** — VS Code、JetBrains 扩展
> - **Model Configuration** — 模型选择和路由
> - **GitHub Integration** — PR 审查、问题分类
> - 来自最近 Claude Code 版本的任何其他概念
>
> 要彻底 — 搜索网络，获取文档，并为你找到的所有内容提供具体的版本号和详细信息。

两个智能体独立运行并将返回它们的发现。

---

## 阶段 0.5：读取验证检查清单

**在智能体运行时**，读取 `changelog/best-practice/concepts/verification-checklist.md`（如果存在）。此文件包含累积的验证规则。如果尚不存在，跳过此步骤 — 它将在阶段 2 中创建。

---

## 阶段 1：读取以前的更新日志条目

**在合并发现之前**，读取文件 `changelog/best-practice/concepts/changelog.md`（如果存在）以获取以前的更新日志条目。每个条目由 `---` 分隔。解析这些以前条目中的优先操作，以便你可以将它们与当前发现进行比较。这使你能够识别：
- **重复项** — 以前出现过且仍未解决的问题
- **新解决的项** — 以前运行中的问题现已修复
- **新项** — 首次出现在此次运行中的问题

如果文件尚不存在，所有项都是 `NEW`。

---

## 阶段 2：合并发现并生成报告

**等待两个智能体完成。** 一旦你拥有：
- **workflow-concepts-agent 发现** — 包含本地文件读取、外部文档获取和偏差检测的详细分析
- **claude-code-guide 发现** — 关于最新 Claude Code 功能和概念的独立研究

交叉引用两者。专用智能体提供 CONCEPTS 特定的偏差分析，而 claude-code-guide 智能体可能会发现它遗漏的内容（例如，最新更改、未记录的功能或来自网络搜索的上下文）。标记两者之间的任何矛盾以供用户解决。

**执行验证检查清单（如果存在）：** 对于 `changelog/best-practice/concepts/verification-checklist.md` 中的每条规则，执行检查。在报告中包含**验证日志**部分。

**根据需要更新检查清单：** 如果发现揭示了现有检查清单规则未涵盖的新型偏差，将新规则附加到 `changelog/best-practice/concepts/verification-checklist.md`。如果文件不存在，创建它。规则必须包括：类别、要检查的内容、深度级别、要比较的源、添加日期和来源。

还要将当前发现与以前的更新日志条目（来自阶段 1）进行比较。对于每个优先操作，将其标记为：
- `NEW` — 首次出现此问题
- `RECURRING` — 在以前的运行中出现过且仍未解决（包括首次出现的运行日期）
- `RESOLVED` — 在以前的运行中出现过但现已修复（包括解决日期）

生成具有以下部分的结构化报告：

1. **缺失的概念** — 官方文档中的功能/概念但 CONCEPTS 表中缺失，包含：
   - 官方名称和文档 URL
   - 推荐的 Location 列值
   - 推荐的 Description 列值
   - 准备粘贴的确切 markdown 表格行
   - 引入的版本（如果已知）
2. **已更改的概念** — 名称、URL、位置或描述已更改的概念
3. **已弃用/已删除的概念** — CONCEPTS 表中的概念但官方文档中不再存在
4. **URL 准确性** — 每个概念的 URL 验证
5. **描述准确性** — 每个概念的描述/位置验证
6. **徽章准确性** — 徽章链接验证和缺失徽章建议
7. **claude-code-guide 智能体发现** — 智能体的独特见解，这些见解未被专用智能体捕获。仅包含添加新信息的发现。标记矛盾。

以优先的**操作项**摘要表结束：

```
优先操作：
#  | 类型                | 操作                                     | 状态
1  | 缺失概念            | 将 <概念> 行添加到 CONCEPTS 表           | NEW
2  | 已更改 URL          | 更新 <概念> 文档链接                     | NEW
3  | 已更改描述          | 更新 <概念> 描述                         | RECURRING（首次发现：<日期>）
4  | 已弃用概念          | 从 CONCEPTS 表中删除 <概念> 行            | NEW
5  | 损坏的徽章          | 修复 <概念> 的徽章链接                    | NEW
```

还要包含**自上次运行以来已解决**部分，列出上次运行中不再是问题的任何项。

---

## 阶段 2.5：将摘要附加到更新日志

**此阶段是强制性的 — 在向用户呈现报告之前始终执行它。**

读取现有的 `changelog/best-practice/concepts/changelog.md` 文件，然后在末尾**附加**（不要覆盖）新条目。如果文件不存在，创建它并包含状态图例表，然后是第一个条目。条目格式必须完全是：

```markdown
---

## [<YYYY-MM-DD HH:MM AM/PM PKT>] Claude Code v<VERSION>

|| # | 优先级 | 类型 | 操作 | 状态 |
||---|--------|------|------|------|
|| 1 | HIGH/MED/LOW | <类型> | <操作描述> | <状态> |
|| ... | ... | ... | ... | ... |
```

**状态格式 — 必须使用以下三种格式之一：**
- `COMPLETE（原因）` — 已采取操作并成功解决
- `INVALID（原因）` — 发现不正确、不适用或有意为之
- `ON HOLD（原因）` — 操作推迟，等待外部依赖或用户决定

`（原因）` 是强制性的，必须简要说明已做了什么或为什么。

**附加规则：**
- 始终附加 — 永远不要覆盖或替换以前的条目
- 日期和时间是命令在巴基斯坦标准时间（PKT，UTC+5）执行的时间；通过运行 `TZ=Asia/Karachi date "+%Y-%m-%d %I:%M %p PKT"` 获取。版本来自智能体发现
- 每个条目由 `---` 分隔
- **仅包含 HIGH、MEDIUM 或 LOW 优先级的项** — 省略 NONE 优先级项

---

## 阶段 2.6：更新最后更新徽章

**此阶段是强制性的 — 在阶段 2.5 之后立即执行，在呈现报告之前。**

更新 `README.md` 顶部（第 3 行）的"最后更新"徽章。运行 `TZ=Asia/Karachi date "+%b %d, %Y %-I:%M %p PKT"` 获取时间，URL 编码它（空格为 `%20`，逗号为 `%2C`），并替换徽章中的日期部分。

**不要将徽章更新记录为更新日志或报告中的操作项。**

---

## 阶段 2.7：验证所有 CONCEPTS URL

**此阶段是强制性的 — 在阶段 2.6 之后执行，在呈现报告之前。**

对于 CONCEPTS 表中的每个概念：

1. **外部文档 URL**（例如，`https://code.claude.com/docs/en/skills`）：使用 WebFetch 获取每个 URL 并验证它返回有效页面。标记任何死链接或移动的链接。
2. **本地徽章链接**（例如，`best-practice/claude-commands.md`）：使用 Read 工具验证文件是否存在。标记任何损坏的链接。
3. **实现徽章链接**（例如，`.claude/commands/`）：验证路径是否存在。

在报告中包含 **URL 验证日志**：

```
URL 验证日志：
#  | 概念        | URL 类型  | URL                                           | 状态 | 注释
1  | Commands    | External  | https://code.claude.com/docs/en/skills         | OK     |
2  | Commands    | Badge     | best-practice/claude-commands.md               | OK     |
3  | Sub-Agents  | External  | https://code.claude.com/docs/en/sub-agents     | OK     |
...
```

**如果任何 URL 损坏**，将它们添加为 HIGH 优先级操作项。

---

## 阶段 3：提供采取行动的选项

在呈现报告后（并确认更新日志已更新），询问用户：

1. **执行所有操作** — 添加缺失的概念，更新已更改的概念，删除已弃用的概念
2. **执行特定操作** — 用户选择要执行的编号
3. **仅保存报告** — 不做更改

执行时：
- **缺失的概念**：按照现有格式向 `README.md` 中的 CONCEPTS 表添加新行：
  ```
  | [**名称**](文档-url) | `位置` | 描述 |
  ```
  仅当相应文件存在时才添加徽章（best-practice、implemented）。
- **已更改的概念**：更新已更改的特定列
- **已弃用的概念**：在删除行之前与用户确认
- **损坏的 URL**：将 URL 修复为当前有效的 URL
- **徽章修复**：将徽章链接更新为正确的文件路径
- 保持与现有表一致的字母或逻辑排序
- 执行所有操作后，重新验证 CONCEPTS 表的一致性

---

## 关键规则

1. **在单个消息中并行启动两个智能体** — 永远不要按顺序
2. **在生成报告之前等待两个智能体**
3. **永远不要猜测**版本、URL 或日期 — 使用来自智能体的数据
4. **缺失的概念是高优先级** — CONCEPTS 表是开发人员首先看到的内容
5. **验证每个 URL** — 损坏的链接会降低对整个项目的信任
6. **不要自动执行** — 始终先呈现报告
7. **始终附加到更新日志** — 阶段 2.5 是强制性的。永远不要跳过它。永远不要覆盖以前的条目。
8. **与以前的运行进行比较** — 从更新日志中读取以前的条目，并将每个操作项标记为 NEW、RECURRING 或 RESOLVED。
9. **执行验证检查清单（如果存在）** — 读取 verification-checklist.md 并执行每条规则。如果不存在且有需要持久规则的发现，创建该文件。
10. **始终更新最后更新徽章** — 阶段 2.6 是强制性的。
11. **始终验证所有 CONCEPTS URL** — 阶段 2.7 是强制性的。损坏的 URL 是 HIGH 优先级。
12. **提供准备粘贴的行** — 对于缺失的概念，包含确切的 markdown 表格行，以便执行是复制粘贴。
13. **尊重现有的表格式** — 匹配现有行的列结构、徽章模式和链接样式。
