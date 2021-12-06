// (C) Copyright 2020 Hewlett Packard Enterprise Development LP

package client

import (
	"context"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"

	"github.com/hewlettpackard/hpegl-provider-lib/pkg/token/common"
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/token/retrieve"
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/token/serviceclient"

	"github.com/HewlettPackard/terraform-provider-hpegl/internal/services/clients"
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

	return c, nil
}
