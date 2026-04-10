# Claude Code Best Practice - 网站自动部署脚本 (PowerShell)
# 使用方法: .\setup-website.ps1

Write-Host "🚀 开始设置 Claude Code Best Practice 网站..." -ForegroundColor Green
Write-Host ""

# 检查 Node.js
try {
    $nodeVersion = node -v
    Write-Host "✅ Node.js 版本: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ 错误: 未找到 Node.js" -ForegroundColor Red
    Write-Host "请先安装 Node.js: https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}
Write-Host ""

# 创建 docs 目录
Write-Host "📁 创建 docs 目录..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path "docs" | Out-Null
Set-Location "docs"

# 初始化 package.json
Write-Host "📦 初始化项目..." -ForegroundColor Cyan
@"
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
"@ | Out-File -FilePath "package.json" -Encoding UTF8

# 安装依赖
Write-Host "📥 安装依赖（这可能需要几分钟）..." -ForegroundColor Cyan
npm install

# 创建 .vitepress 目录
Write-Host "⚙️ 创建配置文件..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path ".vitepress\theme\components" | Out-Null
New-Item -ItemType Directory -Force -Path ".vitepress\theme\styles" | Out-Null

# 创建配置文件
@"
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
"@ | Out-File -FilePath ".vitepress\config.ts" -Encoding UTF8

# 创建首页
Write-Host "📝 创建首页..." -ForegroundColor Cyan
@"
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
"@ | Out-File -FilePath "index.md" -Encoding UTF8

# 创建指南目录
Write-Host "📚 创建指南目录..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path "guide" | Out-Null
@"
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

让我们开始吧！👉 [快速开始](/guide/getting-started)
"@ | Out-File -FilePath "guide\index.md" -Encoding UTF8

# 复制内容
Write-Host "📦 复制项目内容..." -ForegroundColor Cyan
Set-Location ..

$folders = @(
    "best-practice",
    "reports",
    "tips",
    "videos",
    "implementation",
    "tutorial"
)

foreach ($folder in $folders) {
    if (Test-Path $folder) {
        Copy-Item -Path $folder -Destination "docs\" -Recurse -Force
        Write-Host "  ✓ 已复制 $folder" -ForegroundColor Green
    }
}

# 复制工作流
if (Test-Path "orchestration-workflow") {
    New-Item -ItemType Directory -Force -Path "docs\workflows\orchestration" | Out-Null
    Copy-Item -Path "orchestration-workflow\*" -Destination "docs\workflows\orchestration\" -Recurse -Force
    Write-Host "  ✓ 已复制 orchestration-workflow" -ForegroundColor Green
}

if (Test-Path "development-workflows") {
    Copy-Item -Path "development-workflows" -Destination "docs\workflows\" -Recurse -Force
    Write-Host "  ✓ 已复制 development-workflows" -ForegroundColor Green
}

# 复制资源
New-Item -ItemType Directory -Force -Path "docs\public" | Out-Null
if (Test-Path "!") {
    Copy-Item -Path "!\*" -Destination "docs\public\" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  ✓ 已复制资源文件" -ForegroundColor Green
}

# 创建 .gitignore
@"
node_modules
.vitepress/dist
.vitepress/cache
.DS_Store
"@ | Out-File -FilePath "docs\.gitignore" -Encoding UTF8

Write-Host ""
Write-Host "✅ 网站设置完成！" -ForegroundColor Green
Write-Host ""
Write-Host "📝 接下来的步骤：" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. 进入 docs 目录:" -ForegroundColor Cyan
Write-Host "   cd docs"
Write-Host ""
Write-Host "2. 启动开发服务器:" -ForegroundColor Cyan
Write-Host "   npm run docs:dev"
Write-Host ""
Write-Host "3. 在浏览器访问:" -ForegroundColor Cyan
Write-Host "   http://localhost:5173"
Write-Host ""
Write-Host "4. 构建生产版本:" -ForegroundColor Cyan
Write-Host "   npm run docs:build"
Write-Host ""
Write-Host "🎉 祝你成功！" -ForegroundColor Green
