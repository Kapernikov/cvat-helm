# Simple helm chart for CVAT

Note that CVAT now has an official helm chart, see https://github.com/openvinotoolkit/cvat/pull/3102

# Values

* `superUser.create` true|false create a superuser
* `superUser.username` the superuser username to create
* `superUser.initialPassword` the superuser initial password to create
* `superUser.email` the email address of the super user

* `ingress.host` the public hostname for ingress
* `ingress.clusterIssuer` the cluster issuer for ingress

* `volume.createSubdir` create postgres data in a subdirectory under the volume. needed if you use block volumes
* `volume.storageClassName` storage class for volume
* `volume.size` size of volume to create

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
