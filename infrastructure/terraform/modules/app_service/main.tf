resource "azurerm_app_service_plan" "plan" {
  name                = "${var.name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true
  sku_name            = var.plan_sku
  tags                = var.tags
}

resource "azurerm_app_service" "service" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = "PYTHON|3.12"
    always_on        = true
  }

  app_settings = var.app_settings

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
