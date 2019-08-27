# Services
* Services deals with 3 different set of connectivities
  * Connectivity between user and services
  * Connectivity between different set of pods (application services)
  * Connectivity between pods and back-end services

## NodePort

* Why we need NodePort?
  * If a server has ip address of 192.168.1.1 and POD has servicing running on 10.244.0.0:80, we can't reach service running inside server by using POD's IP
  * There could be multiple POD running on port:80 same server, server hostname can have only one 80
    * Hence we need a dedicated port on server pod, that should redirect request to POD's IP and port
    * NodePort listens on Node, and forward all request to Pod's IP+Pod's Port
    * From outside server, external system can reach Servers port using Server-Node-Hostname:NodePort-TCP-Port
    * NodePort = Node-IP + Node-Port (~~~>) ClusterIP 's-IP + ClusterIP's-Port (~~~>) Pods's-IP + Pod's-Port    
* NodePort is implemented using Cluster-IP
  * K8S - treats NodePort as service, hence creates ClusterIP and assigns port for it
  * When we refer `port` in the context of NodePort, it refers to the port assigned to the cluster-ip
    * It is neither node's TCP-port, nor pod's TCP-port
  * When we refer `targetPort` in the context of NodePort, it refers to the port of the POD
  * nodePort should be in range of 30000-32767

* Works across multiple pods on same server
  * Uses random algorithm to pick the pod
  * Uses sticky-session
  * Acts like loadbalancer between multiple-pods
  
* Works PODS across multiple servers
  * When we expose deployment using node-port, same port runs on all node
  * We can access the service using same node-port using any of node-ips

---

## ClusterIP

* Why we need CluserIP?
  * Default type
  * *Within* a cluster we need a address to register similar set of services running. And route the request among them
  * If some restful-service/micro-service running on POD deployed on multiple server, we need one IP-Address to access them
  * Consumer requires single-address for the entire set of service
  * ClusterIP reprsents set-of-pods
  * ClusterIP also comes with name

### Constraints of ClusterIP

* ClusterIP is only accessible/addressable within kubernetes cluter
