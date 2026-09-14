#!/bin/bash

set -u

RESULT_DIR="../results"
RESULT_FILE="$RESULT_DIR/05-s3-invalid-object-request-result.txt"

BUCKET="floci-chaos-s3-05"
VALID_OBJECT="application-data.txt"
INVALID_OBJECT="application-data-v2.txt"
CONTENT="Important production application data"

mkdir -p "$RESULT_DIR"

exec > >(tee "$RESULT_FILE") 2>&1

echo "=========================================="
echo "AWS API CHAOS #5: S3 INVALID OBJECT REQUEST"
echo "=========================================="

eval $(floci env)

echo
echo "[1] ENVIRONMENT CHECK"

if ! floci status | grep -q "Reachable:  yes"; then
    echo "ERROR: Floci is not running or reachable."
    exit 1
fi

echo "Floci is running."

echo
echo "[2] CLEANUP"

aws s3 rm "s3://$BUCKET" --recursive 2>/dev/null || true
aws s3 rb "s3://$BUCKET" 2>/dev/null || true

rm -f application-data.txt baseline.txt after-chaos.txt recovered.txt

echo
echo "[3] BASELINE"

aws s3 mb "s3://$BUCKET"

echo "$CONTENT" > "$VALID_OBJECT"

aws s3 cp "$VALID_OBJECT" \
    "s3://$BUCKET/$VALID_OBJECT"

echo "Verifying correct object access..."

if aws s3 cp \
    "s3://$BUCKET/$VALID_OBJECT" \
    baseline.txt; then

    echo "BASELINE SUCCESS"
    cat baseline.txt
else
    echo "BASELINE FAILED"
    exit 1
fi

echo
echo "=========================================="
echo "CHAOS INJECTION"
echo "Application requests a NON-EXISTENT object"
echo "=========================================="

echo
echo "[4] IMPACT OBSERVATION"

echo "Requesting: $INVALID_OBJECT"

if aws s3 cp \
    "s3://$BUCKET/$INVALID_OBJECT" \
    after-chaos.txt; then

    echo "UNEXPECTED: Object exists"

else

    echo "EXPECTED FAILURE CONFIRMED"
    echo "Impact: Application cannot retrieve required data"
    echo "Reason: Incorrect object key / object does not exist"
fi

echo
echo "[5] RECOVERY"

echo "Restoring correct application configuration..."
echo "Application will request: $VALID_OBJECT"

if aws s3 cp \
    "s3://$BUCKET/$VALID_OBJECT" \
    recovered.txt; then

    echo "RECOVERY SUCCESSFUL"
    echo "Recovered data:"
    cat recovered.txt
else
    echo "RECOVERY FAILED"
fi

echo
echo "=========================================="
echo "CHAOS #5 COMPLETED"
echo "=========================================="

echo
echo "Summary:"
echo "Baseline: Correct object accessible"
echo "Chaos: Invalid object key requested"
echo "Expected Impact: S3 API returns 404 Not Found"
echo "Recovery: Correct object key restored"

