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

# default ns
kubectl label namespace default istio-injection=enabled
kubectl apply -f /tmp/sleep-pod.yaml

# step2 - egress ns
kubectl create namespace egress
kubectl label namespace egress istio-injection=enabled
kubectl apply -n egress -f /tmp/egress-broken.yaml
kubectl apply -n egress -f /tmp/sleep-pod.yaml

# step3 - istio-should-work ns
kubectl create namespace istio-should-work
kubectl apply -n istio-should-work -f /tmp/httpbin.yaml
kubectl label namespace istio-should-work istio-injection=enabled

# step4 - outside-blocked ns
kubectl create namespace outside-blocked
kubectl label namespace outside-blocked istio-injection=enabled
kubectl apply -n outside-blocked -f /tmp/outside-blocked.yaml
kubectl apply -n outside-blocked -f /tmp/sleep-pod.yaml

kubectl -n outside-blocked wait pod --all --for condition=Ready --timeout 2m

clear
echo "YOU ARE READY TO GO!"