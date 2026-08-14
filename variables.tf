variable "project_name" {
  type    = string
  default = "serverless-demo"
}

variable "resource_group_name" {
  type    = string
  default = "rg-serverless-demo"
}

variable "location" {
  type    = string
  default = "uaenorth"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "storage_account_name" {
  type = string
}

variable "function_app_name" {
  type = string
}