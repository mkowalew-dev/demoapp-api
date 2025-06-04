const mysql = require('mysql2/promise');

// Connection pool
const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'password',
    database: process.env.DB_NAME || 'identity_management'
});

module.exports = {
    getAccessToken: async function(token) {
        const [rows] = await pool.query(
            'SELECT * FROM access_tokens WHERE access_token = ?', [token]
        );
        if (!rows.length) return null;

        const tok = rows[0];
        return {
            accessToken: tok.access_token,
            accessTokenExpiresAt: new Date(tok.access_token_expires_at),
            client: { id: tok.client_id },
            user: { id: tok.user_id }
        };
    },

    getClient: async function(clientId, clientSecret) {
        const [rows] = await pool.query(
            'SELECT * FROM clients WHERE client_id = ? AND client_secret = ?', [clientId, clientSecret]
        );
        if (!rows.length) return null;

        const client = rows[0];
        return {
            id: client.client_id,
            clientId: client.client_id,
            clientSecret: client.client_secret,
            grants: client.grants.split(',')
        };
    },

    getUser: async function(username, password) {
        const [rows] = await pool.query(
            'SELECT * FROM users WHERE username = ? AND password = ?', [username, password]
        );
        if (!rows.length) return null;

        return {
            id: rows[0].id,
            username: rows[0].username
        };
    },

    saveToken: async function(token, client, user) {
        await pool.query(
            'INSERT INTO access_tokens (access_token, access_token_expires_at, client_id, user_id) VALUES (?, ?, ?, ?)',
            [token.accessToken, token.accessTokenExpiresAt, client.id, user.id]
        );

        return {
            accessToken: token.accessToken,
            accessTokenExpiresAt: token.accessTokenExpiresAt,
            client: { id: client.id },
            user: { id: user.id }
        };
    },

    verifyScope: async function(token, scope) {
        return true; // You can implement scope validation here
    }
};

