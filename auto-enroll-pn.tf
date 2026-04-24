resource "auth0_action" "mfa-auto-enroll-pn" {
  name    = "mfa-auto-enroll-pn"
  runtime = "node22"
  deploy  = true
  code = file("${path.module}/actions/mfa-auto-enroll-pn.js")

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }

  secrets {
    name  = "TARGET_CLIENT_ID"
    value = auth0_client.auto-enroll.client_id
  }
}


# Native application client
resource "auth0_client" "auto-enroll" {
  name                       = "Auto Enroll PN"
  description                = "Auto Enroll Push Notification"
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
    "password",
    "http://auth0.com/oauth/grant-type/password-realm",
    "http://auth0.com/oauth/grant-type/mfa-oob",
    "http://auth0.com/oauth/grant-type/mfa-otp",
    "http://auth0.com/oauth/grant-type/mfa-recovery-code",
  ]
}

output "auto-enroll-client-id" {
  value = auth0_client.auto-enroll.client_id
}

