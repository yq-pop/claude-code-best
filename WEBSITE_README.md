# 🌐 网站搭建指南

本目录包含将 claude-code-best-practice 项目转换为网站的完整方案和工具。

## 📚 文档清单

| 文档 | 说明 | 适用人群 |
|------|------|----------|
| [WEBSITE_IMPLEMENTATION_PLAN.md](WEBSITE_IMPLEMENTATION_PLAN.md) | 完整的实施方案，包含 4 种技术栈对比、详细设计和实施步骤 | 技术决策者、项目管理者 |
| [website-quickstart.md](website-quickstart.md) | 5 分钟快速开始指南，快速搭建基础网站 | 开发者、快速上手 |
| [setup-website.sh](setup-website.sh) | Linux/Mac 自动化部署脚本 | Linux/Mac 用户 |
| [setup-website.ps1](setup-website.ps1) | Windows 自动化部署脚本 | Windows 用户 |

## 🚀 快速开始

### 选项 A：自动化脚本（推荐）

**Linux/Mac 用户**：
```bash
# 赋予执行权限
chmod +x setup-website.sh

# 运行脚本
./setup-website.sh

# 进入目录并启动
cd docs
npm run docs:dev
```

**Windows 用户**：
```powershell
# 允许执行脚本（以管理员身份运行 PowerShell）
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# 运行脚本
.\setup-website.ps1

# 进入目录并启动
cd docs
npm run docs:dev
```

### 选项 B：手动搭建

参考 [website-quickstart.md](website-quickstart.md) 逐步操作。

## 🎯 技术方案对比

我们评估了 4 种技术方案：

| 方案 | 评分 | 优势 | 开发时间 |
|------|------|------|----------|
| **VitePress** ⭐⭐⭐⭐⭐ | 推荐 | 专为文档设计、速度快、零配置 | 2-3天 |
| Docusaurus ⭐⭐⭐⭐ | 可选 | 功能全面、生态成熟 | 3-5天 |
| Astro ⭐⭐⭐⭐ | 高级 | 性能极致、高度定制 | 4-6天 |
| Nextra ⭐⭐⭐ | 备选 | 基于 Next.js、灵活 | 3-4天 |

**推荐使用 VitePress**，原因：
- ✅ 最适合技术文档
- ✅ 几乎零配置
- ✅ 完美支持现有 Markdown
- ✅ 性能和 SEO 优秀
- ✅ 开发效率最高

详细对比见：[WEBSITE_IMPLEMENTATION_PLAN.md](WEBSITE_IMPLEMENTATION_PLAN.md)

## 📊 网站特性

### 核心功能
- ✅ 响应式设计（移动端友好）
- ✅ 全文搜索
- ✅ 暗色/亮色主题切换
- ✅ 多级侧边栏导航
- ✅ 代码高亮和复制
- ✅ Markdown 增强
- ✅ SEO 优化

### 高级功能（可选）
- 🎯 交互式流程图（Mermaid）
- 📊 学习进度追踪
- ✅ 互动式清单
- 🎨 自定义 Vue 组件
- 💬 评论系统（giscus）
- 📈 分析统计（Google Analytics）

## 🗂️ 网站结构

```
网站结构
├── 首页
│   ├── Hero 区域
│   ├── 特色功能
│   ├── 项目统计
│   └── 学习路径
│
├── 指南
│   ├── 快速开始
│   ├── 核心概念
│   └── 学习路径
│
├── 最佳实践（8篇）
│   ├── 命令
│   ├── 技能
│   ├── 子智能体
│   ├── 设置
│   ├── MCP
│   ├── 内存
│   ├── 增强功能
│   └── CLI 启动标志
│
├── 开发工作流
│   ├── 编排工作流
│   ├── 跨模型工作流
│   ├── RPI 工作流
│   └── 10大工作流对比
│
├── 技巧集锦（69条）
│   ├── 提示技巧
│   ├── 计划规范
│   ├── CLAUDE.md
│   ├── 智能体
│   ├── 工作流
│   └── ...
│
├── 视频笔记（6个）
│   └── Boris Cherny 访谈系列
│
├── 技术报告（9个）
│   └── 专题深度分析
│
├── 实现示例（5个）
│   └── 可运行代码
│
└── 资源中心
    ├── 工具推荐
    ├── 社区资源
    └── FAQ
```

## 🎨 设计特点

### 首页设计
- 🎯 清晰的 Hero 区域（品牌标识）
- ✨ 6-8 个特色卡片（核心亮点）
- 📊 项目统计数据（可视化）
- 🎓 学习路径引导
- 🎬 精选视频展示

### 内容页设计
- 📚 多级侧边栏导航
- 🔍 页面内搜索
- 📝 Markdown 增强渲染
- 💡 提示/警告框
- 🔗 相关链接推荐
- ⬆️ 返回顶部按钮

### 交互设计
- 🎨 流畅的过渡动画
- 🖱️ Hover 效果
- 📱 触摸友好
- ⌨️ 键盘快捷键
- 🌓 主题切换

## 🚀 部署选项

### 免费方案

| 平台 | 带宽 | 部署 | 优势 |
|------|------|------|------|
| **GitHub Pages** | 100GB/月 | 自动 | 与仓库集成，无需配置 |
| **Vercel** | 100GB/月 | 自动 | 速度快，全球 CDN |
| **Netlify** | 100GB/月 | 自动 | 功能全面，表单支持 |
| **Cloudflare Pages** | 无限 | 自动 | 无限带宽，速度极快 |

**推荐 Vercel**：
- ✅ 一键部署
- ✅ 自动 HTTPS
- ✅ 全球 CDN
- ✅ PR 预览
- ✅ 分析工具

### 自定义域名（可选）
- 购买域名：约 ¥50-100/年
- DNS 配置：5 分钟
- SSL 证书：自动（Let's Encrypt）

## 📋 实施清单

### 准备阶段
- [ ] 阅读 [WEBSITE_IMPLEMENTATION_PLAN.md](WEBSITE_IMPLEMENTATION_PLAN.md)
- [ ] 选择技术方案（推荐 VitePress）
- [ ] 准备开发环境（Node.js 18+）

### 开发阶段
- [ ] 运行自动化脚本或手动初始化
- [ ] 配置网站结构和导航
- [ ] 迁移所有内容
- [ ] 调整链接和图片
- [ ] 自定义主题和组件
- [ ] 测试所有页面

### 部署阶段
- [ ] 选择部署平台
- [ ] 配置 CI/CD
- [ ] 部署到生产环境
- [ ] （可选）配置自定义域名
- [ ] 测试线上环境

### 优化阶段
- [ ] SEO 优化
- [ ] 性能优化
- [ ] 移动端适配
- [ ] 添加分析工具
- [ ] 收集用户反馈

## ⏰ 时间规划

### 最快路径（3天）
- **Day 1**（4小时）：运行脚本 → 配置 → 迁移内容
- **Day 2**（4小时）：调整样式 → 自定义组件
- **Day 3**（2小时）：测试 → 部署

### 完整路径（2-3周）
- **Week 1**：基础搭建
- **Week 2**：功能开发
- **Week 3**：部署和完善

详细计划见：[WEBSITE_IMPLEMENTATION_PLAN.md](WEBSITE_IMPLEMENTATION_PLAN.md#🎯-实施步骤)

## 💰 成本估算

### 零成本方案
- 托管：GitHub Pages / Vercel（免费）
- 域名：使用平台提供的域名
- **总成本**：¥0

### 专业方案
- 托管：Vercel（免费）
- 自定义域名：¥50-100/年
- **总成本**：¥50-100/年

## 🆘 常见问题

**Q: 我不懂前端，能搭建吗？**
A: 可以！运行自动化脚本即可，无需前端知识。

**Q: 需要多长时间？**
A: 使用脚本 1 小时即可完成基础版，完整版 3 天。

**Q: 如何更新内容？**
A: 直接修改 Markdown 文件，提交后自动部署。

**Q: 支持搜索吗？**
A: 支持！VitePress 内置全文搜索。

**Q: 可以添加自定义功能吗？**
A: 可以！通过 Vue 组件扩展任何功能。

**Q: 如何保证内容不遗漏？**
A: 脚本会自动复制所有文件，可通过对比检查。

## 📞 获取帮助

遇到问题？查看：
1. [快速开始指南](website-quickstart.md) - 常见问题
2. [完整实施方案](WEBSITE_IMPLEMENTATION_PLAN.md) - 详细说明
3. [VitePress 官方文档](https://vitepress.dev) - 技术文档
4. [GitHub Issues](https://github.com/yq-pop/claude-code-best/issues) - 提问讨论

## 🎯 下一步

1. **立即开始**
   ```bash
   # Linux/Mac
   ./setup-website.sh
   
   # Windows
   .\setup-website.ps1
   ```

2. **阅读详细方案**
   - [WEBSITE_IMPLEMENTATION_PLAN.md](WEBSITE_IMPLEMENTATION_PLAN.md)

3. **加入社区**
   - Star 项目
   - 分享经验
   - 贡献内容

**祝你成功搭建精美的技术博客网站！** 🎉

---

*最后更新：2026年4月11日*  
*文档版本：v1.0*
