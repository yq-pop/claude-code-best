# 时间 SVG 创建器 — 参考

## SVG 模板

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 250" width="400" height="250">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#0a1628"/>
      <stop offset="100%" style="stop-color:#1a2744"/>
    </linearGradient>
  </defs>
  <rect width="400" height="250" rx="16" fill="url(#bg)"/>
  <text x="200" y="50" text-anchor="middle" fill="#8892b0" font-family="sans-serif" font-size="16" font-weight="600">Dubai Time</text>
  <text x="200" y="120" text-anchor="middle" fill="#ffffff" font-family="sans-serif" font-size="52" font-weight="bold">{{TIME}}</text>
  <text x="200" y="160" text-anchor="middle" fill="#64ffda" font-family="sans-serif" font-size="16">{{TIMEZONE}}</text>
  <text x="200" y="195" text-anchor="middle" fill="#ccd6f6" font-family="sans-serif" font-size="14">Dubai, UAE</text>
  <text x="200" y="225" text-anchor="middle" fill="#8892b0" font-family="sans-serif" font-size="12">{{DATE}}</text>
</svg>
```

### 占位符

| 占位符 | 替换为 | 示例 |
|-------------|-------------|---------|
| `{{TIME}}` | 输入的 `time` 值 | `14:30:45` |
| `{{TIMEZONE}}` | 输入的 `timezone` 值 | `GST (UTC+4)` |
| `{{DATE}}` | 从 `formatted` 提取的日期（前 10 个字符） | `2026-03-12` |
| `{{FORMATTED}}` | 完整的 `formatted` 字符串（仅用于 markdown） | `2026-03-12 14:30:45 +04` |

### 设计规范

| 属性 | 值 |
|----------|-------|
| 尺寸 | 400 x 250 px |
| 圆角半径 | 16 px |
| 背景 | 线性渐变：`#0a1628` → `#1a2744`（深海军蓝到深蓝色） |
| 标题 | `#8892b0`（柔和蓝色），16px 半粗体 |
| 时间显示 | `#ffffff`（白色），52px 粗体 |
| 时区 | `#64ffda`（青色强调），16px |
| 位置 | `#ccd6f6`（浅蓝色），14px |
| 日期 | `#8892b0`（柔和蓝色），12px |
| 字体 | `sans-serif` |
| 所有文本 | 居中（x=200 处 `text-anchor="middle"`） |

---

## 输出 Markdown 模板

```markdown
# 迪拜时间卡片

- **时间**：{{TIME}}
- **时区**：{{TIMEZONE}}
- **日期**：{{DATE}}
- **完整**：{{FORMATTED}}
- **SVG**：`agent-teams/output/dubai-time.svg`

由 time-svg-creator 技能生成。
```

---

## 输出路径

| 文件 | 路径 |
|------|------|
| SVG 卡片 | `agent-teams/output/dubai-time.svg` |
| Markdown 摘要 | `agent-teams/output/output.md` |
