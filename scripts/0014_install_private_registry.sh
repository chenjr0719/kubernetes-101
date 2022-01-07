#!/usr/bin/env bash

helm repo add twuni https://helm.twun.io
helm repo update

helm upgrade --install registry twuni/docker-registry \
    --namespace registry \
    --create-namespace \
    -f - << EOF
ingress:
  enabled: true
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: 3Gi
  hosts:
    - registry.$DOMAIN
EOF

kubectl -n registry rollout status deployment registry-docker-registry
