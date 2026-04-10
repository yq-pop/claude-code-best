# Claude Code 中 15 个隐藏且未充分利用的功能 — 来自 Boris Cherny

Boris Cherny ([@bcherny](https://x.com/bcherny))，Claude Code 的创造者，于 2026 年 3 月 30 日分享的技巧摘要。

<table width="100%">
<tr>
<td><a href="../">← 返回 Claude Code 最佳实践</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

## 背景

Boris 分享了他最喜欢的一些 Claude Code 中隐藏且未充分利用的功能，重点介绍了他最常使用的功能。

<a href="https://x.com/bcherny/status/2038454336355999749"><img src="assets/boris-30-mar-26/0.png" alt="Boris Cherny intro tweet" width="50%" /></a>

---

## 1/ Claude Code 有移动应用

你知道 Claude Code 有移动应用吗？Boris 在 iOS 应用上编写了大量代码 — 这是一种无需打开笔记本电脑即可进行更改的便捷方式。

- 下载适用于 iOS/Android 的 Claude 应用
- 导航到左侧的 **Code** 选项卡
- 你可以直接从手机审查更改、批准 PR 和编写代码

<a href="https://x.com/bcherny/status/2038454337811386436"><img src="assets/boris-30-mar-26/1.png" alt="Claude Code mobile app" width="50%" /></a>

---

## 2/ 在移动端/网页端/桌面端和终端之间移动会话

运行 `claude --teleport` 或 `/teleport` 以在你的机器上继续云端会话。或者运行 `/remote-control` 从手机/网页端控制本地运行的会话。

- **Teleport**：将云端会话拉取到本地终端
- **Remote Control**：允许你从任何设备控制本地会话
- Boris 在他的 `/config` 中设置了 **"为所有会话启用远程控制"**

<a href="https://x.com/bcherny/status/2038454339933548804"><img src="assets/boris-30-mar-26/2.png" alt="Teleport and Remote Control" width="50%" /></a>

---

## 3/ /loop 和 /schedule — 两个最强大的功能

使用这些功能让 Claude 按设定的间隔自动运行，一次最多可运行一周。Boris 在本地运行了很多循环：

- `/loop 5m /babysit` — 自动处理代码审查、自动变基，并将 PR 推向生产环境
- `/loop 30m /slack-feedback` — 每 30 分钟自动创建 PR 以获取 Slack 反馈
- `/loop /post-merge-sweeper` — 创建 PR 来处理他遗漏的代码审查评论
- `/loop 1h /pr-pruner` — 关闭过时且不再需要的 PR
- ...还有更多！

尝试将工作流转化为技能 + 循环。这非常强大。

<a href="https://x.com/bcherny/status/2038454341884154269"><img src="assets/boris-30-mar-26/3.png" alt="/loop and /schedule" width="50%" /></a>

---

## 4/ 使用钩子确定性地运行逻辑

使用钩子作为智能体生命周期的一部分来运行逻辑。例如：

- 每次启动 Claude 时**动态加载**上下文 (`SessionStart`)
- **记录每个 bash 命令**模型运行 (`PreToolUse`)
- **将权限提示路由**到 WhatsApp 供你批准/拒绝 (`PermissionRequest`)
- 每当 Claude 停止时**戳一下它**让它继续 (`Stop`)

<a href="https://x.com/bcherny/status/2038454343519932844"><img src="assets/boris-30-mar-26/4.png" alt="Use hooks" width="50%" /></a>

---

## 5/ Cowork Dispatch

Boris 每天使用 Dispatch 来处理 Slack 和电子邮件、管理文件，以及在不在电脑前时在笔记本电脑上做事情。当他不编码时，他就在调度。

- Dispatch 是 Claude Desktop 应用的**安全远程控制**
- 在你的许可下，它可以使用你的 MCP、浏览器和计算机
- 把它看作是从任何地方将非编码任务委托给 Claude 的一种方式

<a href="https://x.com/bcherny/status/2038454345419936040"><img src="assets/boris-30-mar-26/5.png" alt="Cowork Dispatch" width="50%" /></a>

---

## 6/ 为前端工作使用 Chrome 扩展

使用 Claude Code 的最重要提示：**给 Claude 一种验证其输出的方法。** 一旦你这样做，Claude 就会迭代直到结果很好。

- 想象一下让某人构建一个网站但不允许他们使用浏览器 — 结果可能看起来不太好
- 给 Claude 一个浏览器，它就会编写代码并迭代直到看起来不错
- Boris 每次处理 Web 代码时都使用 Chrome 扩展 — 它往往比其他类似的 MCP 更可靠

<a href="https://x.com/bcherny/status/2038454347156398333"><img src="assets/boris-30-mar-26/6.png" alt="Chrome extension for frontend" width="50%" /></a>

---

## 7/ 使用 Claude Desktop 应用自动启动和测试 Web 服务器

沿着同样的思路，Desktop 应用捆绑了让 Claude **自动运行你的 Web 服务器甚至在内置浏览器中测试它**的能力。

- 你可以使用 Chrome 扩展在 CLI 或 VSCode 中设置类似的东西
- 或者直接使用 Desktop 应用获得集成体验

<a href="https://x.com/bcherny/status/2038454348804714642"><img src="assets/boris-30-mar-26/7.png" alt="Desktop app web server testing" width="50%" /></a>

---

## 8/ 分叉你的会话

人们经常问如何分叉现有会话。两种方法：

1. 从你的会话中运行 `/branch`
2. 从 CLI 运行 `claude --resume <session-id> --fork-session`

`/branch` 创建一个分支对话 — 你现在在分支中。要恢复原始对话，使用 `claude -r <original-session-id>`。

<a href="https://x.com/bcherny/status/2038454350214041740"><img src="assets/boris-30-mar-26/8.png" alt="Fork your session" width="50%" /></a>

---

## 9/ 使用 /btw 进行旁路查询

Boris 一直使用它来在智能体工作时回答快速问题。`/btw` 让你可以在不中断智能体当前任务的情况下询问旁路问题。

示例：
```
/btw how do I spell dachshund?
> dachshund — 德语"獾狗"（dachs + 獾，hund + 狗）。
↑/↓ 滚动 · 空格、回车或 Escape 关闭
```

<a href="https://x.com/bcherny/status/2038454351849787485"><img src="assets/boris-30-mar-26/9.png" alt="/btw for side queries" width="50%" /></a>

---

## 10/ 使用 Git 工作树

Claude Code 对 git 工作树提供了深度支持。工作树对于在同一个仓库中进行大量并行工作至关重要。Boris **一直在运行数十个 Claude**，这就是他的做法。

- 使用 `claude -w` 在工作树中启动新会话
- 或者在 Claude Desktop 应用中勾选 **"worktree" 复选框**
- 对于非 git VCS 用户，使用 `WorktreeCreate` 钩子添加你自己的工作树创建逻辑

<a href="https://x.com/bcherny/status/2038454353787519164"><img src="assets/boris-30-mar-26/10.png" alt="Git worktrees" width="50%" /></a>

---

## 11/ 使用 /batch 扇出大量变更集

`/batch` 会对你进行访谈，然后让 Claude 将工作扇出到所需数量的**工作树智能体**（数十个、数百个，甚至数千个）来完成它。

- 将其用于大规模代码迁移和其他类型的可并行化工作
- 每个工作树智能体独立在其自己的代码库副本上工作

<a href="https://x.com/bcherny/status/2038454355469484142"><img src="assets/boris-30-mar-26/11.png" alt="/batch for massive changesets" width="50%" /></a>

---

## 12/ 使用 --bare 将 SDK 启动速度提高多达 10 倍

默认情况下，当你运行 `claude -p`（或 TypeScript 或 Python SDK）时，Claude 会搜索本地 CLAUDE.md、设置和 MCP。但对于非交互式使用，大多数时候你想通过 `--system-prompt`、`--mcp-config`、`--settings` 等明确指定要加载的内容。

- 这是 SDK 首次构建时的设计疏忽
- 在未来的版本中，他们将把默认值翻转为 `--bare`
- 现在，通过标志选择加入以获得高达 **10 倍的启动速度**

```bash
claude -p "summarize this codebase" \
    --output-format=stream-json \
    --verbose \
    --bare
```

<a href="https://x.com/bcherny/status/2038454357088457168"><img src="assets/boris-30-mar-26/12.png" alt="--bare flag for SDK startup" width="50%" /></a>

---

## 13/ 使用 --add-dir 让 Claude 访问更多文件夹

在跨多个仓库工作时，Boris 通常在一个仓库中启动 Claude，并使用 `--add-dir`（或 `/add-dir`）让 Claude 看到其他仓库。

- 这不仅告诉 Claude 关于仓库的信息，还**给予它权限**在仓库中工作
- 或者，将 `"additionalDirectories"` 添加到你团队的 `settings.json` 中，以在启动 Claude Code 时始终加载额外的文件夹

<a href="https://x.com/bcherny/status/2038454359047156203"><img src="assets/boris-30-mar-26/13.png" alt="--add-dir for multiple repos" width="50%" /></a>

---

## 14/ 使用 --agent 给 Claude Code 一个自定义系统提示和工具

自定义智能体是一个经常被忽视的强大原语。要使用它，只需在 `.claude/agents/` 中定义一个新智能体，然后运行：

```bash
claude --agent=<你的智能体名称>
```

- 智能体可以有受限的工具、自定义描述和特定模型
- 它们非常适合创建只读智能体、专门的审查智能体或特定领域的工具

<a href="https://x.com/bcherny/status/2038454360418787764"><img src="assets/boris-30-mar-26/14.png" alt="--agent for custom system prompts" width="50%" /></a>

---

## 15/ 使用 /voice 启用语音输入

有趣的事实：Boris 大部分编码是通过对 Claude 说话而不是打字来完成的。

- 在 CLI 中运行 `/voice`，然后按住空格键说话
- 在 Desktop 上按语音按钮
- 或在 iOS 设置中启用听写

<a href="https://x.com/bcherny/status/2038454362226467112"><img src="assets/boris-30-mar-26/15.png" alt="/voice for voice input" width="50%" /></a>

---

## 来源

- [Boris Cherny (@bcherny) 在 X 上 — 2026 年 3 月 30 日](https://x.com/bcherny/status/2038454336355999749)
