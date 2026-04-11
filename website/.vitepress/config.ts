import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Claude Code 最佳实践',
  description: '从氛围编程到智能体工程 - 熟能生巧，让 Claude 完美运作',
  lang: 'zh-CN',
  appearance: false,
  ignoreDeadLinks: true,
  
  head: [
    ['link', { rel: 'icon', type: 'image/svg+xml', href: '/logo.svg' }],
    ['meta', { name: 'theme-color', content: '#7c3aed' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:locale', content: 'zh_CN' }],
    ['meta', { property: 'og:title', content: 'Claude Code 最佳实践' }],
    ['meta', { property: 'og:description', content: '从氛围编程到智能体工程 - 熟能生巧，让 Claude 完美运作' }],
    ['meta', { property: 'og:site_name', content: 'Claude Code Best Practice' }],
    // Google Fonts
    ['link', { rel: 'preconnect', href: 'https://fonts.googleapis.com' }],
    ['link', { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' }],
    ['link', { href: 'https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&family=Outfit:wght@300;400;500;600;700;800&display=swap', rel: 'stylesheet' }]
  ],
  
  themeConfig: {
    logo: '/logo.svg',
    
    nav: [
      { text: '首页', link: '/' },
      { text: '指南', link: '/guide/' },
      { text: '最佳实践', link: '/best-practice/' },
      { text: '技巧', link: '/tips/' },
      {
        text: '更多',
        items: [
          { text: '🎬 视频教程', link: '/videos/' },
          { text: '📊 技术报告', link: '/reports/' },
          { text: '💻 实现示例', link: '/implementation/' },
          { text: '🔧 工作流', link: '/workflows/' }
        ]
      }
    ],
    
    sidebar: {
      '/guide/': [
        {
          text: '指南',
          items: [
            { text: '简介', link: '/guide/' },
            { text: '快速开始', link: '/guide/getting-started' },
            { text: '核心概念', link: '/guide/concepts' },
            { text: '学习路径', link: '/guide/learning-path' }
          ]
        }
      ],
      
      '/best-practice/': [
        {
          text: '最佳实践',
          items: [
            { text: '概览', link: '/best-practice/' },
            { text: '命令 (Commands)', link: '/best-practice/claude-commands' },
            { text: '技能 (Skills)', link: '/best-practice/claude-skills' },
            { text: '子智能体 (Agents)', link: '/best-practice/claude-subagents' },
            { text: '设置 (Settings)', link: '/best-practice/claude-settings' },
            { text: 'MCP 服务器', link: '/best-practice/claude-mcp' },
            { text: '内存管理', link: '/best-practice/claude-memory' },
            { text: '增强功能', link: '/best-practice/claude-power-ups' },
            { text: 'CLI 启动标志', link: '/best-practice/claude-cli-startup-flags' }
          ]
        }
      ],
      
      '/workflows/': [
        {
          text: '开发工作流',
          items: [
            { text: '概览', link: '/workflows/' }
          ]
        }
      ],
      
      '/tips/': [
        {
          text: '技巧集锦',
          items: [
            { text: '全部技巧 (69条)', link: '/tips/' },
            { text: 'Boris 13条技巧', link: '/tips/claude-boris-13-tips-03-jan-26' },
            { text: 'Boris 10条技巧', link: '/tips/claude-boris-10-tips-01-feb-26' },
            { text: 'Boris 12条技巧', link: '/tips/claude-boris-12-tips-12-feb-26' },
            { text: 'Boris 15条技巧', link: '/tips/claude-boris-15-tips-30-mar-26' },
            { text: 'Boris 2条技巧 (3/10)', link: '/tips/claude-boris-2-tips-10-mar-26' },
            { text: 'Boris 2条技巧 (3/25)', link: '/tips/claude-boris-2-tips-25-mar-26' },
            { text: 'Thariq 技巧', link: '/tips/claude-thariq-tips-17-mar-26' }
          ]
        }
      ],
      
      '/videos/': [
        {
          text: '视频教程',
          items: [
            { text: '全部视频', link: '/videos/' },
            { text: 'Ryan Peterman 访谈', link: '/videos/claude-boris-ryan-peterman-15-dec-25' },
            { text: 'Every 播客', link: '/videos/claude-cat-every-29-oct-25' }
          ]
        }
      ],
      
      '/reports/': [
        {
          text: '技术报告',
          items: [
            { text: '全部报告', link: '/reports/' },
            { text: 'Agent SDK vs CLI', link: '/reports/claude-agent-sdk-vs-cli-system-prompts' },
            { text: '浏览器自动化', link: '/reports/claude-in-chrome-v-chrome-devtools-mcp' },
            { text: 'Global vs Project', link: '/reports/claude-global-vs-project-settings' },
            { text: 'Monorepo 技能', link: '/reports/claude-skills-for-larger-mono-repos' },
            { text: 'Agent Memory', link: '/reports/claude-agent-memory' },
            { text: 'Advanced Tool Use', link: '/reports/claude-advanced-tool-use' },
            { text: 'Usage & Limits', link: '/reports/claude-usage-and-rate-limits' },
            { text: 'Agents vs Commands', link: '/reports/claude-agent-command-skill' },
            { text: 'LLM Degradation', link: '/reports/llm-day-to-day-degradation' }
          ]
        }
      ],
      
      '/implementation/': [
        {
          text: '实现示例',
          items: [
            { text: '全部示例', link: '/implementation/' },
            { text: '子智能体实现', link: '/implementation/claude-subagents-implementation' },
            { text: '命令实现', link: '/implementation/claude-commands-implementation' },
            { text: '技能实现', link: '/implementation/claude-skills-implementation' },
            { text: '定时任务', link: '/implementation/claude-scheduled-tasks-implementation' },
            { text: '智能体团队', link: '/implementation/claude-agent-teams-implementation' }
          ]
        }
      ]
    },
    
    socialLinks: [],
    
    search: {
      provider: 'local',
      options: {
        translations: {
          button: {
            buttonText: '搜索文档',
            buttonAriaLabel: '搜索文档'
          },
          modal: {
            noResultsText: '无法找到相关结果',
            resetButtonTitle: '清除查询条件',
            footer: {
              selectText: '选择',
              navigateText: '切换',
              closeText: '关闭'
            }
          }
        }
      }
    },
    
    footer: {
      message: '基于 <a href="https://github.com/yq-pop/claude-code-best/blob/main/LICENSE" target="_blank">MIT 协议</a>发布',
      copyright: 'Copyright © 2026 Claude Code Best Practice'
    },
    
    editLink: {
      pattern: 'https://github.com/yq-pop/claude-code-best/edit/main/website/:path',
      text: '在 GitHub 上编辑此页'
    },
    
    lastUpdated: {
      text: '最后更新',
      formatOptions: {
        dateStyle: 'short',
        timeStyle: 'short'
      }
    },
    
    docFooter: {
      prev: '上一页',
      next: '下一页'
    },
    
    outline: {
      label: '页面导航',
      level: [2, 3]
    },
    
    returnToTopLabel: '回到顶部',
    sidebarMenuLabel: '菜单',
    darkModeSwitchLabel: '主题',
    lightModeSwitchTitle: '切换到浅色模式',
    darkModeSwitchTitle: '切换到深色模式'
  },
  
  markdown: {
    lineNumbers: true,
    theme: {
      light: 'github-light',
      dark: 'github-dark'
    }
  }
})
