#(C) Copyright 2021 Hewlett Packard Enterprise Development LP
GOFMT_FILES?=$$(find . -name '*.go' | grep -v vendor)
DEPEND_REPO=HewlettPackard/hpegl-vmaas-terraform-resources

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

docs-generate: vendor
	# Installing vend
	go get -d github.com/nomad-software/vend

	# Generate vendor
	vend

	# cleanup existing examples and templates
	rm -rf examples/resources examples/data-sources templates/resources templates/data-sources

	# Copy contents from dependent repos
	@for f in $(DEPEND_REPO); do \
		if [ -d vendor/github.com/$${f}/examples/resources ]; then cp -r vendor/github.com/$${f}/examples/resources ./examples; fi; \
		if [ -d vendor/github.com/$${f}/examples/data-sources ]; then cp -r vendor/github.com/$${f}/examples/data-sources ./examples; fi; \
		if [ -d vendor/github.com/$${f}/templates/resources ]; then cp -r vendor/github.com/$${f}/templates/resources ./templates; fi; \
		if [ -d vendor/github.com/$${f}/templates/data-sources ]; then cp -r vendor/github.com/$${f}/templates/data-sources ./templates; fi; \
	done

	# Generate docs - we ignore errors here so that the follow-on rules and actions will still run
	-@go generate ./main.go

	# remove vend files
	rm -rf vendor

.PHONY: docs-generate


docs: docs-generate
.PHONY: docs
