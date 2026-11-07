# repo-baseline

## Purpose

定义 agent-lab 的仓库骨架：产物登记与依赖方向。多个程序产物共享同一套入口和分层规则，
避免每加一个产物就重新约定目录与命令。

## Requirements

### Requirement: 产物必须在三处登记

每个可独立运行的程序 MUST 位于 `cmd/<name>/`，并在 README 产物表与 Makefile 中有对应条目。

#### Scenario: 新增产物
- **GIVEN** 仓库已有至少一个产物
- **WHEN** 新增一个可独立运行的程序
- **THEN** 它出现在 `cmd/<name>/`、README 产物表和 Makefile target 中

### Requirement: 依赖方向单向

`cmd/` MUST 只做装配；领域库 MUST NOT import `cmd/`；`platform/` MUST NOT import 领域包。

#### Scenario: 领域库需要启动参数
- **GIVEN** 领域库需要读取配置
- **WHEN** 设计依赖
- **THEN** 配置由 `cmd/` 解析后以参数传入，领域库不 import `cmd/`
