-- Run after activating DEVOPS_DEPLOY_ROLE and disabling secondary roles.
-- Positive test: create a table in the authorised RAW schema.
CREATE TABLE RBAC_TEST (
    ID NUMBER,
    MESSAGE VARCHAR(100)
);

-- Positive test: insert a row into the table created by this role.
INSERT INTO RBAC_TEST (ID, MESSAGE)
VALUES (1, 'DevOps RBAC successful');

-- Positive test: read the row.
SELECT * FROM RBAC_TEST;

-- Negative test: this should fail with insufficient privileges.
-- DEVOPS_DEPLOY_ROLE has USAGE on DEVOPS_LAB_DB but not CREATE SCHEMA.
CREATE SCHEMA DEVOPS_LAB_DB.RBAC_BOUNDARY_TEST;

-- Expected outcome for the statement above:
-- SQL access control error: insufficient privileges to operate on database
-- DEVOPS_LAB_DB. CREATE SCHEMA was not granted to DEVOPS_DEPLOY_ROLE.
