const mysql = require('mysql2');

const db = mysql.createPool({
    connectionLimit: 10,
    host: '192.168.1.32',
    user: 'dbuser',
    password: 'CAdemo123',
    database: 'DemoWebAppDB'
});

module.exports = db;