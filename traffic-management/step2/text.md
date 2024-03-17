Create a new namespace `all-injected`. Run an example Pod to see that it has the sidecar [injected](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/).

<br>
<details><summary>Solution</summary>
<br>
```plan
kubectl create ns all-injected
kubectl label namespace all-injected istio-injection=enabled
kubectl run --image nginx -n all-injected injected-nginx 
kubectl get pods -n all-injected -w
```{{exec}}
</details>

Create a new pod without a sidecar. Use annotation on the pod in `all-injected` to disable sidecar and verify the result.

<br>
<details><summary>Solution</summary>
<br>
```plan
kubectl run --image nginx -n all-injected --labels=sidecar.istio.io/inject=false no-sidecar-nginx
kubectl get pods -n all-injected -w
```{{exec}}
</details>

Create namespace `not-automatic` and create a pod with injected sidecar without using the labels at all.

<br>
<details><summary>Solution</summary>
<br>
```plan
kubectl create namespace non-automatic
kubectl run --image nginx -n non-automatic non-automatic-nginx --dry-run=client -o yaml | istioctl kube-inject -f - | kubectl apply -f -
```{{exec}}
</details>