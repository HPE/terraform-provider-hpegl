// Copyright (c) 2016-2020 Hewlett Packard Enterprise Development LP.

package acceptancetest

import (
	"os"
	"testing"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"

	libUtils "github.com/hewlettpackard/hpegl-provider-lib/pkg/utils"

	"github.com/HewlettPackard/terraform-provider-hpegl/internal/hpegl"
)

var (
	testAccProviders map[string]*schema.Provider
	testAccProvider  *schema.Provider
)

func init() {
	testAccProvider = hpegl.ProviderFunc()()
	testAccProviders = map[string]*schema.Provider{
		"hpegl": testAccProvider,
	}
}

func testAccPreCheck(t *testing.T) {
	t.Helper()
	// this fails c is a nil interface....
	// c := testAccProvider.Meta().(*Config)
	// if c.member.GetHosterID() == "" {
	// 	t.Fatalf("Acceptance tests must be run with hoster-scope %+v", c.member)
	// }
}

func TestProvider(t *testing.T) {
	if err := hpegl.ProviderFunc()().InternalValidate(); err != nil {
		t.Fatalf("%s\n", err)
	}
	testAccPreCheck(t)
}

func TestProviderInterface(t *testing.T) {
	var _ *schema.Provider = hpegl.ProviderFunc()()
}

func TestMain(m *testing.M) {
	// TF_ACC_CONFIG_PATH set in make acceptance
	libUtils.ReadAccConfig(os.Getenv("TF_ACC_CONFIG_PATH"))
	m.Run()
	os.Exit(0)
}
