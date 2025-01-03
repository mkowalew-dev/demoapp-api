import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import authRoutes from './routes/auth.js';
import rateLimit from'express-rate-limit';
import {start} from "@splunk/otel";

const authApp = express();
const PORT = 4000; // Centralized authentication service port

//splunk observability
start({
    serviceName: 'auth-service',
    // general options like `serviceName` and `endpoint`
    metrics: true, // turn metrics on with default options
    profiling: true, // turn profiling on with default options
    tracing: true
});

//express rate-limiter
const limiter = rateLimit({
    windowMs: 5 * 60 * 1000, // 5 minutes
    limit: 50, // Limit each IP to 100 requests per `window` (here, per 5 minutes).
    standardHeaders: 'draft-8', // draft-6: `RateLimit-*` headers; draft-7 & draft-8: combined `RateLimit` header
    legacyHeaders: false, // Disable the `X-RateLimit-*` headers.
})

authApp.use(cors());
authApp.use(bodyParser.json());
authApp.use('/api/auth', authRoutes);

authApp.listen(PORT, () => {
    console.log(`Authentication service running on port ${PORT}`);
});