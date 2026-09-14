#!/bin/bash

set -u

RESULT_DIR="../results"
RESULT_FILE="$RESULT_DIR/02-s3-bucket-access-failure-result.txt"

BUCKET="floci-chaos-s3-02"
OBJECT="application-data.txt"
CONTENT="Important application data"

mkdir -p "$RESULT_DIR"

exec > >(tee "$RESULT_FILE") 2>&1

echo "=========================================="
echo "AWS API CHAOS #2: S3 BUCKET ACCESS FAILURE"
echo "=========================================="
echo

echo "[1] ENVIRONMENT SETUP"
eval $(floci env)
floci status

echo
echo "[2] CLEANUP PREVIOUS RESOURCES"
aws s3 rm "s3://$BUCKET" --recursive 2>/dev/null || true
aws s3 rb "s3://$BUCKET" 2>/dev/null || true
rm -f "$OBJECT" baseline-download.txt recovered-download.txt

echo
echo "[3] BASELINE - CREATE BUCKET"
aws s3 mb "s3://$BUCKET"

echo
echo "[4] BASELINE - CREATE AND UPLOAD OBJECT"
echo "$CONTENT" > "$OBJECT"
aws s3 cp "$OBJECT" "s3://$BUCKET/$OBJECT"

echo
echo "[5] BASELINE VERIFICATION"
if aws s3 cp "s3://$BUCKET/$OBJECT" baseline-download.txt; then
    echo "BASELINE SUCCESS: Bucket and object are accessible"
    cat baseline-download.txt
else
    echo "BASELINE FAILED"
    exit 1
fi

echo
echo "=========================================="
echo "CHAOS INJECTION"
echo "Deleting the entire S3 bucket"
echo "=========================================="

aws s3 rm "s3://$BUCKET" --recursive
aws s3 rb "s3://$BUCKET"

echo
echo "[6] IMPACT OBSERVATION"
echo "Trying to access the deleted bucket..."

if aws s3 ls "s3://$BUCKET"; then
    echo "UNEXPECTED: Bucket is still accessible"
else
    echo "EXPECTED FAILURE: Bucket access failed"
fi

echo
echo "[7] RECOVERY"
echo "Recreating bucket and restoring object..."

aws s3 mb "s3://$BUCKET"
echo "$CONTENT" > "$OBJECT"
aws s3 cp "$OBJECT" "s3://$BUCKET/$OBJECT"

echo
echo "[8] RECOVERY VERIFICATION"

if aws s3 cp "s3://$BUCKET/$OBJECT" recovered-download.txt; then
    echo "RECOVERY SUCCESSFUL"
    echo "Recovered content:"
    cat recovered-download.txt
else
    echo "RECOVERY FAILED"
fi

echo
echo "=========================================="
echo "CHAOS #2 COMPLETED"
echo "=========================================="
echo
echo "Summary:"
echo "Baseline: SUCCESS"
echo "Chaos: S3 Bucket Deletion"
echo "Expected Impact: Bucket unavailable"
echo "Recovery: Bucket recreated and object restored"
