// (C) Copyright 2020-2024 Hewlett Packard Enterprise Development LP

//go:generate terraform fmt -recursive ./examples/
//go:generate go run github.com/hashicorp/terraform-plugin-docs/cmd/tfplugindocs

package main

import (
	"context"
	"flag"
	"log"

	"github.com/hashicorp/terraform-plugin-go/tfprotov5/tf5server"
	"github.com/hashicorp/terraform-plugin-mux/tf5muxserver"

	"github.com/HPE/terraform-provider-hpegl/internal/hpegl"
)

// nolint: exhaustruct
func main() {
	var debugMode bool

	flag.BoolVar(&debugMode, "debug", false, "set to true to run the provider with support for debuggers like delve")
	flag.Parse()

	// Create a new MuxServer, we combine SDK v2.0 providers and "framweork" providers
	ctx := context.Background()
	muxServer, err := tf5muxserver.NewMuxServer(ctx, hpegl.ProvidersForMux()...)
	if err != nil {
		log.Fatal(err)
	}

	// Add some serve options
	var serveOpts []tf5server.ServeOpt
	if debugMode {
		serveOpts = append(serveOpts, tf5server.WithManagedDebug())
	}

	// Serve the muxServer
	err = tf5server.Serve(
		"registry.terraform.io/hpe/hpegl",
		muxServer.ProviderServer,
		serveOpts...,
	)
	if err != nil {
		log.Fatal(err)
	}
}
