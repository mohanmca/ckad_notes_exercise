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






apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: 2019-08-03T22:59:40Z
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
  resourceVersion: "5627"
  selfLink: /api/v1/namespaces/default/pods/webapp-color
  uid: 5fd5b6bb-b642-11e9-b30c-0242ac11002f
spec:
  containers:
  - env:
    - name: APP_COLOR
      value: green
    envFrom:
    - configMapRef:
        name: webapp-config-map
    image: kodekloud/webapp-color
    imagePullPolicy: Always
    name: webapp-color
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-bzdjh
      readOnly: true
  dnsPolicy: ClusterFirst
  nodeName: node01
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: default-token-bzdjh
    secret:
      defaultMode: 420
      secretName: default-token-bzdjh
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: 2019-08-03T22:59:40Z
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: 2019-08-03T22:59:42Z
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: null
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: 2019-08-03T22:59:40Z
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://c71cdd5693a5f80cb4bfafc790e91f465c6e3b643d57500c3085af47ed74111b
    image: kodekloud/webapp-color:latest
    imageID: docker-pullable://kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423
    lastState: {}
    name: webapp-color
    ready: true
    restartCount: 0
    state:
      running:
        startedAt: 2019-08-03T22:59:42Z
  hostIP: 172.17.0.49
  phase: Running
  podIP: 10.32.0.2
  qosClass: BestEffort
  startTime: 2019-08-03T22:59:40Z