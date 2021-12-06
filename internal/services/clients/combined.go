// (C) Copyright 2020-2021 Hewlett Packard Enterprise Development LP

package clients

import (
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/client"

	clivmaas "github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/client"
)

func InitialiseClients() []client.Initialisation {
	return []client.Initialisation{
		clivmaas.InitialiseClient{},
	}
}
