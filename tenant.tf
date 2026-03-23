resource "auth0_tenant" "tenant" {
  friendly_name = "My Company"

  # Allow organization names in Authentication API
  allow_organization_name_in_authentication_api = true

  flags {
    enable_client_connections = false
  }

  # Configure supported languages
  enabled_locales = [
    "en",
    "ar",
    "fa"
  ]
}

resource "auth0_prompt" "my_prompt" {
  universal_login_experience     = "new"
  identifier_first               = false
  webauthn_platform_first_factor = false
}

# terraform import auth0_connection.Username-Password-Authentication  con_UZwhZkh05jv7Gsg0
resource "auth0_connection" "Username-Password-Authentication" {
  name     = "Username-Password-Authentication"
  strategy = "auth0"
}

resource "auth0_connection_clients" "UPA-clients" {
  connection_id = auth0_connection.Username-Password-Authentication.id
  enabled_clients = [
    "05NYEth4OY9i57lIrnp9sQCyM1RjcwSJ",
    "0nO2Ub251AHCDy0KWLfBkqYVRyhay27S",
    "4yLCSBH2ww2v9W8OH1OPBmubNuVygLM0",
    "55GnDIKMb4s1ur0hibHrsNHGng4f8AUf",
    "6DnlVYv5PKg2Lj9mXzZ6iW4ymqO0YnvC",
    "6KS0YSEQwsvE9qRqtzonX8SEgJEYVzVH",
    "6P6Kgpi9xfkL94Ubd4d32QXHbhHuUhQT",
    "6awtx57XeNg8M5SAiUo1tViox6IeeJC7",
    "8PqaR0qYna2NBM41AQc2OXnGyjZ49Rmr",
    "At5IQTvLVMhalbVc0WZ07iKUyJtpXmkJ",
    "CP9VBSKZwQl13tsX8NH06w55Da3KWEto",
    "CPj0f9ReExLrfJwzqV3mw8UzAUyjZb1k",
    "DjUmggQQ7I0WMp64hCl7pUr4remtuhsX",
    "ED27SLierWMOj8SAsTY5H87fXsq1gRLO",
    "GPsbodIXephSGKE0eF4sPudC0xIlfuwJ",
    "HX00vu6n0QclPCeiHZhTbzC1njtz5LGC",
    "KkHXVNN6SDVmNsOJACwbni0t2t6dL2rE",
    "LPlbMBxjyAcKNF6EZdjD3Ifob1khp98Z",
    "LcI9FUSw6DcubRAOc7gTr0ASGmIalv4D",
    "MSKK22Qu1MM26DkdP59psEbAY8MVuhfm",
    "Mv2ZGaqECztHaIy3ShmxNF15VBXBkump",
    "NrNY70wcQgvIqafjqYjhhhLSt7plEg3M",
    "PWUCWvydb903veyd93AfRm5HQjfryJqC",
    "QjpX6x1Xial9wVZqqVMBS04PXvZzaWV9",
    "RSoWHmn1CjvErYnrxZlNVGXCxrzfNyHe",
    "VJIEWAptlFWokl2pRC2ptswic1jCGoEC",
    "XZxKS4tce5uFTbg1DqYVzR2qzgjO5PWx",
    "baLYKQQuJbqt8jvrlfBEFrILtP4jeXk1",
    "j9O52ys2lmIs7cYOPbxGgQNhMzY0mS7o",
    "ju7h6jf87VUZW8nkPl5084LNi9D9q9bH",
    "kXM5z5q4qdkB6vezdFi1aL2t4LNGGCZ1",
    "kpSiZowux5Ky7YX1IEK9UYTwjjR2Kf4g",
    "oXf1uIfg9Z7vbBzG3AimyIG4P0JoUTkB",
    "pOUgbo8yozEPlPKk2JcJYO1LxOPK7tLS",
    "pTWr4QrK4GMy093lDGd9a7DM7jtSyXIP",
    "tyS84I3IhppetSj5XXwbNeZgitjX0MrN",
    "uNrrt07AvtkEmYOfFKu3q25bI14v2ysu",
    "udBL9qJPxpoDFWBjiZmRopvXKAHz6LL5",
    "umMFHP0H0LyHXiavg38gYIqscp3dcaAw",
    "ww0P2cA0kqPAskTxvAhTDcNkKZZzZ4LV",
    "y962kxaVJFbfoC08ZABGZ8uXYpFUstPL",
    "yFGUSmuet2KJjPMv184Sbtw80YV6uPK7",
    "ujeEVt80TpFoTlYaAJ1Mp7wyl2W41v7i", # mcd cdsso - app - solution 02
    "E1FfCkuVWwEBt7fYnTBY39zk6r72h3Li", # mcd cdsso - spa - solution 02
    "7Fjto9rKAk4eGQpjHTzBhD8KRg7Lk2od", # n2w auth0 airline auziros-club
    auth0_client.session_transfer_spa.client_id,
    auth0_client.session_transfer_native.client_id,
    auth0_client.cf-hono-oidc-rwa.client_id,
    auth0_client.dubai-spa.client_id,
    auth0_client.dpop-rwa.client_id,
    auth0_client.ios-auth0-airlines.client_id,
    auth0_client.mrrt-test-1.client_id,
    auth0_client.shared_device_passkey_spa.client_id,
    var.auth0_tf_client_id
  ]

}

resource "auth0_user" "test-user" {
  connection_name      = auth0_connection.Username-Password-Authentication.name
  email                = "amin@atko.email"
  password             = "amin@atko.email"
  custom_domain_header = "id.abbaspour.net"

  app_metadata = jsonencode(
    {
      crm_customer_id = 1234
    }
  )
}