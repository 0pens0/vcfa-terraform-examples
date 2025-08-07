variable "region_name" {
  type        = string
}

variable "vpc_name" {
  type        = string
}

variable "zone_name" {
  type        = string
}

variable "project_name" {
  type        = string
  description = "The VCF Automation project name"
  default     = "default-project"
}