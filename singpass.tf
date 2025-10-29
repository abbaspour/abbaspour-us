# Native application client
resource "auth0_client" "singpass-jwt-io" {
  name                       = "singpass-jwt-io"
  description                = "singpass-jwt-io"
  app_type                   = "native"
  is_first_party             = true
  oidc_conformant            = true

  callbacks = [
    "https://jwt.io"
  ]

  allowed_logout_urls = []
  web_origins = []

  grant_types = [
    "implicit"
  ]
}


resource "auth0_connection" "oidc" {
  name     = "OIDC-Connection"
  strategy = "oidc"

  options {
    client_id                       = "OMaeWMfqhId0wwR4FGs7gGgCDCUYNqgW"
    scopes                          = ["openid", "profile"]
    # issuer                          = "https://id.abbaspour.net"
    # authorization_endpoint          = "https://example.com"
    # jwks_uri                        = "https://example.com/jwks"
    type                            = "back_channel"
    discovery_url                   = "https://stg-id.singpass.gov.sg/.well-known/openid-configuration"
    token_endpoint_auth_method      = "private_key_jwt"
    token_endpoint_auth_signing_alg = "RS256"
  }
}

# Resource used to rotate the keys for above OIDC connection
resource "auth0_connection_keys" "singpass_keys" {
  connection_id = auth0_connection.oidc.id

  
  triggers = {
    version = "1"
    date    = "2023-10-01T00:00:00Z"
  }
}