-- Run with a role that has permission to alter this warehouse.
-- Keep the learning warehouse small and auto-suspend quickly.

ALTER WAREHOUSE SNOWFLAKE_LEARNING_WH
SET WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE;

-- Select it for this session.
USE WAREHOUSE SNOWFLAKE_LEARNING_WH;

-- Verify the selected warehouse.
SELECT CURRENT_WAREHOUSE();

-- Inspect its configuration and state.
SHOW WAREHOUSES LIKE 'SNOWFLAKE_LEARNING_WH';
