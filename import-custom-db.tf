resource "auth0_connection" "custom-migrating" {
  name     = "custom-migrating"
  strategy = "auth0"

  options {
    custom_scripts = {
      login = file("${path.module}/custom-db/login.js")
      get_user = file("${path.module}/custom-db/get-user.js")
      //create = file("${path.module}/custom-db/create.js")
    }

    authentication_methods {
      password {
        enabled = true
      }
    }

    requires_username              = false
    disable_signup                 = false
    import_mode                    = true
    enabled_database_customization = true
    enable_script_context          = false
    brute_force_protection         = false
  }

  realms = ["custom-migrating"]

}


resource "auth0_connection_clients" "migrating-clients" {
  connection_id = auth0_connection.custom-migrating.id
  enabled_clients = [
    "VJIEWAptlFWokl2pRC2ptswic1jCGoEC"
  ]
}