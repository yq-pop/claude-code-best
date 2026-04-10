---
description: 通过并行研究所有 10 个工作流仓库来更新 DEVELOPMENT WORKFLOWS 表
---

# 工作流 — 开发工作流

通过并行研究 10 个仓库来更新 `README.md` 中的 DEVELOPMENT WORKFLOWS 表。启动代理、合并结果、展示变更、如果批准则更新表格。

---

## 10 个仓库

| # | Repo | Owner |
|---|------|-------|
| 1 | `github/spec-kit` | GitHub (John Lam / Den Delimarsky) |
| 2 | `Fission-AI/OpenSpec` | Fission-AI (@0xTab) |
| 3 | `humanlayer/humanlayer` | HumanLayer (Dex Horthy) |
| 4 | `affaan-m/everything-claude-code` | Affaan Mustafa |
| 5 | `gsd-build/get-shit-done` | Lex Christopherson |
| 6 | `obra/superpowers` | Jesse Vincent |
| 7 | `garrytan/gstack` | Garry Tan (YC CEO) |
| 8 | `bmad-code-org/BMAD-METHOD` | BMAD Code Org |
| 9 | `EveryInc/compound-engineering-plugin` | Every.to |
| 10 | `Yeachan-Heo/oh-my-claudecode` | Yeachan Heo (@bellman_ych) |

---

## 表格格式

README 表格包含以下列：

```markdown
| Name | ★ | Uniqueness | Plan | <img src="!/tags/a.svg" height="14"> | <img src="!/tags/c.svg" height="14"> | <img src="!/tags/s.svg" height="14"> |
```

- **Name**：`[简称](github-url)` — 使用项目名称，而非 owner/repo
- **★**：星标数向 `k` 取整（例如 98k、10k、4.1k）。少于 1000 显示确切数字
- **Uniqueness**：使用 `![tag](https://img.shields.io/badge/TAG-ddf4ff)` 的 2-3 个 shields.io 徽章标签。空格用下划线，连字符用 `--`，`+` 用 `%2B`，`/` 用 `%2F`
- **Plan**：图标 + Plan 实现的链接名称。图标为命令使用 `<img src="!/tags/c.svg" height="14">`，代理使用 `<img src="!/tags/a.svg" height="14">`，技能使用 `<img src="!/tags/s.svg" height="14">`。名称链接到仓库中的实际文件
- **Agent/Command/Skill counts**：仅显示数字（例如 `25`、`0`、`108+`）

**排序规则**：按星标降序排列（最高在前）。不要按 Plan 类型分组。

---

## 阶段 0：读取当前状态

读取以下文件：

1. `README.md` — `## ⚙️ DEVELOPMENT WORKFLOWS` 表（注意当前星标、标签、Plan 链接、计数）
2. `changelog/development-workflows/changelog.md` — 之前的变更日志条目

---

## 阶段 1：启动 2 个研究代理

**立即**在**单条消息**中生成两个代理（并行）。每个使用 `subagent_type: "development-workflows-research-agent"`。

### 代理 1（3 个仓库）

> 研究以下 3 个 Claude Code 工作流仓库：
>
> **仓库 1：github/spec-kit**（https://github.com/github/spec-kit）
> **仓库 2：affaan-m/everything-claude-code**（https://github.com/affaan-m/everything-claude-code）
> **仓库 3：obra/superpowers**（https://github.com/obra/superpowers）
>
> 对于每个仓库，返回：
>
> 1. **Stars** — 使用 GitHub API `https://api.github.com/repos/{owner}/{repo}`，读取 `stargazers_count`。向 `k` 取整。
> 2. **Agent count** — 计算 `agents/` 或 `.claude/agents/` 中的 `.md` 文件。对于 obra，还要计算由技能调度的隐式子代理。
> 3. **Skill count** — 计算 `skills/` 或 `.claude/skills/` 中的文件夹。
> 4. **Command count** — 计算 `commands/` 或 `.claude/commands/` 中的 `.md` 文件。对于 spec-kit，计算 `templates/commands/` 中的文件。
> 5. **Plan implementation** — 查找 Plan/planning 代理、技能或命令。返回其名称、类型（agent/skill/command）和文件路径。
> 6. **Uniqueness tags** — 2-3 个简短标签（每个 2-3 个单词），捕捉这个工作流的独特之处。
> 7. **Notable changes** — 有任何重要的最近变更吗？新代理/技能/命令、主要版本？
>
> 返回每个仓库的结构化报告：
> ```
> REPO: github/spec-kit
> STARS: <number>k
> AGENTS: <count>
> COMMANDS: <count>
> SKILLS: <count>
> PLAN: <name> (<type>) — <file-path>
> TAGS: <tag1>, <tag2>, <tag3>
> CHANGES: <changes or "No significant changes">
> ```

### 代理 2（7 个仓库）

> 研究以下 7 个 Claude Code 工作流仓库：
>
> **仓库 1：Fission-AI/OpenSpec**（https://github.com/Fission-AI/OpenSpec）
> **仓库 2：humanlayer/humanlayer**（https://github.com/humanlayer/humanlayer）
> **仓库 3：gsd-build/get-shit-done**（https://github.com/gsd-build/get-shit-done）
> **仓库 4：garrytan/gstack**（https://github.com/garrytan/gstack）
> **仓库 5：bmad-code-org/BMAD-METHOD**（https://github.com/bmad-code-org/BMAD-METHOD）
> **仓库 6：EveryInc/compound-engineering-plugin**（https://github.com/EveryInc/compound-engineering-plugin）
> **仓库 7：Yeachan-Heo/oh-my-claudecode**（https://github.com/Yeachan-Heo/oh-my-claudecode）
>
> 对于每个仓库，返回：
>
> 1. **Stars** — 使用 GitHub API `https://api.github.com/repos/{owner}/{repo}`，读取 `stargazers_count`。向 `k` 取整。
> 2. **Agent count** — 计算 `agents/` 或 `.claude/agents/` 中的 `.md` 文件。对于 BMAD，计算 `src/bmm-skills/` 中的 agent-persona 技能。对于 compound-engineering-plugin，计算 `plugins/compound-engineering/agents/` 所有子目录中的 `.md` 文件。对于 oh-my-claudecode，计算仓库根目录 `agents/` 中的 `.md` 文件。
> 3. **Skill count** — 计算 `skills/` 或 `.claude/skills/` 中的文件夹。对于 gstack，技能是带有 SKILL.md 的根级目录。对于 BMAD，计算 `src/bmm-skills/` 和 `src/core-skills/` 中的所有技能。对于 compound-engineering-plugin，计算 `plugins/compound-engineering/skills/` 加上 `plugins/coding-tutor/skills/` 中的文件夹。对于 oh-my-claudecode，计算仓库根目录 `skills/` 中的文件夹。
> 4. **Command count** — 计算 `commands/` 或 `.claude/commands/` 中的 `.md` 文件。对于 GSD，计算 `commands/gsd/` 中的。对于 OpenSpec，计算 `/opsx:*` 命令。对于 BMAD，计数为 0（命令在安装时生成）。对于 compound-engineering-plugin，计算 `.claude/commands/` 加上 `plugins/coding-tutor/commands/` 中的 `.md` 文件。对于 oh-my-claudecode，计数为 0（技能作为斜杠命令）。
> 5. **Plan implementation** — 查找 Plan/planning 代理、技能或命令。返回其名称、类型（agent/skill/command）和文件路径。
> 6. **Uniqueness tags** — 2-3 个简短标签（每个 2-3 个单词），捕捉这个工作流的独特之处。
> 7. **Notable changes** — 有任何重要的最近变更吗？新代理/技能/命令、主要版本？
>
> 返回每个仓库的结构化报告：
> ```
> REPO: Fission-AI/OpenSpec
> STARS: <number>k
> AGENTS: <count>
> COMMANDS: <count>
> SKILLS: <count>
> PLAN: <name> (<type>) — <file-path>
> TAGS: <tag1>, <tag2>, <tag3>
> CHANGES: <changes or "No significant changes">
> ```

---

## 阶段 2：比较与报告

**等待两个代理完成。**然后将发现与当前表格进行比较并展示：

```
Development Workflows — 更新报告
══════════════════════════════════════

发现的变更：
  <repo>：★ <old>k → <new>k | agents <old>→<new> | commands <old>→<new> | skills <old>→<new>
  <repo>：标签已更新：<old tags> → <new tags>
  <repo>：Plan 链接已更改：<old> → <new>
  ...

无变更：
  <repo>：✓（所有值匹配）
  ...

行动项：
#  | 类型        | 操作                                | 状态
1  | Star        | 更新 <repo> ★ 从 Xk 到 Yk           | NEW/RECURRING
2  | Count       | 更新 <repo> agents 从 X 到 Y        | NEW/RECURRING
3  | Tags        | 更新 <repo> 标签                    | NEW/RECURRING
4  | Plan        | 更新 <repo> Plan 链接               | NEW/RECURRING
5  | Sort        | 移动 <repo>（Plan 类型已更改）       | NEW/RECURRING
```

与之前的变更日志条目进行比较，并将项目标记为 `NEW`、`RECURRING` 或 `RESOLVED`。

---

## 阶段 2.5：追加到变更日志

**强制执行** — 在向用户展示之前始终执行。

读取 `changelog/development-workflows/changelog.md`，然后**追加**新条目。如果文件不存在，创建它并添加状态图例，然后添加第一个条目。

```markdown
---

## [<YYYY-MM-DD HH:MM AM/PM PKT>] Development Workflows 更新

| # | 优先级 | 类型 | 操作 | 状态 |
|---|----------|------|--------|--------|
| 1 | HIGH/MED/LOW | <type> | <action> | <status> |
```

通过 `TZ=Asia/Karachi date "+%Y-%m-%d %I:%M %p PKT"` 获取时间。状态必须是以下之一：
- `COMPLETE (reason)` | `INVALID (reason)` | `ON HOLD (reason)`

始终追加，永不覆盖。

---

## 阶段 2.6：更新最后更新徽章

**强制执行** — 在阶段 2.5 之后执行。

更新 `README.md` 第 4 行的徽章。通过 `TZ=Asia/Karachi date "+%b %d, %Y %-I:%M %p PKT"` 获取时间，进行 URL 编码，替换徽章中的日期。不要将此记录为行动项。

---

## 阶段 3：执行

询问用户：**(1) 执行全部** | **(2) 执行特定项** | **(3) 跳过**

执行时，编辑 `README.md` 中的 `## ⚙️ DEVELOPMENT WORKFLOWS` 表：
- 更新每行的星标、标签、Plan 链接、计数
- 保持排序顺序：星标降序（最高在前）。不要按 Plan 类型分组
- 完全匹配现有格式（图标、徽章 URL、链接样式）

---

## 规则

1. **并行启动两个代理** — 单条消息，永不串行
2. **永不猜测** — 仅使用代理数据
3. **不要自动执行** — 先展示报告，等待批准
4. **始终追加变更日志**和**始终更新徽章** — 强制执行
5. **按星标降序排列** — 最高星标在前，不要按 Plan 类型分组
6. **标签使用 shields.io** — `![tag](https://img.shields.io/badge/TAG-ddf4ff)`，空格用 `_`，连字符用 `--`
7. **Plan 链接必须指向实际文件** — 而非仓库根目录
8. **Agents、commands、skills 是不同的** — 从各自的目录计数，不要混淆
9. **星标向 k 一致取整** — `k` 后缀（98k、10k、4.1k）。少于 1000 显示确切数字
10. **与之前的变更日志比较** — 将项目标记为 NEW、RECURRING 或 RESOLVED
