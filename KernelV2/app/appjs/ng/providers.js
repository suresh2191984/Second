'use strict';

angular.module('attuneKernel.providers', ["ui.router"]).provider('$profile', function () {
    this.path = '';
    this.profile = null;
    this.$get = ['$http', '$q', function ($http, $q) {
        var self = this;
        return {
            getProfile: function () {
                var deferred = $q.defer();
                $http.get(self.path).then(function (value) {
                    deferred.resolve(value);
                });
                return deferred.promise;
            }
        };
    }];
    this.setPath = function (path) {
        this.path = path;
    };
}).provider('$settings', function () {
    this.path = '';
    this.profile = null;
    this.$get = ['$http', '$q', function ($http, $q) {
        var self = this;
        return {
            getAppSettings: function () {
                var deferred = $q.defer();
                $http.get(self.path).then(function (value) {
                    deferred.resolve(value);
                });
                return deferred.promise;
            }
        };
    }];
    this.setPath = function (path) {
        this.path = path;
    };
}).provider('$menu', function () {
    var menus = {};
    this.$get = function () {
        return {
            getMenu: function () {
                return menus;
            }
        };
    };
    this.setMenu = function (menuCollection) {
        menus = menuCollection;
    };
});