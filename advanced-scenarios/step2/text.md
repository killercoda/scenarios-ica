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
kubectl exec -n egress sleep -- curl --no-progress-meter microsoft.com -v
```{{exec}}

```plan
kubectl logs -l istio=egressgateway -n istio-system -c istio-proxy | tail -n 20
```{{exec}}

You should see something like this in the logs:
```
[2024-XX-XXT16:12:44.905Z] "GET / HTTP/2" 301 - via_upstream - "-" 0 0 19 18 "192.168.1.8" "curl/8.6.0" "3012f2c1-1c89-95ca-8322-6de88feeb441" "microsoft.com" "20.76.201.171:80" outbound|80||microsoft.com 192.168.1.6:42008 192.168.1.6:8080 192.168.1.8:49070 - -
```