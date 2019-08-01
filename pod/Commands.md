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