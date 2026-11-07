# 架构

本目录放解释性文档：分层、依赖方向、产物边界、关键取舍。
行为契约在 [`openspec/specs/`](../../openspec/specs/)；这里只解释“为什么”，不复制契约。

## 当前骨架

- 一个仓库、多个产物：每个可独立运行的程序在 `cmd/<name>/`。
- 领域库在 `<domain>/`，跨产物基础设施在 `platform/`（按需创建）。
- 依赖方向：`cmd → <domain> → platform`，不反向。
- 骨架阶段不预建领域内部结构；第一个 change 决定落点。
- 先单 module；出现独立发版、依赖冲突、部署隔离等真实压力再拆。

## 产物生长路径

1. 在 `cmd/<name>/` 建入口；
2. 在 `<domain>/` 放可测试的领域代码；
3. 在 Makefile、README 产物表登记；
4. 需要独立部署时加 Dockerfile 与 CI job；
5. 需要独立版本时再拆 module。
