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

# install Bookinfo demo app: https://istio.io/latest/docs/examples/bookinfo/
kubectl label namespace default istio-injection=enabled
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-${ISTIO_MINOR_VERSION}/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-${ISTIO_MINOR_VERSION}/samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl apply -f /tmp/httpbin.yaml
kubectl apply -f /tmp/sleep-pod.yaml
kubectl apply -f /tmp/reviews.yaml

kubectl wait deployment --all --for condition=Available --timeout 2m

clear
echo "YOU ARE READY TO GO!"