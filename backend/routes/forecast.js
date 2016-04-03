/**
 * Created by andrey on 03.04.2016.
 */
var pool = require('../database').read_pool;

module.exports = function listForecast(req, res) {
    pool.query(
        'select ' +
        ' date_format(time - interval ifnull(?, 0) minute, \'%H:%i %d.%m.%Y\') as time, temp, pressure, humidity, weather_info  ' +
        'from forecast ' +
        'where city_id = ? and provider_id = ? and time >= utc_timestamp() limit 8',
    [req.params.offset, req.params.city, req.params.provider],
    function(err, rows, fields) {
        if (err) {
            res.send({error: err});
        } else {
            res.send(rows);
        }
    });
};