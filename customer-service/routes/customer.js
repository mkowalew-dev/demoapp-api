import express from 'express';
const router = express.Router();
import db from '../../db-mysql.js';
import { tracedQuery } from './../../tracequery.js';
// GET all customers
router.get("/customer", async (req, res) => {
    const query = "SELECT * FROM customers";
    const result = await tracedQuery(db, query)
    // // db.query(query, (err, results) => {
    // //     if (err) {
    // //         console.error("Error fetching customers:", err);
    // //         return res.status(500).json({error: "Database query error"});
    // //     }
        res.json(result);
    // });
});

// GET a single customer by ID
router.get("/customer/:id", (req, res) => {
    const query = "SELECT * FROM customers WHERE customer_id = ?";
    db.query(query, [req.params.id], (err, results) => {
        if (err) {
            console.error("Error fetching customer:", err);
            return res.status(500).json({ error: "Database query error" });
        }
        if (results.length === 0) {
            return res.status(404).json({ message: "Customer not found" });
        }
        res.json(results[0]);
    });
});

// POST (create) a new customer
router.post("/customer", (req, res) => {
    const { first_name, last_name, email, phone_number, address, city, state, postal_code, country, status } = req.body;
    const query = `
    INSERT INTO customers (first_name, last_name, email, phone_number, address, city, state, postal_code, country, status)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;
    db.query(query, [first_name, last_name, email, phone_number, address, city, state, postal_code, country, status || "active"], (err, results) => {
        if (err) {
            console.error("Error inserting customer:", err);
            return res.status(500).json({ error: "Database query error" });
        }
        res.status(201).json({ message: "Customer created", customer_id: results.insertId });
    });
});

// PUT (update) a customer by ID
router.put("/customer/:id", (req, res) => {
    const { first_name, last_name, email, phone_number, address, city, state, postal_code, country, status } = req.body;
    const query = `
    UPDATE customers
    SET first_name = ?, last_name = ?, email = ?, phone_number = ?, address = ?, city = ?, state = ?, postal_code = ?, country = ?, status = ?
    WHERE customer_id = ?
  `;
    db.query(
        query,
        [first_name, last_name, email, phone_number, address, city, state, postal_code, country, status, req.params.id],
        (err, results) => {
            if (err) {
                console.error("Error updating customer:", err);
                return res.status(500).json({ error: "Database query error" });
            }
            if (results.affectedRows === 0) {
                return res.status(404).json({ message: "Customer not found" });
            }
            res.json({ message: "Customer updated" });
        }
    );
});

// DELETE a customer by ID
router.delete("/customer/:id", (req, res) => {
    const query = "DELETE FROM customers WHERE customer_id = ?";
    db.query(query, [req.params.id], (err, results) => {
        if (err) {
            console.error("Error deleting customer:", err);
            return res.status(500).json({ error: "Database query error" });
        }
        if (results.affectedRows === 0) {
            return res.status(404).json({ message: "Customer not found" });
        }
        res.json({ message: "Customer deleted" });
    });
});

export default router;