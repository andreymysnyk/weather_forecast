/**
 * Created by amisnik on 04.04.2016.
 */
(function () {
    var app = angular.module('weather forecast', [ ]);

    app.controller('ForecastController', function ($scope, $http) {
        $scope.providerId = 0;
        $scope.providerList = [];

        $http({
            method: 'GET',
            url: 'http://localhost:8080/providers',
            data: {}
        }).success(function (result) {
            $scope.providerList = result;
        });

        $scope.cityId = 0;
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
                $scope.forecast = result;
            });
        }
    });
})();

