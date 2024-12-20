const express = require('express');
const cors = require('cors');
const salesRoutes = require('./routes/sales');
const expensesRoutes = require('./routes/expenses');
const salariesRoutes = require('./routes/salaries');
const employeesRoutes = require('./routes/employees');

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