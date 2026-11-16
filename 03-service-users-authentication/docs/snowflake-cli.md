# Snowflake CLI — Service Connection

## Tested connection profile

```toml
[connections.devops_ci]
account = "AHFVPDM-HH07456"
user = "SNOWFLAKE_CI_SVC"
authenticator = "SNOWFLAKE_JWT"
private_key_file = "/Users/<local-user>/snowflake-keys/rsa_key.p8"
role = "DEVOPS_DEPLOY_ROLE"
warehouse = "SNOWFLAKE_LEARNING_WH"
database = "DEVOPS_LAB_DB"
schema = "RAW"
```

Save as `~/.snowflake/config.toml` and run `chmod 600 ~/.snowflake/config.toml`. The organisation-account identifier `AHFVPDM-HH07456` was the working account identifier in this lab.

## Secure interactive passphrase prompt (Zsh)

```zsh
read -s "PRIVATE_KEY_PASSPHRASE?Enter RSA private-key passphrase: "
echo
export PRIVATE_KEY_PASSPHRASE
```

After CLI operations:

```bash
unset PRIVATE_KEY_PASSPHRASE
```

Do not store the passphrase in plaintext in the config file or source control.

## Validate connection and session

```bash
snow connection test -c devops_ci
snow sql -c devops_ci -q "SELECT CURRENT_USER(), CURRENT_ROLE(), CURRENT_DATABASE(), CURRENT_SCHEMA(), CURRENT_WAREHOUSE();"
```

Expected session: `SNOWFLAKE_CI_SVC`, `DEVOPS_DEPLOY_ROLE`, `DEVOPS_LAB_DB`, `RAW`, `SNOWFLAKE_LEARNING_WH`.

## Deployment smoke test

```bash
snow sql -c devops_ci -q "CREATE TABLE IF NOT EXISTS CI_DEPLOYMENT_TEST (ID NUMBER, MESSAGE VARCHAR(200), CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP());"
snow sql -c devops_ci -q "INSERT INTO CI_DEPLOYMENT_TEST (ID, MESSAGE) VALUES (1, 'Created through Snowflake CLI using RSA authentication');"
snow sql -c devops_ci -q "SELECT * FROM CI_DEPLOYMENT_TEST;"
```

Observed: table created, one row inserted, and the row returned. This insert is a learning test, not an idempotent production deployment pattern; rerunning it inserts another row unless duplicate handling is added.
