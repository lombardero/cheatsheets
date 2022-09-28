# Vault

Vault is an alternative to Kubernetes' built-in secret management mechanism, which stores secrets in the filesystem (not very secure)

Vault provides ways to:
- Identify
- Authorize
- Store / Retrieve secrets (API keys)
- Enables audit logging (knowing who logged in) through different vendors, such as Scalyr

Vault is very secure, as vault secrets are encrypted at rest (when stored) and in transit (when sent via the internet). 

Default Vault secret engine is a key-value store called kv


