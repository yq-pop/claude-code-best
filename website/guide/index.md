# 欢迎来到 Claude Code Best Practice

欢迎来到 Claude Code 最佳实践学习中心！这里汇集了从官方团队到社区实践者的所有精华经验。

## 🎯 学习目标

通过本指南，你将能够：

<div class="goal-list">

✅ **理解核心概念** - 掌握命令、技能、子智能体等 8 大核心组件  
✅ **掌握最佳实践** - 学习 69 条实战技巧，避免常见陷阱  
✅ **构建工作流** - 创建属于自己的命令、技能和自动化工作流  
✅ **提升开发效率** - 从"氛围编程"进化到"智能体工程"

</div>

## 📖 内容概览

### 核心学习路径

```mermaid
graph LR
    A[快速开始] --> B[核心概念]
    B --> C[最佳实践]
    C --> D[工作流示例]
    D --> E[项目应用]
    
    style A fill:#7c3aed,stroke:#fff,color:#fff
    style B fill:#6d28d9,stroke:#fff,color:#fff
    style C fill:#5b21b6,stroke:#fff,color:#fff
    style D fill:#4c1d95,stroke:#fff,color:#fff
    style E fill:#3b0764,stroke:#fff,color:#fff
```

### 学习模块

| 模块 | 内容 | 时间 | 难度 |
|------|------|------|------|
| 🚀 [快速开始](./getting-started.md) | 安装配置、第一个命令、基础概念 | 30分钟 | ⭐ |
| 🧠 [核心概念](./concepts.md) | 8大核心组件详解 | 2-3小时 | ⭐⭐ |
| 📚 [最佳实践](/best-practice/) | 命令、技能、子智能体等实践指南 | 1-2天 | ⭐⭐⭐ |
| 🔧 [工作流](/workflows/) | 完整工作流示例和对比分析 | 2-3天 | ⭐⭐⭐⭐ |
| 💡 [技巧集锦](/tips/) | 69条实战技巧和团队经验 | 持续学习 | ⭐⭐⭐ |

## 🎓 推荐学习路径

### 适合新手（0-1周经验）

1. 📖 **从这里开始** → [快速开始](./getting-started.md)
2. 🧠 **理解基础** → [核心概念](./concepts.md)
3. 🎬 **观看视频** → [Boris Cherny 访谈](/videos/)
4. 💻 **运行示例** → [编排工作流](/workflows/orchestration)

### 适合进阶（有基础，想深入）

1. 📚 **系统学习** → [最佳实践合集](/best-practice/)
2. 🎯 **工作流对比** → [10大工作流分析](/workflows/comparison)
3. 💡 **技巧提升** → [69条实战技巧](/tips/)
4. 📊 **深度报告** → [技术专题](/reports/)

### 适合团队（建立标准）

1. 📖 **理解理念** → [核心概念](./concepts.md)
2. 📝 **制定规范** → [CLAUDE.md 最佳实践](/best-practice/claude-memory)
3. 🔧 **构建工作流** → [工作流示例](/workflows/)
4. 🎯 **持续优化** → [技巧集锦](/tips/) + [技术报告](/reports/)

## ⚡ 快速链接

<div class="quick-links">
  <a href="/best-practice/claude-commands" class="quick-link">
    <span class="link-icon">📝</span>
    <span class="link-text">命令 (Commands)</span>
  </a>
  <a href="/best-practice/claude-skills" class="quick-link">
    <span class="link-icon">🎯</span>
    <span class="link-text">技能 (Skills)</span>
  </a>
  <a href="/best-practice/claude-subagents" class="quick-link">
    <span class="link-icon">🤖</span>
    <span class="link-text">子智能体 (Agents)</span>
  </a>
  <a href="/best-practice/claude-settings" class="quick-link">
    <span class="link-icon">⚙️</span>
    <span class="link-text">设置 (Settings)</span>
  </a>
  <a href="/workflows/orchestration" class="quick-link">
    <span class="link-icon">🔧</span>
    <span class="link-text">工作流</span>
  </a>
  <a href="/tips/" class="quick-link">
    <span class="link-icon">💡</span>
    <span class="link-text">技巧集锦</span>
  </a>
</div>

## 📞 获取帮助

遇到问题？你可以：

- 📖 查看 [FAQ 常见问题](/resources/faq)
- 💬 在 [GitHub Discussions](https://github.com/yq-pop/claude-code-best/discussions) 提问
- 🐛 报告 [Issues](https://github.com/yq-pop/claude-code-best/issues)
- 🌟 给项目点个 [Star](https://github.com/yq-pop/claude-code-best)

## 🎉 开始你的学习之旅

准备好了吗？让我们从快速开始教程启动你的 Claude Code 之旅！

👉 [快速开始指南](./getting-started.md)

<style scoped>
.goal-list {
  padding: 32px;
  background: linear-gradient(135deg, rgba(124, 58, 237, 0.05) 0%, rgba(59, 130, 246, 0.05) 100%);
  border-left: 4px solid var(--vp-c-brand);
  border-radius: 12px;
  font-size: 1.1rem;
  line-height: 2;
  margin: 32px 0;
}

.quick-links {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 16px;
  margin: 40px 0;
}

.quick-link {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px 18px;
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  border-radius: 10px;
  text-decoration: none;
  color: var(--vp-c-text-1);
  transition: all 0.3s ease;
  font-weight: 600;
}

.quick-link:hover {
  transform: translateX(4px);
  border-color: var(--vp-c-brand);
  background: var(--vp-c-brand-soft);
  color: var(--vp-c-brand);
}

.link-icon {
  font-size: 1.35rem;
}

.link-text {
  font-family: 'Outfit', sans-serif;
  font-size: 0.95rem;
}
</style>
