# Simple helm chart for CVAT

Features:

* creates a superuser and store it in a secret for integration with other kubernetes resources
* optionally uses zalando's postgres operator (see [here](zalando-pgo.md))

## Values

* `superUser.create` true|false create a superuser
* `superUser.username` the superuser username to create
* `superUser.initialPassword` the superuser initial password to create
* `superUser.email` the email address of the super user

Note that this chart will always create another superuser with a dynamically generated password. The generated credentials will be stored in a kubernetes secret called `cvat-superuser`.
This is useful if you have other pods that need to access the CVAT API.

* `ingress.host` the public hostname for ingress
* `ingress.clusterIssuer` the cluster issuer for ingress

* `volume.createSubdir` create postgres data in a subdirectory under the volume. needed if you use block volumes
* `volume.storageClassName` storage class for volume
* `volume.size` size of volume to create

## How to install

this will install cvat in its own namespace `cvat` , set an initial password and set the public URL to cvat.com. It will use letsencrypt-prod issuer for https cert

```shell
git clone https://github.com/Kapernikov/cvat-helm.git
cd cvat-helm/charts

helm install cvat cvat-helm \
        --namespace='cvat' --create-namespace \
        --set superUser.initialPassword=boo \
        --set ingress.host=cvat.com \
        --set ingress.clusterIssuer=letsencrypt-prod 
```

## How to create a release

* Bump CVAT version number (tag) in `docker/opa/Dockerfile`
* Bump appVersion in `charts/cvat-helm/Chart.yaml` to the cvat version
* Bump version in `charts/cvat-helm/Chart.yaml` to the version of the future helm chart
* Create a tag with the new version number (eg `cvat-helm-0.1.7`)
* Create a github release with that tag

