#!/bin/bash

set -euo pipefail

echo "Starting failure-handling test..."

echo "[1/3] Running valid SQL..."

snow sql -c devops_ci \
  -q "SELECT CURRENT_USER();"

echo "[2/3] Running intentionally invalid SQL..."

snow sql -c devops_ci \
  -f 04-snowflake-cli/sql/04_failure_test.sql

echo "[3/3] This message should NOT appear."

echo "Deployment completed successfully."
