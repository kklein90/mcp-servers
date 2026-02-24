terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1.1"
    }
    argocd = {
      source  = "argoproj-labs/argocd"
      version = "7.13.0"
    }
  }
}

provider "argocd" {
  server_addr = "argo.kwkc.home:80"
  username    = "admin"
  password    = var.argocd-pw
  insecure    = true
  plain_text  = true
}
