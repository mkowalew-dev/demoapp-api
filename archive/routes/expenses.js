import express from 'express';
const router = express.Router();
import db from '../../app-db.js';

// Get all expenses
router.get('/', (req, res) => {
    const query = `
    SELECT e.expense_id, e.amount, e.expense_date, e.description, e.created_at,
           ec.name as category_name, em.first_name as employee_first_name, em.last_name as employee_last_name
    FROM Expenses e
    JOIN ExpenseCategories ec ON e.category_id = ec.category_id
    JOIN Employees em ON e.employee_id = em.employee_id
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get an expense by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = `
    SELECT e.expense_id, e.amount, e.expense_date, e.description, e.created_at,
           ec.name as category_name, em.first_name as employee_first_name, em.last_name as employee_last_name
    FROM Expenses e
    JOIN ExpenseCategories ec ON e.category_id = ec.category_id
    JOIN Employees em ON e.employee_id = em.employee_id
    WHERE e.expense_id = ?
  `;
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Expense not found' });
        res.json(results[0]);
    });
});

// Update an expense
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { employee_id, category_id, amount, expense_date, description } = req.body;
    const query = 'UPDATE Expenses SET employee_id = ?, category_id = ?, amount = ?, expense_date = ?, description = ? WHERE expense_id = ?';
    db.query(query, [employee_id, category_id, amount, expense_date, description, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Expense updated successfully' });
    });
});

// Delete an expense
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Expenses WHERE expense_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Expense deleted successfully' });
    });
});

// Summarize expenses by month
router.get('/summary/month', (req, res) => {
    const query = `
    SELECT DATE_FORMAT(expense_date, '%m-%Y') AS month, SUM(amount) AS total_amount
    FROM Expenses
    GROUP BY month
    ORDER BY month
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Summarize expenses by year
router.get('/summary/year', (req, res) => {
    const query = `
    SELECT YEAR(expense_date) AS year, SUM(amount) AS total_amount
    FROM Expenses
    GROUP BY year
    ORDER BY year
  `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Summarize expenses by category
router.get('/summary/category', (req, res) => {
    const query = `
        SELECT ec.name AS category_name, SUM(e.amount) AS total_amount
        FROM Expenses e
                 JOIN ExpenseCategories ec ON e.category_id = ec.category_id
        GROUP BY e.category_id, category_name
        ORDER BY category_name
    `;
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});
export default router;