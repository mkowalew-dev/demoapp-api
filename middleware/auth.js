// middleware/auth.js
import db from '../app-db.js';
//const validApiKeys = ['d41d8cd98f00b204e9800998ecf8427e', '098f6bcd4621d373cade4e832627b4f6']; // Replace with your actual API keys

const authenticateApiKey = (req, res, next) => {
    const apiKey = req.headers['x-api-key'];
    if (!apiKey) {
        return res.status(401).json({ error: 'Unauthorized: API key required' });
    }

    const query = 'SELECT * FROM apikeys WHERE api_key = ?';
    db.query(query, [apiKey], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(403).json({ error: 'Forbidden: Invalid API key' });
        next();
    });
};
export default authenticateApiKey;