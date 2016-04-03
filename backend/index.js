/**
 * Created by andrey on 03.04.2016.
 */
// configurations
var nconf = require('nconf');
nconf.file('./config.json');

// api server
var server = require('./server');
server.listen(nconf.get('server_port'), function () {
    console.log('WeatherForecast API server listening on %j', server.address());
});

// scheduler
var schedule = require('node-schedule');
var scheduleJob = require('./schedule-job');
schedule.scheduleJob(nconf.get('schedule'), scheduleJob);