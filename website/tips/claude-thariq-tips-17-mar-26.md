# 构建 Claude Code 的经验教训：我们如何使用技能 — Thariq

Thariq ([@trq212](https://x.com/trq212)) 于 2026 年 3 月 17 日分享的关于 Anthropic 内部如何使用技能的综合指南。

<table width="100%">
<tr>
<td><a href="../">← 返回 Claude Code 最佳实践</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

## 背景

技能已成为 Claude Code 中最常用的扩展点之一。它们灵活、易于创建且易于分发。但这种灵活性也使得很难知道什么最有效。Thariq 分享了在 Anthropic 广泛使用技能的经验教训，目前有数百个技能在积极使用中。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/1.png" alt="Thariq 介绍推文" width="50%" /></a>

---

## 什么是技能？

一个常见的误解是技能"只是 markdown 文件"，但最有趣的部分是它们是**文件夹**，可以包含脚本、资产、数据等 — 智能体可以发现、探索和操作的东西。技能还有各种各样的配置选项，包括注册动态钩子。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/2.png" alt="什么是技能？" width="50%" /></a>

---

## 技能类型

在对所有技能进行分类后，团队注意到它们聚集为 9 个重复出现的类别。最好的技能完全适合其中一个类别；更令人困惑的技能则横跨几个类别。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/3.png" alt="技能类型网格" width="50%" /></a>

---

### 1/ 库与 API 参考

解释如何正确使用库、CLI 或 SDK 的技能。这些可以是内部库或 Claude Code 有时会遇到问题的常见库。它们通常包含一个参考代码片段文件夹和编写脚本时要避免的陷阱列表。

**示例：** billing-lib、internal-platform-cli、frontend-design

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/4.png" alt="库与 API 参考" width="50%" /></a>

---

### 2/ 产品验证

描述如何测试或验证代码是否正常工作的技能。这些通常与 Playwright、tmux 等外部工具配对使用。验证技能对于确保 Claude 的输出正确非常有用。让工程师花一周时间只是为了让你的验证技能变得出色是值得的。

**示例：** signup-flow-driver、checkout-verifier、tmux-cli-driver

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/5.png" alt="产品验证" width="50%" /></a>

---

### 3/ 数据获取与分析

连接到数据和监控堆栈的技能。这些可能包括使用凭据获取数据的库、特定的仪表板 ID 等，以及有关常见工作流程或获取数据方式的说明。

**示例：** funnel-query、cohort-compare、grafana

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/6.png" alt="数据获取与分析" width="50%" /></a>

---

### 4/ 业务流程与团队自动化

将重复工作流程自动化为一个命令的技能。这些通常是相当简单的说明，但可能对其他技能或 MCP 有更复杂的依赖关系。将以前的结果保存在日志文件中可以帮助模型保持一致性并反思工作流程的以前执行情况。

**示例：** standup-post、create-\<ticket-system\>-ticket、weekly-recap

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/7.png" alt="业务流程与团队自动化" width="50%" /></a>

---

### 5/ 代码脚手架与模板

为代码库中的特定函数生成框架样板的技能。你可以将这些技能与可组合的脚本结合使用。当你的脚手架具有无法完全通过代码覆盖的自然语言需求时，它们特别有用。

**示例：** new-\<framework\>-workflow、new-migration、create-app

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/8.png" alt="代码脚手架与模板" width="50%" /></a>

---

### 6/ 代码质量与审查

在你的组织内强制执行代码质量并帮助审查代码的技能。这些可以包括确定性脚本或工具以实现最大的稳健性。你可能希望将这些技能作为钩子的一部分或在 GitHub Action 中自动运行。

**示例：** adversarial-review、code-style、testing-practices

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/10.png" alt="代码质量与审查" width="50%" /></a>

---

### 7/ CI/CD 与部署

帮助你在代码库中获取、推送和部署代码的技能。这些技能可能引用其他技能来收集数据。

**示例：** babysit-pr、deploy-\<service\>、cherry-pick-prod

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/11.png" alt="CI/CD 与部署" width="50%" /></a>

---

### 8/ 运行手册

接受症状（如 Slack 线程、警报或错误签名）、进行多工具调查并生成结构化报告的技能。

**示例：** \<service\>-debugging、oncall-runner、log-correlator

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/12.png" alt="运行手册" width="50%" /></a>

---

### 9/ 基础设施运维

执行日常维护和操作程序的技能 — 其中一些涉及受益于护栏的破坏性操作。这些使工程师更容易在关键操作中遵循最佳实践。

**示例：** \<resource\>-orphans、dependency-management、cost-investigation

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/13.png" alt="基础设施运维" width="50%" /></a>

---

## 编写技能的技巧

编写有效技能的 9 个最佳实践，以及分发和度量的指导。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/14.png" alt="编写技能的技巧网格" width="50%" /></a>

---

### 技巧 1：不要陈述显而易见的事情

Claude Code 对你的代码库了解很多，Claude 对编码也了解很多，包括许多默认观点。如果你发布的技能主要是关于知识的，请尝试专注于推动 Claude 跳出其正常思维方式的信息。前端设计技能就是一个很好的例子 — 它是通过与客户迭代改进 Claude 的设计品味而构建的，避免了 Inter 字体和紫色渐变等经典模式。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/15.png" alt="不要陈述显而易见的事情" width="50%" /></a>

---

### 技巧 2：构建陷阱部分

任何技能中信号最高的内容是陷阱部分。这些部分应该从 Claude 在使用你的技能时遇到的常见失败点中构建起来。理想情况下，你会随着时间的推移更新你的技能以捕获这些陷阱。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/16.png" alt="构建陷阱部分" width="50%" /></a>

---

### 技巧 3：使用文件系统和渐进披露

技能是一个文件夹，而不仅仅是一个 markdown 文件。你应该将整个文件系统视为一种上下文工程和渐进披露的形式。告诉 Claude 你的技能中有哪些文件，它会在适当的时候阅读它们。最简单的形式是指向其他 markdown 文件 — 例如，将详细的函数签名和使用示例拆分到 `references/api.md` 中。你可以有参考、脚本、示例等文件夹。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/17.png" alt="渐进披露" width="50%" /></a>

---

### 技巧 4：避免对 Claude 过度限制

Claude 通常会尝试遵守你的说明，由于技能可重用性很高，你需要小心不要过于具体。给 Claude 所需的信息，但给它适应情况的灵活性。不要给出规定性的分步说明，而是给出目标和约束。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/18.png" alt="避免对 Claude 过度限制" width="50%" /></a>

---

### 技巧 5：仔细考虑设置

某些技能可能需要使用用户的上下文进行设置。一个好的模式是将此设置信息存储在技能目录中的 `config.json` 文件中。如果配置未设置，智能体可以向用户询问信息。你可以指示 Claude 使用 AskUserQuestion 工具进行结构化的多选题。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/19.png" alt="仔细考虑设置" width="50%" /></a>

---

### 技巧 6：描述字段是为模型准备的

当 Claude Code 启动会话时，它会构建一个包含每个可用技能及其描述的列表。这个列表是 Claude 扫描以决定"这个请求有技能吗？"的内容。这意味着描述字段不是摘要 — 它是**何时触发**此技能的描述。为模型编写它。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/20.png" alt="描述 = 触发器" width="50%" /></a>

---

### 技巧 7：内存与数据存储

某些技能可以通过在其中存储数据来包含一种内存形式。你可以将数据存储在像仅追加文本日志文件或 JSON 文件这样简单的东西中，或者像 SQLite 数据库这样复杂的东西中。存储在技能目录中的数据可能会在升级技能时被删除，因此请使用 `${CLAUDE_PLUGIN_DATA}` 作为每个插件存储数据的稳定文件夹。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/21.png" alt="内存与数据存储" width="50%" /></a>

---

### 技巧 8：存储脚本并生成代码

你可以给 Claude 的最强大的工具之一是代码。给 Claude 脚本和库让 Claude 将其回合花在组合上，决定下一步做什么，而不是重建样板。然后，Claude 可以即时生成脚本来组合此功能以进行更高级的分析。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/22.png" alt="存储脚本并生成代码" width="50%" /></a>

---

### 技巧 9：按需钩子

技能可以包含仅在调用技能时激活并持续会话期间的钩子。将此用于你不想一直运行但有时非常有用的更有主见的钩子。

**示例：**
- `/careful` — 通过 Bash 上的 PreToolUse 匹配器阻止 rm -rf、DROP TABLE、force-push、kubectl delete
- `/freeze` — 阻止不在特定目录中的任何 Edit/Write

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/23.png" alt="按需钩子" width="50%" /></a>

---

## 分发技能

与你的团队共享技能的两种方式：
- **检入你的仓库**（在 `.claude/skills` 下）— 最适合在相对较少的仓库中工作的小型团队
- **制作插件**并拥有一个 Claude Code 插件市场，用户可以在其中上传和安装插件

每个检入的技能也会为模型的上下文增加一点内容。随着你的规模扩大，内部插件市场允许你分发技能并让你的团队决定安装哪些技能。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/24.png" alt="分发技能" width="50%" /></a>

---

## 管理市场

没有一个集中的团队来决定哪些技能进入市场。相反，尝试有机地找到最有用的技能。上传到 GitHub 中的沙盒文件夹，并在 Slack 或其他论坛中向人们指出它。一旦技能获得了关注（由技能所有者决定），他们可以提交 PR 将其移至市场。发布前的策展对于避免冗余技能很重要。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/25.png" alt="管理市场" width="50%" /></a>

---

## 组合技能

你可能希望拥有相互依赖的技能。例如，一个上传文件的文件上传技能，以及一个生成 CSV 并上传它的 CSV 生成技能。这种依赖关系管理尚未原生内置到市场或技能中，但你可以按名称引用其他技能，如果它们已安装，模型将调用它们。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/26.png" alt="组合技能" width="50%" /></a>

---

## 衡量技能

要了解技能的表现，请使用 PreToolUse 钩子，该钩子允许你在公司内记录技能使用情况。这意味着你可以找到流行的技能或与预期相比触发不足的技能。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/27.png" alt="衡量技能" width="50%" /></a>

---

## 结论

技能是智能体非常强大、灵活的工具，但现在还处于早期阶段，我们都在摸索如何最好地使用它们。将此视为我们看到有效的有用技巧的大杂烩，而不是权威指南。理解技能的最佳方式是开始、实验并查看对你有效的方法。我们的大多数技能最初只是几行和一个陷阱，并且因为人们在 Claude 遇到新的边缘情况时不断添加到它们而变得更好。

<a href="https://x.com/trq212/status/2033949937936085378"><img src="./assets/thariq-17-mar-26/28.png" alt="结论" width="50%" /></a>

---

## 来源

- [Thariq (@trq212) on X — 2026 年 3 月 17 日](https://x.com/trq212/status/2033949937936085378)
- [Skilljar — Agent Skills course](https://code.claude.com/docs/en/skills)
- [Skill Creator](https://code.claude.com/docs/en/skills)
