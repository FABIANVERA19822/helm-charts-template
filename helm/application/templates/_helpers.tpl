{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "app.name" -}}
{{- printf "%s-%s" .Values.projectname .Values.applicationrole | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "app.fullname" -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "serviceaccountname" -}}
{{- printf "sa-%s-%s-%s-%s" (lower .Values.bu) (lower .Values.environment) .Values.projectname .Values.applicationrole | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.name.service" -}}
{{- printf "%s-%s-svc" .Values.projectname .Values.applicationrole | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.name.ingress" -}}
{{- printf "%s-%s-ingress" .Values.projectname .Values.applicationrole | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.name.appconfig" -}}
{{- printf "%s-%s-appconfig" .Values.projectname .Values.applicationrole | trunc 63 | trimSuffix "-" -}}
{{- end -}}