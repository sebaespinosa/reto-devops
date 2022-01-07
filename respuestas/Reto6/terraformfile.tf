resource "kubernetes_role" "solo_ver_pods" {
  metadata {
    name      = "solo_ver_pods"
    namespace = "default"
  }

  rule {
    api_groups = ["*"]
    resources  = ["pods"]
    verbs      = ["watch"]
  }
}

resource "kubernetes_role_binding" "solo_ver_pods_binding" {
  metadata {
    name      = "solo_ver_pods_binding"
    namespace = "namespace_app_nodejs"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "solo_ver_pods"
  }
}