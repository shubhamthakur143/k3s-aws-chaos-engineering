#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RESPONSE_DIR="$BASE_DIR/responses/08-config-chaos"

mkdir -p "$RESPONSE_DIR"

echo "=========================================="
echo " CHAOS #8: CONFIGURATION CHAOS"
echo "=========================================="

echo ""
echo "[STEP 1] Setting correct configuration..."
aws lambda update-function-configuration \
    --function-name "$FUNCTION" \
    --environment "Variables={APP_MODE=production}" \
    --region "$REGION" > /dev/null

aws lambda wait function-updated \
    --function-name "$FUNCTION" \
    --region "$REGION"

echo "[STEP 2] Testing baseline..."

aws lambda invoke \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --cli-binary-format raw-in-base64-out \
    --payload '{"action":"config_test"}' \
    "$RESPONSE_DIR/baseline.json" > /dev/null

cat "$RESPONSE_DIR/baseline.json"

echo ""
echo ""
echo "=========================================="
echo " INJECTING CONFIGURATION FAULT"
echo "=========================================="

echo "[CHAOS] Changing APP_MODE to chaos..."

aws lambda update-function-configuration \
    --function-name "$FUNCTION" \
    --environment "Variables={APP_MODE=chaos}" \
    --region "$REGION" > /dev/null

aws lambda wait function-updated \
    --function-name "$FUNCTION" \
    --region "$REGION"

echo "[CHAOS] Testing invalid configuration..."

aws lambda invoke \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --cli-binary-format raw-in-base64-out \
    --payload '{"action":"config_test"}' \
    "$RESPONSE_DIR/chaos-response.json" \
    > "$RESPONSE_DIR/invoke-output.log" 2>&1

echo ""
echo "[CHAOS RESPONSE]"
cat "$RESPONSE_DIR/chaos-response.json"

echo ""
echo ""
echo "=========================================="
echo " RECOVERY"
echo "=========================================="

echo "[RECOVERY] Restoring APP_MODE=production..."

aws lambda update-function-configuration \
    --function-name "$FUNCTION" \
    --environment "Variables={APP_MODE=production}" \
    --region "$REGION" > /dev/null

aws lambda wait function-updated \
    --function-name "$FUNCTION" \
    --region "$REGION"

echo "[RECOVERY] Testing Lambda..."

aws lambda invoke \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --cli-binary-format raw-in-base64-out \
    --payload '{"action":"config_test"}' \
    "$RESPONSE_DIR/recovery.json" > /dev/null

echo ""
echo "[RECOVERY RESPONSE]"
cat "$RESPONSE_DIR/recovery.json"

echo ""
echo ""
echo "=========================================="
echo " CHAOS #8 COMPLETED"
echo "=========================================="
