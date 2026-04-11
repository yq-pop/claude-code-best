# Scheduled Tasks 实现

![最后更新](https://img.shields.io/badge/Last_Updated-Mar_10%2C_2026-white?style=flat&labelColor=555)

<table width="100%">
<tr>
<td><a href="../">← 返回 Claude Code Best Practice</a></td>
<td align="right"><img src="/claude-jumping.svg" alt="Claude" width="60" /></td>
</tr>
</table>

---

<a href="#loop-demo"><img src="/tags/implemented-hd.svg" alt="已实现"></a>

`/loop` skill 用于按 cron 间隔调度循环任务。以下是 `/loop 1m "tell current time"` 的演示——一个每分钟触发的简单循环任务。

---

## Loop 演示

### 1. 调度任务

<p align="center">
  <img src="./assets/impl-loop-1.png" alt="/loop 1m tell current time — 调度和 cron 设置" width="100%">
</p>

`/loop 1m "tell current time"` 解析间隔（`1m` → 每 1 分钟），创建 cron 作业，并确认调度。关键要点：

- Cron 的最小粒度是 **1 分钟** — `1m` 映射到 `*/1 * * * *`
- 循环任务 **3 天后自动过期**
- 作业是 **会话范围的** — 它们仅存在于内存中，当 Claude 退出时停止
- 随时使用 `cron cancel <job-id>` 取消

---

### 2. Loop 实战

<p align="center">
  <img src="./assets/impl-loop-2.png" alt="每分钟触发的循环任务" width="100%">
</p>

任务每分钟触发一次，运行 `date` 并报告当前时间。每次迭代都会触发异步 **UserPromptSubmit** 和 **Stop** hooks——与本仓库中用于声音通知的 hook 系统相同。

---

## ![如何使用](/tags/how-to-use.svg)

```bash
$ claude
> /loop 1m "tell current time"
> /loop 5m /simplify
> /loop 10m "check deploy status"
```

---

## ![如何实现](/tags/how-to-implement.svg)

`/loop` 是内置的 Claude Code skill——无需设置。它在底层使用 cron 工具（`CronCreate`、`CronList`、`CronDelete`）来管理循环调度。
