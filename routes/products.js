const express = require('express');
const router = express.Router();
const db = require('../db');

// Get all products
router.get('/', (req, res, next) => {
    db.query('SELECT * FROM Products', (err, results) => {
        if (err) return next(err);
        res.json(results);
    });
});
// Get a product by ID
router.get('/id/:id', (req, res, next) => {
    const { id } = req.params;
    db.query('SELECT * FROM Products WHERE product_id = ?', [id], (err, results) => {
        if (err) return next(err);
        if (results.length === 0) return res.status(404).json({ error: 'Product not found' });
        res.json(results[0]);
    });
});
// Get products by name
router.get('/name/:name', (req, res, next) => {
    const { name } = req.params;
    db.query('SELECT * FROM Products WHERE name LIKE ?', [`%${name}%`], (err, results) => {
        if (err) return next(err);
        res.json(results);
    });
});
// Get products by description
router.get('/description/:description', (req, res, next) => {
    const { description } = req.params;
    db.query('SELECT * FROM Products WHERE description LIKE ?', [`%${description}%`], (err, results) => {
        if (err) return next(err);
        res.json(results);
    });
});
// Get products by price
router.get('/price/:price', (req, res, next) => {
    const { price } = req.params;
    db.query('SELECT * FROM Products WHERE price = ?', [price], (err, results) => {
        if (err) return next(err);
        res.json(results);
    });
});
// Get products by category
router.get('/category/:category', (req, res, next) => {
    const { category } = req.params;
    db.query('SELECT * FROM Products WHERE category LIKE ?', [`%${category}%`], (err, results) => {
        if (err) return next(err);
        res.json(results);
    });
});
// Get the number of products by category
router.get('/category/summary/count-by-category', (req, res) => {
    db.query('SELECT category, COUNT(*) as productcounts FROM Products GROUP BY category', (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});
// Create a new product
router.post('/', (req, res, next) => {
    const { name, description, price, category } = req.body;
    db.query('INSERT INTO Products (name, description, price, category) VALUES (?, ?, ?, ?)',
        [name, description, price, category],
        (err, results) => {
            if (err) return next(err);
            res.status(201).json({ id: results.insertId, name, description, price, category });
        });
});
// Update a product
router.put('/:id', (req, res, next) => {
    const { id } = req.params;
    const { name, description, price, category } = req.body;
    db.query('UPDATE Products SET name = ?, description = ?, price = ?, category = ? WHERE product_id = ?',
        [name, description, price, category, id],
        (err) => {
            if (err) return next(err);
            res.json({ message: 'Product updated successfully' });
        });
});
// Delete a product
router.delete('/:id', (req, res, next) => {
    const { id } = req.params;
    db.query('DELETE FROM Products WHERE product_id = ?', [id], (err) => {
        if (err) return next(err);
        res.json({ message: 'Product deleted successfully' });
    });
})
module.exports = router;