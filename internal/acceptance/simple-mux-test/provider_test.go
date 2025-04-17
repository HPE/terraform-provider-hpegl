// Copyright (c) 2024 Hewlett Packard Enterprise Development LP.

package simplemuxtest

import (
	"testing"

	"github.com/hashicorp/terraform-plugin-go/tfprotov5"
	"github.com/hashicorp/terraform-plugin-mux/tf5muxserver"

	"github.com/HPE/terraform-provider-hpegl/internal/hpegl"
)

// TestMuxServer is a very simple sanity check on the mux server.  There doesn't seem to be
// an equivalent of "InternalValidate" for the mux server, so this is the best we can do.
// Note that this isn't an acceptance test, leaving it here for now.
func TestMuxServer(t *testing.T) {
	ctx := t.Context() // Use t.Context() instead of context.Background()
	providers := hpegl.ProvidersForMux()
	muxServer, err := tf5muxserver.NewMuxServer(ctx, providers...)
	if err != nil {
		t.Fatalf("Error creating MuxServer: %v", err)
	}

	// Test GetProviderSchema - this is a very simple test to make sure the mux server is working
	_, err = muxServer.GetProviderSchema(ctx, &tfprotov5.GetProviderSchemaRequest{})
	if err != nil {
		t.Fatalf("Error getting provider schema: %v", err)
	}
}
