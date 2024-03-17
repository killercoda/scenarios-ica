
[Expose](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/) `details` service through IngressGateway on host `my.details.com`. Verify via curl.

```plan
kubectl apply -f /root/solutions/step3-details-gw.yaml
```{{exec}}

Check for errors:
```plan
istioctl analyze -n default
```{{exec}}


FIXME: THIS DOES NOT WORK
```plan
export INGRESS="$(kubectl get nodes -o jsonpath='{.items[?(@.metadata.name == "node01")].status.addresses[?(@.type == "InternalIP")].address}'):$(kubectl get service -n istio-system istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')"
curl -HHost:my.details.com "http://$INGRESS/details/7" -v
```{{exec}}