# agent-lab

个人 Agent 工程仓库：一个仓库、多个产物。代码从零开始，当前处于骨架阶段。

## 产物

| 产物 | 入口 | 类型 | 运行方式 | 状态 |
|---|---|---|---|---|
| harness | `cmd/harness` | CLI | `make run` | 骨架 |

新增产物的落点与步骤见 [AGENTS.md](AGENTS.md) 与 [架构说明](docs/architecture/README.md)。

## 快速开始

```bash
go version   # >= 1.25
make help
make verify
make run ARGS='--version'
```

## 目录

```text
cmd/        可独立运行的程序
<domain>/   领域库
platform/   跨产物共享（按需）
openspec/   行为契约
docs/       架构解释与决策
.dsh/       工作流 skill
```

## 约定

- 命令统一走 `make`；CI 调同一批 target。
- 先写 OpenSpec 行为契约，再 RED→GREEN。
- 文档与注释中文，标识符英文。
- 只用 DSH：`AGENTS.md` + `.dsh/skills`。

开发流程见 [`.dsh/skills/development-workflow/SKILL.md`](.dsh/skills/development-workflow/SKILL.md)。

## License

MIT
