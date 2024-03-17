
With using `/root/profiles/demo.yaml` do the following:

- Update the Istio installation and [enable access logging](https://istio.io/latest/docs/tasks/observability/logs/access-log/) to `/dev/stdout` via `istioctl`:

<details><summary>Solution</summary>
<br>

```plain
istioctl install -f /root/profiles/demo.yaml --set meshConfig.accessLogFile=/dev/stdout
```{{exec}}

</details>
<br>

- Do the same via updated demo.yaml:

```plain
istioctl install -f /root/profiles/demo-with-access-log.yaml
```{{exec}}

<details><summary>Solution</summary>
<br>

```plain
diff /root/profiles/demo.yaml /root/profiles/demo-with-access-log.yaml
```{{exec}}

</details>
<br>

- Reinstall and disable the Egress gateway component (copy and modify demo.yaml):

```plain
istioctl install -f /root/profiles/demo-without-egress-gw.yaml
```{{exec}}

<details><summary>Solution</summary>
<br>

```plain
diff /root/profiles/demo.yaml /root/profiles/demo-without-egress-gw.yaml
```{{exec}}

</details>
<br>

- Display the parameters of the current installation:

<details><summary>Solution</summary>
<br>

```plain
kubectl get IstioOperator -n istio-system -o yaml installed-state
```{{exec}}

</details>
<br>