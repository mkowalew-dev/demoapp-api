const express = require('express');
const router = express.Router();
const db = require('../db');

// Helper function to get orders by status
const getOrdersByStatus = (status, res) => {
    const query = `SELECT MONTH(order_date) AS month, COUNT(*) AS order_count FROM Orders WHERE status = ? GROUP BY MONTH(order_date) ORDER BY MONTH(order_date)`;
    db.query(query, [status], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
};

// Endpoint for orders with status 'Shipped'
router.get('/shipped', (req, res) => {
    getOrdersByStatus('Shipped', res);
});

// Endpoint for orders with status 'Completed'
router.get('/completed', (req, res) => {
    getOrdersByStatus('Completed', res);
});

// Endpoint for orders with status 'Canceled'
router.get('/canceled', (req, res) => {
    getOrdersByStatus('Canceled', res);
});

// Endpoint for orders with status 'Pending'
router.get('/pending', (req, res) => {
    getOrdersByStatus('Pending', res);
});

module.exports = router;