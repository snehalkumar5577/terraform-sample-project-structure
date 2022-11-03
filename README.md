<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.1.9 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72.0, < 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.72.0, < 4 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 18.24.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.14.2 |

## Resources

| Name | Type |
|------|------|
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.jenkins](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [time_sleep.wait_for_eks](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Enviroment name. This will be used as prefix for all resources | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region in which resources will be deployed | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags logging in center place | <pre>object({<br>    env   = string<br>    owner = string<br>  })</pre> | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | Object representing the VPC configuration | <pre>object({<br>    azs             = list(string)<br>    cidr            = string<br>    public_subnets  = list(string)<br>    private_subnets = list(string)<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->