import express from 'express';
const router = express.Router();
import db from '../app-db.js';

// Get all store locations
router.get('/', (req, res) => {
    const query = 'SELECT * FROM StoreLocations';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get a store location by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM StoreLocations WHERE location_id = ?';
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Location not found' });
        res.json(results[0]);
    });
});

// Update a store location
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { name, address, city, state, zip_code, phone, manager_id } = req.body;
    const query = 'UPDATE StoreLocations SET name = ?, address = ?, city = ?, state = ?, zip_code = ?, phone = ?, manager_id = ? WHERE location_id = ?';
    db.query(query, [name, address, city, state, zip_code, phone, manager_id, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Location updated successfully' });
    });
});

// Delete a store location
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM StoreLocations WHERE location_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Location deleted successfully' });
    });
});

export default router;