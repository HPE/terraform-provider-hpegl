// Copyright (c) 2016-2024 Hewlett Packard Enterprise Development LP.

package acceptancetest

import (
	"testing"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"

	"github.com/HPE/terraform-provider-hpegl/internal/hpegl"
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

// TestProvider tests the SDK v2.0 provider.  Leaving this here for now.  We might need
// to remove this as we add new "framework" provider code
// TODO remove this test
func TestProvider(t *testing.T) {
	if err := hpegl.ProviderFunc()().InternalValidate(); err != nil {
		t.Fatalf("%s\n", err)
	}
	testAccPreCheck(t)
}

// TODO remove this test
func TestProviderInterface(_ *testing.T) {
	var _ *schema.Provider = hpegl.ProviderFunc()()
}
