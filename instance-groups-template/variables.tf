variable "name" {
    description = "friendly name of the project"
    type        = string
}

variable "description" {
    description = "description of the project"
    type        = string
  
}

variable "service_account_id" {
    description   = "Service Account ID"
    type          = string
}

variable "service_account_display_name" {
    description   = "Service Account Display Name"
    type          = string
}

variable "environment_type" {
    description = "Type of environment: dev, uat, prod"
    type        = string
}

variable "bootdisk_image" {
    description   = "Bootdisk Image"
    type          = string
}