'use strict';
angular.module('attuneKernel.services')
.service('resultCaptureAPI', ['DataFactory', function (DataFactory) {
    var resultcaptureAPI = {};
    resultcaptureAPI.getpatientBanner = function (patient, callBack) {
        DataFactory.get('patient', { VisitID: patient.visitID, gUID: patient.gUID }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    resultcaptureAPI.onPatientInvLoad = function (patient, callBack) {
        DataFactory.get('resultCapture', { VisitID: patient.visitID, gUID: patient.gUID }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    resultcaptureAPI.onReferenceRangeTypeLoad = function (callBack) {
        DataFactory.get('ReferenceRangeType', false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    resultcaptureAPI.onInvResultsCaptureLoad = function (visitID, gUID, invIDs, callBack) {
        DataFactory.get('resultCapture', {
            VisitID: visitID,
            gUID: gUID,
            InvIDs: invIDs,
            IsTrustedDetails: 'N',
            Status: 'N'
        }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    resultcaptureAPI.onSaveInvResultsCapture = function (VID, UID, ResultCapture, callBack) {
        DataFactory.post('saveinvestigationvalues',
            { gUID: UID, VisitID: VID },
            ResultCapture
            ).then(function (response) {
                callBack(response.data, null);
            }, function (error) {
                callBack(null, error.data);
            });
    };
    return resultcaptureAPI;
}]);
