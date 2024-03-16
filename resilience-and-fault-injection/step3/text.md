Configure the service `httpbin` and its subpath `httpbin:8000/status/200` to add 1s of delay in 20% of requests and observe the result.

```plan
kubectl apply -f /root/solutions/step3-fault-delay.yaml
```{{exec}}

```plan
for run in {1..10}; do
  kubectl exec sleep -- curl --no-progress-meter httpbin:8000/status/200
  echo
done
```{{exec}}

Configure the service `httpbin` and its path `httpbin:8000/status/201` to fail in 50% of times and validate via `curl`.

```plan
kubectl apply -f /root/solutions/step3-fault-abort.yaml
```{{exec}}

```plan
for run in {1..10}; do
  kubectl exec sleep -- curl --no-progress-meter httpbin:8000/status/201
  echo
done
```{{exec}}