const express = require('express');
const OAuth2Server = require('oauth2-server');
const bodyParser = require('body-parser');
const model = require('./model');

const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const oauth = new OAuth2Server({
    model,
    accessTokenLifetime: 60 * 60, // 1 hour
    allowBearerTokensInQueryString: true
});
app.post('/token/verify', (req, res) => {
    const { token } = req.body;
    const request = new OAuth2Server.Request({ headers: { authorization: `Bearer ${token}` } });
    const response = new OAuth2Server.Response(res);

    oauth.authenticate(request, response)
        .then(token => res.json({ active: true, user: token.user }))
        .catch(() => res.json({ active: false }));
});

app.post('/token', (req, res, next) => {
    const request = new OAuth2Server.Request(req);
    const response = new OAuth2Server.Response(res);

    oauth.token(request, response)
        .then(token => {
            res.json(token);
        })
        .catch(err => {
            res.status(err.code || 500).json(err);
        });
});

// Optional: Authorization code flow (interactive)
app.get('/authorize', (req, res) => {
    res.send('Login page would be here in real app');
});

module.exports = { app, oauth };

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Auth service running on port ${PORT}`));
