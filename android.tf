/*
resource "auth0_client" "android" {
  name = "Android Native"
  description                = "A sample Android native app"
  app_type                   = "native"
  is_first_party             = true
  oidc_conformant            = true

  callbacks = [
    "demo://id.abbaspour.net/android/net.abbaspour.nativetowebsample/callback",
  ]

  allowed_logout_urls = [
  ]

  web_origins = [
  ]

  grant_types = [
    "authorization_code",
    "refresh_token"
  ]
}

# outputs
output "android" {
  value = auth0_client.android.client_id
}
*/