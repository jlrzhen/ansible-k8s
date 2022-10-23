echo -e "\e[1;42mApply Argo CD \e[0m"
kubectl create namespace argocd \
&& kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo -e "\e[1;42mDownload Argo CD CLI \e[0m"
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 \
&& sudo chmod +x /usr/local/bin/argocd

echo -e "\e[1;42mAccess The Argo CD API Server \e[0m"
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'        

cat << EOF

# port forward
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Login Using The CLI
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
&& argocd login localhost:8080  

# change password
argocd account update-password 

# Register A Cluster To Deploy Apps To (Optional)
kubectl config get-contexts -o name | argocd cluster add
EOF
