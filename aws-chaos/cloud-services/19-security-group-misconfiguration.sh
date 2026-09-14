#!/bin/bash

set -e

echo "============================================"
echo " AWS CHAOS #19 - SECURITY GROUP MISCONFIG"
echo "============================================"

REGION="ap-south-1"
SG_ID="sg-0bd500944d5b31de3"

TEST_PORT="8081"
SOURCE_CIDR="10.255.255.0/24"

echo "Security Group: $SG_ID"
echo "Test Port: $TEST_PORT"
echo "Wrong Source CIDR: $SOURCE_CIDR"

echo ""
echo "========== BEFORE =========="
aws ec2 describe-security-groups \
  --group-ids "$SG_ID" \
  --region "$REGION" \
  --query 'SecurityGroups[0].IpPermissions' \
  --output table

echo ""
echo ">>> CHAOS STARTED <<<"
echo "Adding intentionally incorrect test rule..."

aws ec2 authorize-security-group-ingress \
  --group-id "$SG_ID" \
  --protocol tcp \
  --port "$TEST_PORT" \
  --cidr "$SOURCE_CIDR" \
  --region "$REGION"

echo ""
echo "Misconfigured rule added successfully."

echo ""
echo "========== DURING CHAOS =========="
aws ec2 describe-security-groups \
  --group-ids "$SG_ID" \
  --region "$REGION" \
  --query 'SecurityGroups[0].IpPermissions' \
  --output table

echo ""
echo "Chaos active for 30 seconds..."
sleep 30

echo ""
echo ">>> RECOVERY STARTED <<<"

aws ec2 revoke-security-group-ingress \
  --group-id "$SG_ID" \
  --protocol tcp \
  --port "$TEST_PORT" \
  --cidr "$SOURCE_CIDR" \
  --region "$REGION"

echo "Incorrect rule removed successfully."

echo ""
echo "========== AFTER RECOVERY =========="
aws ec2 describe-security-groups \
  --group-ids "$SG_ID" \
  --region "$REGION" \
  --query 'SecurityGroups[0].IpPermissions' \
  --output table

echo ""
echo "AWS Chaos #19 completed successfully."

