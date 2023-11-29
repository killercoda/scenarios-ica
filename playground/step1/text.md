
Istio has been installed like described [here](https://istio.io/latest/docs/setup/getting-started).

Check the installed version:

```plain
istioctl version
```{{exec}}

<br>

### Access Istio
We port-forward to the Istio ingressgateway service:

```plain
kubectl port-forward -n istio-system --address 0.0.0.0 service/istio-ingressgateway 1234:80
```{{exec}}

And then [ACCESS]({{TRAFFIC_HOST1_1234}}) Istio <small>(or [select the port here]({{TRAFFIC_SELECTOR}}))</small>.

> If there are no Istio Gateways and VirtualServices then an error will be thrown


### Install samples
There are samples to install in `/root/istio-1.14.4/samples`.

For guided Istio samples see:

[Helloworld Sample](https://killercoda.com/istio/scenario/samples-helloworld)

[Bookinfo Sample](https://killercoda.com/istio/scenario/samples-bookinfo)
