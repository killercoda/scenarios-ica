The pod `sleep` in `outside-blocked` namespace is trying to reach `google.com`, but this does not work. Investigate the problem and fix it.

Verify that this does not work:
```plan
kubectl exec -n outside-blocked sleep -- curl --no-progress-meter google.com -v
```{{exec}}

Hint?
TODO: HIDE THIS
```plan
kubectl get -n outside-blocked sidecars
```{{exec}}

Apply the fix:
```plan
kubectl apply -f /root/solutions/step4-fix.yaml
```{{exec}}

Should be ok now:
```plan
kubectl exec -n outside-blocked sleep -- curl --no-progress-meter google.com -v
```{{exec}}