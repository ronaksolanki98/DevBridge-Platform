module "vnet" {
  source = "git::https://gitlab.com/@solankironak423/terraform-azure-vnet.git"

  name          = "main-vnet"
  address_space = ["10.0.0.0/16"]
  location      = "Central India"
  rg_name       = "main-rg"
}

module "storage" {
  source = "git::https://gitlab.com/@solankironak423/terraform-azure-storage.git"

  name     = "mainstorage12345"
  location = "Central India"
  rg_name  = "main-rg"
}

module "appservice" {
  source = "git::https://gitlab.com/@solankironak423/terraform-azure-appservice.git"

  plan_name = "main-plan"
  app_name  = "main-app-12345"
  location  = "Central India"
  rg_name   = "main-rg"
}

module "keyvault" {
  source = "git::https://gitlab.com/@solankironak423/terraform-azure-keyvault.git"

  name     = "main-kv-12345"
  location = "Central India"
  rg_name  = "main-rg"
}