#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"

echo "========================================"
echo "CHAOS #2: LAMBDA TIMEOUT"
echo "========================================"

aws lambda invoke \
  --function-name "$FUNCTION" \
  --region "$REGION" \
  --cli-binary-format raw-in-base64-out \
  --payload '{"action":"sleep"}' \
  responses/02-timeout-response.json

echo ""
echo "Response:"
cat responses/02-timeout-response.json

echo ""
echo "Chaos #2 completed."

