'use strict';
angular.module('attuneKernel.services')
.service('masterdataAPI', ['DataFactory', function (DataFactory) {
    var masterdataAPI = {};
    masterdataAPI.geturntype = function (callBack) {
        DataFactory.get('urn', false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    masterdataAPI.checkurn = function (TypeID, URN, callBack) {
        DataFactory.get('checkURN', { UrnTypeId: TypeID, UrnNo: URN }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    masterdataAPI.getpaymentdetails = function (callBack) {
        DataFactory.get('paymentDetails', false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    masterdataAPI.getbankname = function (search, callBack) {
        DataFactory.get('bank', { SearchText: search }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    return masterdataAPI;
}])