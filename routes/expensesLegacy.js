import express from 'express';
const router = express.Router();
import db from '../app-db.js';

router.get('/summary/:year', (req, res, next) => {
    const { year } = req.params;
    const query = 'SELECT month, amount FROM ExpensesLegacy WHERE year = ? ORDER BY month';

    db.query(query, [year], (err, results) => {
        if (err) {
            return next(err);
        }
        if (results.length === 0) {
            return res.status(404).json({ error: 'No expenses data found for this year' });
        }
        res.json(results);
    });
});

export default router;