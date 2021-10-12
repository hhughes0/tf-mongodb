output "connection_strings" {
  value = local.json_data["service_configuration"]
}

output "pwd" {
  value = random_password.password[*]
}
