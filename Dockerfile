FROM quay.io/astronomer/ap-airflow:2.0.0-3-buster-onbuild

## SELECT ONE OF THE FOLLOWING

## Vault Local
## https://airflow.apache.org/docs/apache-airflow-providers-hashicorp/stable/secrets-backends/hashicorp-vault.html
ENV AIRFLOW__SECRETS__BACKEND="airflow.providers.hashicorp.secrets.vault.VaultBackend"
ENV AIRFLOW__SECRETS__BACKEND_KWARGS='{"connections_path": "airflow/connections", "variables_path": null, "config_path": null, "url": "https://vault.vault.svc.cluster.local:8200", "token":"$VAULT_TOKEN"}'

## Vault Production
# ENV AIRFLOW__SECRETS__BACKEND="airflow.providers.hashicorp.secrets.vault.VaultBackend"
# ENV AIRFLOW__SECRETS__BACKEND_KWARGS='{"connections_path": "airflow/connections", "variables_path": null, "config_path": null, "url": "https://vault.vault.svc.cluster.local:8200", "auth_type": "approle", "role_id":"$VAULT_ROLE_ID", "secret_id":"$VAULT_SECRET_ID"}'


## Azure Key Vault Example
## https://airflow.apache.org/docs/apache-airflow-providers-microsoft-azure/stable/secrets-backends/azure-key-vault.html
# ENV AIRFLOW__SECRETS__BACKEND="airflow.providers.microsoft.azure.secrets.azure_key_vault.AzureKeyVaultBackend"
# ENV AIRFLOW__SECRETS__BACKEND_KWARGS='{"connections_prefix": "airflow-connections", "variables_prefix": null, "vault_url": "https://example-akv-resource-name.vault.azure.net/"}'