import express from 'express';
const router = express.Router();
import db from '../app-db.js';

// Get all customers
router.get('/', (req, res) => {
    const query = 'SELECT * FROM Customers';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get a customer by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM Customers WHERE customer_id = ?';
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Customer not found' });
        res.json(results[0]);
    });
});

// Update a customer
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { first_name, last_name, email, phone, address, city, state, zip_code } = req.body;
    const query = 'UPDATE Customers SET first_name = ?, last_name = ?, email = ?, phone = ?, address = ?, city = ?, state = ?, zip_code = ? WHERE customer_id = ?';
    db.query(query, [first_name, last_name, email, phone, address, city, state, zip_code, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Customer updated successfully' });
    });
});

// Delete a customer
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Customers WHERE customer_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Customer deleted successfully' });
    });
});

export default router;