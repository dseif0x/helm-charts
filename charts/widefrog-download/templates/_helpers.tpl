{{/*
Generate a short SHA256-based hash from the .Values.url and .Values.params
Usage: {{ include "urlParamsHash" . }}
*/}}
{{- define "urlParamsHash" -}}
{{- $url := .Values.url | toString -}}
{{- $params := .Values.params | toJson -}}
{{- $concat := printf "%s%s" $url $params -}}
{{- $hash := $concat | sha256sum | trunc 7 -}}
{{- $hash -}}
{{- end }}
