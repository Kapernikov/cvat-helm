# Simple helm chart for CVAT

Note that CVAT now has an official helm chart, see https://github.com/openvinotoolkit/cvat/pull/3102
# Usage

See [here](charts/cvat-helm/README.md) for all configuration options


```shell
helm repo add cvat-helm https://kapernikov.github.io/cvat-helm/

# list the versions available
helm search repo cvat-helm

# check what settings are available
helm inspect values cvat-helm/cvat-helm

# install
helm install cvat . \
        --namespace='cvat' --create-namespace \
        --set superUser.initialPassword=boo \
        --set ingress.host=cvat.com \
        --set ingress.clusterIssuer=letsencrypt-prod 

```
