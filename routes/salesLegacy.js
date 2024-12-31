import express from 'express';
const router = express.Router();
import db from '../app-db.js';

router.get('/summary/:year', (req, res, next) => {
    const { year } = req.params;
    const query = 'SELECT month, amount FROM SalesLegacy WHERE year = ? ORDER BY month';

    db.query(query, [year], (err, results) => {
        if (err) {
            return next(err);
        }
        if (results.length === 0) {
            return res.status(404).json({ error: 'No sales data found for this year' });
        }
        res.json(results);
    });
});
// Get all sales
router.get('/', (req, res) => {
    const query = 'SELECT * FROM Sales';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get a sale by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM Sales WHERE sale_id = ?';
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Sale not found' });
        res.json(results[0]);
    });
});

// Update a sale
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { order_id, product_id, quantity, total } = req.body;
    const query = 'UPDATE Sales SET order_id = ?, product_id = ?, quantity = ?, total = ? WHERE sale_id = ?';
    db.query(query, [order_id, product_id, quantity, total, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Sale updated successfully' });
    });
});

// Delete a sale
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Sales WHERE sale_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Sale deleted successfully' });
    });
});
export default router;