## Private registry

When using the container ecosystem, we must have the regostry to store the images. All the workload on the K8s must come from the registry. However, you might need a private registry in case you don't want to expose your images or you don't have the network in some cases.

Let's set up a private registry on the K8s. Simply deploy the registry with `helm` like this:
```shell
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
```
