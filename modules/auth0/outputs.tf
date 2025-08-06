output "auth0_client_id" {
  description = "Auth0 client ID"
  value       = auth0_client.hello_world_app.client_id
}


output "auth0_client_secret" {
  value     = var.client_secret
  sensitive = true
}
