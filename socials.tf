## LinkedIn social
# VISIT https://www.linkedin.com/developers/apps/226261749/auth
resource "auth0_connection" "linkedin" {
  name     = "linkedin"
  strategy = "linkedin"

  options {
    client_id                = var.linkedin_client_id
    client_secret            = var.linkedin_client_secret
    strategy_version         = 3
    scopes                   = ["email", "profile"]
    set_user_root_attributes = "on_each_login"
  }
}

