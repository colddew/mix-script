# kubectl completion
echo "source <(kubectl completion zsh)" >> ~/.zshrc

# add k8s dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl proxy
TOKEN=$(kubectl -n kube-system describe secret default| awk '$1=="token:"{print $2}')
kubectl config set-credentials docker-for-desktop --token="${TOKEN}"
# http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

# check k8s installation
kubectl version
kubectl get nodes
kubectl cluster-info
kubectl logs <pod-name> -f

# access k8s service 
kubectl run hello-world --replicas=2 --labels="run=load-balancer-example" --image=anjia0532/google-samples.node-hello:1.0 --port=8080
kubectl get deployments hello-world
kubectl describe deployments hello-world
kubectl get replicasets
kubectl describe replicasets
kubectl expose deployment hello-world --type=NodePort --name=example-service
# kubectl expose deployment hello-world --type=LoadBalancer --name=example-service
kubectl scale deployment hello-world --replicas=3
kubectl get service example-service
kubectl describe services example-service
kubectl get pods --selector="run=load-balancer-example" --output=wide
# curl http://<public-node-ip>:<node-port>
kubectl delete services example-service
kubectl delete deployment hello-world

# frontend connect to backend service 
# nginx-frontend.conf
# upstream hello {
#    server hello;
#}
#server {
#    listen 80;
#
#    location / {
#        proxy_pass http://hello;
#    }
#}

kubectl create -f hello.yaml
kubectl get deployments
kubectl describe deployment hello
kubectl create -f hello-service.yaml
kubectl get service hello -o wide
kubectl create -f frontend.yaml
kubectl create -f frontend-service.yaml
kubectl get service frontend --watch
curl http://${EXTERNAL_IP}

# update and rollback version
kubectl set image deployment nginx-deployment nginx=nginx:1.13
kubectl rollout history deployment nginx-deployment
kubectl rollout undo deployment nginx-deployment
