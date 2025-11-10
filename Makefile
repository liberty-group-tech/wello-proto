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
		wello-errs/*.proto


hedging:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		wello-hedging/*.proto

ramp-core:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		wello-ramp-core/*.proto

risk:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		wello-risk/*.proto

crypto-hub:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		wello-crypto-hub/*.proto

notification:
	protoc --proto_path=. \
		-I ./wello-proto-deps \
		--go_out=paths=source_relative:. \
		--go-grpc_out=paths=source_relative:. \
		wello-notification/*.proto