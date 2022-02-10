// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

package acceptancetest

import (
	"testing"

	api_client "github.com/HewlettPackard/hpegl-vmaas-cmp-go-sdk/pkg/client"
	"github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/atf"
)

func TestVmaasRouterTier0Plan(t *testing.T) {
	acc := &atf.Acc{
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		Version:      "tier0",
		ResourceName: "hpegl_vmaas_router",
	}
	acc.RunResourcePlanTest(t)
}

func TestAccResourceTier0RouterCreate(t *testing.T) {
	acc := &atf.Acc{
		ResourceName: "hpegl_vmaas_router",
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		Version:      "tier0",
		GetAPI: func(attr map[string]string) (interface{}, error) {
			cl, cfg := getAPIClient()
			iClient := api_client.RouterAPIService{
				Client: cl,
				Cfg:    cfg,
			}
			id := toInt(attr["id"])

			return iClient.GetSpecificRouter(getAccContext(), id)
		},
	}

	acc.RunResourceTests(t)
}

func TestVmaasRouterTier1Plan(t *testing.T) {
	acc := &atf.Acc{
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		Version:      "tier1",
		ResourceName: "hpegl_vmaas_router",
	}
	acc.RunResourcePlanTest(t)
}

func TestAccResourceTier1RouterCreate(t *testing.T) {
	acc := &atf.Acc{
		ResourceName: "hpegl_vmaas_router",
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		Version:      "tier1",
		GetAPI: func(attr map[string]string) (interface{}, error) {
			cl, cfg := getAPIClient()
			iClient := api_client.RouterAPIService{
				Client: cl,
				Cfg:    cfg,
			}
			id := toInt(attr["id"])

			return iClient.GetSpecificRouter(getAccContext(), id)
		},
	}

	acc.RunResourceTests(t)
}
