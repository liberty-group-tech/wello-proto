FROM golang:1.24.1

ARG PROTOC_VERSION=28.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip curl git make && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sSL -o /tmp/protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip && \
    unzip -o /tmp/protoc.zip -d /usr/local bin/protoc 'include/*' && \
    rm /tmp/protoc.zip

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.35.2 && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.4.0

ENV PATH="/go/bin:${PATH}"
WORKDIR /workspace
