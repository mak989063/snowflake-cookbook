# Module 03 — Service Users & Authentication

Senior DevOps / Platform Engineering learning track.

## Objective
Create a dedicated Snowflake CI/CD service identity, assign a least-privilege role, configure RSA key-pair authentication, connect through Snowflake CLI, and validate SQL execution.

## Lab environment
- Account identifier: `AHFVPDM-HH07456` (Azure Central India)
- Service user: `SNOWFLAKE_CI_SVC`
- Role: `DEVOPS_DEPLOY_ROLE`
- Warehouse: `SNOWFLAKE_LEARNING_WH`
- Database/schema: `DEVOPS_LAB_DB.RAW`
- CLI: `3.33.0`

## Completed and verified
1. Created `SNOWFLAKE_CI_SVC` with `TYPE = SERVICE`.
2. Granted `DEVOPS_DEPLOY_ROLE` to the service user.
3. Configured default role, warehouse, namespace, and no secondary roles.
4. Generated an encrypted RSA private key and matching public key locally.
5. Registered the public key with the Snowflake user.
6. Configured CLI profile `devops_ci` with `SNOWFLAKE_JWT`.
7. Successfully tested authentication and executed SQL.
8. Verified session user, role, database, schema, and warehouse.
9. Created `CI_DEPLOYMENT_TEST`, inserted one row, and selected it successfully.

## Security
- Never commit private keys, passphrases, or local credentials.
- Keep the private key encrypted and set restrictive permissions (`chmod 600`).
- Register only the public key in Snowflake.
- Do not store the passphrase in plaintext in `config.toml`.
- Use an approved secrets manager for enterprise automation. Akeyless integration is deferred until authorised client access is available.
- Do not use `ACCOUNTADMIN` for routine deployment execution.

## Contents
- `docs/service-users-and-rsa-authentication.md`
- `docs/snowflake-cli.md`
- `sql/01_create_service_user.sql`
- `sql/02_assign_deployment_role.sql`
- `sql/03_configure_service_user_defaults.sql`
- `sql/04_register_public_key.sql`
- `sql/05_validate_service_session.sql`
- `sql/06_cli_deployment_test.sql`

SQL templates contain placeholders where needed. Never put private-key material or passphrases in these files.
