# 验证检查清单 — README 概念部分

用于验证 CONCEPTS 表格准确性的规则。每次工作流运行都会检查每条规则。

## 规则

### 1. External URL Liveness
- **类别**: URL 准确性
- **检查内容**: CONCEPTS 表格中的每个外部 URL (文档链接) 返回有效页面
- **深度**: 获取每个 URL 并确认它加载了预期页面 (不是重定向到错误页面)
- **对比依据**: `https://code.claude.com/docs/llms.txt` 用于规范 URL 列表
- **添加时间**: 2026-03-02
- **来源**: Permissions URL `/iam` 被发现重定向到身份验证页面而不是权限页面

### 2. Anchor Fragment Validity
- **类别**: URL 准确性
- **检查内容**: 带有锚点片段 (`#section-name`) 的任何 URL 都匹配目标页面上的实际标题
- **深度**: 获取页面并验证标题是否存在且具有预期的锚点
- **对比依据**: 获取的页面内容
- **添加时间**: 2026-03-02
- **来源**: Rules 锚点 `#modular-rules-with-clauderules` 已过时; 部分重命名为 `#organize-rules-with-clauderules`

### 3. Missing Docs Pages
- **类别**: 缺失概念
- **检查内容**: 官方文档索引 (`llms.txt`) 中代表面向用户的功能的每个页面在 CONCEPTS 表格中都有对应的行
- **深度**: 将完整文档索引与 CONCEPTS 表格条目进行对比
- **对比依据**: `https://code.claude.com/docs/llms.txt`
- **添加时间**: 2026-03-02
- **来源**: 发现多个缺失的概念 (Agent Teams, Keybindings, Model Configuration 等)

### 4. Local Badge Link Validity
- **类别**: 徽章准确性
- **检查内容**: CONCEPTS 表格中的每个徽章目标路径 (`best-practice/*.md`, `implementation/*.md`, `.claude/*/`) 都指向存在的文件或目录
- **深度**: 使用 Read/Glob 验证文件存在性
- **对比依据**: 本地文件系统
- **添加时间**: 2026-03-02
- **来源**: 初始检查清单创建

### 5. Description Currency
- **类别**: 描述准确性
- **检查内容**: 每个概念的描述准确反映当前官方文档描述
- **深度**: 将 README 描述与官方页面的元描述或第一段进行对比
- **对比依据**: 官方文档页面内容
- **添加时间**: 2026-03-02
- **来源**: Memory 描述缺少 auto memory; MCP Servers 位置缺少 `.mcp.json`
