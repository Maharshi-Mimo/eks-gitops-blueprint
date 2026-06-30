resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_version
  namespace        = "argocd"
  create_namespace = true

  values = [yamlencode({
    server = {
      service   = { type = "LoadBalancer" }
      extraArgs = ["--insecure"] # TLS terminated at ALB
    }
    configs = {
      params = {
        "server.disable.auth" = false
      }
    }
  })]
}