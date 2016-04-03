/**
 * Created by andrey on 03.04.2016.
 */
var mysql = require('mysql');
var nconf = require('nconf');
var db_conf = nconf.get('database');

var read_pool  = mysql.createPool({
    connectionLimit : 10,
    host            : db_conf.host,
    user            : db_conf.read_user,
    password        : db_conf.read_password,
    database        : db_conf.database
});

var write_pool  = mysql.createPool({
    connectionLimit : 2,
    host            : db_conf.host,
    user            : db_conf.write_user,
    password        : db_conf.write_password,
    database        : db_conf.database
});

exports.read_pool = read_pool;
exports.write_pool = write_pool;