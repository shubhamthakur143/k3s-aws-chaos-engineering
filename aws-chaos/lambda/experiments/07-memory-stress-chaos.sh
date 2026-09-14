#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RESPONSE_DIR="$BASE_DIR/responses/07-memory-stress"

mkdir -p "$RESPONSE_DIR"

echo "=========================================="
echo " CHAOS #7: LAMBDA MEMORY STRESS / OOM"
echo "=========================================="

echo ""
echo "[INFO] Invoking Lambda with memory_stress action..."
echo "[INFO] Lambda configured memory is expected to be 128 MB"

aws lambda invoke \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --cli-binary-format raw-in-base64-out \
    --payload '{"action":"memory_stress"}' \
    "$RESPONSE_DIR/memory-stress-response.json"

echo ""
echo "=========================================="
echo " CHAOS RESULT"
echo "=========================================="

cat "$RESPONSE_DIR/memory-stress-response.json"

echo ""
echo ""

if grep -q "OutOfMemory" "$RESPONSE_DIR/memory-stress-response.json"; then
    echo "[SUCCESS] OOM Chaos successfully triggered!"
else
    echo "[INFO] Check response and CloudWatch logs."
fi

echo ""
echo "=========================================="
echo " RECOVERY TEST"
echo "=========================================="

echo "[INFO] Invoking normal Lambda request..."

aws lambda invoke \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --cli-binary-format raw-in-base64-out \
    --payload '{"action":"normal"}' \
    "$RESPONSE_DIR/recovery-response.json"

echo ""
echo "[RECOVERY RESPONSE]"
cat "$RESPONSE_DIR/recovery-response.json"

echo ""
echo ""
echo "=========================================="
echo " CHAOS #7 COMPLETED"
echo "=========================================="

