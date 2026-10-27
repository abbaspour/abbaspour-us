# https://mcplay-gamma.vercel.app/amin
resource "auth0_resource_server" "mcplay-gamma" {
  identifier           = "https://mcplay-gamma.vercel.app/amin/mcp"
  name                 = "mcplay-gamma"
  allow_offline_access = true

  subject_type_authorization {

    user {
      policy = "allow_all"
    }

    client {
      policy = "require_client_grant"
    }
  }


}

resource "auth0_resource_server_scopes" "mcplay-gamma-scopes" {
  resource_server_identifier = auth0_resource_server.mcplay-gamma.identifier

  scopes {
    name = "mcp:tools"
    description = "Access to MCP tools"
  }
}

resource "auth0_resource_server" "home-automation" {
  identifier = "https://authenticated-mcp-worker.abbaspour.workers.dev/"
  name       = "home automation mcp api"
}

resource "auth0_client_grant" "my_client_grant" {
  default_for      = "third_party_clients"
  audience         = auth0_resource_server.home-automation.identifier
  subject_type     = "user"
  allow_all_scopes = true
}

resource "auth0_resource_server_scopes" "home-automation" {

  resource_server_identifier = auth0_resource_server.home-automation.identifier

  scopes {
    name        = "tool:greet"
    description = "tool:greet"
  }

  scopes {
    name        = "tool:whoami"
    description = "tool:whoami"
  }
}

resource "auth0_client_cimd" "home-automation" {
  external_client_id = "https://authenticated-mcp-worker.abbaspour.workers.dev/client-metadata.json"

}
