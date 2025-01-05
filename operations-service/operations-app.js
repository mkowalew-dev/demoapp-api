import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import employeesRoutes from './routes/employees.js';
import rateLimit from'express-rate-limit';

const operationsApp = express();
const PORT = 4004; // Unique port for Sales service

const limiter = rateLimit({
    windowMs: 5 * 60 * 1000, // 5 minutes
    limit: 50, // Limit each IP to 100 requests per `window` (here, per 5 minutes).
    standardHeaders: 'draft-8', // draft-6: `RateLimit-*` headers; draft-7 & draft-8: combined `RateLimit` header
    legacyHeaders: false, // Disable the `X-RateLimit-*` headers.
})

operationsApp.use(cors());
operationsApp.use(bodyParser.json());

operationsApp.use('/api/operations/', employeesRoutes);

operationsApp.listen(PORT, () => {
    console.log(`Operations service running on port ${PORT}`);
});