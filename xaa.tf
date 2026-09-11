resource "auth0_resource_server" "todo0-api" {
  identifier = "urn:todo0:api"
  name = "Todo0 SaaS API"

  token_dialect = "rfc9068_profile"
}

resource "auth0_resource_server_scopes" "xaa-api-scopes" {
  resource_server_identifier = auth0_resource_server.todo0-api.identifier

  scopes {
    name = "s1"
  }
}


resource "auth0_client" "agent0" {
  name = "Agent0"
  description                = "Requesting App to test XAA"
  app_type                   = "regular_web"
  is_first_party             = true
  oidc_conformant            = true
  sso = true

  # noinspection HttpUrlsUsage
  callbacks = [
    "https://jwt.io",
    "http://localhost:1980/cgi-bin/cb.sh",
    "http://local.abbaspour.net:1980/cgi-bin/cb.sh",
  ]

  grant_types = [
    "authorization_code",
    "refresh_token",
    "implicit"
  ]

  identity_assertion_authorization_grant {
    active = true
  }
}

output "agent0-client_id" {
  value = auth0_client.agent0.client_id
}

resource "auth0_connection" "okta-xaa" {
  name     = "okta-xaa"
  strategy = "okta"
  show_as_button = true

  options {
    client_id                = var.okta-xaa-oidc-client-id
    client_secret            = var.okta-xaa-oidc-client-secret
    domain                   = "amin.oktapreview.com"
    //domain_aliases           = []
    issuer                   = "https://amin.oktapreview.com"
    jwks_uri                 = "https://amin.oktapreview.com/oauth2/v1/keys"
    token_endpoint           = "https://amin.oktapreview.com/oauth2/v1/token"
    userinfo_endpoint        = "https://amin.oktapreview.com/oauth2/v1/userinfo"
    authorization_endpoint   = "https://amin.oktapreview.com/oauth2/v1/authorize"
    scopes                   = ["openid", "profile", "email"]
    set_user_root_attributes = "on_each_login"
    #non_persistent_attrs     = ["ethnicity", "gender"]
    # upstream_params = jsonencode({
    #   "screen_name" : {
    #     "alias" : "login_hint"
    #   }
    # })

    connection_settings {
      pkce = "auto"
    }

    # attribute_map {
    #   mapping_mode   = "basic_profile"
    #   userinfo_scope = "openid email profile groups"
    #   attributes = jsonencode({
    #     "name" : "$${context.tokenset.name}",
    #     "email" : "$${context.tokenset.email}",
    #     "email_verified" : "$${context.tokenset.email_verified}",
    #     "nickname" : "$${context.tokenset.nickname}",
    #     "picture" : "$${context.tokenset.picture}",
    #     "given_name" : "$${context.tokenset.given_name}",
    #     "family_name" : "$${context.tokenset.family_name}"
    #   })
    # }
  }

  cross_app_access_resource_app {
    status = "enabled"
  }

}

resource "auth0_connection_clients" "xaa-okta-xaa-clients" {
   connection_id = auth0_connection.okta-xaa.id
   enabled_clients = [
     auth0_client.agent0.client_id
   ]
}

resource "auth0_connection" "okta-integrator" {
  name     = "okta-integrator"
  strategy = "okta"
  show_as_button = true

  options {
    client_id                = var.okta-integrator-oidc-client-id # todo0
    client_secret            = var.okta-integrator-oidc-client-secret
    domain                   = "integrator-4598441.okta.com"
    issuer                   = "https://integrator-4598441.okta.com"
    jwks_uri                 = "https://integrator-4598441.okta.com/oauth2/v1/keys"
    token_endpoint           = "https://integrator-4598441.okta.com/oauth2/v1/token"
    userinfo_endpoint        = "https://integrator-4598441.okta.com/oauth2/v1/userinfo"
    authorization_endpoint   = "https://integrator-4598441.okta.com/oauth2/v1/authorize"
    scopes                   = ["openid", "profile", "email"]
    set_user_root_attributes = "on_each_login"

    connection_settings {
      pkce = "auto"
    }
  }

  cross_app_access_resource_app {
    status = "enabled"
  }
}

resource "auth0_connection_clients" "xaa-okta-integrator-clients" {
  connection_id = auth0_connection.okta-integrator.id
  enabled_clients = [
    auth0_client.agent0.client_id
  ]
}
