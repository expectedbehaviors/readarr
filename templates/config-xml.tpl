{{- define "readarr_config_xml_content" -}}
{{- $e := .Values.externalSecrets.configXml | default dict }}
<Config>
  <LogLevel>Info</LogLevel>
  <Port>8787</Port>
  <UrlBase></UrlBase>
  <BindAddress>*</BindAddress>
  <SslPort>8787</SslPort>
  <EnableSsl>False</EnableSsl>
  <ApiKey>__API_KEY__</ApiKey>
  <AuthenticationMethod>Basic</AuthenticationMethod>
  <Branch>nightly</Branch>
  <LaunchBrowser>False</LaunchBrowser>
  <UpdateMechanism>Docker</UpdateMechanism>
  <AnalyticsEnabled>False</AnalyticsEnabled>
  <UpdateAutomatically>True</UpdateAutomatically>
  <InstanceName>Readarr</InstanceName>
  <PostgresUser>{{ $e.postgresUser | default "postgres" }}</PostgresUser>
  <PostgresPassword>__POSTGRES_PASSWORD__</PostgresPassword>
  <PostgresPort>{{ $e.postgresPort | default "5432" }}</PostgresPort>
  <PostgresHost>{{ $e.postgresHost | default "postgresql-rw.postgresql.svc.cluster.local" }}</PostgresHost>
  <PostgresMainDb>{{ $e.postgresMainDb | default "readarr-main" }}</PostgresMainDb>
  <PostgresLogDb>{{ $e.postgresLogDb | default "readarr-log" }}</PostgresLogDb>
</Config>
{{- end -}}
