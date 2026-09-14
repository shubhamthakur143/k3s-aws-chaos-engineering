#!/bin/bash

echo "======================================"
echo " AWS CHAOS #21 - S3 ACCESS FAILURE"
echo "======================================"

REGION="ap-south-1"

# Intentionally invalid bucket name for controlled failure
BUCKET="chaos-nonexistent-bucket-632843870789"

echo ""
echo "========== CHAOS STARTED =========="
echo "Attempting to access unavailable S3 bucket:"
echo "$BUCKET"

echo ""

aws s3 ls "s3://$BUCKET" \
  --region "$REGION" \
  > s3-chaos-response.log 2>&1

EXIT_CODE=$?

echo "========== CHAOS RESULT =========="

if [ $EXIT_CODE -ne 0 ]; then
    echo "S3 access failure successfully simulated."
    echo ""
    cat s3-chaos-response.log
else
    echo "WARNING: Command unexpectedly succeeded."
fi

echo ""
echo "========== RECOVERY =========="
echo "No AWS resource or IAM permission was modified."
echo "No recovery action required."

rm -f s3-chaos-response.log

echo ""
echo "AWS Chaos #21 completed successfully."
