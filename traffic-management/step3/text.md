
[Expose](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/) `details` service through IngressGateay on host `my.details.com`. Verify via curl.

```plan
kubectl apply -f /root/solutions/step3-details-gw.yaml
```{{exec}}

TODO: DYNAMIC IP
```plan
export INGRESS="172.30.1.2:31479"
curl -HHost:my.details.com "http://$INGRESS/details/7" -v
```{{exec}}