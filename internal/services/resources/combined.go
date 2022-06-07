// (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP

package resources

import (
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/registration"

	resvmaas "github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/resources"
	resmetal "github.com/hewlettpackard/hpegl-metal-terraform-resources/pkg/registration"
)

func SupportedServices() []registration.ServiceRegistration {
	return []registration.ServiceRegistration{
		resmetal.Registration{},
		resvmaas.Registration{},
	}
}
