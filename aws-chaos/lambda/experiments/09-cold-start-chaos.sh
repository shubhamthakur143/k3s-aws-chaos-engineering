#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RESPONSE_DIR="$BASE_DIR/responses/09-cold-start"

mkdir -p "$RESPONSE_DIR"

echo "=========================================="
echo " CHAOS #9: LAMBDA COLD START EXPERIMENT"
echo "=========================================="

echo ""
echo "[INFO] Checking Lambda configuration..."

aws lambda get-function-configuration \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --query '[Runtime,MemorySize,Timeout,LastModified]' \
    --output table

echo ""
echo "=========================================="
echo " INVOCATION 1"
echo "=========================================="

echo "[TEST] First invocation..."

aws lambda invoke \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --cli-binary-format raw-in-base64-out \
    --payload '{"action":"normal"}' \
    "$RESPONSE_DIR/first-response.json"

echo ""
echo "Response:"
cat "$RESPONSE_DIR/first-response.json"

echo ""
echo ""
echo "=========================================="
echo " INVOCATION 2"
echo "=========================================="

echo "[TEST] Second invocation..."

aws lambda invoke \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --cli-binary-format raw-in-base64-out \
    --payload '{"action":"normal"}' \
    "$RESPONSE_DIR/second-response.json"

echo ""
echo "Response:"
cat "$RESPONSE_DIR/second-response.json"

echo ""
echo ""
echo "=========================================="
echo " CLOUDWATCH OBSERVATION"
echo "=========================================="

echo "Check logs using:"
echo ""
echo "aws logs tail /aws/lambda/$FUNCTION --region $REGION --since 5m"

echo ""
echo "=========================================="
echo " CHAOS #9 COMPLETED"
echo "=========================================="
