Istio can support two basic authentization methods:
- JWT tokens (inside HTTP header of the request that the server can validate)
- mTLS (mutual TLS)

Istio can use mTLS  meaning that both parties that communicate establish a secure connection exchanging both client and server certificates in the process. This has basic implications:
- You can use identity defined in the certificate to grant access
- Do don't need do anything in the application itself to secure all of its incoming and outgoing communication
- But the service mesh must do a lot work behind the scenes (like [providing certificates](https://istio.io/latest/docs/tasks/security/cert-management/) etc.)

This is one of the major benefits of the service mesh concept, because otherwise all applications need to do this themselves (which is an enormous amount of work, configuration, tooling). Note that from application point of view, all communication seems to be done via unsecured HTTP only, but the proxy does all the work behind the scenes.

Observe these workloads:
- service `httpbin` in namespace `jwt` that requires a client to provide valid JWT token

This fails - no JWT authorization included:
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.jwt:8000/status/200" -v
echo
```{{exec}}

This fails - JWT token is invalid:
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.jwt:8000/status/200" -H "Authorization: Bearer invalid.token" -h
echo
```{{exec}}

This should work:
```plan
# download demo token
TOKEN_GROUP=$(curl https://raw.githubusercontent.com/istio/istio/release-1.21/security/tools/jwt/samples/groups-scope.jwt -s) && echo "$TOKEN_GROUP" | cut -d '.' -f2 - | base64 --decode
kubectl exec sleep -- curl -o /dev/null "http://httpbin.jwt:8000/status/200" -H "Authorization: Bearer $TOKEN_GROUP" -v
echo
```{{exec}}


- service `httpbin` in namespace `mtls-permissive` that allows both non-mTLS and mTLS clients to connect (this is typically used before migrating fully to mTLS)

```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.mtls-permissive:8000/status/200" -v
echo
```{{exec}}

- service `httpbin` in namespace `mtls-strict` that requires you to connect with mTLS

```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.mtls-permissive:8000/status/200" -v
echo
```{{exec}}

- service `httpbin` in namespace `mtls-disable` that has mTLS disabled
```plan
kubectl exec sleep -- curl -o /dev/null "http://httpbin.mtls-permissive:8000/status/200" -v
echo
```{{exec}}

Note that from `curl` point of view, you have no idea how the service mesh secures or does not secure the communication - you communicate in the same manner with all 3 variants of `mtls-X` namespaces. But try to connect directly from the terminal do `mtls-strict` which is exposed as Service.

```plan
# TODO: get IP here

curl -o /dev/null "http://httpbin.mtls-permissive:8000/status/200" -v
echo
```{{exec}}



