# 💡 技巧集锦

来自 Claude Code 创建者 Boris Cherny、Thariq 等官方团队成员的 **69 条实战技巧**。

## 🌟 精华技巧

### 🚫👶 核心原则：不要过度干预

这是贯穿所有技巧的核心理念：

> **让 Claude 自主工作，只在必要时引导，避免微观管理每一步操作。**

Claude 足够聪明，能够自行解决大多数问题。过度干预反而会降低效率和质量。

---

## 📑 技巧分类

### <span class="category-icon">💬</span> 提示技巧（3条）

| 技巧 | 来源 |
|------|------|
| 挑战 Claude - "对这些更改严格审查，在我通过你的测试之前不要创建 PR" 🚫👶 | [Boris Cherny](https://x.com/bcherny) |
| 在平庸的修复之后 - "既然你现在知道了一切，抛弃这个并实现优雅的解决方案" 🚫👶 | [Boris Cherny](https://x.com/bcherny) |
| Claude 能自行修复大多数错误 - 粘贴错误，说"修复"，不要微观管理 🚫👶 | [Boris Cherny](https://x.com/bcherny) |

[查看详细内容 →](./category/prompting.md)

---

### <span class="category-icon">📋</span> 计划/规范（6条）

| 技巧 | 来源 |
|------|------|
| 始终从计划模式开始 | [Boris Cherny](https://x.com/bcherny) |
| 让 Claude 使用 AskUserQuestion 工具采访你 | [Thariq](https://x.com/trq212) |
| 启动第二个 Claude 作为资深工程师审查你的计划 | [Boris Cherny](https://x.com/bcherny) |
| 原型 > PRD - 构建 20-30 个版本而不是编写规范 | [Boris Cherny](https://x.com/bcherny) |

[查看详细内容 →](./category/planning.md)

---

### <span class="category-icon">📝</span> CLAUDE.md（7条）

| 技巧 | 来源 |
|------|------|
| CLAUDE.md 每个文件应控制在 200 行以下 | [Boris Cherny](https://x.com/bcherny) |
| 将特定领域规则包装在 `<important if="...">` 标签中 | [Dex Horthy](https://x.com/dexhorthy) |
| 对于 monorepo 使用多个 CLAUDE.md | 社区实践 |
| 使用 `.claude/rules/` 拆分大型指令 | 官方文档 |
| 任何开发人员都应该能够启动 Claude，说"运行测试"，然后第一次就能工作 | [Dex Horthy](https://x.com/dexhorthy) |

[查看详细内容 →](./category/claudemd.md)

---

### <span class="category-icon">🤖</span> 智能体（4条）

| 技巧 | 来源 |
|------|------|
| 使用功能特定的子智能体配合技能（渐进式展示） | [Boris Cherny](https://x.com/bcherny) |
| 说"使用子智能体"以投入更多计算能力 🚫👶 | [Boris Cherny](https://x.com/bcherny) |
| 使用 tmux 智能体团队和 git 工作树进行并行开发 | 官方文档 |
| 使用测试时计算 - 独立的上下文窗口使结果更好 | [Boris Cherny](https://x.com/bcherny) |

[查看详细内容 →](./category/agents.md)

---

### <span class="category-icon">📝</span> 命令（3条）

| 技巧 | 来源 |
|------|------|
| 为你的工作流使用命令，而不是子智能体 | [Boris Cherny](https://x.com/bcherny) |
| 对每天多次执行的"内部循环"工作流使用斜杠命令 | [Boris Cherny](https://x.com/bcherny) |
| 如果你每天做某事超过一次，将其转换为技能或命令 | [Boris Cherny](https://x.com/bcherny) |

[查看详细内容 →](./category/commands.md)

---

### <span class="category-icon">🎯</span> 技能（9条）

| 技巧 | 来源 |
|------|------|
| 使用 `context: fork` 在隔离的子智能体中运行技能 | [Lydia Hallie](https://x.com/lydiahallie) |
| 对于 monorepo 使用子文件夹中的技能 | 社区实践 |
| 技能是文件夹，不是文件 - 使用渐进式展示 | [Thariq](https://x.com/trq212) |
| 在每个技能中构建 Gotchas 部分 | [Thariq](https://x.com/trq212) |
| 技能描述字段是触发器，不是摘要 | [Thariq](https://x.com/trq212) |

[查看详细内容 →](./category/skills.md)

---

### <span class="category-icon">🪝</span> 钩子（5条）

| 技巧 | 来源 |
|------|------|
| 在技能中使用按需钩子 - /careful 阻止破坏性命令 | [Thariq](https://x.com/trq212) |
| 使用 PreToolUse 钩子测量技能使用情况 | [Thariq](https://x.com/trq212) |
| 使用 PostToolUse 钩子自动格式化代码 | [Boris Cherny](https://x.com/bcherny) |
| 通过钩子将权限请求路由到 Opus 🚫👶 | [Boris Cherny](https://x.com/bcherny) |
| 使用 Stop 钩子在回合结束时推动 Claude 继续 | [Boris Cherny](https://x.com/bcherny) |

[查看详细内容 →](./category/hooks.md)

---

### <span class="category-icon">🔧</span> 工作流（7条）

| 技巧 | 来源 |
|------|------|
| 在最多 50% 时手动执行 /compact | 社区实践 |
| 使用 /model 选择模型，/context 查看上下文使用情况 | [Cat Wu](https://x.com/_catwu) |
| 始终使用思考模式和 Explanatory 输出样式 | [Boris Cherny](https://x.com/bcherny) |
| /rename 重要会话并稍后 /resume 它们 | [Cat Wu](https://x.com/_catwu) |
| 使用 Esc Esc 或 /rewind 撤销，而不是在同一上下文中修复 | 官方文档 |

[查看详细内容 →](./category/workflows.md)

---

### <span class="category-icon">🎓</span> 高级工作流（6条）

| 技巧 | 来源 |
|------|------|
| 大量使用 ASCII 图表来理解你的架构 | [Boris Cherny](https://x.com/bcherny) |
| 使用 /loop 进行本地循环监控（最多 3 天） | 官方文档 |
| 使用 Ralph Wiggum 插件进行长时间运行的自主任务 | [Boris Cherny](https://x.com/bcherny) |
| 使用通配符语法的 /permissions | [Boris Cherny](https://x.com/bcherny) |
| /sandbox 通过文件和网络隔离减少权限提示 | [Boris Cherny](https://x.com/bcherny) |

[查看详细内容 →](./category/workflows-advanced.md)

---

### <span class="category-icon">🔀</span> Git / PR（5条）

| 技巧 | 来源 |
|------|------|
| 保持 PR 小而专注 - p50 为 118 行 | [Boris Cherny](https://x.com/bcherny) |
| 始终压缩合并 PR - 整洁的线性历史 | [Boris Cherny](https://x.com/bcherny) |
| 经常提交 - 尝试每小时至少提交一次 | 社区实践 |
| 在同事的 PR 上标记 @claude 自动生成 lint 规则 🚫👶 | [Boris Cherny](https://x.com/bcherny) |
| 使用 /code-review 进行多智能体 PR 分析 | [Boris Cherny](https://x.com/bcherny) |

[查看详细内容 →](./category/git-pr.md)

---

### <span class="category-icon">🐛</span> 调试（7条）

| 技巧 | 来源 |
|------|------|
| 养成截图并与 Claude 分享的习惯 | 社区实践 |
| 使用 MCP 让 Claude 自己查看 Chrome 控制台日志 | 官方文档 |
| 始终让 Claude 将终端作为后台任务运行 | 社区实践 |
| 使用 /doctor 诊断问题 | 官方文档 |
| 智能体搜索（glob + grep）优于 RAG | [Boris Cherny](https://x.com/bcherny) |

[查看详细内容 →](./category/debugging.md)

---

### <span class="category-icon">🛠️</span> 实用工具（5条）

| 技巧 | 来源 |
|------|------|
| 使用 iTerm/Ghostty/tmux 终端，而不是 IDE | [Boris Cherny](https://x.com/bcherny) |
| 使用 /voice 或 Wispr Flow 进行语音提示 | [Boris Cherny](https://x.com/bcherny) |
| 使用钩子系统进行反馈 | 社区实践 |
| 使用状态栏进行上下文感知 | [Boris Cherny](https://x.com/bcherny) |
| 探索 settings.json 的个性化功能 | [Boris Cherny](https://x.com/bcherny) |

[查看详细内容 →](./category/utilities.md)

---

### <span class="category-icon">📅</span> 日常（2条）

| 技巧 | 来源 |
|------|------|
| 每天更新 Claude Code | 社区实践 |
| 通过阅读变更日志开始你的一天 | 社区实践 |

[查看详细内容 →](./category/daily.md)

---

## 📚 深度学习

### 官方团队文章

- [Boris 的 13 条技巧](./claude-boris-13-tips-03-jan-26.md) - 最早的技巧合集
- [Boris 的 10 条技巧](./claude-boris-10-tips-01-feb-26.md) - 团队总结
- [Boris 的 15 条隐藏功能](./claude-boris-15-tips-30-mar-26.md) - 最新更新
- [Thariq 的技能使用经验](./claude-thariq-tips-17-mar-26.md) - 技能深度指南

## 🎯 应用这些技巧

::: tip 💡 实践建议
1. **不要一次性应用所有技巧** - 选择 3-5 条最相关的开始
2. **理解背后的原理** - 不要死记硬背
3. **根据项目调整** - 这些是指导原则，不是死板规则
4. **持续实验和优化** - 找到最适合你的工作方式
:::

## 🚀 下一步

- 查看 [工作流示例](/workflows/) 看这些技巧如何应用到实际项目中
- 阅读 [最佳实践](/best-practice/) 了解详细的实施指南
- 观看 [视频教程](/videos/) 听官方团队亲自讲解

<style scoped>
.category-icon {
  font-size: 1.25rem;
  margin-right: 8px;
}

table {
  width: 100%;
  margin: 24px 0;
}

table td:first-child {
  width: 75%;
}

table td:last-child {
  text-align: center;
  white-space: nowrap;
}
</style>
