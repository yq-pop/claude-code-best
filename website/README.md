# Claude Code Best Practice 网站

现代化的技术博客网站，完整展示 Claude Code 最佳实践的所有教程、文档和资源。

## 🚀 快速开始

### 安装依赖

```bash
npm install
```

### 启动开发服务器

```bash
npm run dev
```

浏览器访问: http://localhost:5173

### 构建生产版本

```bash
npm run build
```

### 预览生产构建

```bash
npm run preview
```

## 📂 项目结构

```
website/
├── .vitepress/
│   ├── config.ts              # 网站配置
│   └── theme/                 # 自定义主题
│       ├── index.ts
│       ├── Layout.vue         # 自定义布局
│       └── styles/            # 样式文件
│           ├── vars.css       # CSS 变量
│           ├── custom.css     # 自定义样式
│           └── animations.css # 动画效果
│
├── index.md                   # 首页
├── guide/                     # 指南
│   ├── index.md
│   ├── getting-started.md
│   └── concepts.md
│
├── best-practice/             # 最佳实践（8个文档）
├── tips/                      # 技巧集锦（69条）
├── videos/                    # 视频教程（6个）
├── reports/                   # 技术报告（9个）
├── implementation/            # 实现示例（5个）
├── workflows/                 # 工作流
├── tutorial/                  # 教程
└── public/                    # 静态资源
```

## 🎨 设计特点

### 美学方向
**精致极简主义 + 技术感边缘**

### 设计元素
- 🎨 **独特字体**: Outfit（标题）+ JetBrains Mono（代码）
- 🌈 **渐变配色**: 紫色到蓝色的品牌渐变
- ✨ **流畅动画**: 悬停效果、页面过渡、微交互
- 📱 **响应式设计**: 完美适配各种设备
- 🌓 **主题切换**: 支持深色/浅色模式

### 特色功能
- ✅ 全文搜索
- ✅ 多级侧边栏导航
- ✅ 代码高亮和行号
- ✅ 交互式统计卡片
- ✅ 学习路径可视化
- ✅ Mermaid 流程图支持

## 🚀 部署

### Vercel（推荐）

1. 推送代码到 GitHub
2. 在 Vercel 导入仓库
3. 配置：
   - Framework: VitePress
   - Root Directory: `website`
4. 自动部署

### GitHub Pages

```bash
# 构建并部署
npm run build
# 将 .vitepress/dist 推送到 gh-pages 分支
```

### Netlify

```toml
# netlify.toml
[build]
  command = "npm run build"
  publish = ".vitepress/dist"
```

## 📚 内容说明

所有内容已从主项目复制：

- ✅ **102个文件** 已翻译为中文（96.23%）
- ✅ **零遗漏** 所有教程和文档
- ✅ **保持结构** 原有的文件组织
- ✅ **自动链接** 内部链接自动调整

## 🛠️ 技术栈

- ⚡ **VitePress** ^1.1.4 - 静态站点生成器
- 🎨 **Vue 3** ^3.4.21 - 组件框架
- 📦 **@vueuse/core** ^10.9.0 - Vue 组合式 API 工具库

## 📝 许可证

MIT License - 查看 [LICENSE](../LICENSE) 文件

## 🌟 贡献

欢迎贡献！请查看主项目的贡献指南。

---

**主项目**: https://github.com/yq-pop/claude-code-best
