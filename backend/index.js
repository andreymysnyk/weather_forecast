/**
 * Created by andrey on 03.04.2016.
 */
var server = require('./server');

server.listen(8080, function () {
    console.log('WeatherForecast API server listening on %j', server.address());
});