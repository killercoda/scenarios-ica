Setup [a circuit breaker](https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/#configuring-the-circuit-breaker) that will trip after single error in `10s` time window and make `httpbin` pod unavailable for `1 minute` in such a case. To simulate this, limit the amount of number of requests per connection to 1, so the second request triggers the error.

```plan
kubectl apply -f /root/solutions/step1-circuit-breaker.yaml
```{{exec}}

Do quickly these to observe the desired effect. First should be ok, second should trigger an error and third one should not get through because of the circuit breaker.
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin:8000/status/200" -v
```{{exec}}
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin:8000/status/500" -v
```{{exec}}
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin:8000/status/200" -v
```{{exec}}


Now let's try this without outlier detection. `reviews` version 2 takes `2 seconds` for each request. Configure it to maximum concurrency of 1 parallel connection and verify this. Edit already existing `DestinationRule`. Traffic is already routed to `v2`.

```plan
kubectl apply -f /root/solutions/step1-circuit-breaker-reviews.yaml
```{{exec}}

Do quickly these to observe the desired effect. First should be ok, second and third should fail - this is the theory. However there is some "slack" also mentioned in the docs, so it hard to trigger this way the limit.

```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin:8000/status/200" -v
```{{exec}}