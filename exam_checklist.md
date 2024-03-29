# Exam checklist prepared based on past blogs

## Before exam
- [x] [Familiarise K8S documentation](https://kubernetes.io/docs/home/)
- [x] [Familiarise existing kubectl command patterns from generated reference document](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run)
- [] [Bookmark Important API](https://kubernetes.io/docs/home/)
  -  [Kubectl](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
  -  [Kubectl Cheatsheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [] [Review example YAMLs](https://github.com/kubernetes/examples)
- [] [Practice exercises](https://github.com/dgkanatsios/CKAD-exercises)
- [] Decide Yaml convention per question
- [] [Practice exam](https://matthewpalmer.net/kubernetes-app-developer/articles/ckad-practice-exam.html)
- [] (learn and familiarize tmux)
- [*] [Practice vi shortcut-keys]
   -- How to move next n line by 5 spaces towards right and left?

## Technical checklist
- [] Alyways assume you have to jump between the cluster - "kubectl config set-context..."
- [] Familiarize GateOne shortcut keys
  - [] Ctrl+Insert to copy
  - [] Ctrl+Del to cut
  - [] Shift+Insert to paste
- [] While deleting, use "--grace-period=1  " to save time

## Most useful commands
- wget url to save the file or curl -L url > file.name
- sed -i 's/old-text/new-text/g' input.txt

## During exam
* Set alias for k with kubectl
* Set alias for bb with busybox
* Completion for F_complete
* echo "set number" > ~/.vimrc or  vim -c 'set number'

## Non Technical checklist

## After exam
* What is maxSurge and maxUnavailability 10%
* When namespace doesn't appear, did you swtich context
* If ingress rules are already available, how to enforce pod to communicate with other pod within pod configuration
* Configure fluentd using shared volume and transform the file
* Loading configMap as volume should be just easy
* llccnf images
* namespaces are like KDPNS00101
  * kubect config use-context k8s
  * kubect config use-context dk8s
  * kubect config use-context nk8s
  * kubect config use-context sk8s



## List of exercises
* [Pod cannot access service because of created network policy, fix network policy by fixing label](https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy/)
* [Sidecar container with logging  agent](https://kubernetes.io/docs/concepts/cluster-administration/logging/#sidecar-container-with-a-logging-agent)


## Reference
* [Tips to pass Certified Kubernetes Application Developer (CKAD) exam](https://medium.com/chotot/tips-tricks-to-pass-certified-kubernetes-application-developer-ckad-exam-67c9e1b32e6e)
* [GateOne](https://github.com/liftoff/GateOne/)
* [Unofficial tips for CKA and CKAD exams](https://unofficialism.info/posts/unofficial-tips-for-cka-and-ckad-exams/)

