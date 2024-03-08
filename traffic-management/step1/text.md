

Bookinfo has all component connected using regular Kubernetes Services. Pods have already Istio sidecars injected. Add [VirtualService](https://istio.io/latest/docs/tasks/traffic-management/request-routing/) and [DestinationRule](https://istio.io/latest/docs/examples/bookinfo/#define-the-service-versions) to control all 3 services, so they can be controlled via service mesh. Use appropriate labels of the deployments.

You can use Sleep pod (simplified Sleep demo app) `kubectl exec sleep -- curl INTERNAL_URL` to examine behaviour of the microservices from inside the cluster.

- service/details ->
  - deployment.apps/details-v1
- service/ratings ->
  - deployment.apps/ratings-v1
- service/reviews ->
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
kubectl exec sleep -- curl details:9080
echo '---'
kubectl exec sleep -- curl ratings:9080
echo '---'
kubectl exec sleep -- curl reviews:9080
```{{exec}}





