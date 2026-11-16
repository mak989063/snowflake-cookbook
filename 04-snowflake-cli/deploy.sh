
#!/usr/bin/env bash

set -Eeuo pipefail

# -----------------------------------------
# Configuration
# -----------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SQL_DIR="${SCRIPT_DIR}/sql"
LOG_DIR="${SCRIPT_DIR}/logs"

CONNECTION_NAME="devops_ci"
DEPLOY_ENV="${1:-}"

# -----------------------------------------
# Validate deployment environment
# -----------------------------------------

if [[ -z "$DEPLOY_ENV" ]]; then
    echo "Usage: ./04-snowflake-cli/deploy.sh DEV"
    exit 2
fi

case "$DEPLOY_ENV" in
    DEV)
        ;;
    QA|PROD)
        echo "ERROR: ${DEPLOY_ENV} is not configured yet."
        echo "Configure a separate Snowflake target before enabling it."
        exit 2
        ;;
    *)
        echo "ERROR: Invalid environment: ${DEPLOY_ENV}"
        echo "Supported environment: DEV"
        exit 2
        ;;
esac

# -----------------------------------------
# Logging configuration
# -----------------------------------------

mkdir -p "$LOG_DIR"

TIMESTAMP="$(date '+%Y%m%d_%H%M%S')"
LOG_FILE="${LOG_DIR}/deploy_${DEPLOY_ENV}_${TIMESTAMP}.log"

log() {
    printf '[%s] %s\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG_FILE"
}

# -----------------------------------------
# Exit handling
# -----------------------------------------

on_exit() {
    local exit_code=$?

    if [[ "$exit_code" -eq 0 ]]; then
        log "DEPLOYMENT SUCCESSFUL"
    else
        log "DEPLOYMENT FAILED - Exit code: ${exit_code}"
    fi
}

trap on_exit EXIT

# -----------------------------------------
# Execute deployment step
# -----------------------------------------

run_step() {
    local step_name="$1"
    shift

    log "START: ${step_name}"

    if "$@" 2>&1 | tee -a "$LOG_FILE"; then
        log "SUCCESS: ${step_name}"
    else
        local exit_code=$?
        log "FAILED: ${step_name} - Exit code: ${exit_code}"
        return "$exit_code"
    fi
}

# -----------------------------------------
# Deployment execution
# -----------------------------------------

log "=========================================="
log "Starting Snowflake Deployment"
log "Environment: ${DEPLOY_ENV}"
log "Connection: ${CONNECTION_NAME}"
log "=========================================="

# Step 1: Validate Snowflake connection

run_step "Validate Snowflake connection" \
    snow connection test -c "$CONNECTION_NAME"

# Step 2: Create deployment demo table

run_step "Create deployment demo table" \
    snow sql -c "$CONNECTION_NAME" \
    -f "${SQL_DIR}/01_create_deployment_table.sql"

# Step 3: Create deployment audit table

run_step "Create deployment audit table" \
    snow sql -c "$CONNECTION_NAME" \
    -f "${SQL_DIR}/02_create_deployment_audit.sql"

# Step 4: Update deployment audit record with environment

run_step "Update deployment audit record" \
    snow sql -c "$CONNECTION_NAME" \
    -D "deploy_env=${DEPLOY_ENV}" \
    -f "${SQL_DIR}/03_merge_deployment_audit.sql"

log "All deployment steps completed."

