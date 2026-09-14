#!/bin/bash

REGION="ap-south-1"

TARGET_GROUP_ARN="YOUR_TARGET_GROUP_ARN"
INSTANCE_ID="YOUR_INSTANCE_ID"

PORT="80"

echo "======================================"
echo " AWS CHAOS #24 - LOAD BALANCER FAILURE"
echo "======================================"

echo "[CHAOS] Deregistering target..."

aws elbv2 deregister-targets \
  --target-group-arn "$TARGET_GROUP_ARN" \
  --targets Id="$INSTANCE_ID",Port="$PORT" \
  --region "$REGION"

echo "[CHAOS] Target removed from Load Balancer."

sleep 60

echo "[RECOVERY] Registering target again..."

aws elbv2 register-targets \
  --target-group-arn "$TARGET_GROUP_ARN" \
  --targets Id="$INSTANCE_ID",Port="$PORT" \
  --region "$REGION"

echo "[RECOVERY] Target registered."

echo ""
echo "[INFO] Checking target health..."

aws elbv2 describe-target-health \
  --target-group-arn "$TARGET_GROUP_ARN" \
  --region "$REGION"
