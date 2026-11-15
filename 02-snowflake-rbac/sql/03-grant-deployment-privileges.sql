-- Run with a role authorised to grant these privileges.
USE ROLE ACCOUNTADMIN;

-- Warehouse access.
GRANT USAGE ON WAREHOUSE SNOWFLAKE_LEARNING_WH
    TO ROLE DEVOPS_DEPLOY_ROLE;

-- Database and target schema access.
GRANT USAGE ON DATABASE DEVOPS_LAB_DB
    TO ROLE DEVOPS_DEPLOY_ROLE;

GRANT USAGE ON SCHEMA DEVOPS_LAB_DB.RAW
    TO ROLE DEVOPS_DEPLOY_ROLE;

-- Object creation privileges in the target schema.
GRANT CREATE TABLE, CREATE VIEW
    ON SCHEMA DEVOPS_LAB_DB.RAW
    TO ROLE DEVOPS_DEPLOY_ROLE;

-- Assign the role to the learning user.
-- Replace MAK989063 if using a different user.
GRANT ROLE DEVOPS_DEPLOY_ROLE TO USER MAK989063;

-- Verify privileges granted to the custom role.
SHOW GRANTS TO ROLE DEVOPS_DEPLOY_ROLE;
