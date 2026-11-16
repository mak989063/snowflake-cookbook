# Snowflake Architecture

## High-level architecture

Snowflake can be understood through three main layers:

1. **Database storage** — persists data in Snowflake-managed storage.
2. **Query processing (compute)** — virtual warehouses execute queries and data-processing workloads.
3. **Cloud services** — coordinates and manages activities such as authentication, metadata, query optimization, and access control.

These layers work together, but storage and compute are separated. This separation allows compute resources to be selected and scaled independently from the data being stored.

## Virtual warehouses are independent compute

A virtual warehouse is a cluster of compute resources used to execute SQL statements and other supported workloads. It is not a database and is not contained inside a database.

A warehouse can be:
- Resized to a supported size.
- Suspended when idle.
- Resumed when needed.
- Configured to auto-suspend and auto-resume.

Different workloads can use different warehouses while accessing the same database objects, subject to permissions.

## Object hierarchy

A useful simplified hierarchy is:

`Database → Schema → Tables / Views / Other schema objects`

A database groups schemas. A schema groups objects such as tables, views, and procedures.

A warehouse is separate from this hierarchy: it supplies compute for query execution.

## DevOps perspective

For platform engineering, understand and manage:
- Which warehouse a workload uses.
- Warehouse size and auto-suspend policy.
- Which database and schema a deployment targets.
- Which role is active and has the required privileges.
- How to inspect query and warehouse activity.

Do not confuse selecting a warehouse with granting access to a database. Warehouse privileges and database/schema privileges are separate concerns.
