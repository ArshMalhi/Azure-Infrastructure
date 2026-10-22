module "resource_group" {
  source   = "../modules/resource-group"
  for_each = local.resource_groups

  name     = "rg-${local.name_suffix}-${each.key}"
  location = var.location
  tags     = merge(local.tags, { purpose = each.value })
}