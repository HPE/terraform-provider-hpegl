// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

package acceptancetest

import (
	"fmt"
	"testing"

	"github.com/spf13/viper"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/resource"
)

func TestAccDataSourceDataStore(t *testing.T) {
	resource.ParallelTest(t, resource.TestCase{
		IsUnitTest: false,
		PreCheck:   func() { testAccPreCheck(t) },
		Providers:  testAccProviders,
		Steps: []resource.TestStep{
			{
				Config: testAccDataSourceDataStoreConfig(),
				Check: resource.ComposeTestCheckFunc(
					validateDataSourceID("data.hpegl_vmaas_datastore.storage"),
				),
			},
		},
	})
}

func testAccDataSourceDataStoreConfig() string {
	return fmt.Sprintf(`%s
	data "hpegl_vmaas_datastore" "storage" {
		cloud_id = %d
		name = "%s"
	}
	`,
		providerStanza,
		viper.GetInt("vmaas.datasource.datastore.cloud_id"),
		viper.GetString("vmaas.datasource.datastore.name"))
}
