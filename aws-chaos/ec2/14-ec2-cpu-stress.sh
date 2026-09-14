#!/bin/bash

REGION="ap-south-1"
INSTANCE_ID="YOUR_INSTANCE_ID"

echo "======================================"
echo " AWS CHAOS #14 - EC2 CPU STRESS"
echo "======================================"

echo "[INFO] Installing stress-ng and starting CPU stress..."

COMMAND_ID=$(aws ssm send-command \
  --instance-ids "$INSTANCE_ID" \
  --document-name "AWS-RunShellScript" \
  --parameters 'commands=[
    "sudo apt-get update",
    "sudo apt-get install -y stress-ng",
    "stress-ng --cpu 2 --timeout 60s"
  ]' \
  --region "$REGION" \
  --query 'Command.CommandId' \
  --output text)

echo "SSM Command ID: $COMMAND_ID"
echo "CPU stress started for 60 seconds."
echo "Recovery: Automatic after stress-ng completes."
