# 快速开始

欢迎！让我们在 5 分钟内快速上手 Claude Code Best Practice。

## 📦 前置要求

在开始之前，请确保你已经：

- ✅ 安装了 [Claude Code CLI](https://code.claude.com/docs/en/setup)
- ✅ 有基本的命令行使用经验
- ✅ 了解 Git 基础操作

::: tip 💡 还没安装 Claude Code？
查看我们的 [安装教程](/tutorial/day0/) 了解如何在不同平台上安装 Claude Code。
:::

## 🚀 第一步：克隆项目

```bash
# 克隆仓库
git clone https://github.com/yq-pop/claude-code-best.git

# 进入项目目录
cd claude-code-best

# 启动 Claude Code
claude
```

## 🎯 第二步：运行第一个示例

让我们运行天气工作流示例，体验 **命令 → 智能体 → 技能** 的完整架构：

```bash
# 在 Claude Code 中输入
/weather-orchestrator
```

你会看到：

1. 📝 Claude 询问你选择摄氏度还是华氏度
2. 🤖 调用 `weather-agent` 子智能体
3. 🌡️ 使用 `weather-fetcher` 技能获取迪拜天气
4. 🎨 使用 `weather-svg-creator` 技能生成 SVG 卡片
5. 📄 输出文件到 `orchestration-workflow/weather.svg`

::: details 🔍 查看完整流程图
查看 [编排工作流文档](/workflows/orchestration) 了解详细的架构设计。
:::

## 📚 第三步：理解核心概念

现在你已经看到了一个完整的工作流示例，让我们理解 Claude Code 的核心组件：

### 8大核心组件

| 组件 | 作用 | 示例文件 |
|------|------|----------|
| **命令** | 用户可调用的工作流 | `.claude/commands/weather-orchestrator.md` |
| **技能** | 可预加载的知识 | `.claude/skills/weather-fetcher/SKILL.md` |
| **子智能体** | 隔离上下文的智能体 | `.claude/agents/weather-agent.md` |
| **钩子** | 事件触发的处理器 | `.claude/hooks/` |
| **MCP** | 外部工具连接器 | `.claude/settings.json` |
| **设置** | 配置系统 | `.claude/settings.json` |
| **内存** | 持久化上下文 | `CLAUDE.md` |
| **插件** | 组件捆绑包 | 可分发包 |

👉 深入了解：[核心概念详解](./concepts.md)

## 💡 第四步：学习最佳实践

掌握核心概念后，开始学习最佳实践：

### 必读文档

<div class="practice-cards">

::: info 📝 命令最佳实践
学习如何创建高效的斜杠命令，实现工作流自动化。

[阅读文档](/best-practice/claude-commands) →
:::

::: info 🎯 技能最佳实践
掌握技能的渐进式展示、上下文分叉等高级技巧。

[阅读文档](/best-practice/claude-skills) →
:::

::: info 🤖 子智能体最佳实践
了解如何设计功能特定的子智能体，提升代码质量。

[阅读文档](/best-practice/claude-subagents) →
:::

::: info ⚙️ 设置最佳实践
配置权限、模型、输出样式等，打造个性化开发体验。

[阅读文档](/best-practice/claude-settings) →
:::

</div>

## 🎬 第五步：观看视频教程

观看 Claude Code 创建者 Boris Cherny 的访谈，快速理解核心理念：

<div class="video-grid">

### 🎥 [Inside Claude Code With Its Creator](https://youtu.be/PQU9o_5rHC4)
**Boris Cherny @ Y Combinator** | 2026年2月17日

了解 Claude Code 的设计理念和未来方向。

[观看视频](https://youtu.be/PQU9o_5rHC4) | [查看笔记](/videos/y-combinator)

---

### 🎥 [Building Claude Code](https://youtu.be/julbw1JuAz0)
**Boris Cherny @ The Pragmatic Engineer** | 2026年3月4日

深入技术细节，学习如何构建生产级工作流。

[观看视频](https://youtu.be/julbw1JuAz0) | [查看笔记](/videos/pragmatic-engineer)

</div>

[查看全部视频 →](/videos/)

## 💡 第六步：掌握实战技巧

学习来自官方团队的 69 条实战技巧：

### 精选技巧

<div class="tips-highlight">

**🚫👶 不要过度干预**

> 挑战 Claude："对这些更改严格审查，在我通过你的测试之前不要创建 PR"
> 
> 让 Claude 自行修复大多数错误，粘贴错误信息，说"修复"，不要微观管理。

---

**📝 CLAUDE.md 保持简洁**

> 每个文件控制在 200 行以下，使用 `.claude/rules/` 拆分大型指令。
> 
> 对于 monorepo 使用多个 CLAUDE.md。

---

**🔧 使用命令而非智能体**

> 对于日常工作流，使用命令（`.claude/commands/`）而不是子智能体。
> 
> 如果你每天做某事超过一次，将其转换为命令或技能。

</div>

[查看全部 69 条技巧 →](/tips/)

## 🎯 第七步：实践到项目

现在，是时候将学到的知识应用到你自己的项目中了：

### 实施清单

- [ ] 创建 `CLAUDE.md` 文件（参考本项目的 CLAUDE.md）
- [ ] 识别可以命令化的日常工作流
- [ ] 创建第一个自定义命令
- [ ] 配置钩子系统（可选）
- [ ] 构建团队共享的技能库
- [ ] 设置子智能体（针对特定功能）

### 推荐阅读

- 📖 [CLAUDE.md 最佳实践](/best-practice/claude-memory)
- 📖 [命令实现示例](/implementation/claude-commands-implementation)
- 📖 [技能实现示例](/implementation/claude-skills-implementation)

## 📊 学习进度追踪

使用我们的学习清单追踪你的进度：

<div class="progress-checklist">

### 理论学习
- [ ] 阅读快速开始指南
- [ ] 理解 8 大核心概念
- [ ] 观看至少 1 个视频教程
- [ ] 浏览 69 条技巧概览

### 实践操作
- [ ] 克隆并运行项目
- [ ] 执行天气工作流示例
- [ ] 查看示例代码实现
- [ ] 尝试修改配置文件

### 项目应用
- [ ] 在自己项目中创建 CLAUDE.md
- [ ] 创建第一个自定义命令
- [ ] 应用至少 3 条最佳实践
- [ ] 分享学习心得

</div>

## 🎉 恭喜！

你已经完成了快速开始教程！接下来：

<div class="next-steps">

### 📖 推荐阅读
- [核心概念详解](./concepts.md)
- [最佳实践合集](/best-practice/)
- [工作流示例](/workflows/)

### 💬 加入社区
- [GitHub Discussions](https://github.com/yq-pop/claude-code-best/discussions)
- [Reddit - r/ClaudeCode](https://reddit.com/r/ClaudeCode/)

### ⭐ 支持项目
如果觉得有帮助，请给我们一个 Star！

[⭐ Star on GitHub](https://github.com/yq-pop/claude-code-best)

</div>

---

**下一步**: [核心概念详解](./concepts.md) →

<style scoped>
.practice-cards {
  display: grid;
  gap: 16px;
  margin: 32px 0;
}

.tips-highlight {
  background: var(--vp-c-bg-soft);
  border-left: 4px solid var(--vp-c-brand);
  border-radius: 12px;
  padding: 28px;
  margin: 32px 0;
  font-size: 0.95rem;
  line-height: 1.7;
}

.tips-highlight > * + * {
  margin-top: 24px;
  padding-top: 24px;
  border-top: 1px solid var(--vp-c-divider);
}

.video-grid {
  display: grid;
  gap: 32px;
  margin: 32px 0;
}

.video-grid h3 {
  margin-bottom: 12px;
}

.progress-checklist {
  background: var(--vp-c-bg-soft);
  border-radius: 16px;
  padding: 32px;
  margin: 32px 0;
}

.progress-checklist h3 {
  margin-top: 24px;
  margin-bottom: 16px;
  color: var(--vp-c-brand);
}

.progress-checklist ul {
  list-style: none;
  padding-left: 0;
}

.progress-checklist li {
  margin: 12px 0;
  font-size: 1.05rem;
}

.next-steps {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 24px;
  margin: 40px 0;
}

.next-steps h3 {
  font-size: 1.25rem;
  margin-bottom: 16px;
  color: var(--vp-c-brand);
}

@media (max-width: 768px) {
  .next-steps {
    grid-template-columns: 1fr;
  }
}
</style>
