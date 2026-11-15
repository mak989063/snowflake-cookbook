# Least-Privilege Design for a Snowflake Deployment Role

## Objective

Create a role for a narrowly scoped deployment task rather than using `ACCOUNTADMIN` for routine deployment.

## Lab role

`DEVOPS_DEPLOY_ROLE`

## Granted privileges

| Privilege | Object | Why it is needed in this lab |
|---|---|---|
| `USAGE` | `SNOWFLAKE_LEARNING_WH` | Use the selected warehouse |
| `USAGE` | `DEVOPS_LAB_DB` | Access the database |
| `USAGE` | `DEVOPS_LAB_DB.RAW` | Access the target schema |
| `CREATE TABLE` | `DEVOPS_LAB_DB.RAW` | Create a table in the target schema |
| `CREATE VIEW` | `DEVOPS_LAB_DB.RAW` | Create a view in the target schema |

The role was assigned directly to the learning user. It was not granted to `SYSADMIN` in this exercise.

## What was deliberately not granted?

The role was not granted `CREATE SCHEMA` on `DEVOPS_LAB_DB`. It therefore could not create a new schema in that database.

This is intentional. The deployment role should have only the permissions required for its defined deployment scope.

## Why disable secondary roles during a test?

A session may have privileges available through secondary roles. For a controlled boundary test, run:

```sql
USE SECONDARY ROLES NONE;
```

Then test using the intended primary role. This helps establish that the tested permissions come from the primary role's grants rather than additional active roles.

## Production design considerations

A real enterprise design may separate:
- Human interactive roles.
- CI/CD service users and their roles.
- Database/schema ownership roles.
- Read-only operational and monitoring roles.
- Security administration roles.

The exact design depends on the organisation's governance model, deployment process, and Snowflake configuration. This lab is a learning example, not a universal production role template.
