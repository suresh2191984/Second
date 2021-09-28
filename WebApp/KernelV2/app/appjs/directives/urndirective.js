angular.module('attuneKernel.directives')
.directive('urnDirective', function () {
    return {
        controller: ['$scope', '$rootScope', 'masterdataAPI', 'Notification', function ($scope, $rootScope, masterdataAPI, Notification) {
            var urn_func = function (data, error) {
                if (error) {
                    return false;
                }
                $scope.objurn = data;
            }
            var checkurnLoaded = function (data, error) {
                if (error) {
                    return false;
                }
                if (data.length > 0) {
                    Notification.error({ message: 'URN Already Exists Provide New URN', title: 'Alert' });
                    $scope.urn.URN = "";
                }
            }
            masterdataAPI.geturntype(urn_func);

            $scope.checkurn = function (TypeID, URN) {
                if (!angular.isUndefined(TypeID) && !angular.isUndefined(URN) && URN != "" && TypeID > 0)
                    masterdataAPI.checkurn(TypeID, URN, checkurnLoaded);
            }
        }],
        templateUrl: '../KernelV2/app/template/directives/urnDirective.html',
        restrict: 'AE',
        scope: {
            urn: '=urn'
        }
    };
})