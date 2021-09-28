'use strict';
angular.module('attuneKernel.services')
.service('billingAPI', ['DataFactory', function (DataFactory) {
    var billingAPI = {};

    billingAPI.getQuickBillingDetails = function (callBack) {
        DataFactory.get('patientbilling', false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    billingAPI.getHealthPackageDataSearch = function (groupName, packageID, callBack) {
        DataFactory.get('healthpackagedatasearch', { GroupName: groupName, PackageID: packageID }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    billingAPI.DiscountAuthorizedBy = function (authBy, callBack) {
        DataFactory.get('discoiuntapprover', { Name: authBy, Type: "DisApprove" }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        })
    };

    billingAPI.getClientDetails = function (callBack) {
        DataFactory.get('clientmetamata', false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    billingAPI.getreferingphysician = function (prefix, id, callBack) {
        DataFactory.get('referringphysician', { pClientId: id, pPrefixText: prefix }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    billingAPI.getPatientBilling = function (prefix, callBack) {
        DataFactory.get('patientbilling', { PrefixText: prefix }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    billingAPI.getpatientdetailsbilling = function (id, callBack) {
        DataFactory.get('patientbilling', { PatientID: id }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    billingAPI.getpatientadvancesearch = function (FirstName, MiddleName, LastName, PatientNo, PhoneNo, BookingNo, ClientID, ClientCode, callBack) {
        DataFactory.get('patientadvancesearch', { FirstName: FirstName, MiddleName: MiddleName, LastName: LastName, PatientNo: PatientNo, PhoneNo: PhoneNo, BookingNo: BookingNo, ClientID: ClientID, ClientCode: ClientCode }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    billingAPI.GetBillingItemsDetails = function (feeid, feetype, client_id, visit_id, collected, collectedDatetime, callBack) {
        DataFactory.get('billingitems', { FeeID: feeid, FeeType: feetype, ClientID: client_id, VisitID: visit_id, IsCollected: collected, CollectedDatetime: collectedDatetime }, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    billingAPI.getClientAttributesFieldDetails = function (ReferenceID, ReferenceType, callBack) {
        DataFactory.get('clientattributesfielddetails', { ReferenceID: ReferenceID, ReferenceType: ReferenceType}, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    billingAPI.GenerateBill = function (file,billDetails, callBack) {
        //DataFactory.post('patientbillingitemsdetails', 0, billDetails).then(function (response) {
        //    callBack(response.data, null);
        //}, function (error) {
        //    callBack(null, error.data);
        //})

        DataFactory.upload('patientbillingitemsdetails', file,  JSON.stringify(billDetails), false).success(function (data) {
            callBack(data, null);
        }).error(function (error) {
            callBack(null, error);
        });
    }

    /*
   billingAPI.getReferinghospital = function (prefix,id,callBack) {        
       DataFactory.get('referringhospital',{pClientId:id,pPrefixText:prefix}, false).then(function (response) {
           callBack(response.data, null);
       }, function (error) {
           callBack(null, error.data);
       });
   };
   
     billingAPI.getphlebotomist= function (search,callBack) {        
        DataFactory.get('phlebotomist',{searchText:search}, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };
    
    billingAPI.getBillingItems = function (description,feetype,gender,client_id,rate_id,mapped,callBack) {       
         DataFactory.get('billingitems',{Description:description,FeeType:feetype,Gender:gender,ClientID:client_id,RateID:rate_id,IsMapped:mapped}, false).then(function (response) {
             callBack(response.data, null);
         }, function (error) {
             callBack(null, error.data);
         });
     };
     */
    return billingAPI;
}])
.service('fileUploadService', function ($http, $q) {

    this.uploadFileToUrl = function (file, uploadUrl) {
        //FormData, object of key/value pair for form fields and values
        var fileFormData = new FormData();
        fileFormData.append('file', file);

        var deffered = $q.defer();
        $http.post(uploadUrl, fileFormData, {
            transformRequest: angular.identity,
            headers: { 'Content-Type': undefined }

        }).success(function (response) {
            deffered.resolve(response);

        }).error(function (response) {
            deffered.reject(response);
        });

        return deffered.promise;
    }
});
/*
.service('billingAPI', ['DataFactory', function (DataFactory) {
    var billingAPI = {};

    metaDataAPI.getcountry = function (callBack) {
        DataFactory.get('country',{searchText:"s"}, false).then(function (response) {
            callBack(response.data, null);
        }, function (error) {
            callBack(null, error.data);
        });
    };

    return billingAPI;
}]);
*/


