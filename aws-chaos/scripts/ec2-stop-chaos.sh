#!/bin/bash
set -e

REGION="ap-south-1"
INSTANCE_ID="i-0831547efeffb9a80"

echo "=========================================="
echo " AWS EC2 STOP CHAOS EXPERIMENT"
echo "=========================================="

echo "[INFO] Target: $INSTANCE_ID"
echo
echo "[INFO] Current instance state:"

aws ec2 describe-instances \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].[InstanceId,State.Name,PrivateIpAddress]' \
  --output table

echo
echo "[CHAOS] Stopping worker EC2..."

aws ec2 stop-instances \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID"

echo
echo "[CHAOS] Stop command sent successfully."
echo "[INFO] Waiting for instance to stop..."

aws ec2 wait instance-stopped \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID"

echo
echo "=========================================="
echo " CHAOS INJECTION COMPLETE"
echo " Worker EC2 is STOPPED"
echo "=========================================="
