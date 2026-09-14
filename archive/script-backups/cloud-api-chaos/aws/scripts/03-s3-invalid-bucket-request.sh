#!/bin/bash

set -u

RESULT_DIR="../results"
RESULT_FILE="$RESULT_DIR/03-s3-invalid-bucket-request-result.txt"

VALID_BUCKET="floci-chaos-s3-03"
INVALID_BUCKET="floci-chaos-s3-03-invalid"
OBJECT="application-data.txt"
CONTENT="Production application data"

mkdir -p "$RESULT_DIR"

exec > >(tee "$RESULT_FILE") 2>&1

echo "=========================================="
echo "AWS API CHAOS #3: S3 INVALID BUCKET REQUEST"
echo "=========================================="

eval $(floci env)

echo
echo "[1] ENVIRONMENT CHECK"

if ! floci status | grep -q "Reachable:  yes"; then
    echo "ERROR: Floci is not reachable."
    exit 1
fi

echo "Floci is running."

echo
echo "[2] CLEANUP"

aws s3 rm "s3://$VALID_BUCKET" --recursive 2>/dev/null || true
aws s3 rb "s3://$VALID_BUCKET" 2>/dev/null || true

rm -f "$OBJECT" baseline.txt after-chaos.txt recovered.txt

echo
echo "[3] BASELINE"

aws s3 mb "s3://$VALID_BUCKET"

echo "$CONTENT" > "$OBJECT"

aws s3 cp "$OBJECT" "s3://$VALID_BUCKET/$OBJECT"

aws s3 cp \
"s3://$VALID_BUCKET/$OBJECT" \
baseline.txt

echo "BASELINE SUCCESS"
cat baseline.txt

echo
echo "=========================================="
echo "CHAOS INJECTION"
echo "Application configured with WRONG bucket"
echo "=========================================="

echo
echo "[4] IMPACT OBSERVATION"

if aws s3 cp \
"s3://$INVALID_BUCKET/$OBJECT" \
after-chaos.txt; then

    echo "UNEXPECTED: Request succeeded"

else

    echo "EXPECTED FAILURE"
    echo "Impact: Application cannot access data"
    echo "Reason: Incorrect S3 bucket configuration"

fi

echo
echo "[5] RECOVERY"

echo "Restoring correct bucket configuration..."

aws s3 cp \
"s3://$VALID_BUCKET/$OBJECT" \
recovered.txt

echo
echo "[6] RECOVERY VERIFICATION"

if [ -f recovered.txt ]; then

    echo "RECOVERY SUCCESSFUL"
    echo "Recovered data:"
    cat recovered.txt

else

    echo "RECOVERY FAILED"

fi

echo
echo "=========================================="
echo "CHAOS #3 COMPLETED"
echo "=========================================="

echo
echo "Summary:"
echo "Baseline: SUCCESS"
echo "Chaos: Invalid S3 bucket configuration"
echo "Impact: S3 API request failure"
echo "Recovery: Correct bucket restored"

