error:
	@echo "Please make a specific target i.e. make account"

account:
	protoc --proto_path=. \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		$(shell find wello-account -name '*.proto')

errs:
	protoc --proto_path=. \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		--go-http_out=paths=source_relative:. \
		--validate_out=paths=source_relative,lang=go:. \
		$(shell find wello-errs -name '*.proto')

hedging:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		--go-http_out=paths=source_relative:. \
		--validate_out=paths=source_relative,lang=go:. \
		$(shell find wello-hedging -name '*.proto')

ramp-core:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		--go-http_out=paths=source_relative:. \
		--validate_out=paths=source_relative,lang=go:. \
		$(shell find wello-ramp-core -name '*.proto')

risk:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		--go-http_out=paths=source_relative:. \
		--validate_out=paths=source_relative,lang=go:. \
		$(shell find wello-risk -name '*.proto')

crypto-hub:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		--go-http_out=paths=source_relative:. \
		--validate_out=paths=source_relative,lang=go:. \
		$(shell find wello-crypto-hub -name '*.proto')

fiat-hub:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		--go-http_out=paths=source_relative:. \
		--validate_out=paths=source_relative,lang=go:. \
		$(shell find wello-fiat-hub -name '*.proto')

notification:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		--go-http_out=paths=source_relative:. \
		--validate_out=paths=source_relative,lang=go:. \
		$(shell find wello-notification -name '*.proto')

ts-proto:
	find . -type f -name '*.proto' \
		! -path './node_modules/*' \
		! -path './wello-proto-deps/*' -print0 | \
		xargs -0 protoc \
			--plugin=./node_modules/.bin/protoc-gen-ts_proto \
			--ts_proto_out=./typescript \
			--ts_proto_opt=outputServices=nice-grpc,outputServices=generic-definitions,useExactTypes=false \
			--proto_path=./ \
			-I ./wello-proto-deps
