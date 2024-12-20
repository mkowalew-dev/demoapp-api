const express = require('express');
const router = express.Router();
const db = require('../db');

router.get('/', (req, res, next) => {
    const query = 'SELECT * FROM Employees';

    db.query(query, (err, results) => {
        if (err) {
            return next(err);
        }
        if (results.length === 0) {
            return res.status(404).json({ error: 'No employees found' });
        }
        res.json(results);
    });
});

module.exports = router;