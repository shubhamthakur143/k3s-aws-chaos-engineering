#!/bin/bash
set -e

REGION="ap-south-1"
INSTANCE_ID="i-0831547efeffb9a80"

echo "=========================================="
echo " AWS EC2 RECOVERY EXPERIMENT"
echo "=========================================="

echo "[RECOVERY] Starting worker EC2..."

aws ec2 start-instances \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID"

echo "[INFO] Waiting for EC2 to enter Running state..."

aws ec2 wait instance-running \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID"

echo "[INFO] EC2 is Running."
echo "[INFO] Waiting for EC2 status checks..."

aws ec2 wait instance-status-ok \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID"

echo
echo "=========================================="
echo " EC2 RECOVERY SUCCESSFUL"
echo "=========================================="

aws ec2 describe-instances \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].[InstanceId,State.Name,PrivateIpAddress]' \
  --output table
