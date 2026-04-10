# CLAUDE.md

本文件为 Claude Code (claude.ai/code) 在此仓库中工作时提供指导。

## 仓库概述

这是一个 Claude Code 配置的最佳实践仓库，展示了技能、子智能体、钩子和命令的模式。它作为参考实现而非应用程序代码库。

## 关键组件

### 天气系统（示例工作流）
通过 **命令 → 智能体 → 技能** 架构展示两种不同的技能模式：
- `/weather-orchestrator` 命令（`.claude/commands/weather-orchestrator.md`）：入口点——询问用户摄氏度/华氏度，调用智能体，然后调用 SVG 技能
- `weather-agent` 智能体（`.claude/agents/weather-agent.md`）：使用其预加载的 `weather-fetcher` 技能获取温度（智能体技能模式）
- `weather-fetcher` 技能（`.claude/skills/weather-fetcher/SKILL.md`）：预加载到智能体中——从 Open-Meteo 获取温度的说明
- `weather-svg-creator` 技能（`.claude/skills/weather-svg-creator/SKILL.md`）：技能——创建 SVG 天气卡片，写入 `orchestration-workflow/weather.svg` 和 `orchestration-workflow/output.md`

两种技能模式：智能体技能（通过 `skills:` 字段预加载）与技能（通过 `Skill` 工具调用）。查看 `orchestration-workflow/orchestration-workflow.md` 了解完整流程图。

### 技能定义结构
`.claude/skills/<name>/SKILL.md` 中的技能使用 YAML 前置元数据：
- `name`：显示名称和 `/slash-command`（默认为目录名）
- `description`：何时调用（推荐用于自动发现）
- `argument-hint`：自动完成提示（例如，`[issue-number]`）
- `disable-model-invocation`：设置为 `true` 以防止自动调用
- `user-invocable`：设置为 `false` 以从 `/` 菜单中隐藏（仅后台知识）
- `allowed-tools`：技能激活时无需权限提示即可使用的工具
- `model`：技能激活时使用的模型
- `context`：设置为 `fork` 以在隔离的子智能体上下文中运行
- `agent`：`context: fork` 的子智能体类型（默认：`general-purpose`）
- `hooks`：此技能范围内的生命周期钩子

### 演示系统
查看 `.claude/rules/presentation.md`——所有演示工作都委托给 `presentation-curator` 智能体。

### 钩子系统
`.claude/hooks/` 中的跨平台声音通知系统：
- `scripts/hooks.py`：Claude Code 钩子事件的主处理器
- `config/hooks-config.json`：团队共享配置
- `config/hooks-config.local.json`：个人覆盖（git 忽略）
- `sounds/`：按钩子事件组织的音频文件（通过 ElevenLabs TTS 生成）

在 `.claude/settings.json` 中配置的钩子事件：PreToolUse、PostToolUse、UserPromptSubmit、Notification、Stop、SubagentStart、SubagentStop、PreCompact、SessionStart、SessionEnd、Setup、PermissionRequest、TeammateIdle、TaskCompleted、ConfigChange。

特殊处理：git 提交触发 `pretooluse-git-committing` 声音。

## 关键模式

### 子智能体编排
子智能体**不能**通过 bash 命令调用其他子智能体。使用 Agent 工具（在 v2.1.63 中从 Task 重命名；`Task(...)` 仍作为别名工作）：
```
Agent(subagent_type="agent-name", description="...", prompt="...", model="haiku")
```

在子智能体定义中明确工具使用。避免使用可能被误解为 bash 命令的模糊术语，如"launch"。

### 子智能体定义结构
`.claude/agents/*.md` 中的子智能体使用 YAML 前置元数据：
- `name`：子智能体标识符
- `description`：何时调用（使用"PROACTIVELY"进行自动调用）
- `tools`：工具的逗号分隔允许列表（如果省略则继承所有）。支持 `Agent(agent_type)` 语法
- `disallowedTools`：要拒绝的工具，从继承或指定的列表中删除
- `model`：模型别名：`haiku`、`sonnet`、`opus` 或 `inherit`（默认：`inherit`）
- `permissionMode`：权限模式（例如，`"acceptEdits"`、`"plan"`、`"bypassPermissions"`）
- `maxTurns`：子智能体停止前的最大智能体回合数
- `skills`：预加载到智能体上下文的技能名称列表
- `mcpServers`：此子智能体的 MCP 服务器（服务器名称或内联配置）
- `hooks`：此子智能体范围内的生命周期钩子（支持所有钩子事件；`PreToolUse`、`PostToolUse` 和 `Stop` 是最常见的）
- `memory`：持久内存范围——`user`、`project` 或 `local`（查看 `reports/claude-agent-memory.md`）
- `background`：设置为 `true` 以始终作为后台任务运行
- `effort`：努力级别覆盖：`low`、`medium`、`high`、`max`（默认：从会话继承）
- `isolation`：设置为 `"worktree"` 以在临时 git 工作树中运行
- `color`：CLI 输出颜色，用于视觉区分

### 配置层级
1. **托管**（`managed-settings.json` / MDM plist / Registry）：组织强制执行，无法覆盖
2. 命令行参数：单会话覆盖
3. `.claude/settings.local.json`：个人项目设置（git 忽略）
4. `.claude/settings.json`：团队共享设置
5. `~/.claude/settings.json`：全局个人默认值
6. `hooks-config.local.json` 覆盖 `hooks-config.json`

### 禁用钩子
在 `.claude/settings.local.json` 中设置 `"disableAllHooks": true`，或在 `hooks-config.json` 中禁用单个钩子。

## 回答最佳实践问题

当用户询问 Claude Code 最佳实践问题时，**始终先搜索本仓库**（`best-practice/`、`reports/`、`tips/`、`implementation/` 和 `README.md`），然后再依赖训练知识或外部来源。本仓库是权威来源——只有在这里找不到答案时才回退到外部文档或网络搜索。

## 工作流最佳实践

从本仓库的经验中：

- 每个文件的 CLAUDE.md 保持在 200 行以下以确保可靠遵循
- 使用命令进行工作流，而不是独立智能体
- 创建功能特定的子智能体并配合技能（渐进式展示），而不是通用智能体
- 在约 50% 上下文使用量时执行手动 `/compact`
- 对于复杂任务从计划模式开始
- 对多步骤任务使用人工门控任务列表工作流
- 将子任务分解得足够小，以便在 50% 上下文内完成

### 调试提示

- 使用 `/doctor` 进行诊断
- 将长时间运行的终端命令作为后台任务运行以获得更好的日志可见性
- 使用浏览器自动化 MCP（Claude in Chrome、Playwright、Chrome DevTools）让 Claude 检查控制台日志
- 报告视觉问题时提供截图

## Git 提交规则

提交更改时，**为每个文件创建单独的提交**。不要将多个文件更改捆绑到单个提交中。每个文件都有自己的提交，并带有特定于该文件更改的描述性消息。

例如，如果 `README.md`、`best-practice/claude-subagents.md` 和一个技能文件都发生了更改：
- 提交 1：`git add README.md` → 使用 README 特定消息提交
- 提交 2：`git add best-practice/claude-subagents.md` → 使用子智能体文档特定消息提交
- 提交 3：`git add .claude/skills/weather-fetcher/SKILL.md` → 使用技能特定消息提交

这使得 git 历史更整洁，更容易审查、回退或挑选单个更改。

## 文档

查看 `.claude/rules/markdown-docs.md` 了解文档标准。关键文档：
- `best-practice/claude-subagents.md`：子智能体前置元数据、钩子和仓库智能体
- `best-practice/claude-commands.md`：斜杠命令模式和内置命令参考
- `orchestration-workflow/orchestration-workflow.md`：天气系统流程图
