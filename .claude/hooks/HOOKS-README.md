# HOOKS-README
包含钩子的所有详细信息、脚本和指令

## 钩子事件概览 - [官方 27 个钩子](https://code.claude.com/docs/en/hooks)
Claude Code 提供了几个在工作流不同点运行的钩子事件：

| # | Hook | 描述 | 选项 |
|:-:|------|-------------|---------|
| 1 | `PreToolUse` | 在工具调用之前运行（可以阻止它们） | `async`, `timeout: 5000`, `tool_use_id` |
| 2 | `PermissionRequest` | 当 Claude Code 向用户请求权限时运行 | `async`, `timeout: 5000`, `permission_suggestions` |
| 3 | `PostToolUse` | 在工具调用成功完成后运行 | `async`, `timeout: 5000`, `tool_response`, `tool_use_id` |
| 4 | `PostToolUseFailure` | 在工具调用失败后运行 | `async`, `timeout: 5000`, `error`, `is_interrupt`, `tool_use_id` |
| 5 | `UserPromptSubmit` | 在用户提交提示时运行，在 Claude 处理之前 | `async`, `timeout: 5000`, `prompt` |
| 6 | `Notification` | 当 Claude Code 发送通知时运行 | `async`, `timeout: 5000`, `notification_type`, `message`, `title` |
| 7 | `Stop` | 当 Claude Code 完成响应时运行 | `async`, `timeout: 5000`, `last_assistant_message`, `stop_hook_active` |
| 8 | `SubagentStart` | 当子智能体任务开始时运行 | `async`, `timeout: 5000`, `agent_id`, `agent_type` |
| 9 | `SubagentStop` | 当子智能体任务完成时运行 | `async`, `timeout: 5000`, `agent_id`, `agent_type`, `last_assistant_message`, `agent_transcript_path`, `stop_hook_active` |
| 10 | `PreCompact` | 在 Claude Code 即将运行压缩操作之前运行 | `async`, `timeout: 5000`, `once`, `compact_trigger` |
| 11 | `PostCompact` | 在 Claude Code 完成压缩操作后运行 | `async`, `timeout: 5000`, `compact_trigger` |
| 12 | `SessionStart` | 当 Claude Code 启动新会话或恢复现有会话时运行 | `async`, `timeout: 5000`, `once`, `agent_type`, `model`, `source` |
| 13 | `SessionEnd` | 当 Claude Code 会话结束时运行 | `async`, `timeout: 5000`, `once`, `reason` |
| 14 | `Setup` | 当 Claude Code 运行 /setup 命令进行项目初始化时运行 | `async`, `timeout: 30000` |
| 15 | `TeammateIdle` | 当团队成员智能体变为空闲时运行（实验性智能体团队） | `async`, `timeout: 5000`, `teammate_name`, `team_name` |
| 16 | `TaskCreated` | 通过 TaskCreate 工具创建任务时运行（实验性智能体团队） | `async`, `timeout: 5000`, `task_id`, `task_subject`, `task_description`, `teammate_name`, `team_name` |
| 17 | `TaskCompleted` | 当后台任务完成时运行（实验性智能体团队） | `async`, `timeout: 5000`, `task_id`, `task_subject`, `task_description`, `teammate_name`, `team_name` |
| 18 | `ConfigChange` | 当配置文件在会话期间更改时运行 | `async`, `timeout: 5000`, `file_path`, `source` |
| 19 | `WorktreeCreate` | 当智能体工作树隔离为自定义 VCS 设置创建工作树时运行 | `async`, `timeout: 5000`, `worktree_path`, `worktree_name`, `base_branch` |
| 20 | `WorktreeRemove` | 当智能体工作树隔离为自定义 VCS 拆除移除工作树时运行 | `async`, `timeout: 5000`, `worktree_path`, `worktree_name` |
| 21 | `InstructionsLoaded` | 当 CLAUDE.md 或 `.claude/rules/*.md` 文件加载到上下文时运行 | `async`, `timeout: 5000`, `file_path`, `memory_type`, `load_reason`, `globs`, `trigger_file_path`, `parent_file_path` |
| 22 | `Elicitation` | 当 MCP 服务器在工具调用期间请求用户输入时运行 | `async`, `timeout: 5000`, `mcp_server_name`, `tool_name`, `form_fields` |
| 23 | `ElicitationResult` | 在用户响应 MCP 引导后、响应发送回服务器之前运行 | `async`, `timeout: 5000`, `mcp_server_name`, `tool_name`, `user_response`, `form_fields` |
| 24 | `StopFailure` | 当由于 API 错误（速率限制、身份验证失败等）而结束回合时运行 | `async`, `timeout: 5000`, `error`, `error_details`, `last_assistant_message` |
| 25 | `CwdChanged` | 当工作目录在会话期间更改时运行（响应式环境管理，例如 direnv） | `async`, `timeout: 5000`, `old_cwd`, `new_cwd` |
| 26 | `FileChanged` | 当监视的文件在会话期间更改时运行（响应式环境管理，例如 direnv）。**需要使用管道分隔的基名的 `matcher`**（例如 `.envrc\|.env`）来指定要监视的文件 | `async`, `timeout: 5000`, `file_path`, `change_type` |
| 27 | `PermissionDenied` | 在自动模式分类器拒绝工具调用后运行。返回 `{retry: true}` 告诉模型它可以重试 | `async`, `timeout: 5000`, `tool_name`, `tool_input`, `tool_use_id`, `reason` |

> **注意：** 钩子 15-17（`TeammateIdle`、`TaskCreated` 和 `TaskCompleted`）需要实验性智能体团队功能。启动 Claude Code 时设置 `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` 以启用它们。

### 未在官方文档中

以下项目存在于 [Claude Code 更新日志](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md) 中，但**未列在** [官方钩子参考](https://code.claude.com/docs/en/hooks) 中：

| 项目 | 添加于 | 更新日志参考 | 注释 |
|------|----------|-------------------|-------|
| `Setup` 钩子 | [v2.1.10](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md#2110) | "添加了新的 Setup 钩子事件，可以通过 `--init`、`--init-only` 或 `--maintenance` CLI 标志触发，用于仓库设置和维护操作" | 未列在官方钩子参考页面（列出了 26 个钩子，排除了 Setup） |
| 智能体前置元数据钩子 | [v2.1.0](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md#210) | "为智能体前置元数据添加了钩子支持，允许智能体定义范围限定在智能体生命周期的 PreToolUse、PostToolUse 和 Stop 钩子" | 更新日志仅提到 3 个钩子，但测试确认智能体会话中实际触发 **6 个钩子**：PreToolUse、PostToolUse、PermissionRequest、PostToolUseFailure、Stop、SubagentStop。并非所有 27 个钩子都受支持。 |

## 先决条件

在使用钩子之前，确保您的系统上安装了 **Python 3**。

### 所需软件

#### 所有平台（Windows、macOS、Linux）
- **Python 3**：运行钩子脚本所需
- 验证安装：`python3 --version`

**安装说明：**
- **Windows**：从 [python.org](https://www.python.org/downloads/) 下载或通过 `winget install Python.Python.3` 安装
- **macOS**：通过 `brew install python3` 安装（需要 [Homebrew](https://brew.sh/)）
- **Linux**：通过 `sudo apt install python3`（Ubuntu/Debian）或 `sudo yum install python3`（RHEL/CentOS）安装

### 音频播放器（可选 - 自动检测）

钩子脚本自动检测并使用适合您平台的音频播放器：

- **macOS**：使用 `afplay`（内置，无需安装）
- **Linux**：使用 `pulseaudio-utils` 中的 `paplay` - 通过 `sudo apt install pulseaudio-utils` 安装
- **Windows**：使用内置的 `winsound` 模块（包含在 Python 中）

### 钩子的执行方式

钩子在 `.claude/settings.json` 中配置为直接使用 Python 3 运行：

```json
{
  "type": "command",
  "command": "python3 .claude/hooks/scripts/hooks.py"
}
```

## 配置钩子（启用/禁用）

钩子可以在全局和个别级别轻松启用或禁用。

### 一次性禁用所有钩子

编辑 `.claude/settings.local.json` 并设置：
```json
{
  "disableAllHooks": true
}
```

**注意：** `.claude/settings.local.json` 文件被 git 忽略，因此每个用户可以配置自己的钩子偏好，而不影响团队在 `.claude/settings.json` 中的共享设置。

> **托管设置：** 如果管理员通过托管策略设置配置了钩子，在用户、项目或本地设置中设置的 `disableAllHooks` 无法禁用这些托管钩子（在 v2.1.49 中修复）。

### 禁用单个钩子

为了精细控制，您可以通过编辑钩子配置文件来禁用特定钩子。

#### 配置文件

有两个用于管理单个钩子的配置文件：

1. **`.claude/hooks/config/hooks-config.json`** - 提交到 git 的共享/默认配置
2. **`.claude/hooks/config/hooks-config.local.json`** - 您的个人覆盖（git 忽略）

本地配置文件（`.local.json`）优先于共享配置，允许每个开发人员自定义其钩子行为而不影响团队。

#### 共享配置

编辑 `.claude/hooks/config/hooks-config.json` 以设置团队范围的默认值：

```json
{
  "disableLogging": false,
  "disablePreToolUseHook": false,
  "disablePermissionRequestHook": false,
  "disablePostToolUseHook": false,
  "disablePostToolUseFailureHook": false,
  "disableUserPromptSubmitHook": false,
  "disableNotificationHook": false,
  "disableStopHook": false,
  "disableSubagentStartHook": false,
  "disableSubagentStopHook": false,
  "disablePreCompactHook": false,
  "disablePostCompactHook": false,
  "disableElicitationHook": false,
  "disableElicitationResultHook": false,
  "disableStopFailureHook": false,
  "disableSessionStartHook": false,
  "disableSessionEndHook": false,
  "disableSetupHook": false,
  "disableTeammateIdleHook": false,
  "disableTaskCompletedHook": false,
  "disableConfigChangeHook": false,
  "disableWorktreeCreateHook": false,
  "disableWorktreeRemoveHook": false,
  "disableInstructionsLoadedHook": false,
  "disableCwdChangedHook": false,
  "disableFileChangedHook": false,
  "disablePermissionDeniedHook": false
}
```

**配置选项：**
- `disableLogging`：设置为 `true` 以禁用将钩子事件记录到 `.claude/hooks/logs/hooks-log.jsonl`（用于防止日志文件增长）

#### 本地配置（个人覆盖）

创建或编辑 `.claude/hooks/config/hooks-config.local.json` 以设置个人偏好：

```json
{
  "disableLogging": true,
  "disablePostToolUseHook": true,
  "disableSessionStartHook": true
}
```

在此示例中，禁用了日志记录，并在本地覆盖了 PostToolUse 和 SessionStart 钩子。所有其他钩子将使用共享配置值。

**注意：** 单个钩子切换由钩子脚本（`.claude/hooks/scripts/hooks.py`）检查。本地设置覆盖共享设置，如果钩子被禁用，脚本将静默退出，不播放任何声音或执行钩子逻辑。

### 文本转语音（TTS）
用于生成声音的网站：https://elevenlabs.io/
使用的语音：Samara X

## 智能体前置元数据钩子

Claude Code 2.1.0 引入了对智能体前置元数据文件中定义的智能体特定钩子的支持。这些钩子仅在智能体的生命周期内运行，并支持钩子事件的子集。

### 支持的智能体钩子

智能体前置元数据钩子支持 **6 个钩子**（不是全部 27 个）。更新日志最初仅提到 3 个，但测试确认智能体会话中实际触发 6 个钩子：
- `PreToolUse`：在智能体使用工具之前运行
- `PostToolUse`：在智能体完成工具使用后运行
- `PermissionRequest`：当工具需要用户权限时运行
- `PostToolUseFailure`：在工具调用失败后运行
- `Stop`：当智能体完成时运行
- `SubagentStop`：当子智能体完成时运行

> **注意：** [v2.1.0 更新日志](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md#210) 仅提到 3 个钩子：*"为智能体前置元数据添加了钩子支持，允许智能体定义范围限定在智能体生命周期的 PreToolUse、PostToolUse 和 Stop 钩子"*。然而，使用 `claude-code-hook-agent` 的测试确认智能体会话中实际触发 6 个钩子。其余 21 个钩子（例如，Notification、SessionStart、SessionEnd 等）不在智能体上下文中触发。
>
> **更新（2026 年 2 月）：** [官方钩子参考](https://code.claude.com/docs/en/hooks) 现在声明技能/智能体前置元数据钩子*"支持所有钩子事件"*。这可能意味着支持已扩展到最初测试的 6 个钩子之外。建议重新测试以验证智能体会话中现在是否触发其他钩子。

### 智能体声音文件夹

智能体特定的声音存储在单独的文件夹中：
- `.claude/hooks/sounds/agent_pretooluse/`
- `.claude/hooks/sounds/agent_posttooluse/`
- `.claude/hooks/sounds/agent_permissionrequest/`
- `.claude/hooks/sounds/agent_posttoolusefailure/`
- `.claude/hooks/sounds/agent_stop/`
- `.claude/hooks/sounds/agent_subagentstop/`

### 创建带钩子的智能体

1. 在 `.claude/agents/` 中创建智能体定义文件：

```markdown
---
name: my-agent
description: Description of what this agent does
hooks:
  PreToolUse:
    - type: command
      command: python3 ${CLAUDE_PROJECT_DIR}/.claude/hooks/scripts/hooks.py --agent=my-agent
      timeout: 5000
      async: true
      statusMessage: PreToolUse
  PostToolUse:
    - type: command
      command: python3 ${CLAUDE_PROJECT_DIR}/.claude/hooks/scripts/hooks.py --agent=my-agent
      timeout: 5000
      async: true
      statusMessage: PostToolUse
  PermissionRequest:
    - type: command
      command: python3 ${CLAUDE_PROJECT_DIR}/.claude/hooks/scripts/hooks.py --agent=my-agent
      timeout: 5000
      async: true
      statusMessage: PermissionRequest
  PostToolUseFailure:
    - type: command
      command: python3 ${CLAUDE_PROJECT_DIR}/.claude/hooks/scripts/hooks.py --agent=my-agent
      timeout: 5000
      async: true
      statusMessage: PostToolUseFailure
  Stop:
    - type: command
      command: python3 ${CLAUDE_PROJECT_DIR}/.claude/hooks/scripts/hooks.py --agent=my-agent
      timeout: 5000
      async: true
      statusMessage: Stop
  SubagentStop:
    - type: command
      command: python3 ${CLAUDE_PROJECT_DIR}/.claude/hooks/scripts/hooks.py --agent=my-agent
      timeout: 5000
      async: true
      statusMessage: SubagentStop
---

Your agent instructions here...
```

2. 将声音文件添加到智能体声音文件夹：
   - `agent_pretooluse/agent_pretooluse.wav`
   - `agent_posttooluse/agent_posttooluse.wav`
   - `agent_permissionrequest/agent_permissionrequest.wav`
   - `agent_posttoolusefailure/agent_posttoolusefailure.wav`
   - `agent_stop/agent_stop.wav`
   - `agent_subagentstop/agent_subagentstop.wav`

### 示例：天气获取器智能体

请参阅 `.claude/agents/claude-code-hook-agent.md` 以获取配置了钩子的智能体的完整示例。

### 钩子选项：`once: true`

`once: true` 选项确保钩子每个会话仅运行一次：

```json
{
  "type": "command",
  "command": "python3 .claude/hooks/scripts/hooks.py",
  "timeout": 5000,
  "once": true
}
```

这对于像 `SessionStart`、`SessionEnd` 和 `PreCompact` 这样应该只触发一次的钩子很有用。

> **注意：** `once` 选项**仅适用于技能，不适用于智能体**。它在基于设置的钩子和技能前置元数据中有效，但在智能体前置元数据钩子中不受支持。

### 钩子选项：`async: true`

钩子可以通过添加 `"async": true` 在后台运行而不阻塞 Claude Code 的执行：

```json
{
  "type": "command",
  "command": "python3 .claude/hooks/scripts/hooks.py",
  "timeout": 5000,
  "async": true
}
```

**何时使用异步钩子：**
- 日志记录和分析
- 通知和声音效果
- 任何不应减慢 Claude Code 速度的副作用

此项目对所有钩子使用 `async: true`，因为声音通知是不需要阻塞执行的副作用。`timeout` 指定异步钩子在终止之前可以运行多长时间。

### 钩子选项：`asyncRewake`（自 v2.1.72 起，未记录）

`asyncRewake` 选项将异步执行与在失败时唤醒模型的能力结合起来：

```json
{
  "type": "command",
  "command": "python3 .claude/hooks/scripts/hooks.py",
  "asyncRewake": true
}
```

当 `asyncRewake` 为 `true` 时，钩子在后台运行（隐含 `async`），但如果它以代码 2（阻塞错误）退出，它会唤醒模型来处理错误。这对于通常不阻塞但需要显示关键故障的钩子很有用。在设置架构 `propertyNames` 中发现 — 尚未在官方文档中。

### 钩子选项：`statusMessage`

`statusMessage` 字段设置在钩子运行时向用户显示的自定义进度消息：

```json
{
  "type": "command",
  "command": "python3 .claude/hooks/scripts/hooks.py",
  "timeout": 5000,
  "async": true,
  "statusMessage": "PreToolUse"
}
```

此项目在所有钩子上将 `statusMessage` 设置为钩子事件名称，因此进度指示器会短暂显示哪个钩子正在触发（例如，"PreToolUse"、"SessionStart"、"Stop"）。这对于同步钩子最明显；对于异步钩子，消息会在钩子在后台运行之前短暂闪现。

### 钩子选项：`if`（自 v2.1.85 起）

`if` 字段使用权限规则语法为钩子添加条件执行。设置后，仅当条件匹配时才生成钩子进程 — 减少不必要的进程生成：

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "command": "./validate-git.sh",
        "if": "Bash(git *)"
      }]
    }]
  }
}
```

**关键详情：**
- 使用权限规则语法：`Bash(git *)`、`Edit(*.ts)`、`mcp__.*`
- 仅适用于工具事件钩子：`PreToolUse`、`PostToolUse`、`PostToolUseFailure`、`PermissionRequest`
- 在处理器级别设置（每个处理器的粒度），而不是在匹配器级别
- 没有 `if`，钩子进程在每次匹配器匹配时生成 — 有 `if`，它仅在条件也匹配时生成
- 此项目不使用 `if`，因为所有钩子都会触发声音播放，无论工具参数如何

## 钩子类型

Claude Code 支持四种钩子处理器类型。此项目对所有声音播放使用 `command` 钩子。

### `type: "command"`（此项目使用）

运行 shell 命令。通过 stdin 接收 JSON 输入，通过退出代码和 stdout 传达结果。

```json
{
  "type": "command",
  "command": "python3 .claude/hooks/scripts/hooks.py",
  "timeout": 5000,
  "async": true
}
```

### `type: "prompt"`

向 Claude 模型发送提示以进行单轮评估。模型以 JSON（`{"ok": true/false, "reason": "..."}`）返回是/否决定。对于需要判断而不是确定性规则的决策很有用。

```json
{
  "type": "prompt",
  "prompt": "Check if all tasks are complete. $ARGUMENTS",
  "timeout": 30
}
```

**支持的事件：** PreToolUse、PostToolUse、PostToolUseFailure、PermissionRequest、UserPromptSubmit、Stop、SubagentStop、TaskCreated、TaskCompleted。**仅命令事件（prompt/agent 类型不支持）：** ConfigChange、CwdChanged、Elicitation、ElicitationResult、FileChanged、InstructionsLoaded、Notification、PermissionDenied、PostCompact、PreCompact、SessionEnd、SessionStart、Setup、StopFailure、SubagentStart、TeammateIdle、WorktreeCreate、WorktreeRemove。

### `type: "agent"`

生成具有多轮工具访问权限（Read、Grep、Glob）的子智能体，在返回决定之前验证条件。与提示钩子相同的响应格式。当验证需要检查实际文件或测试输出时很有用。

```json
{
  "type": "agent",
  "prompt": "Verify that all unit tests pass. $ARGUMENTS",
  "timeout": 120
}
```

### `type: "http"`（自 v2.1.63 起）

将 JSON POST 到 URL 并接收 JSON 响应，而不是运行 shell 命令。对于与外部服务或 webhook 集成很有用。启用沙箱时，HTTP 钩子通过沙箱网络代理路由。

```json
{
  "type": "http",
  "url": "http://localhost:8080/hooks/pre-tool-use",
  "timeout": 30,
  "headers": {
    "Authorization": "Bearer $MY_TOKEN"
  },
  "allowedEnvVars": ["MY_TOKEN"]
}
```

**不支持：** ConfigChange、CwdChanged、Elicitation、ElicitationResult、FileChanged、InstructionsLoaded、Notification、PermissionDenied、PostCompact、PreCompact、SessionEnd、SessionStart、Setup、StopFailure、SubagentStart、TeammateIdle、WorktreeCreate、WorktreeRemove（仅命令事件）。标头支持使用 `$VAR_NAME` 进行环境变量插值，但仅适用于 `allowedEnvVars` 中明确列出的变量。

## 环境变量

Claude Code 为钩子脚本提供这些环境变量：

| 变量 | 可用性 | 描述 |
|----------|-------------|-------------|
| `$CLAUDE_PROJECT_DIR` | 所有钩子 | 项目根目录。对于带空格的路径用引号括起来 |
| `$CLAUDE_ENV_FILE` | SessionStart、CwdChanged、FileChanged | 用于为后续 Bash 命令持久化环境变量的文件路径。使用追加（`>>`）以保留其他钩子的变量 |
| `${CLAUDE_PLUGIN_ROOT}` | 插件钩子 | 插件的根目录，用于与插件捆绑的脚本 |
| `$CLAUDE_CODE_REMOTE` | 所有钩子 | 在远程 Web 环境中设置为 `"true"`，在本地 CLI 中未设置 |
| `${CLAUDE_SKILL_DIR}` | 技能钩子 | 技能自己的目录，用于与技能捆绑的脚本（自 v2.1.69 起） |
| `${CLAUDE_PLUGIN_DATA}` | 插件钩子 | 插件的持久数据目录，在插件更新后仍然存在（自 v2.1.78 起） |
| `CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS` | SessionEnd 钩子 | 以毫秒为单位覆盖 SessionEnd 钩子超时。在 v2.1.74 之前，SessionEnd 钩子在 1.5 秒后被终止，无论配置的 `timeout` 如何。现在遵守钩子的 `timeout` 值，或者如果设置了此环境变量（自 v2.1.74 起） |
| `session_id`（通过 stdin JSON） | 所有钩子 | 当前会话 ID，作为 stdin 上 JSON 输入的一部分接收（不是环境变量） |

### 常见输入字段（stdin JSON）

每个钩子在 stdin 上接收一个包含这些常见字段的 JSON 对象，以及上面选项列中列出的任何钩子特定字段：

| 字段 | 类型 | 描述 |
|-------|------|-------------|
| `hook_event_name` | string | 触发的钩子事件的名称（例如，`"PreToolUse"`、`"Stop"`） |
| `session_id` | string | 当前会话标识符 |
| `transcript_path` | string | 对话记录 JSON 文件的路径 |
| `cwd` | string | 当前工作目录 |
| `permission_mode` | string | 当前权限模式：`default`、`plan`、`acceptEdits`、`dontAsk` 或 `bypassPermissions` |
| `agent_id` | string | 唯一的子智能体标识符。当钩子在子智能体上下文内触发时存在（自 v2.1.69 起） |
| `agent_type` | string | 智能体类型名称（例如 `Bash`、`Explore`、`Plan` 或自定义）。在使用 `--agent <name>` 标志或在子智能体内部时存在（自 v2.1.69 起） |

> **注意：** 钩子特定字段（例如，PreToolUse 的 `tool_name`、Stop 的 `last_assistant_message`）在上面的[钩子事件概览](#钩子事件概览---官方-27-个钩子)表的选项列中列出。

## 钩子管理命令

Claude Code 提供了用于管理钩子的内置命令：

- **`/hooks`** — 交互式钩子管理 UI。查看、添加和删除钩子，无需编辑 JSON 文件。钩子按来源标记：`[User]`、`[Project]`、`[Local]`、`[Plugin]`。您还可以从此菜单切换 `disableAllHooks`。
- **`claude hooks reload`** — 重新加载钩子配置而不重新启动会话。在编辑设置文件后很有用（自 v2.0.47 起）。

## MCP 工具匹配器

对于 `PreToolUse`、`PostToolUse` 和 `PermissionRequest` 钩子，您可以使用模式 `mcp__<server>__<tool>` 匹配 MCP（模型上下文协议）工具：

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "mcp__memory__.*",
      "hooks": [{ "type": "command", "command": "echo 'MCP memory tool used'" }]
    }]
  }
}
```

支持完整的正则表达式：`mcp__memory__.*`（来自 memory 服务器的所有工具）、`mcp__.*__write.*`（来自任何服务器的任何写入工具）。

### 每个钩子的匹配器参考

匹配器过滤哪些事件触发钩子。并非所有钩子都支持匹配器 — 不支持匹配器的钩子始终触发。

| 钩子 | 匹配器字段 | 可能的值 | 示例 |
|------|--------------|-----------------|---------|
| `PreToolUse` | `tool_name` | 任何工具名称：`Bash`、`Read`、`Edit`、`Write`、`Glob`、`Grep`、`Agent`、`WebFetch`、`WebSearch`、`AskUserQuestion`、`ExitPlanMode`、`mcp__*` | `"matcher": "Bash"` |
| `PermissionRequest` | `tool_name` | Same as PreToolUse | `"matcher": "mcp__memory__.*"` |
| `PostToolUse` | `tool_name` | Same as PreToolUse | `"matcher": "Write"` |
| `PostToolUseFailure` | `tool_name` | Same as PreToolUse | `"matcher": "Bash"` |
| `Notification` | `notification_type` | `permission_prompt`, `idle_prompt`, `auth_success`, `elicitation_dialog` | `"matcher": "permission_prompt"` |
| `SubagentStart` | `agent_type` | `Bash`, `Explore`, `Plan`, or custom agent name | `"matcher": "Bash"` |
| `SubagentStop` | `agent_type` | `Bash`, `Explore`, `Plan`, or custom agent name | `"matcher": "Bash"` |
| `SessionStart` | `source` | `startup`, `resume`, `clear`, `compact` | `"matcher": "startup"` |
| `SessionEnd` | `reason` | `clear`, `resume`, `logout`, `prompt_input_exit`, `bypass_permissions_disabled`, `other` | `"matcher": "logout"` |
| `PreCompact` | `compact_trigger` | `manual`, `auto` | `"matcher": "auto"` |
| `PostCompact` | `compact_trigger` | `manual`, `auto` | `"matcher": "manual"` |
| `Elicitation` | `mcp_server_name` | MCP server name | `"matcher": "my-mcp-server"` |
| `ElicitationResult` | `mcp_server_name` | MCP server name | `"matcher": "my-mcp-server"` |
| `ConfigChange` | `source` | `user_settings`, `project_settings`, `local_settings`, `policy_settings`, `skills` | `"matcher": "project_settings"` |
| `UserPromptSubmit` | — | No matcher support | Always fires |
| `Stop` | — | No matcher support | Always fires |
| `TeammateIdle` | — | No matcher support | Always fires |
| `TaskCreated` | — | No matcher support | Always fires |
| `TaskCompleted` | — | No matcher support | Always fires |
| `WorktreeCreate` | — | No matcher support | Always fires |
| `WorktreeRemove` | — | No matcher support | Always fires |
| `InstructionsLoaded` | `load_reason` | `session_start`, `nested_traversal`, `path_glob_match`, `include`, `compact` | `"matcher": "session_start"` |
| `StopFailure` | `error` | `rate_limit`, `authentication_failed`, `billing_error`, `invalid_request`, `server_error`, `max_output_tokens`, `unknown` | `"matcher": "rate_limit"` |
| `CwdChanged` | — | No matcher support | Always fires |
| `FileChanged` | `filename` (basename) | Pipe-separated basenames: `.envrc`, `.env`, `.env.local` | `"matcher": ".envrc\|.env"` |
| `Setup` | — | No matcher support | Always fires |
| `PermissionDenied` | `tool_name` | Tool names (same as PreToolUse) | `"matcher": "Bash"` |

## Known Issues & Workarounds

### Agent Stop Hook Bug (SubagentStop vs Stop)

**Bug Report:** [GitHub Issue #19220](https://github.com/anthropics/claude-code/issues/19220)

**Issue:** When defining a `Stop` hook in an agent's frontmatter, the `hook_event_name` passed to the hook script is `"SubagentStop"` instead of `"Stop"`. This contradicts the official documentation and breaks consistency with other agent hooks (`PreToolUse` and `PostToolUse`), which correctly pass their configured names.

| Hook | Defined As | Received As | Status |
|------|------------|-------------|--------|
| PreToolUse | `PreToolUse:` | `"PreToolUse"` | ✅ Correct |
| PostToolUse | `PostToolUse:` | `"PostToolUse"` | ✅ Correct |
| Stop | `Stop:` | `"SubagentStop"` | ❌ Inconsistent |

**Status:** The [official hooks reference](https://code.claude.com/docs/en/hooks#hooks-in-skills-and-agents) now documents this as expected behavior: *"For subagents, Stop hooks are automatically converted to SubagentStop since that is the event that fires when a subagent completes."* This project handles it via the `AGENT_HOOK_SOUND_MAP` in `hooks.py`, which has a separate `SubagentStop` entry that maps to the `agent_subagentstop` sound folder.

### PreToolUse `updatedInput` for AskUserQuestion (since v2.1.85)

When a `PreToolUse` hook matches `AskUserQuestion`, it can return `updatedInput` to auto-respond to the question — enabling headless integrations to programmatically answer user questions without manual input:

```json
{
  "hookSpecificOutput": {
    "updatedInput": {
      "question": "Do you want to proceed?",
      "answer": "yes"
    }
  }
}
```

This is useful for CI/CD pipelines, automated testing, or any context where Claude Code runs without a human at the terminal. Not yet in official docs pages — sourced from GitHub changelog v2.1.85.

### PreToolUse Decision Control Deprecation

The `PreToolUse` hook previously used top-level `decision` and `reason` fields for blocking tool calls. These are now **deprecated**. Use `hookSpecificOutput.permissionDecision` and `hookSpecificOutput.permissionDecisionReason` instead:

| Deprecated | Current |
|-----------|---------|
| `"decision": "approve"` | `"hookSpecificOutput": { "permissionDecision": "allow" }` |
| `"decision": "block"` | `"hookSpecificOutput": { "permissionDecision": "deny" }` |

This does not affect this project since `hooks.py` uses async sound playback and does not use decision control.

## Decision Control Patterns

Different hooks use different output schemas for blocking or controlling execution. This project does not use decision control (all hooks are async sound playback), but for reference:

| Hook(s) | Control Method | Values |
|---------|---------------|--------|
| PreToolUse | `hookSpecificOutput.permissionDecision` | `allow`, `deny`, `ask`, `defer` (headless `-p` mode only, v2.1.89+) |
| PreToolUse | `hookSpecificOutput.autoAllow` | `true` — auto-approve future uses of this tool (since v2.0.76) |
| PermissionRequest | `hookSpecificOutput.decision.behavior` | `allow`, `deny` |
| Stop, SubagentStop, ConfigChange | Top-level `decision` | `block` |
| TeammateIdle, TaskCreated, TaskCompleted | `continue` + exit code 2 | `{"continue": false, "stopReason": "..."}` — JSON decision control added in v2.1.70. TaskCreated also uses exit code 2 to block task creation (stderr fed back to model) |
| UserPromptSubmit | Can modify `prompt` field | Returns modified prompt via stdout |
| WorktreeCreate | Non-zero exit + stdout path | Non-zero exit fails creation; stdout provides worktree path |
| Elicitation | `hookSpecificOutput.action` + `hookSpecificOutput.content` | `accept`, `decline`, `cancel` — control MCP elicitation response |
| ElicitationResult | `hookSpecificOutput.action` + `hookSpecificOutput.content` | `accept`, `decline`, `cancel` — override user response before sending to server |
| PermissionDenied | `hookSpecificOutput.retry` | `true` — signal that model may retry the denied tool call (v2.1.89+) |

### Universal JSON Output Fields

All hooks can return these fields via stdout JSON:

| Field | Type | Description |
|-------|------|-------------|
| `continue` | bool | If `false`, stops Claude entirely |
| `stopReason` | string | Message shown when `continue` is false |
| `suppressOutput` | bool | Hides stdout from verbose mode |
| `systemMessage` | string | Warning message shown to user |
| `additionalContext` | string | Context added to Claude's conversation |

## Hook Deduplication & External Changes

- **Hook deduplication:** Identical hook handlers defined in multiple settings locations run only once in parallel, preventing duplicate execution.
- **External change detection:** Claude Code warns when hooks are modified externally (e.g., by another process editing settings files) during an active session.