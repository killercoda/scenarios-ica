Configure 4 retries with 3s timeout in between for the `httpbin` service. Verify that it takes around 12s when you hit `httpbin:8000/status/500` error url.

```plan
kubectl apply -f /root/solutions/step2-retries.yaml
```{{exec}}

```plan
date
kubectl exec sleep -- curl -o /dev/null "http://httpbin:8000/status/500" -v
echo
date
```{{exec}}