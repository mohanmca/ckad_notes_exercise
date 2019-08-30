# Ingress

## Why we need ingress?

* When multiple services are running they are accessible using different URL-path
  * Each path could be routed to different set of services
* Though it is possible to secure each URL-path using different load-balancers like ELB/GCP-LB, it is expensive
* Each URL-path may have different HTTP setttings like keep-alive, ssl-termination-settings, http-error-path
* When application has 100s of above services, managing them becomes cumbersome
* Ingress takes care URL-path to backend-service, ssl-termination, keep-alive, session-timeout rever-proxy in one place

## How ingress is implemented in K8s?

* Ingress could be implemented only by reverse-proxy solution
* Either we should adopt cloud solutions like GCP-LB, ELB or we should setup ngnix/ha-proxy/traefic
* Ingress has two layer, client-facing and actual services that are intercepted
  * Ingress + Resources (pods/services)
* Ingress has to be exposed as NodePort or LB IP to external world to expose the service

## Ingress tips

* All ingress configuration can come from configMap
  * That configmap should be passed as argument in ngnix-ingress-controller deployment
* We can start with empty configMap, later we can amend
* 


## Execute ngnix-ingress-controller deployment

* Steps to setup ngnix-ingress-controller
  * Create configMap inside namepace
  * Create NIC deployment
  * Create nodePort service and expose them
  * Create ServiceAccount 
  * Crate correct roles, rolebindings, clusterroles (so NIC can restart underlying service pods) and assign to ServiceAccount

```bash
kubectl run nc --image=quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.25.1 --dry-run -o yaml
```
### Above deployment is not enough as we have to pass additional argument about configMap to configure

* Pass the executable location of ngnix -- /ngnix-ingress-controller
* Pass the configMap -- configmap=$(POD_NAMESPACE)/ngnix-configuration
* Pass the POD_NAME and POD_NAMESPACE (of the ngnix-controller-deployment deployment)
* Pass the ports that NIC would listen to - /name[http]/containerPort=80, ports/name[https]/containerPort=443

## Ingres resource

* There are 3 types are resources are targetted by NIC
  * Forward all request to one-specific service (back-end)
  * Forward patterns of URL path to set of backend services (/video -> videoService, /shop -> shoppingService)
  * Forward set of request from a domain to a set of backend services (video.onlinedomain.com -> videoService, shop.onlinedomain.com -> shoppingService)

## Ingress rules

* Ingress rules should be unique for combination of domain-name+URL_path
* Ingress rules should be unique for combination of domain-name+URL_path
* Ingress rules will have one of the two type
  * Simple-one spec/backend/{serviceName: $SN, servicePort: $SP}
  * Comprehensive-one spec/rules/http/paths/path/backend/{serviceName: $SN, servicePort: $SP}

## Ingress rules for each domain

* Ingress rule should have host: field to configure for doamin specific rules
```yaml
  rules:
  - host: __INGRESS_HOST__
    http:
      paths:
      - backend:
          serviceName: kubernetes-dashboard
          servicePort: 80
        path: /
```

### Ingres resource just forward to static-service

```yaml
# https://github.com/kubernetes/ingress-nginx/raw/master/docs/examples/static-ip/nginx-ingress.yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-nginx
spec:
  tls:
  # This assumes tls-secret exists.
  - secretName: tls-secret
  rules:
  - http:
      paths:
      - backend:
          # This assumes http-svc exists and routes to healthy endpoints.
          serviceName: http-svc
          servicePort: 80
```          

https://github.com/kubernetes/ingress-nginx/blob/master/docs/examples/auth/oauth-external-auth/dashboard-ingress.yaml