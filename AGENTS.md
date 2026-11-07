# agent-lab — Agent 指令

个人 Agent 工程仓库：一个仓库，多个产物。当前产物：`harness`（本地 CLI，骨架阶段）。

本文件与子目录 `AGENTS.md` 由 DSH 自动注入，流程说明里不再重复“先读 AGENTS”。

## 工作流入口

- 涉及生产/测试代码、脚本/生成器、构建/CI、依赖或公共契约：MUST 使用
  [`.dsh/skills/development-workflow/SKILL.md`](.dsh/skills/development-workflow/SKILL.md)。
- 写任何生产实现前：MUST 使用
  [`.dsh/skills/test-driven-development/SKILL.md`](.dsh/skills/test-driven-development/SKILL.md)。
- 仅调查、比较方案、澄清需求：只读，不建 change、不改文件；方案明确后再进入完整流程。
- 只改文档、AGENTS、skill 文案或普通配置值：可走轻量流程，但仍要保护已有修改并跑对应校验。

## 任务分级

| 级别 | 适用 | 动作 |
|---|---|---|
| 完整 | 生产/测试代码、脚本、构建/CI、依赖、公共契约 | worktree + OpenSpec + TDD + PR + CI + 归档 |
| 轻量 | 文档、AGENTS、skill 文案、配置值 | 分支 + 对应校验 + 提交 |
| 直达 | typo、注释、单个配置值 | `main` 直接提交 + 最低校验 |

碰可执行面就整项升级为完整流程，不拆分规避。

初始化提交（bootstrap）是规则自身的建立过程，不适用完整流程；从第一个业务 change 起，所有变更适用本表。

## 命令

| 用途 | 命令 |
|---|---|
| 查看全部 target | `make help` |
| 格式化 / 校验 | `make fmt` / `make fmt-check` |
| 静态检查 | `make lint` |
| 编译 + vet | `make build-check` |
| 单元测试 / 竞态 | `make unit-test` / `make race-test` |
| 本地预演 CI | `make verify` |
| 运行 harness | `make run ARGS='--version'` |
| OpenSpec | `make openspec ARGS='list --json'` |
| 主 spec 校验 | `make spec-check` |

## 硬规则

- 先行为契约，后实现；没有先失败的测试，不写生产代码。
- 新增可独立运行的程序：`cmd/<name>/` + Makefile target + README 产物表，三处同步。
- 领域内部结构由第一个 change 决定，不预建空目录占位。
- 只用 DSH：指令是根 `AGENTS.md`，skill 在 `.dsh/skills/`；不维护 `.claude`/`.cursor` 投影或 `CLAUDE.md`。
- 代码注释与仓库文档使用简体中文；标识符保持英文。
- 不覆盖、删除或重置用户已有修改；破坏性操作先确认。
- 用户可见变化更新 `CHANGELOG.md`。

## 事实源

| 内容 | 唯一位置 |
|---|---|
| 仓库地图、命令、硬规则 | 本文件 |
| 完整交付流程 | `.dsh/skills/development-workflow/SKILL.md` |
| TDD 纪律 | `.dsh/skills/test-driven-development/SKILL.md` |
| 当前行为契约 | `openspec/specs/` |
| 进行中的变更 | `openspec/changes/` |
| 解释与决策 | `docs/architecture/`、`docs/decisions/` |
| 用户可见变化 | `CHANGELOG.md` |
| 本地命令 | `Makefile` |
| 远程门禁 | `.github/workflows/ci.yml` |

冲突优先级：本文件 → 当前 skill → 活跃 change → 主 spec → 解释性文档。
代码和测试是当前实现证据；与主 spec 冲突时必须显式修复。

## 仓库地图

| 路径 | 说明 |
|---|---|
| `cmd/<name>/` | 每个可独立运行的程序一个入口 |
| `<domain>/` | 领域库：接口、纯逻辑、测试 |
| `platform/` | 跨产物共享的基础设施（按需创建） |
| `openspec/` | 行为契约与变更 |
| `docs/` | 架构解释与决策 |
| `.dsh/skills/` | DSH 工作流 skill |
| `make/` | 工具版本等公共构建片段 |
