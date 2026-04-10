# 使用 Claude Code 的 10 个技巧 — 来自 Claude Code 团队

Boris Cherny ([@bcherny](https://x.com/bcherny))，Claude Code 的创建者，于 2026 年 2 月 1 日分享的团队技巧总结。

<table width="100%">
<tr>
<td><a href="../">← Back to Claude Code Best Practice</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

## 背景

Boris 分享了直接来自 Claude Code 团队的使用技巧。团队使用 Claude 的方式与 Boris 个人使用方式不同。请记住：使用 Claude Code 没有唯一正确的方式 — 每个人的设置都不同。你应该进行实验，看看什么适合你！

<a href="https://x.com/bcherny/status/2017742741636321619"><img src="assets/boris-1-feb-26/0.png" alt="Boris Cherny intro tweet" width="50%" /></a>

---

## 1/ 并行处理更多任务

同时启动 3-5 个 git worktrees，每个都运行自己的 Claude 会话。这是最大的生产力提升，也是团队的首要技巧。Boris 个人使用多个 git checkouts，但 Claude Code 团队大多数人更喜欢 worktrees — 这就是 `@amorisscode` 在 Claude Desktop 应用中为它们构建原生支持的原因！

有些人还会为他们的 worktrees 命名并设置 shell 别名（`2a`、`2b`、`2c`），这样他们可以通过一次按键在它们之间切换。其他人有一个专门的"分析" worktree，仅用于读取日志和运行 BigQuery。

参见：[Worktrees 文档](https://code.claude.com/docs/en/common...)

<a href="https://x.com/bcherny/status/2017742743125299476"><img src="assets/boris-1-feb-26/1.png" alt="Do more in parallel" width="50%" /></a>

---

## 2/ 在计划模式下开始每个复杂任务

将你的精力投入到计划中，这样 Claude 就可以一次完成实现。

有人让一个 Claude 编写计划，然后启动第二个 Claude 作为高级工程师来审查它。

另一个人说，一旦出现问题，他们就会切换回计划模式并重新规划。不要继续推进。他们还明确告诉 Claude 进入计划模式进行验证步骤，而不仅仅是构建。

<a href="https://x.com/bcherny/status/2017742745365057733"><img src="assets/boris-1-feb-26/2.png" alt="Start every complex task in plan mode" width="50%" /></a>

---

## 3/ 投资你的 CLAUDE.md

每次纠正后，以此结束："更新你的 CLAUDE.md，这样你就不会再犯同样的错误。" Claude 在为自己编写规则方面出奇地擅长。

随着时间的推移，无情地编辑你的 `CLAUDE.md`。持续迭代，直到 Claude 的错误率明显下降。

一位工程师告诉 Claude 为每个任务/项目维护一个笔记目录，在每个 PR 后更新。然后他们将 `CLAUDE.md` 指向它。

<a href="https://x.com/bcherny/status/2017742747067945390"><img src="assets/boris-1-feb-26/3.png" alt="Invest in your CLAUDE.md" width="50%" /></a>

---

## 4/ 创建你自己的技能并提交到 Git

在每个项目中重复使用。来自团队的技巧：

- 如果你每天做某事超过一次，就把它变成一个技能或命令
- 构建一个 `/techdebt` 斜杠命令，在每个会话结束时运行它以查找和删除重复代码
- 设置一个斜杠命令，将 7 天的 Slack、GDrive、Asana 和 GitHub 同步到一个上下文转储中
- 构建分析工程师风格的代理，编写 dbt 模型、审查代码并在开发中测试更改

参见：[使用技能扩展 Claude — Claude Code 文档](https://code.claude.com/docs/en/skills)

<a href="https://x.com/bcherny/status/2017742748984742078"><img src="assets/boris-1-feb-26/4.png" alt="Create your own skills" width="50%" /></a>

---

## 5/ Claude Fixes Most Bugs by Itself

Here's how the team does it:

Enable the Slack MCP, then paste a Slack bug thread into Claude and just say "fix." Zero context switching required.

Or, just say "Go fix the failing CI tests." Don't micromanage how.

Point Claude at docker logs to troubleshoot distributed systems — it's surprisingly capable at this.

<a href="https://x.com/bcherny/status/2017742750473720121"><img src="assets/boris-1-feb-26/5.png" alt="Claude fixes most bugs by itself" width="50%" /></a>

---

## 6/ Level Up Your Prompting

a. **Challenge Claude.** Say "Grill me on these changes and don't make a PR until I pass your test." Make Claude be your reviewer. Or, say "Prove to me this works" and have Claude diff behavior between main and your feature branch.

b. **After a mediocre fix,** say: "Knowing everything you know now, scrap this and implement the elegant solution."

c. **Write detailed specs** and reduce ambiguity before handing work off. The more specific you are, the better the output.

<a href="https://x.com/bcherny/status/2017742752566632544"><img src="assets/boris-1-feb-26/6.png" alt="Level up your prompting" width="50%" /></a>

---

## 7/ Terminal & Environment Setup

The team loves Ghostty! Multiple people like its synchronized rendering, 24-bit color, and proper unicode support.

For easier Claude-juggling, use `/statusline` to customize your status bar to always show context usage and current git branch. Many also color-code and name their terminal tabs, sometimes using tmux — one tab per task/worktree.

Use voice dictation. You speak 3x faster than you type, and your prompts get way more detailed as a result. (hit fn x2 on macOS)

See: [Terminal Setup Docs](https://code.claude.com/docs/en/termin...)

<a href="https://x.com/bcherny/status/2017742753971769626"><img src="assets/boris-1-feb-26/7.png" alt="Terminal and environment setup" width="50%" /></a>

---

## 8/ Use Subagents

a. Append "use subagents" to any request where you want Claude to throw more compute at the problem.

b. Offload individual tasks to subagents to keep your main agent's context window clean and focused.

c. Route permission requests to Opus 4.5 via a hook — let it scan for attacks and auto-approve the safe ones. See: [Hooks Docs](https://code.claude.com/docs/en/hooks#...)

<a href="https://x.com/bcherny/status/2017742755737555434"><img src="assets/boris-1-feb-26/8.png" alt="Use subagents" width="50%" /></a>

---

## 9/ Use Claude for Data & Analytics

Ask Claude Code to use the "bq" CLI to pull and analyze metrics on the fly. The team has a BigQuery skill checked into the codebase, and everyone uses it for analytics queries directly in Claude Code. Personally, Boris hasn't written a line of SQL in 6+ months.

This works for any database that has a CLI, MCP, or API.

<a href="https://x.com/bcherny/status/2017742757666902374"><img src="assets/boris-1-feb-26/9.png" alt="Use Claude for data and analytics" width="50%" /></a>

---

## 10/ Learning with Claude

A few tips from the team to use Claude Code for learning:

a. Enable the "Explanatory" or "Learning" output style in `/config` to have Claude explain the "why" behind its changes.

b. Have Claude generate a visual HTML presentation explaining unfamiliar code. It makes surprisingly good slides!

c. Ask Claude to draw ASCII diagrams of new protocols and codebases to help you understand them.

d. Build a spaced-repetition learning skill: you explain your understanding, Claude asks follow-ups to fill gaps, stores the result.

<a href="https://x.com/bcherny/status/2017742759218794768"><img src="assets/boris-1-feb-26/10.png" alt="Learning with Claude" width="50%" /></a>

---

## Sources

- [Boris Cherny (@bcherny) on X — February 1, 2026](https://x.com/bcherny/status/2017742741636321619)
