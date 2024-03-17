Try to install a [secondary Istio installation](https://istio.io/latest/docs/setup/upgrade/canary/) with revision `canary`. Try to run a simple workload to verify under the new Istio installation.

- Check the system before the installation
```plain
istioctl x precheck
```{{exec}}

- Install a `canary` Istio revision to the `istio-system` namespace next to already installed one:

<br>
<details><summary>Solution</summary>
<br>
```plain
istioctl install --set revision=canary -f /root/profiles/demo.yaml
```{{exec}}
</details>

- Verify the installation (there are 2 Istio installations now)

<br>
<details><summary>Solution</summary>
<br>
```plain
kubectl get pods -n istio-system -l app=istiod
kubectl get svc -n istio-system -l app=istiod
kubectl get mutatingwebhookconfigurations
```{{exec}}
</details>

- Create a new namespace `canary-ns` controlled via `canary` Istio. Also ensure that namespace does not have label `istio-injection` as it would take precedence over `istio.io/rev`.

<br>
<details><summary>Solution</summary>
<br>
```plain
kubectl create ns canary-ns
kubectl label namespace canary-ns istio-injection- istio.io/rev=canary
```{{exec}}
</details>

- Run an example workload in `canary-ns` (nginx for example):

```plain
kubectl run --image=nginx -n canary-ns my-canary-nginx
```{{exec}}

- Verify it has sidecar injected and is running on new canary Istio:
```plain
kubectl get pods -n canary-ns
istioctl proxy-status | grep "\.canary-ns "
```{{exec}}

- Cleanup namespace `canary-ns` and `canary` Istio installation

<br>
<details><summary>Solution</summary>
<br>
```plain
kubectl delete namespace canary-ns
istioctl uninstall --set revision=canary -f /root/profiles/demo.yaml
```{{exec}}
</details>

<br>
