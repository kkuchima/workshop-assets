## ツール群のインストール
```bash
brew install helm
helm plugin install https://github.com/databus23/helm-diff
brew install helmfile
```

## helmfile による AdgoCD インストール 
```bash
kubectl create ns argocd
helmfile apply
kubectl port-forward service/argocd-server -n argocd 8080:443
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
