// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

package acceptancetest

import (
	"context"
	"log"
	"os"
	"strconv"

	api_client "github.com/HewlettPackard/hpegl-vmaas-cmp-go-sdk/pkg/client"
	"github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/constants"
	"github.com/HewlettPackard/hpegl-vmaas-terraform-resources/pkg/utils"
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/token/retrieve"
	"github.com/hewlettpackard/hpegl-provider-lib/pkg/token/serviceclient"
)

func getAPIClient() (*api_client.APIClient, api_client.Configuration) {
	var headers map[string]string
	if utils.GetEnvBool("TF_ACC_MOCK_IAM") {
		headers = make(map[string]string)
		headers["Authorization"] = os.Getenv("HPEGL_IAM_TOKEN")
		headers["subject"] = os.Getenv(constants.CmpSubjectKey)
	}

	cfg := api_client.Configuration{
		Host:          utils.GetServiceEndpoint(),
		DefaultHeader: headers,
		DefaultQueryParams: map[string]string{
			constants.LocationKey: os.Getenv("HPEGL_VMAAS_LOCATION"),
			constants.SpaceKey:    os.Getenv("HPEGL_VMAAS_SPACE_NAME"),
		},
	}

	apiClient := api_client.NewAPIClient(&cfg)
	err := apiClient.SetMeta(nil, func(ctx *context.Context, meta interface{}) {
		d := &utils.ResourceData{
			Data: map[string]interface{}{
				"iam_service_url":           os.Getenv("HPEGL_IAM_SERVICE_URL"),
				"tenant_id":                 os.Getenv("HPEGL_TENANT_ID"),
				"user_id":                   os.Getenv("HPEGL_USER_ID"),
				"user_secret":               os.Getenv("HPEGL_USER_SECRET"),
				"api_vended_service_client": true,
				"iam_token":                 os.Getenv("HPEGL_IAM_TOKEN"),
			},
		}
		if utils.GetEnvBool(constants.MockIAMKey) {
			return
		}

		// Initialise token handler
		h, err := serviceclient.NewHandler(d)
		if err != nil {
			log.Printf("[WARN] Unable to fetch token for SCM client: %s", err)
		}

		// Get token retrieve func and put in c
		trf := retrieve.NewTokenRetrieveFunc(h)
		token, err := trf(*ctx)
		if err != nil {
			log.Printf("[WARN] Unable to fetch token for SCM client: %s", err)
		} else {
			*ctx = context.WithValue(*ctx, api_client.ContextAccessToken, token)
		}
	})

	if err != nil {
		log.Printf("[WARN] Error: %s", err)
	}

	return apiClient, cfg
}

func toInt(s string) int {
	i, _ := strconv.Atoi(s)

	return i
}

func getAccContext() context.Context {
	return context.Background()
}
