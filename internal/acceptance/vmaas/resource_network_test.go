// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

package acceptancetest

import (
	"context"
	"testing"

	api_client "github.com/HewlettPackard/hpegl-vmaas-cmp-go-sdk/pkg/client"
	"github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/atf"
)

func TestVmaasNetworkPlan(t *testing.T) {
	acc := &atf.Acc{
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		ResourceName: "hpegl_vmaas_network",
	}
	acc.RunResourcePlanTest(t)
}

func TestAccResourceNetworkCreate(t *testing.T) {
	acc := &atf.Acc{
		ResourceName: "hpegl_vmaas_network",
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		GetAPI: func(attr map[string]string) (interface{}, error) {
			cl, cfg := getAPIClient()
			iClient := api_client.NetworksAPIService{
				Client: cl,
				Cfg:    cfg,
			}
			id := toInt(attr["id"])

			return iClient.GetSpecificNetwork(context.Background(), id)
		},
	}

	acc.RunResourceTests(t)
}
