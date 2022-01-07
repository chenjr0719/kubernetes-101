#!/usr/bin/env bash

# Install Cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update

kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.15.0/cert-manager.crds.yaml
helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --create-namespace \
    --version v0.15.0

kubectl -n cert-manager rollout status deployment cert-manager
sleep 30 # Prevent unexpected issue

# Install Rancher
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update

helm upgrade --install rancher rancher-latest/rancher \
    --version v2.5.11 \
    --namespace cattle-system \
    --create-namespace \
    --set hostname=rancher.$DOMAIN \
    --set replicas=1

kubectl -n cattle-system rollout status deployment rancher
