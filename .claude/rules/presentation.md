# Glob: presentation/**

## 委派规则

任何更新、修改或修复演示文稿（`presentation/index.html`）的请求都必须由 `presentation-curator` 智能体处理。始终通过 Task 工具将演示文稿工作委派给此智能体 — 永远不要直接编辑演示文稿。

```
Task(subagent_type="presentation-curator", description="...", prompt="...")
```

## 原因

presentation-curator 智能体拥有三个预加载的技能，使其与演示文稿的结构、样式和概念框架保持同步。它还会在每次执行后自我演化，更新自己的技能以防止知识漂移。绕过该智能体可能会破坏幻灯片编号、级别转换或样式一致性。
