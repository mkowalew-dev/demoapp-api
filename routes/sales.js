import express from 'express';
const router = express.Router();
import db from '../app-db.js';

// Get all sales
router.get('/', (req, res) => {
    const query = `
    SELECT s.sale_id, s.quantity, s.sale_date, s.total, p.name AS product_name, l.name AS location_name
    FROM Sales s
    JOIN Products p ON s.product_id = p.product_id
    JOIN StoreLocations l ON s.location_id = l.location_id
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get a sale by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = `
    SELECT s.sale_id, s.quantity, s.sale_date, s.total, p.name AS product_name, l.name AS location_name
    FROM Sales s
    JOIN Products p ON s.product_id = p.product_id
    JOIN StoreLocations l ON s.location_id = l.location_id
    WHERE s.sale_id = ?
  `;
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Sale not found' });
        res.json(results[0]);
    });
});

// Update a sale
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { order_id, product_id, quantity, total, location_id } = req.body;
    const query = 'UPDATE Sales SET order_id = ?, product_id = ?, quantity = ?, total = ?, location_id = ? WHERE sale_id = ?';
    db.query(query, [order_id, product_id, quantity, total, location_id, id], (err) => {
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

// Summarize sales by month
router.get('/summary/month', (req, res) => {
    const query = `
    SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month, SUM(total) AS total_sales
    FROM Sales
    GROUP BY month
    ORDER BY month
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Summarize sales by year
router.get('/summary/year', (req, res) => {
    const query = `
    SELECT YEAR(sale_date) AS year, SUM(total) AS total_sales
    FROM Sales
    GROUP BY year
    ORDER BY year
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Summarize sales by location
router.get('/summary/location', (req, res) => {
    const query = `
    SELECT l.name AS location_name, SUM(s.total) AS total_sales
    FROM Sales s
    JOIN StoreLocations l ON s.location_id = l.location_id
    GROUP BY s.location_id, location_name
    ORDER BY location_name
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Summarize sales by product
router.get('/summary/product', (req, res) => {
    const query = `
    SELECT p.name AS product_name, SUM(s.total) AS total_sales
    FROM Sales s
    JOIN Products p ON s.product_id = p.product_id
    GROUP BY s.product_id, product_name
    ORDER BY product_name
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});
export default router;