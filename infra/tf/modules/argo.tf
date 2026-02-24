    resource "argocd_project" "default" {
        metadata {
            name      = "default"
            namespace = "mcp-servers"
        }

        spec {
            # description  = "Default ArgoCD project"
            source_repos = ["*"]

            destination {
                server    = "https://kubernetes.default.svc"
                namespace = "mcp-servers"
            }

            cluster_resource_whitelist {
                group = "*"
                kind  = "*"
                }
            }
        }

    resource "argocd_repository" "mcp-servers" {
        repo            = REPO-NAME
        name            = "mcp-servers"
        type            = "git"
        ssh_private_key = var.github-key
        project         = "default"

        depends_on = [argocd_project.default]
    }

    resource "argocd_application" "mcp-servers" {
    metadata {
        name      = "mcp-servers"
        namespace = "argocd"
    }

    spec {
        project = "default"

        destination {
        server    = "https://kubernetes.default.svc"
        namespace = "default"
        #   name      = "n8n" # conflicts with server param
        }

        source {
        repo_url        = "git@github.com:kklein90/n8n.git"
        path            = "infra/kubernetes/overlays/home"
        target_revision = "main"
        }

        sync_policy {
        automated {
            prune       = true
            self_heal   = true
            allow_empty = true
        }
        sync_options = ["Validate=false"]
        retry {
            limit = "5"
            backoff {
            duration     = "30s"
            max_duration = "2m"
            factor       = "2"
            }
        }
        }
    }

    depends_on = [argocd_project.default, argocd_repository.n8n_repo]
    }
