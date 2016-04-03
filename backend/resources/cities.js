/**
 * Created by andrey on 03.04.2016.
 */
var pool = require('../database').read_pool;

module.exports = function listCities (req, res) {
    pool.query(
        'select ' +
        '   city.id, city.city, country.country ' +
        'from city as city ' +
        'left join country as country on city.country_id = country.id'
    , function(err, rows, fields) {
        if (err) {
            res.send({error: err});
        } else {
            res.send(rows);
        }
    });
};