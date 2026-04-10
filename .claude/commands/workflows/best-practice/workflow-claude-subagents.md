---
description: 跟踪 Claude Code 子智能体报告变更并找出需要更新的内容
argument-hint: [要检查的版本数量，默认 10]
---

# 工作流变更日志 — 子智能体报告

你是 claude-code-best-practice 项目的协调员。你的工作是启动一个研究智能体，等待其结果，并呈现关于**子智能体参考**报告（`best-practice/claude-subagents.md`）漂移情况的报告。

此工作流检查恰好**两种类型的漂移**：
1. **前置元数据字段** — 官方文档中添加或删除的任何字段
2. **官方子智能体** — 添加或删除的任何内置智能体

**要检查的版本数：** `$ARGUMENTS`（默认：如果为空或不是数字则为 10）

这是一个**先读取后报告**的工作流。启动智能体，合并发现，并生成报告。只有在用户批准后才采取行动。

---

## 阶段 1：启动研究智能体

使用以下提示生成 `workflow-claude-subagents-agent`：

> 研究 claude-code-best-practice 项目的子智能体报告漂移情况。检查最近 $ARGUMENTS 个版本（默认：10）。
>
> 获取这 2 个外部来源：
> 1. Sub-agents Reference: https://code.claude.com/docs/en/sub-agents
> 2. Changelog: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
>
> 然后读取本地报告（`best-practice/claude-subagents.md`）。
>
> 检查恰好两件事：
> 1. **前置元数据字段**：将官方文档的支持的前置元数据字段表与报告的前置元数据字段表进行比较。标记任何添加或删除的字段。
> 2. **官方子智能体**：将官方文档的内置子智能体列表与报告的官方智能体表进行比较。标记任何添加或删除的智能体。

---

## 阶段 2：读取之前的变更日志条目

**在智能体运行期间**，读取 `changelog/best-practice/claude-subagents/changelog.md` 以获取最近 25 个条目。解析优先操作以识别：
- **重复出现的项目** — 之前出现过且仍未解决的问题
- **新项目** — 首次出现的问题
- **已解决的项目** — 之前标记的问题现在已修复

---

## 阶段 3：生成报告

**等待智能体完成。** 生成包含以下部分的报告：

1. **前置元数据字段更改** — 官方文档与我们的报告相比添加或删除的字段
2. **官方子智能体更改** — 与我们的表相比添加或删除的内置智能体

最后以优先级**操作项目**摘要表结束。每个项目必须包含一个 `Status`（状态）列，显示 `NEW`（新）、`RECURRING (first seen: <date>)`（重复（首次出现：<日期>））或 `RESOLVED`（已解决）：

```
优先操作：
#  | 类型           | 操作                              | 状态
1  | 新字段      | 将 <字段> 添加到前置元数据表    | NEW
2  | 已删除的字段  | 从表中删除 <字段>           | RECURRING (first seen: <date>)
3  | 新智能体      | 将 <智能体> 添加到官方智能体表 | NEW
4  | 已删除的智能体  | 从表中删除 <智能体>           | NEW
```

还要包含一个**自上次运行以来已解决**的部分，列出之前运行中不再是问题的项目。

---

## 阶段 3.5：将摘要附加到变更日志

**此阶段是强制性的 — 在向用户呈现报告之前始终执行它。**

读取现有的 `changelog/best-practice/claude-subagents/changelog.md` 文件，然后在末尾**附加**（不要覆盖）新条目。条目格式必须完全如下：

```markdown
---

## [<YYYY-MM-DD HH:MM AM/PM PKT>] Claude Code v<VERSION>

| # | Priority | Type | Action | Status |
|---|----------|------|--------|--------|
| 1 | HIGH/MED/LOW | <type> | <action description> | <status> |
| ... | ... | ... | ... | ... |
```

**状态格式 — 必须使用以下三种格式之一：**
- `COMPLETE (reason)` — 已采取行动并成功解决
- `INVALID (reason)` — 发现不正确、不适用或是有意为之
- `ON HOLD (reason)` — 操作推迟，等待外部依赖或用户决定

`(reason)`（原因）是强制性的，必须简要说明已完成的工作或原因。

**附加规则：**
- 始终附加 — 永远不要覆盖或替换先前的条目
- 日期和时间是命令在巴基斯坦标准时间（PKT，UTC+5）执行的时间；通过运行 `TZ=Asia/Karachi date "+%Y-%m-%d %I:%M %p PKT"` 获取。版本来自智能体发现
- 如果 `changelog/best-practice/claude-subagents/changelog.md` 不存在或为空，则使用状态图例表（参见文件顶部）创建它，然后创建第一个条目
- 每个条目由 `---` 分隔
- **仅包含具有 HIGH、MEDIUM 或 LOW 优先级的项目** — 省略 NONE 优先级项目

---

## 阶段 3.6：更新最后更新徽章

**此阶段是强制性的 — 在阶段 3.5 之后、呈现报告之前立即执行它。**

更新 `best-practice/claude-subagents.md` 顶部的"最后更新"徽章。运行 `TZ=Asia/Karachi date "+%b %d, %Y %-I:%M %p PKT"` 获取时间，将其进行 URL 编码（空格转为 `%20`，逗号转为 `%2C`），并替换徽章中的日期部分。如果 Claude Code 版本已更改，也要更新徽章中的版本。

**不要将徽章更新记录为变更日志或报告中的操作项目。** 徽章同步是每次运行的常规部分，而不是发现。

---

## Phase 4: Offer to Take Action

After presenting the report (and confirming both changelog and badge were updated), ask the user:

1. **Execute all actions** — Apply all changes
2. **Execute specific actions** — User picks which numbers to execute
3. **Just save the report** — No changes

When executing:
- **New fields**: Add to the Frontmatter Fields table with correct type, required status, and description from the official docs
- **Removed fields**: Confirm with user before removing
- **New agents**: Add to the official agents table with correct #, name, model, tools, and description
- **Removed agents**: Confirm with user before removing

---

## Critical Rules

1. **Never guess** versions or dates — use data from the agent
2. **Cross-reference field counts** — report field count must match official docs
3. **Cross-reference agent counts** — report agent count must match official docs
4. **Don't auto-execute** — always present the report first
5. **ALWAYS append to changelog** — Phase 3.5 is mandatory. Never skip it. Never overwrite previous entries.
6. **ALWAYS update the Last Updated badge** — Phase 3.6 is mandatory. Never skip it.
7. **Compare with previous runs** — read the last 25 entries from the changelog and mark each action item as NEW, RECURRING, or RESOLVED.
