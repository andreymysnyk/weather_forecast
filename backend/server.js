/**
 * Created by andrey on 03.04.2016.
 */
var restify = require('restify');
var routes = require('./routes');

var options = {
    name: 'WeatherForecast API'
};

var server = restify.createServer(options);
server.use(restify.queryParser());

server.use(restify.CORS({}));

// routes
server.get('/providers', routes.listProviders);
server.get('/cities', routes.listCities);
server.get('/forecast/:provider/:city/', routes.listForecast);

module.exports = server;