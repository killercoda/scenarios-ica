
- [Uninstall Istio](https://istio.io/latest/docs/setup/install/istioctl/#uninstall-istio).
```plain
istioctl uninstall --purge
```{{exec}}

- You can also remove the whole namespace:
```plain
kubectl delete namespace istio-system
```{{exec}}

<br>
