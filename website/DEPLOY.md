# 🚀 部署指南

将网站部署到生产环境的完整指南。

## 📋 部署前检查

- [ ] 所有页面都能正常访问
- [ ] 链接都能正确跳转
- [ ] 图片资源都能加载
- [ ] 搜索功能正常工作
- [ ] 移动端显示正常

## 🌐 部署选项

### 方案 1: Vercel（推荐）⭐⭐⭐⭐⭐

**优势**: 一键部署、全球 CDN、自动 HTTPS、PR 预览

#### 步骤：

1. **推送到 GitHub**
```bash
git add .
git commit -m "feat: 添加网站项目"
git push origin main
```

2. **登录 Vercel**
   - 访问 https://vercel.com
   - 使用 GitHub 账号登录

3. **导入项目**
   - 点击 "New Project"
   - 选择 `claude-code-best` 仓库
   - 配置：
     - Framework Preset: **VitePress**
     - Root Directory: **website**
     - Build Command: `npm run build`
     - Output Directory: `.vitepress/dist`

4. **部署**
   - 点击 "Deploy"
   - 等待 2-3 分钟
   - 完成！🎉

5. **配置自定义域名**（可选）
   - 在项目设置中添加域名
   - 配置 DNS CNAME 记录
   - 等待 SSL 证书自动配置

**预计时间**: 5-10 分钟

---

### 方案 2: GitHub Pages

#### 自动部署方式

创建 `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main
    paths:
      - 'website/**'

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      
      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: 18
          cache: npm
          cache-dependency-path: website/package-lock.json
      
      - name: Install dependencies
        run: |
          cd website
          npm ci
      
      - name: Build
        run: |
          cd website
          npm run build
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v2
        with:
          path: website/.vitepress/dist
  
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v2
```

#### 配置 VitePress base

在 `.vitepress/config.ts` 中添加：

```typescript
export default defineConfig({
  base: '/claude-code-best/',  // 仓库名
  // ... 其他配置
})
```

**预计时间**: 15-20 分钟

---

### 方案 3: Netlify

#### 步骤：

1. **创建 netlify.toml**

```toml
[build]
  base = "website"
  command = "npm run build"
  publish = ".vitepress/dist"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

2. **登录 Netlify**
   - 访问 https://netlify.com
   - 连接 GitHub 账号

3. **导入项目**
   - 点击 "Add new site"
   - 选择仓库
   - 配置会自动识别

4. **部署**
   - 点击 "Deploy site"
   - 完成！

**预计时间**: 10-15 分钟

---

### 方案 4: Cloudflare Pages

#### 步骤：

1. **登录 Cloudflare**
   - 访问 https://pages.cloudflare.com
   - 登录账号

2. **创建项目**
   - 连接 GitHub
   - 选择仓库
   - 配置：
     - Framework: **VitePress**
     - Build command: `cd website && npm run build`
     - Build output: `website/.vitepress/dist`

3. **部署**
   - 自动部署
   - 享受无限带宽！

**预计时间**: 10 分钟

---

## 🔧 部署配置

### 环境变量

如果需要配置环境变量（如分析工具）：

```env
# .env.production
VITE_GA_ID=your-google-analytics-id
VITE_SITE_URL=https://your-domain.com
```

### 构建优化

```typescript
// .vitepress/config.ts
export default defineConfig({
  // 生成 sitemap
  sitemap: {
    hostname: 'https://your-domain.com'
  },
  
  // 压缩
  vite: {
    build: {
      minify: 'terser',
      chunkSizeWarningLimit: 1000
    }
  }
})
```

## 📊 性能优化

### 图片优化

```bash
# 使用 TinyPNG 或 ImageOptim 压缩图片
# 将大图放到 CDN
```

### 代码分割

VitePress 自动进行代码分割，无需额外配置。

### CDN 配置

所有推荐的部署平台都自带全球 CDN。

## 🔍 SEO 优化

### Meta 标签

已在 `config.ts` 中配置：
- ✅ Open Graph 标签
- ✅ Twitter Card
- ✅ 网站描述
- ✅ 关键词

### Sitemap

```typescript
export default defineConfig({
  sitemap: {
    hostname: 'https://your-domain.com'
  }
})
```

### robots.txt

```txt
User-agent: *
Allow: /
Sitemap: https://your-domain.com/sitemap.xml
```

## 📈 分析工具

### Google Analytics

```typescript
// .vitepress/config.ts
export default defineConfig({
  head: [
    [
      'script',
      { async: '', src: 'https://www.googletagmanager.com/gtag/js?id=G-YOUR-ID' }
    ],
    [
      'script',
      {},
      `window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'G-YOUR-ID');`
    ]
  ]
})
```

## 🆘 常见问题

### Q: 部署后样式丢失？
A: 检查 `base` 配置是否正确设置为仓库名。

### Q: 图片显示 404？
A: 确保图片在 `public/` 目录，并使用 `/image.png` 引用。

### Q: 构建失败？
A: 检查 Node.js 版本（需要 18+），清除缓存重新构建。

### Q: 如何更新内容？
A: 修改 Markdown 文件，推送到 GitHub，自动重新部署。

## 🎯 部署清单

### 基础部署
- [ ] 选择部署平台
- [ ] 配置构建参数
- [ ] 验证部署成功
- [ ] 测试所有功能

### 高级配置
- [ ] 配置自定义域名
- [ ] 添加 SSL 证书
- [ ] 设置 CDN 加速
- [ ] 配置分析工具
- [ ] 添加评论系统（可选）

### 持续维护
- [ ] 监控网站性能
- [ ] 定期更新内容
- [ ] 收集用户反馈
- [ ] 优化 SEO

## 🎉 部署成功！

恭喜！你的网站已经上线了。

**接下来**:
- 📊 监控访问数据
- 📝 持续更新内容
- 💬 与用户互动
- 🚀 推广你的网站

---

**需要帮助？** [提交 Issue](https://github.com/yq-pop/claude-code-best/issues)
