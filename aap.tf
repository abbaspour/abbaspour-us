resource "auth0_client" "agent-associated-m2m" {
  name     = "agent-associated-m2m"
  app_type = "non_interactive"

  oidc_conformant = true
  grant_types = [
    "client_credentials",
  ]

  jwt_configuration {
    alg = "RS256"
  }
}

resource "auth0_resource_server" "agent-associated-rs" {
  name = "agent-as-principal RS"
  identifier = "aap.rs"

  subject_type_authorization {
    client {
      policy = "require_client_grant"
    }
  }
}

output "agent-associated-m2m-client-id" {
  value = auth0_client.agent-associated-m2m.client_id
}

resource "auth0_client_grant" "aap-m2m-cg" {
  audience = auth0_resource_server.agent-associated-rs.identifier
  client_id = auth0_client.agent-associated-m2m.client_id
  subject_type = "client"
  allow_all_scopes = true
}