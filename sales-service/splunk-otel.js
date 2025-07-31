import { NodeSDK } from '@opentelemetry/sdk-node';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';
import { OTLPMetricExporter } from '@opentelemetry/exporter-metrics-otlp-http';
import { getNodeAutoInstrumentations } from '@opentelemetry/auto-instrumentations-node';
import process from 'process';

// Configure OTLP Trace Exporter
const traceExporter = new OTLPTraceExporter({
    url: process.env.OTLP_TRACE_ENDPOINT, // OTLP endpoint for traces
    headers: {
        'X-SF-TOKEN': process.env.SPLUNK_ACCESS_TOKEN, // Splunk Observability token
    },
});

// Configure OTLP Metric Exporter
const metricExporter = new OTLPMetricExporter({
    url: process.env.OTLP_METRICS_ENDPOINT, // OTLP endpoint for metrics
    headers: {
        'X-SF-TOKEN': process.env.SPLUNK_ACCESS_TOKEN, // Splunk Observability token
    },
});

// Configure OpenTelemetry Node SDK
const sdk = new NodeSDK({
    traceExporter,
    metricExporter,
    instrumentations: getNodeAutoInstrumentations(), // Automatically enable all supported instrumentation
});

// Start the OpenTelemetry SDK
sdk.start()
    .then(() => console.log('OpenTelemetry SDK initialized'))
    .catch((err) => console.error('Error initializing OpenTelemetry SDK:', err));

// Gracefully shut down the SDK on process termination
process.on('SIGTERM', () => {
    sdk.shutdown()
        .then(() => console.log('OpenTelemetry SDK shut down'))
        .catch((err) => console.error('Error shutting down OpenTelemetry SDK:', err))
        .finally(() => process.exit(0));
});