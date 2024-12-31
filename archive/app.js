import express from 'express'
import rateLimit from'express-rate-limit';
import cors from 'cors'
import salesRoutes from '../routes/salesLegacy.js'
import expensesRoutes from '../routes/expenses.js'
import employeesRoutes from '../routes/employees.js'
import productsRoutes from '../routes/products.js'
import ordersRoutes from '../routes/orders.js'


const app = express();
const PORT = 4000;

const limiter = rateLimit({
    windowMs: 5 * 60 * 1000, // 5 minutes
    limit: 100, // Limit each IP to 100 requests per `window` (here, per 5 minutes).
    standardHeaders: 'draft-8', // draft-6: `RateLimit-*` headers; draft-7 & draft-8: combined `RateLimit` header
    legacyHeaders: false, // Disable the `X-RateLimit-*` headers.
})

// Enable CORS
app.use(cors(), limiter)

// Use routes
app.use('/api/saleslegacy', salesRoutes);
app.use('/api/expenseslegacy', expensesRoutes);
app.use('/api/products', productsRoutes);
app.use('/api/orders', ordersRoutes);


// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Internal Server Error' });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
