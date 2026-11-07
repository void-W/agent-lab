// Command harness 是 agent-lab 的本地入口。
package main

import (
	"flag"
	"fmt"
	"io"
	"os"
)

// version 可在构建时通过 -ldflags "-X main.version=..." 注入。
var version = "0.0.0-dev"

func main() {
	os.Exit(run(os.Args[1:], os.Stdout, os.Stderr))
}

func run(args []string, stdout, stderr io.Writer) int {
	fs := flag.NewFlagSet("harness", flag.ContinueOnError)
	fs.SetOutput(stderr)
	showVersion := fs.Bool("version", false, "打印版本并退出")
	if err := fs.Parse(args); err != nil {
		return 2
	}
	if *showVersion {
		fmt.Fprintln(stdout, version)
		return 0
	}
	fmt.Fprintf(stdout, "agent-lab harness %s\n", version)
	fmt.Fprintln(stdout, "用法: harness [--version]")
	return 0
}
