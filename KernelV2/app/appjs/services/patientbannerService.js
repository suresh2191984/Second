'use strict';
angular.module('attuneKernel.services')
.service('patientBannerAPI', ['DataFactory', function (DataFactory) {
    var patientBannerAPI = {};
    patientBannerAPI.getpatientBanner = function (patient, callBack) {
        DataFactory.get('patient', { visitID: patient.visitID, gUID: patient.gUID }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    patientBannerAPI.savePatientHistory = function (patient, callBack) {
        DataFactory.post('patient', 0, patient, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    return patientBannerAPI;
}]);
