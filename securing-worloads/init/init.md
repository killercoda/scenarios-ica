<br>
Istio can support two basic authentization methods:
- JWT tokens (inside HTTP header of the request that the server can validate)
- mTLS (mutual TLS)

Istio can use mTLS  meaning that both parties that communicate establish a secure connection exchanging both client and server certificates in the process. This has basic implications:
- You can use identity defined in the certificate to grant access
- Do don't need do anything in the application itself to secure all of its incoming and outgoing communication
- But the service mesh must do a lot work behind the scenes (like [providing certificates](https://istio.io/latest/docs/tasks/security/cert-management/) etc.)

This is one of the major benefits of the service mesh concept, because otherwise all applications need to do this themselves (which is an enormous amount of work, configuration, tooling). Note that from application point of view, all communication seems to be done via unsecured HTTP only, but the proxy does all the work behind the scenes.