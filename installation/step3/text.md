With using `/root/profiles/demo.yaml` do the following:

- Update demo.yaml [limits memory to '1Mi'](https://istio.io/latest/docs/setup/install/istioctl/#display-the-configuration-of-a-profile) for Pilot component.
```plain
diff /root/profiles/demo.yaml /root/profiles/demo-overlay.yaml
istioctl install -f /root/profiles/demo-overlay.yaml
```{{exec}}

<br>
