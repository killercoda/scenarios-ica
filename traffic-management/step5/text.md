Let's get back to `default` namespace for now.

Try to inject 50% of fault into ratings v1 and verify.

```plan
kubectl apply -f /root/solutions/step5-details-faults.yaml
```{{exec}}

```plan
istioctl analyze -n default
```{{exec}}

```plan
for run in {1..10}; do
  kubectl exec sleep -- curl --no-progress-meter ratings:9080/ratings/7
  echo
done
```{{exec}}


Try to add 1s delay fro service details v1 in 30% of calls and verify.

```plan
kubectl apply -f /root/solutions/step5-details-slowdown.yaml
```{{exec}}

```plan
istioctl analyze -n default
```{{exec}}

```plan
for run in {1..10}; do
  kubectl exec sleep -- curl --no-progress-meter details:9080/details/7
  echo
done
```{{exec}}



