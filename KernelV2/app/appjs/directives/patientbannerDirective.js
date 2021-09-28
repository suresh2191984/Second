angular.module('attuneKernel.directives')
.directive('patientDetailsDirective', function () {
    return {
        controller: ['patientBannerAPI', '$scope', '$rootScope', 'Notification', function (patientBannerAPI, $scope, $rootScope, Notification) {
            $scope.lstPatientHistory = [];
            var patientBannerLoaded = function (data, error) {
                $scope.objPatient = data[0];
                $scope.lstPatientHistory = $.grep(data, function (n, i) {
                    return n.PatientHistory != "" && n.RegistrationRemarks != "";
                });
                $rootScope.pGender = $scope.objPatient.Sex == "M" ? "Male" : "Female";
                $rootScope.ageInDays = $scope.objPatient.AgeDays;
            }
            patientBannerAPI.getpatientBanner({ visitID: $scope.visitid, gUID: $scope.guid }, patientBannerLoaded);

            var savePatientHistoryLoaded = function (data, error) {
                if (data == null || data == "") {
                    alert(error);
                    return false;
                }
                else {
                    Notification.success({ message: 'Saved Successfully', title: '<i><u>Message</u></i>', delay: null });
                    patientBannerAPI.getpatientBanner({ visitID: $scope.visitid, gUID: $scope.guid }, patientBannerLoaded);
                }
            }

            $scope.savePatientHistory = function () {
                if ($scope.objPatient.PatientHistory != "" && $scope.objPatient.RegistrationRemarks != "") {
                    $scope.objPatientHistory = {};
                    $scope.objPatientHistory.PatientVisitId = $scope.objPatient.PatientVisitId;
                    $scope.objPatientHistory.PatientHistory = $scope.objPatient.PatientHistory;
                    $scope.objPatientHistory.RegistrationRemarks = $scope.objPatient.RegistrationRemarks;
                    $scope.objPatientHistory.ReferingPhysicianID = $scope.objPatient.ReferingPhysicianID;
                    $scope.objPatientHistory.ReferingPhysicianName = $scope.objPatient.ReferingPhysicianName;
                    $scope.objPatientHistory.HospitalID = $scope.objPatient.HospitalID;
                    $scope.objPatientHistory.HospitalName = $scope.objPatient.HospitalName;
                    patientBannerAPI.savePatientHistory($scope.objPatientHistory, savePatientHistoryLoaded);
                    $scope.lstPV = { lstPatientHistory: $scope.objPatient };
                    //patientBannerAPI.savePatientHistory($scope.lstPV, savePatientHistoryLoaded);
                }
                else {
                    if ($scope.objPatient.PatientHistory == "") {
                        Notification.error({ message: 'Provide Patient History', title: '<i><u> Alert</u></i>', delay: null });
                    }
                    if ($scope.objPatient.RegistrationRemarks == "") {
                        Notification.error({ message: 'Provide Patient Remarks', title: '<i><u>Alert </u></i>', delay: null });
                    }
                }
            };

        }],

        templateUrl: '../KernelV2/app/template/directives/patientDetails.html',
        restrict: 'AE',
        scope: {
            objPatient: '@',
            visitid: '=',
            guid: '='
        }
    };
});
