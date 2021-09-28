angular.module('attuneKernel.directives')
.directive('bioPattern1Directive', function () {
    return {
        controller: ['$scope', '$rootScope', '$sce', 'resultcaptureRuleEngine', 'resultCaptureAPI', 'Notification',
        function ($scope, $rootScope, $sce, resultcaptureRuleEngine, resultCaptureAPI, Notification) {
            $scope.IsAbnormal = 'N';
            $scope.objInvestigations.Reason = $scope.objInvestigations.Reason == "" ? null : $scope.objInvestigations.Reason;
            var length = $.grep($scope.objInvestigations.InvStatus, function (n, i) { return n.DisplayText == "Pending"; }).length;
            if (length > 0) {
                //Notification.error({ message: 'Pending Status not mapped for ' + obj.InvestigationName + ' Investigation ', title: '<u><i>Alert !</u></i>', delay: null });
                $scope.objInvestigations.Status = "Pending";
            }

            $scope.changeInvValues = function () {
                $scope.ValColor = 'NormalRange';                                               
                if ($scope.objInvestigations.Value) {
                    $scope.IsAbnormal = resultcaptureRuleEngine.valuationRule($rootScope.ReferenceRangeType, $scope.objInvestigations.IOMReferenceRange == "" ? $scope.objInvestigations.ReferenceRange : $scope.objInvestigations.IOMReferenceRange, $rootScope.pGender, $rootScope.ageInDays, $scope.objInvestigations.Value);
                    $scope.objInvestigations.IsAbnormal = angular.copy($scope.IsAbnormal)
                    $scope.ValColor = resultcaptureRuleEngine.validationColor($scope.IsAbnormal)
                    $scope.objInvestigations.Status = "Completed";
                }
                if ($scope.objInvestigations.ValidationText) {
                    try {
                        eval($scope.objInvestigations.ValidationText);
                    }
                    catch (err) {                        
                    }
                }
            };

            $scope.ControlId = $scope.objInvestigations.InvestigationID + '_' + $scope.objInvestigations.RowNumber;

            $scope.changeInvValues($scope.objInvestigations);
            
            $scope.changeINVStatusColor = function () {
                if ($scope.objInvestigations.Value) {
                    $scope.objInvestigations.IsAbnormal = resultcaptureRuleEngine.validationRange($scope.objInvestigations.IsAbnormal);
                    $scope.ValColor = resultcaptureRuleEngine.validationColor($scope.objInvestigations.IsAbnormal);
                    $scope.objInvestigations.ManualAbnormal = 'Y';
                    if ($scope.IsAbnormal == $scope.objInvestigations.IsAbnormal) {
                        $scope.objInvestigations.ManualAbnormal = 'N';
                    }
                }
            };
        }],
        templateUrl: '../KernelV2/app/template/directives/bioPattern1.html',
        restrict: 'E',
        scope: {
            objInvestigations: '=objinvestigations',
            lstReasons: '=lstreasons'
        }
    };
});
