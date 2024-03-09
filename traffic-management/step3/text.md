
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
kubectl exec -n internet-blocked sleep -- curl -o /dev/null "http://google.com" -v
echo
```{{exec}}

Create new Gateway for egress traffic, add external DNS name to service mesh to make this work.

```plan
kubectl apply -f /root/solutions/step3-egress-gw.yaml
```{{exec}}

Routing through Egress Gateway should work.

```plan
kubectl exec -n internet-blocked sleep -- curl -o /dev/null "http://google.com" -v
echo
```{{exec}}

FIXME: this show how both works...
You can inspect the diffent routing in the logs:
```plan
kubectl logs -n internet-blocked sleep --all-containers
```{{exec}}

```
[2024-03-09T11:56:16.364Z] "GET / HTTP/1.1" 301 - via_upstream - "-" 0 219 28 17 "-" "curl/8.6.0" "54a8f337-b172-9ab6-98bc-79eaa878e22e" "google.com" "142.250.185.142:80" PassthroughCluster 192.168.0.6:36026 142.250.185.142:80 192.168.0.6:36012 - allow_any
[2024-03-09T11:57:16.613Z] "GET / HTTP/1.1" 301 - via_upstream - "-" 0 219 39 35 "-" "curl/8.6.0" "e839838b-5177-9a37-b4c3-cddcf80f5c12" "google.com" "142.250.185.238:80" outbound|80||google.com 192.168.0.6:56686 142.250.185.238:80 192.168.0.6:56680 - default
```