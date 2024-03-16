Make workload `httpbin` in namespace `mtls-strict` accept requests only from pods in namespace default `default`. You can use `sleep` Pod in namespace `non-default` to check that this works.

```plan
kubectl apply -f /root/solutions/step2-secure-mtls-strict.yaml
```{{exec}}

This should work:
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.mtls-strict:8000/status/200" -v
echo
```{{exec}}

This should not:
```plan
kubectl exec -n non-default sleep -- curl -o /dev/null "http://httpbin.mtls-strict:8000/status/200" -v
echo
```{{exec}}

Bonus: think about how this is diffent from using `NetworkPolicy`.

Now configure Istio to deny all traffic to workload `httpbin` in namespace `mtls-permissive`.

```plan
kubectl apply -f /root/solutions/step2-deny-all.yaml
```{{exec}}

This should fail:
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.mtls-permissive:8000/status/200" -v
echo
```{{exec}}

Now add a rule to allow `GET` requests to `/status/200`. Everything else should stay blocked.

```plan
kubectl apply -f /root/solutions/step2-allow-get.yaml
```{{exec}}

This should work:
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.mtls-permissive:8000/status/200" -v
echo
```{{exec}}

This should fail:
```plan
kubectl exec sleep -- curl -o /dev/null -XPOST "http://httpbin.mtls-permissive:8000/status/200" -v
echo
```{{exec}}