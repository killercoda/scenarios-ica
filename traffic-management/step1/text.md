There is a `Bookinfo` demo application installed in the cluster. It has all the component connected using regular Kubernetes Services. Pods have already Istio sidecars injected. Add [VirtualService](https://istio.io/latest/docs/tasks/traffic-management/request-routing/) and [DestinationRule](https://istio.io/latest/docs/examples/bookinfo/#define-the-service-versions) to control all 3 services, so they can be controlled via service mesh. Use appropriate labels of the deployments.

You can use Sleep pod (simplified Sleep demo app) `kubectl exec sleep -- curl INTERNAL_URL` to examine behaviour of the microservices from inside the cluster.

- service/details ->
  - deployment.apps/details-v1
- service/ratings ->
  - deployment.apps/ratings-v1
- service/reviews -> (point it to version 1 for now)
  - deployment.apps/reviews-v1
  - deployment.apps/reviews-v2
  - deployment.apps/reviews-v3

```plan
kubectl apply -f /root/solutions/step1-details.yaml -f /root/solutions/step1-ratings.yaml -f /root/solutions/step1-reviews.yaml
```{{exec}}

Verify via istioctl.

```plan
istioctl analyze -n default
```{{exec}}

Check that bookinfo app works along with app microservices behind it.

```plan
kubectl exec sleep -- curl --no-progress-meter details:9080/details/7 -v
```{{exec}}

```plan
kubectl exec sleep -- curl --no-progress-meter ratings:9080/ratings/7
```{{exec}}

```plan
kubectl exec sleep -- curl --no-progress-meter reviews:9080/reviews/7
```{{exec}}

Try to simulate canary deployment - for reviews service, move 40% of traffic to v2. Check the output of the service.

```plan
kubectl apply -f /root/solutions/step1-reviews-40-to-v2.yaml
```{{exec}}

Verify via istioctl.

```plan
istioctl analyze -n default
```{{exec}}

Check that around 40 percent goes to v2.

```plan
for run in {1..10}; do
  kubectl exec sleep -- curl --no-progress-meter reviews:9080/reviews/7
  echo
done
```{{exec}}

Shift all traffic to v2 now.

```plan
kubectl apply -f /root/solutions/step1-reviews-all-to-v2.yaml
```{{exec}}

Verify via istioctl.

```plan
istioctl analyze -n default
```{{exec}}

Check that all goes to v2.

```plan
for run in {1..10}; do
  kubectl exec sleep -- curl --no-progress-meter reviews:9080/reviews/7
  echo
done
```{{exec}}

Now introduce new version 3 just if the header 'X-Special: yes" is present. For other request show v2 still.

```plan
kubectl apply -f /root/solutions/step1-reviews-header-to-v3.yaml
```{{exec}}

Verify via istioctl.

```plan
istioctl analyze -n default
```{{exec}}

Check that non-header traffic goes to v2 and with header the traffic gets v3 reponse.

```plan
kubectl exec sleep -- curl --no-progress-meter reviews:9080/reviews/7 -v
```{{exec}}

```plan
kubectl exec sleep -- curl -Hx-special:yes --no-progress-meter reviews:9080/reviews/7 -v
```{{exec}}