const mysql = require('mysql2');
const db = mysql.createPool({
    connectionLimit: 10,
    host: 'localhost',
    user: 'dbuser',
    password: 'CAdemo123',
    database: 'DemoWebAppDB'
});

module.exports = db;