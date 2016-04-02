create table weather_forecast.forecast_provider (
    id int primary key,
    title varchar(256) character set 'utf8',
    code varchar(32) character set 'utf8'
);

create unique index forecast_provider_code on weather_forecast.forecast_provider (code);

create table weather_forecast.forecast (
    id int primary key auto_increment,
    time timestamp,
    provider_id int,
    temp numeric(10,2),
    pressure numeric(10,2),
    humidity int,
    weather_info varchar(32)
);

create table weather_forecast.city (
    id int primary key,
    city varchar(32),
    country_id int,
    lon numeric(10,8),
    lat numeric(10,8)
);

create table weather_forecast.city_to_provider (
    id int privary key,
    city_id int,
    provider_city_id int
);

create table weather_forecast.country (
    id int primary key,
    country varchar(32)
);