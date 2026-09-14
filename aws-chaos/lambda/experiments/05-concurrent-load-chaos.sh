#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RESPONSE_DIR="$BASE_DIR/responses/05-concurrent"

mkdir -p "$RESPONSE_DIR"

echo "=========================================="
echo " CHAOS #5: CONCURRENT INVOCATION LOAD"
echo "=========================================="

REQUESTS=10

echo "Sending $REQUESTS concurrent requests..."

for i in $(seq 1 $REQUESTS)
do
    (
        aws lambda invoke \
            --function-name "$FUNCTION" \
            --region "$REGION" \
            --cli-binary-format raw-in-base64-out \
            --payload '{"action":"normal"}' \
            "$RESPONSE_DIR/response-$i.json" \
            > "$RESPONSE_DIR/invoke-$i.log" 2>&1

        echo "Request $i completed"
    ) &
done

wait

echo ""
echo "=========================================="
echo " ALL CONCURRENT REQUESTS COMPLETED"
echo "=========================================="

echo ""
echo "Successful response files:"
ls -1 "$RESPONSE_DIR"/response-*.json 2>/dev/null | wc -l

echo ""
echo "Chaos #5 completed."
