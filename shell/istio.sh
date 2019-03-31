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

# deploy bookinfo
# kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
kubectl label namespace default istio-injection=enabled
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get services
kubectl get pods
kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl get gateway
# export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
curl -s http://${GATEWAY_URL}/productpage | grep -o "<title>.*</title>"
kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
# kubectl apply -f samples/bookinfo/networking/destination-rule-all-mtls.yaml
kubectl get destinationrules -o yaml

# samples/bookinfo/platform/kube/cleanup.sh
kubectl get virtualservices   #-- there should be no virtual services
kubectl get destinationrules  #-- there should be no destination rules
kubectl get gateway           #-- there should be no gateway
kubectl get pods              #-- the Bookinfo pods should be deleted

# intelligent routing
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl get virtualservices -o yaml
kubectl get destinationrules -o yaml
# http://localhost:80/productpage

# login by jason
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
kubectl get virtualservice reviews -o yaml

# kubectl delete -f samples/bookinfo/networking/virtual-service-all-v1.yaml

# fault injection
kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml
kubectl get virtualservice ratings -o yaml

kubectl apply -f samples/bookinfo/networking/virtual-service-ratings-test-abort.yaml
kubectl get virtualservice ratings -o yaml

# kubectl delete -f samples/bookinfo/networking/virtual-service-all-v1.yaml

# traffic shifting
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-50-v3.yaml
kubectl get virtualservice reviews -o yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-v3.yaml

# kubectl delete -f samples/bookinfo/networking/virtual-service-all-v1.yaml

# telemetry
istioctl create -f telemetry.yaml
kubectl -n istio-system get svc prometheus
# http://$GATEWAY_URL/productpage
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') 9090:9090 &
# killall kubectl
# http://localhost:9090/graph
# Expression: istio_request_bytes_count
# istio_request_bytes_count{destination_service="productpage.default.svc.cluster.local"}
# istio_request_bytes_count{destination_service="reviews.default.svc.cluster.local", destination_version="v3"}
# rate(istio_request_bytes_count{destination_service=~"productpage.*", response_code="200"}[5m])
kubectl -n istio-system logs -l istio-mixer-type=telemetry -c mixer | grep "instance='newlog.logentry'"
istioctl delete -f telemetry.yaml

# grafana dashboard
helm template --set grafana.enabled=true install/kubernetes/helm/istio --name istio --namespace istio-system | kubectl apply -f -
kubectl -n istio-system get svc prometheus
kubectl -n istio-system get svc grafana
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
# http://localhost:3000/dashboard/db/istio-mesh-dashboard
# http://localhost:3000/dashboard/db/istio-service-dashboard
# http://localhost:3000/dashboard/db/istio-workload-dashboard 
killall kubectl

# kubectl -n istio-system edit deploy istio-pilot

# jaeger
helm template install/kubernetes/helm/istio --name istio --namespace istio-system --set tracing.enabled=true,tracing.ingress.enabled=true | kubectl apply -f -
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 &
# http://localhost:16686
killall kubectl

# zipkin
helm template install/kubernetes/helm/istio --name istio --namespace istio-system --set tracing.enabled=true,tracing.provider=zipkin,tracing.ingress.enabled=true | kubectl apply -f -
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=zipkin -o jsonpath='{.items[0].metadata.name}') 9411:9411 &
# http://localhost:9411
killall kubectl
