
[Expose](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/) `details` service through IngressGateay on host `my.details.com`. Verify via curl.

FIXME: dynamic
```plan
export INGRESS="172.30.1.2:31479"
```{{exec}}

```plan
kubectl apply -f /root/solutions/step3-details-gw.yaml

curl -HHost:my.details.com "http://$INGRESS/details/7" -v
echo
```{{exec}}

[Route all oubound traffic](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/#egress-gateway-for-http-traffic) to external service `https://google.com` via Egress Gateway for Sleep pod in namespace `internet-blocked`.

Following `curl` will fail because of the restrictive NetworkPolicy.
```plan
curl -o /dev/null "http://google.com" -v
echo
```{{exec}}

Create new Gateway for egress traffic, add external DNS name to service mesh to make this work.

```plan
kubectl apply -f /root/solutions/step3-egress-gw.yaml
```{{exec}}

Routing through Egress Gateway should work.

```plan
curl -o /dev/null "http://google.com" -v
echo
```{{exec}}

Remove the NetworkPolicy.