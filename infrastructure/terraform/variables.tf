variable "location" {
  description = "Primary Azure location for resources."
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Name of the shared resource group."
  default     = "main-rg"
}

variable "tenant_id" {
  description = "Azure tenant id used for authentication."
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription id where resources will be provisioned."
  type        = string
}

variable "client_id" {
  description = "Service principal client id used to authenticate."
  type        = string
}

variable "client_secret" {
  description = "Service principal secret used to authenticate."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    project = "devops-bridge"
    owner   = "platform-team"
  }
}

variable "appservice_plan_sku" {
  description = "SKU for the App Service plan."
  type        = string
  default     = "S1"
}
