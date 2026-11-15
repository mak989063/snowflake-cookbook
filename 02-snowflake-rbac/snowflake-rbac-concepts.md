# Snowflake RBAC Concepts

## 1. The three basic building blocks

### User

A user is an identity that authenticates to Snowflake. A person normally uses an individual user account. Automation should use a dedicated service identity rather than a person's interactive login.

### Role

A role is a named collection of privileges. Users activate roles to work with the objects and operations those roles are authorised to use.

### Privilege

A privilege is permission to perform an operation on a securable object or resource. Examples include `USAGE`, `CREATE TABLE`, `CREATE VIEW`, `SELECT`, and `INSERT`.

A useful mental model:

`User → Role → Privileges → Objects / operations`

## 2. Common system-defined roles

| Role | High-level purpose |
|---|---|
| `ACCOUNTADMIN` | Highest-level account administration; use sparingly |
| `SECURITYADMIN` | Security administration and grant management responsibilities |
| `USERADMIN` | User and role administration |
| `SYSADMIN` | Creates and manages warehouses, databases and other objects |
| `PUBLIC` | Automatically available role for all users |
| `ORGADMIN` | Organization-level administration where applicable |

Exact responsibilities and available capabilities should be checked against the account's current Snowflake documentation and configuration. Avoid treating every built-in role as interchangeable.

## 3. Role inheritance

Snowflake role grants have a direction that matters.

```sql
GRANT ROLE CHILD_ROLE TO ROLE PARENT_ROLE;
```

This means the parent role inherits the privileges of the child role. It does not mean the child inherits the parent.

Role hierarchies should be designed deliberately. Avoid granting a narrowly scoped deployment role to a broad administrative role unless there is a clear reason.

## 4. The PUBLIC role

`PUBLIC` is automatically available to every user. Users can therefore receive privileges through `PUBLIC` in addition to their primary role, depending on secondary-role settings.

Inspect grants rather than assuming what `PUBLIC` provides:

```sql
SHOW GRANTS TO ROLE PUBLIC;
```

The output can be extensive, particularly when sample databases and Snowflake-provided features are present. Do not remove or alter managed grants as part of a learning exercise.

## 5. Inspecting grants

```sql
SHOW ROLES;

SHOW GRANTS TO ROLE DEVOPS_DEPLOY_ROLE;

SHOW GRANTS TO USER MAK989063;
```

To inspect which roles have been granted a role:

```sql
SHOW GRANTS OF ROLE DEVOPS_DEPLOY_ROLE;
```

`SHOW GRANTS TO ROLE` answers which privileges/roles are granted to the specified role. `SHOW GRANTS OF ROLE` shows where that role has been granted.
