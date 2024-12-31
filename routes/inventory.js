import express from 'express';
const router = express.Router();
import db from '../app-db.js';

// Get all inventory records
router.get('/', (req, res) => {
    const query = `
    SELECT i.product_id, i.location_id, i.quantity_in_stock, i.last_updated,
           p.name AS product_name, l.name AS location_name
    FROM Inventory i
    JOIN Products p ON i.product_id = p.product_id
    JOIN StoreLocations l ON i.location_id = l.location_id
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get inventory by product and location
router.get('/:product_id/:location_id', (req, res) => {
    const { product_id, location_id } = req.params;
    const query = `
    SELECT i.product_id, i.location_id, i.quantity_in_stock, i.last_updated,
           p.name AS product_name, l.name AS location_name
    FROM Inventory i
    JOIN Products p ON i.product_id = p.product_id
    JOIN StoreLocations l ON i.location_id = l.location_id
    WHERE i.product_id = ? AND i.location_id = ?
  `;
    db.query(query, [product_id, location_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Inventory record not found' });
        res.json(results[0]);
    });
});

// Update inventory
router.put('/:product_id/:location_id', (req, res) => {
    const { product_id, location_id } = req.params;
    const { quantity_in_stock } = req.body;
    const query = 'UPDATE Inventory SET quantity_in_stock = ? WHERE product_id = ? AND location_id = ?';
    db.query(query, [quantity_in_stock, product_id, location_id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Inventory updated successfully' });
    });
});

// Delete inventory record
router.delete('/:product_id/:location_id', (req, res) => {
    const { product_id, location_id } = req.params;
    const query = 'DELETE FROM Inventory WHERE product_id = ? AND location_id = ?';
    db.query(query, [product_id, location_id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Inventory record deleted successfully' });
    });
});

// Summarize inventory by location
router.get('/summary/location', (req, res) => {
    const query = `
    SELECT l.name AS location_name, SUM(i.quantity_in_stock) AS total_quantity
    FROM Inventory i
    JOIN StoreLocations l ON i.location_id = l.location_id
    GROUP BY i.location_id, location_name
    ORDER BY location_name
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

export default router;