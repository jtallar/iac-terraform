# VPC-Instance example

This folder contains a [Terraform](https://www.terraform.io/) configuration that shows an example of how to use the [vpc module](../../modules/networking/vpc) and the `aws_instance` resource to deploy an EC2 instance in a custom VPC given an [Amazon Web Services (AWS) account](http://aws.amazon.com/). 

## Pre-requisites

* You must have [Terraform](https://www.terraform.io/) installed on your computer. 
* You must have an [Amazon Web Services (AWS) account](http://aws.amazon.com/).

## Quick start

Configure your [AWS access keys](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) as environment variables:

```
export AWS_ACCESS_KEY_ID=(your access key id)
export AWS_SECRET_ACCESS_KEY=(your secret access key)
```

Deploy the code:

```
terraform init
terraform apply
```

Clean up when you're done:

```
terraform destroy
```

## Verify it's working
You can test that the server is working by running

`curl http://${out.instance_public_ip}:${var.server_port}`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_server_http_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | The region to use in AWS | `string` | n/a | yes |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | The name of the created instance | `string` | `"example-server"` | no |
| <a name="input_server_port"></a> [server\_port](#input\_server\_port) | The port where the instance will be listening | `number` | `8080` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | The arn of the created instance |
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | The public IP of the created instance |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | The list of subnet ids |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the created VPC |
<!-- END_TF_DOCS -->