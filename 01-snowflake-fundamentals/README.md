# Module 01 — Snowflake Fundamentals

**Learning track:** Senior DevOps / Platform Engineer  
**Status:** Completed  
**Practice account:** Personal Snowflake learning account

## Objectives

- Understand Snowflake's high-level architecture.
- Distinguish storage, compute, and cloud services.
- Understand warehouses and compute-cost controls.
- Understand databases, schemas, and their relationship to warehouses.
- Navigate the main areas of Snowsight.

## Module contents

| File | Purpose |
|---|---|
| `snowflake-architecture.md` | Three-layer architecture and core concepts |
| `warehouses.md` | Virtual warehouses, sizing, suspend/resume and cost |
| `databases-and-schemas.md` | Database/schema/object hierarchy |
| `sql/01-inspect-account.sql` | Inspect account context |
| `sql/02-inspect-warehouses.sql` | Inspect available warehouses |
| `sql/03-configure-learning-warehouse.sql` | Configure the learning warehouse safely |
| `sql/04-create-learning-database.sql` | Create the learning database and schemas |

## Lab environment notes

The learning account was created on Azure in the Central India region. The account identifier and username are intentionally not included in this repository.

The following lab objects were created during practice:

- Database: `DEVOPS_LAB_DB`
- Schemas: `RAW`, `STAGING`, `CURATED`
- Learning warehouse: `SNOWFLAKE_LEARNING_WH`
- Warehouse size: `XSMALL`
- Auto-suspend: `60` seconds
- Auto-resume: enabled

Snowflake-provisioned objects such as `SNOWFLAKE_LEARNING_DB`, `SNOWFLAKE_SAMPLE_DATA`, and system warehouses may also appear in the account. Do not modify managed/sample objects as part of this introductory lab.

## How to use

1. Open Snowsight and create a SQL worksheet.
2. Review each SQL file before executing it.
3. Run inspection scripts first.
4. Run creation/configuration scripts only if you intend to create or alter the named lab objects.
5. Confirm the current warehouse is suspended when you finish. Auto-suspend is configured to reduce idle compute usage.

## Important safety notes

- Do not commit passwords, private keys, tokens, account URLs containing sensitive identifiers, or client credentials.
- Never use `ACCOUNTADMIN` for routine application deployment. That topic is covered in Module 02 (RBAC).
- A warehouse can incur compute charges while running. Keep the learning warehouse small and configure auto-suspend.
- `USE WAREHOUSE` selects a warehouse for the session; it does not necessarily mean the warehouse is currently running. A suspended warehouse resumes when a query needs compute if auto-resume is enabled.

## Next module

**Module 02 — Snowflake RBAC: users, roles, and privileges.**
