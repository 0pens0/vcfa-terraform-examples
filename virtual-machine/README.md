# Virtual Machine Example

This example creates a virtual machine and its required resources including a supervisor namespace, content library, and VM service.

## Configuration

Copy the example configuration file and update it with your values:

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your VCF-A details
```

### Required Parameters
- `vcfa_url` - The VCF Automation URL
- `vcfa_refresh_token` - Your VCF Automation refresh token
- `vm_user_password` - The password for the VM user

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
- A content library named "My Library"
- An Ubuntu OVA image downloaded and uploaded to the content library
- A virtual machine service (LoadBalancer) for SSH access
- A virtual machine with Ubuntu image
- The VM is configured with cloud-init for user setup
- The VM is powered on automatically