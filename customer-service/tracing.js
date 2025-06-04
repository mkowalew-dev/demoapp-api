// tracing.js
import { NodeSDK } from '@opentelemetry/sdk-node';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';
import { SemanticResourceAttributes } from '@opentelemetry/semantic-conventions';
import { ExpressInstrumentation } from '@opentelemetry/instrumentation-express';
import { MySQL2Instrumentation } from '@opentelemetry/instrumentation-mysql2';

import * as otelResources from '@opentelemetry/resources';
 // double-check it's a function


const resource = 'express-mysql-service';

const sdk = new NodeSDK({
    traceExporter: new OTLPTraceExporter({
        url: 'https://ingest.us1.signalfx.com/v2/trace',
        headers: {
            'x-sf-token': 'szbjLgucNE2S1dlQdlz_2w',
        },
    }),
    instrumentations: [new ExpressInstrumentation(), new MySQL2Instrumentation()],
});

sdk.start()
    // .then(() => console.log('Tracing initialized'))
    // .catch(err => console.error('Tracing error', err));


