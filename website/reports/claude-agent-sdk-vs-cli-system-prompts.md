# Claude Agent SDK vs Claude CLI: 系统提示和输出一致性

<table width="100%">
<tr>
<td><a href="../">← Back to Claude Code Best Practice</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

![SDK vs CLI System Prompts Diagram](assets/sdk-vs-cli-diagram.svg)

---

## 执行摘要

通过 **Claude Agent SDK** 与 **Claude CLI (Claude Code)** 发送相同消息(例如,"挪威的首都是什么?")时,伴随这些消息的系统提示根本不同。CLI 使用**模块化系统提示架构**(约269个基础令牌,根据功能条件性地加载额外上下文),而 SDK 默认使用最小提示。**即使配置匹配,两者之间也不能保证输出相同**,这是由于缺少种子参数以及 Claude 架构中固有的非确定性。

---

## 1. 系统提示比较

### Claude CLI (Claude Code)

Claude CLI 使用**模块化系统提示架构**,有约269个令牌的基础提示,并条件性地加载额外上下文:

| 组件 | 描述 | 加载 |
|-----------|-------------|---------|
| **基础系统提示** | 核心指令和行为 | 始终(约269个令牌) |
| **工具指令** | 18+个内置工具(Write, Read, Edit, Bash, TodoWrite等) | 始终 |
| **编码指南** | 代码风格、格式化规则、安全实践 | 始终 |
| **安全规则** | 拒绝规则、注入防御、伤害预防 | 始终 |
| **响应风格** | 语气、详细程度、解释深度、表情符号使用 | 始终 |
| **环境上下文** | 工作目录、git状态、平台信息 | 始终 |
| **项目上下文** | CLAUDE.md内容、设置、钩子配置 | 条件性 |
| **子代理提示** | 计划模式、探索代理、任务代理 | 条件性 |
| **安全审查** | 扩展安全指令(约2,610个令牌) | 条件性 |

**关键特征:**
- 具有110+个条件性加载的系统提示字符串的**模块化架构**
- 基础提示适度(约269个令牌),总数根据激活的功能而变化
- 包含广泛的安全和注入防御层
- 自动加载工作目录中的CLAUDE.md文件
- 交互模式下的会话持久上下文

### Claude Agent SDK

Agent SDK 默认使用**最小系统提示**,包含:

| 组件 | 描述 | 令牌影响 |
|-----------|-------------|--------------|
| **基本工具指令** | 仅明确提供的工具 | 最小 |
| **基本安全** | 最小安全指令 | 最小 |

**关键特征:**
- 默认无编码指南或风格偏好
- 除非明确配置,否则无项目上下文
- 无广泛的工具描述
- 需要明确配置以匹配CLI行为

---

## 2. 每个接口发送什么

### 示例:"挪威的首都是什么?"

#### 通过 Claude CLI

```
系统提示: [模块化,约269+个基础令牌]
├── 基础系统提示(约269个令牌)
├── 工具指令(Write, Read, Edit, Bash, Grep, Glob等)
├── Git安全协议
├── 代码引用指南
├── 专业客观性指令
├── 安全和注入防御规则
├── 环境上下文(OS、目录、日期)
├── CLAUDE.md内容(如果存在)[条件性]
├── MCP工具描述(如果配置)[条件性]
├── 计划/探索模式提示[条件性]
└── 会话/对话上下文

用户消息: "挪威的首都是什么?"
```

#### 通过 Claude Agent SDK(默认)

```
系统提示: [最小]
├── 基本工具指令(如果提供了任何工具)
└── 基本操作上下文

用户消息: "挪威的首都是什么?"
```

#### Via Agent SDK (with `claude_code` preset)

```typescript
const response = await query({
  prompt: "What is the capital of Norway?",
  options: {
    systemPrompt: {
      type: "preset",
      preset: "claude_code"
    }
  }
});
```

```
System Prompt: [modular, matches CLI]
├── Full Claude Code system prompt
├── Tool instructions
├── Coding guidelines
└── Safety rules

// NOTE: Still does NOT include CLAUDE.md unless settingSources is configured
```

---

## 3. Customization Methods

### Claude CLI Customization

| Method | Command | Effect |
|--------|---------|--------|
| **Append to prompt** | `claude -p "..." --append-system-prompt "..."` | Adds instructions while preserving defaults |
| **Replace prompt** | `claude -p "..." --system-prompt "..."` | Completely replaces the system prompt |
| **Project context** | CLAUDE.md file | Automatically loaded, persistent |
| **Output styles** | `/output-style [name]` | Apply predefined response styles |

### Agent SDK Customization

| Method | Configuration | Effect |
|--------|---------------|--------|
| **Custom prompt** | `systemPrompt: "..."` | Replaces default entirely (loses tools) |
| **Preset with append** | `systemPrompt: { type: "preset", preset: "claude_code", append: "..." }` | Preserves CLI functionality + custom instructions |
| **CLAUDE.md loading** | `settingSources: ["project"]` | Loads project-level instructions |
| **Output styles** | `settingSources: ["user"]` or `settingSources: ["project"]` | Loads saved output styles |

### Configuration Comparison Table

| Feature | CLI Default | SDK Default | SDK with Preset |
|---------|-------------|-------------|-----------------|
| Tool instructions | ✅ Full | ❌ Minimal | ✅ Full |
| Coding guidelines | ✅ Yes | ❌ No | ✅ Yes |
| Safety rules | ✅ Yes | ❌ Basic | ✅ Yes |
| CLAUDE.md auto-load | ✅ Yes | ❌ No | ❌ No* |
| Project context | ✅ Automatic | ❌ No | ❌ No* |

*Requires explicit `settingSources: ["project"]` configuration

---

## 4. 输出一致性保证

### 关键发现:不保证确定性

**Claude Messages API 不提供用于可重现性的种子参数。** 这是一个基本的架构限制。

### 阻止输出相同的因素

| 因素 | 描述 | 可控? |
|--------|-------------|---------------|
| **不同的系统提示** | CLI vs SDK有不同的默认值 | ✅ 是(通过配置) |
| **浮点运算** | 并行硬件怪癖 | ❌ 否 |
| **MoE路由** | 专家混合架构变化 | ❌ 否 |
| **批处理/调度** | 云基础设施差异 | ❌ 否 |
| **数值精度** | 推理引擎变化 | ❌ 否 |
| **模型快照** | 版本更新/更改 | ❌ 否 |

### 温度和采样

即使使用 `temperature=0.0`(贪婪解码):
- **不保证**完全确定性
- 由于基础设施因素,仍可能出现轻微变化
- 已知bug:[Claude CLI对相同输入产生非确定性输出](https://github.com/anthropics/claude-code/issues/3370)

---

## 5. Achieving Maximum Consistency

To get the **closest possible** identical outputs between SDK and CLI:

### Agent SDK Configuration

```typescript
import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic();

// Option 1: Use claude_code preset
const response = await client.messages.create({
  model: "claude-sonnet-4-20250514",
  max_tokens: 1024,
  // Match CLI system prompt as closely as possible
  system: "Your exact system prompt matching CLI",
  messages: [
    { role: "user", content: "What is the capital of Norway?" }
  ],
  // Use greedy decoding for maximum consistency
  temperature: 0
});

// Option 2: With Agent SDK query function
import { query } from "@anthropic-ai/agent-sdk";

for await (const message of query({
  prompt: "What is the capital of Norway?",
  options: {
    systemPrompt: {
      type: "preset",
      preset: "claude_code"
    },
    temperature: 0,
    model: "claude-sonnet-4-20250514",
    // Load project context like CLI does
    settingSources: ["project"]
  }
})) {
  // Process response
}
```

### CLI Configuration

```bash
# Match the SDK configuration as closely as possible
claude -p "What is the capital of Norway?" \
  --model claude-sonnet-4-20250514 \
  --temperature 0
```

### Still Not Guaranteed

Even with perfectly matching configurations:
- Output may differ between runs
- Output may differ between SDK and CLI
- No seed parameter exists to force reproducibility

---

## 6. Practical Implications

### When to Use Each Interface

| Use Case | Recommended Interface | Reason |
|----------|----------------------|--------|
| Interactive development | Claude CLI | Full tool suite, project context |
| Programmatic integration | Agent SDK | Fine-grained control, embedding |
| Consistent API responses | Agent SDK + custom prompt | More control over system prompt |
| Batch processing | Agent SDK | Better for automation pipelines |
| One-off tasks | Claude CLI | Faster setup, immediate context |

### Design Recommendations

1. **Don't rely on bit-perfect reproducibility**
   - Build applications robust to minor output variations
   - Use structured outputs and validation

2. **For production pipelines requiring consistency:**
   - Cache results when possible
   - Use structured outputs with JSON schema validation
   - Combine with deterministic logic and validation
   - Consider multiple generations with consensus

3. **For matching CLI behavior in SDK:**
   ```typescript
   systemPrompt: {
     type: "preset",
     preset: "claude_code",
     append: "Your additional instructions"
   },
   settingSources: ["project", "user"]
   ```

---

## 7. System Prompt Token Impact

| Configuration | Architecture | Notes |
|---------------|-------------|-------|
| SDK (minimal) | Minimal default | Only essential tool instructions |
| SDK (claude_code preset) | Modular (~269+ base) | Matches CLI, varies by features |
| CLI (default) | Modular (~269+ base) | Additional context loaded conditionally |
| CLI (with MCP tools) | Modular + MCP | MCP tool descriptions add significant tokens |

**Note:** Claude Code uses a modular architecture with 110+ system prompt strings. The base prompt is ~269 tokens, with individual components ranging from 18 to 2,610 tokens depending on features activated.

**Implication:** The SDK's minimal default gives you more context for your actual task, but at the cost of Claude Code's full capabilities.

---

## 8. Summary Table

| Aspect | Claude CLI | Agent SDK (Default) | Agent SDK (Preset) |
|--------|------------|--------------------|--------------------|
| **System prompt** | Modular (~269+ base) | Minimal | Modular (matches CLI) |
| **Tools included** | 18+ builtin | Only if provided | 18+ builtin |
| **CLAUDE.md auto-load** | Yes | No | No (needs config) |
| **Coding guidelines** | Yes | No | Yes |
| **Safety rules** | Full | Basic | Full |
| **Temperature control** | Yes | Yes | Yes |
| **Determinism guarantee** | No | No | No |
| **Identical outputs?** | N/A | No (vs CLI) | Closer, but no |

---

## 9. 结论

**问:SDK vs CLI 中相同消息伴随的系统提示是什么?**

CLI 使用**模块化系统提示架构**,有约269个令牌的基础提示和110+个条件加载的组件(工具指令、编码指南、安全规则、项目上下文)。SDK 使用**最小默认值**,仅包含基本工具指令,尽管可以使用 `claude_code` 预设配置以匹配 CLI 行为。

**问:是否保证输出相同?**

**否。** 即使系统提示匹配、输入相同且 `temperature=0`,也不能保证输出相同,原因包括:
- Claude API 中缺少种子参数
- 浮点运算变化
- 基础设施级非确定性
- 模型架构(专家混合)路由变化

**建议:** 设计系统以对输出变化具有鲁棒性,而不是依赖确定性行为。对于一致性关键型应用,使用结构化输出、缓存和验证层。

---

## 资料来源

- [Modifying System Prompts - Agent SDK](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/sdk#modifying-system-prompts)
- [Claude Code CLI Reference](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/cli)
- [Claude Code Headless Mode](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/headless)
- [Claude Code Best Practices - Anthropic Engineering](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Claude Messages API Reference](https://docs.anthropic.com/en/api/messages)
- [GitHub Issue #3370: Non-deterministic output](https://github.com/anthropics/claude-code/issues/3370)
- [Claude Code System Prompts Repository](https://github.com/Piebald-AI/claude-code-system-prompts) - Analysis of modular prompt architecture
- [Why Deterministic Output from LLMs is Nearly Impossible](https://unstract.com/blog/understanding-why-deterministic-output-from-llms-is-nearly-impossible/)

---

*本报告由 Claude Code 使用 Opus 4.5 模型于2026年2月3日生成。*
