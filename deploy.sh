#!/bin/bash

# VCF-A Terraform Deployment Script
# This script automates the deployment of VCF-A resources using Terraform

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to validate required parameters
validate_parameters() {
    local missing_params=()
    
    if [[ -z "$VCFA_URL" ]]; then
        missing_params+=("VCFA_URL")
    fi
    
    if [[ -z "$VCFA_REFRESH_TOKEN" ]]; then
        missing_params+=("VCFA_REFRESH_TOKEN")
    fi
    
    if [[ -z "$VCFA_ORG" ]]; then
        missing_params+=("VCFA_ORG")
    fi
    
    if [[ ${#missing_params[@]} -gt 0 ]]; then
        print_error "Missing required parameters: ${missing_params[*]}"
        print_error "Please check your parameters.env file"
        exit 1
    fi
}

# Function to check if terraform is installed
check_terraform() {
    if ! command_exists terraform; then
        print_error "Terraform is not installed. Please install Terraform first."
        exit 1
    fi
    
    local terraform_version=$(terraform version -json | jq -r '.terraform_version' 2>/dev/null || echo "unknown")
    print_status "Using Terraform version: $terraform_version"
}

# Function to deploy a specific example
deploy_example() {
    local example_dir=$1
    local example_name=$2
    
    print_status "Deploying $example_name..."
    
    if [[ ! -d "$example_dir" ]]; then
        print_error "Example directory '$example_dir' not found"
        return 1
    fi
    
    cd "$example_dir"
    
    # Create terraform.tfvars from parameters
    create_tfvars
    
    # Initialize Terraform
    print_status "Initializing Terraform..."
    terraform init
    
    # Plan the deployment
    print_status "Planning deployment..."
    terraform plan -out=tfplan
    
    # Ask for confirmation
    echo
    read -p "Do you want to apply this plan? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Applying Terraform plan..."
        terraform apply tfplan
        print_success "$example_name deployment completed!"
    else
        print_warning "Deployment cancelled by user"
        return 1
    fi
    
    cd ..
}

# Function to create terraform.tfvars from environment variables
create_tfvars() {
    cat > terraform.tfvars << EOF
# VCF-A Configuration
vcfa_url = "$VCFA_URL"
vcfa_refresh_token = "$VCFA_REFRESH_TOKEN"
vcfa_org = "$VCFA_ORG"

# Environment Configuration
project_name = "${PROJECT_NAME:-default-project}"
region_name = "${REGION_NAME:-west}"
vpc_name = "${VPC_NAME:-west-Default-VPC}"
zone_name = "${ZONE_NAME:-z-wld-a}"

# VM-specific configuration (only for virtual-machine example)
vm_user_password = "${VM_USER_PASSWORD:-VMware123!}"
EOF

    print_status "Created terraform.tfvars with your configuration"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS] [EXAMPLE]"
    echo
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -p, --params   Path to parameters file (default: parameters.env)"
    echo "  --list         List available examples"
    echo
    echo "Examples:"
    echo "  vks-cluster     Deploy VKS cluster"
    echo "  virtual-machine Deploy virtual machine"
    echo "  argocd         Deploy ArgoCD"
    echo "  all            Deploy all examples"
    echo
    echo "Examples:"
    echo "  $0 vks-cluster"
    echo "  $0 --params my-params.env virtual-machine"
    echo "  $0 all"
}

# Function to list available examples
list_examples() {
    echo "Available examples:"
    echo "  vks-cluster     - VKS cluster with supervisor namespace"
    echo "  virtual-machine - Virtual machine with content library"
    echo "  argocd         - ArgoCD deployment"
    echo "  all            - Deploy all examples"
}

# Main script
main() {
    local params_file="parameters.env"
    local example=""
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -p|--params)
                params_file="$2"
                shift 2
                ;;
            --list)
                list_examples
                exit 0
                ;;
            -*)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
            *)
                example="$1"
                shift
                ;;
        esac
    done
    
    # Check if parameters file exists
    if [[ ! -f "$params_file" ]]; then
        print_error "Parameters file '$params_file' not found"
        print_error "Please create the parameters file first"
        exit 1
    fi
    
    # Load parameters
    print_status "Loading parameters from $params_file"
    source "$params_file"
    
    # Validate parameters
    validate_parameters
    
    # Check Terraform installation
    check_terraform
    
    # Deploy based on example
    case "$example" in
        "vks-cluster")
            deploy_example "vks-cluster" "VKS Cluster"
            ;;
        "virtual-machine")
            deploy_example "virtual-machine" "Virtual Machine"
            ;;
        "argocd")
            deploy_example "argocd" "ArgoCD"
            ;;
        "all")
            print_status "Deploying all examples..."
            deploy_example "vks-cluster" "VKS Cluster"
            deploy_example "virtual-machine" "Virtual Machine"
            deploy_example "argocd" "ArgoCD"
            print_success "All deployments completed!"
            ;;
        "")
            print_error "No example specified"
            show_usage
            exit 1
            ;;
        *)
            print_error "Unknown example: $example"
            list_examples
            exit 1
            ;;
    esac
}

# Run main function
main "$@" 