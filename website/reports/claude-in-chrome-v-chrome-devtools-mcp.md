# 浏览器自动化 MCP 综合比较报告

<table width="100%">
<tr>
<td><a href="../">← Back to Claude Code Best Practice</a></td>
<td align="right"><img src="../!/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

## 执行摘要

基于广泛的研究,我分析了你截图中的两个工具以及第三个主要竞争者。这是我的综合分析,帮助你为自动化测试工作选择最佳选项。

---

## 1. 三个竞争者

### **A. Chrome DevTools MCP**(你的截图 #1)
- **来源:** 官方 Google Chrome 团队
- **发布:** 2025年9月公开预览
- **架构:** 基于 Chrome DevTools Protocol (CDP) + Puppeteer 构建
- **令牌使用:** 约19.0k令牌(上下文的9.5%)
- **工具:** 6个类别中的26个专用工具

### **B. Claude in Chrome**(你的截图 #2)
- **来源:** 官方 Anthropic 扩展
- **发布:** Beta版,向所有付费计划推出(Pro、Max、Team、Enterprise)
- **架构:** 具有计算机使用功能的浏览器扩展
- **令牌使用:** 约15.4k令牌(上下文的7.7%)
- **工具:** 16个工具,包括计算机使用功能

### **C. Playwright MCP**(强有力的替代方案)
- **来源:** Microsoft(官方 + 社区实现)
- **架构:** 基于可访问性树的自动化
- **令牌使用:** 约13.7k令牌(上下文的6.8%)
- **工具:** 21个工具

---

## 2. Detailed Feature Comparison

| Feature | Chrome DevTools MCP | Claude in Chrome | Playwright MCP |
|---------|---------------------|------------------|----------------|
| **Primary Purpose** | Debugging & Performance | General browser automation | UI Testing & E2E |
| **Browser Support** | Chrome only | Chrome only | Chromium, Firefox, WebKit |
| **Token Efficiency** | 19.0k (9.5%) | 15.4k (7.7%) | 13.7k (6.8%) |
| **Element Selection** | CSS/XPath selectors | Visual + DOM | Accessibility tree (semantic) |
| **Performance Traces** | ✅ Excellent | ❌ No | ⚠️ Limited |
| **Network Inspection** | ✅ Deep analysis | ⚠️ Basic | ⚠️ Basic |
| **Console Logs** | ✅ Full access | ✅ Full access | ⚠️ Limited |
| **Cross-browser** | ❌ No | ❌ No | ✅ Yes |
| **CI/CD Integration** | ✅ Excellent | ❌ Poor (requires login) | ✅ Excellent |
| **Headless Mode** | ✅ Yes | ❌ No | ✅ Yes |
| **Authentication** | Requires setup | Uses your session | Requires setup |
| **Scheduled Tasks** | ❌ No | ✅ Yes | ❌ No |
| **Cost** | Free | Requires paid plan | Free |
| **Local Setup** | Node.js required | Browser extension | Node.js required |

---

## 3. Tool Breakdown

### Chrome DevTools MCP (26 Tools)

```
INPUT AUTOMATION (8):     click, drag, fill, fill_form, handle_dialog,
                          hover, press_key, upload_file

NAVIGATION (6):           close_page, list_pages, navigate_page,
                          new_page, select_page, wait_for

EMULATION (2):            emulate, resize_page

PERFORMANCE (3):          performance_analyze_insight,
                          performance_start_trace, performance_stop_trace

NETWORK (2):              get_network_request, list_network_requests

DEBUGGING (5):            evaluate_script, get_console_message,
                          list_console_messages, take_screenshot,
                          take_snapshot
```

### Claude in Chrome (16 Tools)

```
BROWSER CONTROL:          navigate, read_page, find, computer
                          (click, type, scroll)

FORM INTERACTION:         form_input, javascript_tool

MEDIA:                    upload_image, get_page_text, gif_creator

TAB MANAGEMENT:           tabs_context_mcp, tabs_create_mcp

DEVELOPMENT:              read_console_messages, read_network_requests

UTILITIES:                shortcuts_list, shortcuts_execute,
                          resize_window, update_plan
```

### Playwright MCP (21 Tools)

```
NAVIGATION:               navigate, goBack, goForward, reload

INTERACTION:              click, fill, select, hover, press,
                          drag, uploadFile

ELEMENT QUERIES:          getElement, getElements, waitForSelector

ASSERTIONS:               assertVisible, assertText, assertTitle

PAGE STATE:               screenshot, getAccessibilityTree,
                          evaluateScript

BROWSER MGMT:             newPage, closePage
```

---

## 4. Use Case Analysis for Automated Testing

### **Chrome DevTools MCP is BEST for:**

✅ **Performance Testing**
- Recording performance traces with Core Web Vitals
- Identifying render bottlenecks and layout shifts
- Memory leak detection and CPU profiling

✅ **Deep Debugging**
- Network request inspection (headers, payloads, timing)
- Console error analysis and stack traces
- Real-time DOM inspection

✅ **CI/CD Pipelines**
- Headless execution support
- Stable, script-based automation
- No authentication state dependencies

**Ideal workflow:** "Find why this page is slow" or "Debug this API call"

---

### **Claude in Chrome is BEST for:**

✅ **Manual Testing Assistance**
- Testing while logged into your accounts
- Exploratory testing with visual context
- Recording workflows you can replay

✅ **Quick Verification**
- Design verification (comparing Figma to output)
- Spot-checking new features
- Reading console errors during development

✅ **Recurring Browser Tasks**
- Scheduled automated checks
- Multi-tab workflow management
- Learning from your recorded actions

**Ideal workflow:** "Check if my changes look right" or "Test this form with my login"

---

### **Playwright MCP is BEST for:**

✅ **E2E Test Automation**
- Cross-browser testing (Chrome, Firefox, Safari)
- Generating reusable test scripts
- Page Object Model generation

✅ **Reliable UI Testing**
- Accessibility tree = no flaky selectors
- Deterministic interactions
- Less prone to breaking from UI changes

✅ **CI/CD Integration**
- Headless mode for pipelines
- Generate Playwright test files from natural language
- Integration with test management tools

**Ideal workflow:** "Write E2E tests for this user flow" or "Test this across browsers"

---

## 5. Token Efficiency Analysis

| Tool | Token Usage | % of Context | Efficiency Rating |
|------|-------------|--------------|-------------------|
| Playwright MCP | ~13.7k | 6.8% | ⭐⭐⭐⭐⭐ Best |
| Claude in Chrome | ~15.4k | 7.7% | ⭐⭐⭐⭐ Good |
| Chrome DevTools MCP | ~19.0k | 9.5% | ⭐⭐⭐ Acceptable |

**Impact:** With 200k token context:
- Playwright leaves 186.3k tokens for your work
- Claude in Chrome leaves 184.6k tokens
- Chrome DevTools leaves 181k tokens

The ~5.3k token difference between Playwright and Chrome DevTools could matter for complex sessions with lots of code context.

---

## 6. Security Considerations

### Chrome DevTools MCP
- ✅ Isolated browser profile by default
- ✅ No cloud dependencies
- ✅ Full local control
- ⚠️ Remote debugging port security (use isolated profiles)

### Claude in Chrome
- ⚠️ **23.6% attack success rate** without mitigations (reduced to 11.2% with defenses)
- ⚠️ Uses your actual browser session (cookie exposure risk)
- ⚠️ Blocked from financial/adult/pirated sites
- ⚠️ Still in beta with known vulnerabilities

### Playwright MCP
- ✅ Isolated browser contexts
- ✅ No cloud dependencies
- ✅ Mature security model (Microsoft backing)
- ✅ Can handle authentication safely

---

## 7. Installation Commands

### Chrome DevTools MCP

```bash
claude mcp add chrome-devtools npx chrome-devtools-mcp@latest
```

### Claude in Chrome

```
Install from Chrome Web Store (requires Pro/Max/Team/Enterprise plan)
```

### Playwright MCP (Recommended)

```bash
# First, install browsers
npx playwright install

# Then add to Claude Code (user scope = all projects)
claude mcp add playwright -s user -- npx @playwright/mcp@latest
```

---

## 8. Recommendations

### **For Your Automated Testing Workflow:**

#### 🥇 **Primary Tool: Playwright MCP**

**Use for:** Day-to-day E2E testing, cross-browser verification, generating test scripts

**Why:**
- Lowest token usage (more context for your code)
- Cross-browser support (Chrome, Firefox, Safari)
- Accessibility tree approach = more reliable selectors
- Excellent CI/CD integration
- Can generate actual Playwright test files
- Free, no subscription required

#### 🥈 **Secondary Tool: Chrome DevTools MCP**

**Use for:** Performance debugging, network analysis, Core Web Vitals

**Why:**
- Unmatched for performance traces and debugging
- Deep network request inspection
- Official Google tooling with long-term support
- Essential when you need to answer "why is this slow?"

#### 🥉 **Situational: Claude in Chrome**

**Use for:** Quick manual verification while logged in, exploratory testing, design verification

**Why:**
- Good for quick visual checks during development
- Can read your logged-in state
- Useful for "does this look right?" verification
- Skip for CI/CD or serious test automation

---

## 9. Recommended Setup

```bash
# Install both Playwright and Chrome DevTools MCP
npx playwright install
claude mcp add playwright -s user -- npx @playwright/mcp@latest
claude mcp add chrome-devtools -s user -- npx chrome-devtools-mcp@latest
```

### Suggested Workflow

```
1. DEVELOP      → Claude Code (terminal)
2. TEST         → Playwright MCP (E2E, cross-browser)
3. DEBUG        → Chrome DevTools MCP (performance, network)
4. VERIFY       → Claude in Chrome (quick visual checks)
5. CI/CD        → Playwright MCP (headless, automated)
```

---

## 10. 最终结论

| 如果你需要... | 使用这个 |
|----------------|----------|
| 跨浏览器端到端测试 | **Playwright MCP** |
| 性能分析 | **Chrome DevTools MCP** |
| 网络调试 | **Chrome DevTools MCP** |
| 快速视觉验证 | **Claude in Chrome** |
| CI/CD自动化 | **Playwright MCP** |
| 测试脚本生成 | **Playwright MCP** |
| 最低令牌使用 | **Playwright MCP** |
| 已登录会话测试 | **Claude in Chrome** |
| 控制台日志调试 | **Chrome DevTools MCP** |

### **简短建议:**

**同时安装 Playwright MCP 和 Chrome DevTools MCP。** 使用 Playwright 作为主要测试工具(它更节省令牌、跨浏览器且更适合端到端测试)。当需要深度性能分析或网络调试时使用 Chrome DevTools。仅在需要已登录会话的快速手动验证时使用 Claude in Chrome。

---

## 资料来源

- [Chrome DevTools MCP - GitHub](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- [Anthropic - Piloting Claude in Chrome](https://claude.com/blog/claude-for-chrome)
- [Claude in Chrome Help Center](https://support.claude.com/en/articles/12012173-getting-started-with-claude-in-chrome)
- [Playwright MCP - GitHub](https://github.com/microsoft/playwright-mcp)
- [Simon Willison - Using Playwright MCP with Claude Code](https://til.simonwillison.net/claude-code/playwright-mcp-claude-code)
- [Testomat.io - Playwright MCP Claude Code](https://testomat.io/blog/playwright-mcp-claude-code/)
- [MCP Integration Guide - Scrapeless](https://www.scrapeless.com/en/blog/mcp-integration-guide)
- [Chrome DevTools MCP Guide - Vladimir Siedykh](https://vladimirsiedykh.com/blog/chrome-devtools-mcp-ai-browser-debugging-complete-guide-2025)
- [Addy Osmani - Give your AI eyes](https://addyosmani.com/blog/devtools-mcp/)

---

*本报告由 Claude Code 使用 Opus 4.5 模型于2025年12月19日生成。*
