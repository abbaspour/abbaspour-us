resource "auth0_client" "samltool" {
  name = "samltool-io"
  description = "samltool.io"
  app_type    = "regular_web"

  callbacks                           = ["https://samltool.io"]
  addons {
    samlp {
      # The Service Provider (SP) Assertion Consumer Service (ACS) URL
      audience = "https://samltool.io"
      issuer   = "https://samltool.io"

      # Optional: Control token lifetimes and formats
      lifetime_in_seconds = 3600
      digest_algorithm    = "sha256"
      signature_algorithm = "rsa-sha256"

      # Optional: Map your Auth0 user properties to custom SAML attributes
      /*
      mappings = {
        "email"       = "http://xmlsoap.org"
        "name"        = "http://xmlsoap.org"
        "given_name"  = "http://xmlsoap.org"
        "family_name" = "http://xmlsoap.org"
      }
      */
    }
  }
}

output "samltool_client_id" {
  value = auth0_client.samltool.client_id
}

resource "auth0_client" "oidc-bash" {
  name = "oidc-bash"
  description = "oidc-bash"
  app_type    = "regular_web"

  callbacks                           = ["http://local.abbaspour.net:1980/cgi-bin/cb.sh"]
  addons {
    samlp {
      audience = "http://local.abbaspour.net:1980/cgi-bin/cb.sh"
      issuer   = "http://local.abbaspour.net:1980/cgi-bin/cb.sh"
    }
  }
}

output "oidc_bash_client_id" {
  value = auth0_client.oidc-bash.client_id
}