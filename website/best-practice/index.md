# 最佳实践

Claude Code 最佳实践完整指南，涵盖所有核心组件的使用技巧和配置方法。

## 📚 内容概览

本节包含 8 个核心主题，涵盖 Claude Code 的所有重要方面。

<div class="practice-overview">

### 📝 [命令 (Commands)](./claude-commands.md)
学习如何创建高效的斜杠命令，实现工作流自动化。

**关键内容**: 命令结构、工作流编排、内置命令、创建技巧

[阅读文档 →](./claude-commands.md)

---

### 🎯 [技能 (Skills)](./claude-skills.md)
掌握技能的渐进式展示、上下文分叉等高级技巧。

**关键内容**: 技能结构、YAML配置、两种技能模式、自动发现

[阅读文档 →](./claude-skills.md)

---

### 🤖 [子智能体 (Agents)](./claude-subagents.md)
了解如何设计功能特定的子智能体，提升代码质量。

**关键内容**: 隔离上下文、工具配置、持久内存、编排模式

[阅读文档 →](./claude-subagents.md)

---

### ⚙️ [设置 (Settings)](./claude-settings.md)
配置权限、模型、输出样式等，打造个性化开发体验。

**关键内容**: 配置层级、权限模式、模型选择、输出样式

[阅读文档 →](./claude-settings.md)

---

### 🔌 [MCP 服务器](./claude-mcp.md)
连接外部工具、数据库和 API，扩展 Claude 的能力边界。

**关键内容**: MCP协议、服务器配置、工具调用、资源访问

[阅读文档 →](./claude-mcp.md)

---

### 🧠 [内存管理](./claude-memory.md)
通过 CLAUDE.md 和规则系统提供持久化的项目知识。

**关键内容**: CLAUDE.md 编写、200行原则、多文件策略、规则拆分

[阅读文档 →](./claude-memory.md)

---

### 🚀 [增强功能](./claude-power-ups.md)
探索 Claude Code 的高级功能和实验性特性。

**关键内容**: 增强功能、超级计划、智能体团队、计算机使用

[阅读文档 →](./claude-power-ups.md)

---

### ⌨️ [CLI 启动标志](./claude-cli-startup-flags.md)
掌握命令行标志、子命令和环境变量的使用。

**关键内容**: 启动参数、交互模式、环境变量、调试选项

[阅读文档 →](./claude-cli-startup-flags.md)

</div>

## 🎯 学习建议

### 按优先级学习

1. **必读** ⭐⭐⭐
   - [命令](./claude-commands.md)
   - [技能](./claude-skills.md)
   - [内存管理](./claude-memory.md)

2. **推荐** ⭐⭐
   - [子智能体](./claude-subagents.md)
   - [设置](./claude-settings.md)

3. **进阶** ⭐
   - [MCP 服务器](./claude-mcp.md)
   - [增强功能](./claude-power-ups.md)
   - [CLI 启动标志](./claude-cli-startup-flags.md)

### 按场景学习

<div class="scenario-cards">

**🏢 团队协作场景**
- [内存管理](./claude-memory.md) - CLAUDE.md 团队规范
- [设置](./claude-settings.md) - 统一配置
- [命令](./claude-commands.md) - 共享工作流

**🚀 个人效率场景**
- [命令](./claude-commands.md) - 日常工作流自动化
- [技能](./claude-skills.md) - 知识沉淀
- [CLI 启动标志](./claude-cli-startup-flags.md) - 快捷启动

**🔧 高级定制场景**
- [子智能体](./claude-subagents.md) - 专业智能体
- [MCP 服务器](./claude-mcp.md) - 工具集成
- [增强功能](./claude-power-ups.md) - 探索前沿

</div>

## 💡 关键原则

::: tip 🚫👶 不要过度干预
让 Claude 自主工作，只在必要时引导，避免微观管理每一步操作。
:::

::: tip 📏 保持简洁
CLAUDE.md 每个文件 ≤ 200 行，专注于必要信息，避免显而易见的内容。
:::

::: tip 🎯 功能特定
使用功能特定的子智能体配合技能（渐进式展示），而不是通用的 QA、后端工程师。
:::

::: tip 🔄 持续迭代
工作流和配置需要持续优化，随着项目演进而调整。
:::

## 📊 快速参考

| 需求 | 使用什么 | 文档链接 |
|------|----------|----------|
| 日常重复任务 | 命令 | [命令文档](./claude-commands.md) |
| 知识沉淀 | 技能 | [技能文档](./claude-skills.md) |
| 功能特定任务 | 子智能体 | [子智能体文档](./claude-subagents.md) |
| 团队规范 | CLAUDE.md | [内存文档](./claude-memory.md) |
| 外部工具集成 | MCP 服务器 | [MCP文档](./claude-mcp.md) |
| 自动化处理 | 钩子 | [钩子文档](https://github.com/shanraisshan/claude-code-hooks) |

## 🚀 下一步

选择一个主题开始深入学习：

<div class="next-topics">
  <a href="./claude-commands" class="topic-link">📝 命令</a>
  <a href="./claude-skills" class="topic-link">🎯 技能</a>
  <a href="./claude-subagents" class="topic-link">🤖 子智能体</a>
  <a href="./claude-settings" class="topic-link">⚙️ 设置</a>
  <a href="./claude-memory" class="topic-link">🧠 内存</a>
</div>

<style scoped>
.practice-overview {
  margin: 40px 0;
}

.practice-overview > * + * {
  margin-top: 40px;
  padding-top: 40px;
  border-top: 1px solid var(--vp-c-divider);
}

.scenario-cards {
  display: grid;
  gap: 24px;
  margin: 32px 0;
  padding: 32px;
  background: var(--vp-c-bg-soft);
  border-radius: 16px;
}

.scenario-cards strong {
  display: block;
  font-family: 'Outfit', sans-serif;
  font-size: 1.25rem;
  color: var(--vp-c-brand);
  margin-bottom: 16px;
}

.scenario-cards ul {
  margin: 0;
}

.next-topics {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  margin: 32px 0;
}

.topic-link {
  padding: 12px 24px;
  background: var(--vp-c-brand);
  color: white !important;
  border-radius: 24px;
  text-decoration: none;
  font-family: 'Outfit', sans-serif;
  font-weight: 600;
  font-size: 1.05rem;
  transition: all 0.3s ease;
  display: inline-block;
}

.topic-link:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(124, 58, 237, 0.4);
  background: var(--vp-c-brand-light);
}
</style>
