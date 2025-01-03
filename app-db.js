import pkg from 'pg';
const { Pool } = pkg;

const db = new Pool({
    user: 'dbuser',
    host: '192.168.1.142',
    database: 'demowebapp_prod',
    password: 'CAdemo123',
    port: 5432,
});

export default db;