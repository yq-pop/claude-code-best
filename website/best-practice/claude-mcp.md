# MCP 服务器最佳实践

![Last Updated](https://img.shields.io/badge/Last_Updated-Mar%2002%2C%202026%2012%3A30%20PM%20PKT-white?style=flat&labelColor=555)<br>
[![Implemented](https://img.shields.io/badge/Implemented-2ea44f?style=flat)](../.mcp.json)

MCP(模型上下文协议)服务器通过连接外部工具、数据库和 API 来扩展 Claude Code。本指南涵盖了日常使用的推荐服务器和配置最佳实践。

<table width="100%">
<tr>
<td><a href="../">← 返回 Claude Code 最佳实践</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

## 日常使用的 MCP 服务器

> *"曾经过度使用了 15 个 MCP 服务器,以为越多越好。最终每天只使用 4 个。"* — [r/mcp](https://reddit.com/r/mcp/comments/1mj0fxs/) (682 赞)

| MCP 服务器 | 功能 | 资源 |
|------------|-------------|-----------|
| [**Context7**](https://github.com/upstash/context7) | 将最新的库文档提取到上下文中。防止因过时训练数据导致的 API 幻觉 | [Reddit: "目前最好的编码 MCP"](https://reddit.com/r/mcp/comments/1qarjqm/) · [npm](https://www.npmjs.com/package/@upstash/context7-mcp) |
| [**Playwright**](https://github.com/microsoft/playwright-mcp) | 浏览器自动化 — 自主实现、测试和验证 UI 功能。屏幕截图、导航、表单测试 | [Reddit: 前端必备](https://reddit.com/r/mcp/comments/1m59pk0/) · [Docs](https://playwright.dev/) |
| [**Claude in Chrome**](https://github.com/nicobailon/claude-code-in-chrome-mcp) | 将 Claude 连接到您的真实 Chrome 浏览器 — 检查控制台、网络、DOM。调试用户实际看到的内容 | [Reddit: 调试的"游戏改变者"](https://reddit.com/r/mcp/comments/1qarjqm/5_mcps_that_have_genuinely_made_me_10x_faster/nza0i7t/) · [对比报告](../reports/claude-in-chrome-v-chrome-devtools-mcp.md) |
| [**DeepWiki**](https://github.com/devanshusemwal/deepwiki-mcp) | 为任何 GitHub 仓库提取结构化的 wiki 风格文档 — 架构、API 表面、关系 | [Reddit: "与 Context7 配合使用"](https://reddit.com/r/mcp/comments/1qarjqm/) |
| [**Excalidraw**](https://github.com/antonpk1/excalidraw-mcp-app) | 从提示生成手绘风格的 Excalidraw 架构图、流程图和系统设计 | [GitHub](https://github.com/antonpk1/excalidraw-mcp-app) |

研究(Context7/DeepWiki) -> 调试(Playwright/Chrome) -> 文档(Excalidraw)

---

## 配置

MCP 服务器在项目根目录的 `.mcp.json`(项目作用域)或 `~/.claude.json`(用户作用域)中配置。

### 服务器类型

| 类型 | 传输 | 示例 |
|------|-----------|---------|
| **stdio** | 生成本地进程 | `npx`、`python`、二进制文件 |
| **http** | 连接到远程 URL | HTTP/SSE 端点 |

### `.mcp.json` 示例

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp"]
    },
    "deepwiki": {
      "command": "npx",
      "args": ["-y", "deepwiki-mcp"]
    },
    "remote-api": {
      "type": "http",
      "url": "https://mcp.example.com/mcp"
    }
  }
}
```

使用环境变量扩展来处理敏感信息,而不是在 `.mcp.json` 中提交 API 密钥:

```json
{
  "mcpServers": {
    "remote-api": {
      "type": "http",
      "url": "https://mcp.example.com/mcp?token=${MCP_API_TOKEN}"
    }
  }
}
```

### MCP 服务器的设置

`.claude/settings.json` 中的这些设置控制 MCP 服务器审批:

| 键 | 类型 | 描述 |
|-----|------|-------------|
| `enableAllProjectMcpServers` | boolean | 自动批准所有 `.mcp.json` 服务器,无需提示 |
| `enabledMcpjsonServers` | array | 要自动批准的特定服务器名称的允许列表 |
| `disabledMcpjsonServers` | array | 要拒绝的特定服务器名称的阻止列表 |

### MCP 工具的权限规则

MCP 工具在权限规则中遵循 `mcp__<server>__<tool>` 命名约定:

```json
{
  "permissions": {
    "allow": [
      "mcp__*",
      "mcp__context7__*",
      "mcp__playwright__browser_snapshot"
    ],
    "deny": [
      "mcp__dangerous-server__*"
    ]
  }
}
```

---

## MCP 作用域

MCP 服务器可以在三个层级定义:

| 作用域 | 位置 | 目的 |
|-------|----------|---------|
| **项目** | `.mcp.json`(仓库根目录) | 团队共享的服务器,提交到 git |
| **用户** | `~/.claude.json`(`mcpServers` 键) | 跨所有项目的个人服务器 |
| **子代理** | 代理前置元数据(`mcpServers` 字段) | 作用域限定于特定子代理的服务器 |

优先级:子代理 > 项目 > 用户

---

## Sources

- [MCP Servers — Claude Code Docs](https://code.claude.com/docs/en/mcp)
- [Model Context Protocol Specification](https://modelcontextprotocol.io/)
- [5 MCPs that have genuinely made me 10x faster — r/mcp](https://reddit.com/r/mcp/comments/1qarjqm/)
- [MCP Server Overload Discussion — r/mcp](https://reddit.com/r/mcp/comments/1mj0fxs/)
