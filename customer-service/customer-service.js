import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import customerRoutes from './routes/customer.js';
import {slowDown} from "express-slow-down";
import { NodeTracerProvider } from '@opentelemetry/sdk-trace-node';
import { BatchSpanProcessor } from '@opentelemetry/sdk-trace-base'; // Use BatchSpanProcessor for production
import { SimpleSpanProcessor } from '@opentelemetry/sdk-trace-base';
import { ConsoleSpanExporter } from '@opentelemetry/sdk-trace-base';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';
import { registerInstrumentations } from '@opentelemetry/instrumentation';
import { MySQL2Instrumentation } from '@opentelemetry/instrumentation-mysql2';
//mport "otel-setup.mjs"
const customerService = express();
const PORT = 4003; // Unique port for Logistics service


// Set up Splunk OTLP exporter
const traceExporter = new OTLPTraceExporter({
    url: 'https://ingest.us1.signalfx.com/v2/trace',
    headers: {
        'X-SF-Token': 'szbjLgucNE2S1dlQdlz_2w',
        "Content-Type": "application/json",
    },
});

// Initialize tracer provider
const provider = new NodeTracerProvider();


// Use BatchSpanProcessor for efficient exporting
provider.addSpanProcessor(new BatchSpanProcessor(traceExporter));

// Optionally add a ConsoleSpanExporter for local debugging
provider.addSpanProcessor(new BatchSpanProcessor(new ConsoleSpanExporter()));
provider.register();

// Instrument MySQL2
registerInstrumentations({
    instrumentations: [
        new MySQL2Instrumentation(),
    ],
    tracerProvider: provider,
});

console.log('OpenTelemetry and MySQL2 instrumentation initialized');


const speedLimiter = slowDown({
    windowMs: 15 * 60 * 1000, // 15 minutes
    delayAfter: 5, // Allow only one request to go at full-speed.
    delayMs: (hits) => hits * hits * 1000, // Add exponential delay after 1 request.
    maxDelayMs: 4000,
});
// Middleware to apply slowdown only during 12 PM to 1 PM, Monday to Friday
const conditionalSlowDown = (req, res, next) => {
    const now = new Date();
    const currentHour = now.getHours(); // Current hour (0-23)
    const currentDay = now.getDay(); // Current day (0 = Sunday, 1 = Monday, ..., 6 = Saturday)

    // Check if it's Monday-Friday (1-5) and 12 PM (hour 12)
    if (currentDay >= 1 && currentDay <= 5 && currentHour === 12) {
        return speedLimiter(req, res, next); // Apply slowdown
    } else {
        next(); // Proceed without slowdown
    }
};

customerService.use(conditionalSlowDown)
customerService.use(cors());
customerService.use(bodyParser.json());

customerService.use('/api/customer-service', customerRoutes);


customerService.listen(PORT, () => {
    console.log(`Customer API service running on port ${PORT}`);
});