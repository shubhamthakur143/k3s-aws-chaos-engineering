#!/bin/bash

echo "======================================"
echo " AWS CHAOS #15 - EC2 MEMORY STRESS"
echo "======================================"

DURATION=60
MEMORY_WORKERS=1
MEMORY_SIZE="1G"

echo "Target: EC2 / K3s Node"
echo "Duration: ${DURATION} seconds"
echo "Memory Workers: ${MEMORY_WORKERS}"
echo "Memory Allocation: ${MEMORY_SIZE}"

echo ""
echo "========== MEMORY BEFORE =========="
free -h

echo ""
echo ">>> CHAOS STARTED <<<"

stress-ng \
  --vm ${MEMORY_WORKERS} \
  --vm-bytes ${MEMORY_SIZE} \
  --vm-keep \
  --timeout ${DURATION}s \
  --metrics-brief

echo ""
echo ">>> CHAOS COMPLETED <<<"

echo ""
echo "========== MEMORY AFTER =========="
free -h

echo ""
echo "Recovery: Memory stress stopped automatically."
echo "AWS Chaos #15 completed successfully."

