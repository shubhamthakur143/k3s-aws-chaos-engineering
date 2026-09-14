#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"

echo "========================================"
echo "CHAOS #3: MEMORY PRESSURE"
echo "========================================"

aws lambda invoke \
  --function-name "$FUNCTION" \
  --region "$REGION" \
  --cli-binary-format raw-in-base64-out \
  --payload '{"action":"memory"}' \
  responses/03-memory-response.json

echo ""
echo "Response:"
cat responses/03-memory-response.json

echo ""
echo "Chaos #3 completed."

