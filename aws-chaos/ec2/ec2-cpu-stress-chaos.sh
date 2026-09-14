#!/bin/bash

echo "======================================"
echo " AWS CHAOS #14 - EC2 CPU STRESS"
echo "======================================"

DURATION=60
CPU_WORKERS=2

echo "Starting CPU Stress..."
echo "Duration: ${DURATION} seconds"
echo "CPU Workers: ${CPU_WORKERS}"

echo ""
echo "CPU BEFORE:"
uptime

echo ""
echo ">>> CHAOS STARTED <<<"

stress-ng --cpu ${CPU_WORKERS} --timeout ${DURATION}s --metrics-brief

echo ""
echo ">>> CHAOS COMPLETED <<<"

echo ""
echo "CPU AFTER:"
uptime

echo ""
echo "Recovery: CPU stress process automatically stopped."
echo "AWS Chaos #14 completed successfully."
