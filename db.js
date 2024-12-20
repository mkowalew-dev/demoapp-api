const mysql = require('mysql2');

const db = mysql.createPool({
    connectionLimit: 10,
    host: '192.168.1.21',
    user: 'dbuser1',
    password: 'CAdemo123',
    database: 'DemoWebAppDB'
});

module.exports = db;