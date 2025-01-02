import mariadb from 'mariadb';

const db = mariadb.createConnection(
    {
        host: '192.168.1.217',
        user: 'dbuser',
        password: 'CAdemo123',
        database: 'DemoWebAppProd'
    }
)

export default db;