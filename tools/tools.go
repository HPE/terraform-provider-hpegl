// (C) Copyright 2020 Hewlett Packard Enterprise Development LP
//go:build tools

package main

import (
	_ "github.com/golangci/golangci-lint/cmd/golangci-lint"
	// document generation
	_ "github.com/hashicorp/terraform-plugin-docs/cmd/tfplugindocs"
)
