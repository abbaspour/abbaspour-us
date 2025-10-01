# Native application client
# https://oktawiki.atlassian.net/wiki/spaces/SES/pages/3394078477/Multi-Resource+Refresh+Tokens+MRRT+Feature+Overview+Quickstart+Guide
resource "auth0_client" "mrrt-test-1" {
  name                       = "MRRT SPA"
  description                = "MRRT Test SPA"
  app_type                   = "native"
  is_first_party             = true
  oidc_conformant            = true
  cross_origin_auth          = false


  callbacks = [
    "https://jwt.io"
  ]
  allowed_logout_urls = []
  web_origins = []

  grant_types = [
    "implicit",
    "password",
    "http://auth0.com/oauth/grant-type/password-realm",
    "authorization_code",
    "refresh_token"
  ]

  refresh_token {
    expiration_type = "expiring"
    rotation_type   = "rotating"
    policies {
      audience = "cool.api"
      scope = ["read:data"]
    }
    policies {
      audience = "my.api"
      scope = ["enroll"]
    }
  }
}

resource "auth0_connection_client" "UPA-for-mrrt-client" {
  client_id     = auth0_client.mrrt-test-1.client_id
  connection_id = auth0_connection.Username-Password-Authentication.id
}

output "mrrt-client-id" {
  value = auth0_client.mrrt-test-1.client_id
}

