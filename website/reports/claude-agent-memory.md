# Claude Code: 代理内存前置信息

子代理的持久内存 — 使代理能够跨会话学习、记忆和构建知识。

<table width="100%">
<tr>
<td><a href="../">← Back to Claude Code Best Practice</a></td>
<td align="right"><img src="/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

## 概述

在 **Claude Code v2.1.33**(2026年2月)中引入,`memory` 前置信息字段为每个子代理提供了自己的持久化基于 markdown 的知识存储。在此之前,每次代理调用都从头开始。

```yaml
---
name: code-reviewer
description: Reviews code for quality and best practices
tools: Read, Write, Edit, Bash
model: sonnet
memory: user
---

You are a code reviewer. As you review code, update your agent memory with
patterns, conventions, and recurring issues you discover.
```

---

## 内存作用域

| 作用域 | 存储位置 | 版本控制 | 共享 | 最适合 |
|-------|-----------------|-------------------|--------|----------|
| `user` | `~/.claude/agent-memory/<agent-name>/` | 否 | 否 | 跨项目知识(推荐默认) |
| `project` | `.claude/agent-memory/<agent-name>/` | 是 | 是 | 团队应共享的项目特定知识 |
| `local` | `.claude/agent-memory-local/<agent-name>/` | 否(git忽略) | 否 | 个人的项目特定知识 |

这些作用域反映了设置层次结构(`~/.claude/settings.json` → `.claude/settings.json` → `.claude/settings.local.json`)。

---

## 工作原理

1. **启动时**: `MEMORY.md` 的前200行被注入到代理的系统提示中
2. **工具访问**: `Read`, `Write`, `Edit` 自动启用,以便代理可以管理其内存
3. **执行期间**: 代理可以自由地读写其内存目录
4. **策展**: 如果 `MEMORY.md` 超过200行,代理会将详细信息移至特定主题文件

```
~/.claude/agent-memory/code-reviewer/     # user scope example
├── MEMORY.md                              # Primary file (first 200 lines loaded)
├── react-patterns.md                      # Topic-specific file
└── security-checklist.md                  # Topic-specific file
```

---

## 代理内存 vs 其他内存系统

| 系统 | 谁写入 | 谁读取 | 作用域 |
|--------|-----------|-----------|-------|
| **CLAUDE.md** | 你(手动) | 主 Claude + 所有代理 | 项目 |
| **自动内存** | 主 Claude(自动) | 仅主 Claude | 每个项目每个用户 |
| **`/memory` 命令** | 你(通过编辑器) | 仅主 Claude | 每个项目每个用户 |
| **代理内存** | 代理本身 | 仅该特定代理 | 可配置(用户/项目/本地) |

这些系统是**互补的** — 代理会读取 CLAUDE.md(项目上下文)和自己的内存(代理特定知识)。

---

## 实际示例

```yaml
---
name: api-developer
description: 遵循团队约定实现API端点
tools: Read, Write, Edit, Bash
model: sonnet
memory: project
skills:
  - api-conventions
  - error-handling-patterns
---

实现API端点。遵循你预加载的技能中的约定。
在工作时,将架构决策和模式保存到你的内存中。
```

这结合了**技能**(启动时的静态知识)和**内存**(随时间构建的动态知识)。

---

## 提示

- **提示内存使用** — 包含明确的指令:`"在开始之前,查看你的内存。完成后,用你学到的内容更新你的内存。"`
- **调用代理时请求内存检查**: `"审查此PR,并检查你的内存以查找之前看到的模式。"`
- **选择正确的作用域** — `user` 用于跨项目,`project` 用于团队共享,`local` 用于个人

---

## 资料来源

- [Create custom subagents — Claude Code Docs](https://code.claude.com/docs/en/sub-agents)
- [Manage Claude's memory — Claude Code Docs](https://code.claude.com/docs/en/memory)
- [Claude Code v2.1.33 Release Notes](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)
