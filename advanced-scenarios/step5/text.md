Our client has configured a mirroring of all the `httpbin` traffic to a separate security appliance in the namespace `security-appliance`. But currently the security compliance is not getting any traffic. Fix it.

You can then check the logs to see if the requests are visible in the logs or not:

```plan
kubectl exec sleep -- curl --no-progress-meter httpbin.security-appliance:8000/status/200
```{{exec}}

```plan
FIXME: get from multiple pods in the deployment?
kubectl logs -n security-appliance --all-containers security-appliance
```{{exec}}


TODO: hide this
This is an ugly one, but I have this from my personal experience - with traffic mirroring feature, you need to keep the same hostname, otherwise the traffic won't get routed correctly to the mirrored service. So you need to configure the security appliance to be under the same service as the real workload. Please note, that this can't be used if some services use kubernetes Service directly (because some regular request are routed to security-appliance instead of real workload).