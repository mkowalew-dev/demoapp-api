import mysql from 'mysql2';

const db = mysql.createConnection(
    {
        host: 'localhost',
        user: 'dbuser',
        password: 'CAdemo123',
        database: 'DemoWebAppProd'
    }
)

export default db;