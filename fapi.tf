resource "auth0_client" "par-client-vivaldi" {
  name = "par-client-vivaldi"

  description     = "Client for FAPI 2.0 conformant OIDC EC PAR client"
  app_type        = "regular_web"
  is_first_party  = true
  oidc_conformant = true
  sso             = true

  jwt_configuration {
    alg = "RS256"
  }

  callbacks = [
    "https://fapi.local.dev.auth0.com/login/callback",
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
  name = "par-client-vivaldi"

  description     = "Client for FAPI 2.0 conformant OIDC EC PAR client"
  app_type        = "regular_web"
  is_first_party  = true
  oidc_conformant = true
  sso             = true

  jwt_configuration {
    alg = "RS256"
  }

  callbacks = [
    "https://fapi.local.dev.auth0.com/login/callback",
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
