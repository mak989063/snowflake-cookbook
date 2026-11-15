# Snowflake Virtual Warehouses

## What is a warehouse?

A virtual warehouse provides compute resources to execute queries. It is separate from the database and schema where data objects are stored.

## Important properties

| Property | Meaning |
|---|---|
| `WAREHOUSE_SIZE` | Compute size, for example `XSMALL` |
| `AUTO_SUSPEND` | Idle time in seconds before Snowflake suspends the warehouse |
| `AUTO_RESUME` | Allows the warehouse to resume automatically when needed |
| State | Indicates whether the warehouse is running or suspended |

## Lab configuration

The learning warehouse was configured as follows:

```sql
ALTER WAREHOUSE SNOWFLAKE_LEARNING_WH
SET WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE;
```

Then selected for the session:

```sql
USE WAREHOUSE SNOWFLAKE_LEARNING_WH;
```

## Important distinction

`USE WAREHOUSE` sets the warehouse for the current session. It does not guarantee that the warehouse is actively running. A warehouse may remain suspended until a query needs compute. With auto-resume enabled, Snowflake can resume it automatically.

## Cost-conscious operating habits

- Use the smallest warehouse that is suitable for the learning task.
- Keep auto-suspend enabled and use a short idle timeout for practice.
- Avoid leaving a warehouse running when it is not needed.
- Check warehouse state before and after exercises.
- Remember that warehouse compute usage is a cost consideration; storage and compute are separate.

## Inspect warehouses

```sql
SHOW WAREHOUSES;
```

Inspect one warehouse:

```sql
SHOW WAREHOUSES LIKE 'SNOWFLAKE_LEARNING_WH';
```
