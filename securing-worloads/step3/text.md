For this example, default cluster-level policy is set to `DISABLE` to help you test your progress.

Configure required mTLS in the namespace `workload-level` between `sleep` pod and `httpbin` service on the workload level.

```plan
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin.workload-level:8000/" -v
echo
kubectl exec -n workload-level sleep -- curl -o /dev/null "http://httpbin.workload-level:8000/" -v
echo
```{{exec}}


Do the same on the namespace level.

`sleep` from default should not reach, but
```plan
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin.namespace-level:8000/" -v
echo
kubectl exec -n namespace-level sleep -- curl -o /dev/null "http://httpbin.namespace-level:8000/" -v
echo
```{{exec}}


Do the same on the cluster level. (Edit the existing resource.)

Not `sleep` from default can reach them all:
```plan
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin:8000/" -v
echo
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin.namespace-level:8000/" -v
echo
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin.workload-level:8000/" -v
echo
```{{exec}}