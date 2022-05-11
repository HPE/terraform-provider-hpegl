// (C) Copyright 2020 Hewlett Packard Enterprise Development LP

package resources

import (
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/registration"

	rescaas "github.com/HewlettPackard/hpegl-containers-terraform-resources/pkg/resources"
	resvmaas "github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/resources"
)

func SupportedServices() []registration.ServiceRegistration {
	return []registration.ServiceRegistration{
		resvmaas.Registration{},
		rescaas.Registration{},
	}
}
