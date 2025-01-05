import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import orderRoutes from './routes/orders.js';
import rateLimit from'express-rate-limit';
import {start} from "@splunk/otel";

const logisticsApp = express();
const PORT = 4002; // Unique port for Logistics service

//express rate-limiter
const limiter = rateLimit({
    windowMs: 5 * 60 * 1000, // 5 minutes
    limit: 50, // Limit each IP to 100 requests per `window` (here, per 5 minutes).
    standardHeaders: 'draft-8', // draft-6: `RateLimit-*` headers; draft-7 & draft-8: combined `RateLimit` header
    legacyHeaders: false, // Disable the `X-RateLimit-*` headers.
})

logisticsApp.use(cors());
logisticsApp.use(bodyParser.json());

logisticsApp.use('/api/orders', orderRoutes);


logisticsApp.listen(PORT, () => {
    console.log(`Logistics service running on port ${PORT}`);
});