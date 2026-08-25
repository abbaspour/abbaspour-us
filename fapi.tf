resource "auth0_client" "par-client-vivaldi" {
  name = "par-client-confidential"

  description     = "Client for FAPI 2.0 conformant OIDC EC PAR client"
  app_type        = "regular_web"
  is_first_party  = true
  oidc_conformant = true
  sso             = true

  jwt_configuration {
    alg = "RS256"
  }

  refresh_token {
    expiration_type = "non-expiring"
    rotation_type   = "non-rotating"
  }

  callbacks = [
    "https://fapi.local.dev.auth0.com/login/callback",
    "https://par.abbaspour.net/login/callback",
    "http://local.abbaspour.net:1980/cgi-bin/cb.sh",
  ]

  grant_types = [
    "authorization_code",
    "refresh_token",
    "implicit"
  ]

  require_pushed_authorization_requests = true
  require_proof_of_possession           = false
}

output "par-client-id" {
  value = auth0_client.par-client-vivaldi.client_id
}

resource "auth0_client" "par-client-vivaldi-dpop" {
  name = "par-client-confidential-dpop"

  description     = "Client for FAPI 2.0 conformant OIDC EC PAR client"
  app_type        = "regular_web"
  is_first_party  = true
  oidc_conformant = true
  sso             = true

  jwt_configuration {
    alg = "RS256"
  }

  refresh_token {
    expiration_type = "non-expiring"
    rotation_type   = "non-rotating"
  }

  callbacks = [
    "https://fapi.local.dev.auth0.com/login/callback",
    "https://par.abbaspour.net/login/callback",
    "http://local.abbaspour.net:1980/cgi-bin/cb.sh",
  ]

  grant_types = [
    "authorization_code",
    "refresh_token",
    "implicit"
  ]

  require_pushed_authorization_requests = true
  require_proof_of_possession           = true
}


output "par-dpop-client-id" {
  value = auth0_client.par-client-vivaldi-dpop.client_id
}

# https://mcplay-gamma.vercel.app/amin
resource "auth0_resource_server" "offline-rs" {
  identifier = "offline-rs"
  name = "offline-rs"
  allow_offline_access = true
  skip_consent_for_verifiable_first_party_clients = true

  subject_type_authorization {

    user {
      policy = "allow_all"
    }

    client {
      policy = "require_client_grant"
    }
  }


}

resource "auth0_resource_server_scopes" "offline-rs-scopes" {
  resource_server_identifier = auth0_resource_server.offline-rs.identifier

  scopes {
    name = "do"
    description = "just do it"
  }
}