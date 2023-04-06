# Copyright 2020 Hewlett Packard Enterprise Development LP

# Set-up for terraform >= v0.13
terraform {
  required_providers {
    hpegl = {
      source  = "HPE/hpegl"
      version = ">= 0.1.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "hpegl" {
  caas {
  }
}

variable "HPEGL_SPACE" {
  type = string
}

data "hpegl_caas_cluster" "test" {
  name     = "test"
  space_id = var.HPEGL_SPACE
}

resource "local_file" "foo" {
  content  = base64decode(data.hpegl_caas_cluster.test.kubeconfig)
  filename = "./kubeconfig"
}

provider "kubernetes" {
  host     = yamldecode(base64decode(data.hpegl_caas_cluster.test.kubeconfig)).clusters[0].cluster.server
  token    = yamldecode(base64decode(data.hpegl_caas_cluster.test.kubeconfig)).users[0].user.token
  insecure = true
}


provider "kubectl" {
  host             = yamldecode(base64decode(data.hpegl_caas_cluster.test.kubeconfig)).clusters[0].cluster.server
  token            = yamldecode(base64decode(data.hpegl_caas_cluster.test.kubeconfig)).users[0].user.token
  insecure         = true
  load_config_file = false
}

resource "kubernetes_namespace" "onlineboutique" {
  metadata {
    name = "onlineboutique"
  }
  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

data "kubectl_file_documents" "docs" {
  content = file("multi-doc-manifest.yaml")
}

resource "kubectl_manifest" "test" {
  for_each           = data.kubectl_file_documents.docs.manifests
  yaml_body          = each.value
  override_namespace = "onlineboutique"
}
