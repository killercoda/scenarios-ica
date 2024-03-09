For `reviews`, send all traffic to v1. Also mirror all traffic for `reviews` version 1 service to `reviews` version 3 service. Edit already existing VirtualService from previous steps.

```plan
kubectl apply -f /root/solutions/step6-mirror.yaml
```{{exec}}

```plan
istioctl analyze -n default
```{{exec}}

Simulate a request:
```plan
kubectl exec sleep -- curl --no-progress-meter reviews:9080/reviews/7
echo
```{{exec}}

Check the logs of `reviews` to verify:
```plan
kubectl logs $(kubectl get pods -o name | grep reviews-v3) -c istio-proxy
```{{exec}}