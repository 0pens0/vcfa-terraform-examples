# VCF-A Terraform Deployment Setup

This guide explains how to use the automated deployment script and parameters file.

## Quick Start

### 1. Configure Your Parameters

Copy the parameters file and update it with your VCF-A details:

```bash
cp parameters.env my-params.env
# Edit my-params.env with your values
```

### 2. Update Required Parameters

Edit `my-params.env` and set these **required** parameters:

```bash
# VCF-A Connection Details
VCFA_URL="https://your-vcfa-instance.example.com"
VCFA_REFRESH_TOKEN="your-refresh-token-here"
VCFA_ORG="your-org-name"
```

### 3. Run the Deployment

Deploy a specific example:

```bash
# Deploy VKS cluster
./deploy.sh vks-cluster

# Deploy virtual machine
./deploy.sh virtual-machine

# Deploy ArgoCD
./deploy.sh argocd

# Deploy all examples
./deploy.sh all
```

## Detailed Usage

### Script Options

```bash
# Show help
./deploy.sh --help

# List available examples
./deploy.sh --list

# Use custom parameters file
./deploy.sh --params my-params.env vks-cluster
```

### Parameter File Structure

The `parameters.env` file contains:

#### Required Parameters
- `VCFA_URL` - Your VCF-A instance URL
- `VCFA_REFRESH_TOKEN` - Your VCF-A refresh token
- `VCFA_ORG` - Your VCF-A organization name

#### Optional Parameters (with defaults)
- `PROJECT_NAME` - VCF-A project name (default: "default-project")
- `REGION_NAME` - VCF-A region name (default: "west")
- `VPC_NAME` - VCF-A VPC name (default: "west-Default-VPC")
- `ZONE_NAME` - VCF-A zone name (default: "z-wld-a")
- `VM_USER_PASSWORD` - VM user password (default: "VMware123!")

## Getting Your VCF-A Credentials

### 1. VCF-A URL
- This is the URL you use to log into VCF-A
- Example: `https://vcfa.company.com`

### 2. Refresh Token
1. Log into your VCF-A instance
2. Go to your profile/settings
3. Generate a refresh token
4. Copy the token to your parameters file

### 3. Organization Name
- This is your VCF-A organization name
- You can find this in the VCF-A UI

## Examples

### Example 1: Deploy VKS Cluster
```bash
# 1. Configure parameters
cp parameters.env my-params.env
# Edit my-params.env with your VCF-A details

# 2. Deploy
./deploy.sh vks-cluster
```

### Example 2: Deploy Virtual Machine
```bash
# 1. Configure parameters
cp parameters.env my-params.env
# Edit my-params.env with your VCF-A details

# 2. Deploy
./deploy.sh virtual-machine
```

### Example 3: Deploy All Examples
```bash
# 1. Configure parameters
cp parameters.env my-params.env
# Edit my-params.env with your VCF-A details

# 2. Deploy all examples
./deploy.sh all
```

## Troubleshooting

### Common Issues

1. **"Missing required parameters"**
   - Check that all required parameters are set in your parameters file
   - Ensure there are no extra spaces or quotes

2. **"Terraform is not installed"**
   - Install Terraform: https://www.terraform.io/downloads

3. **Connection errors**
   - Verify your VCF-A URL is correct
   - Check that your refresh token is valid
   - Ensure your organization name is correct

4. **Environment-specific errors**
   - Update the optional parameters to match your VCF-A environment
   - Check that your region, VPC, and zone names exist

### Manual Deployment

If you prefer to deploy manually without the script:

```bash
# 1. Copy example configuration
cd vks-cluster
cp terraform.tfvars.example terraform.tfvars

# 2. Edit terraform.tfvars with your values

# 3. Deploy
terraform init
terraform plan
terraform apply
```

## Security Notes

- Keep your `parameters.env` file secure
- Don't commit it to version control
- Use strong passwords for VM deployments
- Rotate your refresh tokens regularly 