locals {
  location_short = {
    australiaeast      = "aue"
    australiasoutheast = "aus"
    australiacentral   = "auc"
  }[var.location]

  # e.g. citadel-dev-aue  ->  rg-citadel-dev-aue-hub
  name_suffix = "${var.workload}-${var.environment}-${local.location_short}"

  tags = {
    workload    = var.workload
    environment = var.environment
    owner       = var.owner
    managed_by  = "terraform"
    repo        = "Azure-Infrastructure"
  }

  resource_groups = {
    sanctum = "Shared networking: hub VNet, Bastion, private DNS"
    outpost = "Application workload spoke: VM Scale Set"
    zion    = "Monitoring and recovery: Log Analytics, Recovery Services Vault"
  }
}