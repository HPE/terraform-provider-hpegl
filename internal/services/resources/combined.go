// (C) Copyright 2020-2024 Hewlett Packard Enterprise Development LP

package resources

import (
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/registration"

	rescaas "github.com/HewlettPackard/hpegl-containers-terraform-resources/pkg/resources"
	resvmaas "github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/resources"
	resmetal "github.com/hewlettpackard/hpegl-metal-terraform-resources/pkg/registration"
)

// SupportedServices returns the list of supported services.
// Note: we will need to implement a ServiceRegistration interface which doesn't have
// SupportedResources() or SupportedDataSources() for new "framework" providers.
func SupportedServices() []registration.ServiceRegistration {
	return []registration.ServiceRegistration{
		resmetal.Registration{},
		resvmaas.Registration{},
		rescaas.Registration{},
	}
}
