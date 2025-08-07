variable "vcfa_refresh_token" {
  type        = string
  description = "The VCF Automation refresh token"
  sensitive   = true
}

variable "vcfa_url" {
  type        = string
  description = "The VCF Automation url"
}

variable "vcfa_org" {
  type        = string
  description = "The VCF Automation org"
  default     = "acme"
}

variable "project_name" {
  type        = string
  description = "The VCF Automation project name"
  default     = "default-project"
}

variable "region_name" {
  type        = string
  description = "The VCF Automation region name"
  default     = "west"
}

variable "vpc_name" {
  type        = string
  description = "The VCF Automation VPC name"
  default     = "west-Default-VPC"
}

variable "zone_name" {
  type        = string
  description = "The VCF Automation zone name"
  default     = "z-wld-a"
}

variable "vm_user_password" {
  type        = string
  description = "The password for the VM user"
  sensitive   = true
}