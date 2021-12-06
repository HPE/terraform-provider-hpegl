// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

//nolint:gosec
package acceptancetest

import (
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"time"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/resource"
	"github.com/hashicorp/terraform-plugin-sdk/v2/terraform"
	"github.com/spf13/viper"

	api_client "github.com/HewlettPackard/hpegl-vmaas-cmp-go-sdk/pkg/client"
	"github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/constants"
)

const providerStanza = `
	provider hpegl {
		vmaas {
			allow_insecure = true
			space_name = "` + constants.AccSpace + `"
			location = "` + constants.AccLocation + `"
		}
	}

`

type validators func(*terraform.ResourceState) error

func validateDataSourceID(name string) resource.TestCheckFunc {
	return func(s *terraform.State) error {
		rs, ok := s.RootModule().Resources[name]
		if !ok {
			return fmt.Errorf("data source %s not found", name)
		}

		id := rs.Primary.Attributes["id"]
		if id == "" {
			return fmt.Errorf("data source %s ID is not set", name)
		}

		return nil
	}
}

func validateResource(name string, v ...validators) resource.TestCheckFunc {
	return func(s *terraform.State) error {
		rs, ok := s.RootModule().Resources[name]
		if !ok {
			return fmt.Errorf("resource %s not found", name)
		}

		id := rs.Primary.Attributes["id"]
		if id == "" {
			return fmt.Errorf("resource %s ID is not set", name)
		}
		for _, vs := range v {
			if err := vs(rs); err != nil {
				return fmt.Errorf("resource %s validation failed with error %w", name, err)
			}
		}

		return nil
	}
}

func getAPIClient() (*api_client.APIClient, api_client.Configuration) {
	headers := make(map[string]string)
	headers["Authorization"] = os.Getenv("HPEGL_IAM_TOKEN")
	headers["subject"] = os.Getenv("CMP_SUBJECT")

	cfg := api_client.Configuration{
		Host:          constants.AccServiceURL,
		DefaultHeader: headers,
		DefaultQueryParams: map[string]string{
			constants.SpaceKey:    constants.AccSpace,
			constants.LocationKey: constants.AccLocation,
		},
	}
	apiClient := api_client.NewAPIClient(&cfg)

	return apiClient, cfg
}

func getNetworkStanza() string {
	networks := viper.Get("vmaas.resource.instance.network")
	var networkStanza string
	for i := range networks.([]interface{}) {
		networkStanza = fmt.Sprintf(`%s
		network {
		  id = %d
		  interface_id = %d
		}`,
			networkStanza,
			viper.GetInt("vmaas.resource.instance.network."+strconv.Itoa(i)+".id"),
			viper.GetInt("vmaas.resource.instance.network."+strconv.Itoa(i)+".interface_id"))
	}

	return networkStanza
}

func getVolumeStanza() string {
	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	volumes := viper.Get("vmaas.resource.instance.volume")
	var volumeStanza string
	for i := range volumes.([]interface{}) {
		volumeStanza = fmt.Sprintf(`%s
		volume {
			name         = "%s"
			size         = %d
			datastore_id = %s
		}`,
			volumeStanza,
			viper.GetString("vmaas.resource.instance.volume."+strconv.Itoa(i)+".name"),
			r.Intn(5)+5,
			viper.GetString("vmaas.resource.instance.volume."+strconv.Itoa(i)+".datastore_id"))
	}

	return volumeStanza
}
