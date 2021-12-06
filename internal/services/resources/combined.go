// (C) Copyright 2020 Hewlett Packard Enterprise Development LP

package resources

import (
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/registration"

	resvmaas "github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/resources"
)

func SupportedServices() []registration.ServiceRegistration {
	return []registration.ServiceRegistration{
		resvmaas.Registration{},
	}
}
