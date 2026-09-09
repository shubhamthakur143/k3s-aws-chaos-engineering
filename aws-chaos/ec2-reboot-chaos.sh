#!/bin/bash

REGION="ap-south-1"
INSTANCE_ID="i-0831547efeffb9a80"

echo "=================================="
echo " AWS EC2 REBOOT CHAOS EXPERIMENT"
echo "=================================="

echo "Target Instance: $INSTANCE_ID"

echo "Before Chaos:"
aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --region $REGION \
  --query 'Reservations[].Instances[].[InstanceId,State.Name]' \
  --output table

echo "Injecting Chaos: Rebooting EC2..."
aws ec2 reboot-instances \
  --instance-ids $INSTANCE_ID \
  --region $REGION

echo "Chaos injected successfully."

echo "Monitoring recovery..."
aws ec2 wait instance-status-ok \
  --instance-ids $INSTANCE_ID \
  --region $REGION

echo "=================================="
echo "RECOVERY SUCCESSFUL"
echo "=================================="
