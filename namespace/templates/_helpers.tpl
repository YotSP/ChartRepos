{{/*
Expand the name of the chart.
*/}}
{{- define "namespace.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "namespace.fullname" -}}
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
{{- define "namespace.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "namespace.labels" -}}
helm.sh/chart: {{ include "namespace.chart" . }}
{{ include "namespace.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "namespace.selectorLabels" -}}
app.kubernetes.io/name: {{ include "namespace.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "namespace.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "namespace.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "namespace.argocdNamespace" -}}
{{ .Values.argocdNamespace | default "openshift-gitops" }}
{{- end }}

{{/*
Set Resource Quota size based by name.
*/}}
{{- define "rq.nameCPU" -}}
{{- if .Values.tallas.tCPU eq "S"}}
rq-cpu-s
{{- else if .Values.tallas.tCPU eq "M"}}
rq-cpu-m
{{- else if .Values.tallas.tCPU eq "L"}}
rq-cpu-l
{{- end }}
{{- end }}

{{- define "rq.rCPU" -}}
{{- if .Values.tallas.tCPU eq "S"}}
'200m'
{{- else if .Values.tallas.tCPU eq "M"}}
'500m'
{{- else if .Values.tallas.tCPU eq "L"}}
'1'
{{- end }}
{{- end }}

{{- define "rq.lCPU" -}}
{{- if .Values.tallas.tCPU eq "S"}}
'600mm'
{{- else if .Values.tallas.tCPU eq "M"}}
'1'
{{- else if .Values.tallas.tCPU eq "L"}}
'2'
{{- end }}
{{- end }}


{{/*
Set Resource Quota size based by name.
*/}}
{{- define "rq.nameMEM" -}}
{{- if .Values.tallas.tMEM eq "S"}}
rq-mem-s
{{- else if .Values.tallas.tMEM eq "M"}}
rq-mem-m
{{- else if .Values.tallas.tMEM eq "L"}}
rq-mem-l
{{- end }}
{{- end }}

{{- define "rq.rMEM" -}}
{{- if .Values.tallas.tMEM eq "S"}}
'100Mi'
{{- else if .Values.tallas.tMEM eq "M"}}
'500Mi'
{{- else if .Values.tallas.tMEM eq "L"}}
'1Gi'
{{- end }}
{{- end }}

{{- define "rq.lMEM" -}}
{{- if .Values.tallas.tMEM eq "S"}}
'500Mi'
{{- else if .Values.tallas.tMEM eq "M"}}
'2Gi'
{{- else if .Values.tallas.tMEM eq "L"}}
'4Gi'
{{- end }}
{{- end }}



{{/*
Set Resource Quota size based by name.
*/}}
{{- define "rq.nameOBJ" -}}
{{- if .Values.tallas.tOBJ eq "S"}}
rq-obj-s
{{- else if .Values.tallas.tOBJ eq "M"}}
rq-obj-m
{{- else if .Values.tallas.tOBJ eq "L"}}
rq-obj-l
{{- end }}
{{- end }}

{{- define "rq.pods" -}}
{{- if .Values.tallas.tOBJ eq "S"}}
'1'
{{- else if .Values.tallas.tOBJ eq "M"}}
'2'
{{- else if .Values.tallas.tOBJ eq "L"}}
'4'
{{- end }}
{{- end }}

