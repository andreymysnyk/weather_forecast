/**
 * Created by andrey on 03.04.2016.
 */
module.exports = function converter (body) {
    var results = [];

    if (body) {
        var response = JSON.parse(body);

        response.list.forEach(function (item) {
            results.push({
                time: item.dt_txt,
                temp: item.main.temp,
                pressure: item.main.pressure,
                humidity: item.main.humidity,
                weather_info: item.weather[0].main
            });
        });
    }

    return results;
};