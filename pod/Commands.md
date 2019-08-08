## What is the base k8s pod yaml
* https://github.com/kubernetes/website/blob/master/content/en/examples/pods/pod-nginx.yaml
* https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/pods/pod-nginx.yaml
* r.g.c/k/w/m/c/e/e/p/p (mcee)

## For exercise-1
```bash
  kubectl create -f ex1_pod.yaml
  kubectl get pods
```
## For exercise-2
```bash
  kubectl delete pod myapp-pod
  kubectl create -f ex2_pod.yaml
  kubectl get pods
```
# Create nginx pod
```bash
  kubectl run nginx --image=nginx --generator=run-pod/v1
  kubectl run nginx --image=nginx --generator=run-pod/v1 --dry-run -o yaml
  kubectl get  pods  -o wide
  kubectl describe pod newpod-12121
  kubectl edit pod redis
```

# Replicaset
```bash
kubectl get replicationcontroller
kubectl get replicaset
kubectl remove replicaset m
kubectl describe rs/new-replica-set
# if we update replicaset
kubectl repalce -f mywebapp-replicaset.yml
# if we plan to override only few param in replicaset
kubectl scale --replicas=6 -f mywebapp-replicaset.yml
kubectl scale --replicas=6 replicaset mywebapp-replicaset
```

# Kubectl commands
```bash
#Create an NGINX Pod
kubectl run --generator=run-pod/v1 nginx --image=nginx
```
```bash
#Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)
kubectl run --generator=run-pod/v1 nginx --image=nginx --dry-run -o yaml
```
```bash
#Create a deployment
kubectl run --generator=deployment/v1beta1 nginx --image=nginx
#Or the newer recommended way:
kubectl create deployment --image=nginx nginx
```
```bash
#Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)
kubectl run --generator=deployment/v1beta1 nginx --image=nginx --dry-run -o yaml
Or
kubectl create deployment --image=nginx nginx --dry-run -o yaml
```
```bash
#Generate Deployment YAML file (-o yaml). Don't create it(--dry-run) with 4 Replicas (--replicas=4)
kubectl run --generator=deployment/v1beta1 nginx --image=nginx --dry-run --replicas=4 -o yaml
kubectl create deployment does not have a --replicas option. You could first create it and then scale it using the kubectl scale command.
```
```bash
#Save it to a file - (If you need to modify or add some other details)
kubectl run --generator=deployment/v1beta1 nginx --image=nginx --dry-run --replicas=4 -o yaml > nginx-deployment.yaml
```
```bash
#Create a Service named nginx of type NodePort and expose it on port 30080 on the nodes:
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run -o yaml
```

## Namespace commands
# What is the default namespace? 
* It is *default*
```bash
kubectl get pods --namespace=dev
kubectl config set-context $(kubectl config current-context) --namespace=dev
kubectl get pods --namespace=default
```

# docker commands
```bash
docker run nginx
docker ps
docker ps -a ##show exited container
docker run nginx sleep 5 ## override default command
```

```Dockerfile
CMD sleep 5
CMD ['sleep','5'] # Using JSON array format, first element is command
CMD ['sleep 5'] # FAILURE, WOULD FAIL
ENTRYPOINT ['sleep'] # Rest of the arguments could come from command-line
CMD ["5"] #Default argument for Entry point
ENTRYPOINT ['abracadbabra']
docker run --entry-point abracadbabra curl -o http://google.com 
```

## secutityContext

```bash
kubectl get configmaps
kubectl create configmap webapp-green --from-literal=color=green -o yaml
kubectl create secret generic db_secrets --from-literal=host=mysql.xyz.com --from-literal=db_port=8789 --from-literal=db_user=acme_db_user --from-literal=dbpass=password --dry-run -o yaml
echo hello  | base64
echo hello  | base64 --decode

envFrom:
- secretRef:
    name: secret-app-config
```

```yaml
## for pod level security
spec:
  secutityContext:
    runAsUser: 1000

## for container level security
spec:
  containers:
    secutityContext:
      runAsUser: 1000

# kubectl create secret generic db-secret --from-literal=DB_Host=sql01 --from-literal=DB_User=root --from-literal=DB_Password=password123


```
* Capabilities are configurable only at container level and not-at podlevel 


## Service Accounts

* A service account provides an identity for processes that run in a Pod.
* Processes in containers inside pods can contact with  apiserver, they are authenticated as a particular Service Account.
* Always there exists a default service-account named "default"
* When ServiceAccount is created, it also creates a default token for serviceaccount
* Every namespace has its own default service account
* Token is stored as secret object
* SA-TOken can be used for authorization/authenication
* Service account can be assigned with additional permission using Role-Based-Access
* If 3-rd party application that is requried Secret-ServiceAccount-Token is hosted within k8s cluster, Secret-Service-Account token itself could be mounted as a volume
* Default token secret is mounted as a file (Using default-token-fdcs)
  * /var/run/secrets/kubernetes.io/serviceaccount (directory)
* Default ServiceAccount token only has read-only query permission

```bash
kubectl create serviceaccount dashboard-sa
kubectl get serviceaccount
kubect describe serviceaccount dashboard-sa
## find secret token of the service_0_account
kubectl describe secret dashboard-sa-kbbdm

curl https://192.168.56.102:6443/api -insecure --header "Authenication: Bearer a3ViZWN0bCBkZXNjcmliZSBzZWNyZXQgZGFzaGJvYXJkLXNhLWtiYmRtCg=="
## how to view the secret file from CLI
kubectl exec -it my-pod ls /var/run/secrets/kubernetes.io/serviceaccount
  * ca.crt, namespace, token (3 files)
https://k8s.io/docs/search/?q=ServiceAccount
```


## RBCA
```yaml
kind: RoleBinding 
apiVersion: rbac. authorization. k8s. io/vl 
metadata : 
  name: read-pods 
  namespace :  default 
subjects: 
 - kind: ServiceAccount 
   name: dashboard-sa 
   namespace : default
roleRef : 
  kind: Role 
  name: pod-reader 
  apiGroup: rbac. authorization. k8s. io 
```
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRhc2hib2FyZC1zYS10b2tlbi02bXQ3aCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJkYXNoYm9hcmQtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI3NmZhNWI2OS1iNmNmLTExZTktYmFiZS0wMjQyYWMxMTAwMTciLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkYXNoYm9hcmQtc2EifQ.Y1uOKpIxELDvzVDGbfFW9sCZk3KSDrbB8lTKDTn7RAK7X2hPVxtlQKIJ9yDzL5A0fUwlHmuUK9O2sqiQxLmCgWYxwFPohdYguvCtceAI1D6amm__i2zPa1o4DbTGoNJtTESp42wVzvZmuDcm2dR_SWJn7-CTOC-OXyba0NThx6zgdty972BBXk2MItSZs8mGzJwEWpebRqkbxxTa-ZJBwg1Cl50dIfM_Gyayk4LRNp2g6vvN08Pec1k6_SCVEu4VrbLpoblDFDUo_i9oV4XLq6K_zat449gOKS4Egm2XpgaAzOqVmXjHGYSEPOrIF9_RoliD6OkddNBJWdm8mu6MOA



## Taints and tolerants
* Taints are applied on NODES and Tolerants are applied on POD
* Taints are like constraint, due to that many pods can't be scheduled on nodes that dosn't tolearte with taints
* If pods has tolerant to certain taints, then they are added
* Taint-effects
  * NoSchedule
  * NoExecute
  * PrefereNoSchedule
* If a pod with app:blue is executing on node-1, and if taint node node-1 as such app:blue:NoExecute, existing pod would be evicted from the node node-1
* Nodes that has special hardware can be used for only specific purpose (GPU hw for ML)


```bash
kubectl taint nodes node-name key=value:taint-effect
kubectl tain node node-name app=blue:NoSchedule
kubectl tain node node-name tier=fronend:NoSchedule
kubectl tain node prod-node ctx=dev:NoSchedule
```

tolerations field should be same level as containers (not within containers)
** Under pod definition
tolerations:
  - key: "app"
    operator: "Equal"
    value: "blue"
    effect: "NoSchedule"

tolerations:
  - key: "tier"
    operator: "Equals"
    value: "frontend"
    effect: "PreferNoSchedule"

tolerations:
  key: "key"
  operator: "Exists"
  effect: "NoSchedule"

## Nodeselector
* nodeselector should be at the same level as containers
* kubectl label node node01 size=large #TO create label
* kubectl label node node01 size- #To remove label
* kubectl label node master node-role.kubernetes.io/master=master

nodeselector:
  label_key: label_value

## affinity > nodeAffinity
* When pod should be configured for complex expression, nodeAffinity could be used
* Operator can have one of the values like.. In, NotIn, Exists

## Multi-container pods

* Created and destroyed the same time

## Patterns

* Sidecar
  * Adding log agent along with container
* Ambassador
  * Connecting to different database for different environment
* Adapter
  * Adapt to common standard logging
  * Convert the old logging format to new standard pattern

## Realitime monitoring

```bash
kubectl get po,svc,rs,storageclasses,pv,pvc --watch
```

## Application readinessProbe && liveness

* HTTPTest - /api/ready?
* TCPTest - 3306
* Exec Command - if script return 0 (successful execution)
* readinessProbe:
    initialDelaySounds: 10
    perodSeconds: 5
    failureThreshold: 8
    httpGet:
      path: /api/ready
      port: 8080
    tcpSocket:
      port: 8180
    exect:
      command:
        - cat
        - /app/is_ready


## liveness probe

* docker run nginx
* docker ps -a
* kubectl run nginx --image=nginx

for i in {1..20}; do
  kubectl exec --nmaespace=kube-public curl -- sh -c 'test=`wget -q0- -T 2 http://webappurl:8080/ 2>&1` && echo "$test OK" || echo "Failed"';
  echo ""
done


## Container logging

* docker logs -f event-simulartor-container
* docker logs -f event-simulator-container
* kubectl logs -f event-simulator-pod webapp-container


## How do you monitor?
* Node level metrics
  * cpu, network, memory, io
* Metrics Server
  * In-Memory metrics server without historical data
  * For advanced, we have to use DataDog, ELK, Promethus
* cAdvisor - Container Advisor
  * Kubelet sub-component
  * Node level metric

* 
```bash
  minikube addons enable metrics-server
  git clone https://github.com/kubernetes-incubator/metrics-server.git
  kubectl create -f deploy/1.8+/ ## creating objects for all configuraion found on directory
  kubectl top node
  kubectl top pod
```

## Labels and Selectors

* Labels can go under /metadata/labels/
* kubectl internally uses labels (Example ReplicaSet)
* 
```bash
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp
  annotations:
    buildVersion: 2.0
  labels:
    app: settlment
    tier: front-end
    type: backend-service
```
* labels defined under 
  * ReplicaSets internally uses labels
  * /spec/template/metadata/labels -- Are pod labels
  * /spec/selector/matchLabels/app==settlement -- Are labels to select pods
  * On creation of replicaset, if labels match, ReplicaSet is created successfully

kubectl get pods --selector app=settlement
kubectl get all --selector app=settlement --selector tier=frontend --selector env=prod


## Annotations (for informatory tool)

* Annotations are used to store additional metadata
  * Phone
  * Build-tool
  * Build-tool-version

## Updates and rollbacks (rollouts)
* Every deployment is revisioned
* Default Deployment would use "rollout" strategy  instead of recreate (recreate strategy is kill old, and then bring new)
  * Rollout, kill one pod and cocurrently bring another pod.
  * For n-pods, it does one at a time, at some-point, there will be equaly old and new pods
* Deployment update comes from
  * Image update
  * Label update
  * ReplicasCount update
* New roll-out would trigger, new revision
# We can undo the deployment made to fall-back to older version
  * It would use older replicaSet for the rollback
```bash
kuectl create deployment deploy  
kubectl create -f deployment-definition.yaml
kubectl set image deployment/myapp-deployemnt ngnix:ngnix:1.15.8
kubectl describe deployment myapp-deployment | grep StrategyType
## Recreate /RollingUpdate, watchout for message under Events
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment
kubectl rollout undo deployment/myapp-deployment
## Try below command (get replicasets) before and after rollback of deployment
kubectl get replicasets
kubectl run ngnix --image=ngnix:1.15.8
## It creates deployment
```

## Job

* A job is similar to replicaset
* A Job is used to set of pods to perform a given task to completion
* A Job requires one ore more pods
* Completions should be satisfied (pods sequentially created till it matchs completons count)
* Parallelism: n -- could be used to spinoff multiple pods at a time


* Example Job deployemnt

```bash
kubectl run nginx --image=busybox --exec -it -- expr 2+2
kubectl run nginx --image=nginx:1.15.8 --exec -it -- expr 2+2
kubectl create job --image=busybox math-add-job -- expr 3 + 2 --dry-run  -o yaml
** command: ['expr','3','+','2']
kubectl get job.batch/math-add-job -o yaml
kubectl logs job.batch/math-add-job
```

# CronJob deployemnt

* CronJob = Job + Schedule + Pod
* apiVersion: batch/v1, kind: CronJob
* Spec section should have 3 specs
  * 1 for Job, 1 for Cron, 1 for Pod

* spec: schedule: "*/1 * * * * *" 
  * minute(99)/hour(99)/day_of_month(99)/month(99)/day_of_week(9)
  * minute(0-59)/hour(0-23)/day_of_month(1-31)/month(1-12)/day_of_week(0-6)
  * 0 - Sunday (somesystem treats 7 also sunday)
```bash
kubectl get cronjob
```
