Configure 100 retries in between for the `httpbin` service. Verify that it takes around 12s when you hit `httpbin:8000/status/500` error url.

```plan
kubectl apply -f /root/solutions/step2-retries.yaml
```{{exec}}

```plan
START=date
kubectl exec sleep -- curl -o /dev/null "http://httpbin:8000/status/500" -v
echo Started  at $START
echo Finished at $(date)
```{{exec}}

Observe number of requests in the log:
```plan
kubectl logs $(kubectl get pods -o name | grep httpbin-v1) -c istio-proxy | tail -n 120
```{{exec}}
