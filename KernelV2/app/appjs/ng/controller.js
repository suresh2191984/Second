// INSTRUCTIONS:
// 1. Whenever injecting any service or param into the controllers/functions update them into minification safe injection array as well
'use strict';

angular.module('attuneKernel.controllers', [])

.controller('attHeaderController', ['$scope', 'attHeaderAPI', '$state', "$menu", "$interval",
    'REFRESHINTERVAL', '$window',
function($scope, attHeaderAPI, $state, $menu, $interval, REFRESHINTERVAL, $window) {
    $scope.chevron = true;
    $scope.Menu = MenuName;     
    $scope.menuItems = $menu.getMenu();
    $scope.OrgHeader = {};
    var onProfileLoaded = function(data, error) {
        if (error != null) {
            return;
        }
        $scope.Profile = data;
        $scope.OrgHeader.OrgID = data.Organization[0].SelectedOrgID;
        $scope.OrgHeader.RoleID = data.Role[0].SelectedRoleID;
        $scope.OrgHeader.AddressID = data.Location[0].SelectedAddressID;
        $interval(renewIdentity, REFRESHINTERVAL.tokenInterval, false);
    };

    var renewIdentityComplete = function(data, error) {
        attHeaderAPI.setDate();
    };

    var renewIdentity = function() {
        attHeaderAPI.getRenewIdentity(renewIdentityComplete);
    };
    var onChenagedProfile = function(data, error) {
        if (error != null) {
            return;
        }
        if (data.Controller) {
            $state.go(data.MenuName)
        }
        else {
            $window.location.href = ".." + data.MenuURL;
        }
    }

    $scope.onChangeProfile = function() {
        attHeaderAPI.updateProfile($scope.OrgHeader, onChenagedProfile);
    }
    attHeaderAPI.getProfile(onProfileLoaded);

    $scope.logout = function () {
        localStorage.clear();
        sessionStorage.clear();
    };

}
]).controller('attFooterController', ['$scope',
		function($scope) { } ]);
