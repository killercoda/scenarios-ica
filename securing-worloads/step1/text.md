Observe these workloads:
- service `httpbin` in namespace `jwt` that requires a client to provide valid JWT token

This fails - no JWT authorization included:
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.jwt:8000/status/200" -v
```{{exec}}

This fails - JWT token is invalid:
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.jwt:8000/status/200" -H "Authorization: Bearer invalid.token" -v
```{{exec}}

This should work:
```plan
# download demo token
TOKEN_GROUP=$(curl https://raw.githubusercontent.com/istio/istio/release-1.21/security/tools/jwt/samples/groups-scope.jwt -s) && echo "$TOKEN_GROUP" | cut -d '.' -f2 - | base64 --decode
kubectl exec sleep -- curl -o /dev/null "http://httpbin.jwt:8000/status/200" -H "Authorization: Bearer $TOKEN_GROUP" -v
```{{exec}}


- service `httpbin` in namespace `mtls-permissive` that allows both non-mTLS and mTLS clients to connect (this is typically used before migrating fully to mTLS)

```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.mtls-permissive:8000/status/200" -v
```{{exec}}

- service `httpbin` in namespace `mtls-strict` that requires you to connect with mTLS

```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.mtls-permissive:8000/status/200" -v
```{{exec}}

- service `httpbin` in namespace `mtls-disable` that has mTLS disabled
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.mtls-permissive:8000/status/200" -v
```{{exec}}

Note that from `curl` point of view, you have no idea how the service mesh secures or does not secure the communication - you communicate in the same manner with all 3 variants of `mtls-X` namespaces. But try to connect directly from the terminal do `mtls-strict` which is exposed as Service.