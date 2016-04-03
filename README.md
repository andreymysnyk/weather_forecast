# weather_forecast
API description

/cities - returns list of cities
Example:
[{"id":1,"city":"Sumy","country":"Ukraine"}]

/providers - returns list of providers
Example:
[{"id":1,"title":"OpenWeatherMap"}]

/forecast/:providerId/:cityId?offset=(minutes) - return forecast for city
Example:
[{"time":"00:00 04.04.2016","temp":17.32,"pressure":1018.69,"humidity":100,"weather_info":"Clear"}]