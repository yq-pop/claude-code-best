# Claude Code: 使用量、速率限制与额外使用量

了解 Claude Code 中使用限制的工作原理以及达到限制时如何继续工作。

<table width="100%">
<tr>
<td><a href="../">← Back to Claude Code Best Practice</a></td>
<td align="right"><img src="/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

## 概述

订阅计划(Pro、Max 5x、Max 20x)上的 Claude Code 有在滚动窗口上重置的使用限制。三个内置的斜杠命令帮助你监控和管理使用量:

| 命令 | 描述 | 可用于 |
|---------|-------------|--------------|
| `/usage` | 检查计划限制和速率限制状态 | Pro、Max 5x、Max 20x |
| `/extra-usage` | 配置达到限制时的按需付费溢出 | Pro、Max 5x、Max 20x |
| `/cost` | 显示当前会话的令牌使用和支出 | API密钥用户 |

---

## `/usage` — 检查你的限制

显示当前计划的使用限制和速率限制状态。用于检查在达到限制之前剩余多少容量。

---

## `/extra-usage` — 超出限制后继续工作

`/extra-usage` 命令配置**按需付费溢出计费**,这样当你达到计划的速率限制时,Claude Code 可以无缝继续工作,而不是阻止你。

### 工作原理

1. 你达到计划的速率限制(限制每5小时重置一次)
2. 如果启用了额外使用量且有可用资金,Claude Code 继续工作而不中断
3. 溢出令牌按**标准 API 费率**计费,与订阅费用分开

### 设置

CLI 中的 `/extra-usage` 命令将指导你完成配置。你也可以在 claude.ai 的 **Settings > Usage** 上在网页上配置它:

1. 启用额外使用量
2. 添加付款方式
3. 设置**每月支出上限**(或选择无限制)
4. 可选地添加**预付资金**,当余额低于阈值时自动充值

### 关键详情

| 详情 | 值 |
|--------|-------|
| 每日兑换限制 | $2,000/天 |
| 计费 | 与订阅分开,按标准 API 费率 |
| 限制重置窗口 | 每5小时 |

### 已知问题

截至2026年2月,`/extra-usage` CLI 命令[未记录](https://github.com/anthropics/claude-code/issues/12396),可能会打开登录窗口而没有明确的配置选项。目前通过 **claude.ai 网页界面**配置是更可靠的途径。

---

## `/cost` — 会话支出(API用户)

对于使用 API 密钥(而非订阅计划)进行身份验证的用户,`/cost` 显示:

- 当前会话的总成本
- API 持续时间和挂钟时间
- 令牌使用细分
- 所做的代码更改

此命令与 Pro/Max 订阅用户无关。

---

## 快速模式和额外使用量

快速模式(`/fast`)使用 Claude Opus 4.6 以获得更快的输出。它与额外使用量有特殊的计费关系:

- 快速模式使用量从第一个令牌开始**总是计入额外使用量**
- 即使你的订阅计划有剩余使用量,这也适用
- 快速模式不消耗你计划中包含的速率限制

这意味着你需要启用并资助额外使用量才能使用 `/fast`。

---

## CLI 启动标志

两个启动标志与使用预算相关(仅 API 密钥用户,打印模式):

| 标志 | 描述 |
|------|-------------|
| `--max-budget-usd <AMOUNT>` | 停止前 API 调用的最大美元金额 |
| `--max-turns <NUMBER>` | 限制代理轮次数 |

完整列表见 [CLI Startup Flags Reference](claude-cli-startup-flags.md)。

---

## 资料来源

- [Extra usage for paid Claude plans — Claude Help Center](https://support.claude.com/en/articles/12429409-extra-usage-for-paid-claude-plans)
- [Using Claude Code with your Pro or Max plan — Claude Help Center](https://support.claude.com/en/articles/11145838-using-claude-code-with-your-pro-or-max-plan)
- [/extra-usage slash command is undocumented — GitHub Issue #12396](https://github.com/anthropics/claude-code/issues/12396)
- [Claude Code CLI Reference](https://code.claude.com/docs/en/cli-reference)
