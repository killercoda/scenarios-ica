
- [Uninstall Istio](https://istio.io/latest/docs/setup/install/istioctl/#uninstall-istio).

<details><summary>Solution</summary>
<br>

```plain
istioctl uninstall --purge
```{{exec}}

</details>
<br>

- You can also remove the whole namespace:
```plain
kubectl delete namespace istio-system
```{{exec}}

<br>
