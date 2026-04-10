#!/bin/bash

# Claude Code Best Practice - 网站自动部署脚本
# 使用方法: bash setup-website.sh

set -e  # 遇到错误立即退出

echo "🚀 开始设置 Claude Code Best Practice 网站..."
echo ""

# 检查 Node.js
if ! command -v node &> /dev/null; then
    echo "❌ 错误: 未找到 Node.js"
    echo "请先安装 Node.js: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js 版本: $(node -v)"
echo ""

# 创建 docs 目录
echo "📁 创建 docs 目录..."
mkdir -p docs
cd docs

# 初始化 package.json
echo "📦 初始化项目..."
cat > package.json << 'EOF'
{
  "name": "claude-code-best-practice-docs",
  "version": "1.0.0",
  "description": "Claude Code Best Practice Documentation",
  "scripts": {
    "docs:dev": "vitepress dev",
    "docs:build": "vitepress build",
    "docs:preview": "vitepress preview"
  },
  "devDependencies": {
    "vitepress": "^1.0.0",
    "vue": "^3.4.0"
  }
}
EOF

# 安装依赖
echo "📥 安装依赖..."
npm install

# 创建 .vitepress 目录
echo "⚙️ 创建配置文件..."
mkdir -p .vitepress/theme/components
mkdir -p .vitepress/theme/styles

# 创建配置文件
cat > .vitepress/config.ts << 'EOF'
import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Claude Code 最佳实践',
  description: '从氛围编程到智能体工程 - 熟能生巧，让 Claude 完美运作',
  
  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['meta', { name: 'theme-color', content: '#5f67ee' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:locale', content: 'zh_CN' }],
    ['meta', { property: 'og:title', content: 'Claude Code 最佳实践' }],
    ['meta', { property: 'og:site_name', content: 'Claude Code Best Practice' }]
  ],
  
  themeConfig: {
    logo: '/logo.svg',
    
    nav: [
      { text: '首页', link: '/' },
      { text: '指南', link: '/guide/' },
      { text: '最佳实践', link: '/best-practice/' },
      { 
        text: '资源', 
        items: [
          { text: '工作流', link: '/workflows/' },
          { text: '技巧', link: '/tips/' },
          { text: '视频', link: '/videos/' },
          { text: '报告', link: '/reports/' },
          { text: '实现', link: '/implementation/' }
        ]
      },
      { text: 'GitHub', link: 'https://github.com/yq-pop/claude-code-best' }
    ],
    
    sidebar: {
      '/guide/': [
        {
          text: '开始',
          items: [
            { text: '简介', link: '/guide/' },
            { text: '快速开始', link: '/guide/getting-started' },
            { text: '核心概念', link: '/guide/concepts' }
          ]
        }
      ],
      '/best-practice/': [
        {
          text: '最佳实践',
          items: [
            { text: '概览', link: '/best-practice/' },
            { text: '命令', link: '/best-practice/claude-commands' },
            { text: '技能', link: '/best-practice/claude-skills' },
            { text: '子智能体', link: '/best-practice/claude-subagents' },
            { text: '设置', link: '/best-practice/claude-settings' },
            { text: 'MCP', link: '/best-practice/claude-mcp' },
            { text: '内存', link: '/best-practice/claude-memory' },
            { text: '增强功能', link: '/best-practice/claude-power-ups' },
            { text: 'CLI 启动', link: '/best-practice/claude-cli-startup-flags' }
          ]
        }
      ]
    },
    
    socialLinks: [
      { icon: 'github', link: 'https://github.com/yq-pop/claude-code-best' }
    ],
    
    search: {
      provider: 'local'
    },
    
    footer: {
      message: '基于 MIT 协议发布',
      copyright: 'Copyright © 2026 Claude Code Best Practice'
    },
    
    editLink: {
      pattern: 'https://github.com/yq-pop/claude-code-best/edit/main/docs/:path',
      text: '在 GitHub 上编辑此页'
    }
  },
  
  markdown: {
    lineNumbers: true
  }
})
EOF

# 创建首页
echo "📝 创建首页..."
cat > index.md << 'EOF'
---
layout: home

hero:
  name: "Claude Code"
  text: "最佳实践"
  tagline: 从氛围编程到智能体工程 - 熟能生巧，让 Claude 完美运作
  image:
    src: /logo.svg
    alt: Claude Code
  actions:
    - theme: brand
      text: 开始学习
      link: /guide/
    - theme: alt
      text: 查看 GitHub
      link: https://github.com/yq-pop/claude-code-best

features:
  - icon: 📚
    title: 完整知识体系
    details: 8大核心组件，从命令、技能到子智能体，全面覆盖 Claude Code 的所有功能
  - icon: 💡
    title: 69条实战技巧
    details: Boris Cherny 和团队总结的第一手经验，让你少走弯路
  - icon: 🎯
    title: 10大工作流对比
    details: 深入分析业界主流的 Claude Code 开发工作流，找到最适合你的方案
  - icon: 🎬
    title: 精选视频教程
    details: 官方访谈和社区分享，快速掌握核心理念和最佳实践
  - icon: 📊
    title: 技术报告
    details: 9个专题深度报告，解答关键问题和常见困惑
  - icon: 💻
    title: 实现示例
    details: 可运行的示例代码和完整工作流，即学即用
  - icon: 🌐
    title: 中文友好
    details: 102个文件已翻译为简体中文，翻译完成率 96.23%
  - icon: 🔄
    title: 持续更新
    details: 跟随 Claude Code 版本持续演进，保持最新
---

## 📊 项目统计

<div style="display: flex; gap: 2rem; margin: 2rem 0;">
  <div style="text-align: center;">
    <div style="font-size: 2.5rem; font-weight: bold; color: var(--vp-c-brand);">102</div>
    <div style="font-size: 0.9rem; color: var(--vp-c-text-2);">文件已翻译</div>
  </div>
  <div style="text-align: center;">
    <div style="font-size: 2.5rem; font-weight: bold; color: var(--vp-c-brand);">96.23%</div>
    <div style="font-size: 0.9rem; color: var(--vp-c-text-2);">完成率</div>
  </div>
  <div style="text-align: center;">
    <div style="font-size: 2.5rem; font-weight: bold; color: var(--vp-c-brand);">69</div>
    <div style="font-size: 0.9rem; color: var(--vp-c-text-2);">实战技巧</div>
  </div>
</div>

## 🎓 学习路径

1. **理论学习**（1-2天）
   - 阅读核心文档，理解 8 大核心概念
   - 观看 Boris Cherny 等官方团队的视频教程
   - 学习 69 条实战技巧

2. **实践操作**（3-5天）
   - 克隆项目并运行示例
   - 体验天气工作流、智能体团队等
   - 阅读实现代码，理解架构模式

3. **应用到项目**（持续）
   - 分析自己的项目需求
   - 逐步引入最佳实践
   - 持续优化和迭代

## 🏆 项目成就

- 🌟 **GitHub Trending #1** Repository Of The Day
- 📈 **2026年3月** GitHub 月度趋势项目
- 👥 大量社区贡献和实战案例
- 📚 最全面的 Claude Code 中文学习资源

## 🚀 下一步

<div style="margin: 2rem 0;">
  <a href="/guide/" style="margin-right: 1rem;">📖 阅读指南</a>
  <a href="/best-practice/" style="margin-right: 1rem;">📚 最佳实践</a>
  <a href="/workflows/" style="margin-right: 1rem;">🔧 工作流</a>
  <a href="https://github.com/yq-pop/claude-code-best">⭐ Star on GitHub</a>
</div>
EOF

# 创建指南目录
echo "📚 创建指南目录..."
mkdir -p guide
cat > guide/index.md << 'EOF'
# 指南

欢迎来到 Claude Code Best Practice 学习指南！

## 🎯 学习目标

通过本指南，你将：

1. 理解 Claude Code 的核心概念
2. 掌握最佳实践和工作流
3. 学会构建自己的命令、技能和子智能体
4. 提升 AI 辅助开发效率

## 📖 内容概览

- [快速开始](/guide/getting-started) - 5分钟上手
- [核心概念](/guide/concepts) - 8大核心组件详解
- [学习路径](/guide/learning-path) - 系统化学习计划

## 🚀 开始学习

如果你是第一次接触 Claude Code，建议按以下顺序学习：

1. 先阅读 [快速开始](/guide/getting-started)
2. 再学习 [核心概念](/guide/concepts)
3. 然后查看 [最佳实践](/best-practice/)
4. 最后实践 [工作流示例](/workflows/)

## 💡 学习建议

- **理论与实践结合** - 边学边练
- **不要跳过基础** - 核心概念很重要
- **多看示例代码** - 理解实现细节
- **持续实践** - 应用到实际项目中

让我们开始吧！👉 [快速开始](/guide/getting-started)
EOF

# 复制内容
echo "📦 复制项目内容..."
cd ..
cp -r best-practice docs/
cp -r reports docs/
cp -r tips docs/
cp -r videos docs/
cp -r implementation docs/
cp -r tutorial docs/
cp -r orchestration-workflow docs/workflows/orchestration
cp -r development-workflows docs/workflows/

# 复制资源
mkdir -p docs/public
cp -r '!' docs/public/ 2>/dev/null || true

# 创建 .gitignore
echo "🔒 创建 .gitignore..."
cat > docs/.gitignore << 'EOF'
node_modules
.vitepress/dist
.vitepress/cache
.DS_Store
EOF

echo ""
echo "✅ 网站设置完成！"
echo ""
echo "📝 接下来的步骤："
echo ""
echo "1. 进入 docs 目录:"
echo "   cd docs"
echo ""
echo "2. 启动开发服务器:"
echo "   npm run docs:dev"
echo ""
echo "3. 在浏览器访问:"
echo "   http://localhost:5173"
echo ""
echo "4. 构建生产版本:"
echo "   npm run docs:build"
echo ""
echo "🎉 祝你成功！"
