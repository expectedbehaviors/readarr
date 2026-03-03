{{- define "readarr_config_xml_content" -}}
{{- $e := .Values.externalSecrets.configXml | default dict }}
{{- $o := $e.options | default dict }}
<Config>
  <LogLevel>{{ $o.logLevel | default "Info" }}</LogLevel>
  <Port>{{ $o.port | default "8787" }}</Port>
  <UrlBase>{{ $o.urlBase | default "" }}</UrlBase>
  <BindAddress>{{ $o.bindAddress | default "*" }}</BindAddress>
  <SslPort>{{ $o.sslPort | default "8787" }}</SslPort>
  <EnableSsl>{{ $o.enableSsl | default "False" }}</EnableSsl>
  <ApiKey>__API_KEY__</ApiKey>
  <AuthenticationMethod>{{ $o.authenticationMethod | default "Basic" }}</AuthenticationMethod>
  <Branch>{{ $o.branch | default "nightly" }}</Branch>
  <LaunchBrowser>{{ $o.launchBrowser | default "False" }}</LaunchBrowser>
  <UpdateMechanism>{{ $o.updateMechanism | default "Docker" }}</UpdateMechanism>
  <AnalyticsEnabled>{{ $o.analyticsEnabled | default "False" }}</AnalyticsEnabled>
  <UpdateAutomatically>{{ $o.updateAutomatically | default "True" }}</UpdateAutomatically>
  <InstanceName>{{ $o.instanceName | default "Readarr" }}</InstanceName>
  <PostgresUser>{{ $e.postgresUser | default "postgres" }}</PostgresUser>
  <PostgresPassword>__POSTGRES_PASSWORD__</PostgresPassword>
  <PostgresPort>{{ $e.postgresPort | default "5432" }}</PostgresPort>
  <PostgresHost>{{ $e.postgresHost | default "postgresql-rw.postgresql.svc.cluster.local" }}</PostgresHost>
  <PostgresMainDb>{{ $e.postgresMainDb | default "readarr-main" }}</PostgresMainDb>
  <PostgresLogDb>{{ $e.postgresLogDb | default "readarr-log" }}</PostgresLogDb>
{{- range $k, $v := $e.additionalOptions }}
  <{{ $k }}>{{ $v }}</{{ $k }}>
{{- end }}
</Config>
{{- end -}}
