// app.js
import './tracing.js'; // Must be imported before anything else

import express from 'express';
import mysql from 'mysql2/promise';




const app = express();
const port =  4003;

const pool = mysql.createPool({
    host: 'db.retaildemo.net',
    user: 'dbuser',
    password: 'CAdemo123',
    database: 'retailonlinestore',
});

app.get('/customers', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM customers');
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).send('Database error');
    }
});

app.listen(port, () => {
    console.log(`API listening at http://localhost:${port}`);
});

