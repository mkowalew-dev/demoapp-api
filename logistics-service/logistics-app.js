import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import orderRoutes from './routes/orders.js';
import rateLimit from'express-rate-limit';
import {start} from "@splunk/otel";

const logisticsApp = express();
const PORT = 4002; // Unique port for Logistics service

//splunk observability
// start({
//     serviceName: 'logistics-service',
//     // general options like `serviceName` and `endpoint`
//     metrics: true, // turn metrics on with default options
//     profiling: true, // turn profiling on with default options
//     tracing: true
// });

//express rate-limiter
const limiter = rateLimit({
    windowMs: 5 * 60 * 1000, // 5 minutes
    limit: 50, // Limit each IP to 100 requests per `window` (here, per 5 minutes).
    standardHeaders: 'draft-8', // draft-6: `RateLimit-*` headers; draft-7 & draft-8: combined `RateLimit` header
    legacyHeaders: false, // Disable the `X-RateLimit-*` headers.
})

logisticsApp.use(cors());
logisticsApp.use(bodyParser.json());

// Middleware for API key authentication using the centralized auth service
const authenticateApiKey = async (req, res, next) => {
    try {
        const response = await fetch('http://localhost:4000/api/auth/verify', {
            headers: { 'x-api-key': req.headers['x-api-key'] }
        });
        console.log(response);
        if (res.status(200).json(response)) {
            next();
            //if (results.length === 0) return res.status(403).json({ error: 'Forbidden: Invalid API key' })
        } else {
            res.status(403).json({ error: 'Forbidden: Invalid API key' });
        }
    } catch (error) {
        res.status(error.response ? error.response.status : 500).json({ error: error.message });
    }
};

//salesApp.use(authenticateApiKey);
logisticsApp.use('/api/orders', orderRoutes);


logisticsApp.listen(PORT, () => {
    console.log(`Logistics service running on port ${PORT}`);
});