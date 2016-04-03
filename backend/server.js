/**
 * Created by andrey on 03.04.2016.
 */
var restify = require('restify');
var resources = require('./resources');

var options = {
    name: 'WeatherForecast API'
};

var server = restify.createServer(options);

// routes
server.get('/providers', resources.listProviders);
server.get('/cities', resources.listCities);
server.get('/forecast/:provider/:city/', resources.listForecast);

module.exports = server;