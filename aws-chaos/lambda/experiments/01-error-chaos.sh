#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"

echo "========================================"
echo "CHAOS #1: APPLICATION ERROR INJECTION"
echo "========================================"

aws lambda invoke \
  --function-name "$FUNCTION" \
  --region "$REGION" \
  --cli-binary-format raw-in-base64-out \
  --payload '{"action":"error"}' \
  responses/01-error-response.json

echo ""
echo "Response:"
cat responses/01-error-response.json

echo ""
echo "Chaos #1 completed."

