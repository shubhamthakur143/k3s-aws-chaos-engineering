#!/bin/bash

REGION="ap-south-1"

ALARM_NAME="YOUR_CLOUDWATCH_ALARM"

echo "======================================"
echo " AWS CHAOS #25 - CLOUDWATCH ALARM CHAOS"
echo "======================================"

echo "[CHAOS] Setting alarm state to ALARM..."

aws cloudwatch set-alarm-state \
  --alarm-name "$ALARM_NAME" \
  --state-value ALARM \
  --state-reason "Chaos Engineering Test - Simulated Failure" \
  --region "$REGION"

echo "[CHAOS] Alarm state changed to ALARM."

sleep 30

echo "[INFO] Current alarm status:"

aws cloudwatch describe-alarms \
  --alarm-names "$ALARM_NAME" \
  --region "$REGION" \
  --query 'MetricAlarms[].{Alarm:AlarmName,State:StateValue}' \
  --output table
