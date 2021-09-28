// INSTRUCTIONS: Whenever injecting any service or param into the controllers/functions update them
// into minification safe injection array as well

'use strict';
var partialsDir = './app/partials/';
var MenuName = null;
var initInjector = angular.injector(["ng", "LocalStorageModule", 'attuneKernel.services', 'attuneKernel.constants']);
var $http = initInjector.get("$http");
var sappLS = initInjector.get("AttLocalstorage");
var loginGuid = sappLS.get("loginGuid");
var $window = initInjector.get("$window")
var MENU_COLLN = null;
if (!loginGuid) {
    $window.location.href = '../Home.aspx';
}
else {
    var LoggedInApp = sappLS.get("LoggedInApp");
    var attHeaderAPI = initInjector.get("attHeaderAPI")
    var onGateWayCompleted = function (data, error) {
        if (error) {
            $window.location.href = '../Home.aspx';
            return;
        }
        attHeaderAPI.GetAllMenuItems(data, onMenuLoaded);
    };
    var onMenuLoaded = function (data, error) {
        if (error != null) {
            alert(error.error);
            $window.location.href = '../Home.aspx';            
        }
        MENU_COLLN = data;
        angular.element(document).ready(function () {
            angular.bootstrap(document, ['attuneKernel']);
        });
    };
    var identity = {};
    identity.password = loginGuid;
    identity.client_Secret = LoggedInApp;
    attHeaderAPI.getIdentity(identity, onGateWayCompleted);


}
function getMenuInfo() {
    return MENU_COLLN;
}

angular.module('attuneKernel', ['ngMessages', 'ngAnimate', 'attuneKernel.providers',
            'attuneKernel.constants', 'attuneKernel.filters', 'attuneKernel.services',
		 'attuneKernel.directives', 'attuneKernel.controllers',
		 'ngSanitize', 'ui.bootstrap', 'mgcrea.ngStrap',
		 "ui.router", "LocalStorageModule", 'angular-loading-bar',
		'oc.lazyLoad', 'angular-linq', 'ui-notification', 'anguFixedHeaderTable', 'ui.bootstrap.datetimepicker', 'angularjs-datetime-picker'
])
.filter("sanitize", ['$sce', function ($sce) {
    return function (htmlCode) {
        return $sce.trustAsHtml(htmlCode);
    }
}])
.config(['NotificationProvider', '$compileProvider', 'cfpLoadingBarProvider', '$httpProvider', '$stateProvider', '$popoverProvider', '$urlRouterProvider', '$ocLazyLoadProvider', '$menuProvider',
function (NotificationProvider, $compileProvider, cfpLoadingBarProvider, $httpProvider, $stateProvider, $popoverProvider, $urlRouterProvider, $ocLazyLoadProvider, $menuProvider) {

    $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|file|ftp|blob):|data:image\//);

    $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

    $httpProvider.interceptors.push('gateWayService');
    //cfpLoadingBarProvider.includeSpinner = false;

    //$urlRouterProvider.otherwise('/home');

    var menuInfo = getMenuInfo();

    var GetFiles = function (depFiles) {
        return {
            deps: ['$ocLazyLoad', '$state', function ($ocLazyLoad, $state) {
                return $ocLazyLoad.load([{
                    name: 'myApp',
                    files: depFiles.split(',')
                }
                ]);
            }
            ]
        };
    };

    NotificationProvider.setOptions({
        delay: 3000,
        startTop: 20,
        startRight: 10,
        verticalSpacing: 20,
        horizontalSpacing: 20,
        positionX: 'right',
        positionY: 'bottom',
        replaceMessage: true 
    });

    if (menuInfo) {
        $menuProvider.setMenu(menuInfo);
        angular.forEach(menuInfo, function (mainMenu, mainKey) {
            angular.forEach(mainMenu['SubMenu'], function (menuItem, menuKey) {
                if (menuItem.Controller) {
                    MenuName = menuItem.MenuName;
                    $stateProvider.state(menuItem.MenuName, {
                        url: "/" + menuItem.MenuURL,
                        controller: menuItem.Controller,
                        templateUrl: partialsDir + menuItem.TemplateUrl,
                        resolve: GetFiles(menuItem.Dependencies)
                    });
                }
            });
        });
        //$urlRouterProvider.otherwise('/resultcapture-new');
    }


}]).run(['$rootScope', '$window', 'Auth', function ($rootScope, $window, Auth) {
    $rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams, options) {
        if (!Auth.isLoggedIn()) {
            event.preventDefault();
            $window.location.href = '../Home.aspx';
        }
    });
    console.clear();
}]);

