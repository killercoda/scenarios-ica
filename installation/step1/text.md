
Istioctl CLI is installed:
```plain
istioctl version
```{{exec}}

Now try to do following steps yourself.

1. [List all available Istio Profiles](https://istio.io/latest/docs/setup/install/istioctl/#display-the-list-of-available-profiles) that can be installed
```plain
istioctl profile list
```{{exec}}

2. [Show what is configuration](https://istio.io/latest/docs/setup/install/istioctl/#display-the-configuration-of-a-profile) of `external` profile of the `components.cni` part
```plain
profile dump external --config-path components.cni
```{{exec}}

3. [Compare](https://istio.io/latest/docs/setup/install/istioctl/#show-differences-in-profiles) the `minimal` and the `default` profiles:
```plain
istioctl profile diff minimal default
```{{exec}}

4. [Dump all resources](https://istio.io/latest/docs/setup/install/istioctl/#generate-a-manifest-before-installation) that will be installed in YAML format for profile `external`:
```plain
istioctl manifest generate --set profile=external
```{{exec}}

5. [Perform the Istio installation](https://istio.io/latest/docs/setup/install/istioctl/#install-istio-using-the-default-profile) with prepared `demo` profile (please use Killercoda-tuned manifest file):
```plain
istioctl install -f /root/profiles/demo.yaml
```{{exec}}

6. [Verify the installation](https://istio.io/latest/docs/setup/install/istioctl/#verify-a-successful-installation):
```plain
istioctl verify-install -f /root/profiles/demo.yaml
```{{exec}}
```plain
kubectl -n istio-system get deploy
```{{exec}}

Hooray! You have successfully installed Istio.

<br>
