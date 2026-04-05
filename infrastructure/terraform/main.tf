data "azurerm_client_config" "current" {}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source              = "./modules/vnet"
  name                = "${var.resource_group_name}-vnet"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = ["10.1.0.0/16"]
  subnet_prefix       = ["10.1.1.0/24"]
  tags                = var.tags
}

module "storage" {
  source              = "./modules/storage_account"
  name                = "${var.resource_group_name}sa"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

module "key_vault" {
  source              = "./modules/key_vault"
  name                = "${var.resource_group_name}-kv"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  owner_object_id     = data.azurerm_client_config.current.object_id
  tags                = var.tags
}

module "app_service" {
  source              = "./modules/app_service"
  name                = "${var.resource_group_name}-app"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  plan_sku            = var.appservice_plan_sku
  tags                = var.tags
  app_settings = {
    SERVICE_NAME     = "DevOps Bridge"
    STORAGE_CONN_STR = module.storage.primary_connection_string
    LOG_LEVEL        = "info"
    ENVIRONMENT      = "production"
  }
}
