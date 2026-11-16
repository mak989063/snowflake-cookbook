# Module 04 — Snowflake CLI for DevOps

## 1. Overview

This module demonstrates how to use Snowflake CLI as a deployment tool in a DevOps workflow.

The objective is to move from manually executing SQL statements in Snowsight to executing version-controlled SQL scripts through a command-line interface.

The module introduces:

- Snowflake CLI installation and connection configuration
- SQL file execution
- Multiple SQL file execution
- Idempotent SQL deployments using MERGE
- SQL template variables
- Bash-based deployment automation
- Environment validation
- Deployment logging
- Exit-code handling and failure propagation

**Perspective:** Senior DevOps / Platform Engineering.

## 2. Architecture

```text
Developer
    |
    v
Git Repository
    |
    v
deploy.sh
    |
    +---- Validate environment
    |
    +---- Validate Snowflake connection
    |
    +---- Execute SQL deployment scripts
    |
    +---- Pass environment variable
    |
    +---- Capture execution logs
    |
    v
Snowflake CLI
    |
    v
Snowflake Account
    |
    +---- DEVOPS_LAB_DB
              |
              +---- RAW
                     |
                     +---- CLI_DEPLOYMENT_DEMO
                     |
                     +---- CLI_DEPLOYMENT_AUDIT
```

## 3. Prerequisites

- Snowflake account
- Snowflake CLI
- Configured CLI connection
- Service user with appropriate privileges
- RSA key-pair authentication
- Bash shell
- Git

### Snowflake connection

Connection profile:

`devops_ci`

Service user:

`SNOWFLAKE_CI_SVC`

Deployment role:

`DEVOPS_DEPLOY_ROLE`

Database:

`DEVOPS_LAB_DB`

Schema:

`RAW`

Warehouse:

`SNOWFLAKE_LEARNING_WH`

Authentication:

`SNOWFLAKE_JWT`

## 4. Repository structure

```text
04-snowflake-cli/
|
+-- README.md
|
+-- deploy.sh
|
+-- deploy-basic.sh
|
+-- deploy_failure_test.sh
|
+-- sql/
|   |
|   +-- 01_create_deployment_table.sql
|   +-- 02_create_deployment_audit.sql
|   +-- 03_merge_deployment_audit.sql
|   +-- 04_failure_test.sql
|
+-- docs/
|
+-- logs/
```

Runtime deployment logs are generated under `logs/`.

## 5. Snowflake CLI commands

### Test connection

```bash
snow connection test -c devops_ci
```

### Execute a SQL file

```bash
snow sql -c devops_ci \
-f 04-snowflake-cli/sql/01_create_deployment_table.sql
```

### Execute multiple SQL files

```bash
snow sql -c devops_ci \
-f 04-snowflake-cli/sql/01_create_deployment_table.sql \
-f 04-snowflake-cli/sql/02_create_deployment_audit.sql \
-f 04-snowflake-cli/sql/03_merge_deployment_audit.sql
```

### Execute SQL with a template variable

```bash
snow sql -c devops_ci \
-D "deploy_env=DEV" \
-f 04-snowflake-cli/sql/03_merge_deployment_audit.sql
```

The SQL template uses:

```sql
'<% deploy_env %>' AS ENVIRONMENT
```

Snowflake CLI renders the variable before submitting the SQL statement.

For example:

```sql
'DEV' AS ENVIRONMENT
```

## 6. SQL deployment design

### Deployment demo table

`CLI_DEPLOYMENT_DEMO` stores deployment-related information.

### Deployment audit table

`CLI_DEPLOYMENT_AUDIT` records deployment activity.

Important columns:

| Column | Purpose |
|---|---|
| DEPLOYMENT_KEY | Identifies the deployment record |
| APPLICATION_NAME | Application being deployed |
| ENVIRONMENT | Target environment |
| DEPLOYED_BY | Snowflake execution user |
| DEPLOYED_AT | Deployment timestamp |

### Idempotent deployment with MERGE

The MERGE statement checks whether the deployment key already exists.

- If the record exists, it updates deployment information.
- If the record does not exist, it inserts a new record.

This prevents duplicate records for the same deployment key.

## 7. Bash deployment automation

The `deploy.sh` script orchestrates the Snowflake deployment.

### Configuration

```bash
CONNECTION_NAME="devops_ci"
DEPLOY_ENV="${1:-}"
```

The deployment environment is supplied as a command-line argument.

### Environment validation

Currently, only DEV is enabled.

QA and PROD are intentionally blocked until separate target configurations are established.

### Logging

Each deployment generates a timestamped log:

```text
logs/deploy_DEV_YYYYMMDD_HHMMSS.log
```

The `log()` function records timestamped deployment messages.

### Failure handling

The script uses:

```bash
set -Eeuo pipefail
```

This enables strict Bash error handling.

The `run_step()` function executes commands and captures their output using `tee`.

An EXIT trap records the final deployment status.

If a deployment command fails, the script returns a non-zero exit code and stops subsequent deployment steps.

## 8. Execute deployment

From the repository root:

```bash
./04-snowflake-cli/deploy.sh DEV
```

Expected execution sequence:

1. Validate Snowflake connection.
2. Create deployment demo table.
3. Create deployment audit table.
4. Update deployment audit record using the DEV template variable.
5. Record final deployment status.

## 9. Verify deployment

Execute:

```bash
snow sql -c devops_ci \
-q "SELECT DEPLOYMENT_KEY, APPLICATION_NAME, ENVIRONMENT, DEPLOYED_BY FROM DEVOPS_LAB_DB.RAW.CLI_DEPLOYMENT_AUDIT;"
```

Expected result:

| DEPLOYMENT_KEY | APPLICATION_NAME | ENVIRONMENT | DEPLOYED_BY |
|---|---|---|---|
| MODULE04-EXERCISE-02 | SNOWFLAKE-COOKBOOK | DEV | SNOWFLAKE_CI_SVC |

## 10. Failure testing

An intentionally invalid SQL statement is maintained in:

`sql/04_failure_test.sql`

The failure-handling exercise demonstrates that a Snowflake SQL error returns a non-zero exit code.

The Bash deployment script should stop execution and record the failure in its log.

This helps validate failure propagation before introducing CI/CD automation.

## 11. Security considerations

- Use a dedicated Snowflake service user.
- Follow least-privilege RBAC.
- Use RSA key-pair authentication instead of embedding passwords.
- Never commit private keys or passphrases.
- Keep credentials outside the repository.
- Use separate Snowflake roles and connections for higher environments.
- Restrict PROD deployment permissions.

## 12. Current implementation status

| Capability | Status |
|---|---|
| Snowflake CLI connection | Completed |
| RSA authentication | Completed |
| SQL file execution | Completed |
| Multiple SQL file execution | Completed |
| Idempotent MERGE | Completed |
| SQL template variables | Completed |
| Bash deployment automation | Completed |
| Environment validation | Completed |
| Timestamped logging | Completed |
| Failure handling | Completed |
| DEV deployment | Verified |
| QA deployment | Not configured |
| PROD deployment | Not configured |
| GitHub Actions integration | Future module |

## 13. Key DevOps learning outcomes

After completing this module, you should understand how to:

1. Execute Snowflake SQL through a CLI.
2. Automate SQL deployments using Bash.
3. Pass deployment parameters into SQL templates.
4. Build repeatable and idempotent deployment operations.
5. Implement environment validation.
6. Capture deployment logs.
7. Handle command failures and exit codes.
8. Prepare Snowflake deployment scripts for CI/CD integration.

**Next module:** Integrating Snowflake CLI deployment into GitHub Actions reusable workflows.
