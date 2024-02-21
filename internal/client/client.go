// (C) Copyright 2020-2024 Hewlett Packard Enterprise Development LP

package client

import (
	"context"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/client"
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/gltform"

	metal "github.com/hewlettpackard/hpegl-metal-terraform-resources/pkg/configuration"

	"github.com/hewlettpackard/hpegl-provider-lib/pkg/token/common"
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/token/retrieve"
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/token/serviceclient"

	"github.com/HPE/terraform-provider-hpegl/internal/services/clients"
)

func NewClientMap(ctx context.Context, d *schema.ResourceData) (map[string]interface{}, diag.Diagnostics) { // nolint gocyclo
	c := make(map[string]interface{})

	// Initialise token handler
	h, err := serviceclient.NewHandler(d)
	if err != nil {
		return nil, diag.FromErr(err)
	}

	// Get token retrieve func and put in c
	trf := retrieve.NewTokenRetrieveFunc(h)
	c[common.TokenRetrieveFunctionKey] = trf

	// Iterate over services
	for _, cli := range clients.InitialiseClients() {
		scli, err := cli.NewClient(d)
		if err != nil {
			return nil, diag.Errorf("error in creating client %s: %s", cli.ServiceName(), err)
		}

		// Check that cli.ServiceName() value is unique
		if _, ok := c[cli.ServiceName()]; ok {
			return nil, diag.Errorf("%s client key is not unique", cli.ServiceName())
		}

		// Add service client to map
		c[cli.ServiceName()] = scli
	}

	// Metal. A special case at the moment.
	// If a project ID is required, metal requires that we both initialise the client and use it to
	// "refresh resources" before we hand it off to the provider code.
	// In addition the Metal provider code uses a .gltform file to read the GreenLake project ID, space
	// and portal URL.
	// There are two possibilities:
	// - The information needed to populate the .gltform file is provided in a hpegl metal block
	// - A .gltform file is provided outside of the terraform environment
	// So we do the following:
	// - First check for the existence of a hpegl metal block, if it is present we use it to populate a
	//   .gltform file.  Thus the hpegl metal block contents "win"
	// - Then we check for a .gltform file, if one is present (it will either have been written from the
	//   contents of the hpegl metal block or will have been there previously) we initialise the client
	//   etc.
	// TODO we may want to add some utility functions to hpegl-provider-lib to hide some of these d.Get()s

	// First check to see if there is a metal stanza in the provider input, if so use it to write out a .gltform file
	if metalMap, err := client.GetServiceSettingsMap("metal", d); err == nil {
		// Proceed to write-out .gltform file
		if err := gltform.WriteGLConfig(metalMap); err != nil {
			return nil, diag.Errorf("error in writing out .gltform file for metal")
		}
	}

	// Now check if there is a .gltform file, if so proceed with Metal initialisation.
	if cfg, err := gltform.GetGLConfig(); err == nil {
		// Initialise the metal client
		metalConfig, err := metal.NewConfig("", metal.WithTRF(trf))
		if err != nil {
			return nil, diag.Errorf("error in creating metal client: %s", err)
		}
		if cfg.ProjectID != "" {
			if err := metalConfig.RefreshAvailableResources(); err != nil {
				return nil, diag.Errorf("error in refreshing available resources for metal: %s", err)
			}
		}
		c[metal.KeyForGLClientMap()] = metalConfig
	}

	return c, nil
}
