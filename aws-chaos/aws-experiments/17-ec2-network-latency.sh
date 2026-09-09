#!/bin/bash

set -e

echo "======================================"
echo " AWS CHAOS #17 - EC2 NETWORK LATENCY"
echo "======================================"

INTERFACE=$(ip route | awk '/default/ {print $5; exit}')
DELAY="200ms"
DURATION=60

echo "Target Interface: $INTERFACE"
echo "Injected Latency: $DELAY"
echo "Duration: $DURATION seconds"

echo ""
echo "========== NETWORK BEFORE =========="
ping -c 3 8.8.8.8 || true

echo ""
echo ">>> CHAOS STARTED <<<"

sudo tc qdisc add dev "$INTERFACE" root netem delay "$DELAY"

echo ""
echo "Network latency injected successfully."
echo "Waiting for $DURATION seconds..."

sleep "$DURATION"

echo ""
echo ">>> RECOVERY STARTED <<<"

sudo tc qdisc del dev "$INTERFACE" root || true

echo ""
echo "========== NETWORK AFTER RECOVERY =========="
ping -c 3 8.8.8.8 || true

echo ""
echo "AWS Chaos #17 completed successfully."
