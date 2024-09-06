<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.4.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.4.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eventbridge"></a> [eventbridge](#module\_eventbridge) | ./modules/eventbridge | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./modules/iam | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./modules/lambda | n/a |
| <a name="module_sns"></a> [sns](#module\_sns) | ./modules/sns | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_scheduler_schedule.lambda_schedule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule) | resource |
| [aws_iam_role.acm_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.coordinator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.scheduler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.scheduler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.acm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.coordinator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.acm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.coordinator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lambda_function.coordinator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.get_acm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [archive_file.coordinator](https://registry.terraform.io/providers/hashicorp/archive/2.4.2/docs/data-sources/file) | data source |
| [archive_file.get_acm](https://registry.terraform.io/providers/hashicorp/archive/2.4.2/docs/data-sources/file) | data source |
| [aws_sns_topic.acm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.acm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_function_name"></a> [acm\_function\_name](#input\_acm\_function\_name) | Name of ACM Lambda Function | `string` | n/a | yes |
| <a name="input_acm_lambda_arn"></a> [acm\_lambda\_arn](#input\_acm\_lambda\_arn) | ARN of ACM Lambda Function | `string` | n/a | yes |
| <a name="input_coordinator_function_name"></a> [coordinator\_function\_name](#input\_coordinator\_function\_name) | Name of Coordinator Lambda Function | `string` | n/a | yes |
| <a name="input_coordinator_lambda_role_arn"></a> [coordinator\_lambda\_role\_arn](#input\_coordinator\_lambda\_role\_arn) | ARN of Coordinator Lambda Role | `string` | n/a | yes |
| <a name="input_scheduler_role_arn"></a> [scheduler\_role\_arn](#input\_scheduler\_role\_arn) | ARN of Scheduler Role | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where resources will be provisioned. | `string` | `"us-east-1"` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_lambda_role_arn"></a> [acm\_lambda\_role\_arn](#output\_acm\_lambda\_role\_arn) | ARN of ACM Lambda Role |
| <a name="output_coordinator_lambda_arn"></a> [coordinator\_lambda\_arn](#output\_coordinator\_lambda\_arn) | ARN of Coordinator Lambda Function |
| <a name="output_scheduler_role_arn"></a> [scheduler\_role\_arn](#output\_scheduler\_role\_arn) | ARN of Scheduler Role |
<!-- END_TF_DOCS -->