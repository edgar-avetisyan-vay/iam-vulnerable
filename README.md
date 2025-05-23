# IAM Terraform Repo for AWS

This repository contains Terraform configurations used to demonstrate IAM privilege escalation scenarios.  
The configuration is organised following a simple module structure.

## Layout

- `provider.tf` – provider configuration and AWS caller lookup.
- `modules.tf` – references to the individual modules containing the resources and policies.
- `variables.tf` – input variables shared across modules.
- `modules/` – reusable modules grouped by purpose.

Copy `terraform.tfvars.example` to `terraform.tfvars` and update the values to match your environment before applying the configuration.
