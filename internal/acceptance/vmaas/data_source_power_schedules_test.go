// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

package acceptancetest

import (
	"testing"

	api_client "github.com/HewlettPackard/hpegl-vmaas-cmp-go-sdk/pkg/client"
	"github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/atf"
)

func TestAccDataSourcePowerSchedule(t *testing.T) {
	acc := &atf.Acc{
		PreCheck:     testAccPreCheck,
		Providers:    testAccProviders,
		ResourceName: "hpegl_vmaas_power_schedule",
		GetAPI: func(attr map[string]string) (interface{}, error) {
			cl, cfg := getAPIClient()
			iClient := api_client.PowerSchedulesAPIService{
				Client: cl,
				Cfg:    cfg,
			}
			id := toInt(attr["id"])

			return iClient.GetSpecificPowerSchedule(getAccContext(), id)
		},
	}

	acc.RunDataSourceTests(t)
}
