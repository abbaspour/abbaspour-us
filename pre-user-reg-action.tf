resource "auth0_action" "pre-user-registration" {
  name    = "set-user-id"
  runtime = "node22"
  deploy  = true
  code    = file("${path.module}/actions/pre-user-registration.js")

  supported_triggers {
    id      = "pre-user-registration"
    version = "v2"
  }
}

resource "auth0_trigger_actions" "pre-user-registration" {
  trigger = "pre-user-registration"

  actions {
    id           = auth0_action.pre-user-registration.id
    display_name = auth0_action.pre-user-registration.name
  }
}