-- Activate the dedicated deployment role.
USE ROLE DEVOPS_DEPLOY_ROLE;

-- Disable secondary roles for a clean privilege-boundary test.
USE SECONDARY ROLES NONE;

-- Select the warehouse and target namespace.
USE WAREHOUSE SNOWFLAKE_LEARNING_WH;
USE DATABASE DEVOPS_LAB_DB;
USE SCHEMA RAW;

-- Verify the session context.
SELECT
    CURRENT_USER()       AS CURRENT_USER,
    CURRENT_ROLE()       AS CURRENT_ROLE,
    CURRENT_DATABASE()   AS CURRENT_DATABASE,
    CURRENT_SCHEMA()     AS CURRENT_SCHEMA,
    CURRENT_WAREHOUSE()  AS CURRENT_WAREHOUSE;
