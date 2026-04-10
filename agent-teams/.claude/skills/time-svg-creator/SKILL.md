---
name: time-svg-creator
description: 创建一个显示迪拜当前时间的 SVG 时间卡片。将 SVG 写入 agent-teams/output/dubai-time.svg 并更新 agent-teams/output/output.md。
allowed-tools: Write, Read
---

# 时间 SVG 创建器技能

为迪拜（阿联酋）创建可视化的 SVG 时间卡片并写入输出文件。

## 任务

你将从调用上下文接收三个字段：`time`、`timezone` 和 `formatted`。创建一个 SVG 时间卡片并写入 SVG 和 markdown 摘要。

## 指令

1. **创建 SVG** — 使用 [reference.md](reference.md) 中的 SVG 模板，将占位符替换为实际值
2. **写入 SVG 文件** — 写入到 `agent-teams/output/dubai-time.svg`
3. **写入摘要** — 使用 [reference.md](reference.md) 中的 markdown 模板写入到 `agent-teams/output/output.md`

## 规则

- 使用提供的确切时间值 — 永远不要重新获取或重新计算
- SVG 必须是独立且有效的
- 两个输出文件都放在 `agent-teams/output/` 目录中

## 附加资源

- 有关 SVG 模板、输出模板和设计规范，请参见 [reference.md](reference.md)
- 有关输入/输出示例对，请参见 [examples.md](examples.md)
