---
model: haiku
---

# 时间编排器命令

获取迪拜的当前时间（Asia/Dubai，UTC+4）并创建可视化的 SVG 时间卡片。

## 工作流

### 步骤 1：获取当前迪拜时间

使用 Agent 工具调用时间智能体：
- subagent_type: time-agent
- description: 获取当前迪拜时间
- prompt: 获取迪拜的当前时间（Asia/Dubai，UTC+4）。准确返回三个字段：`time`（时间部分，例如 "14:30:45"）、`timezone`（"GST (UTC+4)"）和 `formatted`（完整格式化字符串，例如 "2026-03-12 14:30:45 +04"）。智能体有一个预加载的技能（time-fetcher）提供详细的指令。
- model: haiku

等待智能体完成并捕获返回的时间数据。

### 数据契约

time-agent 必须返回这三个字段：
- **time**：时间部分（例如，"14:30:45"）
- **timezone**："GST (UTC+4)"
- **formatted**：完整格式化字符串（例如，"2026-03-12 14:30:45 +04"）

### 步骤 2：创建 SVG 时间卡片

使用 Skill 工具调用 time-svg-creator 技能：
- skill: time-svg-creator
- args: 传递步骤 1 的时间数据 — 包含 `time`、`timezone` 和 `formatted` 值

该技能将使用步骤 1 的时间数据（在当前上下文中可用）来创建 SVG 卡片并写入输出文件。

## 关键要求

1. **为 time-agent 使用 Agent 工具**：不要使用 bash 命令调用智能体。必须使用 Agent 工具并设置 `subagent_type: "time-agent"`。
2. **为 SVG 创建器使用 Skill 工具**：通过 Skill 工具和 `skill: "time-svg-creator"` 调用 SVG 创建器，而不是 Agent 工具。
3. **顺序流程**：智能体必须完成并返回时间数据后才能调用技能。不要并行运行它们。
4. **数据传递**：确保在调用技能时，智能体响应中的所有三个字段（time、timezone、formatted）在上下文中可用。

## 输出摘要

在两个步骤完成后，向用户提供清晰的摘要，显示：
- 获取的当前迪拜时间
- 时区：GST (UTC+4)
- 完整格式化时间戳
- 在 `agent-teams/output/dubai-time.svg` 创建的 SVG 卡片
- 写入 `agent-teams/output/output.md` 的摘要
