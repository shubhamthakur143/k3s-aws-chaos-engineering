#!/bin/bash

NAMESPACE="chaos-lab"
WAIT_TIME=45
START_FROM=19
LOG_FILE="chaos-results.log"

COUNT=0

FILES=$(find . -type f \( -name "*.yaml" -o -name "*.yml" \) \
  ! -name "chaos-75-alerts.yaml" | sort)

for FILE in $FILES
do
    COUNT=$((COUNT+1))

    # Skip experiments before START_FROM
    if [ $COUNT -lt $START_FROM ]; then
        continue
    fi

    echo ""
    echo "========================================" | tee -a $LOG_FILE
    echo "[$COUNT/55] Running: $FILE" | tee -a $LOG_FILE
    echo "========================================" | tee -a $LOG_FILE

    kubectl apply -f "$FILE" | tee -a $LOG_FILE

    echo "Waiting $WAIT_TIME seconds..." | tee -a $LOG_FILE
    sleep $WAIT_TIME

    echo "Pod Status:" | tee -a $LOG_FILE
    kubectl get pods -n $NAMESPACE | tee -a $LOG_FILE

    echo "Completed: $FILE" | tee -a $LOG_FILE

done

echo "========================================"
echo "ALL REMAINING CHAOS EXPERIMENTS COMPLETED"
echo "========================================"
