Create a new namespace `all-injected`. Run an example Pod to see that it has [injected sidecar](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/).

```plan
kubectl create ns all-injected
kubectl labale all-injected istio-injected=enabled
kubectl run --image nginx -n all-injected injected-nginx 
kubectl get pods -n all-injected -w
```{{exec}}


Use annotation on the pod in `all-injected` to disable sidecar and verify the result.
```plan
kubectl run --image nginx -n all-inject --labels=sidecar.istio.io/inject=false no-sidecar-nginx
kubectl get pods -n all-injected -w
```{{exec}}

Create namespace `not-automatic` and create a pod with injected sidecar.
```plan
kubectl create namespace non-automatic
kubectl run --image nginx -n non-automatic non-automatic-nginx --dry-run | istioctl kube-inject -
```{{exec}}

