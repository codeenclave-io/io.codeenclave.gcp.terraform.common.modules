variable "organization_id" {
    description   = "GCP Organization id"
    type          = string
}

variable "department_id" {
    description = "Name of a department underwhich the project will be create"
    type        = string
}

variable "name" {
    description = "friendly name of the project"
    type        = string
}

variable "environment_type" {
    description = "Type of environment: dev, uat, prod"
    type        = string
}

variable "data_classification" {
    description = "Clasification of the allowable data: c1, c2, c3"
    type        = string
}

variable "region" {
    description = "region of the environment"
    type        = string
}
