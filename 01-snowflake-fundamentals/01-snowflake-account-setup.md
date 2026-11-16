# Snowflake Account Setup Guide

## 1. Objective

This document explains how to create and configure a Snowflake account for hands-on learning from a DevOps and Platform Engineering perspective.

By completing this setup, you will have:

- A Snowflake account with Snowsight access.
- A configured virtual warehouse.
- A dedicated learning database.
- Separate database schemas.
- A working environment for SQL development and Snowflake CLI automation.

## 2. Snowflake Account Registration

### Step 1: Visit Snowflake

Open the official Snowflake website:

https://www.snowflake.com/

Navigate to the Snowflake trial or account registration option.

### Step 2: Register your account

Provide the required registration details:

- First name
- Last name
- Business email
- Company or organization details, if requested
- Country or region
- Cloud provider
- Cloud region

For this learning environment, the selected configuration is:

| Configuration | Value |
|---|---|
| Cloud provider | Microsoft Azure |
| Cloud region | Central India |
| Account type | Trial / Learning |

*Note: Trial availability and supported cloud regions depend on Snowflake's current registration options.*

### Step 3: Activate the account

1. Complete the registration process.
2. Verify your email address if requested.
3. Follow the account activation instructions.
4. Sign in to your Snowflake account.

## 3. Access Snowsight

Snowsight is Snowflake's web-based interface for managing and interacting with your Snowflake environment.

Open your Snowflake account URL and sign in.

Explore these sections:

| Section | Purpose |
|---|---|
| Worksheets | Execute SQL statements |
| Projects | Organize SQL development work |
| Data | Browse databases, schemas and tables |
| Compute | Manage virtual warehouses |
| Admin | Manage users, roles and account settings |

## 4. Identify Account Information

After logging in, identify the account details required for CLI configuration.

| Attribute | Description |
|---|---|
| Organization name | Snowflake organization |
| Account name | Account name within the organization |
| Account locator | Account locator |
| Cloud provider | Azure, AWS or GCP |
| Cloud region | Selected deployment region |
| Account URL | Snowflake account hostname |

### Important

- Use the correct account identifier when configuring Snowflake CLI.
- Keep account-specific information out of public repositories.
- Never commit passwords, private keys or authentication secrets to GitHub.

## 5. Understand Snowflake Roles

Snowflake uses Role-Based Access Control (RBAC).

A role determines which operations a user can perform.

Important built-in roles:

| Role | Purpose |
|---|---|
| ACCOUNTADMIN | Account administration |
| SECURITYADMIN | Security and access management |
| SYSADMIN | Database and warehouse object management |
| USERADMIN | User and role management |
| PUBLIC | Default role available to users |

For initial account setup, ACCOUNTADMIN can be used for administrative activities.

**Security recommendation:** Avoid using ACCOUNTADMIN for routine development and deployment. Use dedicated roles with minimum required privileges.

Detailed RBAC implementation is covered in Module 02.

## 6. Create a Virtual Warehouse

A virtual warehouse provides the compute resources required to execute SQL queries.

Open a Snowsight worksheet and execute:

```sql
CREATE WAREHOUSE IF NOT EXISTS SNOWFLAKE_LEARNING_WH
WITH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE;
```

### Warehouse configuration

| Property | Value |
|---|---|
| Warehouse name | SNOWFLAKE_LEARNING_WH |
| Size | XSMALL |
| Auto suspend | 60 seconds |
| Auto resume | TRUE |
| Initial state | Suspended |

### Why these settings?

- XSMALL is suitable for basic learning exercises.
- AUTO_SUSPEND stops idle compute.
- AUTO_RESUME starts the warehouse when required.
- INITIALLY_SUSPENDED prevents unnecessary initial compute usage.

**Cost management:** Monitor warehouse usage and trial credits. A warehouse can incur compute charges while running.

## 7. Create a Learning Database

Create a dedicated database for hands-on exercises.

```sql
CREATE DATABASE IF NOT EXISTS DEVOPS_LAB_DB;
```

This database will be used throughout the Snowflake learning modules.

## 8. Create Database Schemas

Create separate schemas to organize different data lifecycle stages.

```sql
CREATE SCHEMA IF NOT EXISTS DEVOPS_LAB_DB.RAW;

CREATE SCHEMA IF NOT EXISTS DEVOPS_LAB_DB.STAGING;

CREATE SCHEMA IF NOT EXISTS DEVOPS_LAB_DB.CURATED;
```

### Schema design

| Schema | Purpose |
|---|---|
| RAW | Raw or source data |
| STAGING | Intermediate processing data |
| CURATED | Refined data for consumption |

This structure provides a foundation for understanding Snowflake database organization.

## 9. Configure the Default Session

Set the warehouse, database and schema for your worksheet session.

```sql
USE WAREHOUSE SNOWFLAKE_LEARNING_WH;

USE DATABASE DEVOPS_LAB_DB;

USE SCHEMA RAW;
```

Verify the session context:

```sql
SELECT
    CURRENT_USER() AS CURRENT_USER,
    CURRENT_ROLE() AS CURRENT_ROLE,
    CURRENT_DATABASE() AS CURRENT_DATABASE,
    CURRENT_SCHEMA() AS CURRENT_SCHEMA,
    CURRENT_WAREHOUSE() AS CURRENT_WAREHOUSE;
```

Expected context:

| Property | Expected value |
|---|---|
| Database | DEVOPS_LAB_DB |
| Schema | RAW |
| Warehouse | SNOWFLAKE_LEARNING_WH |

The current user and role depend on the account session.

## 10. Verify Database Objects

List available databases:

```sql
SHOW DATABASES;
```

List schemas:

```sql
SHOW SCHEMAS IN DATABASE DEVOPS_LAB_DB;
```

List warehouses:

```sql
SHOW WAREHOUSES;
```

Inspect warehouse configuration:

```sql
SHOW WAREHOUSES LIKE 'SNOWFLAKE_LEARNING_WH';
```

## 11. Create a Test Table

Verify that your learning environment can create database objects.

```sql
USE DATABASE DEVOPS_LAB_DB;

USE SCHEMA RAW;

CREATE TABLE IF NOT EXISTS ACCOUNT_SETUP_TEST (
    ID NUMBER,
    MESSAGE VARCHAR(200),
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
```

Insert a test record:

```sql
INSERT INTO ACCOUNT_SETUP_TEST (ID, MESSAGE)
VALUES (
    1,
    'Snowflake account setup completed'
);
```

Retrieve the record:

```sql
SELECT * FROM ACCOUNT_SETUP_TEST;
```

Expected result:

| ID | MESSAGE |
|---|---|
| 1 | Snowflake account setup completed |

## 12. Cost Management and Security Best Practices

Follow these practices when using a Snowflake learning account:

1. Use XSMALL warehouses for basic learning exercises.
2. Configure AUTO_SUSPEND.
3. Avoid leaving warehouses running unnecessarily.
4. Monitor credit consumption and available trial credits.
5. Use dedicated service users for automation.
6. Follow least-privilege RBAC.
7. Never store passwords, private keys or passphrases in Git.
8. Keep Snowflake connection configuration outside source control.
9. Separate administrative and deployment permissions.

## 13. Learning Environment Architecture

```text
             Snowflake Account
                    |
          +---------+---------+
          |                   |
       Snowsight          Compute
                              |
                    SNOWFLAKE_LEARNING_WH
                              |
                       DEVOPS_LAB_DB
                              |
                  +-----------+-----------+
                  |           |           |
                 RAW       STAGING     CURATED
                  |
          ACCOUNT_SETUP_TEST
```

## 14. Account Setup Completion Checklist

- [ ] Snowflake account registered.
- [ ] Account activated.
- [ ] Snowsight login verified.
- [ ] Cloud provider and region identified.
- [ ] Virtual warehouse created.
- [ ] Learning database created.
- [ ] RAW schema created.
- [ ] STAGING schema created.
- [ ] CURATED schema created.
- [ ] Session context verified.
- [ ] Test table created.
- [ ] Test record inserted and queried.
- [ ] Warehouse cost controls configured.

## 15. Next Learning Modules

| Module | Topic |
|---|---|
| 01 | Snowflake Fundamentals and Account Setup |
| 02 | Snowflake RBAC |
| 03 | Service Users and Authentication |
| 04 | Snowflake CLI for DevOps |
| 05 | Snowflake CI/CD with GitHub Actions |

## 16. Learning Outcome

After completing this guide, you should have a functional Snowflake learning environment ready for:

- SQL development.
- Database and warehouse management.
- RBAC implementation.
- Service-user authentication.
- Snowflake CLI automation.
- GitHub Actions CI/CD integration.

**Next:** Continue with Snowflake architecture, databases, schemas and virtual warehouses.
