locals {
  cf_worker_url = "https://cf-hono-auth0.abbaspour.workers.dev"
  cf_worker2_url = "https://auth0-cf-ai-hono.abbaspour.workers.dev"
}

resource "auth0_client" "cf-hono-oidc-rwa" {
  name = "cf-hono-oidc-rwa"
  description                = "Hono OIDC for an RWA running in Cloudflare worker"
  app_type                   = "regular_web"
  is_first_party             = true
  oidc_conformant            = true

  callbacks = [
    "${local.cf_worker_url}/callback",
    "${local.cf_worker2_url}/callback"
  ]

  allowed_logout_urls = [
    local.cf_worker_url,
    local.cf_worker2_url
  ]
  web_origins = [
    local.cf_worker_url,
    local.cf_worker2_url
  ]

  grant_types = [
    "authorization_code",
    "refresh_token",
    "implicit"
  ]
}

# outputs
output "hono-rwa-client-id" {
  value = auth0_client.cf-hono-oidc-rwa.client_id
}