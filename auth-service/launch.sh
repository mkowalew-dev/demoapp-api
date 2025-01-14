#!/bin/bash
export OTEL_INSTRUMENTATION_COMMON_DEFAULT_ENABLED=true
export SPLUNK_METRICS_ENABLED=true
export OTEL_RESOURCE_ATTRIBUTES=deployment.environment=staging,service.version=2.0
export OTEL_SERVICE_NAME=auth-service
export SPLUNK_PROFILER_ENABLED=true
export SPLUNK_PROFILER_MEMORY_ENABLED=true
node -r @splunk/otel/instrument auth-app.js &
