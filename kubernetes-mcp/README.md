# Kubernetes MCP server

## Deployment & Configruation

The k8s mcp server is deployed via a Helm chart. This chart is deployed by ArgoCD.
In this folder is the ArogCD application manifest - argo-app.yaml
Apply this manifest with:

```
kubectl apply -f argo-app.yaml
```
