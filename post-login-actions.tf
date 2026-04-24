resource "auth0_action_module" "logger" {
  name = "logger"
  code = file("${path.module}/actions/log-module.js")
  publish = true
}

data "auth0_action_module_versions" "logger_module_versions" {
  module_id = auth0_action_module.logger.id
}

resource "auth0_action" "dump-context" {
  name    = "Log event object"
  runtime = "node22"
  deploy  = true
  code = file("${path.module}/actions/post-login-dump-context.js")

  modules {
    module_id         = auth0_action_module.logger.id
    module_version_id = data.auth0_action_module_versions.logger_module_versions.versions[0].id
  }

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }
}

resource "auth0_trigger_actions" "post-login" {
  trigger = "post-login"

  actions {
    id           = auth0_action.dump-context.id
    display_name = auth0_action.dump-context.name
  }

  actions {
    id           = auth0_action.mfa-auto-enroll-pn.id
    display_name = auth0_action.mfa-auto-enroll-pn.name
  }
}


