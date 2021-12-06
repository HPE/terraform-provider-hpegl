#(C) Copyright 2021 Hewlett Packard Enterprise Development LP
GOFMT_FILES?=$$(find . -name '*.go' | grep -v vendor)

default: build

build:
	go install

fmtcheck:
	@sh -c "'$(CURDIR)/scripts/gofmtcheck.sh'"

fmt:
	@echo "==> Fixing source code with gofmt..."
	gofmt -s -w $(GOFMT_FILES)

tools:
	GO111MODULE=on go install github.com/golangci/golangci-lint/cmd/golangci-lint

lint:
	@echo "==> Checking source code against linters..."
	golangci-lint run ./...

test:
	go test -v $$(go list ./... | grep -v internal/acceptance/vmaas)

.PHONY: build fmtcheck fmt tools lint test
