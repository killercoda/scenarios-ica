
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

[Route all oubound traffic](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/#egress-gateway-for-http-traffic) to external service `https://google.com` via Egress Gateway.


FIXME: this does not work
Apply this "evil" NetworkPolicy that blocks `sleep` from  all internet access except local pod network. Following `curl` will fail.
```plan
kubectl apply -f /root/solutions/step3-block-default-direct-egress.yaml
```{{exec}}
```plan
curl -o /dev/null "http://google.com" -v
echo
```{{exec}}


```plan
kubectl apply -f /root/solutions/step3-egress-gw.yaml
```{{exec}}

Routing through Egress Gateway should work.

```plan
curl -o /dev/null "http://google.com" -v
echo
```{{exec}}

Remove the NetworkPolicy.