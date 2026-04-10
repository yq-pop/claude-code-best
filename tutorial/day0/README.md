# Day 0 — Claude Code 安装

本指南将引导您在计算机上安装 Claude Code 并进行身份验证,以便开始使用。

## 步骤 1: 安装 Claude Code

选择您的操作系统:

| 操作系统 | 指南 |
|----|-------|
| Windows | [windows.md](windows.md) |
| Linux | [linux.md](linux.md) |
| macOS | [mac.md](mac.md) |

按照适合您操作系统的指南操作,然后返回此处进行身份验证。

---

## 步骤 2: 验证安装

按照特定于操作系统的指南操作后,确认一切正常:

```bash
node --version    # 应显示 v18.x 或更高版本
claude --version  # 应显示已安装的 Claude Code 版本
```

---

## 步骤 3: 登录

<img src="assets/login.png" alt="Claude Code 登录界面" width="50%">

在终端中运行 `claude`。首次启动时,它会要求您选择登录方法。

### 方法 1: 订阅 (Claude Pro / Max)

- 选择 **Claude.ai account**
- 浏览器打开 — 登录并授权
- 返回终端,您已登录

### 方法 2a: API 密钥 (团队邀请)

您的团队管理员从 Anthropic 仪表板邀请您。

- 您会收到一封**邀请邮件** — 接受邀请并创建您的 Anthropic 账户
- 在终端中运行 `claude`
- 选择 **Anthropic API Key**
- 您的密钥在仪表板上**自动生成** — 无需手动设置
- Claude Code 立即开始工作

### 方法 2b: API 密钥 (您已有密钥)

如果有人与您共享了密钥 (通过 Slack、电子邮件等) 或您自己创建了密钥:

- 在终端中运行 `claude`
- 选择 **Anthropic API Key**
- 粘贴您的密钥 (以 `sk-ant-` 开头)
- 密钥会被**永久存储** — 不会再次询问

---