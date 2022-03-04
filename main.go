// (C) Copyright 2020 Hewlett Packard Enterprise Development LP

//go:generate terraform fmt -recursive ./examples/
//go:generate go run github.com/hashicorp/terraform-plugin-docs/cmd/tfplugindocs

package main

import (
	"context"
	"flag"
	"log"

	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"

	"github.com/HPE/terraform-provider-hpegl/internal/hpegl"
)

func main() {
	var debugMode bool

	flag.BoolVar(&debugMode, "debug", false, "set to true to run the provider with support for debuggers like delve")
	flag.Parse()

	opts := &plugin.ServeOpts{ProviderFunc: hpegl.ProviderFunc()}

	if debugMode {
		err := plugin.Debug(context.Background(), "registry.terraform.io/hpe/hpegl", opts)
		if err != nil {
			log.Fatal(err.Error())
		}

		return
	}

	plugin.Serve(opts)
}
