/**
 * Created by andrey on 03.04.2016.
 */
var pool = require('../database').read_pool;

module.exports = function listForecast(req, res) {
    pool.query(
        'select ' +
        '   provider.id, provider.title ' +
        'from forecast_provider as provider '
        , function(err, rows, fields) {
            if (err) {
                res.send({error: err});
            } else {
                res.send(rows);
            }
        });
};