- [terraform-provider-hpegl](#terraform-provider-hpegl)
  * [Introduction](#introduction)
  * [Quick guide to create GreenLake Private Cloud Instance:](#quick-guide-to-create-greenlake-private-cloud-instance)

# terraform-provider-hpegl

## Introduction

This is the main repo for the GreenLake terraform provider which provides terraform support fot GreenLake services.

## Prerequisites

1. Terraform version >= v0.13 [install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
1. An API client to authenticate against GreenLake.
1. Terraform basics. [Terraform Introduction](https://www.terraform.io/intro/index.html)

## Quick guide to create GreenLake Private Cloud Instance:

1. Make sure you have the correct Terraform version installed; It must be v0.13 or later:
   ```shell
   > terrafrom version
   
   > Terraform v0.15.3
   > on linux_amd64
   ```
   
1. Create a Terraform file in your working directory, and reference the desired provider version from the terraform [registry](https://registry.terraform.io/providers/HPE/hpegl/latest). For more information please consult the [documentation](docs/):
   ```terraform
      terraform {
         required_providers {
            hpegl = {
               source  = "HPE/hpegl"
               version = ">= 0.1.0-beta5"
            }
         }
      }

      provider "hpegl" {
         vmaas {
            location   = "BLR"
            space_name = "Default"
         }
      }

      data "hpegl_vmaas_datastore" "c_3par" {
         cloud_id = data.hpegl_vmaas_cloud.cloud.id
         name = "Compute-Cluster-Vol0"
      }

      data "hpegl_vmaas_network" "blue_net" {
        name = "Blue-Net"
      }
      
      data "hpegl_vmaas_network" "green_net" {
        name = "green-net"
      }
      
      data "hpegl_vmaas_group" "default_group" {
        name = "default"
      }
      
      data "hpegl_vmaas_resource_pool" "cl_resource_pool" {
        cloud_id = data.hpegl_vmaas_cloud.cloud.id
        name = "ComputeResourcePool"
      }
      
      data "hpegl_vmaas_layout" "vmware" {
        name = "Vmware VM"
        instance_type_code = "vmware"
      }
      
      data "hpegl_vmaas_cloud" "cloud" {
        name = "HPE GreenLake VMaaS Cloud"
      }
      
      data "hpegl_vmaas_plan" "g1_small" {
        name = "G1-Small"
      }
      
      data "hpegl_vmaas_power_schedule" "weekday" {
        name = "DEMO_WEEKDAY"
      }
      
      data "hpegl_vmaas_template" "vanilla" {
        name = "vanilla-centos7-x86_64-09072020"
      }
      
      data "hpegl_vmaas_environment" "dev" {
        name = "Dev"
      }
   
      resource "hpegl_vmaas_instance" "quick_guide_instance" {
        name               = "quick_guide_instance"
        cloud_id           = data.hpegl_vmaas_cloud.cloud.id
        group_id           = data.hpegl_vmaas_group.default_group.id
        layout_id          = data.hpegl_vmaas_layout.vmware.id
        plan_id            = data.hpegl_vmaas_plan.g1_small.id
        instance_type_code = data.hpegl_vmaas_layout.vmware.instance_type_code

        network {
            id = data.hpegl_vmaas_network.blue_net.id
        }

        volume {
            name         = "root_vol"
            size         = 10
            datastore_id = data.hpegl_vmaas_datastore.c_3par.id
            root         = true
        }

        config {
            resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
            template_id      = data.hpegl_vmaas_template.vanilla.id
            no_agent         = true
            create_user      = false
            asset_tag        = "vm_tag"
        }

        power = "poweron"
      }
   ```

1. Export API client credentials as environment variables:
   ```bash
   export HPEGL_TENANT_ID=< tenant-id >
   export HPEGL_USER_ID=< API client id >
   export HPEGL_USER_SECRET=< API client secret >
   export HPEGL_IAM_SERVICE_URL=< GL iam service url, defaults to https://client.greenlake.hpe.com/api/iam >
   ```
1. Initialize Terraform working directory:
   ```shell
   > terraform init
   ```
   
1. Deploy resources
   ```shell
   > terraform apply
   ```
