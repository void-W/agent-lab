---
name: development-workflow
description: agent-lab 的完整交付流程：需求澄清、OpenSpec 行为契约、worktree 隔离、TDD、本地门禁、PR、评审、归档与合并清理。涉及生产/测试代码、脚本、构建/CI、依赖或公共契约时使用。
---

# Development Workflow

## 开始前

1. 读根 `AGENTS.md`；进入子目录时再读该目录最近的 `AGENTS.md`。
2. 按 AGENTS 的任务分级确认级别；只有完整流程才走下面的状态机。
3. 完整流程先加载 `test-driven-development` skill，再动生产代码。
4. 检查工作树，保护已有修改；新增产物时先看 README 产物表。

## 状态机

```text
定位 baseline
  → 建 <type>/<slug> 分支 + 独立 worktree
  → 创建 OpenSpec change
  → proposal + 行为 spec + tasks（design 按需）
  → 用户确认行为契约
  → RED
  → GREEN / REFACTOR
  → 本地门禁（make verify + 适用的 race/spec）
  → PR + CI
  → 自审 / 可选子 agent 复核
  → OpenSpec archive
  → squash merge
  → 删除 worktree、同步 baseline
```

任何一步失败先定位根因；不得删除断言、放宽规则或绕过 hook 获得假绿。

## OpenSpec

先进入仓库根，再通过固定版本入口执行：

```bash
make openspec ARGS='list --json'
make openspec ARGS='status --change <name> --json'
make openspec ARGS='instructions <artifact> --change <name> --json'
make openspec ARGS='archive <name> -y'
```

一个 change 只解决一个问题；跨产物变更在 proposal 列出受影响产物与实现顺序。

## 暂停门

- 行为契约写完，等待确认；
- 多个方案取舍会改变公开契约或长期结构；
- spec 与可行实现冲突；
- 同一 PR 自动修复两轮仍失败；
- 需要破坏性操作或扩大范围。

## 完成定义

- 已实现已确认的契约，测试经历 RED→GREEN；
- 格式、lint、构建、单测与适用的 race/spec 门禁通过；
- 用户可见变化已写入 `CHANGELOG.md`；
- PR、CI、review 已收敛；
- change 已归档并提交；
- 合并后清理 worktree 并同步 baseline。
