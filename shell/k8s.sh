# minikube
# create cluster
minikube version
minikube start
kubectl version
kubectl cluster-info
kubectl get nodes 	
# deploy app
kubectl run kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1 --port=8080
kubectl get deployments
kubectl proxy
curl http://localhost:8001/version
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metdata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/
# explore app
kubectl get pods
kubectl describe pods
kubectl logs $POD_NAME
kubectl exec $POD_NAME env
kubectl exec -it $POD_NAME bash
cat server.js
curl localhost:8080
exit
# expose app publicly
kubectl get services
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
kubectl describe services/kubernetes-bootcamp
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index.spec.ports 0).nodePort}}')
curl $(minikube ip):$NODE_PORT
kubectl describe deployment
kubectl get pods -l run=kubernetes-bootcamp
kubectl get services -l run=kubernetes-bootcamp
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
kubectl label pod $POD_NAME app=v1
kubectl describe pods $POD_NAME
kubectl get pods -l app=v1
kubectl delete service -l run=kubernetes-bootcamp
kubectl get services
curl $(minikube ip):$NODE_PORT
kubectl exec -it $POD_NAME curl localhost:8080
# scale app

# update app

