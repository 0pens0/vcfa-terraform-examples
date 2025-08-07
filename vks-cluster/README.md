# VKS Cluster Example

This example creates a supervisor namespace and a VKS cluster in the namespace.

## Configuration

Copy the example configuration file and update it with your values:

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your VCF-A details
```

### Required Parameters
- `vcfa_url` - The VCF Automation URL
- `vcfa_refresh_token` - Your VCF Automation refresh token

### Optional Parameters (with defaults)
- `vcfa_org` - VCF Automation organization name (default: "acme")
- `project_name` - VCF Automation project name (default: "default-project")
- `region_name` - VCF Automation region name (default: "west")
- `vpc_name` - VCF Automation VPC name (default: "west-Default-VPC")
- `zone_name` - VCF Automation zone name (default: "z-wld-a")

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## What gets created

- A supervisor namespace with the prefix "lab"
- A VKS cluster named "lab-1" in the namespace
- The cluster uses the "builtin-generic-v3.3.0" topology class
- 1 control plane node and 1 worker node
- Kubernetes version v1.32.0+vmware.6-fips