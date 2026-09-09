hostname
cat /etc/os-release
nproc
free -h
df -h
sudo apt update
sudo apt upgrade -y
sudo apt install -y curl wget git unzip jq
curl --version
git --version
curl -sfL https://get.k3s.io | sh -
sudo kubectl get nodes
sudo kubectl get pods -A
sudo kubectl get nodes
sudo kubectl create namespace chaos-lab
sudo kubectl create deployment nginx --image=nginx:latest -n chaos-lab
sudo kubectl expose deployment nginx --port=80 --target-port=80 --type=ClusterIP -n chaos-lab
sudo kubectl get pods -n chaos-lab
sudo kubectl get svc -n chaos-lab
ubuntu@ip-172-31-4-152:~$ sudo kubectl get pods -n chaos-lab
NAME                    READY   STATUS    RESTARTS   AGE
nginx-6797d5487-q6dzv   1/1     Running   0          55s
ubuntu@ip-172-31-4-152:~$ sudo kubectl get svc -n chaos-lab
NAME    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
nginx   ClusterIP   10.43.107.233   <none>        80/TCP    30s
ubuntu@ip-172-31-4-152:~$
helm version
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack   --namespace monitoring
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm list -A
sudo helm list -A
helm install monitoring prometheus-community/kube-prometheus-stack   --namespace monitoring
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
helm install monitoring prometheus-community/kube-prometheus-stack   --namespace monitoring
sudo helm list -A
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get nodes
helm install monitoring prometheus-community/kube-prometheus-stack   --namespace monitoring
kubectl create namespace monitoring
helm install monitoring prometheus-community/kube-prometheus-stack   --namespace monitoring
kubectl get pods -n monitoring
kubectl get svc -n monitoring
kubectl get secret monitoring-grafana -n monitoring   -o jsonpath="{.data.admin-password}" | base64 -d
echo
kubectl get pod -n monitoring   -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=monitoring"
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
history
kubectl delete deployment nginx -n chaos-lab
kubectl delete service nginx -n chaos-lab
nano chaos-app.yaml
kubectl apply -f chaos-app.yaml
kubectl get all
kubectl get all -n chaos-lab 
kubectl describe pod -n chaos-lab -l app=chaos-app
kubectl get servicemonitors -n monitoring
kubectl get prometheus -n monitoring
kubectl get pods -n monitoring
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
sudo kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
kubectl get pods
kubectl get nodes
kubectl get pods -Aa
kubectl get pods -A
sudo kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
-L 3000:localhost:3000
kubectl scale deployment chaos-app -n chaos-lab --replicas=0
kubectl get deployment chaos-app -n chaos-lab
kubectl get pods -n chaos-lab
helm get values monitoring -n monitoring
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get nodes
helm get values monitoring -n monitoring
kubectl scale deployment chaos-app -n chaos-lab --replicas=2
helm get values monitoring -n monitoring
nano grafana-values.yaml
helm upgrade monitoring prometheus-community/kube-prometheus-stack   -n monitoring   -f grafana-values.yaml
nano grafana-values.yaml
helm upgrade monitoring prometheus-community/kube-prometheus-stack   -n monitoring   -f grafana-values.yaml
kubectl get pods -n monitoring
nano grafana-values.yaml
kubectl get pods -n chaos-lab
kubectl scale deployment chaos-app -n chaos-lab --replicas=0
kubectl get deployment -n chaos-lab
kubectl scale deployment chaos-app -n chaos-lab --replicas=3
sudo kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
nano mariadb.yaml
kubectl apply -f mariadb.yaml
kubectl get pods -n chaos-lab
kubectl get svc -n chaos-lab
kubectl create secret generic mariadb-exporter-secret   -n chaos-lab   --from-literal=DATA_SOURCE_NAME='root:chaos123@(mariadb:3306)/'
nano mariadb-exporter.yaml
kubectl apply -f mariadb-exporter.yaml
kubectl get pods -n chaos-lab
nano mariadb-servicemonitor.yaml
kubectl apply -f mariadb-servicemonitor.yaml
kubectl get servicemonitor -n monitoring
kubectl get pods -n chaos-lab
kubectl logs -n chaos-lab deployment/mariadb-exporter
kubectl delete -f mariadb-exporter.yaml
nano mariadb-exporter.yaml
kubectl apply -f mariadb-exporter.yaml
kubectl get pods -n chaos-lab
kubectl scale deployment mariadb -n chaos-lab --replicas=0
kubectl scale deployment mariadb -n chaos-lab --replicas=1
kubectl get pods -n chaos-lab | grep mariadb
kubectl delete pod -n chaos-lab mariadb-55698757bd-4z65c
kubectl get pods -n chaos-lab | grep mariadb
kubectl get pods -n chaos-lab
kubectl delete pod -n chaos-lab -l app=mariadb
kubectl scale deployment mariadb-exporter -n chaos-lab --replicas=1
kubectl scale deployment mariadb-exporter -n chaos-lab --replicas=0
kubectl scale deployment mariadb-exporter -n chaos-lab --replicas=1
kubectl scale deployment mariadb -n chaos-lab --replicas=0kubectl scale deployment mariadb -n chaos-lab --replicas=0kubectl scale deployment mariadb -n chaos-lab --replicas=0
kubectl scale deployment mariadb -n chaos-lab --replicas=1
kubectl scale deployment chaos-app -n chaos-lab --replicas=0
kubectl scale deployment chaos-app -n chaos-lab --replicas=3
kubectl scale deployment chaos-app -n chaos-lab --replicas=0
kubectl scale deployment chaos-app -n chaos-lab --replicas=3
kubectl scale deployment chaos-app -n chaos-lab --replicas=0
kubectl get pods -n chaos-lab
kubectl delete pod -n chaos-lab <CHAOS-APP-POD-NAME>
kubectl scale deployment chaos-app -n chaos-lab --replicas=3
kubectl delete pod -n chaos-lab <CHAOS-APP-POD-NAME>
kubectl get pods -n chaos-lab
kubectl delete pod -n chaos-lab chaos-app-55f9c87f58-qr8qd
kubectl get deployment chaos-app -n chaos-lab -o jsonpath='{.spec.template.spec.containers[0].image}'
kubectl get deployment chaos-app -n chaos-lab -o yaml > chaos-app-backup.yaml
kubectl edit deployment chaos-app -n chaos-lab
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
ls
kubectl get nodes
sudo kubectl get nodes
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
kubectl get nodes
kubectl get pods -n monitoring
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
kubectl get svc -n monitoring monitoring-grafana
kubectl patch svc monitoring-grafana -n monitoring   -p '{"spec":{"type":"NodePort"}}'
kubectl get svc -n monitoring monitoring-grafana
kubectl get secret -n monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode; echo
kubectl edit deployment chaos-app -n chaos-lab
q
kubectl patch deployment chaos-app -n chaos-lab --type='json' -p='[
  {
    "op": "add",
    "path": "/spec/template/spec/containers/-",
    "value": {
      "name": "memory-stress",
      "image": "polinux/stress",
      "command": [
        "stress",
        "--vm",
        "1",
        "--vm-bytes",
        "100M",
        "--timeout",
        "5m"
      ]
    }
  }
]'
kubectl get pods -n chaos-lab -w
kubectl patch deployment chaos-app -n chaos-lab --type='json' -p='[
  {
    "op": "remove",
    "path": "/spec/template/spec/containers/1"
  }
]'
kubectl get deployment chaos-app -n chaos-lab -o jsonpath='{range .spec.template.spec.containers[*]}{.name}{"\n"}{end}'
kubectl get pods -n chaos-lab
kubectl exec -n chaos-lab chaos-app-55f9c87f58-2zftv -- kill 1
kubectl exec -n chaos-lab chaos-app-55f9c87f58-2zftv -- /bin/sh -c 'kill 1'
kubectl get pods -n chaos-lab -w
helm version
kubectl get ns
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm upgrade --install loki grafana/loki   --namespace monitoring   --set loki.auth_enabled=false
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
sudo helm upgrade --install loki grafana/loki   --namespace monitoring   --set loki.auth_enabled=false
helm list -n monitoring
helm upgrade --install loki grafana/loki   --namespace monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml   --set loki.auth_enabled=false
sudo helm upgrade --install loki grafana/loki   --namespace monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml   --set loki.auth_enabled=false
nano loki-values.yaml
helm upgrade --install loki grafana/loki   --namespace monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml   -f loki-values.yaml
helm upgrade --install loki grafana/loki   --namespace monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml   -f loki-values.yaml   --set loki.useTestSchema=true
kubectl get pods -n monitoring | grep loki
kubectl get pods -n monitoring | grep -i loki
helm status loki -n monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml
kubectl describe pod loki-chunks-cache-0 -n monitoring
kubectl get pods -n monitoring -l app.kubernetes.io/instance=loki
helm uninstall loki -n monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml
kubectl get pods -n monitoring | grep loki
nano loki-values.yaml
helm upgrade --install loki grafana/loki   --namespace monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml   -f loki-values.yaml
kubectl get pods -n monitoring | grep loki
nano loki-values.yaml
helm upgrade --install loki grafana/loki   --namespace monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml   -f loki-values.yaml
cat loki-values.yaml 
nano loki-values.yaml
helm upgrade --install loki grafana/loki   --namespace monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml   -f loki-values.yaml
kubectl get pods -n monitoring | grep loki
helm upgrade --install alloy grafana/alloy   --namespace monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml
kubectl get pods -n monitoring | grep alloy
helm upgrade --install alloy grafana/alloy   --namespace monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml
kubectl get pods -n monitoring | grep alloy
kubectl get configmap -n monitoring | grep alloy
helm get values alloy -n monitoring   --kubeconfig /etc/rancher/k3s/k3s.yaml
kubectl get configmap alloy -n monitoring -o yaml
kubectl logs -n monitoring alloy-hhtns -c alloy --tail=30
kubectl get configmap alloy -n monitoring -o yaml > alloy-config-backup.yaml
kubectl edit configmap alloy -n monitoring
nano alloy-config.yaml
kubectl apply -f alloy-config.yaml
kubectl rollout restart daemonset alloy -n monitoring
kubectl get pods -n monitoring | grep alloy
kubectl logs -n monitoring -l app.kubernetes.io/instance=alloy -c alloy --tail=50
kubectl get pods -n chaos-lab
POD=chaos-app-55f9c87f58-4sfkf
kubectl exec -n chaos-lab $POD -- ps aux
kubectl get deployment chaos-app -n chaos-lab -o jsonpath='{.spec.template.spec.containers[0].image}'; echo
kubectl get deployment chaos-app -n chaos-lab -o yaml > chaos-app-backup.yaml
kubectl get deployment chaos-app -n chaos-lab -o=jsonpath='{.spec.template.spec.containers[*].image}'
kubectl set image deployment/chaos-app nginx=nginx:this-image-does-not-exist -n chaos-lab
kubectl get pods -n chaos-lab -w
kubectl apply -f chaos-app-backup.yaml
kubectl get pods -n chaos-lab -w
kubectl apply -f chaos-app-backup.yaml
kubectl get pods -n chaos-lab -w
kubectl set image deployment/chaos-app nginx=nginx:1.27 -n chaos-lab
kubectl get pods -n chaos-lab -w
kubectl get pods -n chaos-lab
POD=chaos-app-55f9c87f58-2zftv
kubectl delete pod $POD -n chaos-lab
kubectl get pods -n chaos-lab -w
kubectl get nodes
helm version
kubectl get nodes
kubectl top nodes
free -h
nproc
hostname -I
sudo cat /var/lib/rancher/k3s/server/node-token
sudo ss -lntp | grep 6443
sudo systemctl status k3s --no-pager
kubectl get nodes -w
sudo cat /var/lib/rancher/k3s/server/node-token
kubectl get nodes -w
kubectl get nodes
kubectl get pods -A
helm version
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
sudo find /run -name containerd.sock 2>/dev/null
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm repo update
helm search repo chaos-mesh/chaos-mesh --versions | head
sudo find /run -name containerd.sock 2>/dev/null
helm install chaos-mesh chaos-mesh/chaos-mesh   --namespace chaos-mesh   --create-namespace   --set controllerManager.enableFilterNamespace=true   --set chaosDaemon.runtime=containerd   --set chaosDaemon.socketPath=/run/k3s/containerd/containerd.sock
kubectl get nodes
echo $KUBECONFIG
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm ls -A
helm install chaos-mesh chaos-mesh/chaos-mesh   --namespace chaos-mesh   --create-namespace   --set controllerManager.enableFilterNamespace=true   --set chaosDaemon.runtime=containerd   --set chaosDaemon.socketPath=/run/k3s/containerd/containerd.sock
kubectl get pods -n chaos-mesh -w
kubectl get pods -n chaos-mesh -o wide
kubectl get crds | grep chaos-mesh
kubectl get deployments -n chaos-lab --show-labels
kubectl get pods -n chaos-lab --show-labels
mkdir -p ~/chaos-experiments
cd ~/chaos-experiments
nano pod-kill-test.yaml
kubectl apply -f pod-kill-test.yaml
kubectl get pods -n chaos-mesh -o wide
kubectl get svc -n chaos-mesh
kubectl get endpoints -n chaos-mesh
kubectl get endpoints chaos-mesh-controller-manager -n chaos-mesh
kubectl logs -n chaos-mesh deployment/chaos-controller-manager --tail=50
kubectl get deployment -n chaos-mesh
kubectl get endpointslice -n chaos-mesh -l kubernetes.io/service-name=chaos-mesh-controller-manager -o wide
curl -k --connect-timeout 3 https://10.42.0.78:10081
curl -k --connect-timeout 3 https://10.42.1.6:10081
curl -k --connect-timeout 3 https://10.42.1.8:10081
curl -v --connect-timeout 3 http://10.42.0.78:10081
curl -v --connect-timeout 3 http://10.42.1.6:10081
ping -c 3 10.42.1.6
ping -c 3 10.42.1.8
ping -c 3 10.42.1.6
curl -v --connect-timeout 5 http://10.42.1.6:10081
curl -v --connect-timeout 5 http://10.42.1.8:10081
sudo kubectl get nodes -o wide
sudo kubectl get pods -A -o wide
curl -v --connect-timeout 5 http://10.42.1.6:10081
curl -v http://10.42.1.6:10081/
sudo kubectl get pods -n chaos-mesh
sudo kubectl get pods -n chaos-lab --show-labels
nano pod-kill.yaml
sudo kubectl apply -f pod-kill.yaml
nano pod-kill.yaml
sudo kubectl apply -f pod-kill.yaml
sudo kubectl get podchaos -n chaos-lab
sudo kubectl get pods -n chaos-lab -w
sudo kubectl describe podchaos chaos-app-pod-kill -n chaos-lab
sudo kubectl get pods -n chaos-lab --show-labels
sudo kubectl get deployment chaos-app -n chaos-lab --show-labels
sudo kubectl get pod chaos-app-55f9c87f58-4sfkf -n chaos-lab --show-labels
cat pod-kill.yaml
sudo kubectl delete podchaos chaos-app-pod-kill -n chaos-lab
nano pod-kill.yaml 
sudo kubectl apply -f pod-kill.yaml
sudo kubectl get pods -n chaos-lab -w
cat pod-kill.yaml 
sudo kubectl describe podchaos chaos-app-pod-kill -n chaos-lab
sudo kubectl get pods -n chaos-lab -l app=chaos-app\
sudo kubectl get pods -n chaos-lab -l app=chaos-app
sudo kubectl get deployment -n chaos-mesh chaos-controller-manager -o jsonpath='{.spec.template.spec.containers[0].image}'
echo
sudo kubectl get podchaos chaos-app-pod-kill -n chaos-lab -o yaml
sudo kubectl delete podchaos chaos-app-pod-kill -n chaos-lab
ls
cd chaos-experiments/
nano pod-kill.yaml
sudo kubectl apply -f pod-kill.yaml
sudo kubectl get pods -n chaos-lab -w
sudo kubectl logs -n chaos-mesh deployment/chaos-controller-manager --tail=200
sudo kubectl label namespace chaos-lab chaos-mesh.org/enable=true
sudo kubectl get namespace chaos-lab --show-labels
sudo kubectl delete podchaos chaos-app-pod-kill -n chaos-lab
sudo kubectl apply -f pod-kill.yaml
sudo kubectl get pods -n chaos-lab -w
sudo kubectl describe podchaos chaos-app-pod-kill -n chaos-lab
sudo kubectl logs -n chaos-mesh deployment/chaos-controller-manager --tail=50
sudo kubectl get podchaos -n chaos-lab
sudo kubectl get pods -n chaos-lab --show-labels
sudo kubectl get pods -n chaos-lab -l app=chaos-app
chaos-mesh.org/enable=true
sudo kubectl get deployment chaos-controller-manager -n chaos-mesh -o jsonpath='{.spec.template.spec.containers[0].image}'
sudo kubectl get deployment chaos-controller-manager -n chaos-mesh -o yaml | grep -i namespace
sudo kubectl get ns chaos-lab --show-labels
sudo kubectl get deployment chaos-controller-manager -n chaos-mesh -o jsonpath='{range .spec.template.spec.containers[*]}{"CONTAINER: "}{.name}{"\n"}{range .env[*]}{.name}{"="}{.value}{"\n"}{end}{"\n"}{end}'
sudo kubectl get deployment chaos-controller-manager -n chaos-mesh -o yaml | grep -A 5 -B 5 "TARGET_NAMESPACE"
sudo kubectl get deployment chaos-controller-manager -n chaos-mesh -o yaml | grep -A 5 -B 5 "ENABLE_FILTER_NAMESPACE"
sudo kubectl edit deployment chaos-controller-manager -n chaos-mesh
sudo kubectl set env deployment/chaos-controller-manager -n chaos-mesh ENABLE_FILTER_NAMESPACE=false
sudo kubectl rollout status deployment/chaos-controller-manager -n chaos-mesh
sudo kubectl get deployment chaos-controller-manager -n chaos-mesh -o jsonpath='{.spec.template.spec.containers[0].env[?(@.name=="ENABLE_FILTER_NAMESPACE")].value}'
sudo kubectl delete podchaos chaos-app-pod-kill -n chaos-lab
sudo kubectl apply -f pod-kill.yaml
ls
cd chaos-experiments/
sudo kubectl apply -f pod-kill.yaml
sudo kubectl describe podchaos chaos-app-pod-kill -n chaos-lab
sudo kubectl get pods -n chaos-lab -w
kubectl get pods -A | grep -E "prometheus|alertmanager"
nano pod-failure.yaml
sudo kubectl apply -f pod-failure.yaml
sudo kubectl get pods -n chaos-lab -w
sudo kubectl describe podchaos chaos-app-pod-failure -n chaos-lab
nano container-kill.yaml
sudo kubectl get pod $(sudo kubectl get pod -n chaos-lab -l app=chaos-app -o jsonpath='{.items[0].metadata.name}') -n chaos-lab -o jsonpath='{.spec.containers[*].name}'
nano contanetwork-delay.yaml
nano network-loss.yaml
ls
mkdir -p batch-1
cd batch-1
nano pod-kill.yaml
nano pod-failure.yaml
nano container-kill.yaml
nano network-delay.yaml
nano network-loss.yaml
nano network-duplicate.yaml
nano network-corrupt.yaml
nano cpu-stress.yaml
nano memory-stress.yaml
nano network-partition.yaml
ls
cd
cd chaos-experiments/
ls
rm container-kill.yaml contanetwork-delay.yaml network-loss.yaml pod-failure.yaml pod-failure.yaml 
ls
rm pod-kill-test.yaml pod-kill.yaml 
ls
cd batch-1/
ls
sudo kubectl get prometheus -n monitoring
sudo kubectl get prometheusrule -A
sudo kubectl get alertmanager -n monitoring
sudo kubectl get pods -n monitoring
sudo kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090
ls
cd chaos-experiments/
ls
cd batch-1/
curl -s http://localhost:9090/api/v1/query --data-urlencode 'query=kube_pod_status_ready{namespace="chaos-lab"}'
curl -s http://localhost:9090/api/v1/query --data-urlencode 'query=kube_pod_container_status_restarts_total{namespace="chaos-lab"}'
curl -s http://localhost:9090/api/v1/query --data-urlencode 'query=container_cpu_usage_seconds_total{namespace="chaos-lab"}'
curl -s http://localhost:9090/api/v1/query --data-urlencode 'query=container_memory_working_set_bytes{namespace="chaos-lab"}'
kubectl get pods -n chaos-lab
kubectl get deployments -n chaos-lab
kubectl get pods -n chaos-lab -o wide
kubectl delete pod chaos-app-55f9c87f58-ztcns -n chaos-lab
kubectl get pods -n chaos-lab -w
kubectl get pods -n chaos-lab
curl -s http://localhost:9090/api/v1/query --data-urlencode 'query=kube_pod_status_ready{namespace="chaos-lab",condition="true"}'
curl -s http://localhost:9090/api/v1/query --data-urlencode 'query=kube_pod_container_status_restarts_total{namespace="chaos-lab"}'
kubectl get crd | grep prometheusrule
kubectl get prometheusrule -A
nano batch-1-alerts.yaml
kubectl apply -f batch-1-alerts.yaml
kubectl get prometheusrule -n monitoring
curl -s http://localhost:9090/api/v1/rules | grep -E "ChaosAppPodNotReady|ChaosAppHighRestarts|ChaosAppHighMemory"
kubectl get svc -n monitoring | grep grafana
ls
nano batch-1-alerts.yaml 
kubectl apply -f batch-1-alerts.yaml
kubectl get prometheusrule -n monitoring
kubectl get svc -n monitoring | grep alertmanager
kubectl get secret -n monitoring | grep alertmanager
kubectl get alertmanagerconfig -n monitoring
kubectl get prometheusrule -n monitoring
kubectl get secret alertmanager-monitoring-kube-prometheus-alertmanager-generated -n monitoring -o yaml
kubectl get alertmanager monitoring-kube-prometheus-alertmanager -n monitoring -o yaml | grep -A 15 alertmanagerConfig
kubectl create secret generic chaos-email-secret -n monitoring --from-literal=username=shubhamthakur0580@gmail.com --from-literal=password=ltojgaqgqdjgobpe
nano batch1-alertmanager-config.yaml
kubectl apply -f batch1-alertmanager-config.yaml
kubectl explain alertmanagerconfig.spec.receivers.emailConfigs.authUsername
kubectl explain alertmanagerconfig.spec.receivers.emailConfigs.authPassword
nano batch1-alertmanager-config.yaml
kubectl apply -f batch1-alertmanager-config.yaml
kubectl get alertmanagerconfig -n monitoring
kubectl describe alertmanagerconfig batch1-email-alerts -n monitoring
kubectl get prometheusrule batch-1-chaos-alerts -n monitoring -o yaml | grep -A 5 "alert:"
kubectl get alertmanager monitoring-kube-prometheus-alertmanager -n monitoring -o yaml | grep -A5 alertmanagerConfig
kubectl logs -n monitoring alertmanager-monitoring-kube-prometheus-alertmanager-0 --tail=50
kubectl get pods -n monitoring | grep alertmanager
kubectl get prometheusrule batch-1-chaos-alerts -n monitoring -o yaml
curl -s http://localhost:9090/api/v1/alerts
kubectl delete pod -n chaos-lab chaos-app-55f9c87f58-zs9dm
kubectl get pods -n chaos-lab -w
curl -s http://localhost:9090/api/v1/alerts
curl -s http://localhost:9090/api/v1/alerts | grep -i Chaos
curl -s http://localhost:9090/api/v1/rules | grep -o '"name":"Chaos[^"]*"' | sort -u
curl -s http://localhost:9090/api/v1/rules | grep -o '"name":"Maria[^"]*"' | sort -u
kubectl get prometheusrule batch-1-chaos-alerts -n monitoring -o yaml | grep -A5 "labels:"
nano batch-1-chaos-alerts.yaml
ls
nano batch-1-alerts.yaml
kubectl apply -f batch-1-chaos-alerts.yaml
kubectl apply -f batch-1-alerts.yaml
kubectl get prometheusrule batch-1-chaos-alerts -n monitoring -o yaml | grep "alert_group"
kubectl get pods -n chaos-lab
cat pod-kill.yaml
kubectl apply -f pod-kill.yaml
kubectl get podchaos -n chaos-lab
kubectl get pods -n chaos-lab -w
ls
kubectl describe podchaos chaos-app-pod-kill -n chaos-lab
kubectl get podchaos chaos-app-pod-kill -n chaos-lab -o yaml
kubectl delete -f pod-kill.yaml
kubectl get podchaos -n chaos-lab
kubectl get pods -n chaos-lab -w
curl -s http://localhost:9093/api/v2/status | jq
curl -s http://localhost:9093/api/v2/alerts | jq
cd ~/chaos-experiments/batch-1
nano batch1-alertmanager-config.yaml
kubectl apply -f batch1-alertmanager-config.yaml
kubectl delete alertmanagerconfig batch1-email-alerts -n monitoring
kubectl create secret generic chaos-email-secret -n chaos-lab --from-literal=password='YOUR_16_DIGIT_GMAIL_APP_PASSWORD'
kubectl create secret generic chaos-email-secret -n chaos-lab --from-literal=password=ltojgaqgqdjgobpe
kubectl delete secret generic chaos-email-secret -n chaos-lab --from-literal=password='YOUR_16_DIGIT_GMAIL_APP_PASSWORD'
kubectl delete secret chaos-email-secret -n chaos-lab
kubectl create secret generic chaos-email-secret -n chaos-lab --from-literal=password=ltojgaqgqdjgobpe
kubectl get secret chaos-email-secret -n chaos-lab
kubectl get alertmanagerconfig -A
nano batch1-alertmanager-config.yaml
kubectl apply -f batch1-alertmanager-config.yaml
kubectl get alertmanagerconfig -A
curl -s http://localhost:9093/api/v2/status | jq '.config.original'
curl -s http://localhost:9090/api/v1/alerts | jq -r '.data.alerts[] | select(.labels.alert_group=="batch1") | "\(.labels.alertname) - \(.state)"'
curl -s http://localhost:9093/api/v2/alerts | jq -r '.[] | select(.labels.alert_group=="batch1") | "\(.labels.alertname) | Receiver: \(.receivers[].name)"'
cd ~/chaos-experiments/batch-1
kubectl apply -f pod-failure.yaml
kubectl apply -f container-kill.yaml
kubectl apply -f memory-stress.yaml
kubectl apply -f cpu-stress.yaml
kubectl apply -f network-delay.yaml
kubectl apply -f network-loss.yaml
kubectl apply -f network-duplicate.yaml
kubectl apply -f network-corrupt.yaml
kubectl apply -f network-partition.yaml
kubectl get podchaos,stresschaos,networkchaos -n chaos-lab
curl -s http://localhost:9090/api/v1/alerts | jq -r '.data.alerts[] | select(.labels.alert_group=="batch1") | "\(.labels.alertname) - \(.state)"'
curl -s http://localhost:9093/api/v2/alerts | jq -r '.[] | select(.labels.alert_group=="batch1") | "\(.labels.alertname) | Receiver: \(.receivers[].name)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] |
select(.labels.alert_group=="batch1") |
"\(.name) - \(.state)"'
cd ~/chaos-experiments/batch-1
kubectl apply -f pod-kill.yaml
kubectl get pods -n chaos-lab -w
Last login: Tue Sep  8 06:53:18 2026 from 13.233.177.3
ubuntu@ip-172-31-4-152:~$ cd ~/chaos-experiments/batch-1
kubectl apply -f pod-kill.yaml
podchaos.chaos-mesh.org/chaos-app-pod-kill created
ubuntu@ip-172-31-4-152:~/chaos-experiments/batch-1$ kubectl get pods -n chaos-lab -w
NAME                               READY   STATUS    RESTARTS       AGE
chaos-app-55f9c87f58-7nxhl         1/1     Running   0              25s
chaos-app-55f9c87f58-kn6j2         1/1     Running   0              24m
chaos-app-55f9c87f58-rmrk4         1/1     Running   3 (126m ago)   139m
mariadb-55698757bd-cjcqw           1/1     Running   1 (37h ago)    38h
mariadb-exporter-656cb5c7f-nv47z   1/1     Running   1 (37h ago)    38h
kubectl describe podchaos chaos-app-pod-kill -n chaos-lab
curl -s http://localhost:9090/api/v1/alerts | jq -r '.data.alerts[] | select(.labels.alert_group=="batch1") | "\(.labels.alertname) - \(.state)"'
curl -s http://localhost:9090/api/v1/rules | jq -r '.data.groups[].rules[] | select(.labels.alert_group=="batch1") | "\(.name) - \(.state)"'
kubectl scale deployment chaos-app -n chaos-lab --replicas=0
kubectl get pods -n chaos-lab
curl -s http://localhost:9090/api/v1/alerts | jq -r '.data.alerts[] | select(.labels.alert_group=="batch1") | "\(.labels.alertname) - \(.state)"'
kubectl logs -n monitoring alertmanager-monitoring-kube-prometheus-alertmanager-0 --since=5m | tail -50
kubectl logs -n monitoring alertmanager-monitoring-kube-prometheus-alertmanager-0 --since=5m | grep -iE "email|smtp|error|notify"
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-alertmanager 9093:9093
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-alertmanager 9093:9093
curl -s http://localhost:9090/api/v1/alerts | grep -i -E "ChaosApp|MariaDB"
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090
kubectl port-forward -n chaos-mesh svc/chaos-dashboard 2333:2333
kubectl get ingress -A
kubectl get svc -A
kubectl get svc -n chaos-app
kubectl get svc -n chaos
kubectl get svc -n chsched
kubectl create serviceaccount chaos-dashboard-admin -n chaos-mesh
kubectl create clusterrolebinding chaos-dashboard-admin   --clusterrole=cluster-admin   --serviceaccount=chaos-mesh:chaos-dashboard-admin
kubectl create token chaos-dashboard-admin -n chaos-mesh
kubectl get all -l app.kubernetes.io/instance=chaos-mesh
kubectl get all -l app.kubernetes.io/instance=chaos-mesh -n chaos-mesh 
[200~kubectl port-forward -n monitoring \
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-alertmanager 9093:9093
kubectl get pods -A
kubectl get crd | grep chaos-mesh
kubectl get pods -n chaos-mesh
helm list -n chaos-mesh
kubectl scale deployment chaos-app -n chaos-lab --replicas=3
kubectl get pods -n chaos-lab
kubectl get pods -n monitoring
kubectl get pods -n chaos-mesh
kubectl get deployments -A
cd ~/chaos-experiments/batch-1
nano batch1-webhook-alerts.yaml
kubectl apply -f batch1-webhook-alerts.yaml
kubectl get alertmanagerconfig -n chaos-lab
curl -s http://localhost:9093/api/v2/status | jq '.config.original'
kubectl delete alertmanagerconfig batch1-email-alerts -n chaos-lab
kubectl get alertmanagerconfig -A
kubectl get alertmanagerconfig -n chaos-lab
mkdir -p ~/chaos-experiments/batch-2/{pod,stress,network,time,dns,http,io,jvm}
cd ~/chaos-experiments/batch-2
cd ~/chaos-experiments/batch-2/pod
nano chaos-app-pod-kill-01.yaml
ls
kubectl apply -f chaos-app-pod-kill-01.yaml
cp chaos-app-pod-kill-01.yaml chaos-app-pod-failure-01.yaml
nano chaos-app-pod-failure-01.yaml
kubectl apply -f chaos-app-pod-failure-01.yaml
ls
kubectl get alertmanagerconfig -n chaos-lab
cd ~/chaos-experiments/batch-2/stress
nano chaos-app-cpu-stress-01.yaml
kubectl apply -f chaos-app-cpu-stress-01.yaml
nano chaos-app-memory-stress-01.yaml
kubectl apply -f chaos-app-memory-stress-01.yaml
kubectl get podchaos -n chaos-lab
kubectl describe podchaos chaos-app-pod-kill-01 -n chaos-lab
ls
cd ~/chaos-experiments
mv batch-1 batch-1-old
mv batch-2 batch-2-old
cd ~/chaos-experiments
unzip chaos-75-yaml.zip
cd ~/chaos-experiments
mkdir -p chaos-75/{pod,network,stress,cpu,memory,database,dns,http,time,io,jvm}
cd chaos-75
pwd
pwd && ls -la
cd ~/chaos-experiments/chaos-75/pod
nano chaos-app-pod-kill-one.yaml
nano chaos-app-pod-kill-all.yaml
nano chaos-app-pod-failure-one.yaml
nano chaos-app-pod-failure-all.yaml
kubectl get pod -n chaos-lab -l app=chaos-app -o jsonpath='{.items[0].spec.containers[*].name}'
nano chaos-app-container-kill-one.yaml
nano chaos-app-container-kill-all.yaml
ls
cd ~/chaos-experiments/chaos-75/cpu
nano chaos-app-cpu-stress-one-low.yaml
nano chaos-app-cpu-stress-one-medium.yaml
nano chaos-app-cpu-stress-one-high.yaml
nano chaos-app-cpu-stress-all-low.yaml
nano chaos-app-cpu-stress-all-medium.yaml
nano chaos-app-cpu-stress-all-high.yaml
cd ~/chaos-experiments/chaos-75/memory
nano chaos-app-memory-stress-one.yaml
nano chaos-app-memory-stress-all.yaml
nano chaos-app-memory-high-one.yaml
nano chaos-app-memory-high-all.yaml
nano chaos-app-memory-worker-one.yaml
nano chaos-app-memory-worker-all.yaml
cd ~/chaos-experiments/chaos-75/network
nano chaos-app-network-delay-one.yaml
nano chaos-app-network-delay-all.yaml
nano chaos-app-network-loss-one.yaml
nano chaos-app-network-loss-all.yaml
nano chaos-app-network-duplicate-one.yaml
nano chaos-app-network-duplicate-all.yaml
nano chaos-app-network-corrupt-one.yaml
nano chaos-app-network-corrupt-all.yaml
nano chaos-app-network-partition-one.yaml
nano chaos-app-network-partition-all.yaml
cd ~/chaos-experiments/chaos-75/network
ls -1
cat *.yaml
kubectl get pods -n chaos-lab --show-labels
cd ~/chaos-experiments/chaos-75/network
for file in *.yaml; do   echo "Checking: $file";   kubectl apply --dry-run=server -f "$file"; done
kubectl get pods -n chaos-lab --show-labels | grep mariadb
cd ~/chaos-experiments/chaos-75/database
mariadb-pod-kill-one.yaml
nano mariadb-pod-kill-one.yaml
nano mariadb-pod-failure-one.yaml
nano mariadb-network-delay.yaml
nano mariadb-network-loss.yaml
nano mariadb-cpu-stress.yaml
cd ~/chaos-experiments/chaos-75/database
for file in *.yaml; do   echo "Checking: $file";   kubectl apply --dry-run=server -f "$file"; done
cd ~/chaos-experiments/chaos-75/time
nano chaos-app-time-offset-forward-one.yaml
nano chaos-app-time-offset-forward-all.yaml
nano chaos-app-time-offset-backward-one.yaml
nano chaos-app-time-offset-backward-all.yaml
for file in *.yaml; do   echo "Checking: $file";   kubectl apply --dry-run=server -f "$file"; done
cd ~/chaos-experiments/chaos-75/dns
nano chaos-app-dns-error-one.yaml
nano chaos-app-dns-error-all.yaml
nano chaos-app-dns-random-one.yaml
nano chaos-app-dns-random-all.yaml
for file in *.yaml; do   echo "Checking: $file";   kubectl apply --dry-run=server -f "$file"; done
nano chaos-app-http-abort-one.yaml
nano chaos-app-http-abort-all.yaml
nano chaos-app-http-delay-one.yaml
nano chaos-app-http-delay-all.yaml
for file in *.yaml; do   echo "Checking: $file";   kubectl apply --dry-run=server -f "$file"; done
cd ~/chaos-experiments/chaos-75/io
kubectl get pod -n chaos-lab -l app=chaos-app -o name | head -1
POD=$(kubectl get pod -n chaos-lab -l app=chaos-app -o jsonpath='{.items[0].metadata.name}')
kubectl exec -n chaos-lab $POD -- ls -la /
kubectl get deployment chaos-app -n chaos-lab -o yaml | grep -A20 -B5 volumeMounts
kubectl get deployment chaos-app -n chaos-lab -o yaml | grep -A20 "volumes:"
kubectl exec -n chaos-lab $POD -- ls -la /usr/share/nginx/html
kubectl patch deployment chaos-app -n chaos-lab --type='json' -p='[
  {
    "op": "add",
    "path": "/spec/template/spec/containers/0/volumeMounts",
    "value": [
      {
        "name": "chaos-data",
        "mountPath": "/data"
      }
    ]
  },
  {
    "op": "add",
    "path": "/spec/template/spec/volumes",
    "value": [
      {
        "name": "chaos-data",
        "emptyDir": {}
      }
    ]
  }
]'
kubectl rollout status deployment/chaos-app -n chaos-lab
kubectl exec -n chaos-lab $(kubectl get pod -n chaos-lab -l app=chaos-app -o jsonpath='{.items[0].metadata.name}') -- sh -c 'mount | grep /data; ls -ld /data'
nano chaos-app-io-fault-one.yaml
nano chaos-app-io-fault-all.yaml
nano chaos-app-io-latency-one.yaml
nano chaos-app-io-latency-all.yaml
for file in *.yaml; do   echo "Checking: $file";   kubectl apply --dry-run=server -f "$file"; done
cd ~/chaos-experiments/chaos-75/stress
nano chaos-app-stress-one-low.yaml
nano chaos-app-stress-one-medium.yaml
nano chaos-app-stress-one-high.yaml
nano chaos-app-stress-all-low.yaml
nano chaos-app-stress-all-medium.yaml
nano chaos-app-stress-all-high.yaml
cd ~/chaos-experiments/chaos-75/stress
for file in *.yaml; do   echo "Checking: $file";   kubectl apply --dry-run=server -f "$file"; done
kubectl get pods -n chaos-mesh
kubectl logs -n chaos-mesh deployment/chaos-controller-manager --tail=50
kubectl get svc -n chaos-mesh
kubectl get podchaos,stresschaos,networkchaos -n chaos-lab
kubectl describe podchaos chaos-app-pod-kill-01 -n chaos-lab
kubectl delete podchaos chaos-app-pod-kill-01 -n chaos-lab
kubectl get podchaos,stresschaos,networkchaos -n chaos-lab
kubectl -n chaos-mesh create token chaos-dashboard
kubectl get serviceaccount -n chaos-mesh
kubectl -n chaos-mesh create token chaos-dashboard
kubectl api-resources | grep -i chaos
kubectl get crd | grep chaos-mesh.org
cd ~/chaos-experiments/chaos-75
nano chaos-75-alerts.yaml
kubectl apply -f chaos-75-alerts.yaml
kubectl get prometheusrule -A
kubectl get prometheusrule -n monitoring
kubectl get prometheusrule -n monitoring -o yaml | grep "alert:"
kubectl get pods -n monitoring
kubectl get pods -n monitoring | grep prometheus
kubectl get prometheusrule chaos-75-alerts -n monitoring -o yaml
kubectl describe prometheusrule chaos-75-alerts -n monitoring
kubectl get pods -n chaos-lab
kubectl get pods -n chaos-lab -l app=chaos-app
kubectl get deployment chaos-app -n chaos-lab
kubectl get podchaos -n chaos-lab
kubectl get podchaos -n chaos-lab -o wide
kubectl delete podchaos --all -n chaos-lab
kubectl get podchaos -n chaos-lab
kubectl get deployment,pods -n chaos-lab
kubectl delete podchaos,stresschaos,networkchaos,iochaos,dnschaos,httpchaos,timechaos --all -n chaos-lab --ignore-not-found
cd ~/chaos-experiments/chaos-75
find . -type f \( -name "*.yaml" -o -name "*.yml" \) | sort
find . -type f \( -name "*.yaml" -o -name "*.yml" \) | wc -l
cd ~/chaos-experiments/chaos-75
nano run-chaos-55.sh
chmod +x run-chaos-55.sh
find . -type f -name "*.yaml" ! -name "chaos-75-alerts.yaml" | wc -l
cd ~/chaos-experiments/chaos-75
nano run-all-chaos.sh
rm run-chaos-55.sh 
chmod +x run-all-chaos.sh
./run-all-chaos.sh
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090
kubectl port-forward -n monitoring prometheus-monitoring-kube-prometheus-prometheus-0 9090:9090
kubectl port-forward --address 0.0.0.0 -n monitoring prometheus-monitoring-kube-prometheus-prometheus-0 9090:9090
ps aux | grep chaos
kubectl get podchaos,stresschaos,networkchaos,dnschaos,httpchaos,iochaos,timechaos -n chaos-lab
cd ~/chaos-experiments/chaos-75
nano run-all-chaos.sh
chmod +x run-all-chaos.sh
./run-all-chaos.sh
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl -n chaos-mesh create token chaos-dashboard-sa --duration=24h
kubectl get sa -n chaos-mesh
kubectl -n chaos-mesh create token chaos-dashboard-admin --duration=24h
kubectl create secret generic discord-webhook   -n monitoring   --from-literal=webhook-url=kubectl create secret generic discord-webhook   -n monitoring   --from-literal=webhook-url=https://discord.com/api/webhooks/1546860857777197126/uGGkXe-OgabAH3VyP2GlDZ0Rt_2hsrQ5fn77hWSbhdVmGP153T20E08rF_LTI8Uk0ukD
kubectl create secret generic discord-webhook   --namespace=monitoring   --from-literal=webhook-url='https://discord.com/api/webhooks/1546860857777197126/uGGkXe-OgabAH3VyP2GlDZ0Rt_2hsrQ5fn77hWSbhdVmGP153T20E08rF_LTI8Uk0ukD'
kubectl get secret discord-webhook -n monitoring
kubectl get alertmanager -n monitoring
kubectl get secret -n monitoring | grep alertmanager
kubectl get alertmanagerconfig -A
helm list -n monitoring
echo $KUBECONFIG
kubectl config current-context
aws eks list-clusters --region ap-south-1
kubectl get nodes
helm list -n monitoring
sudo helm list -n monitoring
cd chaos-experiments/
sudo helm list -n monitoring
echo $KUBECONFIG
kubectl config view --minify
sudo ls -l /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm list -n monitoring
helm get values monitoring -n monitoring
kubectl get alertmanagerconfig -A
kubectl get alertmanagerconfig batch1-webhook-alerts   -n chaos-lab -o yaml
kubectl get pods -A
mkdir -p ~/chaos-experiments/discord-relay
cd ~/chaos-experiments/discord-relay
kubectl get alertmanager monitoring-kube-prometheus-alertmanager   -n monitoring -o yaml | grep -A 10 -E "alertmanagerConfigSelector|alertmanagerConfigNamespaceSelector"
kubectl get svc -n monitoring | grep alertmanager
nano discord-relay.yaml
kubectl apply -f discord-relay.yaml
kubectl get pods -n monitoring | grep discord
kubectl get svc discord-relay -n monitoring
kubectl logs -n monitoring -l app=discord-relay --tail=20
kubectl run test-curl --rm -it   --image=curlimages/curl   -n monitoring   -- curl -X POST   http://discord-relay.monitoring.svc.cluster.local:8080/alert   -H "Content-Type: application/json"   -d '{
    "alerts": [
      {
        "status": "firing",
        "labels": {
          "alertname": "TestChaosAlert",
          "severity": "critical"
        },
        "annotations": {
          "summary": "Test alert from Chaos project",
          "description": "Testing Discord integration"
        }
      }
    ]
  }'
kubectl get alertmanagerconfig batch1-webhook-alerts -n chaos-lab -o yaml
kubectl edit alertmanagerconfig batch1-webhook-alerts -n chaos-lab
nano discord-alertmanager.yaml
kubectl apply -f discord-alertmanager.yaml
kubectl get alertmanagerconfig batch1-webhook-alerts -n chaos-lab -o yaml
kubectl get alertmanagerconfig batch1-webhook-alerts -n chaos-lab
kubectl logs -n monitoring -l app=discord-relay -f
kubectl run test-alert   -n chaos-lab   --image=busybox   --restart=Never   -- sh -c "sleep 300"
kubectl delete pod -n chaos-lab   $(kubectl get pods -n chaos-lab -l app=chaos-app -o jsonpath='{.items[0].metadata.name}')
kubectl logs -n monitoring -l app=discord-relay -f
kubectl get pods -n chaos-lab
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl port-forward --address 0.0.0.0 -n monitoring svc/monitoring-kube-prometheus-alertmanager 9093:9093
cd chaos-experiments/
ls
cd chaos-75/
ls
kubectl -n chaos-mesh create token chaos-dashboard-admin --duration=24h
cat run-all-chaos.sh 
kubectl get prometheusrule -n chaos-lab
kubectl get prometheusrule chaos-75-alerts -n monitoring
kubectl get prometheusrule -n monitoring
kubectl get prometheusrule chaos-75-alerts -n monitoring -o yaml
kubectl get secret monitoring-grafana -n monitoring -o jsonpath="{.data.admin-user}" | base64 --decode
echo
kubectl get secret monitoring-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode
echo
curl http://localhost:9093/-/ready
kubectl delete pod -n chaos-lab chaos-app-7658f8df59-r7bn7 chaos-app-7658f8df59-grfnp
kubectl get pods -n chaos-lab -w
kubectl get podchaos -A
kubectl get networkchaos -A
kubectl get stresschaos -A
kubectl get iochaos -A
kubectl get podchaos -n chaos-lab -o yaml | grep -E "name:|phase:"
kubectl get networkchaos -n chaos-lab -o yaml | grep -E "name:|phase:"
kubectl get stresschaos -n chaos-lab -o yaml | grep -E "name:|phase:"
kubectl get iochaos -n chaos-lab -o yaml | grep -E "name:|phase:"
kubectl get stresschaos chaos-app-cpu-stress-one-low -n chaos-lab -o yaml
kubectl get podchaos -n chaos-lab -o yaml | grep -E "name:|operation: Apply|operation: Recover|type: Succeeded|type: Failed"
kubectl get networkchaos -n chaos-lab -o yaml | grep -E "name:|operation: Apply|operation: Recover|type: Succeeded|type: Failed"
kubectl get stresschaos -n chaos-lab -o yaml | grep -E "name:|operation: Apply|operation: Recover|type: Succeeded|type: Failed"
kubectl get iochaos -n chaos-lab -o yaml | grep -E "name:|operation: Apply|operation: Recover|type: Succeeded|type: Failed"
kubectl get stresschaos chaos-app-memory-high-all -n chaos-lab -o yaml
kubectl describe stresschaos chaos-app-memory-high-all -n chaos-lab
kubectl describe stresschaos chaos-app-memory-high-one -n chaos-lab
kubectl describe iochaos chaos-app-io-fault-all -n chaos-lab
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get pods -n chaos-lab
kubectl get pods -n chaos-mesh
kubectl get pods -n chaos-mesh -o wide
kubectl describe stresschaos chaos-app-memory-stress-one -n chaos-lab
kubectl get stresschaos chaos-app-memory-stress-one -n chaos-lab -o yaml
kubectl delete stresschaos chaos-app-memory-stress-one -n chaos-lab
kubectl get pods -n chaos-lab -l app=chaos-app -o wide
nano memory-chaos-test.yaml
kubectl apply -f memory-chaos-test.yaml
kubectl describe stresschaos memory-chaos-test -n chaos-lab
kubectl get stresschaos memory-chaos-test -n chaos-lab -o yaml
kubectl get podchaos -n chaos-lab
kubectl get networkchaos -n chaos-lab
kubectl get stresschaos -n chaos-lab
kubectl get iochaos -n chaos-lab
for kind in podchaos networkchaos stresschaos iochaos; do   echo "========== $kind ==========";   kubectl get $kind -n chaos-lab -o yaml |   grep -E "chaos_name:|name:|operation: Apply|operation: Recover|type: Succeeded|type: Failed"; done
kubectl get stresschaos -n chaos-lab -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{range .status.experiment.containerRecords[*].events[*]}{.operation}:{.type}{" "}{end}{"\n"}{end}'
kubectl get pods -n chaos-lab -l app=chaos-app -o wide
cat > memory-high-one-new.yaml <<'EOF'
apiVersion: chaos-mesh.org/v1alpha1
kind: StressChaos
metadata:
  name: memory-high-one-new
  namespace: chaos-lab
spec:
  mode: one
  duration: "60s"
  selector:
    namespaces:
      - chaos-lab
    labelSelectors:
      app: chaos-app
  stressors:
    memory:
      workers: 1
      size: "256MB"
EOF

kubectl apply -f memory-high-one-new.yaml
kubectl get stresschaos memory-high-one-new -n chaos-lab -w
kubectl get stresschaos memory-high-one-new -n chaos-lab -o jsonpath='{range .status.experiment.containerRecords[*].events[*]}{.operation}:{.type}{" "}{end}{"\n"}'
cat > memory-high-all-new.yaml <<'EOF'
apiVersion: chaos-mesh.org/v1alpha1
kind: StressChaos
metadata:
  name: memory-high-all-new
  namespace: chaos-lab
spec:
  mode: all
  duration: "60s"
  selector:
    namespaces:
      - chaos-lab
    labelSelectors:
      app: chaos-app
  stressors:
    memory:
      workers: 1
      size: "256MB"
EOF

kubectl apply -f memory-high-all-new.yaml
kubectl get stresschaos memory-high-all-new -n chaos-lab -o jsonpath='{range .status.experiment.containerRecords[*].events[*]}{.operation}:{.type}{" "}{end}{"\n"}'
cat > memory-workers-one-new.yaml <<'EOF'
apiVersion: chaos-mesh.org/v1alpha1
kind: StressChaos
metadata:
  name: memory-workers-one-new
  namespace: chaos-lab
spec:
  mode: one
  duration: "60s"
  selector:
    namespaces:
      - chaos-lab
    labelSelectors:
      app: chaos-app
  stressors:
    memory:
      workers: 2
      size: "128MB"
EOF

kubectl apply -f memory-workers-one-new.yaml
ls
cd ..
ls
cd discord-relay/
ls
cd ..
cd chaos-75/
ls
cd pod/
ls
~kubectl get podchaos,networkchaos,stresschaos -n chaos-lab | grep mariadb
kubectl get podchaos,networkchaos,stresschaos -n chaos-lab | grep mariadb
kubectl get pods -n chaos-lab --show-labels | grep mariadb
cat > mariadb-memory-stress.yaml <<'EOF'
apiVersion: chaos-mesh.org/v1alpha1
kind: StressChaos
metadata:
  name: mariadb-memory-stress
  namespace: chaos-lab
spec:
  mode: one
  duration: "60s"
  selector:
    namespaces:
      - chaos-lab
    labelSelectors:
      app: mariadb
  stressors:
    memory:
      workers: 1
      size: "128MB"
EOF

kubectl apply -f mariadb-memory-stress.yaml
kubectl get stresschaos mariadb-memory-stress -n chaos-lab -w
kubectl get stresschaos mariadb-memory-stress -n chaos-lab -o jsonpath='{range .status.experiment.containerRecords[*].events[*]}{.operation}:{.type}{" "}{end}{"\n"}'
cat > mariadb-io-latency.yaml <<'EOF'
apiVersion: chaos-mesh.org/v1alpha1
kind: IOChaos
metadata:
  name: mariadb-io-latency
  namespace: chaos-lab
spec:
  action: latency
  mode: one
  duration: "60s"
  selector:
    namespaces:
      - chaos-lab
    labelSelectors:
      app: mariadb
  volumePath: /var/lib/mysql
  path: /var/lib/mysql/**/*
  delay: "100ms"
  percent: 100
EOF

kubectl apply -f mariadb-io-latency.yaml
kubectl get iochaos mariadb-io-latency -n chaos-lab -w
kubectl get iochaos mariadb-io-latency -n chaos-lab -o jsonpath='{range .status.experiment.containerRecords[*].events[*]}{.operation}:{.type}{" "}{end}{"\n"}'
cat > mariadb-io-fault.yaml <<'EOF'
apiVersion: chaos-mesh.org/v1alpha1
kind: IOChaos
metadata:
  name: mariadb-io-fault
  namespace: chaos-lab
spec:
  action: fault
  mode: one
  duration: "60s"
  selector:
    namespaces:
      - chaos-lab
    labelSelectors:
      app: mariadb
  volumePath: /var/lib/mysql
  path: /var/lib/mysql/**/*
  errno: 5
  percent: 50
EOF

kubectl apply -f mariadb-io-fault.yaml
kubectl get iochaos mariadb-io-fault -n chaos-lab -w
kubectl get iochaos mariadb-io-fault -n chaos-lab -o jsonpath='{range .status.experiment.containerRecords[*].events[*]}{.operation}:{.type}{" "}{end}{"\n"}'
cat > mariadb-network-partition.yaml <<'EOF'
apiVersion: chaos-mesh.org/v1alpha1
kind: NetworkChaos
metadata:
  name: mariadb-network-partition
  namespace: chaos-lab
spec:
  action: partition
  mode: one
  duration: "60s"
  selector:
    namespaces:
      - chaos-lab
    labelSelectors:
      app: mariadb
  direction: both
EOF

kubectl apply -f mariadb-network-partition.yaml
kubectl get networkchaos mariadb-network-partition -n chaos-lab -w
kubectl get networkchaos mariadb-network-partition -n chaos-lab -o jsonpath='{range .status.experiment.containerRecords[*].events[*]}{.operation}:{.type}{" "}{end}{"\n"}'
kubectl get pods -n chaos-lab
kubectl delete pod mariadb-55698757bd-87pjh
kubectl delete pod -n chaos-app  mariadb-55698757bd-87pjh
kubectl delete pod -n chaos-lab  mariadb-55698757bd-87pjh
kubectl get pods -n chaos-lab
kubectl get stresschaos -n chaos-lab
kubectl delete stresschaos memory-high-all-new memory-high-one-new memory-chaos-test -n chaos-lab
kubectl delete stresschaos mariadb-memory-stress -n chaos-lab
kubectl get prometheusrule -A
kubectl get pods -A | grep -E "prometheus|alertmanager"
kubectl get prometheusrule -A -o yaml | grep -B 5 -A 15 "ChaosAppContainerOOMKilled"
kubectl get prometheusrule -n monitoring
[200~kubectl edit prometheusrule chaos-75-alerts -n monitoring~
kubectl edit prometheusrule chaos-75-alerts -n monitoring
kubectl get prometheusrule chaos-75-alerts -n monitoring -o yaml > chaos-75-alerts-backup.yaml
kubectl get prometheusrule chaos-75-alerts -n monitoring -o yaml | grep -n "ChaosAppContainerOOMKilled"
kubectl get prometheusrule chaos-75-alerts -n monitoring -o yaml > chaos-75-alerts-backup.yaml
kubectl get prometheusrule chaos-75-alerts -n monitoring -o yaml | grep -n -B 3 -A 15 "ChaosAppContainerOOMKilled"
kubectl delete pod chaos-app-7658f8df59-d28jk chaos-app-7658f8df59-fvq2q -n chaos-lab
hostname
kubectl get nodes -o wide
sudo systemctl status k3s --no-pager
stty sane
aws ec2 describe-instances   --region ap-south-1   --query 'Reservations[].Instances[].[InstanceId,State.Name,PrivateIpAddress,Tags[?Key==`Name`].Value|[0]]'   --output table
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get nodes -o wide
kubectl get pods -n chaos-lab -o wide
watch -n 2 'kubectl get nodes; echo "=========="; kubectl get pods -n chaos-lab -o wide'
sudo apt update
sudo apt install awscli -y
aws --version
aws configure
curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/
aws sts get-caller-identity
aws ec2 describe-instances   --region ap-south-1   --query 'Reservations[].Instances[].[InstanceId,Tags[?Key==`Name`].Value|[0],State.Name,PrivateIpAddress]'   --output table
aws ec2 describe-instances
aws ec2 describe-instances   --region ap-south-1   --query 'Reservations[].Instances[].[InstanceId,Tags[?Key==`Name`].Value|[0],State.Name,PrivateIpAddress]'   --output table
mkdir -p ~/aws-chaos
cd ~/aws-chaos
nano ec2-reboot-chaos.sh
chmod +x ec2-reboot-chaos.sh
./ec2-reboot-chaos.sh
mkdir -p ~/aws-chaos/{scripts,evidence}
cd ~/aws-chaos
nano scripts/ec2-stop-chaos.sh
chmod +x scripts/ec2-stop-chaos.sh
cd ~/aws-chaos
./scripts/ec2-stop-chaos.sh
cd ~/aws-chaos
nano scripts/ec2-start-recovery.sh
chmod +x scripts/ec2-start-recovery.sh
./scripts/ec2-start-recovery.sh
aws lambda list-functions --region ap-south-1
aws sts get-caller-identity
cd ~/aws-chaos
mkdir -p lambda-chaos
cd lambda-chaos
cat > trust-policy.json <<'EOF'
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

aws iam create-role   --role-name lambda-chaos-execution-role   --assume-role-policy-document file://trust-policy.json
[200~aws iam attach-role-policy   --role-name lambda-chaos-execution-role   --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole~
cd aws-chaos/lambda-chaos/
ls
aws iam create-role   --role-name lambda-chaos-execution-role   --assume-role-policy-document file://trust-policy.json
aws iam attach-role-policy   --role-name lambda-chaos-execution-role   --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
aws iam get-role   --role-name lambda-chaos-execution-role   --query 'Role.Arn'   --output text
aws iam get-role   --role-name lambda-chaos-execution-role
[200~cd ~/aws-chaos/lambda-chaos
cat > lambda_function.py <<'EOF'
import json
import time
import os

def lambda_handler(event, context):

    action = event.get("action", "normal")

    if action == "sleep":
        time.sleep(5)

    elif action == "error":
        raise Exception("Chaos induced application error")

    elif action == "memory":
        data = ["chaos-data" * 1000 for _ in range(1000)]

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Lambda executed successfully",
            "action": action
        })
    }

aws lambda get-function   --function-name chaos-lambda   --region ap-south-1   --query 'Configuration.[FunctionName,State,Runtime,Timeout,MemorySize]'   --output table
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --payload '{"action":"normal"}'   response.json
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"normal"}'   response.json
cat response.json
aws lambda get-function   --function-name chaos-lambda   --region ap-south-1
watch -n 2 '
kubectl get nodes
echo "========== PODS =========="
kubectl get pods -n chaos-lab -o wide
'
cd ~/aws-chaos/lambda-chaos
cat > lambda_function.py <<'EOF'
import json
import time
import os

def lambda_handler(event, context):

    action = event.get("action", "normal")

    if action == "sleep":
        time.sleep(5)

    elif action == "error":
        raise Exception("Chaos induced application error")

    elif action == "memory":
        data = ["chaos-data" * 1000 for _ in range(1000)]

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Lambda executed successfully",
            "action": action
        })
    }
EOF

zip function.zip lambda_function.py
sudo apt install zip
zip function.zip lambda_function.py
aws lambda create-function   --function-name chaos-lambda   --runtime python3.12   --role arn:aws:iam::632843870789:role/lambda-chaos-execution-role   --handler lambda_function.lambda_handler   --zip-file fileb://function.zip   --region ap-south-1
cd aws-chaos/lambda-chaos/
ls
aws lambda get-function   --function-name chaos-lambda   --region ap-south-1
[200~cat lambda_function.py~
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-alertmanager 9093:9093 --address 0.0.0.0
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl port-forward --address 0.0.0.0 -n monitoring svc/monitoring-kube-prometheus-alertmanager 9093:9093
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090
kubectl port-forward --address 0.0.0.0 -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090
cd aws-chaos/lambda-chaos/
cat lambda_function.py
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"error"}'   response.json
cat response.json
aws logs describe-log-groups   --region ap-south-1   --log-group-name-prefix "/aws/lambda/chaos-lambda"
aws logs tail /aws/lambda/chaos-lambda   --region ap-south-1   --since 10m
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"normal"}'   recovery.json
cat recovery.json
ls
cd aws-chaos/lambda-chaos/
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"normal"}'   recovery.json
cat recovery.json
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"sleep"}'   sleep-response.json
cat sleep-response.json
[200~aws logs tail /aws/lambda/chaos-lambda   --region ap-south-1 \
aws logs tail /aws/lambda/chaos-lambda   --region ap-south-1   --since 5m
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"normal"}'   recovery.json
cat recovery.json
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"memory"}'   memory-response.json
cat memory-response.json
aws logs tail /aws/lambda/chaos-lambda   --region ap-south-1   --since 5m
nano lambda_function.py
aws lambda update-function-configuration   --function-name chaos-lambda   --timeout 10   --region ap-south-1
[200~aws lambda get-function-configuration   --function-name chaos-lambda   --region ap-south-1   --query '[Timeout,MemorySize,State]'   --output table~
cd aws-chaos/lambda-chaos/
ls
aws lambda get-function-configuration   --function-name chaos-lambda   --region ap-south-1   --query '[Timeout,MemorySize,State]'   --output table
zip -r function.zip lambda_function.py
aws lambda update-function-code   --function-name chaos-lambda   --zip-file fileb://function.zip   --region ap-south-1
cd aws-chaos/lambda-chaos/
aws lambda wait function-updated   --function-name chaos-lambda   --region ap-south-1
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"cpu"}'   cpu-response.json
cat cpu-response.json
nano lambda_function.py
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"cpu"}'   cpu-response.json
rm -f function.zip
zip function.zip lambda_function.py
aws lambda update-function-code   --function-name chaos-lambda   --zip-file fileb://function.zip   --region ap-south-1
cd aws-chaos/lambda-chaos/
ls
aws lambda wait function-updated   --function-name chaos-lambda   --region ap-south-1
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"cpu"}'   cpu-response.json
cat cpu-response.json
cd ~/aws-chaos/lambda-chaos
mkdir -p experiments responses
nano experiments/01-error-chaos.sh
nano experiments/02-timeout-chaos.sh
nano experiments/03-memory-chaos.sh
nano experiments/04-cpu-chaos.sh
chmod +x experiments/*.sh
cd ~/aws-chaos/lambda-chaos
nano run-chaos.sh
cd ~/aws-chaos/lambda-chaos
nano experiments/05-concurrent-load-chaos.sh
chmod +x experiments/05-concurrent-load-chaos.sh
./experiments/05-concurrent-load-chaos.sh
aws logs tail /aws/lambda/chaos-lambda   --region ap-south-1   --since 5m
aws lambda get-function-concurrency   --function-name chaos-lambda   --region ap-south-1
aws lambda update-function-configuration   --function-name chaos-lambda   --timeout 10   --region ap-south-1
cd aws-chaos/lambda-chaos/
cd
cd aws-chaos/lambda-chaos/
ls
cd experiments/
ls
aws lambda put-function-concurrency   --function-name chaos-lambda   --reserved-concurrent-executions 2   --region ap-south-1
aws lambda wait function-updated   --function-name chaos-lambda   --region ap-south-1
aws lambda put-function-concurrency   --function-name chaos-lambda   --reserved-concurrent-executions 2   --region ap-south-1
aws lambda get-account-settings   --region ap-south-1   --query 'AccountLimit.[ConcurrentExecutions,UnreservedConcurrentExecutions]'   --output table
cd ~/aws-chaos/lambda-chaos
nano experiments/06-throttling-chaos.sh
chmod +x experiments/06-throttling-chaos.sh
./experiments/06-throttling-chaos.sh
aws logs tail /aws/lambda/chaos-lambda   --region ap-south-1   --since 5m
aws lambda get-function-configuration   --function-name chaos-lambda   --region ap-south-1   --query '[MemorySize,Timeout,State]'   --output table
cd ~/aws-chaos/lambda-chaos
nano lambda_function.py
zip -r function.zip lambda_function.py
aws lambda update-function-code   --function-name chaos-lambda   --zip-file fileb://function.zip   --region ap-south-1
cd aws-chaos/lambda-chaos/experiments/
aws lambda update-function-configuration   --function-name chaos-lambda   --environment "Variables={APP_MODE=production}"   --region ap-south-1
cd aws-chaos/lambda-chaos/experiments/
ls
aws lambda wait function-updated   --function-name chaos-lambda   --region ap-south-1
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"memory_stress"}'   memory-stress-response.json
cat memory-stress-response.json
ls
cd ~/aws-chaos/lambda-chaos
nano experiments/07-memory-stress-chaos.sh
chmod +x experiments/07-memory-stress-chaos.sh
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"normal"}'   recovery-07.json
cat recovery-07.json
aws lambda get-function-configuration   --function-name chaos-lambda   --region ap-south-1   --query 'Environment.Variables'   --output json
cd ~/aws-chaos/lambda-chaos
nano lambda_function.py
rm -f function.zip
zip function.zip lambda_function.py
aws lambda update-function-code   --function-name chaos-lambda   --zip-file fileb://function.zip   --region ap-south-1
cd aws-chaos/lambda-chaos/experiments/
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"config_test"}'   config-chaos-response.json
cat config-chaos-response.json
aws lambda update-function-configuration   --function-name chaos-lambda   --environment "Variables={APP_MODE=production}"   --region ap-south-1
cd aws-chaos/lambda-chaos/experiments/
aws lambda update-function-configuration   --function-name chaos-lambda   --environment "Variables={APP_MODE=chaos}"   --region ap-south-1
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"config_test"}'   config-recovery.json
cat config-recovery.json
cd ~/aws-chaos/lambda-chaos
nano experiments/08-config-chaos.sh
cd ~/aws-chaos/lambda-chaos
nano experiments/08-config-chaos.sh
chmod +x experiments/08-config-chaos.sh
cd ~/aws-chaos/lambda-chaos
nano experiments/09-cold-start-chaos.sh
chmod +x experiments/09-cold-start-chaos.sh
./experiments/09-cold-start-chaos.sh
aws logs tail /aws/lambda/chaos-lambda   --region ap-south-1   --since 5m
aws lambda invoke   --function-name chaos-lambda   --region ap-south-1   --cli-binary-format raw-in-base64-out   --payload '{"action":"normal"}'   warm-response.json
aws logs tail /aws/lambda/chaos-lambda   --region ap-south-1   --since 2m
cd ~/aws-chaos/lambda-chaos
nano lambda_function.py
rm -f function.zip
zip function.zip lambda_function.py
aws lambda update-function-code   --function-name chaos-lambda   --zip-file fileb://function.zip   --region ap-south-1
aws lambda wait function-updated   --function-name chaos-lambda   --region ap-south-1
[200~cd ~/aws-chaos/lambda-chaos
