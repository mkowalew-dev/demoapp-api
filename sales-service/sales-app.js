import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import salesRoutes from './routes/sales.js';
import expensesRoutes from './routes/expenses.js';
import { slowDown } from 'express-slow-down'

const salesApp = express();
const PORT = 4001; // Unique port for Sales service

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
salesApp.use(conditionalSlowDown)
salesApp.use(cors());
salesApp.use(bodyParser.json());

salesApp.use('/api/sales', salesRoutes);
salesApp.use('/api/expenses', expensesRoutes);

salesApp.listen(PORT, () => {
    console.log(`Sales service running on port ${PORT}`);
});