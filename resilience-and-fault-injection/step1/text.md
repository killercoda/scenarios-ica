Setup [circuit breaker](https://istio.io/latest/docs/tasks/traffic-management/circuit-breaking/#configuring-the-circuit-breaker) that will trip after single error in 10s and make `httpbin` pod unavailable for 1 minute. To simulate this, limit the amount of number of requests per connection to 1, so the second request triggers the error.

```plan
kubectl apply -f /root/solutions/step1-circuit-breaker.yaml
```{{exec}}

Do quickly these to observe the desired effect. First should be ok, second should trigger an error and third one should not get through because of the circuit breaker.
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin:8000/status/200" -v
echo
kubectl exec sleep -- curl -o /dev/null "http://httpbin:8000/status/500" -v
echo
kubectl exec sleep -- curl -o /dev/null "http://httpbin:8000/status/200" -v
echo
```{{exec}}


Now let's try this without outlier detection. `reviews` version 2 takes 2 seconds for each request. Configure it to maximum concurrency of 1 parallel connection and verify this. Edit already existing `DestinationRule`. Traffic is already routed to v2.


```plan
kubectl apply -f /root/solutions/step1-circuit-breaker-reviews.yaml
```{{exec}}

Do quickly these to observe the desired effect. First should be ok, second and third should fail.
```plan
kubectl exec sleep -- curl -o /dev/null "http://reviews:9080/reviews/7" -v
echo
kubectl exec sleep -- curl -o /dev/null "http://reviews:9080/reviews/7" -v
echo
kubectl exec sleep -- curl -o /dev/null "http://reviews:9080/reviews/7" -v
echo
```{{exec}}