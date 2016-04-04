drop database if exists weather_forecast;

drop user 'wf_read'@'localhost';
drop user 'wf_write'@'localhost';

create database weather_forecast;

create user 'wf_read'@'localhost' identified by 'wf_read';
create user 'wf_write'@'localhost' identified by 'wf_write';

grant SELECT on weather_forecast.* to 'wf_read'@'localhost';
grant SELECT,EXECUTE on weather_forecast.* to 'wf_write'@'localhost';

flush privileges;

drop procedure weather_forecast.store_forecast;

delimiter //

create procedure weather_forecast.store_forecast (
  in p_time varchar(32),
  in p_provider_id int,
  in p_city_id int,
  in p_temp numeric(10,2),
  in p_pressure numeric(10,2),
  in p_humidity int,
  in p_weather_info varchar(32))
  begin
    declare cnt int;

     delete from forecast
       where `time` = p_time and `provider_id` = p_provider_id and `city_id` = p_city_id;

    insert into forecast (`time`, `provider_id`, `city_id`, `temp`, `pressure`, `humidity`, `weather_info`)
      values (p_time, p_provider_id, p_city_id, p_temp, p_pressure, p_humidity, p_weather_info);
  end //

delimiter ;