#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"

echo "========================================"
echo "CHAOS #4: CPU STRESS"
echo "========================================"

aws lambda invoke \
  --function-name "$FUNCTION" \
  --region "$REGION" \
  --cli-binary-format raw-in-base64-out \
  --payload '{"action":"cpu"}' \
  responses/04-cpu-response.json

echo ""
echo "Response:"
cat responses/04-cpu-response.json

echo ""
echo "Chaos #4 completed."
