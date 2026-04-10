---
description: 为功能创建全面的规划文档
argument-hint: "<feature-slug>"
---

## 用户输入

```text
$ARGUMENTS
```

你**必须**解析用户输入以提取功能 slug（`rpi/` 中的文件夹名称）。

## 目的

此命令为功能请求创建全面的规划文档。它在功能的 RPI 文件夹中生成详细的规范、技术设计和实施计划。

**前提条件**：
- 功能文件夹存在于 `rpi/{feature-slug}/`
- 研究已完成并有 GO 建议（`rpi/{feature-slug}/research/RESEARCH.md` 存在）

**输出位置**：所有文件保存到 `rpi/{feature-slug}/plan/`

**这是 RPI 工作流的步骤 3**（在研究批准 GO 之后）。

## 大纲

1. **加载上下文**：读取研究报告和项目宪章（如果存在）
2. **理解需求**：解析功能范围和需求
3. **分析技术需求**：审查架构和依赖项
4. **设计架构**：创建高层架构和 API 契约
5. **分解实施**：创建分阶段任务分解
6. **生成文档**：创建结构化文档文件
7. **验证输出**：确保所有质量关卡通过
8. **报告完成**：提供摘要和后续步骤

## 阶段

### 阶段 0：加载上下文

**前提条件**：已提供功能 slug

**流程**：
1. **验证研究已完成**：
   - 检查 `rpi/{feature-slug}/research/RESEARCH.md` 是否存在
   - 验证 GO 建议（如果是 NO-GO 或 CONDITIONAL 则警告）

2. **读取研究结果**：
   - 提取产品分析
   - 提取技术发现
   - 提取技术可行性评估
   - 记录风险和约束

3. **加载项目宪章**（如果存在）：
   - 在仓库中查找宪章或原则文档
   - 提取相关约束和偏好

**输出**：
- 研究摘要
- 宪章上下文（如果找到）
- 规划约束

**验证**：
- [ ] 研究报告存在
- [ ] GO 建议已确认
- [ ] 宪章已加载（如果存在）

---

### 阶段 1：理解功能需求

**前提条件**：阶段 0 完成

**流程**：
1. **从研究报告中解析功能描述**：
   - 提取功能名称和主要目标
   - 识别目标组件
   - 理解面向用户 vs 技术功能
   - 确定功能复杂性级别

2. **识别受影响的组件**：
   - 主要组件（功能所在位置）
   - 次要组件（集成点）
   - 所需的共享实用程序
   - 外部依赖项

3. **研究现有模式**：
   - 在代码库中搜索类似功能
   - 审查组件架构和模式
   - 识别可重用的代码和模式

**输出**：
- 功能范围文档（内部）
- 受影响的组件列表
- 现有模式目录

**验证**：
- [ ] 功能名称和目标明确定义
- [ ] 目标组件已识别
- [ ] 功能复杂性已评估

---

### Phase 2: Analyze Technical Requirements

**Prerequisites**: Phase 1 complete

**Process**:
1. **Review Component Architecture**:
   - Read component README and documentation
   - Review existing code structure
   - Identify architectural patterns used

2. **Identify Technical Dependencies**:
   - Internal dependencies (other components, shared utilities)
   - External dependencies (APIs, services, libraries)
   - Database/storage requirements
   - Authentication/authorization needs

3. **Assess Integration Points**:
   - APIs that need to be created or modified
   - Database schema changes required
   - Event/message flows
   - Frontend-backend integration

4. **Evaluate Technical Risks**:
   - Breaking changes to existing features
   - Performance implications
   - Security concerns
   - Data migration needs

**Outputs**:
- Technical requirements document (internal)
- Dependency map
- Integration point diagram
- Risk assessment

**Validation**:
- [ ] Component architecture understood
- [ ] All dependencies identified
- [ ] Integration points mapped
- [ ] Technical risks assessed

---

### Phase 3: Design Feature Architecture

**Prerequisites**: Phases 1-2 complete

**Agent**: senior-software-engineer

**Process**:
1. **Design High-Level Architecture**:
   - Component/module structure
   - Data flow diagrams
   - API interfaces
   - Database schema changes

2. **Define Implementation Approach**:
   - File structure and organization
   - Code organization patterns
   - Testing strategy
   - Error handling approach

3. **Plan Database/Storage Changes** (if applicable):
   - New collections/tables
   - Schema modifications
   - Migration strategy
   - Data validation rules

4. **Design API Contracts** (if applicable):
   - Request/response formats
   - Authentication requirements
   - Error responses

5. **Plan Testing Strategy**:
   - Unit test requirements
   - Integration test scenarios
   - End-to-end test cases

**Outputs**:
- Architecture design document (internal)
- API specifications
- Database schema design
- Testing strategy

**Validation**:
- [ ] High-level architecture designed
- [ ] Implementation approach defined
- [ ] Database changes planned (if needed)
- [ ] API contracts specified (if needed)
- [ ] Testing strategy complete

---

### Phase 4: Break Down Implementation Tasks

**Prerequisites**: Phases 1-3 complete

**Process**:
1. **Identify Implementation Phases**:
   - Break feature into 3-5 logical phases
   - Each phase should deliver working, testable functionality
   - Phases should build on each other progressively

2. **Create Task Breakdown for Each Phase**:
   - List specific implementation tasks
   - Estimate complexity (Low/Medium/High)
   - Identify task dependencies
   - Assign to appropriate code areas

3. **Define Success Criteria**:
   - Acceptance criteria for each phase
   - Testing requirements
   - Documentation requirements

4. **Identify Parallelization Opportunities**:
   - Tasks that can be done concurrently
   - Frontend/backend parallel work
   - Independent module development

**Outputs**:
- Phased implementation plan
- Task breakdown with estimates
- Success criteria per phase
- Dependency chart

**Validation**:
- [ ] Feature broken into 3-5 logical phases
- [ ] Each phase has specific tasks
- [ ] All tasks have complexity estimates
- [ ] Dependencies clearly marked
- [ ] Success criteria defined

---

### 阶段 5：生成文档

**前提条件**：阶段 1-4 完成

**代理**：documentation-analyst-writer（通过 Task 工具）

**流程**：
1. **生成 pm.md**（产品需求）：
   - 功能描述和用户故事
   - 宪章一致性（如适用）
   - 业务价值和成功指标
   - 用户角色和用例
   - 验收标准
   - 不在范围内的项目

2. **生成 ux.md**（用户体验设计）：
   - 用户界面模型（文本描述）
   - 用户流程和交互
   - 可访问性考虑
   - 错误状态和边缘情况

3. **生成 eng.md**（技术规范）：
   - 架构设计
   - API 规范
   - 数据库架构更改
   - 技术栈
   - 技术风险和缓解

4. **生成 PLAN.md**（实施路线图）：
   - 分阶段实施分解
   - 每个阶段的任务列表和估算
   - 依赖项和排序
   - 每个阶段的成功标准
   - 测试要求
   - 验证检查点

**输出文件**（全部保存到 `rpi/{feature-slug}/plan/`）：
- `pm.md` - 产品需求
- `ux.md` - UX 设计
- `eng.md` - 技术规范
- `PLAN.md` - 详细实施路线图

**验证**：
- [ ] 所有 4 个文件都存在（pm、ux、eng、PLAN）
- [ ] pm.md 涵盖业务需求
- [ ] ux.md 解决用户体验
- [ ] eng.md 提供技术规范
- [ ] PLAN.md 有分阶段实施
- [ ] 没有占位符文本残留
- [ ] Markdown 格式整洁

---

## 子代理委托

此命令协调专门的代理：

| 阶段 | 代理 | 类型 | 目的 |
|-------|-------|------|---------|
| 阶段 3 | senior-software-engineer | 自定义 | 架构设计 |
| 阶段 5 | product-manager | 自定义 | 产品需求 (pm.md) |
| 阶段 5 | ux-designer | 自定义 | 用户体验 (ux.md) |
| 阶段 5 | senior-software-engineer | 自定义 | 技术规范 (eng.md) |
| 阶段 5 | documentation-analyst-writer | 内置 | 文档综合 |

### 代理调用

**自定义代理**（product-manager、senior-software-engineer、ux-designer）：
- Claude Code 自动从 `.claude/agents/` 检测这些
- 自然地引用它们："作为 senior-software-engineer 代理..."
- 不需要 Task 工具调用

**内置代理**（documentation-analyst-writer）：
- 使用 Task 工具，带 `subagent_type="documentation-analyst-writer"`

---

## Completion Report

Report the following on successful completion:

### Outputs Created

**Documentation Folder**: `rpi/{feature-slug}/plan/`

Files created:
- **pm.md**: Product requirements and user stories ({Y} stories)
- **ux.md**: User experience design ({Z} flows)
- **eng.md**: Technical specification ({A} APIs, {B} schema changes)
- **PLAN.md**: Detailed roadmap ({C} phases, {D} tasks)

### Feature Summary

- **Feature Name**: {feature-name}
- **Target Component**: {component-name}
- **Complexity**: {Simple/Medium/Complex}
- **Implementation Phases**: {N} phases
- **Total Tasks**: {M} tasks
- **Dependencies**: {Y} internal, {Z} external

### Technical Overview

- **Architecture Pattern**: {pattern-name}
- **APIs Added/Modified**: {N} APIs
- **Database Changes**: {Y} collections/tables
- **Testing Requirements**: {Z} test suites
- **Risk Level**: {Low/Medium/High}

### Implementation Phases

1. **Phase 1**: {phase-name} - {task-count} tasks
2. **Phase 2**: {phase-name} - {task-count} tasks
3. **Phase 3**: {phase-name} - {task-count} tasks
[Continue for all phases...]

---

### 后续步骤

1. **审查文档**：
   - 阅读 `rpi/{feature-slug}/plan/` 中的规划文档
   - 审查 `eng.md` 中的技术规范
   - 理解 `PLAN.md` 中的实施阶段

2. **与利益相关者验证**：
   - pm.md 的产品审查
   - ux.md 的 UX 审查
   - eng.md 的技术审查

3. **开始实施**：
   - 运行 `/rpi:implement "{feature-slug}"` 执行分阶段实施
   - 遵循 PLAN.md 的阶段
   - 在每个阶段完成验证关卡

---

## 错误处理

**如果研究报告不存在**：
- 操作：停止并告知用户
- 消息："未找到研究报告。请先运行 `/rpi:research`。"

**如果研究建议是 NO-GO**：
- 操作：警告用户但允许继续
- 消息："研究建议 NO-GO。仍要继续吗？(y/n)"

**如果目标组件不存在**：
- 操作：与用户确认这是否是新组件
- 消息："未找到组件。这是新组件吗？"

**如果文档代理失败**：
- 操作：直接生成文档
- 警告："文档可能不完全符合标准"

---

## 注释

- **前提条件**：研究已完成并有 GO 建议
- **RPI 工作流的一部分**：步骤 3/4（描述 → 研究 → 规划 → 实施）

**最佳实践**：
1. **首先审查研究**：确保你理解可行性评估
2. **利用发现**：使用研究阶段的技术发现
3. **要具体**：详细的计划导致更顺畅的实施
4. **早期验证**：在实施前审查文档

---

## 完成后操作

**重要**：完成规划工作流后，始终提示用户压缩对话：

> **上下文管理**：此规划工作流消耗了大量上下文。要为实施释放空间，请运行：
>
> ```
> /compact
> ```
>
> 这将总结对话并保留规划决策，同时减少实施阶段的令牌使用量。
