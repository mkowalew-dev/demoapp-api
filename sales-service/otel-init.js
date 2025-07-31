import { NodeSDK } from '@opentelemetry/sdk-node';
import {
    OTLPTraceExporter,
    OTLPMetricExporter,
} from '@opentelemetry/exporter-otlp-http';
import { PeriodicExportingMetricReader } from '@opentelemetry/sdk-metrics';
import * as resources from '@opentelemetry/resources'; // 👈 CommonJS-safe import
import { SemanticResourceAttributes } from '@opentelemetry/semantic-conventions';
import { ExpressInstrumentation } from '@opentelemetry/instrumentation-express';
import { PgInstrumentation } from '@opentelemetry/instrumentation-pg';
import { diag, DiagConsoleLogger, DiagLogLevel } from '@opentelemetry/api';

diag.setLogger(new DiagConsoleLogger(), DiagLogLevel.INFO);

const SPLUNK_ACCESS_TOKEN = 'szbjLgucNE2S1dlQdlz_2w';
const SPLUNK_REALM = 'us1';
const SPLUNK_ENDPOINT = `https://ingest.us1.signalfx.com`;

export async function setupTracing() {
    const traceExporter = new OTLPTraceExporter({
        url: `${SPLUNK_ENDPOINT}/v1/traces`,
        headers: { 'X-SF-TOKEN': SPLUNK_ACCESS_TOKEN },
    });

    const metricExporter = new OTLPMetricExporter({
        url: `${SPLUNK_ENDPOINT}/v1/metrics`,
        headers: { 'X-SF-TOKEN': SPLUNK_ACCESS_TOKEN },
    });

    const metricReader = new PeriodicExportingMetricReader({
        exporter: metricExporter,
        exportIntervalMillis: 30000,
    });

    // Safely access functions from CommonJS module
    const { detectResourcesSync, resourceFromAttributes, defaultResource } = resources;

    const base = defaultResource().merge(detectResourcesSync());

    const custom = resourceFromAttributes({
        [SemanticResourceAttributes.SERVICE_NAME]: 'sales-api-service',
        [SemanticResourceAttributes.SERVICE_VERSION]: '2.0.0',
        [SemanticResourceAttributes.DEPLOYMENT_ENVIRONMENT]: 'development',
    });

    const resource = base.merge(custom);

    const sdk = new NodeSDK({
        traceExporter,
        metricReader,
        instrumentations: [new ExpressInstrumentation(), new PgInstrumentation()],
        resource,
    });

    await sdk.start();
    console.log('✅ OpenTelemetry is running');

    process.on('SIGTERM', async () => {
        await sdk.shutdown();
        console.log('🛑 OpenTelemetry shut down');
        process.exit(0);
    });
}


