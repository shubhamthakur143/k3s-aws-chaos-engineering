#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RESPONSE_DIR="$BASE_DIR/responses/10-dependency-failure"

mkdir -p "$RESPONSE_DIR"

echo "=========================================="
echo " CHAOS #10: DOWNSTREAM DEPENDENCY FAILURE"
echo "=========================================="

echo ""
echo "[CHAOS] Simulating downstream dependency failure..."

aws lambda invoke \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --cli-binary-format raw-in-base64-out \
    --payload '{"action":"dependency_failure"}' \
    "$RESPONSE_DIR/dependency-failure.json" \
    > "$RESPONSE_DIR/invoke-output.log" 2>&1

echo ""
echo "=========================================="
echo " CHAOS RESULT"
echo "=========================================="

cat "$RESPONSE_DIR/dependency-failure.json"

echo ""

if grep -q "downstream dependency failure" \
    "$RESPONSE_DIR/dependency-failure.json"; then

    echo "[SUCCESS] Dependency failure successfully simulated!"
else
    echo "[INFO] Check Lambda response and CloudWatch logs."
fi

echo ""
echo "=========================================="
echo " CLOUDWATCH LOGS"
echo "=========================================="

aws logs tail "/aws/lambda/$FUNCTION" \
    --region "$REGION" \
    --since 2m

echo ""
echo "=========================================="
echo " RECOVERY TEST"
echo "=========================================="

echo "[RECOVERY] Invoking Lambda normally..."

aws lambda invoke \
    --function-name "$FUNCTION" \
    --region "$REGION" \
    --cli-binary-format raw-in-base64-out \
    --payload '{"action":"normal"}' \
    "$RESPONSE_DIR/recovery.json" \
    > "$RESPONSE_DIR/recovery-invoke.log" 2>&1

echo ""
echo "[RECOVERY RESPONSE]"
cat "$RESPONSE_DIR/recovery.json"

echo ""

if grep -q "Lambda executed successfully" \
    "$RESPONSE_DIR/recovery.json"; then

    echo "[SUCCESS] Lambda recovered successfully!"
else
    echo "[WARNING] Recovery verification failed."
fi

echo ""
echo "=========================================="
echo " CHAOS #10 COMPLETED"
echo "=========================================="
