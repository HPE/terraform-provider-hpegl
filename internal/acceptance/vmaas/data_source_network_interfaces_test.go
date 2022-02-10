// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

package acceptancetest

import (
	"testing"

	api_client "github.com/HewlettPackard/hpegl-vmaas-cmp-go-sdk/pkg/client"
	"github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/atf"
)

func TestAccDataSourceNetworkInterface(t *testing.T) {
	acc := &atf.Acc{
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		ResourceName: "hpegl_vmaas_network_interface",
		GetAPI: func(attr map[string]string) (interface{}, error) {
			cl, cfg := getAPIClient()
			iClient := api_client.CloudsAPIService{
				Client: cl,
				Cfg:    cfg,
			}

			cloudID := toInt(attr["cloud_id"])
			pClient := api_client.ProvisioningAPIService{
				Client: cl,
				Cfg:    cfg,
			}
			provision, err := pClient.GetAllProvisioningTypes(getAccContext(), map[string]string{
				"name": "vmware",
			})
			if err != nil {
				return nil, err
			}

			return iClient.GetAllCloudNetworks(getAccContext(), cloudID, provision.ProvisionTypes[0].ID)
		},
	}

	acc.RunDataSourceTests(t)
}
