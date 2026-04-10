---
name: presentation-structure
description: 关于演示文稿幻灯片格式、权重系统、导航和章节结构的知识
---

# 演示文稿结构技能

关于 `presentation/index.html` 演示文稿结构的知识。

## 文件位置

`presentation/index.html` — 带内联 CSS 和 JS 的单文件 HTML 演示文稿。

## 幻灯片格式

每张幻灯片都是一个带有 `data-slide`（顺序编号）和可选 `data-level`（转换点的旅程级别）的 div：

```html
<!-- 常规幻灯片 — 从前一个 data-level 幻灯片继承级别 -->
<div class="slide" data-slide="12">
    <h1>幻灯片标题</h1>
    <!-- 内容 -->
</div>

<!-- 级别转换幻灯片 — 为此幻灯片及之后所有幻灯片设置新级别 -->
<div class="slide section-slide" data-slide="10" data-level="low">
    <h1>章节名称</h1>
    <p class="section-desc">级别：Low — 此章节的描述</p>
</div>

<!-- 标题幻灯片（居中） -->
<div class="slide title-slide" data-slide="1">
    <h1>演示文稿标题</h1>
    <p class="subtitle">副标题文本</p>
</div>
```

## 旅程条级别系统

演示文稿使用 4 级系统而非累积百分比：

- 级别通过关键转换幻灯片（章节分隔符）上的 `data-level` 属性设置
- `data-level` 幻灯片之后的所有幻灯片都继承该级别，直到下一个转换
- 旅程条分别填充到 Low / Medium / High / Pro 的 25% / 50% / 75% / 100%
- 在幻灯片 1（标题幻灯片）上隐藏条；从幻灯片 2 开始显示条
- 第一个 `data-level` 之前的幻灯片（幻灯片 2–9）显示空条（尚未设置级别）
- `.level-badge` 由 JS 注入到带有 `data-level` 的幻灯片的 `<h1>` 上 — 不要在 HTML 中硬编码

### 按章节的级别转换

| 章节 | 幻灯片范围 | data-level | 条高度 |
|---------|-------------|------------|------------|
| 第 0 部分：介绍 | 幻灯片 1-4 | (无) | 隐藏 / 空 |
| 第 1 部分：先决条件 | 幻灯片 5-9 | (无) | 空 |
| 第 2 部分：更好的提示 | 幻灯片 10-17 | `low` | 25% |
| 第 3 部分：项目记忆 | 幻灯片 18-24 | `medium` | 50% |
| 第 4 部分：结构化工作流程 | 幻灯片 25-28 | (继承 medium) | 50% |
| 第 5 部分：领域知识 | 幻灯片 29-33 | `high` | 75% |
| 第 6 部分：代理工程 | 幻灯片 34-46 | `high` | 75% |
| 附录 | 幻灯片 47+ | (继承 high) | 75% |

## 导航系统

- `goToSlide(n)` — 在 TOC 链接中使用，必须匹配实际的 `data-slide` 编号
- `totalSlides` 从 DOM 自动计算（`document.querySelectorAll('[data-slide]').length`）
- 箭头键、空格键和触摸滑动用于导航
- 幻灯片计数器在左下角显示 `当前 / 总计`

## 重新编号规则

添加、删除或重新排序幻灯片后：
1. 从 1 开始顺序重新编号所有 `data-slide` 属性
2. 更新 TOC/旅程地图幻灯片中的所有 `goToSlide()` 调用
3. JS `totalSlides` 自动计算 — 无需手动更新
4. 验证不存在间隙或重复

## 章节分隔符格式

章节分隔符使用 `section-slide` 类。级别转换章节分隔符带有 `data-level` 并在描述中显示级别名称：

```html
<div class="slide section-slide" data-slide="10" data-level="low">
    <p class="section-number">第 2 部分</p>
    <h1>更好的提示</h1>
    <p class="section-desc">级别：Low — 获得真实结果的有效提示。</p>
</div>
```

JS 将在运行时在级别转换时向 `<h1>` 注入 `.level-badge`（例如"→ Low"）— 不要在 HTML 中手动添加这些。
