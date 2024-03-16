Istio is not working for the `httpbin` workload in `istio-should-work` namespace, fix it.

TODO: hide this:
- Verify that namespace should inject sidecar (see the namespace labels, check deployment labels)

```plan
kubectl get deployment -o yaml -n istio-should-work
kubectl get namespace --show-labels istio-should-work
```{{exec}}

Probably the workload was created before the label was added to the namespace. Restarting the deployment should do the trick:
```plan
kubectl rollout restart -n istio-should-work deployment httpbin
```{{exec}}

After a while, you should see sidecard inject `2/2`.
```plan
kubectl get pods -n istio-should-work
```{{exec}}