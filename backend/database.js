/**
 * Created by andrey on 03.04.2016.
 */
var mysql = require('mysql');

var read_pool  = mysql.createPool({
    connectionLimit : 10,
    host            : 'localhost',
    user            : 'wf_read',
    password        : 'wf_read',
    database        : 'weather_forecast'
});

exports.read_pool = read_pool;