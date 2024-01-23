> **Note that as of 2022/09 the built in helm chart for CVAT has CVAT2 support too, so it might make sense to move to the official helm chart. See https://opencv.github.io/cvat/docs/administration/advanced/k8s_deployment_with_helm/**

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

* `ingress.enabled` true|false enable ingress
* `ingress.host` the public hostname for ingress
* `ingress.clusterIssuer` the cluster issuer for ingress
* `ingress.ingressClassName` the ingress class name

* `volume.createSubdir` create postgres data in a subdirectory under the volume. needed if you use block volumes. Note: once you set this value, changing it **will cause you to loose data** (as the postgres data directory will be changed).
* `volume.storageClassName` storage class for volume
* `volume.data.size` size of volume to create for storing data. Should be big enough to hold all images/videos you want to annotate.

* `volume.share.size` size of the share volume to create. If you don't use volume sharing, you can leave this at a small value.
* `volume.share.create` set this to false if you want to provide your own share volume (default=true).
* `volume.share.name` set this to the name of the share volume if you provide your own (see above). Defaults to `cvat-share`

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
* commit and push

