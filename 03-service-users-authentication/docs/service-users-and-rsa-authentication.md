# Service Users and RSA Key-Pair Authentication

A human user represents an individual. A service user represents a non-human workload such as a CI/CD runner. This lab uses `SNOWFLAKE_CI_SVC` as a dedicated deployment identity.

The service user is assigned `DEVOPS_DEPLOY_ROLE`, with limited permissions in `DEVOPS_LAB_DB.RAW`. Its defaults are:
- Role: `DEVOPS_DEPLOY_ROLE`
- Warehouse: `SNOWFLAKE_LEARNING_WH`
- Namespace: `DEVOPS_LAB_DB.RAW`
- Secondary roles: none

## Key generation (local trusted machine)

```bash
mkdir -p ~/snowflake-keys
cd ~/snowflake-keys
openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out rsa_key.p8
openssl pkey -in rsa_key.p8 -pubout -out rsa_key.pub
chmod 600 rsa_key.p8
chmod 644 rsa_key.pub
```

Export the public key in Base64 DER form:

```bash
openssl pkey -pubin -in rsa_key.pub -outform DER | base64 | tr -d '\n'
```

Register the public key value with the Snowflake user. Never paste or commit the private key or its passphrase.
