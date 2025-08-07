# VCF-A terraform Examples

This repo contains a collection of examples how to interact with VCF-A using terraform. 

## Prerequisites

Before running any of the examples, you need to configure the following parameters:

### Required Parameters
- `vcfa_url` - The VCF Automation URL
- `vcfa_refresh_token` - Your VCF Automation refresh token
- `vcfa_org` - Your VCF Automation organization name

### Optional Parameters (with defaults)
- `project_name` - VCF Automation project name (default: "default-project")
- `region_name` - VCF Automation region name (default: "west")
- `vpc_name` - VCF Automation VPC name (default: "west-Default-VPC")
- `zone_name` - VCF Automation zone name (default: "z-wld-a")

### Configuration

#### Option 1: Automated Deployment (Recommended)
Use the provided deployment script for easy automation:

```bash
# 1. Configure your parameters
cp parameters.env my-params.env
# Edit my-params.env with your VCF-A details

# 2. Deploy using the script
./deploy.sh vks-cluster
./deploy.sh virtual-machine
./deploy.sh argocd
./deploy.sh all  # Deploy all examples
```

See [SETUP.md](./SETUP.md) for detailed instructions.

#### Option 2: Manual Deployment
Each example directory contains a `terraform.tfvars.example` file. Copy it to `terraform.tfvars` and update the values:

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

## Examples

* [vks cluster](./vks-cluster) -  simple example of creating a supervisor namespace and a vks cluster in the namespace.
* [Virtual machine](./virtual-machine) - simple example of creating a virtual machine and it's required resources.
* [ArgoCD](./argocd) - example of deploying ArgoCD in a supervisor namespace.

## FAQ

### Why is the supervisor namespace created in it's own terraform run

This is an issue with the kubernetes provider for terraform and specifically the `manifest` resource. In order to use the manifest resource the provider needs to contact the k8s api during plan in order to validate the CRDs and look up their APIs.  In our case the k8s api is the VCF-A api. The content is targeting the new namespace for deploying the resources. So due to the way that the k8s provider works it needs to have access to  that namespace context during plan, so we need to create the namespace first.