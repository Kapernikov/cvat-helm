# Integrating with zalando postgres operator

First install zalando's postgres operator.
Then, create a database cluster with a database for cvat (maybe others) and a user for cvat (maybe others).
Example configuration:

```yaml
apiVersion: "acid.zalan.do/v1"
kind: postgresql
metadata:
  name: cvat-db
spec:
  teamId: "cvat"
  volume:
    size: 10Gi
  numberOfInstances: 2
  users:
    cvatuser:
    - superuser
    - createdb
  databases:
    cvat: cvatuser
  postgresql:
    version: "14"
    parameters: 
      shared_buffers: "32MB"
      max_connections: "40"
```

Then, install this helm chart with the following values:

```yaml
database:
    create: false
    zalando:
        enable: true
        databaseUser: cvatuser
        databaseName: cvat
        databaseCluster: cvat-db
```

The password will be extracted from the secret created by zalando PGO.
