#(C) Copyright 2021 Hewlett Packard Enterprise Development LP
GOFMT_FILES?=$$(find . -name '*.go' | grep -v vendor)
DEPEND_REPO=HewlettPackard/hpegl-vmaas-terraform-resources

prefix=hpegl-
suffix=-terraform-resources
ACC_TEST_SERVICES=vmaas
TESTCASE_DIRS=data-sources resources

default: build

build:
	go install

fmtcheck:
	@sh -c "'$(CURDIR)/scripts/gofmtcheck.sh'"

fmt:
	@echo "==> Fixing source code with gofmt..."
	gofmt -s -w $(GOFMT_FILES)

tools:
	GO111MODULE=on go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.43.0

lint: tools
	@echo "==> Checking source code against linters..."
	golangci-lint run ./...

test:
	go test -v $$(go list ./... | grep -v internal/acceptance/vmaas)

.PHONY: build fmtcheck fmt tools lint test

vendor: go.mod go.sum
	go mod vendor

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

accframework: vendor
	vend; \

	# Download acceptance tests
	# build config files
	for f in $(ACC_TEST_SERVICES); do \
		if [ -d "internal/acceptance/$${f}" ] ; then \
		rm -rf ./internal/acceptance/$${f} ; \
		fi ; \
		if [ -d vendor/github.com/HewlettPackard/$(prefix)$${f}$(suffix)/internal/acceptance_test ] ; then \
		cp -r vendor/github.com/HewlettPackard/$(prefix)$${f}$(suffix)/internal/acceptance_test ./internal/acceptance/$${f} ; \
		cp -r vendor/github.com/HewlettPackard/$(prefix)$${f}$(suffix)/acc-prod_testcases ./internal/acceptance/$${f} ; \
		fi ; \
		rm ./internal/acceptance/$${f}/provider_test.go ; \
		cp ./internal/acceptance/acceptance-utils/provider_test.go ./internal/acceptance/$${f} ; \
	done

.PHONY: accframework

acceptance: accframework
	export TF_ACC_TEST_PATH=$(shell pwd)/internal/acceptance/vmaas/acc-prod_testcases ; \
	for f in $(ACC_TEST_SERVICES); do \
		TF_ACC=true go test -v -timeout=9000s -cover ./internal/acceptance/$$f ; \
	done

	# remove vend files
	rm -rf vendor

.PHONY: acceptance

docs: docs-generate
.PHONY: docs
