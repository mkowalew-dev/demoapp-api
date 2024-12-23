import './instrumentation.mjs'
import express from 'express'
import cors from 'cors'
import salesRoutes from './routes/sales.js'
import expensesRoutes from './routes/expenses.js'
import salariesRoutes from './routes/salaries.js'
import employeesRoutes from './routes/employees.js'

const app = express();
const PORT = process.env.PORT || 4000;

// Enable CORS
app.use(cors());

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
