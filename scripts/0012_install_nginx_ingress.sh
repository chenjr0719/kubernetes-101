#!/usr/bin/env bash

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    --create-namespace \
    --set controller.hostPort.enabled=true \
    --set controller.ingressClassResource.default=true \
    -f - << EOF
controller:
  hostPort:
    enabled: true
  ingressClassResource:
    default: true
  service:
    type: NodePort
  watchIngressWithoutClass: true
EOF

kubectl -n ingress-nginx rollout status deployment ingress-nginx-controller
