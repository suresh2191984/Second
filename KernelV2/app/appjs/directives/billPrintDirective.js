angular.module('attuneKernel.directives')
.directive('billprintDirective', function () {
    return {
        controller: ['$scope', '$rootScope', '$sce', 'Notification',
        function ($scope, $rootScope, $sce, Notification) {
            $scope.billprint;
        }],
        templateUrl: '../KernelV2/app/template/directives/billPrint.html',
        restrict: 'E',
        scope: {
            billprint: '=billprint',
        }
    };
});
