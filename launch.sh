#!/bin/bash
export OTEL_INSTRUMENTATION_COMMON_DEFAULT_ENABLED=true
export SPLUNK_METRICS_ENABLED=true
export OTEL_RESOURCE_ATTRIBUTES=deployment.environment=development,service.version=1.1.0
export OTEL_SERVICE_NAME=demoapp-api-development
export SPLUNK_ACCESS_TOKEN=szbjLgucNE2S1dlQdlz_2w
export SPLUNK_REALM=us1
node -r @splunk/otel/instrument app-api.js &
#node app-api.js &