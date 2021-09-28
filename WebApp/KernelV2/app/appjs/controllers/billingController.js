

angular.module('attuneKernel.controllers')
.controller('billingFormController', ['$uibModal', '$scope', '$rootScope', '$filter', 'DataFactory', 'billingAPI', 'metaDataAPI',
    'masterdataAPI', '$state', 'Notification', '$window', '$interval', 'fileUploadService', '$q',
function ($uibModal, $scope, $rootScope, $filter, DataFactory, billingAPI, metaDataAPI, masterdataAPI, $state, Notification, $window, $interval, fileUploadService, $q) {

    //--------------------------------------------------------------Declarations----------------------------------------------------//
    $scope.billContents = [];
    $scope.checkboxModel = [];
    $scope.selectedItems = [];
    $scope.billdata = [];
    $scope.lstDocument = [];
    $scope.files = [];
    $scope.tempCity = "";

    $scope.billingData = {};
    $scope.dirOptions = {};

    $scope.GrossBillValue = 0;
    $scope.DiscountPercentage = 0;
    $scope.TotalItemDiscount = 0;
    $scope.TaxAmount = 0;
    $scope.TotalAmount = 0;
    $scope.NetAmount = 0;
    $scope.RoundOffAmount = 0;
    $scope.ItemDiscount = 0;
    $scope.BillLevelDiscount = 0;

    $scope.disableGender = false;

    $scope.dynamicPopover = { templateUrl: 'advancedSearch.html' };
    $scope.PreviousVisitPopover = { templateUrl: 'previousVisitPopover.html' }
    $scope.allOption = "All";

    var modelScope = { "checkboxModel": "checkboxModel", "selectedItems": "selectedItems" };

    var that = this;

    // date and time picker
    this.picker3 = {
        date: new Date()
    };

    this.openCalendar = function (e, picker) {
        that[picker].open = true;
    };
    //--------------------------------------------------------------Declarations----------------------------------------------------//

    //--------------------------------------------------------------Callback Functions----------------------------------------------------//

    var billingFormReset = function () {
        if ($scope.billingSearchFrom) {
            $scope.billingSearchFrom.$setUntouched();
            $scope.billingSearchFrom.$setPristine();
        }

        if ($scope.billingItemForm) {
            $scope.billingItemForm.$setUntouched();
            $scope.billingItemForm.$setPristine();
        }
    };

    $interval(billingFormReset, 4000, false);

    var getQuickBillDetailsLoaded = function (data, error) {
        if (error) {
            return false;
        }
        $scope.billingData = data;
        $scope.billingData.ReportDeliveryMode = $scope.billingData.ReportDeliveryMode.length == 0 ? "" : $scope.billingData.ReportDeliveryMode;
        metaDataAPI.getBillingMetaData(getBillingMetaDataLoaded);
        $scope.billingData.Patient = {};
        $scope.billingData.Patient.AgeTypeCode = $.grep($scope.billingData.AgeType, function (n, i) { return (n.Code == "Year(s)") })[0].Code;
    }

    var getBillingMetaDataLoaded = function (data, error) {
        if (error) {
            return false;
        }
        $scope.billingData.Discount = data.Discount;
        $scope.billingData.DiscountReason = data.DiscountReason;
        $scope.billingData.DiscountType = data.DiscountType;
        $scope.billingData.Tax = data.Tax;
    }

    var generateBillLoaded = function (data, error) {
        if (error) {
            return false;
        }
        if (data != null) {
            $scope.billPrint(data);
            $scope.reset();
        }
    }

    var getBillingDetailsLoaded = function (data, error) {
        if (error) {
            return false;
        }
        if (data.Patient) {
            data.Patient.Salutation = data.Patient.Salutation;
            //data.Patient.FirstName = data.Patient.PatientName;
            data.Patient.Gender = data.Patient.Gender;

            $scope.billingData.Patient = data.Patient;
            if (moment(data.Patient.DOB).format("DD/MM/YYYY") != "31/12/9999") {
                $scope.billingData.Patient.DOB = new Date(data.Patient.DOB);
            }
            else {
                $scope.billingData.Patient.DOB = "";
            }
            $scope.billingData.Patient.DispatchType = [];
            $scope.billingData.Patient.DispatchMode = [];
            $scope.PreviousVisit = data.PreviousVisitBilling;
            $scope.billingData.Patient.Salutation = $.grep($scope.billingData.Titles, function (n, i) { return (n.TitleID == data.Patient.Salutation.TitleID) })[0];
            $scope.billingData.Patient.Gender = $.grep($scope.billingData.Gender, function (n, i) { return (n.Code == data.Patient.Gender.Code) })[0];
            $scope.billingData.URN = data.URN;
            $scope.billingData.Country = data.Country;
            $scope.billingData.State = data.State;
            $scope.tempCity = data.Patient.City;

            $scope.billingData.Patient.City = {};
            $scope.billingData.Patient.City.CityName = $scope.tempCity;

            $scope.clientData.ExtrenalPatientNo = data.Patient.ExternalPatientNumber;
            $scope.Pincode = data.Patient.PostalCode;
            $scope.billingData.DispatchType = data.DispatchType;
            $scope.billingData.DispatchMode = data.DispatchMode;
            $scope.clientData.Client = data.ClientReference;
            $scope.clientData.TPA = data.ClientReference;
        }
    }

    var advanceSearchLoaded = function (data, error) {
        if (error) {
            return false;
        }
        $scope.advSearch = data;
    }

    var getBillingItemsDetailsLoaded = function (PatientDueChart, error) {
        if (error) {
            return false;
        }
        if (PatientDueChart.Amount <= 0)
        {
            Notification.error({ message: 'Item amount is zero.Kindly map rate for the Item', title: 'Alert' });
            return false;

        }
         
        var Discount;
        var IS_JSON = true;
        try {
            Discount = JSON.parse($scope.ItemLevelDiscount).Discount;
            PatientDueChart.ItemDiscount = JSON.parse($scope.ItemLevelDiscount);
            $scope.ItemLevelDiscount = JSON.parse($scope.ItemLevelDiscount).Discount;
        }
        catch (err) {
            IS_JSON = false;
        }
        if (IS_JSON) {
            PatientDueChart.DiscountPercentage = Discount;
            PatientDueChart.DiscountAmount = ((PatientDueChart.Amount * Discount) / 100);
        }
        else if ($scope.ItemLevelDiscount != null && angular.lowercase($scope.ItemLevelDiscount) == 'value' && $scope.ItemDiscount != "") {
            $scope.ItemLevelDiscount = "";
            if (PatientDueChart.Amount < $scope.ItemDiscount) {
                Notification.error({ message: 'Provide Discount value Less than ' + $scope.billingitem.Descrip + ' Amount : ' + PatientDueChart.Amount, title: 'Alert' });
                return false;
            }
            PatientDueChart.DiscountAmount = parseInt($scope.ItemDiscount);
            PatientDueChart.ItemDiscount = {};
            PatientDueChart.ItemDiscount.DiscountID = 0;
            PatientDueChart.ItemDiscount.DiscountName = 0;
            PatientDueChart.ItemDiscount.Discount = $scope.ItemDiscount;
            PatientDueChart.ItemDiscount.Code = "";
            PatientDueChart.ItemDiscount.CeilingValue = 0;
            PatientDueChart.ItemDiscount.DiscountPercentage = 0.00;
            PatientDueChart.ItemDiscount.DiscountType = 0;

        }
        $scope.resetBillingDetails();
        PatientDueChart.DiscountAmount = PatientDueChart.DiscountAmount ? PatientDueChart.DiscountAmount : 0;
        PatientDueChart.NetAmount = PatientDueChart.Amount - PatientDueChart.DiscountAmount;
        PatientDueChart.unit = 1.00;
        
        angular.merge(PatientDueChart, $scope.billingitem);
        if ($scope.billingData.Patient.PatientStatus == "ST") {
            PatientDueChart.IsStat = "Y";
        }
        else {
            PatientDueChart.IsStat = "N";
        }
        $scope.billdata.push(PatientDueChart);
        $.grep($scope.billdata, function (n, i) {
            if (!angular.isUndefined(n.FeeDescription) && n.FeeDescription != "") {
                return (n.Descrip = n.FeeDescription)
            }
        });
        $scope.CalTotalAmount();
        $scope.billingitem = "";
        $scope.ItemLevelDiscount = "";
        $scope.ItemDiscount = "";
        $scope.billingitemSelected = {};
        $scope.billingItemForm.$setUntouched();
        $scope.billingItemForm.$setPristine();
    }
    var getHealthPackageDataSearchLoaded = function (data, error) {
        if (error) {
            return false;
        }
        $scope.billContents = [];
        $scope.billContents = data;
    }
    //--------------------------------------------------------------Callback Functions----------------------------------------------------//

    //--------------------------------------------------------------Page Load Functions----------------------------------------------------//
    billingAPI.getQuickBillingDetails(getQuickBillDetailsLoaded);
    //--------------------------------------------------------------Page Load Functions----------------------------------------------------//

    $scope.salutation = function (titler) {
        $scope.billingData.Patient.Salutation = titler;
        if (titler.TitleID == 4 || titler.TitleID == 7 || titler.TitleID == 8) {
            $scope.billingData.Patient.Gender = $.grep($scope.billingData.Gender, function (n, i) { return (n.Code == 'M') })[0];
            $scope.disableGender = true;
        } else if (titler.TitleID == 1 || titler.TitleID == 2 || titler.TitleID == 3 || titler.TitleID == 15 || titler.TitleID == 22) {
            $scope.billingData.Patient.Gender = $.grep($scope.billingData.Gender, function (n, i) { return (n.Code == 'F') })[0];
            $scope.disableGender = true;
        }
        else if (titler.TitleID == 17) {
            $scope.billingData.Patient.Gender = $.grep($scope.billingData.Gender, function (n, i) { return (n.Code == 'V') })[0];
            $scope.disableGender = true;
        }
        else {
            $scope.billingData.Patient.Gender = undefined;
            $scope.disableGender = false;
        }
        $rootScope.billingDetailsClear();
    };
    $scope.gender = function (gender) {
        //if (!angular.isUndefined($scope.billingData.Patient.Salutation) && Object.keys($scope.billingData.Patient.Salutation).length == 0) {
        if (gender.Code == "M") {
            $scope.billingData.Patient.Salutation = $.grep($scope.billingData.Titles, function (n, i) { return (n.TitleID == 7) })[0];
            /* if ($scope.billingData.Patient.Salutation != 7 || $scope.billingData.Patient.Salutation != 4 || $scope.billingData.Patient.Salutation != 8) {
                 alert("Gender and Salutation Miss Match");
                 Notification.error({ message: 'Gender and Salutation Miss Match', title: 'Alert' });
             }*/
        } else if (gender.Code == "F") {
            $scope.billingData.Patient.Salutation = $.grep($scope.billingData.Titles, function (n, i) { return (n.TitleID == 3) })[0];
            /* if ($scope.billingData.Patient.Salutation != 1 || $scope.billingData.Patient.Salutation != 2 || $scope.billingData.Patient.Salutation != 3 || $scope.billingData.Patient.Salutation != 22) {
                 alert("Gender and Salutation Miss Match");
                 Notification.error({ message: 'Gender and Salutation Miss Match', title: 'Alert' });
             }*/
        }
        else if (gender.Code == "V") {
            $scope.billingData.Patient.Salutation = $.grep($scope.billingData.Titles, function (n, i) { return (n.TitleID == 17) })[0];
        }
        $rootScope.billingDetailsClear();
        // }
    };
    $scope.getcountry = function (country) {
        return DataFactory.get('country', { searchText: country })
            .then(function (response) {
                return response.data.map(function (item) {
                    return item;
                });
            });
    };
    $scope.getstate = function (state) {
        return DataFactory.get('state', { CountryId: $scope.billingData.Country.CountryID, searchText: state })
            .then(function (response) {
                return response.data.map(function (item) {
                    return item;
                });
            });
    };
    $scope.getPinCode = function (pincode) {
        return DataFactory.get('pincode', { Pincode: parseInt(pincode) })
            .then(function (response) {
                return response.data.map(function (item) {
                    return item;
                });
            });
    };
    $scope.setPincode = function (value) {
        $scope.billingData.Country = {};
        $scope.billingData.Country.CountryCode = value.CountryCode;
        $scope.billingData.Country.CountryID = value.CountryID;
        $scope.billingData.Country.CountryName = value.CountryName;
        $scope.billingData.Country.ISDCode = value.ISDCode;
        $scope.billingData.Country.Nationality = value.Nationality;
        $scope.billingData.Country.NationalityID = value.NationalityID;
        $scope.billingData.Country.PhoneNo_Length = value.PhoneNo_Length;

        $scope.billingData.State = {};
        $scope.billingData.State.CountryID = value.CountryID;
        $scope.billingData.State.ISDCode = value.ISDCode;
        $scope.billingData.State.IsDefault = value.IsDefault;
        $scope.billingData.State.StateCode = value.StateCode;
        $scope.billingData.State.StateID = value.StateID;
        $scope.billingData.State.StateName = value.StateName;

        if (angular.isUndefined($scope.billingData.Patient.City)) {
            $scope.billingData.Patient.City = {};
        }
        $scope.billingData.Patient.City.CityId = value.CityID;
        $scope.billingData.Patient.City.CityName = value.CityName;

        $scope.billingData.Patient.Add1 = "";
        $scope.billingData.Patient.Add1 = value.Locality;
    };
    $scope.setValue = function (type, value) {
        if (type == "DispatchType") {
            if (value == "" || angular.isUndefined(value)) {
                $.grep($scope.billingData.DispatchType, function (n, i) { return (n.Code == "Home") })[0].IsChecked = false;
            }
            else {
                $.grep($scope.billingData.DispatchType, function (n, i) { return (n.Code == "Home") })[0].IsChecked = true;
            }
        }
        if (type != "DispatchType") {
            if (value != "" && value != undefined) {
                $.grep($scope.billingData.DispatchMode, function (n, i) { return (n.ActionType == type) })[0].IsChecked = true;
            }
            else {
                $.grep($scope.billingData.DispatchMode, function (n, i) { return (n.ActionType == type) })[0].IsChecked = false;
            }
        }
    };
    $scope.checkValue = function (type, obj) {
        if (type == "DispatchMode") {
            if (!angular.isUndefined($scope.billingData.Patient)) {
                if (obj.ActionType == "Sms" && angular.isUndefined($scope.billingData.Patient.MobileNumber)) {
                    Notification.error({ message: 'Provide mobile number for Dispatch Mode by sms ', title: '<i><u>Alert</u></i>' });
                    obj.IsChecked = false;
                }
                else if (obj.ActionType == "Sms" && $scope.billingData.Patient.MobileNumber == "") {
                    Notification.error({ message: 'Provide mobile number for Dispatch Mode by sms ', title: '<i><u>Alert</u></i>' });
                    obj.IsChecked = false;
                }
                else if (obj.ActionType == "Email" && angular.isUndefined($scope.billingData.Patient.EMail)) {
                    Notification.error({ message: 'Provide EmailID for Dispatch Mode by Email ', title: '<i><u>Alert</u></i>' });
                    obj.IsChecked = false;
                }
                else if (obj.ActionType == "Email" && ($scope.billingData.Patient.EMail == "")) {
                    Notification.error({ message: 'Provide EmailID for Dispatch Mode by Email ', title: '<i><u>Alert</u></i>' });
                    obj.IsChecked = false;
                }
            }
            else {
                if (obj.ActionType == "Sms") {
                    Notification.error({ message: 'Provide mobile number for Dispatch Mode by sms ', title: '<i><u>Alert</u></i>' });
                    obj.IsChecked = false;
                }
                else if (obj.ActionType == "Email") {
                    Notification.error({ message: 'Provide EmailID for Dispatch Mode by Email ', title: '<i><u>Alert</u></i>' });
                    obj.IsChecked = false;
                }
            }
        }
        else if (type == "DispatchType") {
            if (!angular.isUndefined($scope.billingData.Patient)) {
                if (obj.DisplayText == "HomeDelivery" && angular.isUndefined($scope.billingData.Patient.Add1)) {
                    Notification.error({ message: 'Provide address for Dispatch Type by Home Delivery ', title: '<i><u>Alert</u></i>' });
                    obj.IsChecked = false;
                }
                else if (obj.DisplayText == "HomeDelivery" && $scope.billingData.Patient.Add1 == "") {
                    Notification.error({ message: 'Provide address for Dispatch Type by Home Delivery ', title: '<i><u>Alert</u></i>' });
                    obj.IsChecked = false;
                }
            }
            else {
                Notification.error({ message: 'Provide address for Dispatch Type by Home Delivery ', title: '<i><u>Alert</u></i>' });
                obj.IsChecked = false;
            }
        }
    };
    $scope.patientbilling = function (PatientName) {
        return DataFactory.get('patientbilling', { PrefixText: PatientName })
            .then(function (response) {
                return response.data.map(function (item) {
                    return item;
                });
            });
    };
    $scope.patientSearchSelect = function ($item) {
        $scope.PatientID = $item.PatientID;
        $scope.GetBillingItemsDetails();
    };
    $scope.AdvanceSearch = function (FirstName, MiddleName, LastName, PatientNo, PhoneNo, BookingNo, ClientID, ClientCode) {
            
        FirstName = FirstName ? FirstName : "";
        MiddleName = MiddleName ? MiddleName : "";
        LastName = LastName ? LastName : "";
        PatientNo = PatientNo ? PatientNo : "";
        PhoneNo = PhoneNo ? PhoneNo : "";
        ClientID = ClientID ? ClientID : 0;
        ClientCode = ClientCode ? ClientCode : "";
        BookingNo = BookingNo ? BookingNo : "";

        //if (FirstName == undefined) FirstName = ""; if (MiddleName == undefined) MiddleName = "";
        //if (LastName == undefined) LastName = ""; if (PatientNo == undefined) PatientNo = ""; if (PhoneNo == undefined) PhoneNo = "";
        //if (BookingNo == undefined) BookingNo = ""; if (ClientID == undefined) ClientID = 0; if (ClientCode == undefined) ClientCode = "";

        if (FirstName || MiddleName || LastName || PatientNo || PhoneNo || BookingNo || ClientID || ClientCode) {
            billingAPI.getpatientadvancesearch(FirstName, MiddleName, LastName, PatientNo, PhoneNo, BookingNo, ClientID, ClientCode, advanceSearchLoaded);
        }
        else {
            Notification.error({ message: 'Provide any one search criteria ', title: '<i><u>Alert</u></i>' });
        }
    };
    $scope.GetBillingItemsDetails = function (PID) {
        if (!angular.isUndefined(PID) && PID != "") {
            $scope.PatientID = PID;
        }
        if ($scope.PatientID) {
            $scope.isOpen = false;
            $scope.PreviousVisitopen = true;

            billingAPI.getpatientdetailsbilling($scope.PatientID, getBillingDetailsLoaded);
        }
        else {
            Notification.error({ message: 'Provide any search criteria ', title: '<i><u>Alert</u></i>' });
        }
    };
    $scope.billingitems = function (billingitem, Gender, objClient) {
        if (objClient.TPA == undefined) {
            objClient.TPA = objClient.Client;
        }
        else {
            objClient.Client = objClient.TPA;
        }
        if (!angular.isUndefined(billingitem) && !angular.isUndefined(Gender) && !angular.isUndefined(objClient.Client.ClientID)) {
            return DataFactory.get('billingitems', { Description: billingitem, FeeType: "INV", Gender: Gender, ClientID: objClient.Client.ClientID, RateID: objClient.Client.RateID, IsMapped: "N" }, false).then(function (response) {
                return response.data.map(function (item) {
                    return item;
                });
            });
        }
        else {
            if (angular.isUndefined(Gender)) {
                Notification.error({ message: 'Provide patient details', title: '<i><u>Alert</u></i>'});
            }
            if (angular.isUndefined(objClient.Client.ClientID)) {
                Notification.error({ message: 'Client details missing', title: '<i><u>Alert</u></i>' });
            }
        }
    };
    $scope.billingitemSelect = function (item, data) {
        $scope.billingitem = item;
        $scope.billingitemSelected = item;
        $scope.FeeID = item.ID;
        $scope.FeeType = item.FeeType;
        $scope.ClientID = data.ClientID;
        $scope.VisitID = "0";
        $scope.IsCollected = "N";
        $scope.CollectedDatetime = "12/12/1900";
    };

    var chBillingItemsDuplicate = function () {
        var isBool = false;
        if ($scope.billdata) {
            angular.forEach($scope.billdata, function (itm, index) {
                if (itm.ID == $scope.billingitem.ID && itm.FeeType == $scope.billingitem.FeeType) {
                    isBool = true;
                }
            });
        }
        return isBool;
    }

    $scope.addBillingitem = function () {
        var isform = false;
        angular.forEach($scope.billingItemForm.$error, function (items) {
            angular.forEach(items, function (item) {
                if (item.$touched !== undefined && item.$touched === false) {
                    item.$touched = true;
                    isform = true
                }

            });
        });
        if (isform) {
            return;
        }

        if (chBillingItemsDuplicate()) {
            Notification.error({ message: 'Item Already Exists !', title: 'Alert' });
            return false;
        }

        if ($scope.billingitemSelected) {
            billingAPI.GetBillingItemsDetails($scope.billingitemSelected.ID, $scope.billingitemSelected.FeeType, $scope.ClientID, $scope.VisitID, $scope.IsCollected, $scope.CollectedDatetime, getBillingItemsDetailsLoaded);
        }
         
    };
    $scope.addPrevioustoBillingitem = function () {
        $scope.lstPreVisit = $.grep($scope.PreviousVisit, function (n, i) { return n.Checked == true });
        $scope.all = false;
        if ($scope.lstPreVisit.length > 0) {
            if ($scope.clientData.TPA == undefined) {
                $scope.clientData.TPA = $scope.clientData.Client;
            }
            else {
                $scope.clientData.Client = $scope.clientData.TPA;
            }
            $scope.lstPreVisit.forEach(function (obj, i) {
                var getBillingItemsDetailsLoad = function (PatientDueChart, error) {
                    if (error) {
                        return false;
                    }
                    $scope.lstPreVisit[i].Checked = false;
                    $scope.billingitemSelect($scope.lstPreVisit[i], $scope.clientData.Client)
                    if ($.grep($scope.billdata, function (n, i) { return n.TestCode == $scope.billingitem.TestCode; }).length > 0) {
                        Notification.error({ message: 'Item Already Exists !', title: 'Alert' });
                        return false;
                    }
                    var Discount;
                    var IS_JSON = true;
                    try {
                        Discount = JSON.parse($scope.ItemLevelDiscount).Discount;
                        PatientDueChart.ItemDiscount = JSON.parse($scope.ItemLevelDiscount);
                        $scope.ItemLevelDiscount = JSON.parse($scope.ItemLevelDiscount).Discount;
                    }
                    catch (err) {
                        IS_JSON = false;
                    }
                    if (IS_JSON) {
                        PatientDueChart.DiscountPercentage = Discount;
                        PatientDueChart.DiscountAmount = ((PatientDueChart.Amount * Discount) / 100);
                    }
                    else if ($scope.ItemLevelDiscount != null && angular.lowercase($scope.ItemLevelDiscount) == 'value' && $scope.ItemDiscount != "") {
                        $scope.ItemLevelDiscount = "";
                        if (PatientDueChart.Amount < $scope.ItemDiscount) {
                            Notification.error({ message: 'Provide Discount value Less than ' + $scope.billingitem.Descrip + ' Amount : ' + PatientDueChart.Amount, title: 'Alert' });
                            return false;
                        }
                        PatientDueChart.DiscountAmount = parseInt($scope.ItemDiscount);
                        PatientDueChart.ItemDiscount = {};
                        PatientDueChart.ItemDiscount.DiscountID = 0;
                        PatientDueChart.ItemDiscount.DiscountName = 0;
                        PatientDueChart.ItemDiscount.Discount = $scope.ItemDiscount;
                        PatientDueChart.ItemDiscount.Code = "";
                        PatientDueChart.ItemDiscount.CeilingValue = 0;
                        PatientDueChart.ItemDiscount.DiscountPercentage = 0.00;
                        PatientDueChart.ItemDiscount.DiscountType = 0;
                    }
                    $scope.resetBillingDetails();
                    PatientDueChart.DiscountAmount = PatientDueChart.DiscountAmount ? PatientDueChart.DiscountAmount : 0;
                    PatientDueChart.NetAmount = PatientDueChart.Amount - PatientDueChart.DiscountAmount;
                    PatientDueChart.unit = 1.00;
                    angular.merge(PatientDueChart, $scope.billingitem);
                    if ($scope.billingData.Patient.PatientStatus == "ST") {
                        PatientDueChart.IsStat = "Y";
                    }
                    else {
                        PatientDueChart.IsStat = "N";
                    }
                    $scope.billdata.push(PatientDueChart);
                    $.grep($scope.billdata, function (n, i) {
                        if (!angular.isUndefined(n.FeeDescription) && n.FeeDescription != "") {
                            return (n.Descrip = n.FeeDescription)
                        }
                    });
                    $scope.CalTotalAmount();
                    $scope.billingitem = "";
                    $scope.ItemLevelDiscount = "";
                    $scope.ItemDiscount = "";
                    $scope.billingitemSelected = {};
                    $scope.billingItemForm.$setUntouched();
                    $scope.billingItemForm.$setPristine();
                }
                billingAPI.GetBillingItemsDetails(obj.FeeId, obj.FeeType, $scope.clientData.Client.ClientID, 0, "N", obj.VisitDate, getBillingItemsDetailsLoad);
            });
        }
        else {
            Notification.error({ message: 'Select Atleast one item for add', title: 'Alert' });
        }
    };
    $scope.removePreviousBillingItems = function () {
        $scope.all = false;
        var pv = $.grep($scope.PreviousVisit, function (n, i) { return n.Checked == true });
        if (pv.length > 0) {
            var check = false;
            for (var j = 0; j < pv.length; j++) {
                $.grep($scope.billdata, function (n, i) {
           
                    if (n && n.FeeId == pv[j].FeeId && n.FeeType == pv[j].FeeType) {
                        $scope.billdata.splice(i, 1);
                        pv[j].Checked = false;
                        check = true;
                        $scope.CalTotalAmount();
                        $scope.billingitemSelected = {};
                        $scope.billingItemForm.$setUntouched();
                        $scope.billingItemForm.$setPristine();
                        $scope.RoundOffAmount = 0;
                        $scope.billingitem = "";
                    }
                })
            }
            if (check) {
                Notification.success({ message: pv.length + 'Items removed successfully for this visit', title: 'Success' });
            }
            else {
                Notification.error({ message: 'Selected Items not available for this visit', title: 'Alert' });
            }
        }
        else {
            Notification.error({ message: 'Select Atleast one item for remove', title: 'Alert' });
        }
    };
    $scope.removeBillingitem = function (index) {
        $scope.billdata.splice(index, 1);
        $scope.CalTotalAmount();
        $scope.billingitemSelected = {};
        $scope.billingItemForm.$setUntouched();
        $scope.billingItemForm.$setPristine();
        $scope.RoundOffAmount = 0;
    };
    //--------------------------------------------------------Billing Calculation-----------------------------------------------------------//
    $scope.CalTotalAmount = function () {
        $scope.TotalAmount = 0;
        $scope.GrossBillValue = 0;
        $scope.TotalItemDiscount = 0;
        angular.forEach($scope.billdata, function (value, key) {

            $scope.TotalAmount = $scope.TotalAmount + (value.Amount - value.DiscountAmount);
            $scope.GrossBillValue = $scope.GrossBillValue + value.Amount;
            $scope.TotalItemDiscount = $scope.TotalItemDiscount + value.DiscountAmount;
        });
        $scope.calcBillLevelDiscount();
    }

    $scope.calcBillLevelDiscount = function () {
        var Discount;
        var IS_JSON = true;
        $scope.BillLevelDiscount = $scope.BillLevelDiscount ? $scope.BillLevelDiscount : 0;
        try {
            Discount = JSON.parse($scope.BillDiscount).Discount;
            //$scope.BillDiscount = JSON.parse($scope.BillDiscount).Discount;
        }
        catch (err) {
            IS_JSON = false;
            $scope.BillLevelDiscount = $scope.BillDiscount ? $scope.BillLevelDiscount : 0;
        }
        if (IS_JSON) {
            if (Discount > 100) {
                Notification.error({ message: 'Provide Discount Less than 100 %', title: 'Alert' });
                return false;
            }
            $scope.BillLevelDiscount = (($scope.TotalAmount * Discount) / 100);
        }
        else if (angular.lowercase($scope.BillDiscount) == 'value' && $scope.TotalAmount <= $scope.BillLevelDiscount) {
            Notification.error({ message: 'Provide Discount Less than bill amount', title: 'Alert' });
            return false;
        }
        var pnet = $scope.TotalAmount - $scope.BillLevelDiscount;
        $scope.TaxAmount = 0;

        if ($scope.tax) {
            $scope.TaxAmount = ((pnet) * $scope.tax.TaxPercent) / 100;
        }

        $scope.NetAmount = pnet + $scope.TaxAmount;
        var tempNet = $scope.NetAmount;
        $scope.NetAmount = Math.round($scope.NetAmount);
        $scope.RoundOffAmount = $scope.NetAmount - tempNet;
    };

    $scope.NetValueCalc = function () {
        if (!angular.isUndefined($scope.ItemDiscountType) && $scope.ItemDiscountType == 'PERCENTAGE') {

        }
        else if (!angular.isUndefined($scope.ItemDiscountType) && $scope.ItemDiscountType == 'VALUE') {

        }
        $scope.billingData.FinalBillDetails.NetValue = (($scope.billingData.FinalBillDetails.GrossBillValue) -
                           ((($scope.billingData.FinalBillDetails.GrossBillValue) / 100) * ($scope.DiscountPercentage)) +
                           ((($scope.billingData.FinalBillDetails.GrossBillValue) / 100) * ($scope.TaxAmount)));
    };

    $scope.$watch('billingData.Patient.DOB', function (newobj, oldobj) {
        if (newobj == "" || newobj == undefined || newobj == '9999-12-31T23:59:59.997') {
            $scope.dtOutput = "";
        } else {
            $scope.selectDate(newobj);

        }
    });

    //--------------------------------------------------------Billing Calculation-----------------------------------------------------------//
    //calender popup 
    function DaysInMonth(Y, M) {
        with (new Date(Y, M, 1, 24)) {
            setDate(0);
            return getDate();
        }
    }
    $scope.selectDate = function (dt) {
        var dob = dt;
        var today = new Date();
        var differenceInMilisecond = today.valueOf() - dob.valueOf();
        var year_age = Math.floor(differenceInMilisecond / 31536000000);
        var day_age = Math.floor((differenceInMilisecond % 31536000000) / 86400000);
        var month_age = Math.floor(day_age / 30);
        var week_age = Math.floor(day_age / 7);

        if (year_age > 120) {
            Notification.error({ message: 'Age should not be more than 120 years', title: 'Alert' });
            $scope.billingData.Patient.Age = "";
            $scope.billingData.Patient.DOB = "";
        }
        if (!istxtDate) {
            if (year_age != 0) {
                $scope.billingData.Patient.Age = year_age;
                $scope.billingData.Patient.AgeTypeCode = $scope.billingData.AgeType[2].Code
            } else if (year_age == 0 && month_age != 0) {
                $scope.billingData.Patient.Age = month_age;
                $scope.billingData.Patient.AgeTypeCode = $scope.billingData.AgeType[1].Code
            } else if (week_age != 0 && month_age == 0 && year_age == 0) {
                $scope.billingData.Patient.Age = week_age
                $scope.billingData.Patient.AgeTypeCode = $scope.billingData.AgeType[3].Code
            } else if (year_age == 0 && month_age == 0 && week_age == 0) {
                $scope.billingData.Patient.Age = day_age;
                $scope.billingData.Patient.AgeTypeCode = $scope.billingData.AgeType[0].Code
            }
        }
        istxtDate = false;
    };
    var istxtDate = false;
    $scope.calDob = function (age) {
        istxtDate = true;
        if (age > 120) {
            Notification.error({ message: 'Age should not be more than 120 years', title: 'Alert' });
            $scope.billingData.Patient.Age = "";
            $scope.billingData.Patient.DOB = "";
            return false;
        }
        if (angular.isUndefined($scope.billingData.Patient.AgeTypeCode)) {
            return false;
        }
        else {
            $scope.AgeType = $scope.billingData.Patient.AgeTypeCode;//$scope.billingData.AgeType[2].MetaDataID
            var today = new Date();
            $scope.billingData.Patient.DOB = "";
            var dob;
            if ($scope.AgeType == "Year(s)") {
                dob = today.getFullYear() - age;
                dob = today.setFullYear(dob);
            }
            else if ($scope.AgeType == "Month(s)") {
                //if (age >= 12) {
                //    Notification.error({ message: 'Provide month 12 and below ', title: 'Alert' });
                //    return false
                //}
                dob = today.getMonth() - age;

                dob = today.setMonth(dob);
            }
            else if ($scope.AgeType == "Week(s)") {
                //if (age >= 4) {
                //    Notification.error({ message: 'Provide week 4 and below ', title: 'Alert' });
                //    return false
                //}
                var d = age * 7;
                dob = today.getDate() - d;
                dob = today.setDate(dob);

            }
            else if ($scope.AgeType == "Day(s)") {
                //if (age >= 30) {
                //    Notification.error({ message: 'Provide days 30 and below ', title: 'Alert' });
                //    return false
                //}
                dob = today.getDate() - age;
                dob = today.setDate(dob);
            }
            $scope.billingData.Patient.DOB = dob;
        }
    };
    $scope.checkAuthBy = function (authBy) {
        return DataFactory.get('discountapprover', { Name: authBy, Type: "DisApprove" }).then(function (response) {
            return response.data.map(function (item) {
                return item;
            });
        });
    };
    $scope.selectAll = function (data) {
        if (data) {
            $.grep($scope.PreviousVisit, function (n, i) { return n.Checked = true });
        }
        else {
            $.grep($scope.PreviousVisit, function (n, i) { return n.Checked = false });
        }
    };

    $scope.viewContent = function (obj) {
        billingAPI.getHealthPackageDataSearch(obj.FeeType, obj.ID, getHealthPackageDataSearchLoaded);
    }
    $scope.validation = function () {
        var isValid = false;
        angular.forEach($scope.billingFrom.$error, function (items) {
            angular.forEach(items, function (item) {
                if (item.valid !== undefined && item.valid === false) {
                    if (!isValid) {
                        Notification.error({ message: 'Provide ' + item.$name, title: 'Alert' });
                        isValid = true;
                    }
                }
            });
        });

        if (!angular.isDefined($scope.billingData.Patient.FirstName)) {
            Notification.error({ message: 'Provide Patient Name', title: 'Alert' });
            isValid = true;
        }
        if (!angular.isDefined($scope.billingData.Patient.Gender)) {
            Notification.error({ message: 'Provide Patient Gender', title: 'Alert' });
            isValid = true;
        }
        if ($scope.billingData.Patient.Age === "") {
            Notification.error({ message: 'Provide Patient Age', title: 'Alert' });
            isValid = true;
        }
        if ($scope.billingData.Patient.DOB === "Invalid date") {
            Notification.error({ message: 'Provide Patient Age', title: 'Alert' });
            isValid = true;
        }
        if (!angular.isDefined($scope.billingData.Patient.Age)) {
            Notification.error({ message: 'Provide Patient Age', title: 'Alert' });
            isValid = true;
        }
        if (!$scope.billingData.Patient.MobileNumber && !$scope.billingData.Patient.LandLineNumber) {
            Notification.error({ message: 'Provide Patient Contact Number', title: 'Alert' });
            isValid = true;
        }
        if ($scope.billingData.Patient.MobileNumber) {
            if ($scope.billingData.Patient.MobileNumber.length != $scope.billingData.Country.PhoneNo_Length) {
                Notification.error({ message: 'Provide Valid Mobile No', title: 'Alert' });
                isValid = true;
            }
        }
        if ($scope.billingFrom.emailId.$error.pattern) {
            Notification.error({ message: 'Provide Valid E-MailID', title: 'Alert' });
            isValid = true;
        }
        if (!angular.isDefined($scope.billingData.Country)) {
            Notification.error({ message: 'Provide Patient Country', title: 'Alert' });
            isValid = true;
        }
        if (!angular.isDefined($scope.billingData.State)) {
            Notification.error({ message: 'Provide Patient State', title: 'Alert' });
            isValid = true;
        }
        if ($scope.billdata.length == 0) {
            Notification.error({ message: 'Provide billing items', title: 'Alert' });
            isValid = true;
        }
        if ($scope.BillLevelDiscount > 0) {
            if (angular.isUndefined($scope.BillLevelDiscountReason)) {
                Notification.error({ message: 'Provide Bill level discount reason', title: 'Alert' });
                isValid = true;
            }
            if (angular.isUndefined($scope.DisCountAuthorized)) {
                $scope.DisCountAuthorized = "";
            }
            if ($scope.DisCountAuthorized == "") {
                Notification.error({ message: 'Provide Authorized by ', title: 'Alert' });
                isValid = true;
            }
        }
        


        if (isValid) {
            return false;
        }
        else {
            return true;
        }
    }
    $scope.GenerateBill = function () {
        var isValid = true;
        if ($scope.validation() == true) {
                
            if ($scope.billingData.Due > 0 && $scope.clientData.Client.IsCashClient =='Y') {
                if (!$window.confirm("Bill amount will be added to due.\n Do you want to continue?")) {
                    isValid = false;
                }
            }

            if (isValid) {

                try {
                    $scope.FinalBillDetails = {
                        DiscountAmount: parseFloat($scope.BillLevelDiscount.toFixed(2)),
                        GrossBillValue: parseFloat($scope.TotalAmount.toFixed(2)),
                        DiscountReason: $scope.BillLevelDiscountReason ? $scope.BillLevelDiscountReason : "",
                        TaxAmount: parseFloat($scope.TaxAmount.toFixed(2)),
                        ServiceCharge: 0,
                        RoundOff: parseFloat($scope.RoundOffAmount.toFixed(2)),
                        NetValue: parseFloat($scope.NetAmount.toFixed(2)),
                        Due:  $scope.clientData.Client.IsCashClient !='Y' ? 0: $scope.billingData.Due,
                        BillDiscount: JSON.parse($scope.BillDiscount),

                    }
                }
                catch (err) {
                    var BillDiscount = {};
                    BillDiscount.DiscountID = 0;
                    BillDiscount.DiscountName = 0;
                    BillDiscount.Discount = $scope.BillLevelDiscount;
                    BillDiscount.Code = "";
                    BillDiscount.CeilingValue = 0;
                    BillDiscount.DiscountPercentage = 0.00;
                    BillDiscount.DiscountType = 0;

                    $scope.FinalBillDetails = {
                        DiscountAmount: $scope.BillLevelDiscount,
                        GrossBillValue: $scope.TotalAmount,
                        DiscountReason: "",
                        TaxAmount: $scope.TaxAmount,
                        ServiceCharge: 0,
                        RoundOff: parseFloat($scope.RoundOffAmount.toFixed(2)),
                        NetValue: parseFloat($scope.NetAmount.toFixed(2)),
                        Due: $scope.clientData.Client.IsCashClient !='Y' ? 0: $scope.billingData.Due,
                        BillDiscount: BillDiscount,

                    }
                }

                $scope.BillingPatient = {};
                angular.isUndefined($scope.billingData.Patient.Salutation) ? ($scope.billingData.Patient.Salutation = $.grep($scope.billingData.Titles, function (n, i) { return (n.TitleName == "") })[0]) : "";
                $scope.billingData.Patient.AgeTypeCode = $scope.billingData.Patient.AgeTypeCode;
                $scope.billingData.Patient.DOB1 = moment($scope.billingData.Patient.DOB).format();
                $scope.BillingPatient.Patient = $scope.billingData.Patient;
                $scope.billingData.Patient.DOB = moment($scope.billingData.Patient.DOB);
                $scope.BillingPatient.Patient = $scope.billingData.Patient;
                $scope.BillingPatient.Country = $scope.billingData.Country ? $scope.billingData.Country : {};
                $scope.BillingPatient.State = $scope.billingData.State ? $scope.billingData.State : {};
                $scope.billingData.Patient.City = angular.isUndefined($scope.billingData.Patient.City) ? "" : $scope.billingData.Patient.City;
                $scope.BillingPatient.City = {};
                if (angular.isDefined($scope.billingData.Patient.City)) {
                    $scope.BillingPatient.City.CityId = !angular.isUndefined($scope.billingData.Patient.City) ? $scope.billingData.Patient.City.CityId : 0;
                    $scope.BillingPatient.City.CityName = !angular.isUndefined($scope.billingData.Patient.City) ? $scope.billingData.Patient.City.CityName : "";
                    $scope.BillingPatient.City.StateID = $scope.billingData.State ? $scope.billingData.State.StateID : 0;
                    $scope.billingData.Patient.City = $scope.BillingPatient.City.CityName;
                }
                $scope.BillingPatient.Patient.PostalCode = !angular.isUndefined($scope.Pincode) ? $scope.Pincode.Pincode : '';// angular.isDefined($scope.Pincode);
                $scope.BillingPatient.Patient.ExternalPatientNumber = $scope.clientData.ExtrenalPatientNo;
                $scope.BillingPatient.ReportDeliveryMode = $scope.billingData.Patient.ReportDeliveryMode ? $scope.billingData.Patient.ReportDeliveryMode : {};
                $scope.BillingPatient.DispatchType = $.grep($scope.billingData.DispatchType, function (n, i) { return (n.IsChecked == true) });
                $scope.BillingPatient.DispatchMode = $.grep($scope.billingData.DispatchMode, function (n, i) { return (n.IsChecked == true) });
                $scope.BillingPatient.ClientReference = $scope.clientData.Client;
                $scope.BillingPatient.Patient.SamplePickupDate = moment($scope.clientData.SamplePickupDate);
                $scope.BillingPatient.URN = $scope.billingData.URN ? $scope.billingData.URN : {};
                $scope.BillingPatient.AdditionalDetails = $scope.billingData.AdditionalDetails ? $scope.billingData.AdditionalDetails : {};
                $scope.BillingPatient.AdditionalDetails.DiscountApprovedBy = $scope.DisCountAuthorized ? $scope.DisCountAuthorized.LoginID : 0
                $scope.BillingPatient.PatientDueChart = $scope.billdata;
                $.grep($scope.BillingPatient.PatientDueChart, function (n, i) { return (n.FeeID = n.ID, n.Description = n.Descrip) });
                $scope.BillingPatient.FinalBillDetails = $scope.FinalBillDetails;
                var TRFFile = $scope.lstDocument ? $scope.lstDocument : [];
                if ($scope.clientData.Client.IsCashClient == 'Y') {
                    angular.isUndefined($scope.billingData.AmountReceivedDetails) ? ($scope.dirOptions.AddAmountReceived()) : "";
                }



                $scope.BillingPatient.AmountReceivedDetails = $scope.billingData.AmountReceivedDetails ? $scope.billingData.AmountReceivedDetails : [];
                billingAPI.GenerateBill(TRFFile, $scope.BillingPatient, generateBillLoaded);
            }
        }
    };

    
    $scope.billPrint = function (data) {
        var PID = data.PatientID;
        var VID = data.VisitID;
        var BID = data.FinalBillID;
        var TPAName = $scope.clientData.Client.ClientCode;
        var strURL = "../Reception/PrintPage.aspx?pid=" + PID + "&vid=" + VID + "&pagetype=BP&quickbill=N&bid=" + BID + "&visitPur=-1&ClientName=" + TPAName + "&OrgID=98&BKNO=&IsPopup=Y%20&duplicateBill=N&IsPopup=Y";
        window.open(strURL, '', 'left=150,top=50,height=600,width=900,scrollbars=no,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
    };

    $scope.reset = function () {
        $state.reload();
    };
    $rootScope.billingDetailsClear = function (ev) {
        if ($scope.billdata.length > 0 && angular.isUndefined(ev)) {
            $scope.billdata = [];
        }
        $scope.TotalAmount = 0;
        $scope.GrossBillValue = 0;
        $scope.TotalItemDiscount = 0;
        $scope.NetAmount = 0;
        $scope.RoundOffAmount = 0;
        $scope.BillDiscount = undefined;
        $scope.BillLevelDiscount = undefined;
        $scope.tax = undefined;
        $scope.TaxAmount = undefined;
        $scope.BillLevelDiscountReason = undefined;
        $scope.paymentDetailsClear();

    };
    $scope.paymentDetailsClear = function () {
        !angular.isUndefined($scope.billingData.AmountReceivedDetails) ? ($scope.dirOptions.ClearAmountReceived()) : "";
    };
    $scope.resetBillingDetails = function () {
        $scope.BillDiscount = "";
        $scope.BillLevelDiscount = "";
        $scope.BillLevelDiscountReason = undefined;
        $scope.tax = undefined;
        $scope.AuthorizedBy = 0;
    };

    $scope.GetautoColor=function(p)
    {
        var pcolur = "";
        switch (p.FeeType) {
            case "INV":
                pcolur = "Investigation";
                break;
            case "GRP":
                pcolur = "Group";
                break;
            case "PKG":
                pcolur = "Package";
                break;
            case "GEN":
                pcolur = "GeneralBillingItems";
                break;
            case "INV":
                pcolur = "Investigation";
                break;
            case "INV":
                pcolur = "Investigation";
                break;
            default:

        }
        return pcolur;
    }
    $scope.GettdColor = function (p) {
        var pcolur = "";
        if (p.IsOutSource)
        {
            pcolur = "tdoutsource";
        }
        else if(p.IsStat=="Y")
        {
            pcolur = "STAT";
        }
        return pcolur;

    }




}]);
