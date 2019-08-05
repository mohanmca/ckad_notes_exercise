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
```
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

nodeselector:
  label_key: label_value

## affinity > nodeAffinity
* When pod should be configured for complex expression, nodeAffinity could be used
* Operator can have one of the values like.. In, NotIn, Exists