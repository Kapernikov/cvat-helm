{{ define "cvat-helm.postgres-env" }}
{{ if .Values.database.create }}
        - name: CVAT_POSTGRES_HOST
          value: 'cvat-db'
{{ end }}
{{ if .Values.database.zalando.enable }}
        - name: CVAT_POSTGRES_HOST
          value: {{ .Values.database.zalando.databaseCluster }}
        - name: CVAT_POSTGRES_DBNAME
          value: {{ .Values.database.zalando.databaseName }}
        - name: CVAT_POSTGRES_USER
          valueFrom:
            secretKeyRef:
              name: {{ .Values.database.zalando.databaseUser }}.{{ .Values.database.zalando.databaseCluster }}.credentials.postgresql.acid.zalan.do
              key: username
        - name: CVAT_POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: {{ .Values.database.zalando.databaseUser }}.{{ .Values.database.zalando.databaseCluster }}.credentials.postgresql.acid.zalan.do
              key: password
{{ end }}
{{ end }}