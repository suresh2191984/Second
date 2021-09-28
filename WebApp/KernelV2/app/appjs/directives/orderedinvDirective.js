
angular.module('attuneKernel.directives')
.directive('orderedINVDirective', function() {
    return {
        controller: ['resultCaptureAPI', '$scope', function(resultCaptureAPI, $scope) {
            var onPatientInvLoaded = function(data, error) {
                if (error) {
                    return;
                }
                $scope.lstPatientInvestigation = data;
            }
            resultCaptureAPI.onPatientInvLoad({ visitID: $scope.visitid, gUID: $scope.guid }, onPatientInvLoaded);
        } ],
        templateUrl: '../KernelV2/app/template/directives/orderedInvestigations.html',
        restrict: 'AE',
        scope: {
            lstPatientInvestigation: '@',
            visitid: '=',
            guid: '='
        }
    };
});
