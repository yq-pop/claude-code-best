# 📊 技术报告

深度技术报告合集，解答 Claude Code 使用过程中的关键问题和常见困惑。

## 🎯 报告概览

我们提供 **9 个专题报告**，涵盖架构选择、工具对比、配置策略等核心主题。

---

## 📑 核心报告

### 🔀 [Agent SDK vs CLI 系统提示](./claude-agent-sdk-vs-cli-system-prompts.md)

**问题**: Agent SDK 和 CLI 的系统提示有什么区别？

**核心内容**:
- SDK 和 CLI 的系统提示对比
- 适用场景分析
- 选择建议

[阅读报告 →](./claude-agent-sdk-vs-cli-system-prompts.md)

---

### 🌐 [Browser Automation MCP 对比](./claude-in-chrome-v-chrome-devtools-mcp.md)

**问题**: Claude in Chrome、Playwright MCP、Chrome DevTools MCP 有什么区别？

**核心内容**:
- 三种浏览器自动化方案对比
- 功能特性分析
- 使用场景推荐
- 性能和易用性评估

[阅读报告 →](./claude-in-chrome-v-chrome-devtools-mcp.md)

---

### ⚙️ [Global vs Project Settings](./claude-global-vs-project-settings.md)

**问题**: 全局设置和项目设置如何协同工作？

**核心内容**:
- 配置层级详解
- 优先级规则
- 个人vs团队配置策略
- 最佳实践建议

[阅读报告 →](./claude-global-vs-project-settings.md)

---

### 🏢 [Skills in Monorepos](./claude-skills-for-larger-mono-repos.md)

**问题**: 在大型 monorepo 中如何组织技能？

**核心内容**:
- Monorepo 技能组织策略
- 子文件夹技能模式
- 避免技能冲突
- 团队协作最佳实践

[阅读报告 →](./claude-skills-for-larger-mono-repos.md)

---

### 🧠 [Agent Memory](./claude-agent-memory.md)

**问题**: 智能体的内存系统如何工作？

**核心内容**:
- 三种内存范围（user、project、local）
- 跨会话持久化
- 内存管理策略
- 使用场景和最佳实践

[阅读报告 →](./claude-agent-memory.md)

---

### 🔧 [Advanced Tool Use](./claude-advanced-tool-use.md)

**问题**: 如何使用 Claude 的高级工具能力？

**核心内容**:
- 编程式工具调用
- 并行工具执行
- 工具组合模式
- 错误处理和重试

[阅读报告 →](./claude-advanced-tool-use.md)

---

### 📈 [Usage & Rate Limits](./claude-usage-and-rate-limits.md)

**问题**: Claude Code 的使用量和速率限制是多少？

**核心内容**:
- 免费和付费计划对比
- 速率限制详解
- 成本优化策略
- 超额使用管理

[阅读报告 →](./claude-usage-and-rate-limits.md)

---

### 🎨 [Agents vs Commands vs Skills](./claude-agent-command-skill.md)

**问题**: 何时使用智能体、命令还是技能？

**核心内容**:
- 三者的区别和联系
- 使用场景对比
- 选择决策树
- 组合使用模式

[阅读报告 →](./claude-agent-command-skill.md)

---

### 📉 [LLM Day-to-Day Degradation](./llm-day-to-day-degradation.md)

**问题**: 为什么 LLM 的日常表现会下降？

**核心内容**:
- 模型退化现象分析
- 可能的原因探讨
- 缓解策略
- 监控和应对方法

[阅读报告 →](./llm-day-to-day-degradation.md)

---

## 🔍 按主题查找

### 架构和设计
- [Agent SDK vs CLI](./claude-agent-sdk-vs-cli-system-prompts.md)
- [Agents vs Commands vs Skills](./claude-agent-command-skill.md)
- [Skills in Monorepos](./claude-skills-for-larger-mono-repos.md)

### 配置和设置
- [Global vs Project Settings](./claude-global-vs-project-settings.md)
- [Agent Memory](./claude-agent-memory.md)

### 工具和集成
- [Browser Automation MCP](./claude-in-chrome-v-chrome-devtools-mcp.md)
- [Advanced Tool Use](./claude-advanced-tool-use.md)

### 使用和优化
- [Usage & Rate Limits](./claude-usage-and-rate-limits.md)
- [LLM Degradation](./llm-day-to-day-degradation.md)

## 💡 阅读建议

### 新手必读
1. [Agents vs Commands vs Skills](./claude-agent-command-skill.md) - 理解核心区别
2. [Global vs Project Settings](./claude-global-vs-project-settings.md) - 配置基础

### 进阶阅读
1. [Agent Memory](./claude-agent-memory.md) - 掌握内存系统
2. [Advanced Tool Use](./claude-advanced-tool-use.md) - 高级用法
3. [Skills in Monorepos](./claude-skills-for-larger-mono-repos.md) - 大型项目

### 问题排查
1. [LLM Degradation](./llm-day-to-day-degradation.md) - 性能问题
2. [Usage & Rate Limits](./claude-usage-and-rate-limits.md) - 限制问题

## 🎯 报告特点

✅ **深度分析** - 每个报告都经过深入研究和实战验证  
✅ **实用导向** - 提供可操作的建议和解决方案  
✅ **持续更新** - 随 Claude Code 版本更新而迭代  
✅ **社区驱动** - 吸收社区反馈和真实案例

## 🚀 下一步

- 📚 查看 [最佳实践](/best-practice/) 了解实施细节
- 💡 阅读 [技巧集锦](/tips/) 获取快速提示
- 🔧 探索 [工作流示例](/workflows/) 学习架构模式

<style scoped>
.video-actions {
  display: flex;
  gap: 16px;
  margin: 24px 0 48px 0;
  flex-wrap: wrap;
}

.btn-watch,
.btn-notes {
  padding: 12px 28px;
  border-radius: 12px;
  text-decoration: none;
  font-family: 'Outfit', sans-serif;
  font-weight: 600;
  font-size: 1.05rem;
  transition: all 0.3s ease;
  display: inline-block;
}

.btn-watch {
  background: linear-gradient(135deg, #7c3aed 0%, #6d28d9 100%);
  color: white !important;
}

.btn-watch:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 30px rgba(124, 58, 237, 0.4);
}

.btn-notes {
  background: var(--vp-c-bg-soft);
  border: 2px solid var(--vp-c-brand);
  color: var(--vp-c-brand) !important;
}

.btn-notes:hover {
  background: var(--vp-c-brand-soft);
  transform: translateY(-2px);
}
</style>
