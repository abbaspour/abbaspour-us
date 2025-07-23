# Auth0 Clients

# Native application client
resource "auth0_client" "session_transfer_native" {
  name                       = "session-transfer-native"
  description                = "Native application for session transfer"
  app_type                   = "native"
  is_first_party             = true
  oidc_conformant            = true

  callbacks = [
    "https://jwt.io"
  ]
  allowed_logout_urls = []
  web_origins = []

  grant_types = [
    "password",
    "http://auth0.com/oauth/grant-type/password-realm",
    "authorization_code",
    "refresh_token"
  ]

  session_transfer {
    can_create_session_transfer_token = true
    enforce_device_binding            = "asn"
    allow_refresh_token               = true
  }
}

# Configuring none as an authentication method.
resource "auth0_client_credentials" "session_transfer_native" {
  client_id = auth0_client.session_transfer_native.id
  authentication_method = "none"
}


# SPA application client
resource "auth0_client" "session_transfer_spa" {
  name                       = "session-transfer-spa"
  description                = "Single Page Application for session transfer"
  app_type                   = "spa"
  is_first_party             = true
  oidc_conformant            = true

  callbacks = [
    "https://jwt.io"
  ]

  allowed_logout_urls = []
  web_origins = []

  grant_types = [
    "authorization_code",
    "refresh_token",
    "implicit"
  ]

  session_transfer {
    allowed_authentication_methods = ["cookie", "query"]
  }
}

# Configuring none as an authentication method.
resource "auth0_client_credentials" "session_transfer_spa" {
  client_id = auth0_client.session_transfer_spa.id
  authentication_method = "none"
}

# outputs
output "session_transfer_native-client_id" {
  value = auth0_client.session_transfer_native.client_id
}

output "session_transfer_spa-client_id" {
  value = auth0_client.session_transfer_spa.client_id
}