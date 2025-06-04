#!/bin/bash

export SPLUNK_METRICS_ENABLED=true
export OTEL_RESOURCE_ATTRIBUTES=deployment.environment=azure-production,service.version=2.0
export OTEL_SERVICE_NAME=customer-api
export SPLUNK_PROFILER_ENABLED=true
export SPLUNK_PROFILER_MEMORY_ENABLED=true
node customer-service.js &
