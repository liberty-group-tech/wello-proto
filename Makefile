error:
	@echo "Please make a specific target i.e. make account"

account:
	protoc --proto_path=. \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		wello-account/*.proto

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
