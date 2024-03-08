

Bookinfo has all component connected using regular Kubernetes Services. Pods have already Istio sidecars injected. Convert all 3 services and all appropriate deployments to VirtualService, so they can be controlled via service mesh. Use appropriate labels of the deployments.

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

Check that bookinfo app works along with app microservices behind it.

```plan
kubectl exec sleep -- curl bookinfo
```{{exec}}





