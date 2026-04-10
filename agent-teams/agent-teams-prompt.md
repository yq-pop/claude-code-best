创建一个智能体团队来构建时间编排工作流，将当前迪拜时间显示为可视化的 SVG 卡片。该工作流遵循
命令 → 智能体 → 技能架构模式：

- 命令编排流程并处理用户交互
- 智能体使用预加载的技能获取迪拜的实时当前时间
- 技能从获取的数据创建可视化的 SVG 时间卡片

**重要**：所有文件必须在 `agent-teams/.claude/` 内创建 —
而不是在仓库根目录的 `.claude/` 目录中。这使智能体团队的
输出保持独立并可通过 `cd agent-teams && claude` 运行。
不要引用或复制现有的天气工作流 — 从头开始构建所有内容。

分配这些团队成员：

1. **命令架构师** — 在 `agent-teams/.claude/commands/time-orchestrator.md` 中设计和实现 `/time-orchestrator`
   命令。该命令应该：
   - 通过 Agent 工具（不是 bash）调用 time-agent 以获取
     迪拜（阿联酋）的当前时间（Asia/Dubai 时区，UTC+4）
   - 通过 Skill 工具调用 time-svg-creator 技能以从
     获取的时间数据渲染 SVG 卡片
   - 在前置元数据中使用 model: haiku
   - 包含关键要求：顺序流程、正确的工具使用
     （Agent 工具用于智能体，Skill 工具用于技能）以及输出摘要
   通过共享任务列表与其他团队成员协调，就组件之间传递的
   数据契约（{time, timezone, formatted}）达成一致。

2. **智能体工程师** — 在 `agent-teams/.claude/agents/time-agent.md` 中设计和实现 `time-agent`
   以及其预加载的 `time-fetcher` 技能（位于 `agent-teams/.claude/skills/time-fetcher/SKILL.md`）。该智能体应该：
   - 使用 Bash 和 `TZ='Asia/Dubai' date '+%Y-%m-%d %H:%M:%S %Z'` 获取迪拜的当前时间（Asia/Dubai，UTC+4）
   - 将时间值、时区名称和格式化字符串返回给命令
   - 使用前置元数据：tools（Bash）、model: haiku、color: blue、maxTurns: 3
   - 通过 `skills:` 字段预加载 time-fetcher 技能
   time-fetcher 技能（`agent-teams/.claude/skills/time-fetcher/SKILL.md`）
   应包含获取迪拜时间的 bash 命令、预期输出格式，
   并设置 user-invocable: false，因为它是仅限智能体的领域知识。
   将约定的数据契约发布到共享任务列表，以便命令
   架构师和技能设计师可以在接口上保持一致。

3. **技能设计师** — 在 `agent-teams/.claude/skills/time-svg-creator/SKILL.md` 中设计和实现 `time-svg-creator`
   技能，并附带支持文件 `reference.md`（SVG 模板 + 输出模板）和 `examples.md`
   （输入/输出示例对）。该技能应该：
   - 从调用上下文接收时间值、时区和格式化字符串
   - 为迪拜创建一个独立的 SVG 时间卡片，显示当前时间
   - 将 SVG 写入 `agent-teams/output/dubai-time.svg`
   - 将 markdown 摘要写入 `agent-teams/output/output.md`
   - 使用提供的确切时间 — 永远不要重新获取
   - 将模板保存在 reference.md 中（带占位符的 SVG 标记、markdown
     输出模板）和 examples.md 中的示例对
   还要为输出文件创建 `agent-teams/output/` 目录。

所有三个团队成员都应该在共享任务列表中创建任务以
协调数据契约：智能体返回 {time, timezone, formatted}，
命令通过上下文传递它，技能使用它。
并行启动所有三个，因为组件是独立的 —
它们只需要就数据接口达成一致，而不需要等待彼此的
实现。
