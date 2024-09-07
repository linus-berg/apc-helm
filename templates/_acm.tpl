{{- define "acm" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: acm-{{ .id }}
  labels:
    app: acm-{{ .id }}
spec:
  replicas: {{ .replicas }}
  selector:
    matchLabels:
      app: acm-{{ .id }}
  template:
    metadata:
      labels:
        app: acm-{{ .id }}
    spec:
      containers:
        - name: acm-{{ .id }}
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
            - configMapRef:
                name: acm-env-config
{{- end }}
