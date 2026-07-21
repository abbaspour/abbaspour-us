# https://mcplay-gamma.vercel.app/amin
resource "auth0_resource_server" "mcplay-gamma" {
  identifier = "https://mcplay-gamma.vercel.app/amin/mcp"
  name = "mcplay-gamma"
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