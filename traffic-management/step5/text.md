Let's get back to `default` namespace for now.

Try to [inject 50% faults](https://istio.io/latest/docs/tasks/traffic-management/fault-injection/) into `ratings` v1 and verify.

```plan
kubectl apply -f /root/solutions/step5-ratings-faults.yaml
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


Try to add `1s` delay for service `details` v1 in 30% of calls and verify.

```plan
kubectl apply -f /root/solutions/step5-details-slowdown.yaml
```{{exec}}

Check for errors:
```plan
istioctl analyze -n default
```{{exec}}

Verify:
```plan
for run in {1..10}; do
  kubectl exec sleep -- curl --no-progress-meter details:9080/details/7
  echo
done
```{{exec}}




Now switch details to version 2 and add `0.5s` timeout the same service. Version 2 is flawed and won't reply in 2s timeout. So all requests will fail, some after `0.5s`, some after `2s`.
(FIXME: check this fact)

```plan
kubectl apply -f /root/solutions/step5-details-slowdown-with-timeout.yaml
```{{exec}}

Check for errors:
```plan
istioctl analyze -n default
```{{exec}}

Verify:
```plan
for run in {1..10}; do
  kubectl exec sleep -- curl --no-progress-meter details:9080/details/7
  echo
done
```{{exec}}