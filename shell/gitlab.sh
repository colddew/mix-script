# https://github.com/helm/charts/blob/master/stable/gitlab-ce/values.yaml
# helm install --name gitlab -f values.yaml stable/gitlab-ce --namespace gitlab

# https://docs.gitlab.com/charts/
helm repo add gitlab https://charts.gitlab.io/
helm repo list
helm search -l gitlab/gitlab

helm repo update
helm upgrade --install gitlab gitlab/gitlab --timeout 600 --set global.hosts.domain=plantlink.io --set global.hosts.externalIP=127.0.0.1 --set certmanager-issuer.email=admin@plantlink.io
helm ls
helm status gitlab
kubectl get secret <name>-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

helm repo update
helm get values gitlab > gitlab.yaml
helm upgrade gitlab gitlab/gitlab -f gitlab.yaml

helm delete gitlab
helm ls --all
helm del --purge gitlab
