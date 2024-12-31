import express from 'express';
const router = express.Router();
import db from '../app-db.js';

// Helper function to get orders by status
const getOrdersByStatus = (status, res) => {
    const query = `SELECT MONTH(order_date) AS month, COUNT(*) AS order_count FROM Orders WHERE status = ? GROUP BY MONTH(order_date) ORDER BY MONTH(order_date)`;
    db.query(query, [status], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
};
// Get all orders
router.get('/', (req, res) => {
    const query = 'SELECT * FROM Orders';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});
// Get an order by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM Orders WHERE order_id = ?';
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Order not found' });
        res.json(results[0]);
    });
});

// Create a new order
router.post('/', (req, res) => {
    const { user_id, status, total, store_id } = req.body;
    const query = 'INSERT INTO Orders (user_id, status, total, store_id) VALUES (?, ?, ?, ?)';
    db.query(query, [user_id, status, total, store_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(201).json({ order_id: results.insertId });
    });
});

// Update an order
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { user_id, status, total, store_id } = req.body;
    const query = 'UPDATE Orders SET user_id = ?, status = ?, total = ?, store_id = ? WHERE order_id = ?';
    db.query(query, [user_id, status, total, store_id, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Order updated successfully' });
    });
});

// Delete an order
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Orders WHERE order_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Order deleted successfully' });
    });
});
// Endpoint for orders with status 'Shipped'
router.get('/shipped', (req, res) => {
    getOrdersByStatus('Shipped', res);
});

// Endpoint for orders with status 'Completed'
router.get('/completed', (req, res) => {
    getOrdersByStatus('Completed', res);
});

// Endpoint for orders with status 'Canceled'
router.get('/canceled', (req, res) => {
    getOrdersByStatus('Canceled', res);
});

// Endpoint for orders with status 'Pending'
router.get('/pending', (req, res) => {
    getOrdersByStatus('Pending', res);
});

export default router;