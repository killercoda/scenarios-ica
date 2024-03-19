Imagine, that you plan to install a VM `outside-vm` with `10.11.12.13` address completely separate from your Kubernetes cluster. VM should provider service labeled `app: inventory-lookup`. Add such a configuration that enables basic control over this VM.

```plan
cat /root/solutions/step1-external-vm-example.yaml
```{{exec}}

You also need to [install a sidecar](https://istio.io/latest/docs/setup/install/virtual-machine/) on the VM yourself.

Bonus: Can you provider more than [single service](https://istio.io/latest/docs/ops/deployment/vm-architecture/) via `outside-vm`?

Bonus 2: Does this mean that all outgoing traffic from `outside-vm` goes also through the side-proxy? (Similar to containers?)

<details><summary>Solution</summary>
<br>
Yes.
</details>