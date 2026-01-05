# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains Terraform configurations for managing an Auth0 tenant. It defines Auth0 applications (clients), connections, resource servers, and other identity platform resources using Infrastructure as Code (IaC).

## Common Commands

### Terraform Workflow
```bash
# Initialize Terraform (run after cloning or updating providers)
make init
# or: terraform init -input=false -upgrade

# Plan changes (generates abbaspour.plan file)
make plan
# or: TF_LOG=TRACE terraform plan -out abbaspour.plan  # with debug logging

# Apply planned changes
make apply
# or: terraform apply -auto-approve abbaspour.plan

# View current state
make show
# or: terraform show

# View outputs
make output
# or: terraform output

# Refresh state from Auth0
make refresh
# or: terraform refresh

# Validate configuration
make validate
# or: terraform validate

# Lint Terraform files
make lint
# or: tflint

# Generate dependency graph
make graph
# Generates graph.svg from Terraform resource dependencies
```

## Architecture

### Configuration Structure

The Terraform configuration is split across multiple feature-specific files:

- **provider.tf**: Auth0 provider configuration using required variables
- **variables.tf**: Variable definitions for Auth0 domain, credentials, and external service credentials (e.g., LinkedIn)
- **tenant.tf**: Core tenant configuration including Universal Login settings, locales, test users, and the primary Username-Password-Authentication connection
- **session-transfer.tf**: Native and SPA applications configured for Auth0 session transfer functionality
- **mrrt.tf**: Multi-Resource Refresh Token (MRRT) test client configuration
- **dpop.tf**: DPoP (Demonstrating Proof-of-Possession) resource server and regular web application
- **singpass.tf**: Singapore SingPass OIDC connection configurations with private_key_jwt authentication
- **socials.tf**: Social connection definitions (e.g., LinkedIn)
- **hono.tf**: Cloudflare Worker applications using Hono framework
- **ios.tf**: iOS native application (Auth0 Airlines sample)
- **android.tf**: Android native application (currently commented out)
- **rtl.tf**: Right-to-left (RTL) language testing SPA client (Dubai SPA)
- **saml-org.tf**: SAML organization configuration (currently empty, new file)

### Key Patterns

**Client Configuration**: Most client definitions follow this pattern:
- Define `auth0_client` resource with app_type (native, spa, regular_web)
- Optionally define `auth0_client_credentials` for authentication methods
- Export client_id as output for reference
- Special features enabled via dedicated blocks (session_transfer, refresh_token)

**Connection Management**:
- The main Username-Password-Authentication connection is shared across many clients
- Connection associations are managed via `auth0_connection_clients` (bulk) or `auth0_connection_client` (individual)
- Social and enterprise connections are defined separately with their own resources

**Resource Servers**:
- Defined with `auth0_resource_server` for APIs
- Scopes managed separately via `auth0_resource_server_scopes`

**Outputs**: Each feature file typically exports relevant client IDs and secrets for downstream use

### Required Variables

You must provide these via terraform.auto.tfvars (gitignored):
- `auth0_domain`: Your Auth0 tenant domain
- `auth0_tf_client_id`: Client ID for Terraform Auth0 provider
- `auth0_tf_client_secret`: Client secret for Terraform Auth0 provider
- `linkedin_client_id`: LinkedIn social connection credentials
- `linkedin_client_secret`: LinkedIn social connection credentials

### Special Features

**Session Transfer**: Configured in session-transfer.tf with device binding options and token creation capabilities

**MRRT (Multi-Resource Refresh Tokens)**: Defined per-audience policies for refresh token usage across multiple APIs

**DPoP (Demonstrating Proof-of-Possession)**: Token binding for enhanced OAuth 2.0 security

**Private Key JWT**: Used for enterprise OIDC connections like SingPass (ES256 and RS256 algorithms)

## Important Notes

- The plan file (abbaspour.plan) is gitignored and should not be committed
- terraform.auto.tfvars contains sensitive credentials and is gitignored
- State files (terraform.tfstate*) are gitignored and should be managed via remote backend
- The events/ directory is gitignored (contains Auth0 Action/Rule code)
- Many clients have hardcoded client IDs in tenant.tf for connection associations
- use Terraform MCP to generate up-to-date code snippets
