import express from 'express';
const router = express.Router();
import db from '../app-db.js';

// Get all expense categories
router.get('/', (req, res) => {
    const query = 'SELECT * FROM ExpenseCategories';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get an expense category by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM ExpenseCategories WHERE category_id = ?';
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Category not found' });
        res.json(results[0]);
    });
});

// Update an expense category
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { name, description } = req.body;
    const query = 'UPDATE ExpenseCategories SET name = ?, description = ? WHERE category_id = ?';
    db.query(query, [name, description, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Category updated successfully' });
    });
});

// Delete an expense category
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM ExpenseCategories WHERE category_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Category deleted successfully' });
    });
});

export default router;