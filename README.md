# IAC-Terraform
This repository contains sample modules and templates to demo at `HU Talks: Infrastructure as Code`.

## Folder structure
There are 2 directories in the root folder
- `modules`: all modules in this project
- `examples`: example templates to handle locally and test each module

## AWS Account Setup
In order to deploy the infrastructure from the examples, you need to create an IAM User in your AWS Account. This user only needs to have the `AmazonEC2FullAccess` managed policy attached. 

You can also create a custom policy and specify a condition for the given permission (e.g: limit the permission to a specific region). For instance, if you'll be deploying infrastructure to `us-west-2`, you can use the following policy:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": "us-west-2"
                }
            }
        }
    ]
}
```

You will need to generate an Access Key pair for that user and configure its credentials in the environment file.

## Environment Configuration
Inside each environment's folder, you will find a `env.example` file with an example environment file. You must copy this file to a `.env` file in the same directory and set each variable to the appropriate value.

Once configured, you can apply the environment by sourcing the file with `source .env`.

---
## Additional Notes

### Provider Installation
When you run `terraform init`, the provider plugin for each cloud provider will be downloaded and installed in each module's directory. If you leave the default configurations, the project will fastly grow in size, as you will have the same provider source files multiple times.

To avoid this behaviour, create a [CLI configuration file](https://www.terraform.io/cli/config/config-file#provider-plugin-cache) and configure a `plugin_cache_dir` directory. Then, delete any existing `.terraform` folders in this project and re-initialize every module. This way, the providers will only be installed once in the `plugin_cache_dir` directory and simlinks will be created in this project's modules.

### Using Pre-commit
This project is configured with [pre-commit](https://github.com/antonbabenko/pre-commit-terraform) using [tflint](https://github.com/terraform-linters/tflint) to enforce validations on your code.

In order to use them, you should
1. Install pre-commit
    - MacOS: `brew install pre-commit`
    - Linux: `pip install pre-commit`
2. Install tflint
    - MacOS: `brew install tflint`
    - Linux: `curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash`
3. Run `tflint --init` to install configured tflint plugins
4. Run `pre-commit install` to install the pre-commit hook in the repo.

Now every time you commit a code change (`.tf` file), the hooks in `.pre-commit-config.yaml` will execute.

### Updating Documentation
You can update all `README.md` files for each module by using [terraform-docs](https://github.com/terraform-docs/terraform-docs). This can be done for all files in a folder by running

`terraform-docs markdown table --output-file README.md --output-mode inject --recursive --recursive-path [folder] .`

Where `folder` should be one of `examples` or `modules`.
