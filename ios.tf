resource "auth0_client" "ios-auth0-airlines" {
  name = "Auth0 Airlines"
  description                = "A sample iOS native app"
  app_type                   = "native"
  is_first_party             = true
  oidc_conformant            = true

  callbacks = [
    "net.abbaspour.airways.demo://abbaspour.auth0.com/ios/net.abbaspour.airways.demo/callback",
  ]

  allowed_logout_urls = [
    "net.abbaspour.airways.demo://abbaspour.auth0.com/ios/net.abbaspour.airways.demo/callback",
  ]

  web_origins = [
  ]

  grant_types = [
    "authorization_code",
    "refresh_token"
  ]

  session_transfer {
    can_create_session_transfer_token = true
    enforce_device_binding            = "none"
    allow_refresh_token               = true
  }

  /*
  mobile {
    ios {
      team_id               = "AQ7YMXWSV2"                 # identityfolk@gmail.com
      app_bundle_identifier = "net.abbaspour.airways.demo"
    }
  }
  */
}

# outputs
output "ios-auth0-airlines-client_id" {
  value = auth0_client.ios-auth0-airlines.client_id
}