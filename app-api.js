import express from 'express'
import rateLimit from'express-rate-limit';
import cors from 'cors'
import salesRoutes from './archive/routes/sales.js'
import expensesRoutes from './archive/routes/expenses.js'
import employeesRoutes from './archive/routes/employees.js'
import productsRoutes from './archive/routes/products.js'
import ordersRoutes from './archive/routes/orders.js'
import usersRoutes from './archive/routes/users.js'
import customersRoutes from './archive/routes/customers.js'
import locationsRoutes from './archive/routes/locations.js'
import expenseCategoriesRoutes from './archive/routes/expenseCategories.js'
import orderDetailsRoutes from './archive/routes/orderDetails.js'
import bodyParser from 'body-parser'
import inventoryRoutes from './archive/routes/inventory.js'
import shippingRoutes from './archive/routes/shipping.js'
import authenticateApiKey from './middleware/auth.js';



const app = express();
const PORT = 4000;

const limiter = rateLimit({
    windowMs: 5 * 60 * 1000, // 5 minutes
    limit: 50, // Limit each IP to 100 requests per `window` (here, per 5 minutes).
    standardHeaders: 'draft-8', // draft-6: `RateLimit-*` headers; draft-7 & draft-8: combined `RateLimit` header
    legacyHeaders: false, // Disable the `X-RateLimit-*` headers.
})
app.use(cors(), limiter);
app.use(bodyParser.json());
app.use(authenticateApiKey)


app.use('/api/users', usersRoutes);
app.use('/api/products', productsRoutes);
app.use('/api/customers', customersRoutes);
app.use('/api/employees', employeesRoutes);
app.use('/api/locations', locationsRoutes);
app.use('/api/orders', ordersRoutes);
app.use('/api/orderdetails', orderDetailsRoutes);
app.use('/api/inventory', inventoryRoutes);
app.use('/api/shipping', shippingRoutes);
app.use('/api/expenses', expensesRoutes);
app.use('/api/expenseCategories', expenseCategoriesRoutes);
app.use('/api/sales', salesRoutes);
app.use('/api/expenses', expensesRoutes);

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});