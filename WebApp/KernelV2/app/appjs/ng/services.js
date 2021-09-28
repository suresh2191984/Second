// INSTRUCTIONS:
// 1. Whenever injecting any service or param into the controllers/functions update them into minification safe injection array as well

'use strict';
angular.module('attuneKernel.services', ['ngFileUpload'])
.factory('DataFactory', ['$http', 'ENV', 'Upload', function ($http, ENV, Upload) {

    //ENV.apiEndPoint = 'http://localhost/PlatFormA/' + 'api/v1/';

    var dataFactory = {};

    dataFactory.get = function (controllerName, param, isArray, authData) {
        if (authData) {
            return $http({
                url: ENV.apiEndPoint + controllerName,
                method: 'GET',
                params: param || null,
                isArray: isArray == undefined ? true : false,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                    'Authorization': 'Bearer ' + authData
                }

            });
        }
        return $http({
            url: ENV.apiEndPoint + controllerName,
            method: 'GET',
            params: param || null,
            isArray: isArray == undefined ? true : false,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            }
        });


    };

    dataFactory.getplatform = function (controllerName, param, isArray) {
        return $http({
            url: ENV.platformEndPoint + controllerName,
            method: 'GET',
            params: param || null,
            isArray: isArray == undefined ? true : false,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            }
        });
    };
    dataFactory.getPatientBannerDetails = function (controllerName, param, isArray) {
        return $http({
            url: ENV.platformEndPoint + controllerName,
            method: 'GET',
            params: param || null,
            isArray: isArray == undefined ? true : false,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            }
        });
    };
    dataFactory.postplatform = function (controllerName, param, payload, token) {
        return $http({
            url: ENV.platformEndPoint + controllerName,
            dataType: "json",
            method: 'POST',
            params: param,
            data: payload,
            headers: token
        });
    };
    dataFactory.post = function (controllerName, param, payload) {
        return $http({
            url: ENV.apiEndPoint + controllerName,
            dataType: "json",
            method: 'POST',
            params: param,
            data: payload
        });
    };

    dataFactory.put = function (controllerName, param, payload, token) {
        return $http({
            url: ENV.apiEndPoint + controllerName,
            dataType: 'json',
            method: 'PUT',
            params: param,
            data: payload,
            headers: token
        });
    };

    dataFactory.delete = function (controllerName, param, token) {
        return $http({
            url: ENV.apiEndPoint + controllerName,
            dataType: 'json',
            method: 'DELETE',
            params: param,
            headers: token
        });
    };
    dataFactory.upload = function (controllerName, files, payload, token) {
       
            return Upload.upload({
                url: ENV.apiEndPoint + controllerName,
                method: "POST",
                dataType: 'Application/json',
                file: files,
                data: {
                    FileData: payload
                } 
                //headers: token
                // headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' }
            });
    };

    return dataFactory;
}]);

angular.module('attuneKernel.services')
.factory('AuthTokenService', ['AUTHTOKEN', function (AUTHTOKEN) {
    var authToken = {
        sessionToken: undefined,
        fieldToken: undefined,
        setRequestHeaderToken: function (headers) {
            if (headers != null && headers != undefined
                 && (headers(AUTHTOKEN.SESSION) != undefined
                     && headers(AUTHTOKEN.FIELD) != undefined
                     && headers(AUTHTOKEN.SESSION) != null
                     && headers(AUTHTOKEN.FIELD) != null)) {
                this.sessionToken = headers(AUTHTOKEN.SESSION);
                this.fieldToken = headers(AUTHTOKEN.FIELD);
            }
        },
        getRequestHeaderToken: function () {
            return (this.sessionToken != undefined && this.fieldToken != undefined) ? {
                'X-XSRF-Ajax-Tokens': this.sessionToken + ":" + this.fieldToken,
                'X-Requested-With': 'XMLHttpRequest',
                'Content-Type': 'application/json; charset=UTF-8'
            }
             : {
                 'Content-Type': 'application/json; charset=UTF-8'
             };
        }
    };
    return authToken;
}
]);

angular.module('attuneKernel.services')
.factory('AppService', ['PRIVILEGE', function (Privileges) {
    /* Application centric services */
    var appService = {};

    appService.Security = {
        Privileges: Privileges,
        getPrivileges: function (weight) {
            var permissions = {};
            for (var p in Privileges) {
                permissions[p] = this.getPrivilegeToBool(weight, Privileges[p]);
            }
            return permissions;
        },
        getPrivilegeToBool: function (weight, privilege) {
            return (weight & privilege) == privilege ? true : false;
        },
        getPrivilegeWeight: function (permissions) {
            var weight = 0; // 0 => no permission on an entity
            if (!permissions)
                return weight;
            for (var p in Privileges) {
                if (permissions[p])
                    weight += Privileges[p]
            }
            return weight;
        }
    };

    return appService;
}
]).factory("AttLocalstorage", ['localStorageService', function (localStorageService) {
    var Base64 = {
        characters: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

        encode: function (string) {
            var characters = Base64.characters;
            var result = '';

            var i = 0;
            do {
                var a = string.charCodeAt(i++);
                var b = string.charCodeAt(i++);
                var c = string.charCodeAt(i++);

                a = a ? a : 0;
                b = b ? b : 0;
                c = c ? c : 0;

                var b1 = (a >> 2) & 0x3F;
                var b2 = ((a & 0x3) << 4) | ((b >> 4) & 0xF);
                var b3 = ((b & 0xF) << 2) | ((c >> 6) & 0x3);
                var b4 = c & 0x3F;

                if (!b) {
                    b3 = b4 = 64;
                } else if (!c) {
                    b4 = 64;
                }

                result += Base64.characters.charAt(b1) + Base64.characters.charAt(b2) + Base64.characters.charAt(b3) + Base64.characters.charAt(b4);

            } while (i < string.length);

            return result;
        },

        decode: function (string) {
            var characters = Base64.characters;
            var result = '';

            var i = 0;
            do {
                var b1 = Base64.characters.indexOf(string.charAt(i++));
                var b2 = Base64.characters.indexOf(string.charAt(i++));
                var b3 = Base64.characters.indexOf(string.charAt(i++));
                var b4 = Base64.characters.indexOf(string.charAt(i++));

                var a = ((b1 & 0x3F) << 2) | ((b2 >> 4) & 0x3);
                var b = ((b2 & 0xF) << 4) | ((b3 >> 2) & 0xF);
                var c = ((b3 & 0x3) << 6) | (b4 & 0x3F);

                result += String.fromCharCode(a) + (b ? String.fromCharCode(b) : '') + (c ? String.fromCharCode(c) : '');

            } while (i < string.length);

            return result;
        }
    };
    var AttLocalstorage = {
        Base64: Base64,
        set: function (key, val) {
            if (val) {
                localStorageService.set(key, this.Base64.encode(val));
            }
        },
        get: function (key) {
            var localval = localStorageService.get(key);
            if (localval) {
                return this.Base64.decode(localval);
            }
            return localval;
        },
        remove: function (key) {
            return localStorageService.remove(key);
        },
        removeAll: function () {
            localStorageService.clearAll();
        }
    };

    return AttLocalstorage;
}]).factory('Auth', ['AttLocalstorage', function (AttLocalstorage) {
    return {
        isLoggedIn: function () {
            var authData = JSON.parse(AttLocalstorage.get('loggedinuser'));
            return (authData) ? authData : false;
        }
    }
}]).factory('PageDetails', ['$menu', '$filter', function ($menu, $filter) {
    var pageID = {};
    return {
        GetPageID: function (url) {
            angular.forEach($menu.getMenu(), function (menu) {
                var menuContext = $filter('filter')(menu.SubMenu, { MenuURL: url.substr(1)});
                if (menuContext.length > 0) {
                    pageID = menuContext[0].PageID;
                }
            });
            return pageID;
        }
    }
}]);

