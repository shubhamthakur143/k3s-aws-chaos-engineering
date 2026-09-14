#!/bin/bash

set -e

echo "======================================"
echo " AWS CHAOS #16 - EC2 DISK FULL"
echo "======================================"

CHAOS_FILE="/tmp/chaos-disk-fill.img"
SIZE="2G"

echo ""
echo "========== DISK BEFORE =========="
df -h /

echo ""
echo ">>> CHAOS STARTED <<<"
echo "Creating controlled ${SIZE} disk file..."

fallocate -l ${SIZE} "${CHAOS_FILE}"

echo ""
echo "========== DISK DURING CHAOS =========="
df -h /

echo ""
echo "Chaos active for 30 seconds..."
sleep 30

echo ""
echo ">>> RECOVERY STARTED <<<"
rm -f "${CHAOS_FILE}"

echo ""
echo "========== DISK AFTER RECOVERY =========="
df -h /

echo ""
echo "AWS Chaos #16 completed successfully."
