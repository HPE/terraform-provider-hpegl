#(C) Copyright 2021-2022 Hewlett Packard Enterprise Development LP
GOFMT_FILES?=$$(find . -name '*.go' | grep -v vendor)
DEPEND_REPO=HewlettPackard/hpegl-vmaas-terraform-resources hewlettpackard/hpegl-metal-terraform-resources HewlettPackard/hpegl-containers-terraform-resources

prefix=hpegl-
suffix=-terraform-resources
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
	GO111MODULE=on go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.64.2

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
	go install github.com/nomad-software/vend@v1.0.3

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

accframework-vmaas: vendor
	go install github.com/nomad-software/vend@v1.0.3 ; \
	vend; \

	# Download acceptance tests
	if [ -d "internal/acceptance/vmaas" ] ; then \
		rm -rf ./internal/acceptance/vmaas ; \
	fi ; \
	mkdir ./internal/acceptance/vmaas ; \
	if [ -d vendor/github.com/HewlettPackard/$(prefix)vmaas$(suffix)/internal/acceptance_test ] ; then \
	  cp -r vendor/github.com/HewlettPackard/$(prefix)vmaas$(suffix)/internal/acceptance_test/* ./internal/acceptance/vmaas ; \
	fi ; \
	  cp -r vendor/github.com/HewlettPackard/$(prefix)vmaas$(suffix)/acc-testcases ./internal/acceptance/vmaas ; \
	rm ./internal/acceptance/vmaas/provider_test.go ; \
	cp ./internal/acceptance/acceptance-utils/provider_test.go ./internal/acceptance/vmaas ; \
	go mod tidy ; \
	go mod vendor

.PHONY: accframework-vmaas

accframework-caas: vendor
	go install github.com/nomad-software/vend@v1.0.3 ; \
	vend; \

	# Download acceptance tests
	if [ -d "internal/acceptance/containers" ] ; then \
		rm -rf ./internal/acceptance/containers ; \
	fi ; \
	mkdir ./internal/acceptance/containers ; \
	if [ -d vendor/github.com/HewlettPackard/$(prefix)containers$(suffix)/internal/acceptance_test ] ; then \
	  cp -r vendor/github.com/HewlettPackard/$(prefix)containers$(suffix)/internal/acceptance_test/* ./internal/acceptance/containers ; \
	fi ; \
	rm ./internal/acceptance/containers/provider_test.go ; \
	cp ./internal/acceptance/acceptance-utils/provider_test.go ./internal/acceptance/containers ; \
	go mod tidy ; \
	go mod vendor

.PHONY: accframework-caas

acceptance-vmaas: accframework-vmaas
	-for f in vmaas ; do \
		TF_ACC_TEST_PATH=$(shell pwd)/internal/acceptance/vmaas/acc-testcases TF_ACC=true go test -v -timeout=9000s -cover ./internal/acceptance/$$f ; \
		# remove service tests ; \
		rm -rf ./internal/acceptance/$$f ; \
		go mod tidy ; \
		go mod vendor ; \
	done

	# remove vend files
	rm -rf vendor

.PHONY: acceptance-vmaas

acceptance-caas: accframework-caas
	-for f in containers ; do \
		TF_ACC=true go test -v -timeout=9000s -cover ./internal/acceptance/$$f ; \
		# remove service tests ; \
		rm -rf ./internal/acceptance/$$f ; \
		go mod tidy ; \
		go mod vendor ; \
	done

	# remove vend files
	rm -rf vendor

.PHONY: acceptance-caas

docs: docs-generate
.PHONY: docs
