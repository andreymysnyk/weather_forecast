drop database if exists weather_forecast;

drop user 'wf_read'@'localhost';
drop user 'wf_write'@'localhost';

create database weather_forecast;

create user 'wf_read'@'localhost' identified by 'wf_read';
create user 'wf_write'@'localhost' identified by 'wf_write';

grant SELECT on weather_forecast.* to 'wf_read'@'localhost';
grant SELECT,INSERT,UPDATE on weather_forecast.* to 'wf_write'@'localhost';

flush privileges;
