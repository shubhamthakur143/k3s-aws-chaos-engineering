#!/bin/bash

set -u

RESULT_DIR="../results"
RESULT_FILE="$RESULT_DIR/04-s3-object-overwrite-chaos-result.txt"

BUCKET="floci-chaos-s3-04"
OBJECT="application-config.txt"

ORIGINAL_CONTENT="environment=production"
CORRUPTED_CONTENT="environment=CORRUPTED"

mkdir -p "$RESULT_DIR"

exec > >(tee "$RESULT_FILE") 2>&1

echo "=========================================="
echo "AWS API CHAOS #4: S3 OBJECT OVERWRITE"
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

rm -f original.txt corrupted.txt recovered.txt

echo
echo "[3] BASELINE"

aws s3 mb "s3://$BUCKET"

echo "$ORIGINAL_CONTENT" > original.txt

aws s3 cp original.txt "s3://$BUCKET/$OBJECT"

aws s3 cp "s3://$BUCKET/$OBJECT" baseline.txt

echo "BASELINE OBJECT CONTENT:"
cat baseline.txt

echo
echo "=========================================="
echo "CHAOS INJECTION"
echo "Overwriting valid object with corrupted data"
echo "=========================================="

echo "$CORRUPTED_CONTENT" > corrupted.txt

aws s3 cp corrupted.txt "s3://$BUCKET/$OBJECT"

echo
echo "[4] IMPACT OBSERVATION"

aws s3 cp "s3://$BUCKET/$OBJECT" after-chaos.txt

echo "OBJECT CONTENT AFTER CHAOS:"
cat after-chaos.txt

if grep -q "$CORRUPTED_CONTENT" after-chaos.txt; then
    echo "EXPECTED IMPACT CONFIRMED"
    echo "Object exists but data is corrupted."
else
    echo "CHAOS VERIFICATION FAILED"
fi

echo
echo "[5] RECOVERY"

echo "Restoring original object data..."

echo "$ORIGINAL_CONTENT" > original.txt

aws s3 cp original.txt "s3://$BUCKET/$OBJECT"

echo
echo "[6] RECOVERY VERIFICATION"

aws s3 cp "s3://$BUCKET/$OBJECT" recovered.txt

echo "RECOVERED OBJECT CONTENT:"
cat recovered.txt

if grep -q "$ORIGINAL_CONTENT" recovered.txt; then
    echo "RECOVERY SUCCESSFUL"
else
    echo "RECOVERY FAILED"
fi

echo
echo "=========================================="
echo "CHAOS #4 COMPLETED"
echo "=========================================="

echo
echo "Summary:"
echo "Baseline: Original data available"
echo "Chaos: Object overwritten"
echo "Impact: Data corruption"
echo "Recovery: Original data restored"

