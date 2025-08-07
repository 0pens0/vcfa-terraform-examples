# ArgoCD Example

This example deploys ArgoCD in a supervisor namespace.

## Configuration

Copy the example configuration file and update it with your values:

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your VCF-A details
```

### Required Parameters
- `vcfa_url` - The VCF Automation URL
- `vcfa_refresh_token` - Your VCF Automation refresh token
- `vcfa_org` - Your VCF Automation organization name
- `region_name` - VCF Automation region name
- `vpc_name` - VCF Automation VPC name
- `zone_name` - VCF Automation zone name

### Optional Parameters (with defaults)
- `project_name` - VCF Automation project name (default: "default-project")

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## What gets created

- A supervisor namespace with the prefix "lab"
- An ArgoCD instance named "argocd-1"
- A service account for ArgoCD management
- A role binding for the service account
- A cluster secret for namespace registration
- ArgoCD version 2.14.13+vmware.1-vks.1