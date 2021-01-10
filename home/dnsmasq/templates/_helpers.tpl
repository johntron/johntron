{{- define "service.labels.standard" -}}
choerodon.io/release: {{ .Release.Name | quote }}
choerodon.io/infra: {{ .Chart.Name | quote }}
{{- end -}}

{{- define "service.logging.deployment.label" -}}
choerodon.io/logs-parser: {{ .Values.logs.parser | quote }}
{{- end -}}