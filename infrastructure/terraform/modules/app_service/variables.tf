variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "plan_sku" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "app_settings" {
  type = map(string)
  default = {}
}
