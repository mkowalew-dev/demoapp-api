const { oauth } = require('./index');
const OAuth2Server = require('oauth2-server');

module.exports = function authenticateRequest(req, res, next) {
    const request = new OAuth2Server.Request(req);
    const response = new OAuth2Server.Response(res);

    oauth.authenticate(request, response)
        .then(token => {
            req.user = token.user;
            next();
        })
        .catch(err => {
            res.status(err.code || 401).json({ error: err.message });
        });
};
