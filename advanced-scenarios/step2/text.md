There is an egress gateway deployed in `istio-system` via this installation:

TODO: install

Route all traffic from namespace `egress` out of the cluster through the egress gateway and verify this in the logs. You can use `sleep` container to issue requests.

```plan
kubectl exec -n egress sleep -- curl --no-progress-meter google.com
```{{exec}}

```plan
TODO: egress gw
kubectl logs -n istio-system 
```{{exec}}