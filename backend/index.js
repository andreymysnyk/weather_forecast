/**
 * Created by andrey on 03.04.2016.
 */
var nconf = require('nconf');
nconf.file('./config.json');

var server = require('./server');
server.listen(nconf.get('server_port'), function () {
    console.log('WeatherForecast API server listening on %j', server.address());
});