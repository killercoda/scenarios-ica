There is an egress gateway deployed in `istio-system` via this installation:

```yaml
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  ...
  components:
    egressGateways:
    - name: istio-egressgateway
      enabled: true
      ...
```

[Route all HTTP traffic](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/) from namespace `egress` out of the cluster to `microsoft.com` through the egress gateway and verify this in the logs. You can use `sleep` container to issue requests.

```plan
kubectl apply -f /root/solutions/step2-egress.yaml
```{{exec}}

```plan
kubectl exec -n egress sleep -- curl --no-progress-meter microsoft.com
```{{exec}}

```plan
kubectl logs -l istio=egressgateway -n istio-system -c istio-proxy | tail -n 20
```{{exec}}