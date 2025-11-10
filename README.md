# Wello Proto

Protobuf definitions for the Wello services. Each `.proto` file is committed in source form; generated Go code is intentionally excluded so that downstream services can regenerate stubs with their preferred toolchain.

## Project Layout
- `wello-account/`: user & account service (`user.service.v1`).
- `wello-errs/`, `wello-hedging/`, `wello-ramp-core/`, `wello-crypto-hub/`, `wello-notification/`, `wello-risk/`: service-specific proto packages (one folder per service namespace).
- `wello-proto-deps/`: vendored third-party protos (Google APIs, OpenAPI annotations, buf `validate`, etc.). Add this path to your `protoc` includes when generating code.
- `Dockerfile`: reproducible environment containing `protoc` and the Go plugins used by this repo.
- `Makefile`: helper targets for generating Go sources from the protos.

## References
- https://grpc.io/docs/languages/go/quickstart
- https://developers.google.com/protocol-buffers/docs/style
- https://pkg.go.dev/google.golang.org/grpc

## Prerequisites
Install the Go plugins required for code generation (the versions match `go.mod`):

```shell
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.35.2
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.4.0
```

Ensure the binaries live on your `$PATH` (Go places them in `$(go env GOPATH)/bin` by default).

## Generate Code
Run `protoc` locally:

```shell
cd /Users/denniszhou/wello/wello-proto  ## your wello-proto files
protoc \
    --proto_path=. \
    --proto_path=./wello-proto-deps \
    --go_out=paths=source_relative:. \
    --go-grpc_out=paths=source_relative:. \
    wello-account/*.proto
```

Or use the provided make target:

```shell
cd /Users/denniszhou/wello/wello-proto ## your wello-proto files
make account
```

> ⚠️ Remember to regenerate and commit compiled artifacts only in downstream repositories; this repo stores the sources.

To regenerate other folders, swap out `wello-account/*.proto` with the service directory you need (e.g. `wello-errs/*.proto`). When those protos import dependencies from `wello-proto-deps`, the extra `--proto_path=./wello-proto-deps` ensures the imports resolve.

### TypeScript 输出

```shell
npm install
make ts-proto

# output: ./typescript
```

Usage:

```shell
npm i git+https://github.com/liberty-group-tech/wello-proto nice-grpc-common @bufbuild/protobuf/wire
```

```typescript
import { RampClient } from "wello-proto/wello-ramp-core/v1/ramp.ts"
```

## Naming Notes

- Keep the `go_package` option in sync with the module path in `go.mod`.
- Any change in package or service naming requires coordinated updates across both server and client implementations to avoid `code = Unimplemented` errors.

## Future(dennis)
    
#### 1.	GitHub 工作流（Go 代码生成）
- 通过创建分支 `gen/<service>/<feature>` 并提交 PR，触发 `.github/workflows/generate.yml` 自动生成目标目录下的 Go stub。
      工作流会安装指定版本的 `protoc ${PROTOC_VERSION}`、`protoc-gen-go`、`protoc-gen-go-grpc`，并将 `wello-proto-deps` 加入 -I include 路径，确保依赖 proto 能被正确解析。
      若某个服务需要额外插件（如 `protoc-gen-validate`），在 CI 中补充安装并在 `Generate` 步骤追加对应的 `--validate_out` 参数即可。
#### 2.	TypeScript 代码生成
-  在 Makefile 与 GitHub Actions 中新增 TS 生成任务（如采用 `protoc-gen-ts/ts-proto` 等），统一产出 TypeScript 类型与 gRPC/HTTP 客户端。
   生成产物与 Go 一致遵循“源相对路径”，并复用 `-I `. `-I ./wello-proto-deps` 的 include 约定，确保多语言生成行为一致。
#### 3.  wello bot