'use strict';
angular.module('attuneKernel.services')
.service('attHeaderAPI', ['DataFactory', "AttLocalstorage", 'ngAuthSettings','AuthTokenService',
function (DataFactory, AttLocalstorage, ngAuthSettings,AuthTokenService) {
                var attHeaderAPI = {};
                attHeaderAPI.getIdentity = function (identity, callBack) {
                    var data = "grant_type=password&username=&password=" + identity.password + "&client_id=" + ngAuthSettings.clientId + "&client_Secret=" + identity.client_Secret;
                    DataFactory.post('Authenticate', 0, data).then(function (response) {
                        AttLocalstorage.set('loggedinuser', JSON.stringify({
                            token: response.data.access_token,
                            userName: response.data.userName,
                            refreshToken: response.data.refresh_token,
                            useRefreshTokens: false
                        }));
                        callBack(response.data, null);
                    }, function (error) {
                        callBack(null, error.data);
                    });
                };
                attHeaderAPI.GetAllMenuItems = function (authdata,callBack) {
                    DataFactory.get('menu', 0, false, authdata.access_token).then(function (response) {
                        AuthTokenService.setRequestHeaderToken(response.headers);
                            callBack(response.data, null);
                    },function (error) {
                        callBack(null, error.data);
                    });
                };
                attHeaderAPI.getProfile = function (callBack) {
                    DataFactory.get('profile', 0, false).then(function (response) {
                        AuthTokenService.setRequestHeaderToken(response.headers);
                        callBack(response.data, null);
                    }, function (error) {
                        callBack(null, error.data); 
                    });
                };

                attHeaderAPI.updateProfile = function (profile, callBack) {
                    DataFactory.put('profile', 0, profile, AuthTokenService.getRequestHeaderToken()).then(function (response) {
                        DataFactory.postplatform('UpdateLogin', 0, JSON.stringify(profile), AuthTokenService.getRequestHeaderToken()).then(function (res) {
                            callBack(response.data, null);
                        }, function (error) {
                            callBack(null, error.data);
                        }); 
                        //callBack(response.data, null);
                    }, function (error) {
                        callBack(null, error.data);
                    });
                };
                 
                attHeaderAPI.UpdateLogin = function () {
                   
                };
                attHeaderAPI.setDate = function () {
                    DataFactory.getplatform('GetServerDate', 0, false).then(function (response) {
                    }, function (error) {
                    });
                };
                attHeaderAPI.getIdentity = function (identity, callBack) {
                    var data = "grant_type=password&username=&password=" + identity.password + "&client_id=" + ngAuthSettings.clientId + "&client_Secret=" + identity.client_Secret;
                    DataFactory.post('Authenticate', 0, data).then(function (response) {
                        AttLocalstorage.set('loggedinuser', JSON.stringify({
                            token: response.data.access_token,
                            userName: response.data.userName,
                            refreshToken: response.data.refresh_token,
                            useRefreshTokens: false
                        }));
                        callBack(response.data, null);
                    }, function (error) {
                        callBack(null, error.data);
                    });
                };
                attHeaderAPI.getRenewIdentity = function (callBack) {
                    var identity = JSON.parse(AttLocalstorage.get('loggedinuser'));
                    var LoggedInApp = AttLocalstorage.get("LoggedInApp");
                    var data = "grant_type=refresh_token&refresh_token=" + identity.refreshToken + "&client_id=" + ngAuthSettings.clientId + "&client_Secret=" + LoggedInApp;
                    DataFactory.post('Authenticate', 0, data).then(function (response) {
                        AttLocalstorage.set('loggedinuser', JSON.stringify({
                            token: response.data.access_token,
                            userName: response.data.userName,
                            refreshToken: response.data.refresh_token,
                            useRefreshTokens: false
                        }));
                        callBack(response.data, null);
                    }, function (error) {
                        callBack(null, error.data);
                    });
                };
        
                
                return attHeaderAPI;
            }]);
