#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
EXPERIMENT_DIR="$BASE_DIR/experiments"

echo "=========================================="
echo " AWS LAMBDA CHAOS ENGINEERING"
echo " Master Automation Script"
echo "=========================================="

echo ""
echo "Available Chaos Experiments:"
echo ""
echo "1) Application Error Chaos"
echo "2) Timeout Chaos"
echo "3) Memory Usage Chaos"
echo "4) CPU Stress Chaos"
echo "5) Concurrent Load Chaos"
echo "6) Concurrency Pressure Chaos"
echo "7) Memory Stress / OOM Chaos"
echo "8) Configuration Chaos"
echo "9) Cold Start Experiment"
echo "10) Dependency Failure Chaos"
echo "0) Run ALL Experiments"
echo "q) Quit"

echo ""
read -p "Select an experiment: " CHOICE

run_experiment() {
    local NUMBER=$1
    local SCRIPT=$2

    echo ""
    echo "=========================================="
    echo " Running Chaos #$NUMBER"
    echo "=========================================="

    if [ -f "$EXPERIMENT_DIR/$SCRIPT" ]; then
        bash "$EXPERIMENT_DIR/$SCRIPT"
    else
        echo "[ERROR] Script not found:"
        echo "$EXPERIMENT_DIR/$SCRIPT"
    fi
}

case $CHOICE in

    1)
        run_experiment "1" "01-application-error-chaos.sh"
        ;;

    2)
        run_experiment "2" "02-timeout-chaos.sh"
        ;;

    3)
        run_experiment "3" "03-memory-usage-chaos.sh"
        ;;

    4)
        run_experiment "4" "04-cpu-stress-chaos.sh"
        ;;

    5)
        run_experiment "5" "05-concurrent-load-chaos.sh"
        ;;

    6)
        run_experiment "6" "06-concurrency-pressure-chaos.sh"
        ;;

    7)
        run_experiment "7" "07-memory-stress-chaos.sh"
        ;;

    8)
        run_experiment "8" "08-config-chaos.sh"
        ;;

    9)
        run_experiment "9" "09-cold-start-chaos.sh"
        ;;

    10)
        run_experiment "10" "10-dependency-failure-chaos.sh"
        ;;

    0)
        echo ""
        echo "[WARNING] Running all experiments..."

        for SCRIPT in \
            "01-application-error-chaos.sh" \
            "02-timeout-chaos.sh" \
            "03-memory-usage-chaos.sh" \
            "04-cpu-stress-chaos.sh" \
            "05-concurrent-load-chaos.sh" \
            "06-concurrency-pressure-chaos.sh" \
            "07-memory-stress-chaos.sh" \
            "08-config-chaos.sh" \
            "09-cold-start-chaos.sh" \
            "10-dependency-failure-chaos.sh"
        do
            echo ""
            echo "Running: $SCRIPT"

            if [ -f "$EXPERIMENT_DIR/$SCRIPT" ]; then
                bash "$EXPERIMENT_DIR/$SCRIPT"
            else
                echo "[WARNING] Script not found: $SCRIPT"
            fi

        done
        ;;

    q|Q)
        echo "Exiting Chaos Engineering Suite."
        exit 0
        ;;

    *)
        echo "[ERROR] Invalid option."
        exit 1
        ;;
esac

echo ""
echo "=========================================="
echo " MASTER SCRIPT FINISHED"

echo "=========================================="
