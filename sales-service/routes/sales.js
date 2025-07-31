import '../otel-init.js'
import { DateTime } from 'luxon'; // Import DateTime from luxon
import { trace, context, SpanStatusCode } from '@opentelemetry/api';
import express from 'express';
const router = express.Router();
import db from '../../app-db.js';

// Get the tracer instance from the global OpenTelemetry API for custom spans
// Use the same serviceName as configured in app.js for consistent tracing
const tracer = trace.getTracer('sales-service');

// Log database connection errors
db.on('error', (err, client) => {
    console.error('Unexpected error on idle PostgreSQL client', err);
});
// Helper function to check if it's between 8:00 AM and 8:30 AM CST, Monday - Friday
function isBusinessHoursCSTStrict() {
    const now = DateTime.now().setZone('America/Chicago'); // Set timezone to CST

    const dayOfWeek = now.weekday; // Monday is 1, Sunday is 7
    const hour = now.hour;
    const minute = now.minute;

    const isWeekday = dayOfWeek >= 1 && dayOfWeek <= 7; // Monday (1) to Friday (5)
    // Check if hour is exactly 8 AND minute is between 0 (inclusive) and 30 (exclusive)
    const isStrictBusinessHour = hour === 10 && minute >= 0 && minute < 45;

    return isWeekday && isStrictBusinessHour;
}

// Get all sales
router.get('/', async (req, res) => {
    try {
        const result = await db.query('SELECT * FROM Sales');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Get total sales by month
router.get('/monthly', async (req, res) => {
    try {
        const result = await db.query(`
            SELECT
                EXTRACT(YEAR FROM order_date) AS year,
                EXTRACT(MONTH FROM order_date) AS month,
                SUM(total) AS total_amount
            FROM
                orders
            GROUP BY
                month , year
            ORDER BY
                month ASC, year ASC;
    `);
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
router.get('/monthly/simappissue', async (req, res) => {
    const parentSpan = trace.getSpan(context.active());
    const monthlyQuerySpan = tracer.startSpan('getMonthlySales', { parent: parentSpan });
    const delayApplied = isBusinessHoursCSTStrict();
    const delayDurationMs = 1500; // 1.5 seconds

    // Add attributes to the span to indicate if the delay condition was met
    monthlyQuerySpan.setAttribute('delay_condition_met', delayApplied);
    if (delayApplied) {
        monthlyQuerySpan.setAttribute('simulated_delay_ms', delayDurationMs);
        console.log(`[${DateTime.now().setZone('America/Chicago').toLocaleString(DateTime.DATETIME_FULL)}] Business hours (8:00-8:30 AM CST). Applying ${delayDurationMs}ms delay to /monthly query.`);
    } else {
        console.log(`[${DateTime.now().setZone('America/Chicago').toLocaleString(DateTime.DATETIME_FULL)}] Not business hours (8:00-8:30 AM CST). No delay applied to /monthly query.`);
    }

    try {
        let queryPrefix = '';
        if (delayApplied) {
            // Inject pg_sleep into the query. It will execute before the rest of the SELECT.
            // pg_sleep takes seconds as an argument.
            queryPrefix = `SELECT pg_sleep(${delayDurationMs / 1000}); `;
        }
        const result = await db.query(`
            ${queryPrefix}
            SELECT
                EXTRACT(YEAR FROM order_date) AS year,
                EXTRACT(MONTH FROM order_date) AS month,
                SUM(total) AS total_amount
            FROM
                orders
            GROUP BY
                month , year
            ORDER BY
                month ASC, year ASC;
    `);
        res.json(result.rows);
        monthlyQuerySpan.setStatus({ code: SpanStatusCode.OK });
    } catch (err) {
        res.status(500).json({ error: err.message });
        monthlyQuerySpan.setStatus({ code: SpanStatusCode.ERROR, message: err.message });
    } finally {
        monthlyQuerySpan.end(); // End the span
    }
});
// Create a new sale
router.post('/', async (req, res) => {
    const { order_id, product_id, quantity, total, location_id } = req.body;
    try {
        const result = await db.query(
            'INSERT INTO Sales (order_id, product_id, quantity, total, location_id) VALUES ($1, $2, $3, $4, $5) RETURNING *',
            [order_id, product_id, quantity, total, location_id]
        );
        res.status(201).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Update a sale
router.put('/:id', async (req, res) => {
    const { id } = req.params;
    const { order_id, product_id, quantity, total, location_id } = req.body;
    try {
        const result = await db.query(
            'UPDATE Sales SET order_id = $1, product_id = $2, quantity = $3, total = $4, location_id = $5 WHERE sale_id = $6 RETURNING *',
            [order_id, product_id, quantity, total, location_id, id]
        );
        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Delete a sale
router.delete('/:id', async (req, res) => {
    const { id } = req.params;
    try {
        await db.query('DELETE FROM Sales WHERE sale_id = $1', [id]);
        res.json({ message: 'Sale deleted successfully' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Additional CRUD operations for sales...

export default router;