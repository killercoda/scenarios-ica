FILE=/ks/wait-background.sh; while ! test -f ${FILE}; do clear; sleep 0.1; done; bash ${FILE}

# NOTE: keep the version with sync with official: https://docs.linuxfoundation.org/tc-docs/certification/important-instructions-ica#ica-exam-environment
export ISTIO_MINOR_VERSION=1.18
export ISTIO_VERSION=1.18.2
curl -L https://istio.io/downloadIstio | TARGET_ARCH=x86_64 sh -
echo "export PATH=/root/istio-${ISTIO_VERSION}/bin:\$PATH" >> .bashrc
export PATH=/root/istio-${ISTIO_VERSION}/bin:$PATH
mv /tmp/demo.yaml /root/istio-${ISTIO_VERSION}/manifests/profiles/
istioctl install --set profile=demo -y --manifests=/root/istio-${ISTIO_VERSION}/manifests

mkdir -p /root/solutions/
mv /tmp/step*.yaml /root/solutions/

kubectl apply -f /tmp/disable-mtls.yaml

# default ns
kubectl label namespace default istio-injection=enabled
kubectl apply -f /tmp/httpbin.yaml
kubectl apply -f /tmp/sleep-pod.yaml

# step1
for NS in (mtls-permissive mtls-strict mtls-disable jwt); do
    kubectl create namespace $NS
    kubectl label namespace $NS istio-injection=enabled
    kubectl apply -n $NS /tmp/httpbin.yaml
done
kubectl apply -f /tmp/env-step1.yaml

# workload-level ns
kubectl create namespace workload-level
kubectl label namespace workload-level istio-injection=enabled
kubectl apply -n workload-level -f /tmp/httpbin.yaml
kubectl apply -n workload-level -f /tmp/sleep-pod.yaml

# namespace-level ns
kubectl create namespace namespace-level
kubectl label namespace namespace-level istio-injection=enabled
kubectl apply -n namespace-level -f /tmp/httpbin.yaml
kubectl apply -n namespace-level -f /tmp/sleep-pod.yaml

kubectl -n namespace-level wait pod --all --for condition=Ready --timeout 2m

clear
echo "YOU ARE READY TO GO!"