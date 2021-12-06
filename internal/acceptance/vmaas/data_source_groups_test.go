// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

package acceptancetest

import (
	"fmt"
	"testing"

	"github.com/spf13/viper"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/resource"
)

func TestAccDataSourceGroup(t *testing.T) {
	resource.ParallelTest(t, resource.TestCase{
		IsUnitTest: false,
		PreCheck:   func() { testAccPreCheck(t) },
		Providers:  testAccProviders,
		Steps: []resource.TestStep{
			{
				Config: testAccDataSourceGroupConfig(),
				Check: resource.ComposeTestCheckFunc(
					validateDataSourceID("data.hpegl_vmaas_group.group"),
				),
			},
		},
	})
}

func testAccDataSourceGroupConfig() string {
	return fmt.Sprintf(`%s
data "hpegl_vmaas_group" "group" {
	name = "%s"
}
`, providerStanza,
		viper.GetString("vmaas.datasource.group.name"))
}
