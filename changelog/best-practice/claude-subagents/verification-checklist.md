# 验证检查清单 — 子代理报告

规则随时间累积。每次workflow-changelog运行都必须按指定深度执行所有规则。当捕获到现有规则本应捕获(但不存在或太浅)的新类型偏差时,在此追加新规则。

## 深度级别

| 深度 | 含义 | 示例 |
|-------|---------|---------|
| `exists` | 检查某个部分/表格/文件是否存在 | "报告中是否有内存范围表?" |
| `presence-check` | 检查特定项目是否存在或缺失 | "`color` 字段是否在前置元数据字段表中?" |
| `content-match` | 逐字对比实际值与源文件 | "`model` 字段描述是否与官方文档匹配?" |
| `field-level` | 验证每个独立字段都有记录 | "官方文档中的每个前置元数据字段是否都出现在表格中?" |
| `cross-file` | 相同的值必须在多个文件中匹配 | "CLAUDE.md 代理部分是否与报告的字段列表匹配?" |

---

## 1. Frontmatter Fields Table

Rules that verify the Frontmatter Fields table against official docs.

| # | 类别 | 检查 | 深度 | 对比依据 | 添加时间 | 来源 |
|---|----------|-------|-------|-----------------|-------|--------|
| 1A | Field Completeness | For each agent frontmatter field in official docs, verify it appears in the report's Frontmatter Fields table | field-level | sub-agents reference page | 2026-02-28 | Initial checklist — ensures no new fields are missed |
| 1B | Field Types | For each field in the table, verify the Type column matches official docs | content-match | sub-agents reference page | 2026-02-28 | Initial checklist — type mismatches cause user confusion |
| 1C | Required Status | For each field, verify the Required column matches official docs | content-match | sub-agents reference page | 2026-02-28 | Initial checklist — wrong required status causes broken agents |
| 1D | Field Descriptions | For each field, verify the Description column accurately reflects official docs behavior | content-match | sub-agents reference page | 2026-02-28 | Initial checklist — stale descriptions mislead users |

---

## 2. Memory Scopes

Rules that verify the Memory Scopes table.

| # | 类别 | 检查 | 深度 | 对比依据 | 添加时间 | 来源 |
|---|----------|-------|-------|-----------------|-------|--------|
| 2A | Scope Completeness | Verify all memory scopes from official docs appear in the Memory Scopes table | field-level | sub-agents reference page | 2026-02-28 | Initial checklist — new scopes could be added |
| 2B | Storage Locations | For each scope, verify the Storage Location column matches official docs | content-match | sub-agents reference page | 2026-02-28 | Initial checklist — wrong paths cause data loss |

---

## 3. Examples

Rules that verify example accuracy.

| # | 类别 | 检查 | 深度 | 对比依据 | 添加时间 | 来源 |
|---|----------|-------|-------|-----------------|-------|--------|
| 3A | Minimal Example | Verify the minimal example uses only required fields with valid syntax | content-match | sub-agents reference page | 2026-02-28 | Initial checklist — minimal example should stay minimal |
| 3B | Full-Featured Example | Verify the full-featured example demonstrates ALL available frontmatter fields | field-level | sub-agents reference page | 2026-02-28 | Initial checklist — full example must show every field |

---

## 4. Scope & Priority

Rules that verify scope and priority information.

| # | 类别 | 检查 | 深度 | 对比依据 | 添加时间 | 来源 |
|---|----------|-------|-------|-----------------|-------|--------|
| 4A | Priority Order | Verify the Scope and Priority table lists all agent locations in correct priority order | content-match | sub-agents reference page + CLI reference page | 2026-02-28 | Initial checklist — wrong priority order causes resolution bugs |
| 4B | Invocation Methods | Verify the invocation methods table lists ALL invocation methods from CLI reference and sub-agents docs, including `--agent` (singular), `--agents` (plural), `/agents`, `claude agents`, Agent tool, and agent resumption | field-level | CLI reference page + sub-agents reference page | 2026-03-07 | `--agent` CLI flag was missing from the invocation table — it's a distinct invocation method for running Claude as a specific agent |

---

## 5. Cross-File Consistency

Rules that verify consistency between the report and other repo files.

| # | 类别 | 检查 | 深度 | 对比依据 | 添加时间 | 来源 |
|---|----------|-------|-------|-----------------|-------|--------|
| 5A | CLAUDE.md Sync | Verify CLAUDE.md's Subagent Definition Structure section lists the same fields as the report's Frontmatter Fields table | cross-file | CLAUDE.md vs report | 2026-02-28 | Initial checklist — CLAUDE.md could drift from report |

---

## 6. Process

Meta-rules about the workflow verification process itself.

| # | 类别 | 检查 | 深度 | 对比依据 | 添加时间 | 来源 |
|---|----------|-------|-------|-----------------|-------|--------|
| 6A | Source Credibility Guard | Only flag items as drift if confirmed by official sources (sub-agents reference page, CLI reference page, GitHub changelog). Third-party blog sources may be outdated or wrong — use them for leads only, verify against official docs before flagging | content-match | official docs only | 2026-02-28 | Adopted from hooks workflow — prevents false positives from blog sources |

---

## 7. Agent Tables

Rules that verify the Official Claude Agents and Agents in This Repository tables.

| # | 类别 | 检查 | 深度 | 对比依据 | 添加时间 | 来源 |
|---|----------|-------|-------|-----------------|-------|--------|
| 7A | Built-in Agent Completeness | Verify the "Official Claude Agents" table lists all built-in agent types with correct model, tools, and description | field-level | sub-agents reference page + changelog | 2026-02-28 | Report only had 3 of 5 built-in agents — `claude-code-guide` and `statusline-setup` were missing |
| 7B | Repository Agent Completeness | Scan `.claude/agents/**/*.md` and verify every agent file appears in the "Agents in This Repository" table with correct model, color, tools, skills, and memory columns | field-level | `.claude/agents/**/*.md` file frontmatter | 2026-02-28 | Repo agents were manually maintained — new agents added to the repo were not reflected in the report |
| 7C | Repository Agent Links | Verify each agent name in the "Agents in This Repository" table has a clickable link that resolves to the correct `.md` file | exists | resolved file path from `best-practice/` | 2026-02-28 | Agent names were made clickable — links must stay valid after file moves |

---

## 8. Hyperlinks

Rules that verify all hyperlinks in the report are valid.

| # | 类别 | 检查 | 深度 | 对比依据 | 添加时间 | 来源 |
|---|----------|-------|-------|-----------------|-------|--------|
| 8A | Local File Links | Verify all relative file links (e.g. `../.claude/agents/weather-agent.md`) resolve to existing files | exists | local filesystem | 2026-02-28 | File moves (reports/ → best-practice/) broke relative links — must catch future breakage |
| 8B | External URL Links | Verify all external URLs (e.g. `https://code.claude.com/docs/en/sub-agents`) return valid pages | exists | HTTP response | 2026-02-28 | External docs pages can be restructured or removed — must validate on each run |
| 8C | Cross-File Reference Links | Verify links to other report files (e.g. `../reports/claude-agent-memory.md`) resolve to existing files | exists | local filesystem | 2026-02-28 | Reports can be moved or renamed — cross-references must stay in sync |
