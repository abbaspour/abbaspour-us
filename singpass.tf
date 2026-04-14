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

output "singpass-jwt-io" {
  value = auth0_client.singpass-jwt-io.client_id
}

// this is pointing to https://keys.abbaspour.net/.well-known/jwks.json for oidc-bash testing
resource "auth0_connection" "oidc" {
  name     = "OIDC-Connection"
  strategy = "oidc"

  options {
    client_id                       = "OMaeWMfqhId0wwR4FGs7gGgCDCUYNqgW"
    scopes                          = ["openid", "profile"]
    issuer                          = "https://stg-id.singpass.gov.sg"
    authorization_endpoint          = "https://stg-id.singpass.gov.sg/auth"
    jwks_uri                        = "https://stg-id.singpass.gov.sg/.well-known/keys"
    token_endpoint                  = "https://stg-id.singpass.gov.sg/token"
    type                            = "back_channel"
    #discovery_url                   = "https://stg-id.singpass.gov.sg/.well-known/openid-configuration"
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

// this is pointing to https://id.abbaspour.net/oauth/connection/singpass/.well-known/jwks.json
resource "auth0_connection" "singpass" {
  name     = "singpass"
  strategy = "oidc"

  options {
    client_id                       = "wgQVLL3CBULMXwwJkPncoBYypXEabGeD"
    scopes                          = ["openid"]
    issuer                          = "https://stg-id.singpass.gov.sg"
    authorization_endpoint          = "https://stg-id.singpass.gov.sg/auth"
    jwks_uri                        = "https://stg-id.singpass.gov.sg/.well-known/keys"
    #token_endpoint                  = "https://stg-id.singpass.gov.sg/token"
    #token_endpoint                  = "https://logging-token-endpoint.abbaspour.workers.dev"
    type                            = "back_channel"
    discovery_url                   = "https://stg-id.singpass.gov.sg/.well-known/openid-configuration"
    token_endpoint_auth_method      = "private_key_jwt"
    token_endpoint_auth_signing_alg = "ES256"
    #pkce_enabled = true
    connection_settings {
      pkce = "S256"
    }
  }
}

# Resource used to rotate the keys for above OIDC connection
/*resource "auth0_connection_keys" "singpass2_keys" {
  connection_id = auth0_connection.singpass.id


  triggers = {
    version = "1"
    date    = "2023-10-01T00:00:00Z"
  }
}
*/