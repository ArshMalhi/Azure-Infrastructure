output "resource_group_names" {
  description = "Resource group name for each zone."
  value       = { for zone, rg in module.resource_groups : zone => rg.name }
}