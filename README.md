> **Note that as of 2022/09 the built in helm chart for CVAT has CVAT2 support too, so it might make sense to move to the official helm chart. See https://opencv.github.io/cvat/docs/administration/advanced/k8s_deployment_with_helm/**

# Simple helm chart for CVAT

Features:

* creates a superuser and store it in a secret for integration with other kubernetes resources
* optionally uses zalando's postgres operator (see [here](zalando-pgo.md))

## Usage

See [here](charts/cvat-helm/README.md) for all configuration options

```shell
helm repo add cvat-helm https://kapernikov.github.io/cvat-helm/

# list the versions available
helm search repo cvat-helm

# check what settings are available
helm inspect values cvat-helm/cvat-helm

# install
helm install cvat cvat-helm/cvat-helm \
        --namespace='cvat' --create-namespace \
        --set superUser.initialPassword=boo \
        --set ingress.host=cvat.com \
        --set ingress.clusterIssuer=letsencrypt-prod 

```
