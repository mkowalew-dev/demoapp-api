import express from 'express';
import pkg from 'pg';
const { Pool } = pkg;

const app = express();
const port = 4000;

// Configure PostgreSQL connection
// const pool = new Pool({
//     user: 'dbuser',
//     host: '192.168.1.142',
//     database: 'demo_webapp_staging',
//     password: 'CAdemo123',
//     port: 5432,
// });
const pool = new Pool({
    user: 'dbuser',
    host: '192.168.1.24',
    database: 'postgres',
    password: 'CAdemo123',
    port: 5432,
});
// Helper function to get orders by status
async function getOrdersByStatus(status) {
    const query = `
        SELECT
            EXTRACT(YEAR FROM order_date) AS year,
            EXTRACT(MONTH FROM order_date) AS month,
            COUNT(*) AS total
        FROM
            orders
        WHERE
            status = $1
        GROUP BY
            year, month
        ORDER BY
            year, month;
    `;
    const { rows } = await pool.query(query, [status]);
    return rows.map(row => ({
        year: parseInt(row.year),
        month: parseInt(row.month),
        total: row.total,
    }));
}

// Define routes for each status
app.get('/orders/completed', async (req, res) => {
    try {
        const data = await getOrdersByStatus('Completed');
        res.json(data);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.get('/orders/canceled', async (req, res) => {
    try {
        const data = await getOrdersByStatus('Canceled');
        res.json(data);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.get('/orders/shipped', async (req, res) => {
    try {
        const data = await getOrdersByStatus('Shipped');
        res.json(data);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.get('/orders/pending', async (req, res) => {
    try {
        const data = await getOrdersByStatus('Pending');
        res.json(data);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Start the server
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});