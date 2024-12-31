//import db from './app-db.js';
//
// const authenticateApiKey = (req, res, next) => {
//     //const apiKey = req.headers['x-api-key'];
//     if (!apiKey) {
//         return res.status(401).json({ error: 'Unauthorized: API key required' });
//     }
//
//     const query = 'SELECT * FROM ApiKeys WHERE api_key = ?';
//     db.query(query, [apiKey], (err, results) => {
//         if (err) return response.status(500).json({ error: err.message });
//         if (results.length === 0) return res.status(401).json({ error: 'Unauthorized: Invalid API key' });
//
//         next();
//     });
// };

export default authenticateApiKey();