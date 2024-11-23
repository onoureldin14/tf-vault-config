# Terraform Vault Configuration

This repository contains Terraform configurations for setting up Vault authentication and AWS IAM policies for trust relationships. The configurations enable integration between Terraform Cloud, Vault, and AWS.

## Repository Structure
. ├── .gitignore ├── .pre-commit-config.yaml ├── .terraform/ ├── data.tf ├── iam-policies.tf ├── iam-user.tf ├── locals.tf ├── outputs.tf ├── policies/ ├── providers.tf ├── random.tf ├── README.md ├── terraform.tf ├── tfe.tf ├── variables.tf ├── vault-auth.tf ├── vault-aws.tf ├── vault-ca.tf

Initialize Terraform:

Review and apply the Terraform configuration:

Pre-commit Hooks
This repository uses pre-commit hooks to ensure code quality. The hooks are defined in .pre-commit-config.yaml and include checks for YAML files, Terraform formatting, and more.

To install the pre-commit hooks, run:

License
This project is licensed under the MIT License. See the LICENSE file for details.


## Files and Directories

- **.gitignore**: Specifies files and directories to be ignored by Git.
- **.pre-commit-config.yaml**: Configuration for pre-commit hooks.
- **.terraform/**: Directory containing Terraform provider plugins.
- **data.tf**: Data sources for Terraform.
- **iam-policies.tf**: IAM policies for AWS.
- **iam-user.tf**: IAM user and access key for Vault trust relationships.
- **locals.tf**: Local values used in the Terraform configuration.
- **outputs.tf**: Output values from the Terraform configuration.
- **policies/**: Directory containing JSON policy files.
- **providers.tf**: Configuration for Terraform providers.
- **random.tf**: Configuration for random resources.
- **terraform.tf**: Main Terraform configuration file.
- **tfe.tf**: Configuration for Terraform Enterprise (TFE) and Terraform Cloud (TFC).
- **variables.tf**: Input variables for the Terraform configuration.
- **vault-auth.tf**: Configuration for Vault authentication.
- **vault-aws.tf**: Configuration for AWS secrets backend in Vault.
- **vault-ca.tf**: Configuration for Vault CA backend.

## Variables

The `variables.tf` file defines various input variables used throughout the Terraform configuration. Some key variables include:

- `tf_cloud_backend`: Enable Terraform Cloud as the backend.
- `aws_region`: AWS region for resources.
- `vault_namespace`: Namespace of the Vault instance.
- `tfc_project_name`: Name of the Terraform Cloud project.
- `tfc_organization_name`: Name of the Terraform Cloud organization.
- `tfc_variable_set_name`: Name of the Terraform Cloud variable set.

## Resources

The repository defines several Terraform resources, including:

- **AWS IAM User and Policies**: Defined in `iam-user.tf` and `iam-policies.tf`.
- **Vault AWS Secrets Backend**: Defined in `vault-aws.tf`.
- **Vault Authentication**: Defined in `vault-auth.tf`.
- **Terraform Cloud Project and Variables**: Defined in `tfe.tf`.

## Usage

1. Clone the repository:
   ```sh
   git clone <repository-url>
   cd <repository-directory>

2. Initialize Terraform:
terraform init

3. Review and apply the Terraform configuration:

terraform apply

##  Pre-commit Hooks
This repository uses pre-commit hooks to ensure code quality. The hooks are defined in .pre-commit-config.yaml and include checks for YAML files, Terraform formatting, and more.

To install the pre-commit hooks, run:

pre-commit install

## License
This project is licensed under the MIT License. See the LICENSE file for details.
