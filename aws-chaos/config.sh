#!/bin/bash

# AWS Configuration
REGION="ap-south-1"

# EC2 Instances
CHAOS_CONTROLLER_INSTANCE="i-07ab7e303bb280868"
WORKER_INSTANCE_ID="i-0831547efeffb9a80"

# Security Groups
CONTROLLER_SG="sg-08140e425ecb8bd87"
WORKER_SG="sg-0bd500944d5b31de3"

# Worker Details
WORKER_PUBLIC_IP="3.110.171.40"

echo "AWS Chaos Configuration Loaded"
