# 命令最佳实践

![Last Updated](https://img.shields.io/badge/Last_Updated-Apr%2009%2C%202026%2011%3A31%20PM%20PKT-white?style=flat&labelColor=555) ![Version](https://img.shields.io/badge/Claude_Code-v2.1.97-blue?style=flat&labelColor=555)<br>
[![Implemented](https://img.shields.io/badge/Implemented-2ea44f?style=flat)](../implementation/claude-commands-implementation.md)

Claude Code 命令 — 前置元数据字段和官方内置斜杠命令。

<table width="100%">
<tr>
<td><a href="../">← 返回 Claude Code 最佳实践</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

## 前置元数据字段 (13)

| 字段 | 类型 | 必需 | 描述 |
|-------|------|----------|-------------|
| `name` | string | 否 | 显示名称和 `/斜杠命令` 标识符。如果省略则默认为目录名 |
| `description` | string | 推荐 | 命令的功能。在自动完成中显示,并由 Claude 用于自动发现 |
| `argument-hint` | string | 否 | 自动完成期间显示的提示(例如 `[issue-number]`、`[filename]`) |
| `disable-model-invocation` | boolean | 否 | 设置为 `true` 以防止 Claude 自动调用此命令 |
| `user-invocable` | boolean | 否 | 设置为 `false` 以从 `/` 菜单中隐藏 — 命令仅作为背景知识 |
| `paths` | string/list | 否 | 限制此技能激活时机的 Glob 模式。接受逗号分隔的字符串或 YAML 列表。设置后,Claude 仅在处理匹配模式的文件时自动加载该技能 |
| `allowed-tools` | string | 否 | 此命令激活时无需权限提示即可使用的工具 |
| `model` | string | 否 | 此命令运行时使用的模型(例如 `haiku`、`sonnet`、`opus`) |
| `effort` | string | 否 | 调用时覆盖模型努力级别(`low`、`medium`、`high`、`max`) |
| `context` | string | 否 | 设置为 `fork` 以在隔离的子代理上下文中运行命令 |
| `agent` | string | 否 | 设置 `context: fork` 时的子代理类型(默认:`general-purpose`) |
| `shell` | string | 否 | `` !`command` `` 块的 Shell — 接受 `bash`(默认)或 `powershell`。需要 `CLAUDE_CODE_USE_POWERSHELL_TOOL=1` |
| `hooks` | object | 否 | 作用域限定于此命令的生命周期钩子 |

---

## ![Official](../!/tags/official.svg) **(68)**

| # | 命令 | 标签 | 描述 |
|---|---------|-----|-------------|
| 1 | `/login` | ![Auth](https://img.shields.io/badge/Auth-2980B9?style=flat) | 登录到您的 Anthropic 账户 |
| 2 | `/logout` | ![Auth](https://img.shields.io/badge/Auth-2980B9?style=flat) | 从您的 Anthropic 账户注销 |
| 3 | `/setup-bedrock` | ![Auth](https://img.shields.io/badge/Auth-2980B9?style=flat) | 通过交互式向导配置 Amazon Bedrock 身份验证、区域和模型固定。仅在设置 `CLAUDE_CODE_USE_BEDROCK=1` 时可见。首次使用 Bedrock 的用户也可以从登录屏幕访问此向导 |
| 4 | `/upgrade` | ![Auth](https://img.shields.io/badge/Auth-2980B9?style=flat) | 打开升级页面以切换到更高的计划层级 |
| 5 | `/color [color\|default]` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 为当前会话设置提示栏颜色。可用颜色:`red`、`blue`、`green`、`yellow`、`purple`、`orange`、`pink`、`cyan`。使用 `default` 重置 |
| 6 | `/config` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 打开设置界面以调整主题、模型、输出样式和其他偏好设置。别名:`/settings` |
| 7 | `/keybindings` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 打开或创建键绑定配置文件 |
| 8 | `/permissions` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 管理工具权限的允许、询问和拒绝规则。打开一个交互式对话框,您可以按作用域查看规则、添加或删除规则、管理工作目录以及查看最近的自动模式拒绝。别名:`/allowed-tools` |
| 9 | `/privacy-settings` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 查看和更新隐私设置。仅适用于 Pro 和 Max 计划订阅者 |
| 10 | `/sandbox` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 切换沙盒模式。仅在支持的平台上可用 |
| 11 | `/statusline` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 配置 Claude Code 的状态行。描述您想要的内容,或不带参数运行以从 shell 提示符自动配置 |
| 12 | `/stickers` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 订购 Claude Code 贴纸 |
| 13 | `/terminal-setup` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 配置 Shift+Enter 和其他快捷键的终端键绑定。仅在需要它的终端中可见,如 VS Code、Alacritty 或 Warp |
| 14 | `/theme` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 更改颜色主题。包括明暗变体、色盲可访问(达尔顿化)主题以及使用终端调色板的 ANSI 主题 |
| 15 | `/voice` | ![Config](https://img.shields.io/badge/Config-F39C12?style=flat) | 切换按住说话的语音听写。需要 Claude.ai 账户 |
| 16 | `/context` | ![Context](https://img.shields.io/badge/Context-8E44AD?style=flat) | 将当前上下文使用情况可视化为彩色网格。显示上下文密集型工具、内存膨胀和容量警告的优化建议 |
| 17 | `/cost` | ![Context](https://img.shields.io/badge/Context-8E44AD?style=flat) | 显示令牌使用统计信息。有关订阅特定详细信息,请参阅成本跟踪指南 |
| 18 | `/extra-usage` | ![Context](https://img.shields.io/badge/Context-8E44AD?style=flat) | 配置额外使用量以在达到速率限制时继续工作 |
| 19 | `/insights` | ![Context](https://img.shields.io/badge/Context-8E44AD?style=flat) | 生成分析您的 Claude Code 会话的报告,包括项目领域、交互模式和摩擦点 |
| 20 | `/stats` | ![Context](https://img.shields.io/badge/Context-8E44AD?style=flat) | 可视化每日使用情况、会话历史记录、连续使用天数和模型偏好 |
| 21 | `/status` | ![Context](https://img.shields.io/badge/Context-8E44AD?style=flat) | 打开设置界面(状态选项卡),显示版本、模型、账户和连接性。在 Claude 响应时工作,无需等待当前响应完成 |
| 22 | `/usage` | ![Context](https://img.shields.io/badge/Context-8E44AD?style=flat) | 显示计划使用限制和速率限制状态 |
| 23 | `/doctor` | ![Debug](https://img.shields.io/badge/Debug-E74C3C?style=flat) | 诊断并验证您的 Claude Code 安装和设置 |
| 24 | `/feedback [report]` | ![Debug](https://img.shields.io/badge/Debug-E74C3C?style=flat) | 提交关于 Claude Code 的反馈。别名:`/bug` |
| 25 | `/help` | ![Debug](https://img.shields.io/badge/Debug-E74C3C?style=flat) | 显示帮助和可用命令 |
| 26 | `/powerup` | ![Debug](https://img.shields.io/badge/Debug-E74C3C?style=flat) | 通过带有动画演示的快速交互式课程发现 Claude Code 功能 |
| 27 | `/release-notes` | ![Debug](https://img.shields.io/badge/Debug-E74C3C?style=flat) | 在交互式版本选择器中查看更新日志。选择特定版本以查看其发行说明,或选择显示所有版本 |
| 28 | `/tasks` | ![Debug](https://img.shields.io/badge/Debug-E74C3C?style=flat) | 列出并管理后台任务。别名:`/bashes` |
| 29 | `/copy [N]` | ![Export](https://img.shields.io/badge/Export-7F8C8D?style=flat) | 将最后的助手响应复制到剪贴板。传递数字 `N` 以复制第 N 个最新响应:`/copy 2` 复制倒数第二个。当存在代码块时,显示交互式选择器以选择单个块或完整响应。在选择器中按 `w` 将选择内容写入文件而不是剪贴板,这在 SSH 上很有用 |
| 30 | `/export [filename]` | ![Export](https://img.shields.io/badge/Export-7F8C8D?style=flat) | 将当前对话导出为纯文本。使用文件名时,直接写入该文件。不使用时,打开一个对话框以复制到剪贴板或保存到文件 |
| 31 | `/agents` | ![Extensions](https://img.shields.io/badge/Extensions-16A085?style=flat) | 管理代理配置 |
| 32 | `/chrome` | ![Extensions](https://img.shields.io/badge/Extensions-16A085?style=flat) | 配置 Chrome 中的 Claude 设置 |
| 33 | `/hooks` | ![Extensions](https://img.shields.io/badge/Extensions-16A085?style=flat) | 查看工具事件的钩子配置 |
| 34 | `/ide` | ![Extensions](https://img.shields.io/badge/Extensions-16A085?style=flat) | 管理 IDE 集成并显示状态 |
| 35 | `/mcp` | ![Extensions](https://img.shields.io/badge/Extensions-16A085?style=flat) | 管理 MCP 服务器连接和 OAuth 身份验证 |
| 36 | `/plugin` | ![Extensions](https://img.shields.io/badge/Extensions-16A085?style=flat) | 管理 Claude Code 插件 |
| 37 | `/reload-plugins` | ![Extensions](https://img.shields.io/badge/Extensions-16A085?style=flat) | 重新加载所有活动插件以应用待处理的更改,无需重启。报告每个重新加载组件的计数并标记任何加载错误 |
| 38 | `/skills` | ![Extensions](https://img.shields.io/badge/Extensions-16A085?style=flat) | 列出可用技能 |
| 39 | `/memory` | ![Memory](https://img.shields.io/badge/Memory-3498DB?style=flat) | 编辑 `CLAUDE.md` 记忆文件,启用或禁用自动记忆,以及查看自动记忆条目 |
| 40 | `/effort [low\|medium\|high\|max\|auto]` | ![Model](https://img.shields.io/badge/Model-E67E22?style=flat) | 设置模型努力级别。`low`、`medium` 和 `high` 在会话之间持久化。`max` 仅适用于当前会话并需要 Opus 4.6。`auto` 重置为模型默认值。不带参数时显示当前级别。立即生效,无需等待当前响应完成 |
| 41 | `/fast [on\|off]` | ![Model](https://img.shields.io/badge/Model-E67E22?style=flat) | 开启或关闭快速模式 |
| 42 | `/model [model]` | ![Model](https://img.shields.io/badge/Model-E67E22?style=flat) | 选择或更改 AI 模型。对于支持的模型,使用左/右箭头调整努力级别。更改立即生效,无需等待当前响应完成 |
| 43 | `/passes` | ![Model](https://img.shields.io/badge/Model-E67E22?style=flat) | 与朋友分享一周免费的 Claude Code。仅在您的账户符合条件时可见 |
| 44 | `/plan [description]` | ![Model](https://img.shields.io/badge/Model-E67E22?style=flat) | 直接从提示符进入计划模式。传递可选描述以进入计划模式并立即开始该任务,例如 `/plan fix the auth bug` |
| 45 | `/ultraplan <prompt>` | ![Model](https://img.shields.io/badge/Model-E67E22?style=flat) | 在 ultraplan 会话中起草计划,在浏览器中查看,然后远程执行或发送回终端 |
| 46 | `/add-dir <path>` | ![Project](https://img.shields.io/badge/Project-27AE60?style=flat) | 在当前会话期间添加用于文件访问的工作目录。大多数 `.claude/` 配置不会从添加的目录中发现 |
| 47 | `/diff` | ![Project](https://img.shields.io/badge/Project-27AE60?style=flat) | 打开交互式差异查看器,显示未提交的更改和每轮差异。使用左/右箭头在当前 git diff 和单个 Claude 轮次之间切换,使用上/下浏览文件 |
| 48 | `/init` | ![Project](https://img.shields.io/badge/Project-27AE60?style=flat) | 使用 `CLAUDE.md` 指南初始化项目。设置 `CLAUDE_CODE_NEW_INIT=1` 以使用交互式流程,该流程还会引导完成技能、钩子和个人记忆文件 |
| 49 | `/review` | ![Project](https://img.shields.io/badge/Project-27AE60?style=flat) | 已弃用。请改为安装 `code-review` 插件:`claude plugin install code-review@claude-plugins-official` |
| 50 | `/security-review` | ![Project](https://img.shields.io/badge/Project-27AE60?style=flat) | 分析当前分支上的待处理更改是否存在安全漏洞。审查 git diff 并识别注入、身份验证问题和数据泄露等风险 |
| 51 | `/autofix-pr [prompt]` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 生成一个 Claude Code 网页会话,该会话监视当前分支的 PR,并在 CI 失败或审阅者留下评论时推送修复。使用 `gh pr view` 从您签出的分支检测打开的 PR;要监视不同的 PR,请先签出其分支。需要 `gh` CLI 和访问网页上的 Claude Code |
| 52 | `/desktop` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 在 Claude Code 桌面应用程序中继续当前会话。仅限 macOS 和 Windows。别名:`/app` |
| 53 | `/install-github-app` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 为仓库设置 Claude GitHub Actions 应用。引导您选择仓库并配置集成 |
| 54 | `/install-slack-app` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 安装 Claude Slack 应用。打开浏览器完成 OAuth 流程 |
| 55 | `/mobile` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 显示二维码以下载 Claude 移动应用。别名:`/ios`、`/android` |
| 56 | `/remote-control` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 使此会话可从 claude.ai 进行远程控制。别名:`/rc` |
| 57 | `/remote-env` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 配置使用 `--remote` 启动的网页会话的默认远程环境 |
| 58 | `/schedule [description]` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 创建、更新、列出或运行云计划任务。Claude 会对话式地引导您完成设置 |
| 59 | `/teleport` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 将网页上的 Claude Code 会话拉入此终端:打开一个选择器,然后获取分支和对话。也可用作 `/tp`。需要 claude.ai 订阅 |
| 60 | `/web-setup` | ![Remote](https://img.shields.io/badge/Remote-5D6D7E?style=flat) | 使用本地 `gh` CLI 凭据将您的 GitHub 账户连接到网页上的 Claude Code。如果未连接 GitHub,`/schedule` 会自动提示此操作 |
| 61 | `/branch [name]` | ![Session](https://img.shields.io/badge/Session-4A90D9?style=flat) | 在此时创建当前对话的分支。别名:`/fork` |
| 62 | `/btw <question>` | ![Session](https://img.shields.io/badge/Session-4A90D9?style=flat) | 提出一个快速的旁注问题,而不添加到对话中 |
| 63 | `/clear` | ![Session](https://img.shields.io/badge/Session-4A90D9?style=flat) | 清除对话历史并释放上下文。别名:`/reset`、`/new` |
| 64 | `/compact [instructions]` | ![Session](https://img.shields.io/badge/Session-4A90D9?style=flat) | 使用可选的焦点指令压缩对话 |
| 65 | `/exit` | ![Session](https://img.shields.io/badge/Session-4A90D9?style=flat) | 退出 CLI。别名:`/quit` |
| 66 | `/rename [name]` | ![Session](https://img.shields.io/badge/Session-4A90D9?style=flat) | 重命名当前会话并在提示栏上显示名称。不带名称时,从对话历史自动生成一个 |
| 67 | `/resume [session]` | ![Session](https://img.shields.io/badge/Session-4A90D9?style=flat) | 通过 ID 或名称恢复对话,或打开会话选择器。别名:`/continue` |
| 68 | `/rewind` | ![Session](https://img.shields.io/badge/Session-4A90D9?style=flat) | 将对话和/或代码倒回到先前的点,或从选定的消息进行总结。参见检查点。别名:`/checkpoint` |

捆绑的技能(如 `/debug`)也可以出现在斜杠命令菜单中,但它们不是内置命令。

---

## Sources

- [Claude Code Slash Commands](https://code.claude.com/docs/en/slash-commands)
- [Claude Code Interactive Mode](https://code.claude.com/docs/en/interactive-mode)
- [Claude Code CHANGELOG](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)
