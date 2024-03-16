Imagine, that you plan to install a VM `outside-vm` with `10.11.12.13` address completely separete from you Kubernetes cluster. Add such a configuration that enables basic control over this VM.

```plan
cat /root/solutions/step1-external-vm-example.yaml
```{{exec}}

You also need to [install a sidecar](https://istio.io/latest/docs/setup/install/virtual-machine/) on the VM yourself.