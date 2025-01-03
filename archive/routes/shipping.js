import express from 'express';
const router = express.Router();
import db from '../../app-db.js';

// Get all shipping details
router.get('/', (req, res) => {
    const query = `
    SELECT sd.shipping_id, sd.address, sd.city, sd.state, sd.zip_code, sd.shipping_date, sd.carrier, sd.tracking_number, o.order_id
    FROM ShippingDetails sd
    JOIN Orders o ON sd.order_id = o.order_id
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get a shipping detail by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = `
    SELECT sd.shipping_id, sd.address, sd.city, sd.state, sd.zip_code, sd.shipping_date, sd.carrier, sd.tracking_number, o.order_id
    FROM ShippingDetails sd
    JOIN Orders o ON sd.order_id = o.order_id
    WHERE sd.shipping_id = ?
  `;
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Shipping detail not found' });
        res.json(results[0]);
    });
});

// Update a shipping detail
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { order_id, address, city, state, zip_code, carrier, tracking_number } = req.body;
    const query = 'UPDATE ShippingDetails SET order_id = ?, address = ?, city = ?, state = ?, zip_code = ?, carrier = ?, tracking_number = ? WHERE shipping_id = ?';
    db.query(query, [order_id, address, city, state, zip_code, carrier, tracking_number, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Shipping detail updated successfully' });
    });
});

// Delete a shipping detail
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM ShippingDetails WHERE shipping_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Shipping detail deleted successfully' });
    });
});

// Summarize shipping by carrier
router.get('/summary/carrier', (req, res) => {
    const query = `
    SELECT carrier, COUNT(*) AS total_shipments
    FROM ShippingDetails
    GROUP BY carrier
    ORDER BY carrier
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Summarize shipping by month
router.get('/summary/month', (req, res) => {
    const query = `
    SELECT DATE_FORMAT(shipping_date, '%Y-%m') AS month, COUNT(*) AS total_shipments
    FROM ShippingDetails
    GROUP BY month
    ORDER BY month
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

export default router;