##############################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = var.env_name
  cidr = var.vpc.cidr

  azs                = [for az in var.vpc.azs : "${var.region}${az}"]
  private_subnets    = var.vpc.private_subnets
  public_subnets     = var.vpc.public_subnets
  enable_nat_gateway = true
}

##############################################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.24.1"

  cluster_name    = var.env_name
  cluster_version = "1.22"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = ["t3.medium", "t2.medium"]
  }

  eks_managed_node_groups = {
    green = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::610546882158:user/svmahale"
      username = "svmahale"
      groups   = ["system:masters"]
    }
  ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id

  depends_on = [
    time_sleep.wait_for_eks
  ]
}

resource "time_sleep" "wait_for_eks" {
  create_duration = "2m"

  depends_on = [
    module.eks.cluster_id
  ]
}

##############################################################
resource "helm_release" "ingress_nginx" {
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  version          = "4.0.19"

  values = [file("./files/nginx-override-values.yaml")]
}
##############################################################
resource "helm_release" "jenkins" {
  depends_on       = [helm_release.ingress_nginx]
  create_namespace = true
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  version          = "4.1.11"
  name             = "jenkins"
  namespace        = "jenkins"
  values           = [file("./files/jenkins-override-values.yaml")]
}
##############################################################
