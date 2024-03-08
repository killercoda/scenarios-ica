
Istio has been installed like described [here](https://istio.io/latest/docs/setup/getting-started).

Current profile is `demo` with slight tuning for Killercoda environment. You have these components prepared:
- istiod
- istio-egressgateway
- istio-ingressgateway

Check the installed version:

```plain
istioctl version
```{{exec}}

Also the demo app [Bookinfo](https://istio.io/latest/docs/examples/bookinfo/) is already installed, so you can experiment:
```plan
# get all Bookinfo services in namespace default
kubectl get services

# get all pods
kubectl get pods

# To confirm that the Bookinfo application is running, send a request to it by a curl command from some pod, for example from ratings:
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"
# should return '<title>Simple Bookstore App</title>'
```{{exec}}

<br>
