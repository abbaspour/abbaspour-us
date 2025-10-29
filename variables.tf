variable "auth0_domain" {
  description = "Auth0 domain"
  type        = string
}

variable "auth0_tf_client_id" {
  description = "Auth0 Terraform client ID"
  type        = string
}

variable "auth0_tf_client_secret" {
  description = "Auth0 Terraform client secret"
  type        = string
  sensitive   = true
}

## LinkedIn Social
variable "linkedin_client_id" {
  type = string
  description = "LinkedIn social connection client_id"
}

variable "linkedin_client_secret" {
  type = string
  description = "LinkedIn social connection client_secret"
}
