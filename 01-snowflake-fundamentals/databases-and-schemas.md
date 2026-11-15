# Databases and Schemas

## Database

A database is a logical container for schemas and their objects.

## Schema

A schema is a namespace inside a database. It organizes objects such as tables, views, stages, and procedures.

## Relationship

```text
Snowflake account
└── DEVOPS_LAB_DB
    ├── RAW
    ├── STAGING
    └── CURATED
```

The warehouse is not nested under the database. It is a separate compute resource used to execute queries against accessible objects.

## Lab objects

The learning database is:

`DEVOPS_LAB_DB`

Schemas created for the lab:

- `RAW` — landing area for source-shaped data.
- `STAGING` — intermediate area for prepared data.
- `CURATED` — area for refined data products.

These names are a learning convention for the lab; they are not mandatory Snowflake schema names.

## Useful commands

```sql
SHOW DATABASES;

SHOW SCHEMAS IN DATABASE DEVOPS_LAB_DB;

USE DATABASE DEVOPS_LAB_DB;

USE SCHEMA RAW;
```

## DevOps relevance

Deployment pipelines need an explicit target database and schema. A deployment role also needs the appropriate privileges on those objects. Selecting a database/schema with `USE` does not itself grant access.
