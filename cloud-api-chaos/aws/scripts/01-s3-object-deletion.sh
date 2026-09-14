#!/bin/bash

set -u

RESULT_DIR="../results"
RESULT_FILE="$RESULT_DIR/01-s3-object-deletion-result.txt"

BUCKET="floci-chaos-s3-01"
OBJECT="config.txt"
CONTENT="Important application configuration"

mkdir -p "$RESULT_DIR"

exec > >(tee "$RESULT_FILE") 2>&1

echo "=========================================="
echo "AWS API CHAOS #1: S3 OBJECT DELETION"
echo "=========================================="
echo

echo "[1] Environment Setup"
eval $(floci env)

echo "Floci Status:"
floci status
echo

echo "[2] Cleanup Previous Resources"
aws s3 rm "s3://$BUCKET/$OBJECT" 2>/dev/null || true
aws s3 rb "s3://$BUCKET" 2>/dev/null || true
rm -f "$OBJECT" downloaded-config.txt recovered-config.txt

echo
echo "[3] BASELINE - Create Bucket"
aws s3 mb "s3://$BUCKET"

echo
echo "[4] BASELINE - Create and Upload Object"
echo "$CONTENT" > "$OBJECT"
aws s3 cp "$OBJECT" "s3://$BUCKET/$OBJECT"

echo
echo "[5] BASELINE VERIFICATION"
aws s3 cp "s3://$BUCKET/$OBJECT" downloaded-config.txt
echo "Downloaded content:"
cat downloaded-config.txt

echo
echo "=========================================="
echo "CHAOS INJECTION"
echo "Deleting critical S3 object: $OBJECT"
echo "=========================================="

aws s3 rm "s3://$BUCKET/$OBJECT"

echo
echo "[6] IMPACT OBSERVATION"
echo "Trying to access deleted object..."

if aws s3 cp "s3://$BUCKET/$OBJECT" after-chaos-config.txt; then
    echo "UNEXPECTED: Object is still accessible"
else
    echo "EXPECTED FAILURE: Object access failed"
    echo "IMPACT: S3 object unavailable (404 Not Found)"
fi

echo
echo "[7] RECOVERY"
echo "Restoring deleted object..."

echo "$CONTENT" > "$OBJECT"
aws s3 cp "$OBJECT" "s3://$BUCKET/$OBJECT"

echo
echo "[8] RECOVERY VERIFICATION"

if aws s3 cp "s3://$BUCKET/$OBJECT" recovered-config.txt; then
    echo "RECOVERY SUCCESSFUL"
    echo "Recovered content:"
    cat recovered-config.txt
else
    echo "RECOVERY FAILED"
fi

echo
echo "=========================================="
echo "CHAOS #1 COMPLETED"
echo "=========================================="
echo
echo "Summary:"
echo "Baseline: SUCCESS"
echo "Chaos: S3 Object Deletion"
echo "Expected Impact: Object unavailable / 404"
echo "Recovery: Object restored"
