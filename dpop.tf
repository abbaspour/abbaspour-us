resource "auth0_resource_server" "dpop-rs" {
  identifier = "dpop.rs"
  name = "dpop.rs"
  allow_offline_access = true

  proof_of_possession {
    required_for = "all_clients"
    mechanism = "dpop"
    required  = true
  }
}

resource "auth0_resource_server_scopes" "dpop-rs-scopes" {
  resource_server_identifier = auth0_resource_server.dpop-rs.identifier

  scopes {
    name = "s1"
  }

  scopes {
    name = "s2"
  }
}

resource "auth0_client" "dpop-rwa" {
  name = "dpop-rwa"
  description                = "Client to test DPoP"
  app_type                   = "regular_web"
  is_first_party             = true
  oidc_conformant            = true

  callbacks = [
    "https://jwt.io"
  ]

  grant_types = [
    "authorization_code",
    "refresh_token",
    "implicit"
  ]
}

data "auth0_client" "dpop-rwa" {
  client_id = auth0_client.dpop-rwa.client_id
}

# outputs
output "dpop-rwa-client-id" {
  value = auth0_client.dpop-rwa.client_id
}

output "dpop-rwa-client-secret" {
  value = nonsensitive(data.auth0_client.dpop-rwa.client_secret)
}

output "dpop-rs-id" {
  value = auth0_resource_server.dpop-rs.id
}