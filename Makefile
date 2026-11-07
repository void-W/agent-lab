# agent-lab — 仓库根 Makefile
#
# 唯一操作入口：格式化、lint、构建、测试、运行、OpenSpec 都从这里进。
# CI 只调用这里的 target，不另写一套命令。

ROOT := $(CURDIR)
include $(ROOT)/make/tool-versions.mk

# 单 module 项目；显式关闭 workspace，避免本机 go.work 影响结果。
export GOWORK := off

.DEFAULT_GOAL := help

# 只检查项目自己的 Go 文件：排除 .git、缓存和 vendor，避免工具缓存被当成源码。
GO_FILES := $(shell find . -name '*.go' -not -path './.git/*' -not -path './.cache/*' -not -path './vendor/*' | sort)

.PHONY: help fmt fmt-check lint build-check unit-test race-test verify build run tidy openspec spec-check

help: ## 列出可用 target 及用途
	@grep -hE '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

fmt: ## 格式化 Go 代码
	@if [ -n "$(GO_FILES)" ]; then gofmt -s -w $(GO_FILES); fi

fmt-check: ## 校验格式（不写入）
	@if [ -z "$(GO_FILES)" ]; then exit 0; fi; \
	unformatted="$$(gofmt -s -l $(GO_FILES))"; \
	if [ -n "$$unformatted" ]; then \
		echo "以下文件未格式化，请运行 make fmt："; echo "$$unformatted"; exit 1; \
	fi

lint: ## golangci-lint 静态检查（版本钉死）
	go run github.com/golangci/golangci-lint/v2/cmd/golangci-lint@$(GOLANGCI_LINT_VERSION) \
		run --config .golangci.yml ./...

build-check: ## 编译 + go vet（产物写到临时目录，避免污染仓库）
	@set -e; tmp="$$(mktemp -d)"; trap 'rm -rf "$$tmp"' EXIT; \
	go build -o "$$tmp" ./...; \
	go vet ./...

unit-test: ## 单元测试
	go test ./...

race-test: ## 竞态检测
	go test -race ./...

verify: fmt-check lint build-check unit-test ## 本地预演 CI（聚合门禁）

build: ## 构建本地 harness 到 bin/
	go build -o bin/harness ./cmd/harness

run: ## 运行本地 harness（ARGS 透传）
	go run ./cmd/harness $(ARGS)

tidy: ## 整理 go.mod / go.sum
	go mod tidy

openspec: ## 执行 OpenSpec（ARGS 透传）
	DO_NOT_TRACK=1 npx --yes @fission-ai/openspec@$(OPENSPEC_VERSION) $(ARGS)

spec-check: ## 校验主 spec
	DO_NOT_TRACK=1 npx --yes @fission-ai/openspec@$(OPENSPEC_VERSION) validate --specs
