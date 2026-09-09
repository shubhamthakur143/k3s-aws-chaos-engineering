#!/bin/bash

echo "=========================================="
echo " AWS CHAOS #20 - IAM PERMISSION FAILURE"
echo "=========================================="

REGION="ap-south-1"
FAKE_ROLE_ARN="arn:aws:iam::632843870789:role/Chaos-NonExistent-Role"

echo ""
echo "========== CURRENT AWS IDENTITY =========="
aws sts get-caller-identity

echo ""
echo ">>> CHAOS STARTED <<<"
echo "Simulating IAM permission/role access failure..."

echo ""
echo "Attempting to assume a non-existent IAM role:"
echo "$FAKE_ROLE_ARN"

aws sts assume-role \
  --role-arn "$FAKE_ROLE_ARN" \
  --role-session-name chaos-test \
  --region "$REGION" \
  > iam-chaos-response.json 2>&1

EXIT_CODE=$?

echo ""
echo "========== CHAOS RESULT =========="

if [ $EXIT_CODE -ne 0 ]; then
    echo "IAM access failure successfully simulated."
    echo ""
    cat iam-chaos-response.json
else
    echo "WARNING: Command unexpectedly succeeded."
fi

echo ""
echo "========== RECOVERY =========="
echo "No IAM permissions were modified."
echo "No recovery action required."

rm -f iam-chaos-response.json

echo ""
echo "AWS Chaos #20 completed successfully."

