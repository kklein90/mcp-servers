terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1.1"
    }
    argocd = {
      source  = "argoproj-labs/argocd"
      version = "~> 7.13.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/admin.conf"
}

variable "argocd-pw" {
  sensitive = true
}

variable "github-key" {
  sensitive = true
}

module "mcp-servers" {
  source     = "git@github.com:kklein90/terraform-modules.git//argocd/argocd-app/kustomize-app"
  argocd-pw  = var.argocd-pw
  github-key = var.github-key
  repo-url   = "git@github.com:kklein90/mcp-servers.git"
  app-name   = "mcp-servers"
  env        = "home"
  namespace  = "mcp-servers"
}
