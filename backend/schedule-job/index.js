/**
 * Created by andrey on 03.04.2016.
 */
var pool = require('../database').write_pool;
var nconf = require('nconf');
var request = require('request');
var async = require('async');

module.exports = function scheduleJob () {
    pool.query(
        'select ' +
        '   provider.id, provider.code ' +
        'from forecast_provider as provider'
    , function(err, rows, fields) {
        if (err) {
            console.error(err);
        } else {
            rows.forEach(fetchProviderForecast);
        }
    });
};

function fetchProviderForecast(provider) {
    try {
        var conf = nconf.get(provider.code);
        var converter = require('./' + provider.code);

        pool.query(
            'select city_id, provider_city_id, provider_id from city_to_provider where provider_id = ?',
            provider.id,
            function (err, rows, fields) {
                if (err) {
                    console.error(err);
                } else {
                    async.eachSeries(rows, function iterateCity (item, cb) {
                        fetchProviderForecastByCity(conf.url, item, converter, cb);
                    });
                }
            }
        )
    } catch (err) {
        console.error(err);
    }
}

function fetchProviderForecastByCity(url, city, converter, cb) {
    var req_url = url.replace(':cityId', city.provider_city_id);

    request(req_url, function (err, response, body) {
        if (err) {
            console.error(err);
        } else {
            var forecast = converter(body);

            async.eachSeries(forecast, function iterateForecast (item, callback) {
                item.provider_id = city.provider_id;
                item.city_id = city.city_id;

                pool.query(
                    'insert into forecast (time, provider_id, city_id, temp, pressure, humidity, weather_info) ' +
                    'values (?, ?, ?, ?, ?, ?, ?) ' +
                    'on duplicate key update temp = ?, pressure = ?, humidity = ?, weather_info = ?',
                [item.time, item.provider_id, item.city_id,
                    item.temp, item.pressure, item.humidity, item.weather_info,
                    item.temp, item.pressure, item.humidity, item.weather_info],
                function (err) {
                    if (err) {
                        console.error(err);
                        console.error(item);
                    }

                    callback();
                });
            }, function done() {
                cb();
            });
        }
    });
}