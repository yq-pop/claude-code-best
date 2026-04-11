# Claude Code: 全局 vs 项目级功能

全面比较哪些 Claude Code 功能仅为全局(`~/.claude/`),哪些同时具有全局和项目级(`.claude/`)等效功能。

<table width="100%">
<tr>
<td><a href="../">← Back to Claude Code Best Practice</a></td>
<td align="right"><img src="/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

## 目录

1. [概述](#overview)
2. [仅全局功能](#global-only-features)
3. [双重作用域功能](#dual-scope-features)
4. [设置优先级](#settings-precedence)
5. [目录结构比较](#directory-structure-comparison)
6. [任务系统](#tasks-system)
7. [代理团队](#agent-teams)
8. [设计原则](#design-principles)
9. [资料来源](#sources)

---

## 概述

Claude Code 使用**作用域层次结构**,其中一些功能同时存在于全局(`~/.claude/`)和项目(`.claude/`)级别,而其他功能则专属于全局。设计原则:*个人状态*或*跨项目协调*的内容全局存在;*团队可共享的项目配置*可以存在于项目级别。

- `~/.claude/` 是你的**用户级主目录**(全局,所有项目)
- 仓库内的 `.claude/` 是你的**项目级主目录**(限定于该项目)

---

## 仅全局功能

这些功能**仅**存在于 `~/.claude/` 下,不能限定于项目:

| 功能 | 位置 | 目的 |
|---------|----------|---------|
| **任务** | `~/.claude/tasks/` | 跨会话和代理的持久任务列表 |
| **代理团队** | `~/.claude/teams/` | 多代理协调配置(实验性,2026年2月) |
| **自动内存** | `~/.claude/projects/<hash>/memory/` | Claude 为每个项目自我编写的学习内容(个人,从不共享) |
| **凭据与 OAuth** | 系统密钥链 + `~/.claude.json` | API密钥、OAuth令牌(从不在项目文件中) |
| **键绑定** | `~/.claude/keybindings.json` | 自定义键盘快捷键 |
| **MCP 用户服务器** | `~/.claude.json`(`mcpServers` 键) | 所有项目的个人 MCP 服务器 |
| **首选项/缓存** | `~/.claude.json` | 主题、模型、输出风格、会话状态 |

---

## 双重作用域功能

这些功能存在于两个级别,**项目级优先于**全局:

| 功能 | 全局(`~/.claude/`) | 项目(`.claude/`) | 优先级 |
|---------|----------------------|---------------------|------------|
| **CLAUDE.md** | `~/.claude/CLAUDE.md` | `./CLAUDE.md` 或 `.claude/CLAUDE.md` | 项目覆盖全局 |
| **设置** | `~/.claude/settings.json` | `.claude/settings.json` + `.claude/settings.local.json` | 项目 > 全局 |
| **规则** | `~/.claude/rules/*.md` | `.claude/rules/*.md` | 项目覆盖 |
| **代理/子代理** | `~/.claude/agents/*.md` | `.claude/agents/*.md` | 项目覆盖 |
| **命令** | `~/.claude/commands/*.md` | `.claude/commands/*.md` | 两者都可用 |
| **技能** | `~/.claude/skills/` | `.claude/skills/` | 两者都可用 |
| **钩子** | `~/.claude/hooks/` | `.claude/hooks/` | 两者都执行 |
| **MCP 服务器** | `~/.claude.json`(用户作用域) | `.mcp.json`(项目作用域) | 三个作用域:本地 > 项目 > 用户 |

---

## 设置优先级

用户可写设置按此覆盖顺序应用(从高到低):

| 优先级 | 位置 | 作用域 | 版本控制 | 目的 |
|----------|----------|-------|-----------------|---------|
| 1 | 命令行标志 | 会话 | 不适用 | 单会话覆盖 |
| 2 | `.claude/settings.local.json` | 项目 | 否(git忽略) | 个人项目特定 |
| 3 | `.claude/settings.json` | 项目 | 是(已提交) | 团队共享设置 |
| 4 | `~/.claude/settings.local.json` | 用户 | 不适用 | 个人全局覆盖 |
| 5 | `~/.claude/settings.json` | 用户 | 不适用 | 全局个人设置 |

策略层:`managed-settings.json` 是组织强制的,无法被本地文件覆盖。

**重要**: `deny` 规则具有最高的安全优先级,无法被较低优先级的允许/询问规则覆盖。

---

## Directory Structure Comparison

### Global Scope (`~/.claude/`)

```
~/.claude/
├── settings.json              # User-level settings (all projects)
├── settings.local.json        # Personal overrides
├── CLAUDE.md                  # User memory (all projects)
├── agents/                    # User subagents (available to all projects)
│   └── *.md
├── rules/                     # User-level modular rules
│   └── *.md
├── commands/                  # User-level commands
│   └── *.md
├── skills/                    # User-level skills
│   └── */SKILL.md
├── tasks/                     # GLOBAL-ONLY: Task lists
│   └── {task-list-id}/
├── teams/                     # GLOBAL-ONLY: Agent team configs
│   └── {team-name}/
│       └── config.json
├── projects/                  # GLOBAL-ONLY: Per-project auto-memory
│   └── {project-hash}/
│       └── memory/
│           ├── MEMORY.md
│           └── *.md
├── keybindings.json           # GLOBAL-ONLY: Keyboard shortcuts
└── hooks/                     # User-level hooks
    ├── scripts/
    └── config/

~/.claude.json                 # GLOBAL-ONLY: MCP servers, OAuth, preferences, caches
```

### Project Scope (`.claude/`)

```
.claude/
├── settings.json              # Team-shared settings
├── settings.local.json        # Personal project overrides (git-ignored)
├── CLAUDE.md                  # Project memory (alternative to ./CLAUDE.md)
├── agents/                    # Project subagents
│   └── *.md
├── rules/                     # Project-level modular rules
│   └── *.md
├── commands/                  # Custom slash commands
│   └── *.md
├── skills/                    # Custom skills
│   └── {skill-name}/
│       ├── SKILL.md
│       └── supporting-files/
├── hooks/                     # Project-level hooks
│   ├── scripts/
│   └── config/
└── plugins/                   # Installed plugins

.mcp.json                      # Project-scoped MCP servers (repo root)
```

---

## Tasks System

Introduced in **Claude Code v2.1.16** (January 22, 2026), replacing the deprecated TodoWrite system.

### Storage

Tasks are stored at `~/.claude/tasks/` on the local filesystem (not in a cloud database). This makes task state auditable, version-controllable, and crash-recoverable.

### Tools

| Tool | Purpose |
|------|---------|
| **TaskCreate** | Create a new task with `subject`, `description`, and `activeForm` |
| **TaskGet** | Retrieve full details of a specific task by ID |
| **TaskUpdate** | Change status, set owner, add dependencies, or delete |
| **TaskList** | List all tasks with their current status |

### Task Lifecycle

```
pending  →  in_progress  →  completed
```

### Dependency Management

Tasks can block other tasks via `addBlockedBy`/`addBlocks`, creating dependency graphs that prevent premature execution.

### Multi-Session Collaboration

```bash
CLAUDE_CODE_TASK_LIST_ID=my-project-tasks claude
```

All sessions sharing the same ID see task updates in real-time, enabling parallel workstreams and session resumption.

### Key Differences from Old Todos

| Feature | Old Todos | New Tasks |
|---------|-----------|-----------|
| Scope | Single session | Cross-session, cross-agent |
| Dependencies | None | Full dependency graph |
| Storage | In-memory only | File system (`~/.claude/tasks/`) |
| Persistence | Lost on session end | Survives restarts and crashes |
| Multi-session | Not possible | Via `CLAUDE_CODE_TASK_LIST_ID` |

---

## Agent Teams

Announced **February 5, 2026** as an experimental feature. Agent Teams allow multiple Claude Code sessions to coordinate on shared work.

### Enabling

```json
// In ~/.claude/settings.json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

### Configuration

Team configs live at `~/.claude/teams/{team-name}/` and support modes:

| Mode | Description | Requirements |
|------|-------------|--------------|
| **In-process** (default) | All teammates run inside your terminal | None |
| **Split panes** | Each teammate gets its own pane | tmux or iTerm2 (not VS Code terminal) |

---

## Design Principles

The global-only vs dual-scope split follows a clear pattern:

| Category | Scope | Rationale |
|----------|-------|-----------|
| **Coordination state** (tasks, teams) | Global-only | Needs to persist beyond any single project |
| **Security state** (credentials, OAuth) | Global-only | Prevents accidental commits to version control |
| **Personal learning** (auto-memory) | Global-only | User-specific, not team-shareable |
| **Input preferences** (keybindings) | Global-only | User muscle memory, not project-specific |
| **Configuration** (settings, rules, agents) | Both levels | Teams need to share project-specific behavior |
| **Workflow definitions** (commands, skills) | Both levels | Can be personal or team-shared |

Auto-memory (`~/.claude/projects/<hash>/memory/`) is a notable hybrid: it's *about* a specific project but stored *globally* because it represents personal learning rather than team-shareable configuration.

---

## 资料来源

- [Claude Code Settings Documentation](https://code.claude.com/docs/en/settings)
- [Orchestrate Teams of Claude Code Sessions](https://code.claude.com/docs/en/agent-teams)
- [What are Tasks in Claude Code - ClaudeLog](https://claudelog.com/faqs/what-are-tasks-in-claude-code/)
- [Claude Code Task Management - ClaudeFast](https://claudefa.st/blog/guide/development/task-management)
- [Claude Code Tasks Update - VentureBeat](https://venturebeat.com/orchestration/claude-codes-tasks-update-lets-agents-work-longer-and-coordinate-across)
- [Where Are Claude Code Global Settings - ClaudeLog](https://claudelog.com/faqs/where-are-claude-code-global-settings/)
- [Claude Opus 4.6 Agent Teams - VentureBeat](https://venturebeat.com/technology/anthropics-claude-opus-4-6-brings-1m-token-context-and-agent-teams-to-take)
- [How to Set Up Claude Code Agent Teams (Full Walkthrough) - r/ClaudeCode](https://www.reddit.com/r/ClaudeCode/comments/1qz8tyy/how_to_set_up_claude_code_agent_teams_full/)
- [Anthropic replaced Claude Code's old 'Todos' with Tasks - r/ClaudeAI](https://www.reddit.com/r/ClaudeAI/comments/1qkjznp/anthropic_replaced_claude_codes_old_todos_with/)
