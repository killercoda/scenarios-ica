Mirror all traffic for `details` version 1 service to `httpbin` version 1 service. Edit already existing VirtualService from previous steps.

```plan
kubectl apply -f /root/solutions/step6-mirror.yaml
```{{exec}}

```plan
istioctl analyze -n default
```{{exec}}

Simulate a request:
kubectl exec sleep -- curl --no-progress-meter details:9080/details/7

Check the logs of `httpbin` to verify:
```plan
kubectl logs httpbin --all-containers
```{{exec}}