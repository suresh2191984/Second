'use strict';
angular.module('attuneKernel.services').factory('gateWayService', ['$q', '$injector', '$location', 'AttLocalstorage', '$window',
		function ($q, $injector, $location, AttLocalstorage, $window) {

			var authInterceptorServiceFactory = {};

			var _request = function (config) {
				config.headers = config.headers || {};
				var authData =JSON.parse(AttLocalstorage.get('loggedinuser'));
				if (authData) {
					config.headers.Authorization = 'Bearer ' + authData.token;
				}
				return config;
			}

			var _responseError = function (rejection) {
				if (rejection.status === 401) {
					////var authService =     injector.get('authService');
					////var authData = localStorageService.get('gatePass');
					////if (authData) {
					////    if (authData.useRefreshTokens) {
					////        $location.path('/refresh');
					////        return $q.reject(rejection);
					////    }
					////}
					////authService.logOut();
					////$location.path('/login');
					 AttLocalstorage.removeAll();
					alert('Authorization has been denied for this request.');
					////window.sessionStorage.clear();
					////$window.location.href = '../Home.aspx';
					//return;
					$window.location.href = '../Home.aspx';
				}
				return $q.reject(rejection);
			}

			var _response = function (res) {

				return res;
			}

			authInterceptorServiceFactory.request = _request;
			authInterceptorServiceFactory.response = _response;
			authInterceptorServiceFactory.responseError = _responseError;

			return authInterceptorServiceFactory;
		}
	]);
