import './otel-init.js'
import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import salesRoutes from './routes/sales.js';
import expensesRoutes from './routes/expenses.js';
import rateLimit from'express-rate-limit';

const salesApp = express();
const PORT = 4001; // Unique port for Sales service


//express rate-limiter
const limiter = rateLimit({
    windowMs: 5 * 60 * 1000, // 5 minutes
    limit: 50, // Limit each IP to 100 requests per `window` (here, per 5 minutes).
    standardHeaders: 'draft-8', // draft-6: `RateLimit-*` headers; draft-7 & draft-8: combined `RateLimit` header
    legacyHeaders: false, // Disable the `X-RateLimit-*` headers.
})

salesApp.use(cors());
salesApp.use(bodyParser.json());

salesApp.use('/api/sales', salesRoutes);
salesApp.use('/api/expenses', expensesRoutes);

salesApp.listen(PORT, () => {
    console.log(`Sales service running on port ${PORT}`);
});