data "auth0_resource_server" "MyAccount" {
  identifier = "https://${var.auth0_domain}/me/"
}

resource "auth0_client" "shared_device_passkey_spa" {
  name = "Share Device SPA"
  app_type = "native"
  is_first_party = true
  oidc_conformant = true


  grant_types = [
    "password",
    "http://auth0.com/oauth/grant-type/password-realm",
    "urn:okta:params:oauth:grant-type:webauthn"
  ]

  callbacks = [
    "http://localhost:8000"
  ]

  allowed_logout_urls = [
    "http://localhost:8000"
  ]

}

resource "auth0_client_grant" "shared_device_passkey_spa" {
  audience  = data.auth0_resource_server.MyAccount.identifier
  client_id = auth0_client.shared_device_passkey_spa.client_id
  scopes = [
    "create:me:authentication_methods",
    "read:me:authentication_methods",
  ]
  subject_type = "user"
}

output "shared_device_passkey_spa-client_id" {
  value = auth0_client.shared_device_passkey_spa.client_id
}