For this example, default cluster-level policy is set to `DISABLE` to help you test your progress.

Configure required mTLS in the namespace `workload-level` between `sleep` pod and `httpbin` service on the workload level. (Don't forget to configure on both ends.)

```plan
kubectl apply -f /root/solutions/step3-workload-level.yaml
```{{exec}}

Check for problems:
```plan
istioctl analyze -n workload-level
```{{exec}}

```plan
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin.workload-level:8000/" -v
```{{exec}}
```plan
kubectl exec -n workload-level sleep -- curl -o /dev/null "http://httpbin.workload-level:8000/" -v
```{{exec}}


Do the same on the namespace level.
```plan
kubectl apply -f /root/solutions/step3-namespace-level.yaml
```{{exec}}

Check for problems:
```plan
istioctl analyze -n namespace-level
```{{exec}}

`sleep` from `default` namespace should not reach, but `sleep` from the same namespace should
```plan
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin.namespace-level:8000/" -v
```{{exec}}
```plan
kubectl exec -n namespace-level sleep -- curl -o /dev/null "http://httpbin.namespace-level:8000/" -v
```{{exec}}

Do the same on the cluster level. (Hint: Edit the existing resource)

```plan
kubectl apply -f /root/solutions/step3-cluster-level.yaml
```{{exec}}

Check for problems:
```plan
istioctl analyze -n default
```{{exec}}

Now `sleep` from `default` namespace can reach them all:
```plan
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin:8000/" -v
echo
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin.namespace-level:8000/" -v
echo
kubectl exec -n default sleep -- curl -o /dev/null "http://httpbin.workload-level:8000/" -v
echo
```{{exec}}