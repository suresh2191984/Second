angular.module('attuneKernel.directives')
.directive('bioPattern5Directive', function () {
    return {
        controller: ['$scope', '$rootScope', '$sce', 'resultcaptureRuleEngine', 'resultCaptureAPI', 'Notification',
    function ($scope, $rootScope, $sce, resultcaptureRuleEngine, resultCaptureAPI, Notification) {
        $scope.time = "Select";
        $scope.lstSugar = [];

        $scope.GenerateSugarCalc = function () {
           /*
            if (!angular.isUndefined($scope.NoOfTest) && parseInt($scope.NoOfTest) > 0 && $scope.timeInterval != "" && $scope.timePeriod != "") {
                $scope.lstSugar = [];
                for (var i = 0; i <= parseInt($scope.NoOfTest) ; i++) {
                    $scope.objSugar = {};
                    var timeInterval = parseInt($scope.timeInterval);
                    var time = parseInt($scope.time);
                    var j = i;
                    $scope.objSugar.Time = time;
                    $scope.objSugar.TimeInterval = (timeInterval * j++) / 60 < 60 ? (timeInterval * j++) : (timeInterval * j++) / 60;

                    $scope.objSugar.Timeperiod = $scope.timePeriod

                    $scope.lstSugar.push($scope.objSugar);
                }
                $scope.lstSugar.splice(0, 1);
            }
            else {
                if (!angular.isUndefined($scope.NoOfTest) && parseInt($scope.NoOfTest) > 0) {
                    Notification.error({ message: 'Enter number of test', title: '<i><u>Alert</u></i>', delay: null });
                }
                if ($scope.timeInterval != "") {
                    Notification.error({ message: 'Select Time Interval', title: '<i><u>Alert</u></i>', delay: null });
                }
                if ($scope.timePeriod != "") {
                    Notification.error({ message: 'Select Time Period', title: '<i><u>Alert</u></i>', delay: null });
                }
            }
            */
            var totalMin = parseInt($scope.NoOfTest) * parseInt($scope.timeInterval)
            var h = Math.floor(totalMin / 60);
            var m = totalMin % 60;
            var sTime = parseInt($scope.time) + ":00"; var eTime=h+":"+m;
           
            var time1 = sTime.split(':'), time2 = eTime.split(':');
            var hours1 = parseInt(time1[0], 10),
                hours2 = parseInt(time2[0], 10),
                mins1 = parseInt(time1[1], 10),
                mins2 = parseInt(time2[1], 10);
            var hours = hours2 - hours1, mins = 0;

            // get hours
            if (hours < 0) hours = 24 + hours;

            // get minutes
            if (mins2 >= mins1) {
                mins = mins2 - mins1;
            }
            else {
                mins = (mins2 + 60) - mins1;
                hours--;
            }

            // convert to fraction of 60
            mins = mins / 60;

            hours += mins;
            hours = hours.toFixed(2);           
           
        };

    }],
        templateUrl: '../KernelV2/app/template/directives/bioPattern5.html',
        restrict: 'AE',
        scope: {
            objInvestigations: '=objinvestigations'
        }
    };
});
