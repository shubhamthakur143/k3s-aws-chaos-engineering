AWS & K3s Chaos Engineering
│
├── 📌 Project Overview
├── 🎯 Objectives
├── 🏗️ Overall Architecture
│
├── 🐳 K3s Chaos Engineering
│   ├── Cluster Architecture
│   ├── Tools Used
│   ├── Application Architecture
│   ├── 55 Chaos Experiments
│   │   ├── Pod Chaos
│   │   ├── Container Chaos
│   │   ├── Node Chaos
│   │   ├── Network Chaos
│   │   ├── CPU Chaos
│   │   ├── Memory Chaos
│   │   ├── Disk / IO Chaos
│   │   └── Application Chaos
│   ├── Monitoring
│   └── Recovery
│
├── ☁️ AWS Chaos Engineering
│   ├── AWS Architecture
│   ├── Services Used
│   ├── 13 Chaos Experiments
│   │   ├── Lambda Chaos
│   │   ├── EC2 Chaos
│   │   ├── Network Chaos
│   │   └── Serverless Chaos
│   ├── CloudWatch Monitoring
│   └── Recovery
│
├── 🤖 Automation
│   ├── Bash Scripts
│   └── AWS CLI
│
├── 📊 Results
├── 🧠 Key Learnings
├── 🛡️ Safety Principles
└── 🚀 Future Improvements

# AWS & K3s Chaos Engineering

## 📌 Project Overview

This project demonstrates practical Chaos Engineering experiments across two different infrastructure environments:

1. **K3s / Kubernetes-based infrastructure**
2. **AWS Serverless infrastructure using AWS Lambda**

The objective of this project is to intentionally introduce controlled failures, observe system behavior, monitor the impact, and verify recovery mechanisms.

The experiments were performed with a DevOps and reliability engineering mindset, focusing on:

* Fault injection
* System resilience
* Self-healing
* Failure observation
* Monitoring
* Recovery validation
* Automation using Bash and AWS CLI

---

# 🏗️ Architecture

## Part 1: K3s Kubernetes Environment

The Kubernetes environment consists of a K3s cluster running on AWS EC2 instances.

```text
                    AWS EC2 Infrastructure
                           |
          -----------------------------------
          |                                 |
          |                                 |
   Control Plane                       Worker Node
   K3s Server                         K3s Agent
          |                                 |
          -----------------------------------
                           |
                    K3s Kubernetes Cluster
                           |
                ---------------------
                |                   |
             Application          MariaDB
                Pods               Pod
```

### Cluster Nodes

* **Control Plane**
* **Worker Node**

The cluster was monitored using:

```bash
kubectl get nodes
kubectl get pods -o wide
```

---

# 🐳 Part 1: K3s Chaos Engineering

## Objective

The purpose of the Kubernetes chaos experiments was to understand how Kubernetes behaves when infrastructure or application components fail.

The experiments focused on:

* Node failure
* Pod behavior during node failure
* Application recovery
* Container restart behavior
* Replica availability
* Kubernetes self-healing

---

## Application Components

The K3s environment contained:

* `chaos-app`
* MariaDB
* MariaDB Exporter

Example running pods:

```text
chaos-app
chaos-app
chaos-app

mariadb
mariadb-exporter
```

The application was deployed with multiple replicas to improve availability.

---

## Kubernetes Chaos Observation

During the experiment, one Kubernetes node entered the following state:

```text
STATUS: NotReady
```

Example:

```text
NAME               STATUS
ip-172-31-3-20     NotReady
ip-172-31-4-152    Ready
```

At the same time, Kubernetes pods running on the affected node were observed.

```text
chaos-app
mariadb
```

After recovery activity, containers restarted and the system continued operating.

Example:

```text
READY     STATUS      RESTARTS

1/1       Running     1
```

---

## Key Kubernetes Learning

Kubernetes continuously monitors the desired state of the cluster.

The basic self-healing concept is:

```text
Desired State
      |
      v
Kubernetes Controller
      |
      v
Detect Failure
      |
      v
Restart / Reschedule Workload
      |
      v
Restore Desired State
```

Important components involved in reliability include:

* Deployment
* ReplicaSet
* Scheduler
* Kubelet
* Container Runtime
* Node Controller

---

## K3s Chaos Results

| Test Area            | Observation                                    |
| -------------------- | ---------------------------------------------- |
| Node Failure         | Node entered `NotReady` state                  |
| Pod Availability     | Pods continued to be monitored                 |
| Container Failure    | Containers restarted                           |
| Application Recovery | Kubernetes attempted to maintain desired state |
| Replica Management   | ReplicaSet maintained application replicas     |
| MariaDB              | Database pod status was monitored              |

---

# ☁️ Part 2: AWS Lambda Chaos Engineering

## Objective

The second part of the project focuses on Serverless Chaos Engineering using AWS Lambda.

The goal was to intentionally introduce failures into a Lambda function and observe:

* Errors
* Timeouts
* Memory pressure
* CPU pressure
* Concurrent execution
* Throttling behavior
* Configuration failures
* Cold starts
* Dependency failures
* Recovery

---

# 🔧 Technology Stack

* AWS Lambda
* AWS CLI
* Amazon CloudWatch Logs
* IAM
* Python 3.12
* Bash
* Linux
* K3s
* Kubernetes
* AWS EC2

---

# 🏗️ AWS Lambda Architecture

```text
                 AWS CLI / Bash Automation
                           |
                           v
                    AWS Lambda Function
                           |
              -------------------------
              |                       |
              v                       v
        Chaos Injection          Normal Request
              |                       |
              v                       v
         Failure Simulation       Recovery Test
              |
              v
       Amazon CloudWatch Logs
              |
              v
        Observation & Analysis
```

---

# 🔥 Lambda Chaos Experiments

A total of **10 serverless chaos experiments** were created.

---

## 1️⃣ Application Error Chaos

### Objective

Simulate an application-level failure.

### Chaos Action

The Lambda function intentionally raises an exception.

```text
Chaos induced application error
```

### Expected Result

* Lambda invocation returns an error
* CloudWatch logs capture the exception

### Recovery

A normal Lambda invocation is performed.

---

## 2️⃣ Timeout Chaos

### Objective

Simulate a slow-running application.

### Chaos Action

The Lambda function sleeps longer than the configured Lambda timeout.

Example:

```text
Lambda Sleep Time > Lambda Timeout
```

### Observed Result

```text
Sandbox.Timedout
```

Example:

```text
Task timed out after 3.00 seconds
```

### Recovery

The function is invoked normally.

---

## 3️⃣ Memory Usage Chaos

### Objective

Simulate increased memory consumption.

### Chaos Action

The Lambda function creates memory-consuming data.

### Observation

CloudWatch reports:

```text
Memory Size
Max Memory Used
```

### Recovery

A normal invocation verifies that the function continues working.

---

## 4️⃣ CPU Stress Chaos

### Objective

Simulate CPU-intensive processing.

### Chaos Action

The Lambda function performs intensive calculations.

### Observation

The experiment can increase execution duration and potentially trigger a timeout.

Example:

```text
Duration: 10000 ms
Status: timeout
```

### Recovery

Normal invocation is performed after the experiment.

---

## 5️⃣ Concurrent Load Chaos

### Objective

Test Lambda behavior under multiple concurrent requests.

### Chaos Action

Multiple Lambda invocations are generated.

### Observation

CloudWatch logs show multiple Lambda execution requests.

Example:

```text
START RequestId
START RequestId
START RequestId
```

### Learning

AWS Lambda automatically manages multiple execution environments when concurrency increases.

---

## 6️⃣ Throttling / Concurrency Pressure Chaos

### Objective

Investigate Lambda concurrency behavior.

### Observation

The AWS account concurrency settings were checked.

Example:

```text
ConcurrentExecutions
UnreservedConcurrentExecutions
```

The experiment also demonstrated AWS account-level concurrency limitations.

---

## 7️⃣ Memory Stress / Out of Memory Chaos

### Objective

Simulate a severe memory failure.

### Chaos Action

The Lambda function intentionally consumes excessive memory.

### Observed Result

```text
Runtime.OutOfMemory
```

Example:

```text
Runtime exited with error: signal: killed
```

### Recovery

A normal invocation was performed after the failure.

---

## 8️⃣ Configuration Chaos

### Objective

Simulate an application configuration problem.

### Chaos Action

The Lambda function validates an environment configuration.

Example:

```text
APP_MODE
```

An invalid or missing configuration triggers an application error.

### Recovery

The configuration is restored and the Lambda function is invoked again.

---

## 9️⃣ Cold Start Observation

### Objective

Observe AWS Lambda initialization behavior.

### Cold Start

A Lambda cold start occurs when AWS creates a new execution environment.

CloudWatch logs can show:

```text
INIT_START
START
END
REPORT
Init Duration
```

Example observation:

```text
Init Duration: 82.43 ms
```

### Warm Invocation

A reused execution environment may execute without initialization.

```text
START
END
REPORT
```

### Learning

Cold starts can increase the latency of serverless applications.

---

## 🔟 Downstream Dependency Failure

### Objective

Simulate a downstream service failure.

### Chaos Action

The Lambda function intentionally generates a dependency-related exception.

Example:

```text
Chaos induced downstream dependency failure
```

### Observation

The failure is recorded in:

* Lambda invocation response
* CloudWatch Logs

### Recovery

The function is invoked normally to verify successful recovery.

---

# 📊 CloudWatch Monitoring

Amazon CloudWatch Logs was used to observe Lambda execution.

Example command:

```bash
aws logs tail /aws/lambda/chaos-lambda \
  --region ap-south-1 \
  --since 5m
```

CloudWatch automatically receives Lambda execution logs when the Lambda execution role has the required logging permissions.

Important log events include:

```text
INIT_START
START
END
REPORT
ERROR
```

Example metrics observed:

```text
Duration
Billed Duration
Memory Size
Max Memory Used
Init Duration
Status
```

---

# 🤖 Automation

The chaos experiments were automated using Bash scripts.

Project structure:

```text
lambda-chaos/
│
├── lambda_function.py
├── function.zip
├── run-chaos.sh
│
├── experiments/
│   ├── 01-error-chaos.sh
│   ├── 02-timeout-chaos.sh
│   ├── 03-memory-chaos.sh
│   ├── 04-cpu-chaos.sh
│   ├── 05-concurrent-load-chaos.sh
│   ├── 06-throttling-chaos.sh
│   ├── 07-memory-stress-chaos.sh
│   ├── 08-config-chaos.sh
│   ├── 09-cold-start-chaos.sh
│   └── 10-dependency-failure-chaos.sh
│
└── responses/
```

---

# 🚀 Master Chaos Runner

The project includes a master automation script:

```bash
./run-chaos.sh
```

The script provides a menu for selecting chaos experiments.

Example:

```text
1) Application Error Chaos
2) Timeout Chaos
3) Memory Usage Chaos
4) CPU Stress Chaos
5) Concurrent Load Chaos
6) Throttling Chaos
7) Memory Stress / OOM Chaos
8) Configuration Chaos
9) Cold Start Experiment
10) Dependency Failure Chaos
0) Run ALL Experiments
q) Quit
```

---

# 🔄 Chaos Engineering Lifecycle

The experiments follow a structured approach:

```text
Define System
      |
      v
Define Hypothesis
      |
      v
Inject Controlled Failure
      |
      v
Observe System Behavior
      |
      v
Monitor Logs and Metrics
      |
      v
Perform Recovery
      |
      v
Validate System Health
```

---

# 🛠️ Prerequisites

## AWS

* AWS Account
* AWS CLI installed
* AWS CLI configured
* IAM permissions for:

  * AWS Lambda
  * CloudWatch Logs

Verify AWS access:

```bash
aws sts get-caller-identity
```

---

## Kubernetes

* AWS EC2 instances
* K3s installed
* `kubectl` configured

Verify cluster:

```bash
kubectl get nodes
```

Check workloads:

```bash
kubectl get pods -A
```

---

# ▶️ Running Lambda Chaos Experiments

Navigate to the project directory:

```bash
cd ~/aws-chaos/lambda-chaos
```

Run the master automation script:

```bash
./run-chaos.sh
```

Select an experiment from the menu.

---

# 🔍 Useful Monitoring Commands

## Kubernetes

Check nodes:

```bash
kubectl get nodes
```

Check pods:

```bash
kubectl get pods -o wide
```

Watch cluster changes:

```bash
watch kubectl get nodes
```

Check application pods:

```bash
kubectl get pods
```

---

## AWS Lambda

Check Lambda functions:

```bash
aws lambda list-functions \
  --region ap-south-1
```

Check Lambda configuration:

```bash
aws lambda get-function-configuration \
  --function-name chaos-lambda \
  --region ap-south-1
```

View CloudWatch logs:

```bash
aws logs tail /aws/lambda/chaos-lambda \
  --region ap-south-1 \
  --since 10m
```

---

# 🧠 Key Learnings

Through this project, the following concepts were practiced:

### Kubernetes

* K3s cluster management
* Control plane and worker nodes
* Node readiness
* Pod lifecycle
* Container restart behavior
* Replica management
* Kubernetes self-healing

### AWS

* AWS Lambda
* Serverless architecture
* AWS CLI
* IAM roles
* CloudWatch Logs
* Lambda timeout
* Memory configuration
* Lambda concurrency
* Cold starts

### DevOps

* Bash automation
* Failure testing
* Recovery validation
* Monitoring
* Troubleshooting
* Infrastructure resilience

---

# 📈 Results

The experiments demonstrated that modern cloud-native systems provide mechanisms for improving resilience.

## Kubernetes

Kubernetes continuously works toward maintaining the desired state of workloads.

When failures occur, Kubernetes components can detect unhealthy conditions and restart or reschedule workloads depending on the failure scenario.

## AWS Lambda

AWS Lambda isolates function execution environments and provides monitoring through CloudWatch.

The experiments demonstrated several possible serverless failure scenarios:

* Application exceptions
* Timeouts
* Memory failures
* Configuration problems
* High execution load
* Cold starts
* Dependency failures

---

# 🛡️ Important Chaos Engineering Principle

Chaos Engineering should always be performed carefully.

Recommended practices:

* Start with controlled experiments
* Define the expected impact
* Monitor the system continuously
* Avoid production systems without approval
* Define recovery procedures
* Document results
* Automate repeatable experiments

---

# 🚀 Future Improvements

Future versions of this project can include:

* Amazon CloudWatch Metrics dashboards
* CloudWatch Alarms
* SNS notifications
* AWS Fault Injection Service (AWS FIS)
* Prometheus monitoring
* Grafana dashboards
* Kubernetes Chaos Mesh experiments
* LitmusChaos
* CI/CD integration
* GitHub Actions
* Automated chaos reports
* Infrastructure as Code using Terraform

---

# 👨‍💻 Author

**Shubham Thakur**

Aspiring DevOps Engineer

Skills:

* Linux
* AWS
* Docker
* Kubernetes
* K3s
* Git
* GitHub
* Bash
* CloudWatch
* CI/CD

---

# ⭐ Conclusion

This project demonstrates practical Chaos Engineering across both Kubernetes and Serverless environments.

The goal was not simply to create failures, but to understand:

```text
Failure
   ↓
Detection
   ↓
Observation
   ↓
Recovery
   ↓
Resilience
```

The project provides hands-on experience with cloud-native infrastructure, serverless computing, Kubernetes reliability, monitoring, automation, and failure recovery.
