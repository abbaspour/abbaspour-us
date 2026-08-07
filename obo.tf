resource "auth0_resource_server" "obo" {
  identifier = "https://test-obo-api.com"
  name = "My OBO Test API"

  skip_consent_for_verifiable_first_party_clients = true
}

resource "auth0_resource_server_scopes" "obo" {
  resource_server_identifier = auth0_resource_server.obo.identifier

  scopes {
    name = "read:item"
  }
}

output "obo-client-id" {
  value = auth0_resource_server.obo.client_id
}

resource "auth0_client" "obo" {
  name = "My OBO Test API client (tf)"
  app_type = "resource_server"
  resource_server_identifier = auth0_resource_server.obo.identifier

  token_exchange {
    allow_any_profile_of_type = ["on_behalf_of_token_exchange"]
  }
}

resource "auth0_client_grant" "obo" {
  audience = auth0_resource_server.obo.identifier
  client_id = auth0_client.obo.client_id
  subject_type = "user"
  scopes = [
    "read:item"
  ]
}

resource "auth0_resource_server" "downstream" {
  identifier = "urn:downstream:api"
  name = "My Downstream API"
  skip_consent_for_verifiable_first_party_clients = true
}

resource "auth0_resource_server_scopes" "downstream" {
  resource_server_identifier = auth0_resource_server.downstream.identifier

  scopes {
    name = "read:private"
  }
}