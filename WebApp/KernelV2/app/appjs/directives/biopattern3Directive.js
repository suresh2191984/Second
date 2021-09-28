angular.module('attuneKernel.directives')
.directive('bioPattern3Directive', function () {
    return {
        controller: ['$scope', '$rootScope', '$sce', 'resultcaptureRuleEngine', 'resultCaptureAPI', 'Notification',
    function ($scope, $rootScope, $sce, resultcaptureRuleEngine, resultCaptureAPI, Notification) {
        if ($scope.objInvestigations.Value != "") {
            $scope.objInvestigations.Status = "Completed";
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
                    //console.log(err);
                }
            }
        };


        $scope.objInvestigations.Reason = $scope.objInvestigations.Reason == "" ? null : $scope.objInvestigations.Reason;
       
        $scope.addQualitativeResult = function (obj) {
            if (angular.isObject(obj)) {
                $scope.objQualitative = {};
                $scope.objQualitative.Value = obj.QualitativeResultName;
                
                var length = $.grep($scope.objInvestigations.InvestigationValues, function (n, i) { return n.Value == obj.QualitativeResultName; }).length;
                if (length == 0) {
                    $scope.objInvestigations.InvestigationValues.push($scope.objQualitative);

                    $scope.Qualitative = {};
                    $scope.Qualitative.ResultID = obj.QualitativeResultId;
                    $scope.Qualitative.InvestigationID = $scope.objInvestigations.InvestigationID;
                    $scope.Qualitative.Name = "Source";
                    $scope.Qualitative.Value = obj.QualitativeResultName;
                    $rootScope.lstQualitative.push($scope.Qualitative);
                }
                else {
                    Notification.error({ message: 'Source name already added against ' + objInvestigations.InvestigationName + ' Investigation ', title: '<u><i>Alert !</u></i>', delay: 3000 });
                }
                $scope.QualitativeResultName = "Select";
            }
        };

        $scope.alert = function (obj, type) {
            if (type == "Status") {
                Notification.error({ message: 'Pending Status not mapped for' + obj.InvestigationName + ' Investigation ', title: '<u><i>Alert !</u></i>', delay: 3000 });
                $scope.objInvestigations.Status = "Select";
            }
        };
    }],
        templateUrl: '../KernelV2/app/template/directives/bioPattern3.html',
        restrict: 'AE',
        scope: {
            objInvestigations: '=objinvestigations',
            lstQualitativeResult: '=lstqualitativeresult',            
            lstReasons: '=lstreasons'
        }
    };
});
