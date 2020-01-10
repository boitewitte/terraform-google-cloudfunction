# Terraform Module: Google CloudFunction


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| entry\_point | Name of the function that will be executed when the Google Cloud Function is triggered. | `string` | n/a | yes |
| name | A user-defined name of the function. Function names must be unique globally. | `string` | n/a | yes |
| region | Region to which the Cloudfunction will be deployed | `string` | n/a | yes |
| runtime | The runtime in which the function is going to run. | `string` | n/a | yes |
| available\_memory\_mb | Memory (in MB), available to the function. Default value is 256MB. Allowed values are: 128MB, 256MB, 512MB, 1024MB, and 2048MB. | `string` | `"256MB"` | no |
| description | Description of the Cloudfunction | `string` | `"null"` | no |
| environment\_variables | A set of key/value environment variable pairs to assign to the function. | `map(string)` | `"null"` | no |
| event\_triggers | A source that fires events in response to a condition in another service. Can't be used in conjunction with trigger\_http | `object` | `[]` | no |
| function\_source | Defines the Source configuration for the Cloudfunction. Can't be used in conjunction with source\_repository\_url | `object` | `"null"` | no |
| invoker\_members | Cloudfunction can be invoked by the members defined in this list | `list(string)` | `[]` | no |
| is\_public\_function | Cloudfunction can be invoked by all users - Public function | `bool` | `false` | no |
| labels | A set of key/value label pairs to assign to the function. | `map(string)` | `"null"` | no |
| max\_instances | The limit on the maximum number of function instances that may coexist at a given time. | `number` | `"null"` | no |
| project\_id | The Project ID to which the function will be deployed | `string` | `"null"` | no |
| project\_roles | List of roles within other projects that will be attached to the Cloudfunction | `object` | `[]` | no |
| roles | List of roles that will be attached to the Cloudfunction within the same project | `list(string)` | `[]` | no |
| source\_repository\_url | The URL pointing to the hosted Cloud Source repository where the function is defined. | `string` | `"null"` | no |
| timeout | Timeout (in seconds) for the function. Default value is 60 seconds. Cannot be more than 540 seconds. | `number` | `60` | no |
| trigger\_http | Boolean variable. Any HTTP request (of a supported type) to the endpoint will trigger function execution. | `bool` | `"null"` | no |
| vpc\_connector | The VPC Network Connector that this cloud function can connect to. | `string` | `"null"` | no |

## Outputs

| Name | Description |
|------|-------------|
| available\_memory\_mb | Memory (in MB), available to the function. |
| entry\_point | Name of the function that will be executed when the Google Cloud Function is triggered. |
| https\_trigger\_url | URL which triggers function execution. Returned only if trigger\_http is used. |
| name | The name for the Cloudfunction |
| project\_id | ID of the project to which the Cloudfunction is deployed |
| region | Region to which the Cloudfunction is deployed |
| runtime | The runtime in which the function is going to run |
| service\_account | Service Account for the Cloud Function |
| service\_account\_email | The email for the Service Account to run the function with |
| source\_repository | The URL pointing to the hosted repository where the function was defined at the time of deployment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
