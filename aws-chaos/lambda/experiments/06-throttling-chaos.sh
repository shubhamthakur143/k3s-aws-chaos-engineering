#!/bin/bash

FUNCTION="chaos-lambda"
REGION="ap-south-1"

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RESPONSE_DIR="$BASE_DIR/responses/06-throttling"

mkdir -p "$RESPONSE_DIR"

echo "=========================================="
echo " CHAOS #6: LAMBDA THROTTLING TEST"
echo "=========================================="

REQUESTS=20

echo "Account concurrency limit is expected to be 10"
echo "Sending $REQUESTS simultaneous long-running requests..."

for i in $(seq 1 $REQUESTS)
do
    (
        aws lambda invoke \
            --function-name "$FUNCTION" \
            --region "$REGION" \
            --cli-binary-format raw-in-base64-out \
            --payload '{"action":"sleep"}' \
            "$RESPONSE_DIR/response-$i.json" \
            > "$RESPONSE_DIR/request-$i.log" 2>&1
    ) &
done

wait

echo ""
echo "=========================================="
echo " RESULTS"
echo "=========================================="

echo ""
echo "Checking throttled requests..."

grep -l "TooManyRequestsException" \
    "$RESPONSE_DIR"/request-*.log 2>/dev/null | wc -l

echo ""
echo "Total requests:"
echo "$REQUESTS"

echo ""
echo "Chaos #6 completed."
