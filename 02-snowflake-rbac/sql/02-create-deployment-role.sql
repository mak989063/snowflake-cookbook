-- Run with an administrative role authorised to create roles.
USE ROLE ACCOUNTADMIN;

CREATE ROLE IF NOT EXISTS DEVOPS_DEPLOY_ROLE
    COMMENT = 'Dedicated role for DevOps CI/CD learning';

-- Verify that the role exists.
SHOW ROLES LIKE 'DEVOPS_DEPLOY_ROLE';
