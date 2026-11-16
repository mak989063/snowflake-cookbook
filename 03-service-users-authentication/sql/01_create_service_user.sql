USE ROLE ACCOUNTADMIN;

CREATE USER SNOWFLAKE_CI_SVC
    TYPE = SERVICE
    COMMENT = 'Dedicated service identity for Snowflake CI/CD deployments';
