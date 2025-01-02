import mariadb from "mariadb";
import express from "express";

const app = express();
const port = 4000;

let conn = await mariadb.createConnection({
    host: "localhost",
    user: "dbuser",
    password: "CAdemo123",
    database: "DemoWebAppProd",
});
// Define a route to query orders
app.get('/orders', async (req, res) => {
    try {
        const rows = await conn.query('SELECT * FROM DemoWebAppProd.orders'); // Replace 'orders' with your table name
        res.json(rows);
    } catch (err) {
        res.status(500).send('Error querying orders: ' + err.message);
    } finally {
        // if (conn) conn.release(); // Release to pool
    }
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});

// // Main function
// async function main() {
//     let conn;
//
//     try {
//
//
//         // Use Connection to get contacts data
//         var rows = await get_contacts(conn);
//         let i;
//         let len;
//         //Print list of contacts
//         for (i = 0, len = rows.length; i < len; i++) {
//             console.log(`${rows[i].order_date} ${rows[i].status} <${rows[i].total}>`);
//         }
//     } catch (err) {
//         // Manage Errors
//         console.log(err);
//     } finally {
//         // Close Connection
//         if (conn) conn.close();
//     }
// }
//
// //Get list of contacts
// function get_contacts(conn) {
//     return conn.query("SELECT * from DemoWebAppProd.Orders");
// }
//
// main();