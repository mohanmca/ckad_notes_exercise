
## Exam notes (learnt from mock-exam)
* To Search "nodeSelector inside Deployment manifest inside github: org:kubernetes"
  * https://github.com/search?q=org%3Akubernetes+Deployment+nodeSelector+extension%3Ayaml
  * %3A == :
* kubectl expose deployment redis --port=30083 --name messaging-service --namespace=marketing  --type=NodePort --protocol=TCP 
* --dry-run may not produce nodePort: 30xxx, hence we might need to create service, export yaml, and update yaml, drop old object and recreate it. It happened for type=NodePort
* For replicaset, after edit, you should delete the staled pods to recreate new pods
* Make use of kubectl tab completion


* Create a deployment called my-webapp with image: nginx, label tier:frontend and 2 replicas. Expose the deployment as a NodePort service with name front-end-service , port: 80 and NodePort: 30083
  * 'k run my-webapp --image=nginx --restart=Always -l tier=frontend --dry-run -o yaml'
  * 'k scale --replicas=2 deployment my-webapp 2'
  * 'k expose deployment my-webapp --port=80  -type=NodePort --name messaging-service -o yaml'

* Add a taint to the node node01 of the cluster. Use the specification below:, key:app_type, value:alpha and effect:NoSchedule, Create a pod called alpha, image:redis with toleration to node01
    * 'k taint node node01 app_type=alpha:NoSchedule'
    * 'k run alpha --image=redis --restart=Never -o yaml'
    * 'k explain pod.spec.tolerations --recursive'

* Operator : "Equal" and "Equls" not exist, use In, and Values should be configured as Array

Apply a label app_type=beta to node node02. Create a new deployment called beta-apps with image:nginx and replicas:3. Set Node Affinity to the deployment to place the PODs on node02 only


Create a new Ingress Resource for the service: my-video-service to be made available at the URL: http://ckad-mock-exam-solution.com:30093/video.


We have deployed a new pod called pod-with-rprobe. This Pod has an initial delay before it is Ready. Update the newly created pod pod-with-rprobe with a readinessProbe using the given spec


Create a job called pi with image perl and command "perl -Mbignum=bpi -wle print bpi(200)".
completions: 2
backoffLimit: 6
restartPolicy: Never


Create a pod called multi-pod with two containers. 
Container 1: name: jupiter, image: nginx
Container 2: europa, image: busybox
command: sleep 4800

Environment Variables: Container 1: type: planet

Container 2: type: moon


Create a PersistentVolume called custom-volume with size: 50MiB reclaim policy:retain, Access Modes: ReadWriteMany and hostPath: /opt/data    