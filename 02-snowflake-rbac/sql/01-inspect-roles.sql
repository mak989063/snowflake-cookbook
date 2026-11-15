-- Inspect system-defined and custom roles visible to the current role.
SHOW ROLES;

-- Inspect privileges granted to the Snowflake-provisioned learning role.
-- Run only if this role exists in your account.
SHOW GRANTS TO ROLE SNOWFLAKE_LEARNING_ROLE;

-- Inspect roles granted to the PUBLIC role.
SHOW GRANTS OF ROLE SNOWFLAKE_LEARNING_ROLE;

-- Inspect privileges granted to PUBLIC.
-- Output may be extensive; do not change managed grants for this lab.
SHOW GRANTS TO ROLE PUBLIC;
