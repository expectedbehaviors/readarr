{{- define "readarr_config_xml_content" -}}
{{- $configXmlValues := .Values.externalSecrets.configXml | default dict }}
{{- $configOptions := $configXmlValues.options | default dict }}
{{- $databaseMode := lower ($configXmlValues.databaseMode | default "auto") }}
{{- $bitnamiPostgresqlEnabled := .Values.postgresql.enabled | default false }}
{{- $postgresqlOperatorEnabled := .Values.postgresqlOperator.enabled | default false }}
{{- $postgresHostOverride := $configXmlValues.postgresHost | default "" }}
{{- $managedPostgresqlConfigured := or $bitnamiPostgresqlEnabled $postgresqlOperatorEnabled }}
{{- $autoModeUsesPostgresql := or $managedPostgresqlConfigured (ne $postgresHostOverride "") }}
{{- $postgresqlBlockEnabled := false }}
{{- if eq $databaseMode "sqlite" }}
  {{- $postgresqlBlockEnabled = false }}
{{- else if or (eq $databaseMode "postgres") (eq $databaseMode "external-postgres") (eq $databaseMode "external") }}
  {{- $postgresqlBlockEnabled = true }}
{{- else }}
  {{- $postgresqlBlockEnabled = $autoModeUsesPostgresql }}
{{- end }}
<Config>
  <LogLevel>{{ $configOptions.logLevel | default "Info" }}</LogLevel>
  <Port>{{ $configOptions.port | default "8787" }}</Port>
  <UrlBase>{{ $configOptions.urlBase | default "" }}</UrlBase>
  <BindAddress>{{ $configOptions.bindAddress | default "*" }}</BindAddress>
  <SslPort>{{ $configOptions.sslPort | default "8787" }}</SslPort>
  <EnableSsl>{{ $configOptions.enableSsl | default "False" }}</EnableSsl>
  <ApiKey>__API_KEY__</ApiKey>
  <AuthenticationMethod>{{ $configOptions.authenticationMethod | default "Basic" }}</AuthenticationMethod>
  <Branch>{{ $configOptions.branch | default "nightly" }}</Branch>
  <LaunchBrowser>{{ $configOptions.launchBrowser | default "False" }}</LaunchBrowser>
  <UpdateMechanism>{{ $configOptions.updateMechanism | default "Docker" }}</UpdateMechanism>
  <AnalyticsEnabled>{{ $configOptions.analyticsEnabled | default "False" }}</AnalyticsEnabled>
  <UpdateAutomatically>{{ $configOptions.updateAutomatically | default "True" }}</UpdateAutomatically>
  <InstanceName>{{ $configOptions.instanceName | default "Readarr" }}</InstanceName>
  {{- $postgresDefaultHost := printf "%s-postgresql.%s.svc.cluster.local" .Release.Name .Release.Namespace }}
  {{- if $postgresqlOperatorEnabled }}
    {{- $postgresDefaultHost = printf "%s-rw.%s.svc.cluster.local" .Values.postgresqlOperator.clusterName .Release.Namespace }}
  {{- end }}
  {{- if $postgresqlBlockEnabled }}
  <PostgresUser>{{ $configXmlValues.postgresUser | default "postgres" }}</PostgresUser>
  <PostgresPassword>__POSTGRES_PASSWORD__</PostgresPassword>
  <PostgresPort>{{ $configXmlValues.postgresPort | default "5432" }}</PostgresPort>
  <PostgresHost>{{ $configXmlValues.postgresHost | default $postgresDefaultHost }}</PostgresHost>
  <PostgresMainDb>{{ $configXmlValues.postgresMainDb | default "readarr-main" }}</PostgresMainDb>
  <PostgresLogDb>{{ $configXmlValues.postgresLogDb | default "readarr-log" }}</PostgresLogDb>
  {{- end }}
{{- range $k, $v := $configXmlValues.additionalOptions }}
  <{{ $k }}>{{ $v }}</{{ $k }}>
{{- end }}
</Config>
{{- end -}}
