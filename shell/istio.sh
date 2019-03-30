# fast installation without helm
# download package and set environment variable
cd /usr/local/istio
for i in install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done

kubectl apply -f install/kubernetes/istio-demo.yaml
# kubectl apply -f install/kubernetes/istio-demo-auth.yaml

kubectl get svc -n istio-system
kubectl get pods -n istio-system

kubectl label namespace <namespace> istio-injection=enabled
kubectl create -n <namespace> -f <your-app-spec>.yaml

istioctl kube-inject -f <your-app-spec>.yaml | kubectl apply -f -

kubectl delete -f install/kubernetes/istio-demo.yaml
# kubectl delete -f install/kubernetes/istio-demo-auth.yaml

for i in install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl delete -f $i; done

# install istio by helm
# brew install kubernetes-helm
helm help
helm init --history-max 200

kubectl create namespace istio-system
helm template install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -
kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l
helm template install/kubernetes/helm/istio --name istio --namespace istio-system | kubectl apply -f -

kubectl get svc -n istio-system
kubectl get pods -n istio-system

helm template install/kubernetes/helm/istio --name istio --namespace istio-system | kubectl delete -f -
kubectl delete namespace istio-system

# kubectl delete -f install/kubernetes/helm/istio-init/files

# install istio by helm and tiller
kubectl apply -f install/kubernetes/helm/helm-service-account.yaml
helm init --service-account tiller
helm install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system
kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l
helm install install/kubernetes/helm/istio --name istio --namespace istio-system 
