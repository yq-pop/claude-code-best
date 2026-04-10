# 🚀 快速开始 - 5分钟搭建网站

## 方案选择

我为你提供了 **4 个方案**，推荐按优先级选择：

### ⭐ 方案一：VitePress（最推荐）
- ✅ **最快**：2-3天完成
- ✅ **最简单**：几乎零配置
- ✅ **最适合**：技术文档
- ✅ **性能最好**：基于 Vite

### 🎯 方案二：Docusaurus
- ✅ Meta 出品，生态成熟
- ✅ 博客功能强大
- ⏱️ 3-5天完成

### 🚀 方案三：Astro
- ✅ 性能极致
- ✅ 高度可定制
- ⏱️ 4-6天完成

### 📘 方案四：Nextra
- ✅ 基于 Next.js
- ✅ 支持 MDX
- ⏱️ 3-4天完成

---

## 🎯 推荐：VitePress 快速部署

### 第一步：初始化项目（5分钟）

```bash
# 在项目根目录
cd claude-code-best-practice

# 创建 docs 目录
mkdir docs
cd docs

# 初始化 VitePress
npm init vitepress@latest

# 选择配置
# ✔ Current directory is not empty. Continue? › Yes
# ✔ Install and use TypeScript? › Yes
# ✔ Add VitePress npm scripts? › Yes

# 安装依赖
npm install
```

### 第二步：配置网站（10分钟）

创建 `.vitepress/config.ts`:

```typescript
import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Claude Code 最佳实践',
  description: '从氛围编程到智能体工程',
  
  themeConfig: {
    nav: [
      { text: '首页', link: '/' },
      { text: '指南', link: '/guide/' },
      { text: '最佳实践', link: '/best-practice/' },
      { text: 'GitHub', link: 'https://github.com/yq-pop/claude-code-best' }
    ],
    
    sidebar: {
      '/best-practice/': [
        {
          text: '最佳实践',
          items: [
            { text: '命令', link: '/best-practice/claude-commands' },
            { text: '技能', link: '/best-practice/claude-skills' },
            { text: '子智能体', link: '/best-practice/claude-subagents' }
          ]
        }
      ]
    },
    
    socialLinks: [
      { icon: 'github', link: 'https://github.com/yq-pop/claude-code-best' }
    ]
  }
})
```

### 第三步：创建首页（5分钟）

创建 `docs/index.md`:

```markdown
---
layout: home

hero:
  name: "Claude Code"
  text: "最佳实践"
  tagline: 从氛围编程到智能体工程
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
    details: 8大核心组件，从命令、技能到子智能体，全面覆盖
  - icon: 💡
    title: 69条实战技巧
    details: Boris Cherny 等官方团队总结的第一手经验
  - icon: 🎯
    title: 10大工作流对比
    details: 深入分析业界主流的 Claude Code 开发工作流
  - icon: 🎬
    title: 精选视频教程
    details: 官方访谈和社区分享，快速上手
  - icon: 📊
    title: 技术报告
    details: 9个专题深度报告，解答关键问题
  - icon: 💻
    title: 实现示例
    details: 可运行的示例代码，即学即用
---
```

### 第四步：迁移内容（15分钟）

```bash
# 复制现有文档
cp -r ../best-practice ./
cp -r ../reports ./
cp -r ../tips ./
cp -r ../videos ./
cp -r ../implementation ./
cp -r ../tutorial ./

# 复制资源文件
cp -r ../'!' ./public/
```

### 第五步：启动预览（1分钟）

```bash
# 启动开发服务器
npm run docs:dev

# 浏览器访问
# http://localhost:5173
```

### 第六步：部署上线（10分钟）

**选项 A：GitHub Pages**

```bash
# 构建
npm run docs:build

# 部署
npm run docs:deploy
```

**选项 B：Vercel（推荐）**

1. 登录 https://vercel.com
2. 导入 GitHub 仓库
3. 配置：
   - Framework Preset: VitePress
   - Root Directory: `docs`
4. 点击 Deploy

**选项 C：Netlify**

1. 登录 https://netlify.com
2. 连接 GitHub 仓库
3. 配置：
   - Build command: `npm run docs:build`
   - Publish directory: `docs/.vitepress/dist`
4. 部署

---

## 📋 完整清单

### ✅ 必做事项

- [ ] 初始化 VitePress 项目
- [ ] 配置 `config.ts`
- [ ] 创建首页
- [ ] 迁移所有 Markdown 文件
- [ ] 复制图片资源
- [ ] 调整内部链接
- [ ] 测试所有页面
- [ ] 配置部署

### 🎨 可选增强

- [ ] 自定义主题颜色
- [ ] 添加自定义组件
- [ ] 集成 Mermaid.js
- [ ] 添加评论系统
- [ ] 配置 SEO
- [ ] 添加分析工具
- [ ] 配置 PWA
- [ ] 多语言支持

---

## 🎯 3天完成计划

### Day 1：基础搭建
- ⏰ 上午：初始化项目 + 配置
- ⏰ 下午：创建首页 + 迁移内容

### Day 2：功能开发
- ⏰ 上午：调整链接 + 优化布局
- ⏰ 下午：自定义组件 + 主题

### Day 3：部署上线
- ⏰ 上午：测试 + 优化
- ⏰ 下午：部署 + 域名配置

---

## 💡 专业提示

1. **使用 Git 分支**
   ```bash
   git checkout -b feature/website
   ```

2. **定期提交**
   ```bash
   git add .
   git commit -m "feat: add website structure"
   ```

3. **预览部署**
   - Vercel 和 Netlify 都支持 PR 预览
   - 可以在合并前查看效果

4. **性能优化**
   - 压缩图片（使用 TinyPNG）
   - 启用 Gzip
   - 配置 CDN

---

## 🆘 常见问题

**Q: 图片显示不出来？**
A: 将所有图片放到 `docs/public/` 目录，然后用 `/image.png` 引用

**Q: 链接跳转 404？**
A: 检查链接路径，相对路径要正确：`./file.md` 或 `/path/file.md`

**Q: 构建失败？**
A: 检查 Node.js 版本（需要 18+），清除 node_modules 重新安装

**Q: 部署后样式丢失？**
A: 检查 `base` 配置，GitHub Pages 需要设置 base 为仓库名

---

## 🎉 完成！

按照上面的步骤，你可以在 **1小时内** 完成基础网站搭建！

接下来：
1. 📝 完善内容
2. 🎨 自定义样式
3. 🚀 推广网站
4. 📊 收集反馈

**祝你成功！** 🎊
