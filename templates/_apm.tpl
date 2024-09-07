{{- define "apm" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: apm-{{ .id }}
  labels:
    app: apm-{{ .id }}
spec:
  replicas: {{ .replicas }}
  selector:
    matchLabels:
      app: apm-{{ .id }}
  template:
    metadata:
      labels:
        app: apm-{{ .id }}
    spec:
      containers:
        - name: apm-{{ .id }}
          image: {{ .image }}:{{ .tag }}
          {{- if .env }}
          env:
            {{- range $key, $val := .env }}
            {{ $val.name }}: {{ $val.value | quote }}
            {{- end }}
          {{- end }}
          envFrom:
            - configMapRef:
                name: common-env-config
{{- end }}
