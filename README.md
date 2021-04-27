# Simple helm chart for CVAT

i might be too late, see https://github.com/openvinotoolkit/cvat/issues/1087
for an ongoing PR introducing an official helm chart.

# Values

* `superUser.create` true|false create a superuser
* `superUser.username` the superuser username to create
* `superUser.initialPassword` the superuser initial password to create
* `superUser.email` the email address of the super user

* `ingress.host` the public hostname for ingress
* `ingress.clusterIssuer` the cluster issuer for ingress

# How to install

this will install cvat in its own namespace `cvat` , set an initial password and set the public URL to cvat.com. It will use letsencrypt-prod issuer for https cert

```shell
git clone https://github.com/Kapernikov/cvat-helm.git
cd cvat-helm

helm install cvat . \
        --namespace='cvat' --create-namespace \
        --set superUser.initialPassword=boo \
        --set ingress.host=cvat.com \
        --set ingress.clusterIssuer=letsencrypt-prod 
```
