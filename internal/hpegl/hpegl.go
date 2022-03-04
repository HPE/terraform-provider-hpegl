// (C) Copyright 2020 Hewlett Packard Enterprise Development LP

package hpegl

import (
	"context"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"

	"github.com/hewlettpackard/hpegl-provider-lib/pkg/provider"

	"github.com/HPE/terraform-provider-hpegl/internal/client"
	"github.com/HPE/terraform-provider-hpegl/internal/services/resources"
)

func ProviderFunc() plugin.ProviderFunc {
	return provider.NewProviderFunc(resources.SupportedServices(), providerConfigure)
}

func providerConfigure(p *schema.Provider) schema.ConfigureContextFunc { // nolint staticcheck
	return func(ctx context.Context, d *schema.ResourceData) (interface{}, diag.Diagnostics) {
		return client.NewClientMap(ctx, d)
	}
}
