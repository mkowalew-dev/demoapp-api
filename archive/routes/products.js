import express from 'express';
const router = express.Router();
import db from '../../app-db.js';

// Get all products
router.get('/', (req, res) => {
    const query = 'SELECT * FROM Products';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get a product by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM Products WHERE product_id = ?';
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Product not found' });
        res.json(results[0]);
    });
});

// Update a product
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { name, description, price, category, photo_url } = req.body;
    const query = 'UPDATE Products SET name = ?, description = ?, price = ?, category = ?, photo_url = ? WHERE product_id = ?';
    db.query(query, [name, description, price, category, photo_url, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Product updated successfully' });
    });
});

// Delete a product
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Products WHERE product_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Product deleted successfully' });
    });
});
export default router;