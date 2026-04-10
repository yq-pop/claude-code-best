# Commands 实现

![最后更新](https://img.shields.io/badge/Last_Updated-Mar_02%2C_2026-white?style=flat&labelColor=555)

<table width="100%">
<tr>
<td><a href="../">← 返回 Claude Code Best Practice</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

<a href="#weather-orchestrator"><img src="../!/tags/implemented-hd.svg" alt="已实现"></a>

weather orchestrator 命令在本仓库中作为 **Command → Agent → Skill** 架构模式的入口点实现，展示了命令如何编排多步骤工作流。

---

## Weather Orchestrator

**文件**: [`.claude/commands/weather-orchestrator.md`](../.claude/commands/weather-orchestrator.md)

```yaml
---
description: Fetch weather data for Dubai and create an SVG weather card
model: haiku
---

# Weather Orchestrator Command

Fetch the current temperature for Dubai, UAE and create a visual SVG weather card.

## Workflow

### Step 1: Ask User Preference
Use the AskUserQuestion tool to ask the user whether they want the temperature
in Celsius or Fahrenheit.

### Step 2: Fetch Weather Data
Use the Agent tool to invoke the weather agent:
- subagent_type: weather-agent
- prompt: Fetch the current temperature for Dubai, UAE in [unit]...

### Step 3: Create SVG Weather Card
Use the Skill tool to invoke the weather-svg-creator skill:
- skill: weather-svg-creator

...
```

该命令编排整个工作流：询问用户的温度单位偏好，通过 Agent 工具调用 `weather-agent`，然后通过 Skill 工具调用 `weather-svg-creator` skill。

---

## ![如何使用](../!/tags/how-to-use.svg)

```bash
$ claude
> /weather-orchestrator
```

---

## ![如何实现](../!/tags/how-to-implement.svg)

让 Claude 为你创建一个——它会在 `.claude/commands/<name>.md` 中生成带有 YAML frontmatter 和正文的 markdown 文件

---

<a href="https://github.com/shanraisshan/claude-code-best-practice#orchestration-workflow"><img src="../!/tags/orchestration-workflow-hd.svg" alt="编排工作流"></a>

weather orchestrator 是 Command → Agent → Skill 编排模式中的 **Command**。它作为入口点——处理用户交互（温度单位偏好），将数据获取委托给 `weather-agent`，并调用 `weather-svg-creator` skill 生成可视化输出。

<p align="center">
  <img src="../orchestration-workflow/orchestration-workflow.svg" alt="Command Skill Agent 架构流程" width="100%">
</p>

| 组件 | 角色 | 本仓库 |
|-----------|------|-----------|
| **Command** | 入口点，用户交互 | [`/weather-orchestrator`](../.claude/commands/weather-orchestrator.md) |
| **Agent** | 使用预加载的 skill 获取数据（agent skill） | [`weather-agent`](../.claude/agents/weather-agent.md) 带 [`weather-fetcher`](../.claude/skills/weather-fetcher/SKILL.md) |
| **Skill** | 独立创建输出（skill） | [`weather-svg-creator`](../.claude/skills/weather-svg-creator/SKILL.md) |
