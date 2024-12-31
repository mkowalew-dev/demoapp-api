import express from 'express';
const router = express.Router();
import db from '../app-db.js';

// Create a new user
router.post('/', (req, res) => {
    const { first_name, last_name, email, password_hash, avatar_url, phone, address, city, state, zip_code } = req.body;
    const query = 'INSERT INTO Users (first_name, last_name, email, password_hash, avatar_url, phone, address, city, state, zip_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';
    db.query(query, [first_name, last_name, email, password_hash, avatar_url, phone, address, city, state, zip_code], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(201).json({ id: results.insertId });
    });
});

// Update a user
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { first_name, last_name, email, avatar_url, phone, address, city, state, zip_code } = req.body;
    const query = 'UPDATE Users SET first_name = ?, last_name = ?, email = ?, avatar_url = ?, phone = ?, address = ?, city = ?, state = ?, zip_code = ? WHERE user_id = ?';
    db.query(query, [first_name, last_name, email, avatar_url, phone, address, city, state, zip_code, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'User updated successfully' });
    });
});

// Delete a user
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Users WHERE user_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'User deleted successfully' });
    });
});

export default router;