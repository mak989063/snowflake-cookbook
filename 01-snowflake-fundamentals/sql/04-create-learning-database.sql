-- Run only if these lab objects do not already exist.
-- Choose a role with the required database/schema creation privileges.

CREATE DATABASE IF NOT EXISTS DEVOPS_LAB_DB;

CREATE SCHEMA IF NOT EXISTS DEVOPS_LAB_DB.RAW;
CREATE SCHEMA IF NOT EXISTS DEVOPS_LAB_DB.STAGING;
CREATE SCHEMA IF NOT EXISTS DEVOPS_LAB_DB.CURATED;

-- Set the working context.
USE DATABASE DEVOPS_LAB_DB;
USE SCHEMA RAW;

-- Verify the schemas.
SHOW SCHEMAS IN DATABASE DEVOPS_LAB_DB;
