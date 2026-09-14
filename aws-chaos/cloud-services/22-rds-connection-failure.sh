#!/bin/bash

echo "=========================================="
echo " AWS CHAOS #22 - RDS CONNECTION FAILURE"
echo "=========================================="

REGION="ap-south-1"

# Intentionally invalid RDS endpoint
RDS_HOST="chaos-invalid-rds.cluster-xyz.ap-south-1.rds.amazonaws.com"
RDS_PORT="3306"

echo ""
echo "Target RDS Host: $RDS_HOST"
echo "Target Port: $RDS_PORT"

echo ""
echo "========== CHAOS STARTED =========="
echo "Simulating RDS connection failure..."

echo ""
echo "Testing DNS resolution..."

if getent hosts "$RDS_HOST"; then
    echo "Unexpected: Host resolved."
else
    echo "DNS/endpoint resolution failed as expected."
fi

echo ""
echo "Testing TCP connection..."

timeout 10 bash -c "</dev/tcp/$RDS_HOST/$RDS_PORT" \
    > rds-chaos-response.log 2>&1

EXIT_CODE=$?

echo ""
echo "========== CHAOS RESULT =========="

if [ $EXIT_CODE -ne 0 ]; then
    echo "RDS connection failure successfully simulated."
    echo "Connection to RDS is unavailable."
else
    echo "WARNING: Connection unexpectedly succeeded."
fi

echo ""
echo "========== RECOVERY =========="
echo "No actual RDS instance was modified."
echo "No database data was affected."

rm -f rds-chaos-response.log

echo ""
echo "AWS Chaos #22 completed successfully."

