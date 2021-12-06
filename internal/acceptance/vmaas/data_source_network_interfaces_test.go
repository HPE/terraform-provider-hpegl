// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

package acceptancetest

import (
	"fmt"
	"testing"

	"github.com/spf13/viper"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/resource"
)

func TestAccDataSourceNetworkInterface(t *testing.T) {
	resource.ParallelTest(t, resource.TestCase{
		IsUnitTest: false,
		PreCheck:   func() { testAccPreCheck(t) },
		Providers:  testAccProviders,
		Steps: []resource.TestStep{
			{
				Config: testAccDataSourceNetworkInterfaceConfig(),
				Check: resource.ComposeTestCheckFunc(
					validateDataSourceID("data.hpegl_vmaas_network_interface.primary"),
				),
			},
		},
	})
}

func testAccDataSourceNetworkInterfaceConfig() string {
	return fmt.Sprintf(`%s
data "hpegl_vmaas_network_interface" "primary"{
	name = "%s"
	cloud_id = %d
  }
`, providerStanza,
		viper.GetString("vmaas.datasource.network_interface.name"),
		viper.GetInt("vmaas.datasource.network_interface.cloud_id"))
}
