#!/bin/bash

echo "======================================"
echo " AWS CHAOS #18 - EC2 NETWORK LOSS"
echo "======================================"

INTERFACE=$(ip route | awk '/default/ {print $5; exit}')
LOSS="50%"
DURATION=60

echo "Target Interface: $INTERFACE"
echo "Packet Loss: $LOSS"
echo "Duration: $DURATION seconds"

echo ""
echo "========== NETWORK BEFORE =========="
ping -c 5 8.8.8.8 || true

echo ""
echo ">>> CHAOS STARTED <<<"

sudo tc qdisc add dev "$INTERFACE" root netem loss "$LOSS"

echo "Injected $LOSS packet loss."
echo ""

echo "========== NETWORK DURING CHAOS =========="
ping -c 10 8.8.8.8 || true

echo ""
echo "Chaos active for remaining duration..."
sleep "$DURATION"

echo ""
echo ">>> RECOVERY STARTED <<<"

sudo tc qdisc del dev "$INTERFACE" root 2>/dev/null || true

echo ""
echo "========== NETWORK AFTER RECOVERY =========="
ping -c 5 8.8.8.8 || true

echo ""
echo "AWS Chaos #18 completed successfully."
