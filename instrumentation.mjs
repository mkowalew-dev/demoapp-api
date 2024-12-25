import { start } from '@splunk/otel'

start({
    serviceName: 'demoapp-api',
    tracing: {
        enabled: true,
    },
    profiling: true,
    metrics: true,
})