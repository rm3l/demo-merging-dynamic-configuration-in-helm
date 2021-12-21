{{/*
Expand the name of the chart.
*/}}
{{- define "demo-merging-dynamic-configuration-in-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "demo-merging-dynamic-configuration-in-helm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "demo-merging-dynamic-configuration-in-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "demo-merging-dynamic-configuration-in-helm.labels" -}}
helm.sh/chart: {{ include "demo-merging-dynamic-configuration-in-helm.chart" . }}
{{ include "demo-merging-dynamic-configuration-in-helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "demo-merging-dynamic-configuration-in-helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "demo-merging-dynamic-configuration-in-helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "demo-merging-dynamic-configuration-in-helm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "demo-merging-dynamic-configuration-in-helm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Default configuration
*/}}
{{- define "demo-merging-dynamic-configuration-in-helm.baseConfig" -}}
myConfig1:
  nonUpdatableParameter1: some-value
nonUpdatableOption1: value1
{{- end }}
