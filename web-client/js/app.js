/**
 * Created by amisnik on 04.04.2016.
 */
(function () {
    var app = angular.module('weather forecast', [ ]);

    app.controller('ForecastController', function ($scope, $http) {
        $scope.providerId = 1;
        $scope.providerList = [];

        $http({
            method: 'GET',
            url: 'http://localhost:8080/providers',
            data: {}
        }).success(function (result) {
            $scope.providerList = result;
        });

        $scope.cityId = 1;
        $scope.cityList = [];

        $http({
            method: 'GET',
            url: 'http://localhost:8080/cities',
            data: {}
        }).success(function (result) {
            $scope.cityList = result;
        });

        $scope.forecast = [];

        $scope.loadForecast = function () {
            $http({
                method: 'GET',
                url: 'http://localhost:8080/forecast/' + $scope.providerId + '/' + $scope.cityId + '?offset=' + new Date().getTimezoneOffset(),
                data: {}
            }).success(function (result) {
                var maxIndex = result.length - 1;

                result.forEach(function(item, index) {
                    var prev = result[index > 0 ? index - 1 : index];
                    var next = result[index < maxIndex ? index + 1 : index];

                    item.temp_left = (prev.temp + item.temp) / 2;
                    item.temp_right = (item.temp + next.temp) / 2;
                });

                $scope.forecast = result;
            });
        };

        $scope.isDay = isDay;
    });

    app.directive('initCanvas', function ($timeout) {
        return {
            restrict: 'A',
            link: function (scope, element, attr) {
                var canvasEl = element[0].getElementsByTagName('canvas')[0];

                $timeout(function() {
                    drawTemp(canvasEl, isDay(scope.item), scope.item.temp_left, scope.item.temp_right);
                    element[0].className += " load";
                }, 80 * scope.$index)
            }
        }
    });
})();

function isDay(item) {
    var hours = item.time.split(' ')[0].substring(0, 2);
    return hours > 7 && hours < 19;
}

function drawTemp (el, isDay, temp_left, temp_right) {
    if (el.getContext) {
        var ctx = el.getContext('2d');

        var y_left = calcPos(temp_left);
        var y_right = calcPos(temp_right);
        var y_zero = calcPos(0);
        var y_middle = (y_left + y_right) / 2;

        ctx.globalAlpha = 0.75;
        var gradient = ctx.createLinearGradient(48, y_middle, 48, 250);
        gradient.addColorStop(0, isDay ? 'rgb(255, 200, 80)' : 'rgb(80, 200, 255)');
        gradient.addColorStop(1, 'white');
        ctx.fillStyle = gradient;
        
        ctx.beginPath();
        ctx.moveTo(0, y_left);
        ctx.lineTo(95, y_right);
        ctx.lineTo(95, 250);
        ctx.lineTo(0, 250);
        ctx.closePath();
        ctx.fill();

        ctx.globalAlpha = 0.3;
        ctx.strokeStyle = 'rgb(255, 0, 0)';

        ctx.beginPath();
        ctx.moveTo(0, y_zero);
        ctx.lineTo(95, y_zero);
        ctx.closePath();
        ctx.stroke();
    }
}

function calcPos(cur_t) {
    return 250 * (1 - (cur_t + 20) / 60);
}