# 在大型单体仓库中理解 Claude 技能发现

在单体仓库中使用 Claude Code 时,理解技能如何被发现并加载到上下文中对于有效组织项目特定功能至关重要。

<table width="100%">
<tr>
<td><a href="../">← Back to Claude Code Best Practice</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

## 与 CLAUDE.md 的重要区别

**技能的加载行为与 CLAUDE.md 文件不同。** 虽然 CLAUDE.md 文件向上遍历目录树(祖先加载),但技能使用不同的发现机制,专注于项目内的嵌套目录。

## 技能如何被发现

### 1. 标准技能位置

技能根据作用域从这些固定位置加载:

| 位置 | 路径 | 适用于 |
|----------|------|------------|
| 企业 | 托管设置 | 组织中的所有用户 |
| 个人 | `~/.claude/skills/<skill-name>/SKILL.md` | 你的所有项目 |
| 项目 | `.claude/skills/<skill-name>/SKILL.md` | 仅此项目 |
| 插件 | `<plugin>/skills/<skill-name>/SKILL.md` | 启用插件的地方 |

### 2. 从嵌套目录自动发现

当你在子目录中处理文件时,Claude Code 会自动从嵌套的 `.claude/skills/` 目录发现技能。例如,如果你正在编辑 `packages/frontend/` 中的文件,Claude Code 也会在 `packages/frontend/.claude/skills/` 中查找技能。

这支持包具有自己技能的单体仓库设置。

## 单体仓库结构示例

考虑一个典型的带有独立包的单体仓库：

```
/mymonorepo/
├── .claude/
│   └── skills/
│       └── shared-conventions/SKILL.md    # 项目级技能
├── packages/
│   ├── frontend/
│   │   ├── .claude/
│   │   │   └── skills/
│   │   │       └── react-patterns/SKILL.md  # 前端特定技能
│   │   └── src/
│   │       └── App.tsx
│   ├── backend/
│   │   ├── .claude/
│   │   │   └── skills/
│   │   │       └── api-design/SKILL.md      # 后端特定技能
│   │   └── src/
│   └── shared/
│       ├── .claude/
│       │   └── skills/
│       │       └── utils-patterns/SKILL.md  # 共享工具技能
│       └── src/
```

## 场景 1：刚在根目录启动 Claude（尚未编辑任何文件）

当你从 `/mymonorepo/` 运行 Claude Code 且尚未编辑任何文件时：

```bash
cd /mymonorepo
claude
# 刚启动 - 尚未编辑任何文件
```

| 技能 | 在上下文中？ | 原因 |
|-------|-------------|--------|
| `shared-conventions` | **是** | 根目录 `.claude/skills/` 中的项目级技能 |
| `react-patterns` | **否** | 未发现 - 尚未处理 `packages/frontend/` 中的文件 |
| `api-design` | **否** | 未发现 - 尚未处理 `packages/backend/` 中的文件 |
| `utils-patterns` | **否** | 未发现 - 尚未处理 `packages/shared/` 中的文件 |

## 场景 2：编辑包中的文件后

在你要求 Claude 编辑 `packages/frontend/src/App.tsx` 之后：

| 技能 | 在上下文中？ | 原因 |
|-------|-------------|--------|
| `shared-conventions` | **是** | 根目录 `.claude/skills/` 中的项目级技能 |
| `react-patterns` | **是** | 编辑 `packages/frontend/` 中的文件时被发现 |
| `api-design` | **否** | 仍未发现 - 尚未处理 `packages/backend/` 中的文件 |
| `utils-patterns` | **否** | 仍未发现 - 尚未处理 `packages/shared/` 中的文件 |

**关键洞察**：嵌套技能在你处理这些目录中的文件时**按需**发现。它们不会在会话开始时预加载。

## 关键行为：描述 vs 完整内容

技能描述被加载到上下文中，这样 Claude 就知道有什么可用，但**完整技能内容仅在调用时加载**。这是一个重要的优化：

- **描述**：始终在上下文中（在字符预算内）
- **完整内容**：调用技能时按需加载

> 注意：带预加载技能的子代理工作方式不同 - 完整技能内容在启动时注入。

## 优先级顺序（当技能共享名称时）

当技能在不同级别共享相同名称时，优先级更高的位置获胜：

| 优先级 | 位置 | 范围 |
|----------|----------|-------|
| 1（最高） | 企业 | 组织范围 |
| 2 | 个人（`~/.claude/skills/`） | 你的所有项目 |
| 3（最低） | 项目（`.claude/skills/`） | 仅此项目 |

插件技能使用 `plugin-name:skill-name` 命名空间，因此不会与其他级别冲突。

## 为什么这种设计适用于单体仓库

- **包特定的技能保持隔离** - 在 `packages/frontend/` 中工作的前端开发人员获得前端特定的技能，而不会被后端技能干扰上下文。

- **自动发现减少配置** - 无需显式注册包级技能；当你在这些目录中工作时它们会被发现。

- **上下文被优化** - 最初只加载技能描述，嵌套技能按需发现。

- **团队可以维护自己的技能** - 每个包团队可以定义特定于其领域的技能，而无需与其他团队协调。

## 字符预算考虑

技能描述被加载到上下文中，最多到字符预算（默认 15,000 个字符）。在带有许多包和技能的大型单体仓库中，你可能会达到此限制。

- 运行 `/context` 检查有关排除技能的警告
- 设置 `SLASH_COMMAND_TOOL_CHAR_BUDGET` 环境变量以增加限制

## 最佳实践

1. **将共享工作流放在根 `.claude/skills/` 中** - 仓库范围的约定、提交工作流和共享模式。

2. **将包特定的技能放在包 `.claude/skills/` 中** - 框架特定的模式、组件约定、该包独有的测试工具。

3. **对危险技能使用 `disable-model-invocation: true`** - 部署或破坏性技能应需要明确的用户调用。

4. **保持技能描述简洁** - 描述始终在上下文中(直到字符预算),因此冗长的描述浪费上下文空间。

5. **在技能名称中使用命名空间** - 考虑使用包名称作为前缀(例如,`frontend-review`、`backend-deploy`)以避免混淆。

## 比较:技能 vs CLAUDE.md 加载

| 行为 | CLAUDE.md | 技能 |
|----------|-----------|--------|
| 祖先加载(向上目录树) | 是 | 否 |
| 嵌套/后代发现(向下目录树) | 是(懒加载) | 是(自动发现) |
| 全局位置 | `~/.claude/CLAUDE.md` | `~/.claude/skills/` |
| 项目位置 | `.claude/` 或仓库根目录 | `.claude/skills/` |
| 内容加载 | 完整内容 | 仅描述(调用时完整) |

---

## 资料来源

- [Claude Code Documentation - Extend Claude with Skills](https://code.claude.com/docs/en/skills)
- [Claude Code Documentation - Automatic Discovery from Nested Directories](https://code.claude.com/docs/en/skills#automatic-discovery-from-nested-directories)
