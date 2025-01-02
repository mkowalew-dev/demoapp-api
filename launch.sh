#!/bin/bash
export OTEL_INSTRUMENTATION_COMMON_DEFAULT_ENABLED=true
export SPLUNK_METRICS_ENABLED=true
export OTEL_RESOURCE_ATTRIBUTES=deployment.environment=staging,service.version=1.1
export OTEL_SERVICE_NAME=demoapp-api
export SPLUNK_ACCESS_TOKEN=szbjLgucNE2S1dlQdlz_2w
export SPLUNK_REALM=us1
export SPLUNK_PROFILER_ENABLED=true
export SPLUNK_PROFILER_MEMORY_ENABLED=true
#node -r @splunk/otel/instrument app-api.js
node -r @splunk/otel/instrument app-psql.js