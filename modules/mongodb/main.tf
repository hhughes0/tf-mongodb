locals {
  json_data = jsondecode(file("${path.module}/variables.json"))
}

resource "mongodbatlas_cluster" "cluster-test" {
  for_each   = toset(local.json_data.service_configuration[*].mongoCluster)
  project_id = var.project_id
  name       = each.value

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "US_EAST_1"
  provider_instance_size_name = "M0"
}

resource "random_password" "password" {
  for_each         = toset(local.json_data.service_configuration[*].serviceName)
  length           = 16
  special          = true
  override_special = "_%"
}

resource "mongodbatlas_database_user" "test" {
  depends_on = [
    mongodbatlas_cluster.cluster-test
  ]
  for_each           = { for f in local.json_data.service_configuration : f.serviceName => f }
  username           = each.value.serviceName
  password           = random_password.password[each.value.serviceName].result
  project_id         = var.project_id
  auth_database_name = "admin"

  dynamic "roles" {
    for_each = each.value.mongoCollection
    content {
      role_name       = "read"
      database_name   = each.value.mongoDatabase
      collection_name = roles.value
    }
  }
}

data "mongodbatlas_clusters" "test" {
  depends_on = [
    mongodbatlas_cluster.cluster-test
  ]
  for_each   = toset(local.json_data.service_configuration[*].mongoCluster)
  project_id = var.project_id
}


data mongodbatlas_cluster this {
  depends_on = [
    data.mongodbatlas_clusters.test
  ]
  for_each   = data.mongodbatlas_clusters.test
  project_id = var.project_id
  name       = each.value.results[0].name
}

