In namespace `only-mesh-routing` there is a `sleep` pod that can connect only to services known to the service mesh. Add there all needed resources, so it can connect to `microsoft.com` both on HTTP and HTTPS.

This does not work now:
```plan
kubectl exec -n only-mesh-routing sleep -- curl -o /dev/null "http://microsoft.com" -v
echo
```{{exec}}

Add [required resources](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/#egress-gateway-for-http-traffic).

```plan
kubectl apply -f /root/solutions/step4-serviceentry.yaml
```{{exec}}

And this should work now:
```plan
kubectl exec -n only-mesh-routing sleep -- curl -o /dev/null "http://microsoft.com" -v
echo
```{{exec}}