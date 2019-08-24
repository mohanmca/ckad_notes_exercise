```bash
kubectl annotate -f pod.json description='my frontend'
kubectl annotate pods foo description='my frontend running nginx' --resource-version=1
kubectl api-resources --api-group=extensions
kubectl apply --prune -f manifest.yaml -l app=nginx
kubectl apply -f ./pod.json
kubectl apply -k dir/
kubectl apply edit-last-applied -f deploy.yaml -o json
kubectl apply edit-last-applied deployment/nginx
kubectl apply view-last-applied -f deploy.yaml -o json
kubectl apply view-last-applied deployment/nginx
kubectl attach 123456-7890
kubectl attach 123456-7890 -c ruby-container
kubectl attach 123456-7890 -c ruby-container -i -t
kubectl attach rs/nginx
kubectl auth can-i --list --namespace=foo
kubectl auth can-i '*' '*'
kubectl auth can-i create pods --all-namespaces
kubectl auth can-i get /logs/
kubectl auth can-i get pods --subresource=log
kubectl auth can-i list deployments.extensions
kubectl auth can-i list jobs.batch/bar -n foo
kubectl auth reconcile -f my-rbac-rules.yaml
kubectl autoscale deployment foo --min=2 --max=10
kubectl autoscale rc foo --max=5 --cpu-percent=80
kubectl cluster-info dump --all-namespaces
kubectl cluster-info dump --namespaces default,kube-system --output-directory=/path/to/cluster-state
kubectl cluster-info dump --output-directory=/path/to/cluster-state
kubectl completion bash > ~/.kube/completion.bash.inc
kubectl config current-context
kubectl config get-clusters
kubectl config get-contexts
kubectl config rename-context old-name new-name
kubectl config set clusters.my-cluster.certificate-authority-data $(echo "cert_data_here" | base64 -i -)
kubectl config set clusters.my-cluster.server https://1.2.3.4
kubectl config set contexts.my-context.cluster my-cluster
kubectl config set users.cluster-admin.client-key-data cert_data_here --set-raw-bytes=true
kubectl config set-cluster e2e --certificate-authority=~/.kube/e2e/kubernetes.ca.crt
kubectl config set-cluster e2e --insecure-skip-tls-verify=true
kubectl config set-cluster e2e --server=https://1.2.3.4
kubectl config set-context gce --user=cluster-admin
kubectl config set-credentials cluster-admin --auth-provider=gcp
kubectl config set-credentials cluster-admin --auth-provider=oidc --auth-provider-arg=client-id=foo --auth-provider-arg=client-secret=bar
kubectl config set-credentials cluster-admin --auth-provider=oidc --auth-provider-arg=client-secret-
kubectl config set-credentials cluster-admin --client-certificate=~/.kube/admin.crt --embed-certs=true
kubectl config set-credentials cluster-admin --client-key=~/.kube/admin.key
kubectl config set-credentials cluster-admin --username=admin --password=uXFGweU9l35qcif
kubectl config unset contexts.foo.namespace
kubectl config unset current-context
kubectl config use-context minikube
kubectl config view
kubectl config view --raw
kubectl config view -o jsonpath='{.users[?(@.name == "e2e")].user.password}'
kubectl convert -f . | kubectl create -f -
kubectl convert -f pod.yaml --local -o json
kubectl cp /tmp/foo <some-namespace>/<some-pod>:/tmp/bar
kubectl cp /tmp/foo <some-pod>:/tmp/bar -c <specific-container>
kubectl cp /tmp/foo_dir <some-pod>:/tmp/bar_dir
kubectl cp <some-namespace>/<some-pod>:/tmp/foo /tmp/bar
kubectl create -f ./pod.json
kubectl create -f docker-registry.yaml --edit -o json
kubectl create clusterrole "foo" --verb=get --non-resource-url=/logs/*
kubectl create clusterrole foo --verb=get,list,watch --resource=pods,pods/status
kubectl create clusterrole foo --verb=get,list,watch --resource=rs.extensions
kubectl create clusterrole monitoring --aggregation-rule="rbac.example.com/aggregate-to-monitoring=true"
kubectl create clusterrole pod-reader --verb=get --resource=pods --resource-name=readablepod --resource-name=anotherpod
kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods
kubectl create clusterrolebinding cluster-admin --clusterrole=cluster-admin --user=user1 --user=user2 --group=group1
kubectl create configmap my-config --from-env-file=path/to/bar.env
kubectl create configmap my-config --from-file=key1=/path/to/bar/file1.txt --from-file=key2=/path/to/bar/file2.txt
kubectl create configmap my-config --from-file=path/to/bar
kubectl create configmap my-config --from-literal=key1=config1 --from-literal=key2=config2
kubectl create cronjob my-job --image=busybox
kubectl create cronjob my-job --image=busybox -- date
kubectl create cronjob test-job --image=busybox --schedule="*/1 * * * *"
kubectl create deployment my-dep --image=busybox
kubectl create deployment my-dep -o yaml --dry-run | kubectl label --local -f - environment=qa -o yaml | kubectl create -f -
kubectl create job my-job --image=busybox
kubectl create job my-job --image=busybox -- date
kubectl create job test-job --from=cronjob/a-cronjob
kubectl create namespace my-namespace
kubectl create pdb my-pdb --selector=app=nginx --min-available=50%
kubectl create poddisruptionbudget my-pdb --selector=app=rails --min-available=1
kubectl create priorityclass default-priority --value=1000 --global-default=true --description="default priority"
kubectl create priorityclass high-priority --value=1000 --description="high priority"
kubectl create quota best-effort --hard=pods=100 --scopes=BestEffort
kubectl create quota my-quota --hard=cpu=1,memory=1G,pods=2,services=3,replicationcontrollers=2,resourcequotas=1,secrets=5,persistentvolumeclaims=10
kubectl create role foo --verb=get,list,watch --resource=pods,pods/status
kubectl create role foo --verb=get,list,watch --resource=rs.extensions
kubectl create role pod-reader --verb=get --resource=pods --resource-name=readablepod --resource-name=anotherpod
kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods
kubectl create rolebinding admin --clusterrole=admin --user=user1 --user=user2 --group=group1
kubectl create rolebinding admin --role=admin --user=admin -o yaml --dry-run | kubectl set subject --local -f - --user=foo -o yaml
kubectl create secret docker-registry my-secret --docker-server=DOCKER_REGISTRY_SERVER --docker-username=DOCKER_USER --docker-password=DOCKER_PASSWORD --docker-email=DOCKER_EMAIL
kubectl create secret generic my-secret --from-env-file=path/to/bar.env
kubectl create secret generic my-secret --from-file=path/to/bar
kubectl create secret generic my-secret --from-file=ssh-privatekey=~/.ssh/id_rsa --from-file=ssh-publickey=~/.ssh/id_rsa.pub
kubectl create secret generic my-secret --from-file=ssh-privatekey=~/.ssh/id_rsa --from-literal=passphrase=topsecret
kubectl create secret generic my-secret --from-literal=key1=supersecret --from-literal=key2=topsecret
kubectl create secret tls tls-secret --cert=path/to/tls.cert --key=path/to/tls.key
kubectl create service clusterip my-cs --clusterip="None"
kubectl create service clusterip my-cs --tcp=5678:8080
kubectl create service clusterip my-svc --clusterip="None" -o yaml --dry-run | kubectl set selector --local -f - 'environment=qa' -o yaml | kubectl create -f -
kubectl create service externalname my-ns --external-name bar.com
kubectl create service loadbalancer my-lbs --tcp=5678:8080
kubectl create service nodeport my-ns --tcp=5678:8080
kubectl create serviceaccount my-service-account
kubectl delete -f ./pod.json
kubectl delete -k dir
kubectl delete pod foo --now
kubectl delete pod,service baz foo
kubectl delete pod/busybox1
kubectl delete pods --all
kubectl delete pods,services -l name=myLabel
kubectl describe nodes kubernetes-node-emt8.c.myproject.internal
kubectl describe po -l name=myLabel
kubectl describe pods/nginx
kubectl edit deployment/mydeployment -o yaml --save-config
kubectl edit job.v1.batch/myjob -o json
kubectl edit svc/docker-registry
kubectl exec 123456-7890 -c ruby-container -i -t -- bash -il
kubectl exec 123456-7890 -c ruby-container date
kubectl exec 123456-7890 -i -t -- ls -t /usr
kubectl exec 123456-7890 date
kubectl explain pods.spec.containers
kubectl expose -f nginx-controller.yaml --port=80 --target-port=8000
kubectl expose deployment nginx --port=80 --target-port=8000
kubectl expose pod valid-pod --port=444 --name=frontend
kubectl expose rc nginx --port=80 --target-port=8000
kubectl expose rc streamer --port=4100 --protocol=UDP --name=video-stream
kubectl expose rs nginx --port=80 --target-port=8000
kubectl expose service nginx --port=443 --target-port=8443 --name=nginx-https
kubectl get -f pod.yaml -o json
kubectl get -k dir/
kubectl get -o json pod web-pod-13je7
kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
kubectl get deployments.v1.apps -o json
kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f -
kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
kubectl get pods
kubectl get pods -o wide
kubectl get rc,services
kubectl get rc/web service/frontend pods/web-pod-13je7
kubectl get replicationcontroller web
kubectl kustomize /home/configuration/production
kubectl kustomize github.com/kubernetes-sigs/kustomize.git/examples/helloWorld?ref=v1.0.6
kubectl label --overwrite pods foo status=unhealthy
kubectl label -f pod.json status=unhealthy
kubectl label pods --all status=unhealthy
kubectl label pods foo bar-
kubectl label pods foo status=unhealthy --resource-version=1
kubectl label pods foo unhealthy=true
kubectl logs --since=1h nginx
kubectl logs --tail=20 nginx
kubectl logs -f -c ruby web-1
kubectl logs -f -lapp=nginx --all-containers=true
kubectl logs -lapp=nginx --all-containers=true
kubectl logs -p -c ruby web-1
kubectl logs deployment/nginx -c nginx-1
kubectl logs job/hello
kubectl logs nginx --all-containers=true
kubectl patch -f node.json -p '{"spec":{"unschedulable":true}}'
kubectl patch node k8s-node-1 -p '{"spec":{"unschedulable":true}}'
kubectl patch node k8s-node-1 -p $'spec:\n unschedulable: true'
kubectl patch pod valid-pod --type='json' -p='[{"op": "replace", "path": "/spec/containers/0/image", "value":"new image"}]'
kubectl patch pod valid-pod -p '{"spec":{"containers":[{"name":"kubernetes-serve-hostname","image":"new image"}]}}'
kubectl port-forward --address 0.0.0.0 pod/mypod 8888:5000
kubectl port-forward --address localhost,10.19.21.23 pod/mypod 8888:5000
kubectl port-forward deployment/mydeployment 5000 6000
kubectl port-forward pod/mypod :5000
kubectl port-forward pod/mypod 5000 6000
kubectl port-forward pod/mypod 8888:5000
kubectl port-forward service/myservice 5000 6000
kubectl proxy --api-prefix=/k8s-api
kubectl proxy --port=0
kubectl proxy --port=8011 --www=./local/www/
kubectl replace --force -f ./pod.json
kubectl replace -f ./pod.json
kubectl rolling-update frontend --image=image:v2
kubectl rollout history daemonset/abc --revision=3
kubectl rollout history deployment/abc
kubectl rollout pause deployment/nginx
kubectl rollout resume deployment/nginx
kubectl rollout status daemonset/foo
kubectl rollout status deployment/nginx
kubectl rollout undo --dry-run=true deployment/abc
kubectl rollout undo daemonset/abc --to-revision=3
kubectl rollout undo deployment/abc
kubectl run -i -t busybox --image=busybox --restart=Never
kubectl run hazelcast --image=hazelcast --env="DNS_DOMAIN=cluster" --env="POD_NAMESPACE=default"
kubectl run hazelcast --image=hazelcast --labels="app=hazelcast,env=prod"
kubectl run hazelcast --image=hazelcast --port=5701
kubectl run nginx --image=nginx
kubectl run nginx --image=nginx -- <arg1> <arg2> ... <argN>
kubectl run nginx --image=nginx --command -- <cmd> <arg1> ... <argN>
kubectl run nginx --image=nginx --dry-run
kubectl run nginx --image=nginx --overrides='{ "apiVersion": "v1", "spec": { ... } }'
kubectl run nginx --image=nginx --replicas=5
kubectl run pi --image=perl --restart=OnFailure -- perl -Mbignum=bpi -wle 'print bpi(2000)'
kubectl run pi --schedule="0/5 * * * ?" --image=perl --restart=OnFailure -- perl -Mbignum=bpi -wle 'print bpi(2000)'
kubectl scale --current-replicas=2 --replicas=3 deployment/mysql
kubectl scale --replicas=3 -f foo.yaml
kubectl scale --replicas=3 rs/foo
kubectl scale --replicas=3 statefulset/web
kubectl scale --replicas=5 rc/foo rc/bar rc/baz
kubectl set env --from=configmap/myconfigmap --prefix=MYSQL_ deployment/myapp
kubectl set env --from=secret/mysecret deployment/myapp
kubectl set env --keys=my-example-key --from=configmap/myconfigmap deployment/myapp
kubectl set env -f deploy.json ENV-
kubectl set env deployment/registry STORAGE_DIR=/local
kubectl set env deployment/sample-build --list
kubectl set env deployment/sample-build STORAGE_DIR=/data -o yaml
kubectl set env deployments --all --containers="c1" ENV-
kubectl set env pods --all --list
kubectl set env rc --all ENV=prod
kubectl set image -f path/to/file.yaml nginx=nginx:1.9.1 --local -o yaml
kubectl set image daemonset abc *=nginx:1.9.1
kubectl set image deployment/nginx busybox=busybox nginx=nginx:1.9.1
kubectl set image deployments,rc nginx=nginx:1.9.1 --all
kubectl set resources -f path/to/file.yaml --limits=cpu=200m,memory=512Mi --local -o yaml
kubectl set resources deployment nginx --limits=cpu=0,memory=0 --requests=cpu=0,memory=0
kubectl set resources deployment nginx --limits=cpu=200m,memory=512Mi --requests=cpu=100m,memory=256Mi
kubectl set resources deployment nginx -c=nginx --limits=cpu=200m,memory=512Mi
kubectl set sa -f nginx-deployment.yaml serviceaccount1 --local --dry-run -o yaml
kubectl set serviceaccount deployment nginx-deployment serviceaccount1
kubectl set subject clusterrolebinding admin --serviceaccount=namespace:serviceaccount1
kubectl set subject rolebinding admin --user=user1 --user=user2 --group=group1
kubectl taint node -l myLabel=X  dedicated=foo:PreferNoSchedule
kubectl taint nodes foo dedicated=special-user:NoSchedule
kubectl top node
kubectl top node NODE_NAME
kubectl top pod
kubectl top pod --namespace=NAMESPACE
kubectl top pod -l name=myLabel
kubectl top pod POD_NAME --containers
kubectl version
kubectl wait --for=condition=Ready pod/busybox1
kubectl wait --for=delete pod/busybox1 --timeout=60s
```