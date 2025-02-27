module "helm_addon" {
  source            = "../helm-addon"
  manage_via_gitops = var.manage_via_gitops
  set_values        = local.set_values
  helm_config       = local.helm_config
  irsa_config       = local.irsa_config
  addon_context     = var.addon_context
}

resource "aws_iam_policy" "nops-k8s-agent" {
  description = "IAM policy for nops-k8s-agent Pod"
  name        = "${var.addon_context.eks_cluster_id}-nops-k8s-agent"
  path        = var.addon_context.irsa_iam_role_path
  policy      = data.aws_iam_policy_document.this.json
}