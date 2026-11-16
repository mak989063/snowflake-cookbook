-- Replace with the Base64-encoded public key DER value.
-- Never place private-key contents or passphrases here.
USE ROLE ACCOUNTADMIN;

ALTER USER SNOWFLAKE_CI_SVC
SET RSA_PUBLIC_KEY = '<BASE64_ENCODED_PUBLIC_KEY_DER>';
