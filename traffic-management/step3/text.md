
[Expose](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/) `details` service through IngressGateay on host `my.details.com`. Verify via curl.

FIXME: dynamic
```plan
kubectl apply -f /root/solutions/step3-details-gw.yaml

curl -HHost:my.details.com 172.30.1.2:31470/details/7 -v
echo
```{{exec}}

Force out oubound traffic via Egress Gateway.