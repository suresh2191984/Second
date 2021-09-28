'use strict';
angular.module('attuneKernel.services')
.service('metaDataAPI', ['DataFactory', function (DataFactory) {
    var metaDataAPI = {};
    metaDataAPI.getBillingMetaData = function (callBack) {
        DataFactory.get('billingmetadata', false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    metaDataAPI.getcountry = function (search, callBack) {
        DataFactory.get('country', { searchText: search }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    metaDataAPI.getstate = function (search, id, callBack) {
        DataFactory.get('state', { CountryId: id, searchText: search }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    return metaDataAPI;
}])