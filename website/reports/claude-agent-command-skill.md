# 代理 vs 命令 vs 技能 — 何时使用什么

Claude Code 中三种扩展机制的比较:子代理、命令和技能。

<table width="100%">
<tr>
<td><a href="../">← Back to Claude Code Best Practice</a></td>
<td align="right"><img src="/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

![Slash menu showing time-skill, time-command, and time-agent](assets/agent-command-skill-1.jpg)

---

## 一览表

| | 代理 | 命令 | 技能 |
|---|---|---|---|
| **位置** | `.claude/agents/<name>.md` | `.claude/commands/<name>.md` | `.claude/skills/<name>/SKILL.md` |
| **上下文** | 独立的子代理进程 | 内联(主对话) | 内联(主对话) |
| **用户可调用** | 无 `/` 菜单 — 由 Claude 或通过 Agent 工具调用 | 是 — `/command-name` | 是 — `/skill-name`(除非 `user-invocable: false`) |
| **由 Claude 自动调用** | 是 — 通过 `description` 字段 | 否 | 是 — 通过 `description` 字段(除非 `disable-model-invocation: true`) |
| **接受参数** | 通过 `prompt` 参数 | `$ARGUMENTS`, `$0`, `$1` | `$ARGUMENTS`, `$0`, `$1` |
| **动态上下文注入** | 否 | 是 — `` !`command` `` | 是 — `` !`command` `` |
| **独立上下文窗口** | 是 — 隔离的 | 否 — 共享主窗口 | 否 — 共享主窗口(除非 `context: fork`) |
| **模型覆盖** | `model:` 前置信息 | `model:` 前置信息 | `model:` 前置信息 |
| **工具限制** | `tools:` / `disallowedTools:` | `allowed-tools:` | `allowed-tools:` |
| **钩子** | `hooks:` 前置信息 | — | `hooks:` 前置信息 |
| **内存** | `memory:` 前置信息(用户/项目/本地) | — | — |
| **可预加载技能** | 是 — `skills:` 前置信息 | — | — |
| **MCP 服务器** | `mcpServers:` 前置信息 | — | — |

---

## 何时使用各种机制

### 使用代理的场景:

- 任务是**自主的多步骤**任务 — 代理需要探索、决策和行动,而无需持续指导
- 你需要**上下文隔离** — 工作不应污染主对话窗口
- 代理需要**跨会话的持久内存**(例如,学习模式的代码审查器)
- 你想通过技能**预加载领域知识**而不使主上下文混乱
- 任务受益于**在后台运行**或在 **git worktree** 中运行
- 你需要**工具限制**或**不同的权限模式**(例如,`acceptEdits`, `plan`)

**示例**: `weather-agent` — 使用其预加载的 `weather-fetcher` 技能自主获取天气数据,在独立的上下文中运行并限制工具。

### 使用命令的场景:

- 你需要**用户启动的入口点** — 用户明确触发的工作流
- 工作流涉及**协调**其他代理或技能
- 你想**保持上下文精简** — 命令内容在用户触发之前不会注入到会话上下文中

**示例**: `weather-orchestrator` — 用户触发它,它询问C/F偏好,调用代理,然后调用 SVG 技能。

### 使用技能的场景:

- 你希望 **Claude 根据用户意图自动调用** — 技能描述被注入到会话上下文中进行语义匹配
- 任务是可从多个地方调用的**可重用过程**(命令、代理或 Claude 本身)
- 你需要**代理预加载** — 在启动时将领域知识嵌入到特定代理中

**示例**: `weather-svg-creator` — 当用户询问天气卡片时,Claude 自动调用它;也可从命令调用。

---

## 命令 → 代理 → 技能架构

这个仓库展示了一个分层编排模式:

```
用户触发 /command
    ↓
命令编排工作流
    ↓
命令调用代理(独立上下文,自主)
    ↓
代理使用预加载的技能(领域知识)
    ↓
命令调用技能(内联,用于输出生成)
```

**具体示例** — 天气系统:

```
/weather-orchestrator (命令 — 入口点,询问C/F)
    ↓
weather-agent (代理 — 自主获取温度)
    ├── weather-fetcher (代理技能 — 预加载的API指令)
    ↓
weather-svg-creator (技能 — 内联创建SVG)
```

---

## 前置信息比较

### 代理前置信息

```yaml
---
name: my-agent
description: Use this agent PROACTIVELY when...
tools: Read, Write, Edit, Bash
model: sonnet
maxTurns: 10
permissionMode: acceptEdits
memory: user
skills:
  - my-skill
---
```

### 命令前置信息

```yaml
---
description: Do something useful
argument-hint: [issue-number]
allowed-tools: Read, Edit, Bash(gh *)
model: sonnet
---
```

### 技能前置信息

```yaml
---
name: my-skill
description: Do something when the user asks for...
argument-hint: [file-path]
disable-model-invocation: false
user-invocable: true
allowed-tools: Read, Grep, Glob
model: sonnet
context: fork
agent: general-purpose
---
```

---

## 关键区别

### 自动调用

| 机制 | Claude 能自动调用吗? | 如何阻止 |
|-----------|------------------------|----------------|
| 代理 | 是 — 通过 `description`(使用"PROACTIVELY"鼓励) | 删除或软化描述 |
| 命令 | 否 — 始终通过 `/` 由用户启动 | 不适用 |
| 技能 | 是 — 通过 `description` | 设置 `disable-model-invocation: true` |

### 在 `/` 菜单中的可见性

| 机制 | 出现在 `/` 菜单中? | 如何隐藏 |
|-----------|---------------------|-------------|
| 代理 | 否 | 不适用 |
| 命令 | 是 — 始终 | 无法隐藏 |
| 技能 | 是 — 默认 | 设置 `user-invocable: false` |

### 上下文隔离

| 机制 | 在独立上下文中运行? | 如何配置 |
|-----------|---------------------|-----------------|
| 代理 | 始终 | 内置行为 |
| 命令 | 从不 | 不适用 |
| 技能 | 可选 | 设置 `context: fork` |

---

## 实例演示:"现在几点了?"

这个仓库为同一任务定义了所有三种机制 — 显示 PKT 的当前时间。当用户输入**"现在几点了?"**而没有明确调用任何 `/` 命令时会发生什么:

| 机制 | 会触发吗? | 原因 |
|-----------|--------------|---------------|
| `time-command` | 否 | 命令**从不自动调用**。用户需要明确输入 `/time-command` 才能运行。命令没有自动发现路径 — 它们严格由用户启动。 |
| `time-agent` | **是**(可能) | 代理的 `description` 说*"使用此代理显示巴基斯坦标准时间的当前时间"*。Claude 将此与用户意图匹配,可能通过 Agent 工具生成它。但是,代理在**独立的上下文窗口**中运行,对于这个简单任务来说比必要的重。 |
| `time-skill` | **是**(最有可能) | 技能的 `description` 说*"显示巴基斯坦标准时间(PKT,UTC+5)的当前时间。当用户询问当前时间、巴基斯坦时间或PKT时使用。"* Claude 匹配此内容并通过 Skill 工具调用它。由于它**内联**运行且没有上下文开销,因此是最高效的匹配。 |

### 解析顺序

当多个机制匹配相同意图时,Claude 优先选择满足请求的**最轻量级选项**:

```
1. 技能(内联,无上下文开销)     ← 首选
2. 代理(独立上下文,自主)       ← 如果技能不可用或任务复杂则使用
3. 命令(从不 — 需要明确的 /)  ← 仅当用户输入 /time-command
```

### 如果在技能上设置了 `disable-model-invocation: true` 会怎样?

那么 Claude **无法**自动调用技能。代理成为唯一可自动调用的选项,因此 Claude 会生成 `time-agent` — 代价是为一行 bash 命令使用独立的上下文窗口。

### 如果技能和代理都禁用了自动调用会怎样?

那么**没有任何东西会自动触发**。Claude 会退回到其自身的一般知识,可能只是直接运行 `TZ='Asia/Karachi' date` — 不涉及扩展机制。用户需要明确输入 `/time-command` 或 `/time-skill` 才能使用其中一个。

![Claude auto-invoking time-skill when user asks "What is the current time?"](assets/agent-command-skill-2.png)

---

## 资料来源

- [Claude Code Skills — Docs](https://code.claude.com/docs/en/skills)
- [Claude Code Sub-agents — Docs](https://code.claude.com/docs/en/sub-agents)
- [Claude Code Slash Commands — Docs](https://code.claude.com/docs/en/slash-commands)
- [Skills Best Practice](../best-practice/claude-skills.md)
- [Commands Best Practice](../best-practice/claude-commands.md)
- [Sub-agents Best Practice](../best-practice/claude-subagents.md)
