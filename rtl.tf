
resource "auth0_client" "dubai-spa" {
  name            = "Dubai SPA Client RTL"
  app_type        = "spa"
  oidc_conformant = true

  grant_types = [
    "authorization_code",
    "http://auth0.com/oauth/grant-type/password-realm",
    "implicit",
    "password",
    "refresh_token"
  ]

  callbacks = [
    "https://jwt.io"
  ]
}

output "dubai-spa-client_id" {
  value = auth0_client.dubai-spa.client_id
}