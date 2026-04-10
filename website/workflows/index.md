# 🔧 开发工作流

探索业界主流的 Claude Code 开发工作流，找到最适合你的方案。

## 🎯 工作流概览

所有主要工作流都遵循相同的架构模式：

```
研究 → 计划 → 执行 → 审查 → 发布
```

---

## 📚 本项目的工作流示例

### 🌤️ [编排工作流 (Orchestration Workflow)](./orchestration)

**完整的命令→智能体→技能架构演示**

展示了如何通过三层架构实现复杂工作流：

```
/weather-orchestrator (命令)
    ↓
weather-agent (智能体)
    ↓
weather-fetcher (智能体技能) + weather-svg-creator (技能)
    ↓
输出: weather.svg + output.md
```

**特点**:
- ✅ 完整的工作流示例
- ✅ 可视化流程图
- ✅ 可运行的代码
- ✅ 两种技能模式演示

[查看详情 →](./orchestration)

---

### 🔀 [跨模型工作流 (Cross-Model Workflow)](./cross-model)

**Claude Code + Codex 协同工作**

利用不同 AI 模型的优势，实现更高质量的输出：

```
Claude Code (计划) → Codex (实现) → Claude Code (审查)
```

**适用场景**:
- 需要多角度审查
- 追求更高代码质量
- 避免单一模型的盲点

[查看详情 →](./cross-model)

---

### 📋 [RPI 工作流 (Research-Plan-Implement)](./rpi)

**完整的需求到实现流程**

包含 8 个专业智能体的协作工作流：

- 🔍 Requirement Parser - 需求解析
- 👔 Product Manager - 产品管理
- 🎨 UX Designer - 用户体验设计
- 🏗️ CTO Advisor - 技术架构
- 👨‍💻 Senior Engineer - 高级工程师
- 📝 Documentation Analyst - 文档分析
- 🔍 Code Reviewer - 代码审查
- ⚖️ Constitutional Validator - 规范验证

**特点**:
- ✅ 8 个专业角色智能体
- ✅ 完整的 SDLC 流程
- ✅ 质量门控机制
- ✅ 文档同步更新

[查看详情 →](./rpi)

---

## 🏆 10大工作流对比

深入分析业界主流的 Claude Code 开发工作流：

| 工作流 | Stars | 独特性 | 智能体 | 命令 | 技能 |
|--------|-------|--------|--------|------|------|
| [Everything Claude Code](./ecc) | 148k | 本能评分、AgentShield | 47 | 82 | 182 |
| [Superpowers](./superpowers) | 143k | TDD优先、铁律 | 5 | 3 | 14 |
| [Spec Kit](./spec-kit) | 87k | 规范驱动、宪法 | 0 | 9+ | 0 |
| [gstack](./gstack) | 68k | 角色人设、并行冲刺 | 0 | 0 | 37 |
| [Get Shit Done](./gsd) | 50k | 200K新上下文、波浪执行 | 24 | 68 | 0 |
| [BMAD-METHOD](./bmad) | 44k | 完整SDLC、22+平台 | 0 | 0 | 39 |
| [OpenSpec](./openspec) | 39k | 增量规范、棕地项目 | 0 | 11 | 0 |
| [oh-my-claudecode](./oh-my-claudecode) | 27k | 团队编排、tmux工作者 | 19 | 0 | 37 |
| [Compound Engineering](./compound) | 14k | 复合学习、插件市场 | 51 | 4 | 43 |
| [HumanLayer](./humanlayer) | 10k | RPI、300k+ LOC | 6 | 27 | 0 |

[查看完整对比分析 →](./comparison)

---

## 🎯 如何选择工作流？

### 按团队规模

**个人开发者**
- ✅ 本项目的轻量级工作流
- ✅ Superpowers（简单直接）
- ✅ gstack（快速原型）

**小团队（2-5人）**
- ✅ Spec Kit（规范驱动）
- ✅ oh-my-claudecode（团队协作）
- ✅ HumanLayer（上下文工程）

**大团队（5+人）**
- ✅ Everything Claude Code（完整功能）
- ✅ Compound Engineering（企业级）
- ✅ BMAD-METHOD（完整SDLC）

### 按项目类型

**新项目（绿地）**
- ✅ Get Shit Done（快速启动）
- ✅ gstack（原型为先）
- ✅ 本项目的简单工作流

**现有项目（棕地）**
- ✅ OpenSpec（增量规范）
- ✅ HumanLayer（大型代码库）
- ✅ Everything Claude Code（全面支持）

**高质量要求**
- ✅ Superpowers（TDD优先）
- ✅ Spec Kit（规范严格）
- ✅ BMAD-METHOD（完整流程）

## 💡 工作流设计原则

根据 Boris Cherny 和社区的经验总结：

::: tip 1. 简单优于复杂
原生 Claude Code 已经很强大，不要过度工程化。只在确实需要时才引入复杂工作流。
:::

::: tip 2. 使用命令而非智能体
对于日常工作流，使用命令（.claude/commands/）而不是子智能体。智能体适合需要隔离上下文的场景。
:::

::: tip 3. 渐进式展示
使用技能的渐进式展示，而不是一次性加载所有上下文。

references/ 存放详细文档，只在需要时读取。
:::

::: tip 4. 门控质量
在关键阶段设置质量门控（测试、审查、验证），确保输出质量。
:::

::: tip 5. 保持灵活
工作流不是一成不变的，根据项目演进和团队反馈持续优化。
:::

## 🚀 实施建议

### 开始简单

1. **第一周**: 使用原生 Claude Code
2. **第二周**: 添加 2-3 个常用命令
3. **第三周**: 创建 1-2 个核心技能
4. **第四周**: 如果需要，引入子智能体

### 逐步演进

```mermaid
graph LR
    A[原生 Claude] --> B[+ 命令]
    B --> C[+ 技能]
    C --> D[+ 子智能体]
    D --> E[+ 钩子]
    E --> F[完整工作流]
    
    style A fill:#e5e7eb
    style B fill:#ddd6fe
    style C fill:#c4b5fd
    style D fill:#a78bfa
    style E fill:#8b5cf6
    style F fill:#7c3aed,color:#fff
```

### 避免过度工程化

❌ **不要做**:
- 一开始就构建复杂的多智能体系统
- 为每个小任务创建单独的智能体
- 过早优化工作流

✅ **应该做**:
- 从简单命令开始
- 识别重复模式后再抽象
- 根据实际需求演进

## 📚 相关资源

- 💡 [技巧集锦](/tips/) - 69 条实战技巧
- 📖 [最佳实践](/best-practice/) - 详细实施指南
- 💻 [实现示例](/implementation/) - 可运行代码

---

**推荐**: 先从 [编排工作流](./orchestration) 开始，理解基本架构，然后探索 [10大工作流对比](./comparison)。

<style scoped>
.practice-overview > * + * {
  margin-top: 40px;
  padding-top: 40px;
  border-top: 1px solid var(--vp-c-divider);
}
</style>
