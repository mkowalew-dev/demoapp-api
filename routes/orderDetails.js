import express from 'express';
const router = express.Router();
import db from '../app-db.js';

// Get all order details
router.get('/', (req, res) => {
    const query = `
    SELECT od.order_detail_id, od.quantity, od.price, o.order_id, p.name AS product_name
    FROM OrderDetails od
    JOIN Orders o ON od.order_id = o.order_id
    JOIN Products p ON od.product_id = p.product_id
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get an order detail by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = `
    SELECT od.order_detail_id, od.quantity, od.price, o.order_id, p.name AS product_name
    FROM OrderDetails od
    JOIN Orders o ON od.order_id = o.order_id
    JOIN Products p ON od.product_id = p.product_id
    WHERE od.order_detail_id = ?
  `;
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Order detail not found' });
        res.json(results[0]);
    });
});

// Update an order detail
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { order_id, product_id, quantity, price } = req.body;
    const query = 'UPDATE OrderDetails SET order_id = ?, product_id = ?, quantity = ?, price = ? WHERE order_detail_id = ?';
    db.query(query, [order_id, product_id, quantity, price, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Order detail updated successfully' });
    });
});

// Delete an order detail
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM OrderDetails WHERE order_detail_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Order detail deleted successfully' });
    });
});

export default router;