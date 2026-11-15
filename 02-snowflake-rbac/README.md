# Module 02 — Snowflake RBAC: Users, Roles, and Privileges

**Learning track:** Senior DevOps / Platform Engineer  
**Status:** Hands-on lab completed  
**Lab database:** `DEVOPS_LAB_DB`  
**Lab schema:** `RAW`  
**Custom role:** `DEVOPS_DEPLOY_ROLE`

## Learning objectives

- Understand Snowflake users, roles, and privileges.
- Inspect built-in roles and role grants.
- Understand role inheritance and the `PUBLIC` role.
- Create a dedicated deployment role.
- Grant only the privileges needed for a defined deployment task.
- Activate the role and verify the session context.
- Test both allowed and denied operations.

## Module contents

| File | Purpose |
|---|---|
| `snowflake-rbac-concepts.md` | Users, roles, privileges, built-in roles and inheritance |
| `least-privilege-design.md` | Deployment-role design and security considerations |
| `sql/01-inspect-roles.sql` | Inspect roles and grants |
| `sql/02-create-deployment-role.sql` | Create the dedicated deployment role |
| `sql/03-grant-deployment-privileges.sql` | Grant warehouse, database and schema privileges |
| `sql/04-activate-and-verify-role.sql` | Activate the role and verify session context |
| `sql/05-test-deployment-permissions.sql` | Test table creation, DML and denied schema creation |

## Lab implementation

The following role was created:

`DEVOPS_DEPLOY_ROLE`

It was granted:

- `USAGE` on warehouse `SNOWFLAKE_LEARNING_WH`
- `USAGE` on database `DEVOPS_LAB_DB`
- `USAGE` on schema `DEVOPS_LAB_DB.RAW`
- `CREATE TABLE` on schema `DEVOPS_LAB_DB.RAW`
- `CREATE VIEW` on schema `DEVOPS_LAB_DB.RAW`

The role was assigned to user `MAK989063`. The username is included here as a lab-specific example; replace it with your own user if reproducing the lab in another account.

The custom role was intentionally **not** granted to `SYSADMIN` in this exercise. It is assigned directly to the lab user so its permissions can be tested independently.

## Validation results

| Test | Expected / observed result |
|---|---|
| Activate `DEVOPS_DEPLOY_ROLE` | Successful |
| Select `SNOWFLAKE_LEARNING_WH` | Successful |
| Select `DEVOPS_LAB_DB.RAW` | Successful |
| Create `RBAC_TEST` table | Confirmed successful |
| Insert and select a test row | Confirmed successful |
| Create schema `DEVOPS_LAB_DB.RBAC_BOUNDARY_TEST` | Denied with insufficient privileges |

The denied schema-creation test is important: the role has `USAGE` on the database but does not have `CREATE SCHEMA` on that database.

## Important Snowflake RBAC concepts

- A user is an identity that can authenticate to Snowflake.
- A role is a collection of privileges.
- Privileges are granted on securable objects or account-level resources.
- `USAGE` on a database does not grant `CREATE SCHEMA`.
- A role that creates an object generally owns that object and can perform permitted operations on its own object.
- Roles can inherit privileges from roles granted to them. `GRANT ROLE child_role TO ROLE parent_role` makes the parent role inherit the child role's privileges.
- `PUBLIC` is automatically available to users. Inspect its grants carefully; do not remove or alter Snowflake-managed grants as part of this lab.

## Running the lab

1. Start with an administrative role that is authorised to create roles and grant privileges.
2. Run the inspection script.
3. Create the custom role.
4. Grant the required privileges and assign the role to the intended user.
5. Switch to the custom role.
6. Run the positive permission tests.
7. Run the negative boundary test.
8. Save the actual outputs in your own lab notes, but do not commit credentials or sensitive account details.

## Security notes

- Do not use `ACCOUNTADMIN` for routine application deployment.
- Do not grant broad privileges simply to make a test pass.
- Do not grant the deployment role to a broader role unless the inheritance is intentional and reviewed.
- Use `USE SECONDARY ROLES NONE` during privilege-boundary testing so secondary roles do not supply additional privileges.
- Never commit passwords, private keys, tokens, or client credentials.
- Use placeholders for account identifiers and usernames in public examples.

## Completion

This module's hands-on RBAC configuration and permission-boundary test were completed in the learning account.

**Next module:** Snowflake service users and authentication.
