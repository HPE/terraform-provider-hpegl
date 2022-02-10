// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

package acceptancetest

import (
	"testing"

	api_client "github.com/HewlettPackard/hpegl-vmaas-cmp-go-sdk/pkg/client"
	"github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/atf"
)

func TestVmaasRouteBGPNeighborPlan(t *testing.T) {
	acc := &atf.Acc{
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		ResourceName: "hpegl_vmaas_router_bgp_neighbor",
	}
	acc.RunResourcePlanTest(t)
}

func TestAccResourceRouterBGPNeighborCreate(t *testing.T) {
	acc := &atf.Acc{
		ResourceName: "hpegl_vmaas_router_bgp_neighbor",
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		GetAPI: func(attr map[string]string) (interface{}, error) {
			cl, cfg := getAPIClient()
			iClient := api_client.RouterAPIService{
				Client: cl,
				Cfg:    cfg,
			}
			id := toInt(attr["id"])
			routerID := toInt(attr["router_id"])

			return iClient.GetSpecificRouterBgpNeighbor(getAccContext(), routerID, id)
		},
	}

	acc.RunResourceTests(t)
}
