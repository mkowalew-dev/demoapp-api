import express from 'express';
const router = express.Router();
import db from '../../app-db.js';

// Get all employees
router.get('/', (req, res) => {
    const query = 'SELECT * FROM Employees';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Get an employee by ID
router.get('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'SELECT * FROM Employees WHERE employee_id = ?';
    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ error: 'Employee not found' });
        res.json(results[0]);
    });
});

// Update an employee
router.put('/:id', (req, res) => {
    const { id } = req.params;
    const { first_name, last_name, email, phone, position, salary, hire_date, avatar_url } = req.body;
    const query = 'UPDATE Employees SET first_name = ?, last_name = ?, email = ?, phone = ?, position = ?, salary = ?, hire_date = ?, avatar_url = ? WHERE employee_id = ?';
    db.query(query, [first_name, last_name, email, phone, position, salary, hire_date, avatar_url, id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Employee updated successfully' });
    });
});

// Delete an employee
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Employees WHERE employee_id = ?';
    db.query(query, [id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Employee deleted successfully' });
    });
});

export default router;