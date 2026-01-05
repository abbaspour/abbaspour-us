# Organization-enabled SPA client for SAML federation testing
resource "auth0_client" "jwt-io-org" {
  name            = "jwt-io-org"
  description     = "Organization-enabled SPA for SAML federation testing"
  app_type        = "spa"
  is_first_party  = true
  oidc_conformant = true

  callbacks = [
    "https://jwt.io"
  ]

  allowed_logout_urls = []
  web_origins         = []

  grant_types = [
    "authorization_code",
    "refresh_token",
    "implicit"
  ]

  organization_usage            = "require"
  organization_require_behavior = "no_prompt"
}

resource "auth0_client" "samltool-io" {
  name            = "samltool-io"
  description     = "SAML federation testing"
  app_type        = "spa"
  is_first_party  = true
  oidc_conformant = true

  callbacks = [
    "https://www.samltool.io",
  ]

  allowed_logout_urls = []
  web_origins         = []

  grant_types = [
    "authorization_code",
    "refresh_token",
    "implicit"
  ]

}

resource "auth0_connection_clients" "samltool-clients" {
  connection_id = auth0_connection.saml-idp-connection-org-enabled.id
  enabled_clients = [
    auth0_client.samltool-io.client_id
  ]
}

# Output the client ID
output "jwt-io-org-client_id" {
  value = auth0_client.jwt-io-org.client_id
}

# Create organization for SAML federation testing
resource "auth0_organization" "saml-fed-org-test-1" {
  name         = "saml-org-t1"
  display_name = "SAML Federation Org Test 1"
}

resource "auth0_organization" "saml-fed-org-test-2" {
  name         = "saml-org-t2"
  display_name = "SAML Federation Org Test 2"
}

# SAML connection with metadata URL
resource "auth0_connection" "saml-idp-connection" {
  name     = "saml-idp-connection"
  strategy = "samlp"

  options {
    metadata_url = "https://amin-saml-idp.au.auth0.com/samlp/metadata/3LzXgTyxA9EiLRZpMA2zfMnrDQp8x9cT"

    # Enable IdP-initiated SAML
    idp_initiated {
      enabled                = true
      client_id              = auth0_client.jwt-io-org.client_id
      client_protocol        = "oidc"
      client_authorize_query = "response_type=id_token"
    }
  }
}

# SAML connection with metadata URL
resource "auth0_connection" "saml-idp-connection-org-enabled" {
  name     = "saml-idp-connection-org"
  strategy = "samlp"

  options {
    metadata_url = "https://amin-saml-idp.au.auth0.com/samlp/metadata/Xtrt9XgI4ngUy3M2yBVnBOAtzqEMxn3H"

  #   # Enable IdP-initiated SAML
  #   idp_initiated {
  #     enabled                = true
  #     client_id              = auth0_client.jwt-io-org.client_id
  #     client_protocol        = "oidc"
  #     client_authorize_query = "response_type=id_token"
  #   }
  }
}


# Enable SAML connection for the organization with auto membership
resource "auth0_organization_connection" "saml-fed-org-connection-test-1" {
  organization_id = auth0_organization.saml-fed-org-test-1.id
  connection_id   = auth0_connection.saml-idp-connection.id

  assign_membership_on_login = true
  show_as_button             = true
}

resource "auth0_organization_connection" "saml-fed-org-connection-test-2" {
  organization_id = auth0_organization.saml-fed-org-test-2.id
  connection_id   = auth0_connection.saml-idp-connection.id

  assign_membership_on_login = true
  show_as_button             = true
}
