
Istioctl CLI is installed:
```plain
istioctl version
```{{exec}}

Now try to do following steps yourself.

- [List all available Istio Profiles](https://istio.io/latest/docs/setup/install/istioctl/#display-the-list-of-available-profiles) that can be installed

<br>
<details><summary>Solution</summary>
<br>
```plain
istioctl profile list
```{{exec}}
</details>

- [Show what is configuration](https://istio.io/latest/docs/setup/install/istioctl/#display-the-configuration-of-a-profile) of `external` profile of the `components.cni` part

<br>
<details><summary>Solution</summary>
<br>
```plain
istioctl profile dump external --config-path components.cni
```{{exec}}
</details>

- [Compare](https://istio.io/latest/docs/setup/install/istioctl/#show-differences-in-profiles) the `minimal` and the `default` profiles:

<br>
<details><summary>Solution</summary>
<br>
```plain
istioctl profile diff minimal default
```{{exec}}
</details>

- [Dump all resources](https://istio.io/latest/docs/setup/install/istioctl/#generate-a-manifest-before-installation) that will be installed in YAML format for profile `external`:

<br>
<details><summary>Solution</summary>
<br>
```plain
istioctl manifest generate --set profile=external
```{{exec}}
</solution>

- [Perform the Istio installation](https://istio.io/latest/docs/setup/install/istioctl/#install-istio-using-the-default-profile) with prepared `demo` profile (please use Killercoda-tuned manifest file):

<br>
<details><summary>Solution</summary>
<br>
```plain
istioctl install -f /root/profiles/demo.yaml
```{{exec}}
</details>

- [Verify the installation](https://istio.io/latest/docs/setup/install/istioctl/#verify-a-successful-installation):

<br>
<details><summary>Solution</summary>
<br>
```plain
istioctl verify-install -f /root/profiles/demo.yaml
```{{exec}}
```plain
kubectl -n istio-system get deploy
```{{exec}}
</details>

Hooray! You have successfully installed Istio.

<br>
