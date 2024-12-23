import './instrumentation.mjs'
import express from 'express'
import rateLimit from'express-rate-limit';
import cors from 'cors'
import salesRoutes from './routes/sales.js'
import expensesRoutes from './routes/expenses.js'
import salariesRoutes from './routes/salaries.js'
import employeesRoutes from './routes/employees.js'


const app = express();
const PORT = 4000;

const limiter = rateLimit({
    windowMs: 5 * 60 * 1000, // 15 minutes
    limit: 10, // Limit each IP to 100 requests per `window` (here, per 15 minutes).
    standardHeaders: 'draft-8', // draft-6: `RateLimit-*` headers; draft-7 & draft-8: combined `RateLimit` header
    legacyHeaders: false, // Disable the `X-RateLimit-*` headers.
})

// Enable CORS
app.use(cors(), limiter)

// Use routes
app.use('/api/sales', salesRoutes);
app.use('/api/expenses', expensesRoutes);
app.use('/api/salaries', salariesRoutes);
app.use('/api/employees', employeesRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Internal Server Error' });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
