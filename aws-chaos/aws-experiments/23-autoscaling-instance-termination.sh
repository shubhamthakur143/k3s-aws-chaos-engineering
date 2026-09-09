#!/bin/bash

REGION="ap-south-1"

ASG_NAME="YOUR_AUTO_SCALING_GROUP"

echo "=============================================="
echo " AWS CHAOS #23 - AUTO SCALING INSTANCE FAILURE"
echo "=============================================="

echo "[INFO] Finding instance in ASG..."

INSTANCE_ID=$(aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names "$ASG_NAME" \
  --region "$REGION" \
  --query 'AutoScalingGroups[0].Instances[0].InstanceId' \
  --output text)

echo "Target Instance: $INSTANCE_ID"

echo "[CHAOS] Terminating instance..."

aws ec2 terminate-instances \
  --instance-ids "$INSTANCE_ID" \
  --region "$REGION"

echo ""
echo "[INFO] Instance terminated."
echo "[EXPECTED] Auto Scaling Group should launch a replacement."

sleep 30

echo ""
echo "[INFO] Checking ASG..."

aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names "$ASG_NAME" \
  --region "$REGION" \
  --query 'AutoScalingGroups[0].Instances[].{ID:InstanceId,State:LifecycleState,Health:HealthStatus}' \
  --output table
