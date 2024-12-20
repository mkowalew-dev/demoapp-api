const express = require('express');
const router = express.Router();
const db = require('../db');

router.get('/:year', (req, res, next) => {
    const { year } = req.params;
    const query = 'SELECT month, total_salary FROM Salaries WHERE year = ? ORDER BY month';

    db.query(query, [year], (err, results) => {
        if (err) {
            return next(err);
        }
        if (results.length === 0) {
            return res.status(404).json({ error: 'No salary data found for this year' });
        }
        res.json(results);
    });
});

module.exports = router;