# Boris Cherny 使用 Claude Code 的 13 个技巧

Boris Cherny ([@bcherny](https://x.com/bcherny))，Claude Code 的创建者，于 2026 年 1 月 3 日分享的设置技巧摘要。

<table width="100%">
<tr>
<td><a href="../">← 返回 Claude Code 最佳实践</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

## 背景

Boris 分享了他个人的 Claude Code 设置，指出它"出奇地原生" — Claude Code 开箱即用就很棒，所以他不会过多定制。使用它没有唯一正确的方法：团队有意这样构建它，以便你可以以任何方式使用、定制和破解它。Claude Code 团队的每个人使用它的方式都非常不同。

<a href="https://x.com/bcherny/status/2007179832300581177"><img src="./assets/boris-3-jan-26/0.png" alt="Boris Cherny 介绍推文" width="50%" /></a>

---

## 1/ 并行运行 5 个 Claude

在终端中并行运行 5 个 Claude。将标签编号为 1-5，并使用系统通知来知道何时 Claude 需要输入。

参见：[终端设置文档](https://code.claude.com/docs/en/terminal)

<a href="https://x.com/bcherny/status/2007179833990885678"><img src="./assets/boris-3-jan-26/1.png" alt="并行运行 5 个 Claude" width="50%" /></a>

---

## 2/ 使用 claude.ai/code 实现更多并行性

在 claude.ai/code 上并行运行 5-10 个 Claude 与你的本地 Claude。使用 `claude.ai/code` 将本地会话移交给 Web 会话，在 Chrome 中手动启动会话，并来回传送。

<a href="https://x.com/bcherny/status/2007179836704600237"><img src="./assets/boris-3-jan-26/2.png" alt="claude.ai/code 并行性" width="50%" /></a>

---

## 3/ 对所有事情使用带思考的 Opus

对所有事情使用带思考的 Opus 4.5。这是 Boris 使用过的最好的编码模型 — 尽管它比 Sonnet 更大更慢，但由于你需要更少地引导它，并且它在工具使用方面更好，最终它几乎总是比使用更小的模型更快。

<a href="https://x.com/bcherny/status/2007179838864666847"><img src="./assets/boris-3-jan-26/3.png" alt="带思考的 Opus" width="50%" /></a>

---

## 4/ 与团队共享单个 CLAUDE.md

为仓库共享单个 `CLAUDE.md`。将其签入 git，并让整个团队每周贡献多次。每当 Claude 做错事时，将其添加到 `CLAUDE.md` 中，以便 Claude 知道下次不要这样做。

<a href="https://x.com/bcherny/status/2007179840848597422"><img src="./assets/boris-3-jan-26/4.png" alt="共享的 CLAUDE.md" width="50%" /></a>

---

## 5/ 在 PR 上标记 @claude 以更新 CLAUDE.md

在代码审查期间，在同事的 PR 上标记 `@claude`，以将某些内容添加到 `CLAUDE.md` 作为 PR 的一部分。为此使用 Claude Code GitHub action ([install-@hub-action](https://github.com/apps/claude)) — 这是 Boris 版本的复利工程。

<a href="https://x.com/bcherny/status/2007179842928947333"><img src="./assets/boris-3-jan-26/5.png" alt="在 PR 上标记 @claude" width="50%" /></a>

---

## 6/ 在计划模式下开始大多数会话

在计划模式下开始大多数会话（shift+tab 两次）。如果目标是编写 Pull Request，使用计划模式并与 Claude 来回交流，直到你喜欢它的计划。从那里，切换到自动接受编辑模式，Claude 通常可以一次完成。一个好的计划真的很重要。

<a href="https://x.com/bcherny/status/2007179845336527000"><img src="./assets/boris-3-jan-26/6.png" alt="计划模式" width="50%" /></a>

---

## 7/ 为内循环工作流使用斜杠命令

对每天多次执行的每个"内循环"工作流使用斜杠命令。这可以避免重复提示，并使 Claude 也可以使用这些工作流。命令被签入 git 并存放在 `.claude/commands/` 中。

示例：`/commit-push-pr` — 提交、推送并打开 PR。

<a href="https://x.com/bcherny/status/2007179847949500714"><img src="./assets/boris-3-jan-26/7.png" alt="斜杠命令" width="50%" /></a>

---

## 8/ 使用子智能体自动化常见工作流

经常使用一些子智能体：`code-simplifier` 在 Claude 完成工作后简化代码，`verify-app` 有详细的端到端测试 Claude Code 的说明，等等。将子智能体视为自动化最常见的工作流 — 类似于斜杠命令。

子智能体存放在 `.claude/agents/` 中。

<a href="https://x.com/bcherny/status/2007179850139000872"><img src="./assets/boris-3-jan-26/8.png" alt="子智能体" width="50%" /></a>

---

## 9/ 使用 PostToolUse 钩子自动格式化代码

使用 `PostToolUse` 钩子格式化 Claude 的代码。Claude 通常开箱即用地生成格式良好的代码，钩子处理最后 10%，以避免以后在 CI 中出现格式错误。

```json
"PostToolUse": [
  {
    "matcher": "Write|Edit",
    "hooks": [
      {
        "type": "command",
        "command": "bun run format || true"
      }
    ]
  }
]
```

<a href="https://x.com/bcherny/status/2007179852047335529"><img src="./assets/boris-3-jan-26/9.png" alt="用于格式化的 PostToolUse 钩子" width="50%" /></a>

---

## 10/ 预先允许权限而不是 --dangerously-skip-permissions

不要使用 `--dangerously-skip-permissions`。相反，使用 `/permissions` 预先允许你知道在环境中安全的常见 bash 命令，以避免不必要的权限提示。其中大多数被签入 `.claude/settings.json` 并与团队共享。

<a href="https://x.com/bcherny/status/2007179854077407667"><img src="./assets/boris-3-jan-26/10.png" alt="预先允许权限" width="50%" /></a>

---

## 11/ 通过 MCP 让 Claude 使用所有工具

Claude Code 使用所有工具。它经常搜索并发布到 Slack（通过 MCP 服务器），运行 BigQuery 查询以回答分析问题（使用 `bq` CLI），从 Sentry 获取错误日志等。Slack MCP 配置被签入 `.mcp.json` 并与团队共享。

<a href="https://x.com/bcherny/status/2007179856266789204"><img src="./assets/boris-3-jan-26/11.png" alt="MCP 工具" width="50%" /></a>

---

## 12/ 使用后台智能体验证长时间运行的任务

对于非常长时间运行的任务，要么 (a) 提示 Claude 在完成后使用后台智能体验证其工作，(b) 使用智能体 Stop 钩子更确定性地执行此操作，或 (c) 使用 ralph-wiggum 插件（最初由 @GeoffreyHuntley 构思）。

<a href="https://x.com/bcherny/status/2007179858435281082"><img src="./assets/boris-3-jan-26/12.png" alt="长时间运行的任务验证" width="50%" /></a>

---

## 13/ 给 Claude 一种验证其工作的方法

这可能是从 Claude Code 中获得出色结果的最重要的事情 — 给 Claude 一种验证其工作的方法。如果 Claude 有那个反馈循环，它将使最终结果的质量提高 2-3 倍。

Claude 测试 Boris 提交的每一个更改。

<a href="https://x.com/bcherny/status/2007179861115511237"><img src="./assets/boris-3-jan-26/13.png" alt="给 Claude 一种验证方法" width="50%" /></a>

---

## 来源

- [Boris Cherny (@bcherny) 在 X 上 — 2026 年 1 月 3 日](https://x.com/bcherny/status/2007179832300581177)
