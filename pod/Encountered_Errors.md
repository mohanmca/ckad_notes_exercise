# error: error validating "ex1_pod.yaml": error validating data: ValidationError(Pod.metadata): unknown field "label" in io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta; if you choose to ignore these errors, turn validation off with --validate=false
  * Should be labels
* Error from server (BadRequest): error when creating "ex1_pod.yaml": pod in version "v1" cannot be handled as a Pod: no kind "pod" is registered for version "v1" in scheme "k8s.io/kubernetes/pkg/api/legacyscheme/scheme.go:30"
    * Should be Pod
* -o wide  won't work with describe command    

* ReplicaSet is new, and it is repalcing old replication-controller
* ReplicationContoller doesn't require selector, whereas ReplicaSet, it is mandatory

# Selctor
selector:
  matchLabels:
    type: frontend
    app: demo


Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply
Error from server (Conflict): Operation cannot be fulfilled on replicasets.extensions "new-replica-set": the object has been modified; please apply your changes to the latest version and try again
master $ kubectl replace -f new-rs.yml
Error from server (Conflict): Operation cannot be fulfilled on re    