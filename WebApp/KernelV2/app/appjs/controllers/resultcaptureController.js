/// <reference path="../../../../../PlatForm/StyleSheets/dist/bootstrap-3.3.6-dist/js/bootstrap.js" />
'use strict';

angular.module('attuneKernel.controllers')
.controller('resultCaptureFormController', ['$scope', '$rootScope', 'resultCaptureAPI', 'Notification', '$state', 'PageDetails',
function ($scope, $rootScope, resultCaptureAPI, Notification, $state, PageDetails) {

    //Notification.success({ message: 'Saved Successfully', title: '<i><u>Success</u></i>', delay: null });
    //Notification.error({ message: 'Provide Investigation Values', title: '<u><i>Alert !</u></i>', delay: null });
    //Notification.error({ message: 'Error notification', delay: null });
    //Notification.error({ message: 'Error notification 1s', delay: null });
    //Notification.error({ message: 'Error notification (no timeout)', delay: null });
    //Notification.success({ message: 'Success notification 20s', delay: null });
    //Notification.error({ message: '<b>Error</b> <s>notification</s>', title: '<i>Html</i> <u>message</u>', delay: null });
    //Notification.success({ message: 'Success notification<br>Some other <b>content</b><br><a href="https://github.com/alexcrack/angular-ui-notification">This is a link</a><br><img src="https://angularjs.org/img/AngularJS-small.png">', title: 'Html content', delay: null });

    $rootScope.lstQualitative = [];
    $rootScope.ReferenceRangeType;
    $scope.visitId = $state.params.vid;
    $scope.gUID = $state.params.gUID;

    var invIDs = '';
    invIDs = $state.params.Invid;

    var onInvResultsCaptureLoaded = function (data, error) {
        if (error) {
            return false;
        }
        $scope.lstResultsCapture = data;
    };
    var onReferenceRangeTypeLoaded = function (data, error) {
        if (error) {
            return false;
        }
        $rootScope.ReferenceRangeType = data;
    }

    var saveResultCaptureLoaded = function (data, error) {
        if (error) {
            return false;
        }
        Notification.success({ message: 'Saved successfully', title: '<i><u>Success</u></i>' });
        window.location.href = "../Lab/home.aspx";
    }

    resultCaptureAPI.onInvResultsCaptureLoad($scope.visitId, $scope.gUID, invIDs, onInvResultsCaptureLoaded);

    resultCaptureAPI.onReferenceRangeTypeLoad(onReferenceRangeTypeLoaded);

    $scope.setDeptInvStatus = function (obj) {
        angular.forEach(obj.lstUI_Group, function (Value, Key) {
            Value.objInvStatus = obj.objDepInvStatus;
            angular.forEach(Value.lstUI_PatientInvestigation, function (Value, Key) {
                Value.Status = obj.objDepInvStatus;
            });
        });
        angular.forEach(obj.lstUI_PatientInvestigation, function (Value, Key) {
            Value.Status = obj.objDepInvStatus;
        });
    };

    $scope.setGroupInvStatus = function (obj) {
        angular.forEach(obj.lstUI_PatientInvestigation, function (Value, Key) {
            Value.Status = obj.objInvStatus;
        });
    };

    $scope.setInvStatus = function (obj) {
        $scope.objInvStatus = obj;
    };

    $scope.alert = function (obj, type) {
        if (type == "Pattern") {
            Notification.error({ message: obj.PatternName + ' is  not available for the ' + obj.InvestigationName + ' Investigation ', title: '<u><i>Alert !</u></i>', delay: null });
        }
    };

    $scope.saveResultCapture = function () {
        var ResultCapture = {};
        var pageContext = {};

        pageContext.PageID = PageDetails.GetPageID($state.current.url);
        pageContext.ButtonName = "btnSave";
        pageContext.ButtonValue = "Save";
        pageContext.LabNo = $state.params.LNo;
        pageContext.PatientID = $state.params.pid;

        ResultCapture.lstDept = $scope.lstResultsCapture.InvDept;
        ResultCapture.InvQualitativeResult = $rootScope.lstQualitative;
        ResultCapture.PageContext = pageContext;
        resultCaptureAPI.onSaveInvResultsCapture($scope.visitId, $scope.gUID, ResultCapture, saveResultCaptureLoaded);
    };

}]);