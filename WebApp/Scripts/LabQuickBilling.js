function GetCorrectdate1(oObj) {
    var value = "";
   // debugger;
    if (parseInt(oObj.indexOf(')')) > -1 && parseInt(oObj.indexOf('(')) > -1) {
        var actualvalue = oObj.slice(parseInt(oObj.indexOf('(')) + 1, parseInt(oObj.indexOf(')')));
        var actualdate = new Date(parseInt(actualvalue)); //like Sun Nov 08 2020 13:41:00 GMT+0530 (India Standard Time)

        var date = new Date(actualdate),
            mnth = ("0" + (date.getMonth() + 1)).slice(-2),
            day = ("0" + date.getDate()).slice(-2);
        var finaldateformat = [day, mnth, actualdate.getFullYear()].join("/");
        var ahour = ("0" + date.getHours()).slice(-2),
        aminutes = ("0" + date.getMinutes()).slice(-2);
        value = finaldateformat + " " + ahour + ":" + aminutes;
    }
    return value;
}
function setPatientSearch() {
    try {
        var searchvalue, searchtype;
        var searchtypeRadioList = document.getElementsByName('rblSearchType');
        var OrgID = document.getElementById('hdnOrgID').value;
        var NewOrgID = document.getElementById('hdnNewOrgID').value;

        for (var i = 0; i < searchtypeRadioList.length; i++) {
            if (searchtypeRadioList[i].checked) {
                searchtype = searchtypeRadioList[i].value
                break;
            }
        }
        if (searchtype == 4) {
            document.getElementById('txtName').setAttribute('autocomplete', 'off');
        }
        else {
            if (searchtype == 0) {
                $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(3);
            }
            else if (searchtype == 1) {
                $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(1);
            }
            else if (searchtype == 2) {
                $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(5);
            }
            else if (searchtype == 3) {
                $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(1);
            }
            var PatientID = -1;
            searchvalue = OrgID + "~" + PatientID + "~" + searchtype;
            $find('AutoCompleteExtenderPatient').set_contextKey(searchvalue);
        }

    } catch (e) {
        //alert(e);
    }
}

function setPatientSearchjquery() {
    try {
        var searchvalue, searchtype;
        var searchtypeRadioList = document.getElementsByName('rblSearchType');
        var OrgID = document.getElementById('hdnOrgID').value;
        var NewOrgID = document.getElementById('hdnNewOrgID').value;

        for (var i = 0; i < searchtypeRadioList.length; i++) {
            if (searchtypeRadioList[i].checked) {
                searchtype = searchtypeRadioList[i].value
                break;
            }
        }
        if (searchtype == 4) {
            $('#txtName').autocomplete('disable');
            document.getElementById('txtName').setAttribute('autocomplete', 'off');
            
        }
        else {
            $('#txtName').autocomplete('enable');
            var PatientID = -1;
            searchvalue = OrgID + "~" + PatientID + "~" + searchtype;
            $('#hdnContextText').val(searchvalue);
           
        }

    } catch (e) {
        //alert(e);
    }
}



function SelectVisitType() {
    //    if ($('[id$="ddlIsExternalPatient"]').val() == 1) {
    //        $('[id$="tdlblWardNo"]').show();
    //        $('[id$="tdtxtWardNo"]').show();
    //    }
    //    else {
    //        $('[id$="tdlblWardNo"]').hide();
    //        $('[id$="tdtxtWardNo"]').hide();
    //    }
    //    if ($('[id$="ddlIsExternalPatient"]').val() == 1) {
    //        $('[id$="tdlblWardNo"]').show();
    //        $('[id$="tdtxtWardNo"]').show();
    //    }
    //    else {
    //        $('[id$="tdlblWardNo"]').hide();
    //        $('[id$="tdtxtWardNo"]').hide();
    //    }
}



function ShowPrevious() {
    $('[id$="ShowBillingItems"]').show();
    $('[id$="ShowPreviousData"]').hide();
    //    $('[id$="ShowBillingItems"]').show();
    //    $('[id$="ShowPreviousData"]').hide(); 
}

function IsPatientAlreadyExists() {
    if ($('[id$="hdnPatientID"]').val() <= 0 && $('[id$="hdnPatientAlreadyExistsWebCall"]').val() == 0) {
        if (document.getElementById('txtMobileNumber').value.trim().length > 0 || document.getElementById('txtPhone').value.trim().length > 0) {
            $.ajax({
                type: "POST",
                url: "../OPIPBilling.asmx/CheckPatientforDuplicate",
                data: "{ 'patientName': '" + document.getElementById('txtName').value + "','mobileNo': '" + document.getElementById('txtMobileNumber').value + "','llNo': '" + document.getElementById('txtPhone').value + "','orgID': '" + parseInt(document.getElementById('hdnOrgID').value) + "','patientNumber': '-1'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    $('[id$="hdnPatientAlreadyExistsWebCall"]').val(1);
                    if (data.d >= 1) {
                        $('[id$="hdnPatientAlreadyExists"]').val(1); ;
                        alert('Patient already registered with the given details');
                        $('[id$="txtMobileNumber"]').focus();
                        return false;
                    }
                },
                failure: function(msg) {
                    alert(msg);
                }
            });
        }
    }
    else {
        return true;
    }
}


function IsRegistrationDeflag() {

    var OrgID = document.getElementById('hdnOrgID').value;

    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/RegistrationRepush",
        data: "{ OrgId: '" + OrgID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            if (data.d != [] && data.d.length > 0) {
                var list = data.d;

                for (i = 0; i < list.length; i++) {
                    if (document.getElementById(list[i].FieldId).value.trim() != document.getElementById(list[i].ControlId).value.trim()) {
                        if ((list[i].IsDeflag) == "Y") {
                            document.getElementById('hdnIsEditDeFlag').value = 'Y';
                            document.getElementById('hdnIsEditRePush').value = 'Y';
                            break;
                        }
                    }
                }
            }
            //            failure: function(msg) {
            //                alert(msg);
            //            }
        }
    });
}
function IsRegistrationRepush() {
    var OrgID = document.getElementById('hdnOrgID').value;

    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/RegistrationRepush",
        data: "{ OrgId: '" + OrgID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            if (data.d != [] && data.d.length > 0) {
                var list = data.d;
                for (i = 0; i < list.length; i++) {
                    if (document.getElementById(list[i].FieldId).value.trim() != document.getElementById(list[i].ControlId).value.trim()) {
                        if ((list[i].IsRepush) == "Y") {
                            document.getElementById('hdnIsEditRePush').value = 'Y';
                            break;
                        }
                    }
                }
            }

        },
        failure: function(msg) {
            alert(msg);
        }
    });
}
//    if ($('[id$="hdnPatientID"]').val() <= 0 && $('[id$="hdnPatientAlreadyExistsWebCall"]').val() == 0) {
//        if (document.getElementById('txtMobileNumber').value.trim().length > 0 || document.getElementById('txtPhone').value.trim().length > 0) {
//            $.ajax({
//                type: "POST",
//                url: "../OPIPBilling.asmx/CheckPatientforDuplicate",
//                data: "{ 'patientName': '" + document.getElementById('txtName').value + "','mobileNo': '" + document.getElementById('txtMobileNumber').value + "','llNo': '" + document.getElementById('txtPhone').value + "','orgID': '" + parseInt(document.getElementById('hdnOrgID').value) + "','patientNumber': '-1'}",
//                contentType: "application/json; charset=utf-8",
//                dataType: "json",
//                async: true,
//                success: function(data) {
//                    $('[id$="hdnPatientAlreadyExistsWebCall"]').val(1);
//                    if (data.d >= 1) {
//                        $('[id$="hdnPatientAlreadyExists"]').val(1); ;
//                        alert('Patient already registered with the given details');
//                        $('[id$="txtMobileNumber"]').focus();
//                        return false;
//                    }
//                },
//                failure: function(msg) {
//                    alert(msg);
//                }
//            });
//        }
//    }
//    else {
//        return true;
//    }


function SetPreviousVisitItems() {
    var UsrAdd = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") : "Add";
    var TVisit = "N";
    var tblStatr = "";
    var tblBoody = "";
    var vTestName = SListForAppDisplay.Get("Billing_CommonBilling_js_59") == null ? "Test Name" : SListForAppDisplay.Get("Billing_CommonBilling_js_59");
    var vType = SListForAppDisplay.Get("Billing_CommonBilling_js_60") == null ? "Type" : SListForAppDisplay.Get("Billing_CommonBilling_js_60");
    var vS = SListForAppDisplay.Get("Billing_CommonBilling_js_03") == null ? "S.No" : SListForAppDisplay.Get("Billing_CommonBilling_js_03");
    var vID = SListForAppDisplay.Get("Billing_CommonBilling_js_61") == null ? "ID" : SListForAppDisplay.Get("Billing_CommonBilling_js_61");
    var vAll = SListForAppDisplay.Get("Billing_CommonBilling_js_62") == null ? "All" : SListForAppDisplay.Get("Billing_CommonBilling_js_62");
    var vIsAddToday = SListForAppDisplay.Get("Billing_CommonBilling_js_63") == null ? "IsAddToday" : SListForAppDisplay.Get("Billing_CommonBilling_js_63");
    var vAdd = SListForAppDisplay.Get("Billing_CommonBilling_js_64") == null ? "Add" : SListForAppDisplay.Get("Billing_CommonBilling_js_64");
    var vVisitDate = SListForAppDisplay.Get("Billing_CommonBilling_js_65") == null ? "Visit Date" : SListForAppDisplay.Get("Billing_CommonBilling_js_65");
    var vPatientHistory = SListForAppDisplay.Get("Billing_CommonBilling_js_66") == null ? "Patient History" : SListForAppDisplay.Get("Billing_CommonBilling_js_66");
    var vIsOutSource = SListForAppDisplay.Get("Billing_CommonBilling_js_25") == null ? "IsOutSource" : SListForAppDisplay.Get("Billing_CommonBilling_js_25");
    var vTestCode = SListForAppDisplay.Get("Billing_CommonBilling_js_67") == null ? "TestCode" : SListForAppDisplay.Get("Billing_CommonBilling_js_67");
    var tblEnd = "";
    var tblResult = "";
    var tblTotal = "";
    var listLen = 0;
    if (document.getElementById('hdnPreviousVisitDetails').value != '') {
        listLen = document.getElementById('hdnPreviousVisitDetails').value.split('^').length;
    }
    var sum = 0.00;
    var temp = 0.00;
    var res = new Array();
    var ItemArray = new Array();
    var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
    var Gender = document.getElementById('ddlSex').value;
    document.getElementById('hdnGender').value = Gender;
    //    FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
    //                + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8] + "|";
    //document.getElementById('hdfBillType1').value = FeeViewStateValue;

    if (listLen > 0) {
        tblStatr = " <div style='overflow: auto; height: 100px;width: 475px;'>"
                + "<table border='1' id='tblItems' class='gridView' width='100%'>"
                + "<tr class = 'gridHeader' style='font-weight:bold;color:#fff;'><td style='width:30px;color:#fff;'>" + vS + "</td><td  style='width:330px;color:#fff;'>" + vTestName + "</td><td  style='display:none;width:30px;color:#fff;'>" + vID + "</td><td style='display:table-cell;width:30px;color:#fff;'>" + vType + "</td>"
                + "<td style='display:table-cell;width:30px;color:#fff;'><input id='chkAll' name='chkAll1' onclick='chkSelectAll(document.form1.chkAll);' value='SelectAll' type='checkbox'>" + vAll + "</input></td><td  style='display:none;'>" + vIsAddToday + "</td><td  style='display:none;'>" + vIsOutSource + "</td><td  style='display:none;'>"+vTestCode+"</td></tr>";

        ItemArray = document.getElementById('hdnPreviousVisitDetails').value.split('^');

        var curdate = '';
        var predate = '';
        var j = 0;
        var k = 0;
        var count = 0;
        for (var i = 0; i < ItemArray.length; i++) {
            if (ItemArray[i] != "") {
                res = ItemArray[i].split('$');
                curdate = res[3];

                var strPatientHistory = '';
                if (res[4] == null || res[4] == 'null') {
                    strPatientHistory = '';
                }
                else {
                    strPatientHistory = res[4];
                }

                if (predate == curdate) {
                    var str = "chkboxItem" + k;
                    var txt = "txtBillItems" + j;
                    if (defalutdata[0] != res[1] && defalutdata[1] != res[2]) {

                        tblBoody += "<tr><td>" + parseInt(j + 1) + "</td><td>" + res[0] + "</td><td style='display:none;'>" + res[1] + "</td><td style='display:table-cell;'>" + res[2] +
                                "</td><td style='display:table-cell;'><input  id='" + str + "' name='chkAll'  value='" + '' + "' type='checkbox'  /></td><td style='display:none;'>" + res[5] + "</td><td style='display:none;'>" + res[6] + "</td><td style='display:none;'>" + res[7] + "</td>";

                        j++;
                        k++;
                    }
                }
                else {
                    count++;
                    if (count == 6) {
                        break;
                    }
                    tblBoody += "<tr><td style='font-weight:bold' colspan='5' title='" + strPatientHistory + "'>" + vVisitDate + " : " + curdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; " + vPatientHistory + ": " + strPatientHistory.substring(0, 25) + "</td></tr>";
                    predate = curdate;
                    j = 0;
                    i--;

                }
                var IsTodayVisit = res[8];
                if (IsTodayVisit == 'Y') {
                    TVisit = "Y";
                    var TodayVisitID = res[9];
                    document.getElementById('hdnTodayVisitID').value = TodayVisitID;
                    document.getElementById('hdnTempTodayVisitID').value = TodayVisitID;
                    //document.getElementById('ddlVisitDetails').value = "1~2";
                    var ddlVisitDetails = document.getElementById('ddlVisitDetails');
                    ddlVisitDetails.selectedIndex = 0;
                    document.getElementById('tdVisitType1').style.display = "table-cell";
                    document.getElementById('tdVisitType2').style.display = "table-cell";
                    var NewOrgID = document.getElementById('hdnNewOrgID').value;
                    //document.getElementById('tdSex1').style.width = '10%';
                    //document.getElementById('tdSex2').style.width = '18%';
                }
            }

        }
        tblTotal += "<tr><td colspan='5' style='display:table-cell;' align='center'><input id='adds' type='button' value="+UsrAdd+" class='btn' onclick='javascript:AddPreviousVisitItemsToBilling();' ></td></tr>";
        tblEnd = "</table></div>";
    }
    tblResult = tblStatr + tblBoody + tblTotal + tblEnd;
    $('[id$="lblPreviousItems"]').html(tblResult);
    if (document.getElementById('lblPreviousItems').innerHTML.trim() != '') {
        tbItemshow();
    }
    else {
        $('[id$="ShowBillingItems"]').hide();
    }
}
function SetBookedItems() {
    var UsrAdd = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") : "Add";
    var TVisit = "N";
    var tblStatr = "";
    var tblBoody = "";

    var tblEnd = "";
    var tblResult = "";
    var tblTotal = "";
    var listLen = document.getElementById('hdnPreviousVisitDetails').value.split('^').length;
    var sum = 0.00;
    var temp = 0.00;
    var res = new Array();
    var ItemArray = new Array();
    var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
    var Gender = document.getElementById('ddlSex').value;
    document.getElementById('hdnGender').value = Gender;
    //    FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
    //                + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8] + "|";
    //document.getElementById('hdfBillType1').value = FeeViewStateValue;

    if (listLen > 0) {
        tblStatr = " <div style='overflow: auto; height: 130px;width: 475px;'>"
                + "<table border='1' id='tblItems' cellpadding='1' cellspacing='0' class='dataheaderInvCtrl' style='text-align: left; font-size: 11px;' width='100%'>"
                + "<tr class = 'dataheader1' style='font-weight:bold;'><td style='width:30px;'>S.No</td><td  style='width:330px;'>Test Name</td><td  style='display:none;width:30px;'>ID</td><td style='display:table-cell;width:30px;'>Type</td>"
                + "<td style='display:table-cell;width:30px;'><input id='chkAll' name='chkAll1' onclick='chkSelectAll(document.form1.chkAll);' value='SelectAll' type='checkbox'>All</input></td><td  style='display:none;'>IsAddToday</td><td  style='display:none;'>IsOutSource</td><td  style='display:none;'>TestCode</td></tr>";

        ItemArray = document.getElementById('hdnPreviousVisitDetails').value.split('^');

        var curdate = '';
        var predate = '';
        var j = 0;
        var k = 0;
        var count = 0;
        for (var i = 0; i < ItemArray.length; i++) {
            if (ItemArray[i] != "") {
                res = ItemArray[i].split('$');
                curdate = res[3];

                var strPatientHistory = '';
                if (res[4] == null || res[4] == 'null') {
                    strPatientHistory = '';
                }
                else {
                    strPatientHistory = res[4];
                }

                if (predate == curdate) {
                    var str = "chkboxItem" + k;
                    var txt = "txtBillItems" + j;
                    if (defalutdata[0] != res[1] && defalutdata[1] != res[2]) {

                        tblBoody += "<tr><td>" + parseInt(j + 1) + "</td><td>" + res[0] + "</td><td style='display:none;'>" + res[1] + "</td><td style='display:table-cell;'>" + res[2] +
                                "</td><td style='display:table-cell;'><input  id='" + str + "' name='chkAll'  value='" + '' + "' type='checkbox'  /></td><td style='display:none;'>" + res[5] + "</td><td style='display:none;'>" + res[6] + "</td><td style='display:none;'>" + res[7] + "</td><td style='display:none;'>" + res[10] + "</td>";

                        j++;
                        k++;
                    }
                }
                else {
                    count++;
                    if (count == 6) {
                        break;
                    }
                    tblBoody += "<tr><td style='font-weight:bold' colspan='5' title='" + strPatientHistory + "'>Booked on : " + curdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Booking History " + strPatientHistory.substring(0, 25) + "</td></tr>";
                    predate = curdate;
                    j = 0;
                    i--;

                }
                var IsTodayVisit = res[8];
                if (IsTodayVisit == 'Y') {
                    TVisit = "Y";
                    var TodayVisitID = res[9];
                    document.getElementById('hdnTodayVisitID').value = TodayVisitID;
                    document.getElementById('hdnTempTodayVisitID').value = TodayVisitID;
                    //document.getElementById('ddlVisitDetails').value = "1~2";
                    var ddlVisitDetails = document.getElementById('ddlVisitDetails');
                    ddlVisitDetails.selectedIndex = 0;
                    document.getElementById('tdVisitType1').style.display = "table-cell";
                    document.getElementById('tdVisitType2').style.display = "table-cell";
                    //                    document.getElementById('tdSex1').style.width = '10%';
                    //                    document.getElementById('tdSex2').style.width = '18%';
                }
            }

        }
        tblTotal += "<tr><td colspan='5' style='display:table-cell;' align='center'><input id='adds' type='button' value="+UsrAdd+" class='btn' onclick='javascript:AddPreviousVisitItemsToBilling();' ></td></tr>";
        tblEnd = "</table></div>";
    }
    tblResult = tblStatr + tblBoody + tblTotal + tblEnd;
    $('[id$="lblPreviousItems"]').html(tblResult);
    if (document.getElementById('lblPreviousItems').innerHTML.trim() != '') {
        tbItemshow();
var a = $('#hdnContextText').val().split('~');
        if (a[2] == 3 && document.getElementById('hdnBookingType').value == "Home Collection") {
            AddPreviousVisitItemsToBillingNew();
            $('#ShowBillingItems').hide();
            GetDiscountorRedeemDetails();
            //document.getElementById('divItems').style.display = 'none';
        }
    }
    else {
        $('[id$="ShowBillingItems"]').hide();
    }
}


function chkSelectAll(obj) {
    for (i = 0; i < obj.length; i++) {
        obj[i].checked = document.form1.chkAll1.checked == true ? true : false;
    }
}
function AddPreviousVisitItemsToBilling() {
    var isAlert = 'Y';
    if (IsItemChecked()) {
        var OrgID = document.getElementById('hdnOrgID').value;
        CallBillItems(OrgID);
        
        ///for HomeCollection data
        if (document.getElementById('hdnBookedID').value != '0' 
           && document.getElementById('hdnBookedID').value != '') {
            if (document.form1.chkAll1.checked == true) {
                if (document.getElementById('hdnIsPaymentAdded').value != 'Y') { ///Stoping duplicate payment mode
                    getHCPayments();
                    //controlsdisable();
                }
              } 
            else {  alert('Select All'); return false; }
        }
        
        var tbl = document.getElementById('tblItems').rows.length;
        var td = document.getElementById('tblItems');
        var rate = document.getElementById('txtClient').value;
        var pretex = new Array();
        var preInvID = new Array();
        var HasTest = 'N';
        var IsOutSourceLocation;
        var idv = new Array();
        if (tbl > 1) {
            var j = 0;
            var x = -1;
            for (var i = 1; i < tbl - 1; i++) {
                var cellcount = td.rows[i].cells.length;
                if (cellcount > 1) {
                    var tdID = td.rows[i].cells[4].childNodes[0].id;
                    if (document.getElementById(tdID).checked == true) {
                        x++;
                        var testName = td.rows[i].cells[1].childNodes[0];
                        var id = td.rows[i].cells[2].childNodes[0];
                        var FeeType = td.rows[i].cells[3].innerText;
                        var feetype1 = FeeType;
                        var IsOutSource = td.rows[i].cells[6].childNodes[0];
                        
                        var pBookingID = 0;
                        if (document.getElementById('hdnBookedID').value != '0' && document.getElementById('hdnBookedID').value != '') {
                            var TestCode = td.rows[i].cells[8].childNodes[0];
                            IsOutSourceLocation = td.rows[i].cells[8].childNodes[0].data;
                            pBookingID = document.getElementById('hdnBookedID').value;
                        }
                        else {
                            var TestCode = td.rows[i].cells[7].childNodes[0];
                        }
                        idv[x] = td.rows[i].cells[2].childNodes[0];
                        if (testName.data != "Test Name") {
                            var prefixText = testName.data;
                            preInvID[x] = td.rows[i].cells[2].innerText;
                            var Descrip = td.rows[i].cells[1].innerText
                            var FeeID = td.rows[i].cells[2].innerText;
                            var feeid1 = FeeID;
                            pretex[x] = testName.data;
                            var autoComplete = $find('billPart_AutoCompleteExtender3');
                            $.ajax({
                                type: "POST",
                                url: "../OPIPBilling.asmx/GetBillingItemsDetails",
                                data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, FeeID: id.data, FeeType: FeeType, Description: testName.data, ClientID: document.getElementById('hdnSelectedClientClientID').value, VisitID: 0, Remarks: '', IsCollected: document.getElementById('billPart_hdnIsCollected').value, CollectedDatetime: document.getElementById('billPart_hdnCollectedDateTime').value, locationName: document.getElementById('billPart_hdnLocName').value, BookingID: pBookingID }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: false,
                                success: function(data) {
                                    var Items = data.d;
                                    $.each(Items, function(index, Item) {
                                        var valu;
                                        for (var k = 0; k < Items.length; k++) {
                                            valu = Items[k].ProcedureName;
                                            // for (var m = 0; m < pretex.length; m++) {
                                            var idvalu = valu.split('^');

                                            var defalutdata = valu.split('^');

                                            if (document.getElementById('hdnBookedID').value != '0' && document.getElementById('hdnBookedID').value != '') {

                                            }
                                            else {
                                                IsOutSourceLocation = defalutdata[17];
                                            }

                                            var FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;

                                            var FeeGotValue = new Array();
                                            FeeGotValue = FeeViewStateValue.split('|');
                                            var feeIDALready = new Array();
                                            var tempFeeID, tempFeeType, tempOtherID, tempDateTime, tempDescrip, tempPerphyname, tempPerphyID, Quantity = 1;


                                            var PaymentAAlreadyPresent = new Array();
                                            var iPaymentAlreadyPresent = 0;
                                            var iPaymentCount = 0;
                                            var tarrayChildData = new Array();

                                            for (iMain = 0; iMain < FeeGotValue.length - 1; iMain++) {

                                                tarraySubData = FeeGotValue[iMain].split('~');
                                                for (tiChild = 0; tiChild < tarraySubData.length; tiChild++) {
                                                    tarrayChildData = tarraySubData[tiChild].split('^');
                                                    if (tarrayChildData.length > 0) {

                                                        if (tarrayChildData[0] == "FeeID") {
                                                            tempFeeID = tarrayChildData[1];
                                                        }
                                                        if (tarrayChildData[0] == "FeeType") {
                                                            tempFeeType = tarrayChildData[1];
                                                        }
                                                        if (tarrayChildData[0] == "Descrip") {
                                                            tempDescrip = tarrayChildData[1];
                                                        }
                                                        if (feeid1 == tempFeeID && feetype1 == tempFeeType && Descrip == tempDescrip) {
                                                            iPaymentAlreadyPresent = 1;
                                                        }
                                                    }
                                                }

                                            }

if(Items[k].IsTemplateText !=null && Items[k].IsTemplateText.length>0)
{
  var FeeID = defalutdata[0];
                        var FeeType = defalutdata[2];
                        var Templatediv = $('#billPart_divtemplate').find('div[FeeID="' + FeeID + '"]');
                        if (Templatediv.length > 0) {
                            $(Templatediv).remove();
                        }
                        $('#billPart_divtemplate').append('<div FeeID="' + FeeID + '">' + Items[k].IsTemplateText + '</div>');
}


                                            if (iPaymentAlreadyPresent == 0) {
                                                j++;
                                                HasTest = 'Y';

                                                if (IsOutSource == 'N') {
                                                    FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[2] + "~Descrip^" + defalutdata[1] +
                                                        "~Amount^" + defalutdata[3] + "~Quantity^" + 1 + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[7] +
                                                        "~IsReimbursable^" + defalutdata[6] + "~ActualAmount^" + defalutdata[8] + "~IsNormalRateCard^" + defalutdata[9] +
                                                        "~IsDiscountable^" + defalutdata[9] + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] +
                                                        "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + IsOutSource.data + "~IsNABL^" + defalutdata[14] +
                                                        "~BillingItemRateID^" + defalutdata[15] + "~Code^" + defalutdata[18] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + IsOutSourceLocation +
                                                        "~BaseRateID^" + defalutdata[19] + "~DiscountPolicyID^" + defalutdata[20] + "~DiscountCategoryCode^" + defalutdata[21] +
                                                        "~ReportDeliveryDate^" + defalutdata[22] + "~MaxDiscount^" + undefined + "~IsRedeem^" + undefined + "~RedeemAmount^" + undefined +
                                                        "~IsSpecialTest^" + Item.IsSpecialTest + "~Ishtmltab^" + Item.Ishtml + "~IsTemplateID^" + Item.TemplateID + "~IsMandatoryHis^" + IsMandatoryHis + "|";
                                                    //changes by arun added IsMandatoryHis - couldnt remove service
                                                }
                                                else {
                                                    FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[2] + "~Descrip^" + defalutdata[1] +
                                                        "~Amount^" + defalutdata[3] + "~Quantity^" + 1 + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[7] +
                                                        "~IsReimbursable^" + defalutdata[6] + "~ActualAmount^" + defalutdata[8] + "~IsNormalRateCard^" + defalutdata[9] +
                                                        "~IsDiscountable^" + defalutdata[9] + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] +
                                                        "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + "0" + "~IsNABL^" + defalutdata[14] +
                                                        "~BillingItemRateID^" + defalutdata[15] + "~Code^" + defalutdata[18] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + IsOutSourceLocation +
                                                        "~BaseRateID^" + defalutdata[19] + "~DiscountPolicyID^" + defalutdata[20] + "~DiscountCategoryCode^" + defalutdata[21] +
                                                        "~ReportDeliveryDate^" + defalutdata[22] + "~MaxDiscount^" + undefined + "~IsRedeem^" + undefined + "~RedeemAmount^" + undefined +
                                                        "~IsSpecialTest^" + Item.IsSpecialTest + "~Ishtmltab^" + Item.Ishtml + "~IsTemplateID^" + Item.TemplateID + "~IsMandatoryHis^" + IsMandatoryHis + "|";
                                                    //changes by arun added IsMandatoryHis - couldnt remove service
                                                }
                                                document.getElementById('billPart_hdfBillType1').value = (document.getElementById('billPart_hdfBillType1').value).replace(FeeViewStateValue, '');
                                                document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;

                                                // CreateBillItemsTable(0);
                                                //Co Paymnet//
                                                var BToBhdnCopay
                                                if (document.getElementById('HdnCoPay') != null) {
                                                    BToBhdnCopay = document.getElementById('HdnCoPay').value;
                                                }
                                                else {
                                                    BToBhdnCopay = 'N';
                                                }

                                                if (BToBhdnCopay == 'Y') {
                                                    Calc_Copayment();
                                                }
                                                //End Co Paymnet//
                                            }

                                            else {
                                                if (isAlert == 'Y') {
                                                    isAlert = 'N';
                                                    var objItem = SListForAppMsg.Get("Scripts_CommonBiling_js_25") == null ? "Item already added" : SListForAppMsg.Get("Scripts_CommonBiling_js_25");
                                                    ValidationWindow(objItem, objAlert);
                                                    //alert("Item already added");
                                                    //ClearSelectedData(0);
                                                    return false;
                                                }
                                            }
                                            //}
                                        }
                                    });
                                    if (HasTest == 'Y') {
                                        HasTest = 'N';
                                        CreateBillItemsTable(0);
                                        var FeeViewStateValue = '';
                                    }
                                },
                                failure: function(msg) {
                                    ShowErrorMessage(msg);
                                }
                            });
                        }
                    }
                }
            }
        }
    }
}

/*******Code commented and  Modified by Arivalagan.k Bcoz to awoid duplicate entey today ordered test*************/
//function IsItemChecked() {
//    var flag = 0;
//    var flagAlreadyToday = 0;
//    var tbl = document.getElementById('tblItems').rows.length;
//    var td = document.getElementById('tblItems');
//    if (tbl > 0) {
//        for (var i = 0; i < tbl - 1; i++) {
//            var cellcount = td.rows[i].cells.length;
//            if (cellcount > 1) {
//                var tdID = td.rows[i].cells[4].childNodes[0].id;
//                if (document.getElementById(tdID).checked == true) {
//                    var FeeID = td.rows[i].cells[2].childNodes[0];
//                    var FeeType = td.rows[i].cells[3].childNodes[0];
//                    var IsAddedToday = td.rows[i].cells[5].childNodes[0];
//                    var ItemArrayAlreadyToday = new Array();
//                    var resAlreadyToday = new Array();
//                    ItemArrayAlreadyToday = document.getElementById('hdnPreviousVisitDetails').value.split('^');
//                    for (j = 0; j < ItemArrayAlreadyToday.length; j++) {
//                        res = ItemArrayAlreadyToday[j].split('$');
//                        if (FeeID.data == res[1] && 'Y' == res[5] && FeeType.data == res[2]) {
//                            flagAlreadyToday++;
//                        }
//                    }

//                    flag++;
//                }
//            }
//        }
//    }

//    if (flag == 0) {
//        alert('Does not allowed to add  to click the checkbox');
//    }
//    else {
//        if (flagAlreadyToday > 0) {
//            if (window.confirm("Warning: The selected test already ordered today...!  Do you want to continue?")) {
//                flagAlreadyToday = 0;
//            }
//            else {
//                flagAlreadyToday = 1;
//            }
//        }
//        if (flagAlreadyToday == 0)
//            return true;
//        else
//            return false;
//    }
//}


function GetDiscountorRedeemDetails() {
    //debugger;
    var coupons = '';
    var bookingID = $('#hdnBookedID').val();
    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetPreRegistrationDiscountRedeemDetails",
        data: "{ bookingID: '" + bookingID + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            //debugger;
            if (data.d.length > 0) {
                if (data.d[0].HealthCardNos.length > 1) {

                    coupons = data.d[0].HealthCardNos;
                    var listCoupons = coupons.split(',');
                    for (var i = 0; i < listCoupons.length; i++) {
                        if (listCoupons[i].length > 1) {
                            $('#billPart_txtCardNo').val(listCoupons[i]);
                            GetMemberDetails('VerifyMember', 'CardNo');
                            // alert(i);
                            // ClickCardType('Redeem');
                        }
                    }

                    //debugger;
                    $('#billPart_txtGross').val(data.d[0].GrossBillValue);
                    $('#billPart_txtNetAmount').val(data.d[0].NetValue);
                    $('#billPart_txtAmtReceived').val(data.d[0].AmountReceived);
                    $('#billPart_txtDiscount').val(data.d[0].DiscountAmount);
                    $('#billPart_hdnNetAmount').val(data.d[0].NetValue);
                    $('#billPart_hdnAmountReceived').val(data.d[0].AmountReceived);
                    //$('#billPart_PaymentType_txtAmount').val(data.d[0].AmountReceived);
                    //$('#billPart_PaymentType_txtTotalAmount').val(data.d[0].AmountReceived);
                    document.getElementById('billPart_PaymentType_txtAmount').value = data.d[0].AmountReceived;
                    document.getElementById('billPart_PaymentType_txtTotalAmount').value = data.d[0].AmountReceived;

                    document.getElementById('billPart_PaymentType_txtAmount').innerText = data.d[0].AmountReceived;
                    document.getElementById('billPart_PaymentType_txtTotalAmount').innerText = data.d[0].AmountReceived;

                    if (data.d[0].AmountReceived > 0) {
                        changeAmountValues();
                        PaymentTypeValidation();
                    }

                }
                else {



                    var discountReason = data.d[0].DiscountReason;
                    //$('#billPart_ddDiscountPercent').val(discountReason).attr("selected", "selected");


                    $('#billPart_ddDiscountPercent option').map(function() {
                        if ($(this).val() == discountReason) return this;
                    }).attr('selected', 'selected');

                    SetDiscountAmt();
                    SetNetValue('ADD');
                    IsCheckMyCard();

                    var getPercentValue = 0;
                    // debugger;
                    if (data.d[0].DiscountType == "Percentage") {
                        $('#billPart_hdnDiscountPercentage').val(data.d[0].SlabPercentage);

                        getPercentValue = data.d[0].SlabPercentage + "~" + data.d[0].DiscountCode + "~" + data.d[0].SlabCeilingValue;
                        //$('#billPart_ddlSlab').val(getPercentValue).attr("selected", "selected");
                        $('#billPart_ddlSlab option').map(function() {
                            if ($(this).val() == getPercentValue) return this;
                        }).attr('selected', 'selected');
                    }
                    else if (data.d[0].DiscountType == "Value") {
                        $('#billPart_txtCeiling').val(data.d[0].UserDiscountValue);
                    }
                    //$('#billPart_ddlSlab').val(getPercentValue);
                    //$('#billPart_ddlSlab').val(percentvalue[0]).attr("selected", "selected");

                    SetNetValue('ADD');

                    document.getElementById('billPart_PaymentType_txtAmount').value = data.d[0].AmountReceived;
                    document.getElementById('billPart_PaymentType_txtTotalAmount').value = data.d[0].AmountReceived;
                    $('#billPart_txtAmtReceived').val(data.d[0].AmountReceived);
                    $('#billPart_hdnAmountReceived').val(data.d[0].AmountReceived);

//                    document.getElementById('billPart_PaymentType_txtAmount').innerText = data.d[0].AmountReceived;
//                    document.getElementById('billPart_PaymentType_txtTotalAmount').innerText = data.d[0].AmountReceived;

                    $('#billPart_hdnNetAmount').val(data.d[0].NetValue);
                    //                    $('#billPart_hdnAmountReceived').val(data.d[0].AmountReceived);
                    //                    $('#billPart_hdnDiscountValue').val(getPercentValue);
                    $('#billPart_txtGross').val(data.d[0].GrossBillValue);

                    if (data.d[0].AmountReceived > 0) {
                        changeAmountValues();
                        PaymentTypeValidation();
                    }
                    // changeAmountValues();
                    // PaymentTypeValidation();

                    // javascript: __doPostBack('billPart_PaymentType_addNewPayment', '');
                    // $("#billPart_PaymentType_addNewPayment").trigger("click");


                    //                    $('#billPart_PaymentType_addNewPayment').OnClientClick(function() {
                    //                    PaymentTypeValidation();
                    //                        return false;
                    //                    });
                    //$("#addNewPayment").click(return false;);
                    /*
                    // $("#billPart_ddDiscountPercent option:selected").val(discountReason);
                    document.getElementById('billPart_PaymentType_txtAmount').innerText = discountReason;
                    //data.d[0].SlabPercentage;

                    if (data.d[0].DiscountType == "Value") {

                        $('#billPart_txtCeiling').val(data.d[0].UserDiscountValue);
                    }
                    //txtCeiling

                    $('#billPart_txtGross').val(data.d[0].GrossBillValue);
                    $('#billPart_txtNetAmount').val(data.d[0].NetValue);
                    $('#billPart_txtAmtReceived').val(data.d[0].AmountReceived);
                    $('#billPart_txtDiscount').val(data.d[0].DiscountAmount);
                    $('#billPart_PaymentType_txtAmount').val(data.d[0].AmountReceived);
                    $('#billPart_hdnNetAmount').val(data.d[0].NetValue);
                    $('#billPart_PaymentType_txtTotalAmount').val(data.d[0].AmountReceived);
                    $('#billPart_hdnAmountReceived').val(data.d[0].AmountReceived);
                    $('#billPart_PaymentType_txtAmount').val(data.d[0].AmountReceived);
                    document.getElementById('billPart_PaymentType_txtAmount').value = data.d[0].AmountReceived;
                    document.getElementById('billPart_PaymentType_txtTotalAmount').value = data.d[0].AmountReceived;

                    document.getElementById('billPart_PaymentType_txtAmount').innerText = data.d[0].AmountReceived;
                    document.getElementById('billPart_PaymentType_txtTotalAmount').innerText = data.d[0].AmountReceived;
                    //  var percentvalue = '5~SPAPPR01~20000';
                    //$('#billPart_ddlSlab').val(percentvalue);

                    $('#billPart_hdnDiscountValue').val(getPercentValue);
                    getPercentValue = getPercentValue + '*' + discountReason;
                    $('#billPart_hdnDiscountValue').val(getPercentValue);



                    $('#billPart_txtGross').val(data.d[0].GrossBillValue);
                    $('#billPart_txtNetAmount').val(data.d[0].NetValue);
                    $('#billPart_txtAmtReceived').val(data.d[0].AmountReceived);
                    $('#billPart_txtDiscount').val(data.d[0].DiscountAmount);
                    $('#billPart_PaymentType_txtAmount').val(data.d[0].AmountReceived);
                    $('#billPart_hdnNetAmount').val(data.d[0].NetValue);
                    $('#billPart_PaymentType_txtTotalAmount').val(data.d[0].AmountReceived);
                    $('#billPart_hdnAmountReceived').val(data.d[0].AmountReceived);
                    $('#billPart_PaymentType_txtAmount').val(data.d[0].AmountReceived);
                    document.getElementById('billPart_PaymentType_txtAmount').value = data.d[0].AmountReceived;
                    document.getElementById('billPart_PaymentType_txtTotalAmount').value = data.d[0].AmountReceived;

                    document.getElementById('billPart_PaymentType_txtAmount').innerText = data.d[0].AmountReceived;
                    document.getElementById('billPart_PaymentType_txtTotalAmount').innerText = data.d[0].AmountReceived;

                    changeAmountValues();
                    PaymentTypeValidation();
                    */



                }

                //debugger;

            }

        },
        failure: function(msg) {
            alert(msg);
        }
    });
    // GetMemberDetails_MyTestPraba(coupons);
    document.getElementById('hdnPatientID').value = "-1";
    return false;

}

var Type;
var CardType;
function GetMemberDetails_MyTestPraba(coupons) {
    //debugger;
    Type = "VerifyMember";
    CardType = "CardNo";
    var couponList = coupons.split(',');
    for (var iii = 0; iii < couponList.length; iii++) {
        /* if (iii == 0) {
        $('#billPart_txtCardNo').val('16819919871');
        }
        if (iii == 1) {
        $('#billPart_txtCardNo').val('29287043420');
        }*/

        $('#billPart_txtCardNo').val(couponList(iii));
        var cardNoValidate = false;
        $('#cardPoints tr').each(function(i, n) {
            if (i == 0) {
            }
            else {
                var $row = $(n);
                var lblCardNo = $row.find($('span[id$="lblCardNo"]')).html();
                if (lblCardNo == $('#billPart_txtCardNo').val()) {
                    cardNoValidate = true;
                }

            }
        });
        if (cardNoValidate) {
            alert('Please enter different card No.');
            return false;
        }

        $("#billPart_hdnmyCardDetailsbill").val("");
        if (CardType == 'CardNo') {
            var MemberCardNo = $('#billPart_txtCardNo').val();
        }
        else if (CardType == 'MobileNo') {
            var MemberCardNo = $('#billPart_txtMobileNo').val();
        }
        else {
            var MemberCardNo = $('#billPart_txtCardNo').val();
        }
        var PatientIdLab = $('#hdnPatientID').val();
        $('#billPart_lblCardStatus').text('');

        var MembershipCardMappingID;
        var PatientID;
        var MembershipCardNo;
        var CreditPoints;
        var CreditValue;
        var Status;

        var lstMycardDetails = [];
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetMemberDetails",
            data: JSON.stringify({ MemberCardNo: MemberCardNo, CardType: CardType, Type: Type }),
            dataType: "json",
            async: false,
            success: function(data) {

                if (data.d.length > 0) {
                    //debugger;
                    var lstPatientHealthCard = data.d;
                    if (data.d[0].CreditRedeemTye == "Redeem") {
                        $("#billPart_txtCardNo").val("");
                        $("#billPart_txtCardNo").focus();
                        alert("This coupon has already been redeemed on " + data.d[0].HasHealthCard + " for  VID No " + data.d[0].VisitID);
                        return false;
                    }


                    if (data.d[0].TotalCreditValue == 0) {
                        $("#billPart_txtCardNo").val("");
                        $("#billPart_txtCardNo").focus();
                        alert("Health coupon no is invalid.");
                        return false;
                    }


                    if (Type == 'VerifyMember') {
                        $("#billPart_hdnmyCardDetailsbill").val(data.d[0].MembershipCardMappingID + "~" + data.d[0].PatientID + "~" + data.d[0].TotalCreditPoints + "~" + data.d[0].TotalCreditValue);
                        var listVal = [];
                        if ($("#billPart_hdnMycardDetails").val() != "") {
                            listVal = JSON.parse($("#billPart_hdnMycardDetails").val());
                        }
                        for (i = 0; i < lstPatientHealthCard.length; i++) {
                            Status = lstPatientHealthCard[i].Status.trim();
                        }

                        if (Status == "Active") {
                            $.each(lstPatientHealthCard, function(i, obj) {

                                PatientID = data.d[i].PatientID;
                                $('#billPart_hdnExistingPatientID').val(PatientID);
                                CreditPoints = data.d[i].TotalCreditPoints;
                                CreditValue = data.d[i].TotalCreditValue;
                                MembershipCardMappingID = data.d[i].MembershipCardMappingID;
                                $('#billPart_hdnMembershipCardMappingID').val(MembershipCardMappingID);
                            });

                            lstMycardDetails.push({
                                MembershipCardMappingID: MembershipCardMappingID,
                                TotalRedemPoints: CreditPoints,
                                TotalRedemValue: CreditValue,
                                PatientID: PatientID

                            });

                        }
                        else {
                            $('#billPart_lblCardStatus').text('Your Card Is Not Activated');
                            $('#billPart_lblCardStatus').css("color", "Red");
                        }
                        if (listVal.length > 0) {
                            lstMycardDetails.push(listVal[0]);
                        }
                        $('#billPart_hdnMycardDetails').val(JSON.stringify(lstMycardDetails));
                        if (PatientID > 0 && PatientID != 0) {
                            $('#billPart_lblCreditPoints').text(CreditPoints);
                            $('#billPart_lblCreditValue').text(CreditValue);
                            $('#dvPoints').hide();
                            $('#trCreditPoints').css("display", "none");
                            $('#trCreditAmount').css("display", "");
                            if ($('#billPart_txtCardNo').val() != "") {
                                $("input#billPart_chkRedeem").attr('checked', true);
                                ClickCardType('Redeem');

                            }
                            else {
                                $("input#billPart_chkRedeem").attr('checked', false);
                            }
                        }
                        else {
                            $('#dvPoints').hide();
                            $('#trCreditPoints').css("display", "none");
                            $('#trCreditAmount').css("display", "none");
                        }
                    }
                }


                else if (Type == 'OTP') {
                    for (i = 0; i < lstPatientHealthCard.length; i++) {
                        Status = lstPatientHealthCard[i].Status.trim();
                    }
                    if (status == "Active") {
                        alert('Your card is activated');
                    }
                    else { alert('Your card is not activated'); }

                }
                else {
                    $('#DvRedeemOnetimePassword').hide();
                    $("input#billPart_chkRedeem").attr('checked', false);
                    $("input#billPart_chkCredit").attr('checked', false);
                    alert('No data found');
                }





            },
            error: function(result) {
                alert("Error");
            }
        });
    }

}


function AddPreviousVisitItemsToBillingNew() {
    //debugger;
    // if (IsItemChecked()) {
    var ss = document.getElementById('hdnPreviousVisitDetails').value;
    var OrgID = document.getElementById('hdnOrgID').value;
    CallBillItems(OrgID);
    var tbl = document.getElementById('tblItems').rows.length;
    var td = document.getElementById('tblItems');
    var rate = document.getElementById('txtClient').value;
    var pretex = new Array();
    var idv = new Array();
    if (tbl > 1) {
        var j = 0;
        var x = -1;
        for (var i = 1; i < tbl - 1; i++) {
            var cellcount = td.rows[i].cells.length;
            if (cellcount > 1) {
                var tdID = td.rows[i].cells[4].childNodes[0].id;
                if (document.getElementById(tdID).checked == false) {
                    x++;
                    var testName = td.rows[i].cells[1].childNodes[0];
                    var id = td.rows[i].cells[2].childNodes[0];
                    var FeeType = td.rows[i].cells[3].childNodes[0];
                    var IsOutSource = td.rows[i].cells[6].childNodes[0];
                    var pBookingID = 0;
                    if (document.getElementById('hdnBookedID').value != '0') {
                        var TestCode = td.rows[i].cells[8].childNodes[0];
                        pBookingID = document.getElementById('hdnBookedID').value;
                    }
                    else {
                        var TestCode = td.rows[i].cells[7].childNodes[0];
                    }
                    idv[x] = td.rows[i].cells[2].childNodes[0];
                    if (testName.data != "Test Name") {
                        var prefixText = testName.data;
                        pretex[x] = testName.data;
                        var autoComplete = $find('billPart_AutoCompleteExtender3');
                        $.ajax({
                            type: "POST",
                            url: "../OPIPBilling.asmx/GetBillingItemsDetails",
                            data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, FeeID: id.data, FeeType: FeeType.data, Description: testName.data, ClientID: document.getElementById('hdnSelectedClientClientID').value, VisitID: 0, Remarks: '', IsCollected: document.getElementById('billPart_hdnIsCollected').value, CollectedDatetime: document.getElementById('billPart_hdnCollectedDateTime').value, locationName: document.getElementById('billPart_hdnLocName').value, BookingID: pBookingID }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function(data) {
                                var Items = data.d;
                                $.each(Items, function(index, Item) {
                                    var valu;
                                    for (var k = 0; k < Items.length; k++) {
                                        valu = Items[k].ProcedureName;
                                        for (var m = 0; m < pretex.length; m++) {
                                            var idvalu = valu.split('^');

                                            var defalutdata = valu.split('^');
                                            //debugger;
                                            FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[2] + "~Descrip^" + defalutdata[1] +
                                                                        "~Amount^" + defalutdata[3] + "~Quantity^" + 1 + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[7] +
                                                                        "~IsReimbursable^" + defalutdata[6] + "~ActualAmount^" + defalutdata[8] + "~IsNormalRateCard^" + defalutdata[9] + "~IsDiscountable^" + defalutdata[9]
                                                                         + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13]
                                                                         + "~IsOutSource^" + "0" + "~IsNABL^" + defalutdata[14] + "~BillingItemRateID^" + defalutdata[15]
                                                                          + "~Code^" + defalutdata[18] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + defalutdata[17] + "~BaseRateID^" + defalutdata[19]
                                                                           + "~DiscountPolicyID^" + defalutdata[20] + "~DiscountCategoryCode^" + defalutdata[21]
                                                                            + "~ReportDeliveryDate^" + defalutdata[22] + "~MaxDiscount^" + defalutdata[23] + "~IsRedeem^" + defalutdata[25] + "~RedeemAmount^" + defalutdata[26]  //+ "|";
																			//cahngesby arun - can't delete investigation added frm rit corner box
																			+ "~IsSpecialTest^" + Item.IsSpecialTest + "~Ishtmltab^" + Item.Ishtml + "~IsTemplateID^" + Item.TemplateID + "~IsMandatoryHis^" + IsMandatoryHis + "|";


                                            document.getElementById('billPart_hdfBillType1').value = (document.getElementById('billPart_hdfBillType1').value).replace(FeeViewStateValue, '');
                                            document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;
                                            j++;


                                        }
                                    }


                                });
                                if (j >= (pretex.length)) {
                                    CreateBillItemsTable(0);
                                    AddHistoryDetail();
                                    var FeeViewStateValue = '';
                                }

                            },
                            failure: function(msg) {
                                ShowErrorMessage(msg);
                            }

                        });
                    }
                }
            }
        }
    }
    // }
}


function IsItemChecked() {
    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var vNotAllowedCheckbox = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_02') == null ? "Does not allowed to add  to click the checkbox" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_02');
    var vAlreadyOrdered = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_03') == null ? "This test already ordered...! Not allow to order for this test" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_03');
    var vWarning = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_04') == null ? "Warning: The selected test already ordered today...!  Do you want to continue?" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_04');
    var flag = 0;
    var OkMsg = SListForAppMsg.Get('Scripts_Ok') == null ? "OK" : SListForAppMsg.Get('Scripts_Ok');
    var CancelMsg = SListForAppMsg.Get('Scripts_Cancel') == null ? "Cancel" : SListForAppMsg.Get('Scripts_Cancel');
    var Information = SListForAppMsg.Get('Scripts_Information') == null ? "Information" : SListForAppMsg.Get('Scripts_Information');
    var error = SListForAppMsg.Get('Scripts_Error') == null ? "Alert" : SListForAppMsg.Get('Scripts_Error'); var flag = 0;
    var flagAlreadyToday = 0;
    var tbl = document.getElementById('tblItems').rows.length;
    var td = document.getElementById('tblItems');
    var LabNo;
    if (document.getElementById('hdnDoFrmVisit') != null) {
        LabNo = $('#hdnDoFrmVisit').val();
    }
    if (tbl > 0) {
        for (var i = 0; i < tbl - 1; i++) {
            var cellcount = td.rows[i].cells.length;
            if (cellcount > 1) {
                var tdID = td.rows[i].cells[4].childNodes[0].id;
                if (document.getElementById(tdID).checked == true) {
                    if (tdID == "chkAll") { i = 2; }
                    var FeeID = td.rows[i].cells[2].childNodes[0];
                    var FeeType = td.rows[i].cells[3].childNodes[0];
                    var IsAddedToday = td.rows[i].cells[5].childNodes[0];
                    var ItemArrayAlreadyToday = new Array();
                    var resAlreadyToday = new Array();
                    ItemArrayAlreadyToday = document.getElementById('hdnPreviousVisitDetails').value.split('^');
                    for (j = 0; j < ItemArrayAlreadyToday.length; j++) {
                        res = ItemArrayAlreadyToday[j].split('$');
                        /// if (FeeID.data == res[1] && 'Y' == res[5] && FeeType.data == res[2]) {\
                        if (FeeID.data == res[1] && LabNo == res[9] && FeeType.data == res[2]) {
                            flagAlreadyToday++;
                        }
                    }
                    flag++;
                }
            }
        }
    }

    if (flag == 0) {
        //alert('Does not allowed to add  to click the checkbox');
        ValidationWindow(vNotAllowedCheckbox, AlertType);
    }
    else {
        /*******Code commented and  Modified by Arivalagan.k Bcoz to awoid duplicate entey today ordered test*************/
        //        if (flagAlreadyToday == 1) {
        //            if (window.confirm("Warning: The selected test already ordered today...!  Do you want to continue?")) {
        //                flagAlreadyToday = 0;
        //            }
        //            else {
        //                flagAlreadyToday = 1;
        //            }
        //        }
        //        if (flagAlreadyToday == 0)
        //            return true;
        //        else
        //            return false;

        var selectedText = $("#ddlVisitDetails option:selected").text();
        var searchtype;
        var searchtypeRadioList;
        if (document.getElementsByName('rblSearchType') != null) {
            searchtypeRadioList = document.getElementsByName('rblSearchType');
            for (var i = 0; i < searchtypeRadioList.length; i++) {
                if (searchtypeRadioList[i].checked) {
                    searchtype = searchtypeRadioList[i].value
                    break;
                }
            }
        }
        //if (flagAlreadyToday == 1 && selectedText == "Today's Visit") {
        if (flagAlreadyToday >= 1 && searchtype != '3' && searchtype != '5') {
            // alert('This test already ordered...! Not allow to order for this test');
            ValidationWindow(vAlreadyOrdered, AlertType);
            return false;
        }
        else if (flagAlreadyToday >= 1 && selectedText == 'New Visit') {
        if (ConfirmWindow("" + vWarning + "")) {
                flagAlreadyToday = 0;
            }
            else {
                flagAlreadyToday = 1;
            }
        }
        else {
            return true;
        }
        if (flagAlreadyToday == 0) {
            return true;
        }
        else {
            return false;
        }
        /*******End Code commented and  Modified by Arivalagan.k Bcoz to awoid duplicate entey today ordered test*************/
    }
}
var found = false;
function SelectedClientPatientForDoFromVisit(source, eventArgs) {
    //debugger;
    var vPatientDetails = SListForAppDisplay.Get("Billing_CommonBilling_js_69") == null ? "Patient Details" : SListForAppDisplay.Get("Billing_CommonBilling_js_69")
    var vPatientNo = SListForAppDisplay.Get("Billing_CommonBilling_js_68") == null ? "Patient No:" : SListForAppDisplay.Get("Billing_CommonBilling_js_68")
    var isPatientDetails = "";
    if (document.getElementById('hdnDifferSanpleforDFV').value == "Y") {
        document.getElementById('hdnDOFromVisitFlag').value = 2;
    }
    else {
        document.getElementById('hdnDOFromVisitFlag').value = 1;
    }
    isPatientDetails = eventArgs.get_value().split('|')[0];
    //changes by arun
   // debugger;
    var vlstOutput = isPatientDetails.split('~');
    
    for (var i = 0; i < vlstOutput.length && !found; i++) {
        if (vlstOutput[i].indexOf("TRFAVAIL") > -1) {
          //  debugger;
            found = true;
            break;
        }
    }
//
    var PatientName = eventArgs.get_text().split(':')[0];
    var PatientNumber = isPatientDetails.split('~')[43];
    var PatientVisitType = isPatientDetails.split('~')[44];

    var PatientTITLECode = isPatientDetails.split('~')[0];
    var PatientAge = isPatientDetails.split('~')[3];
    var PatientDOB = isPatientDetails.split('~')[4];
    var PatientSex = isPatientDetails.split('~')[5];
    var PatientMaritalStatus = isPatientDetails.split('~')[6];
    var PatientMobile = isPatientDetails.split('~')[7].split(',')[0].trim();
    if (isPatientDetails.split('~')[7].split(',')[1] != null) {
        var PatientPhone = isPatientDetails.split('~')[7].split(',')[1].trim();
    }
    var PatientAddress = isPatientDetails.split('~')[8];
    var PatientCity = isPatientDetails.split('~')[9];
    var PostalCode = isPatientDetails.split('~')[10];
    var PatientNationality = isPatientDetails.split('~')[11];
    var PatientCountryID = isPatientDetails.split('~')[12];
    var PatientStateID = isPatientDetails.split('~')[13];
    var PatientID = isPatientDetails.split('~')[14];
    var PatientEmailID = isPatientDetails.split('~')[15];
    var URNNo = isPatientDetails.split('~')[16];
    var URNofId = isPatientDetails.split('~')[17];
    var URNTypeId = isPatientDetails.split('~')[18];
    var VisitPurpose = 3
    var PatientPreviousDue = isPatientDetails.split('~')[19];
    var Suburban = isPatientDetails.split('~')[20];
    var ExternalPatientNumber = isPatientDetails.split('~')[21];
    var PatientType = isPatientDetails.split('~')[22];
    var PatientStatus = isPatientDetails.split('~')[23];
    var NewOrgID = isPatientDetails.split('~')[24];
    // var ClientName = isPatientDetails.split('~')[26];
    var PAtientVisitID = isPatientDetails.split('~')[30];
    document.getElementById('hdnDoFrmVisit').value = PAtientVisitID;
    var PhleboName = isPatientDetails.split('~')[35];
    var PhleboID = isPatientDetails.split('~')[36];
    var RoundNo = isPatientDetails.split('~')[37];
    var ExAutoAuthorization = isPatientDetails.split('~')[38];
    var LogisticsID = isPatientDetails.split('~')[39];
    var LogisticsName = isPatientDetails.split('~')[40];
    var ZoneName = isPatientDetails.split('~')[46];
    var ZoneID = isPatientDetails.split('~')[45];
    var DispatchType = isPatientDetails.split('~')[29];
    var SRFID = isPatientDetails.split('~')[52];
    var TRFID = isPatientDetails.split('~')[53];
    var Passportno = isPatientDetails.split('~')[54];
    document.getElementById('txtpassportno').value = Passportno;
    document.getElementById('txtLogistics').value = LogisticsName;
    document.getElementById('hdnLogisticsName').value = LogisticsName;
    document.getElementById('txtRoundNo').value = TRFID!=''?TRFID:RoundNo;
    document.getElementById('hdnLogisticsID').value = LogisticsID;
    document.getElementById('hdnEditDDlDOB').value = PatientAge.split(' ')[1];
    document.getElementById('hdnPatientAge').value = PatientAge.split(' ')[0];
    document.getElementById('hdnEdtPatientAge').value = PatientAge.split(' ')[0];
    document.getElementById('hdnPatientDOB').value = PatientDOB;
    document.getElementById('hdnPatientSex').value = PatientSex;
    document.getElementById('txtPhleboName').value = PhleboName;
    document.getElementById('HdnPhleboID').value = PhleboID;
    document.getElementById('HdnPhleboName').value = PhleboName;
    document.getElementById('tDOB').value = PatientDOB;
    document.getElementById('txtWardNo').value = SRFID != '' ? SRFID : "";
    if (DispatchType != undefined) {
    }
    if (DispatchType != undefined) {
        var LstDispatchedtype = DispatchType.split(",");
        for (var j = 0; j < LstDispatchedtype.length; j++) {
            $('[id$="chkDespatchMode"] input[type=checkbox]').each(function(i) {
                if (($("#" + $(this).filter().context.id).next().text()) == LstDispatchedtype[j]) {
                    this.checked = true;
                }
            });
        }
    }
    if (document.getElementById('chkExcludeAutoathz') != null) {
        if (ExAutoAuthorization == 'Y') {
            document.getElementById('chkExcludeAutoathz').checked = true;
        }
        else {
            document.getElementById('chkExcludeAutoathz').checked = false;
        }
    }
    var ClientntName = isPatientDetails.split('~')[41];
    var ClientID = isPatientDetails.split('~')[42];
    document.getElementById('hdnSelectedClientClientID').value = ClientID;
    //Added By Arivalagan.kk
    if (document.getElementById('txtDoFrmVisitNumber') != null) {
        if (document.getElementById('txtDoFrmVisitNumber').value != '') {
            document.getElementById('txtClient').disabled = true;
        }
    }
    document.getElementById('txtClient').value = ClientntName;
    document.getElementById('hdnSelectedClientName').value = ClientntName;
    //Modified by arivalagan.kk for copayment//
    /**Co pay*/
    if (document.getElementById('HdnCoPay') != null) {
        var Iscopay = isPatientDetails.split('~')[47];
        document.getElementById('HdnCoPay').value = Iscopay;
        DisplayCoPayMent();
    }
    /*End*Co pay*/
    //End Modified by arivalagan.kk for copayment//
    //  document.getElementById('hdnBookedID').value = isPatientDetails.split('~')[26];
    if (URNNo != "" && URNTypeId == 6) {
        SetDiscountLimit(URNNo);
    }
    if (URNNo != "" && URNTypeId != 6) {
        document.getElementById('txtURNo').value = URNNo;
        document.getElementById('ddlUrnoOf').value = URNofId;
        document.getElementById('ddlUrnType').value = URNTypeId;
     }

    document.getElementById('ddSalutation').value = PatientTITLECode
    document.getElementById('txtName').value = PatientName;
    document.getElementById('hdnPatientNumber').value = PatientNumber
    document.getElementById('hdnPatientEmailId').value = PatientEmailID;
    document.getElementById('hdnReferringDoctor').value = ReferingPhysicianName;
    document.getElementById('hdnDOBMonth').value = PatientDOB;
    document.getElementById('hdnPhoneNo').value = PatientPhone;
    document.getElementById('hdnMobileNo').value = PatientMobile;
    document.getElementById('hdnPatientAddress').value = PatientAddress;
    document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
    document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
    document.getElementById('ddlSex').value = PatientSex;
    if (document.getElementById('hdnEditSex') != null) {
        document.getElementById('hdnEditSex').value = PatientSex;
    }

    document.getElementById('ddMarital').value = PatientMaritalStatus;
    document.getElementById('txtMobileNumber').value = PatientMobile;
    document.getElementById('txtPhone').value = PatientPhone;
    document.getElementById('hdnddlsalutation').value = PatientTITLECode;
    if (PatientPhone != null) {
        // document.getElementById('txtPhone').value = PatientPhone;
    }
    //document.getElementById('txtAddress').value = PatientAddress.trim();
    //document.getElementById('txtCity').value = PatientCity;
    if (PatientNationality != '') {
        if (document.getElementById('ddlNationality') != null) {
            document.getElementById('ddlNationality').value = PatientNationality;
        }
    }
    document.getElementById('ddCountry').value = PatientCountryID;
    //document.getElementById('ddCountry').onchange();
    document.getElementById('hdnPatientStateID').value = PatientStateID;
    document.getElementById('ddState').value = PatientStateID;
    if (PatientStateID == "") {
        loadState("11");
    }
    document.getElementById('hdnPatientID').value = PatientID;
    var textBox = $get('tDOB');
    //    if (textBox.AjaxControlToolkitTextBoxWrapper) {
    //        textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
    //    }
    //    else {
    //        textBox.value = PatientDOB;
    //    }
    //document.getElementById('txtPincode').value = PostalCode;
    document.getElementById('txtEmail').value = PatientEmailID;
    //document.getElementById('txtURNo').value = URNNo;
    //document.getElementById('hdnNewOrgID').value = NewOrgID;
    /////document.getElementById('ddlUrnoOf').value = URNofId;
    //document.getElementById('ddlUrnType').value = URNTypeId;
    //document.getElementById('lblPatientDetails').innerHTML = '';
    //document.getElementById('trPatientDetails').style.display = "none";
    if (document.getElementById('txtClient') != null) {
        document.getElementById('txtClient').focus();
    }
    //Getdigitalnumber(document.getElementById('lblPreviousDueText'), PatientPreviousDue);
    if (document.getElementById('billPart_lblPreviousDueText') != null) {
        document.getElementById('billPart_lblPreviousDueText').innerHTML = PatientPreviousDue;
        document.getElementById('hdnpreviousdue').value = PatientPreviousDue;
    }
    if (document.getElementById('txtSuburban') != null) {
        document.getElementById('txtSuburban').value = Suburban;
    }
    if (document.getElementById('txtExternalPatientNumber') != null) {
        document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
    }
    var panelLegend = $('#PnlPatientDetail legend');
    panelLegend.html(vPatientDetails).append('<b>(' + vPatientNo + PatientNumber + ')</b>');
    //panelLegend.html("Patient Details ").append('<b>(Patient No: ' + PatientNumber + ' )</b>');
    document.getElementById('PnlPatientDetail');
    document.getElementById('hdnPatientName').value = PatientName;
    document.getElementById('hdnPatientEmailId').value = PatientEmailID;
    document.getElementById('hdnReferringDoctor').value = ReferingPhysicianName;
    document.getElementById('hdnDOBMonth').value = PatientDOB;
    document.getElementById('hdnPhoneNo').value = PatientPhone;
    document.getElementById('hdnMobileNo').value = PatientMobile;
    document.getElementById('hdnPatientAddress').value = PatientAddress;
    document.getElementById('hdnPatientID').value = PatientID;
    LoadPreviousBillingItemsForClientPatient();
    document.getElementById('hdnPatientID').value = PatientID;
    var ReferingPhysicianName = isPatientDetails.split('~')[25];
    var HospitalName = isPatientDetails.split('~')[26];
    if (HospitalName != undefined) {
        document.getElementById('txtInternalExternalPhysician').value = ReferingPhysicianName;
    }
    if (ReferingPhysicianName != undefined) {
        document.getElementById('txtReferringHospital').value = HospitalName;
    }

    /// This  function added by arivalagan.k for do from visit patient details freeze*********//

    if (document.getElementById('hdnDofromVisitfreeze') != null) {
        if (document.getElementById('hdnDofromVisitfreeze').value == "Y") { DofromVisitfreeze(); }
    }
    /// This  function added by arivalagan.k for do from visit patient details freeze*********//
    //EnabledFalse();
}
/// This  function cheanged by arivalagan.k on 27-04-2015
function LoadPreviousBillingItemsForPatient() {
    if (document.getElementById('hdnPreviousVisitDetails') != null) {
        document.getElementById('hdnPreviousVisitDetails').value = ''; //$('[id$="hdnPreviousVisitDetails"]').val(""); 
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetPreviousVisitBilling",
            data: "{ 'PatientID': '" + parseInt(document.getElementById('hdnPatientID').value) + "','VisitID': '" + parseInt(0) + "','Type': ''}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var ArrayItems = data.d;
                var Items = ArrayItems[0];
                $.each(Items, function(index, Item) {
                    document.getElementById('hdnPreviousVisitDetails').value += Item.FeeDescription + '$'
                    + Item.FeeId + '$'
                    + Item.FeeType + '$'
                    + Item.Address + '$'
                    + Item.PatientHistory + '$'
                    + Item.Status + '$'
                    + Item.IsOutSource + '$'
                    + Item.ServiceCode + '$'
                    + Item.IsAVisitPurpose + '$'
                    + Item.VisitID + '$'
                    + Item.LabNo + '$'
                    + Item.CoPayType + '$'
                    + Item.BatchNo + '$'
                    + Item.Comments + '$'
                    + Item.RejectReason + '$'
                    + '^';
                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
                    document.getElementById('hdnExBarcodeExpiry').value = Item.Comments;
                });

                SetPreviousVisitItems();
                //alert(Items);
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }
}
/// This  function cheanged by arivalagan.k on 27-04-2015
function LoadBookedpatientDetails() {

    if (document.getElementById('hdnPreviousVisitDetails') != null) {
        document.getElementById('hdnPreviousVisitDetails').value = ''; //$('[id$="hdnPreviousVisitDetails"]').val(""); 

        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetBookingOrderDetails",
            data: "{ 'BookingId': '" + parseInt(document.getElementById('hdnBookedID').value) + "','OrgId': '" + parseInt(document.getElementById('hdnOrgID').value) + "','LocationId':'" + parseInt(0) + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                $.each(Items, function(index, Item) {
                document.getElementById('hdnPreviousVisitDetails').value += Item.Name + '$' + Item.ID + '$' + Item.Type + '$' + Item.SourceType + '$' + "" + '$' + "" + '$' + Item.FeeType + '$' + "0" + '$' + "" + '$' + "" + '$' + Item.CollectionAddress + '^';
                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
                });

                SetBookedItems();
                //alert(Items);
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }
}
function LoadBookedpatientDetailsForHealthiAPI() {

    if (document.getElementById('hdnPreviousVisitDetails') != null) {
        document.getElementById('hdnPreviousVisitDetails').value = ''; //$('[id$="hdnPreviousVisitDetails"]').val(""); 

        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetBookingOrderDetails",
            data: "{ 'BookingId': '" + parseInt(document.getElementById('hdnHealthiBookingID').value) + "','OrgId': '" + parseInt(document.getElementById('hdnOrgID').value) + "','LocationId':'" + parseInt(0) + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                $.each(Items, function(index, Item) {
                    document.getElementById('hdnPreviousVisitDetails').value += Item.Name + '$' + Item.ID + '$' + Item.Type + '$' + Item.SourceType + '$' + "" + '$' + "" + '$' + Item.FeeType + '$' + "0" + '$' + "" + '$' + "" + '$' + Item.CollectionAddress + '^';
                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
                });

                SetBookedItems();
                //alert(Items);
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }
}
function OpenBillPrint(url) {
    window.open(url + " &duplicateBill=N", "billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
}

function OpenBillPrint_Check(url) {
   //ConfigBased call this Method
    window.open(url + " &duplicateBill=Y", "dupbillprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
}
function OpenBillPrint1(url, url1) {
    window.open(url, "billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
    window.open(url1, "billprint1", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
}

function CheckExistingURN1(ctl) {
    if (document.getElementById('hdnDiscountLimitType') != null) {
        document.getElementById('hdnDiscountLimitType').value = '';
    }
    if (document.getElementById('hdnUrn').value == '0') {
        if (document.getElementById('txtURNo').value != '' && document.getElementById('ddlUrnType').value != '0') {
            WebService.GetURN(document.getElementById('ddlUrnType').value, document.getElementById('txtURNo').value, GetURN1);
            if (document.getElementById('hdnDiscountLimitType') != null) {
                document.getElementById('hdnDiscountLimitType').value = '';
            }
            if (document.getElementById('ddlUrnType').value == 6) {
                SetDiscountLimit(document.getElementById('txtURNo').value);
            }
        }
    }

}
function GetURN1(URnList) {
    if (URnList.length > 0) {
        if (document.getElementById('ddlUrnType').value != 6) {
            alert('Already exist in this URN type');
            document.getElementById('txtURNo').value = "";
            document.getElementById('txtURNo').focus();
            return false;
        }
    }
}
function SetDiscountLimit(ReferID) {

    if (ReferID != "") {
        var PhysicianID = -1;
        PhyType = "EMPL";
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetDiscountLimit",
            data: "{ 'ReferType': '" + ReferID + "','ReferID': '" + PhysicianID + "','llNo': '" + "','orgID': '" + parseInt(document.getElementById('hdnOrgID').value) + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {

                if (data.d.length >= 1) {
                    if (data.d[0].GrossBillValue > 0) {
                        $('[id$="hdnDiscountLimitAmt"]').val(data.d[0].GrossBillValue);
                        $('[id$="hdnSumDiscountAmt"]').val(data.d[0].DiscountAmount);
                        $('[id$="hdnAvailableDiscountAmt"]').val(data.d[0].NetValue);
                        $('[id$="hdnDiscountLimitType"]').val(PhyType);
                    }
                    //alert('Discount Limit: ' + data.d[0].GrossBillValue + ' Total Discount: ' + data.d[0].DiscountAmount + ' Avialable Balance: ' + data.d[0].NetValue);
                }
            },
            failure: function(msg) {
                alert(msg);
            }
        });
    }
}
function setRate(id) {
    if (id > 0) {
        document.getElementById("hdnSelectedClientRateID").value = id;
    }
}
function clearPageControlsValue(ClearType) {
    var vPatientDetails = SListForAppDisplay.Get("Billing_CommonBilling_js_69") == null ? "Patient Details" : SListForAppDisplay.Get("Billing_CommonBilling_js_69")
    var vPatientNo = SListForAppDisplay.Get("Billing_CommonBilling_js_68") == null ? "Patient No:" : SListForAppDisplay.Get("Billing_CommonBilling_js_68")
    if (document.getElementById('billPart_hdnCpedit').value != null) {
        if (document.getElementById('billPart_hdnCpedit').value != "Y") {
            if (document.getElementById('hdnIsEditMode') != null) {
                if (document.getElementById('hdnIsEditMode').value == 'N') {
                    if (ClearType == "N") {
                        document.getElementById('txtName').value = '';
                        if (document.getElementById('txtName') != null) {
                            try {
                                //document.getElementById('txtName').focus();
                            }
                            catch (err) { }
                        }
                    }
                    if (document.getElementsByName('rblSearchType') != null) {
                        var searchtypeRadioList = document.getElementsByName('rblSearchType');
                        for (var i = 0; i < searchtypeRadioList.length; i++) {
                            if (searchtypeRadioList[i].checked) {
                                searchtype = searchtypeRadioList[i].value
                                break;
                            }
                        }
                        if (searchtype == 4) {
                            document.getElementById('txtName').setAttribute('autocomplete', 'off');
                            if ($find('AutoCompleteExtenderPatient') != null) {
                                $find('AutoCompleteExtenderPatient').set_contextKey('');
                            }
                        }
                    }
                    document.getElementById('billPart_lblPreviousDueText').innerHTML = "0.00";
                    document.getElementById('tDOB').value = "dd//MM//yyyy";
                    document.getElementById('txtMobileNumber').value = "";
                    document.getElementById('txtPhone').value = "";
                    document.getElementById('txtAddress').value = "";
                    document.getElementById('txtPincode').value = "";
                    document.getElementById('txtCity').value = "";
                    document.getElementById('txtDOBNos').value = "";
                    document.getElementById('txtReferringHospital').value = "";
                    document.getElementById('ddlDOBDWMY').value = "Year(s)";
                    document.getElementById('billPart_tdAdditionalTest').style.display = "none";
                    document.getElementById('billPart_tdlblAdditionalTest').style.display = "none";
                     if (document.getElementById('chkIncomplete').checked == true)
        {
       document.getElementById('ddlSex').value = "M";
     }
     document.getElementById('chkIncomplete').checked = false;
                    document.getElementById('txtInternalExternalPhysician').value = "";
                    document.getElementById('hdnReferralType').value = "0";
                    document.getElementById('txtCollectionCode').value = "";
                    if ((document.getElementById('hdnDefaultClienID') != null) && (document.getElementById('hdnDefaultClienName') != null)) {
                        if ((document.getElementById('hdnDefaultClienID').value == "") ||
                ((document.getElementById('hdnDefaultClienName').value != "") && (document.getElementById('hdnDefaultClienName').value != document.getElementById('txtClient').value))) {
                            document.getElementById('txtClient').value = "";
                        }
                    }
                    else {
                        document.getElementById('txtClient').value = "";
                    }
                    document.getElementById('txtEmail').value = "";
                    document.getElementById('ChkTRFImage').checked = false;
                    document.getElementById('chkMobileNotify').checked = false;
                    document.getElementById('hdnOPIP').value = "OP";
                    document.getElementById('hdnPreviousVisitDetails').value = "";
                    document.getElementById('lblPreviousItems').innerHTML = "";
                    document.getElementById('ShowBillingItems').style.display = "none";
                    document.getElementById('ShowPreviousData').style.display = "none";
                    document.getElementById('hdnPatientID').value = "-1";
                    document.getElementById('hdnVisitPurposeID').value = "-1";
                    document.getElementById('hdnClientID').value = "-1";
                    document.getElementById('hdnTPAID').value = "-1";
                    document.getElementById('hdnClientType').value = "CRP";
                    document.getElementById('hdnReferedPhyID').value = "0";
                    document.getElementById('hdnReferedPhyName').value = "";
                    document.getElementById('hdnReferedPhysicianCode').value = "0";
                    document.getElementById('lblPatientDetails').innerHTML = "";
                    document.getElementById('trPatientDetails').style.display = "none";
                    document.getElementById('hdnReferedPhyType').value = "";
                    document.getElementById('hdnBillGenerate').value = "N";
                    document.getElementById('hdnLstPatientInvSample').value = "";
                    document.getElementById('hdnLstSampleTracker').value = "";
                    document.getElementById('hdnLstPatientInvSampleMapping').value = "";
                    document.getElementById('hdnLstInvestigationValues').value = "";
                    document.getElementById('hdnLstCollectedSampleStatus').value = "";
                    document.getElementById('hdnPatientAlreadyExists').value = "0";
                    document.getElementById('hdnPatientAlreadyExistsWebCall').value = "0";
                    document.getElementById('hdnVisitID').value = "-1";
                    document.getElementById('hdnFinalBillID').value = "-1";
                    document.getElementById('hdnCashClient').value = "";
                    document.getElementById('hdnSerachPatientwithClientID').value = "0";
                    if ((document.getElementById('hdnDefaultClienID') != null) && (document.getElementById('hdnDefaultClienName') != null)) {
                        if ((document.getElementById('hdnDefaultClienID').value == "") ||
                ((document.getElementById('hdnDefaultClienName').value != "") && (document.getElementById('hdnDefaultClienName').value != document.getElementById('txtClient').value))) {

                            document.getElementById('hdnSelectedClientClientID').value = document.getElementById('hdnDefaultClienID').value;
                        }
                    }
                    else {
                        document.getElementById('hdnSelectedClientClientID').value = document.getElementById('hdnBaseClientID').value;
                    }

                    if (ClearType == "N") {
                        document.getElementById('txtDoFrmVisitNumber').value = "";
                        document.getElementById('hdnDoFrmVisit').value = "";
                        document.getElementById('hdnDOFromVisitFlag').value = "-1";
                        if (document.getElementById('hdnLocationClient').value != 'Y') {
                            document.getElementById('txtClient').value = "";
                            document.getElementById('hdnSelectedClientID').value = "-1";
                        }
                    }
                    var panelLegend = $('#PnlPatientDetail legend');
                    panelLegend.html(vPatientDetails);
                    document.getElementById('hdnRateID').value = document.getElementById('hdnBaseRateID').value;
                    document.getElementById('hdnMappingClientID').value = "-1";
                    document.getElementById('hdnIsMappedItem').value = "N";
                    document.getElementById('hdfReferalHospitalID').value = "0";
                    //document.getElementById('txtSampleDate').value = "";
                    document.getElementById('lblClientDetails').innerHTML = "";
                    document.getElementById('ddlDespatchMode').value = 0;
                    document.getElementById('txtSuburban').value = "";
                    document.getElementById('txtExternalPatientNumber').value = "";
                    document.getElementById('ddCountry').value = document.getElementById('hdnDefaultCountryID').value;
                    document.getElementById('lblCountryCode').innerHTML = document.getElementById('hdnDefaultCountryStdCode').value;
                    document.getElementById('ddlUrnoOf').value = 0;
                    document.getElementById('ddlUrnType').value = 0;
                    document.getElementById('txtURNo').value = "";
                    document.getElementById('hdnPatientName').value = "";
                    document.getElementById('billPart_UcHistory_hdnPreference').value = "";
                    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value = "";
                    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').value = "";
                    if (document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference') != null) {
                        document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference').value = "";
                    }
                    if (document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference') != null) {
                        document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').value = "";
                    }
                    if (document.getElementById('billPart_UcHistory_PatientPreference1hdnPreference') != null) {
                        document.getElementById('billPart_UcHistory_PatientPreference1hdnPreference').value = ""
                    }
                    document.getElementById('billPart_tdHistory').style.display = "none";
                    document.getElementById('billPart_tdClientAttributes').style.display = 'none';
                    clearBillPartValues();
                    clearDespatchMode();
                    var panelLegend = $('#PnlPatientDetail legend');
                    panelLegend.html(vPatientDetails);
                    ClearTodayVisitItems();
                    //Modified by arivalagan.kk for copayment//
                    // Co Paymnet //
                    var BToBhdnCopay
                    if (document.getElementById('HdnIsCopay') != null) {
                        BToBhdnCopay = document.getElementById('HdnIsCopay').value;
                    }
                    else {
                        BToBhdnCopay = 'N';
                    }
                    $("#billPart_hdnSpecimenValues").val("");
                    $('#billPart_btnspec').hide();
                    if (BToBhdnCopay == 'N') {
                        document.getElementById('HdnCoPay').value = 'N';
                        Calc_Copayment();
                        DisplayCoPayMent();
                        document.getElementById('billPart_lblTotal').innerHTML = '0.00';
                        document.getElementById('uctlClientTpa_ddlCopaymentType').value = 0;  //'--Select--';
                        document.getElementById('uctlClientTpa_txtCoperent').value = '0.00';
                        ToTargetFormat($("#uctlClientTpa_txtCoperent"));
                    }
                    //for HomeCollection
                    document.getElementById('billPart_hdnHCPayments').value = 'N';
                    ToTargetFormat($("#billPart_hdnHCPayments"));
                    document.getElementById('hdnIsPaymentAdded').value = 'N';
                    document.getElementById('txtHealthHubID').value = "";
                    document.getElementById('ddSalutation').value = 0;
                    
                    // Co Paymnet //
                    //End Modified by arivalagan.kk for copayment//
                }
            }
        }
    }
}

function clearPageControlsVal(ClearType) {
    var vPatientDetails = SListForAppDisplay.Get("Billing_CommonBilling_js_69") == null ? "Patient Details" : SListForAppDisplay.Get("Billing_CommonBilling_js_69")
    var vPatientNo = SListForAppDisplay.Get("Billing_CommonBilling_js_68") == null ? "Patient No:" : SListForAppDisplay.Get("Billing_CommonBilling_js_68")
    if (document.getElementById('hdnIsEditMode').value == 'N') {
        if (ClearType == "N") {
            document.getElementById('txtName').value = '';
            if (document.getElementById('txtName') != null) {
                try {
                    //document.getElementById('txtName').focus();
                }
                catch (err) { }
            }
        }
        if (document.getElementsByName('rblSearchType') != null) {
            var searchtypeRadioList = document.getElementsByName('rblSearchType');
            for (var i = 0; i < searchtypeRadioList.length; i++) {
                if (searchtypeRadioList[i].checked) {
                    searchtype = searchtypeRadioList[i].value
                    break;
                }
            }
            if (searchtype == 4) {
                document.getElementById('txtName').setAttribute('autocomplete', 'off');
                if ($find('AutoCompleteExtenderPatient') != null) {
                    $find('AutoCompleteExtenderPatient').set_contextKey('');
                }
            }
        }
        document.getElementById('tDOB').value = "dd//MM//yyyy";
        document.getElementById('txtMobileNumber').value = "";
        document.getElementById('txtSuburban').value = "";
        document.getElementById('txtPhone').value = "";
        document.getElementById('txtAddress').value = "";
        document.getElementById('txtPincode').value = "";
        document.getElementById('txtCity').value = "";
        document.getElementById('txtDOBNos').value = "";
        document.getElementById('ddlDOBDWMY').value = "Year(s)";
         if (document.getElementById('chkIncomplete').checked == true)
        {
       document.getElementById('ddlSex').value = "M";
     }
        document.getElementById('txtEmail').value = "";
        document.getElementById('hdnPatientID').value = "-1";
        document.getElementById('ddCountry').value = document.getElementById('hdnDefaultCountryID').value;
        document.getElementById('lblCountryCode').innerHTML = document.getElementById('hdnDefaultCountryStdCode').value;
        document.getElementById('ddlUrnoOf').value = 0;
        document.getElementById('ddlUrnType').value = 0;
        document.getElementById('ddState').value = 11;
        //document.getElementById('ddSalutation').value = 7;
        document.getElementById('ddCountry').value = 75;
        // loadState("31");
        document.getElementById('txtURNo').value = "";
        document.getElementById('ComplaintICDCodeBP1_txtICDName').value = "";
        document.getElementById('ComplaintICDCodeBP1_txtCpmlaint').value = "";
        document.getElementById('ComplaintICDCodeBP1_txtICDCode').value = "";
        document.getElementById('PatientPreference1_txtEnterPreference').value = "";
        if (document.getElementById('PatientPreference1_PatientPreference').innerText != "") {
            document.getElementById('PatientPreference1_PatientPreference').innerText = "";
        }
        document.getElementById('lblPatientDetails').innerHTML = "";
        document.getElementById('trPatientDetails').style.display = "none";
        document.getElementById('hdnPreference').value = "";
        document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value = "";
        if (document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText != "") {
            document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
        }
        if (document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference') != null) {
            document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference').value = "";
            document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML = "";
            document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value = "";
        }
        if (document.getElementById('billPart_UctHistory_ComplaintICDCodeBP1_hdnDiagnosisItems') != null) {
            document.getElementById('billPart_UctHistory_ComplaintICDCodeBP1_hdnDiagnosisItems') = "";
        }
        document.getElementById('billPart_tdAdditionalTest').style.display = "none";
        document.getElementById('billPart_tdlblAdditionalTest').style.display = "none";
        var panelLegend = $('#PnlPatientDetail legend');
        panelLegend.html(vPatientDetails);
        document.getElementById('btnSaveEMR').value = 'Save';
    }

}
function ClearTodayVisitItems() {

    document.getElementById('hdnTodayVisitID').value = '-1';
    document.getElementById('hdnTempTodayVisitID').value = '-1';


    var ddlVisitDetails = document.getElementById('ddlVisitDetails');
    ddlVisitDetails.selectedIndex = 0;

    document.getElementById('tdVisitType1').style.display = "none";
    document.getElementById('tdVisitType2').style.display = "none";
    //    document.getElementById('tdSex1').style.width = '42%';
    //    document.getElementById('tdSex2').style.width = '58%';

}
function clearDespatchMode() {
    $('[id$="chkDespatchMode"] input[type=checkbox]:checked').each(function() {
        $('[id$="chkDespatchMode"] input[type=checkbox]:checked').attr('checked', false);
    });
    $('[id$="chkDisPatchType"] input[type=checkbox]:checked').each(function() {
        $('[id$="chkDisPatchType"] input[type=checkbox]:checked').attr('checked', false);

    });
}
function ForFutureDate() {
    /* Added By Venkatesh S */
    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var vSamplePickupDate = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_05') == null ? "Dont select sample pickup date as future Date." : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_05');
    var date = new Date,
    day = date.getDate(),
    month = date.getMonth() + 1,
    year = date.getFullYear(),
    hour = date.getHours(),
    minute = date.getMinutes(),
    seconds = date.getSeconds(),
    ampm = hour > 12 ? "PM" : "AM";
    hour = hour % 12;
    hour = hour ? hour : 12; // zero = 12
    minute = minute > 9 ? minute : "0" + minute;
    seconds = seconds > 9 ? seconds : "0" + seconds;
    hour = hour > 9 ? hour : "0" + hour;

    date = day + "/" + month + "/" + year + " " + hour + ":" + minute + ":" + seconds + " " + ampm;
    if (document.getElementById('txtSampleDate').value != '') {
        var currentdate = document.getElementById('txtcurrendate').value;
        var Sampledt = document.getElementById('txtSampleDate').value;
        var dt1 = currentdate.split(' ');
        var dt2 = Sampledt.split(' ');
        if (Date.parse(Sampledt) > Date.parse(date)) {
            //alert("Dont select sample pickup date as future Date.");
            ValidationWindow(vSamplePickupDate, AlertType);
            document.getElementById('txtSampleDate').value = '';
            document.getElementById('txtSampleDate').value = date;
            return false;
        }
    }
}
function validateEvents(obj) {
    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var vCoPaymentAmt = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_06') == null ? "The Co-payment amount is Zero. \r\n  do you want to continue?" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_06');
    var vClientName = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_07') == null ? "Client Name remains same, Please Change the Client Before Save" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_07');
    var vDiscountcoupon = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_08') == null ? "Discount coupon can be used, would you like to redeem the coupon?" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_08');
    var vReferringDoctor = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_09') == null ? "Referring Doctor discount limit is exceeded for this period, will not be able to provide further discounts." : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_09');
    var vEmployeediscount = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_10') == null ? "Employee discount limit is exceeded for this period, will not be able to provide further discounts." : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_10');
    var vProvidepatient = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_11') == null ? "Provide patient name" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_11');
    var vProvideExternal = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_12') == null ? "Provide External VisitID" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_12');
    var vProvidepatientage = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_13') == null ? "Provide patient age or date of birth" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_13');
    var vSelectpatien = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_14') == null ? "Select patient sex" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_14');
    var vProvidecontact = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_15') == null ? "Provide contact mobile number" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_15');
    var vPleaseselectPhlebotomist = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_16') == null ? "Please select Phlebotomist Name" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_16');
    var vProvidecontactmobile = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_17') == null ? "Provide contact mobile or telephone number" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_17');
    var vEnterSpecimen = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_18') == null ? "Enter Specimen Count" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_18');
    var vSelectPhlebotomist = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_19') == null ? "Select Phlebotomist Name" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_19');
    var vYouselectedDoctor = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_22') == null ? "You selected Doctor/Clinic Delivery,  Provide Ref Dr" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_20');
    var vYouselectedHome = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_21') == null ? "You selected Home Delivery, Provide address" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_21');
    var vProvideavalidemail = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_22') == null ? "Provide a valid e-mail address" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_22');
    var vHistoryneeds = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_23') == null ? "History needs to be captured for this Patient" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_23');
    var vYouselectdespatchmodeasEmail = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_24') == null ? "You select dispatch mode as E-mail , Provide e-mail address" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_24');
    var vYouselectdespatchmodeassms = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_25') == null ? "You select dispatch mode as sms , Provide contact mobile number" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_25');
    var vYouSelectCouriorAddress = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_26') == null ? "You select dispatch mode as courier , Provide address" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_26');
    var vYouSelectCouriorCity = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_27') == null ? "You select dispatch mode as courier , Provide city" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_27');
    var vYouSelectCouriorPincode = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_28') == null ? "You select dispatch mode as courier , Provide pincode" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_28');
    var vSamplePickupDate = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_29') == null ? "Provide Sample Pickup Date" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_29');
    var vBillingitems = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_30') == null ? "Include billing items" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_30');
    var vDiscountAuthorised = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_31') == null ? "Provide discount authorised by" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_31');
    var vDiscountReason = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_32') == null ? "Provide discount reason" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_32');
    var vSlab = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_33') == null ? "Select the slab" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_33');
    var vDiscountAuthorisedBy = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_34') == null ? "Provide discount authorised by" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_34');
    var vCeilingValue = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_35') == null ? "Provide the Ceiling Value" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_35');
    //var vDiscountReason = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_36') == null ? "Provide the Ceiling Value" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_36');
  //  var vDiscountReason = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_37') == null ? "Provide discount reason" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_37');
    var vDiscountAuthorisedBy = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_38') == null ? "Provide discount authorised by" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_38');
    var vOnlyMiscellaneous = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_39') == null ? "Only miscellaneous item is added, do you want to continue?" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_39');
    var vBillAmount = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_40') == null ? "Bill amount will be added to due.\r Do you want to continue" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_40');
    var vThereChange = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_41') == null ? "There is a change in Age / Gender, Any Result entry completed reports for this Visit need to be re-validated" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_41');
    var vIncludeBilling = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_42') == null ? "Include billing items" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_42');
    var OkMsg = SListForAppMsg.Get('Scripts_Ok') == null ? "OK" : SListForAppMsg.Get('Scripts_Ok');
    var CancelMsg = SListForAppMsg.Get('Scripts_Cancel') == null ? "Cancel" : SListForAppMsg.Get('Scripts_Cancel');
    var Information = SListForAppMsg.Get('Scripts_Information') == null ? "Information" : SListForAppMsg.Get('Scripts_Information');
    var error = SListForAppMsg.Get('Scripts_Error') == null ? "Alert" : SListForAppMsg.Get('Scripts_Error');

    var AlrtWinHdr = SListForAppMsg.Get("Scripts_LabQuickBilling_js_02") != null ? SListForAppMsg.Get("Scripts_LabQuickBilling_js_02") : "Alert";
    var UsrAlrtMsg12 = SListForAppMsg.Get("Scripts_LabQuickBilling_js_03") != null ? SListForAppMsg.Get("Scripts_LabQuickBilling_js_03") : "Insufficient balance, Please deposit the advance amount";
    var UsrAlrtMsg13 = SListForAppMsg.Get("Scripts_LabQuickBilling_js_04") != null ? SListForAppMsg.Get("Scripts_LabQuickBilling_js_04") : "Second Alert:Threshold value exceed";
    var UsrAlrtMsg14 = SListForAppMsg.Get("Scripts_LabQuickBilling_js_05") != null ? SListForAppMsg.Get("Scripts_LabQuickBilling_js_05") : "First Alert: Threshold value exceed";
    var UsrAlrtMsg16 = SListForAppMsg.Get("Scripts_LabQuickBilling_js_06") != null ? SListForAppMsg.Get("Scripts_LabQuickBilling_js_06") : "Credit Limit Days has Expired !";
    var UsrAlrtMsg17 = SListForAppMsg.Get("Scripts_LabQuickBilling_js_07") != null ? SListForAppMsg.Get("Scripts_LabQuickBilling_js_07") : "Credit Limit Exceeds";
    var UsrAlrtMsg18 = SListForAppMsg.Get("Scripts_LabQuickBilling_js_08") != null ? SListForAppMsg.Get("Scripts_LabQuickBilling_js_08") : "Third Alert: Threshold value exceed";
    //debugger;
    //Modified by arivalagan.kk for copayment//
    var patient_NetpayAmt = document.getElementById('billPart_lblTotal').innerHTML;
    if (document.getElementById('HdnCoPay').value == 'Y' && patient_NetpayAmt > 0) {
        try {
            if (!ValidateCopay()) {
                return false;
            }
        } catch (e) {
        }
    }
    //End Modified by arivalagan.kk for copayment//
    else {
        if (document.getElementById('HdnCoPay').value == 'Y' && patient_NetpayAmt == 0) {
            var ans = ConfirmWindow('' + vCoPaymentAmt + '');
            if (ans != true)
                return false;
        }
    }
    if (CPEDIT == 'Y' && document.getElementById('hdnSelectedClientClientID').value == "0") {
        //alert("Client Name remains same, Please Change the Client Before Save");
        ValidationWindow(vClientName, AlertType);
        return false;
    }
    if (document.getElementById('billPart_ddDiscountPercent').selectedIndex == 0 && document.getElementById('billPart_hdnIsCashClient').value == "Y" && document.getElementById('billPart_hdnHealthCardItems').value != "" && ($("#billPart_txtRedeem").val() == "" || $("#billPart_txtRedeem").val() == "0.00")) {
        if (ConfirmWindow('' + vDiscountcoupon + '')) {
            $("#billPart_txtCardNo").focus();
            return false;
        }
    }

    ForFutureDate();

    var NewOrgID = document.getElementById('hdnNewOrgID').value;

    //syed
    var DiscountAmount = 0;
    var AvailableDiscountAmt = 0;
    var DiscountLimitAmt = 0;
    var total = 0;
    total = document.getElementById('billPart_hdnDiscountPercentage').value;
    DiscountAmount = Number((document.getElementById('billPart_txtGross').value) * total / 100).toFixed(2);
    AvailableDiscountAmt = Number(Number(document.getElementById('hdnAvailableDiscountAmt').value)).toFixed(2);
    DiscountLimitAmt = document.getElementById('hdnDiscountLimitAmt').value;
    if (Number(DiscountAmount) <= Number(AvailableDiscountAmt)) {

    }
    else if (DiscountLimitAmt > 0) {
        //alert("Discount Limit of this Physician is exist, Avilable Discount Balance is : " + Number(AvailableDiscountAmt).toFixed(2));
        if (document.getElementById('hdnDiscountLimitType').value != "EMPL") {
            //alert("Referring Doctor discount limit is exceeded for this period, will not be able to provide further discounts.");
            ValidationWindow(vReferringDoctor, AlertType);
            //("Insufficient Discount Limit");
            return false;
        }
        else {
            //alert("Employee discount limit is exceeded for this period, will not be able to provide further discounts.");
            ValidationWindow(vEmployeediscount, AlertType);
            return false;
        }

    }
    if ($('#txtName').val() != undefined && $.trim($('#txtName').val()) == '') {
        //alert('Provide patient name');
        CommonControlFocus = "#txtName";
        ValidationWindowResponse(vProvidepatient, AlertType, FocusControlAfterValidationWindowResponse);
      
        return false;
    }
    if ($('#txtExternalVisitID').val() != undefined && $.trim($('#txtExternalVisitID').val()) == '') {
        //alert('Provide External VisitID');
        CommonControlFocus = "#txtExternalVisitID";
        ValidationWindowResponse(vProvideExternal, AlertType, FocusControlAfterValidationWindowResponse);
      
        return false;
    }
    if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy') && (document.getElementById('hdnIncompleteAge').value != 'Y') && document.getElementById('chkIncomplete').checked == false) {
        //alert('Provide patient age or date of birth');
        CommonControlFocus = "#txtDOBNos";
        ValidationWindowResponse(vProvidepatientage, AlertType, FocusControlAfterValidationWindowResponse);
//        document.getElementById('txtDOBNos').focus();
        return false;
    }
    if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0" &&  document.getElementById('chkIncomplete').checked == false) {
        if (document.getElementById('ddlSex').disabled != true) {
            //alert('Select patient sex');
            CommonControlFocus = "#ddlSex";

            ValidationWindowResponse(vSelectpatien, AlertType, FocusControlAfterValidationWindowResponse);
//            document.getElementById('ddlSex').focus();
            return false;
        }
    }
    if (document.getElementById('chkMobileNotify').checked == true) {
        if (document.getElementById('txtMobileNumber').value == '') {
            //alert('Provide contact mobile number');
            CommonControlFocus = "#txtMobileNumber";
            ValidationWindowResponse(vProvidecontact, AlertType, FocusControlAfterValidationWindowResponse);
//            document.getElementById('txtMobileNumber').focus();
            return false;
        }
    }
    if ($('#HdnPhleboNameMandatory').val() != 'N') {
        if (document.getElementById('txtPhleboName').value == "") {
            if (document.getElementById('HdnPhleboID').value == "") {
                //alert('Please select Phlebotomist Name');
                CommonControlFocus = "#txtPhleboName";
                ValidationWindowResponse(vSelectPhlebotomist, AlertType, FocusControlAfterValidationWindowResponse);
               // document.getElementById('txtPhleboName').focus();
                return false;
            }
        }
    }

    if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '' && document.getElementById('chkIncomplete').checked == false) {
        //alert('Provide contact mobile or telephone number');
        CommonControlFocus = "#txtMobileNumber";
        ValidationWindowResponse(vProvidecontactmobile, AlertType, FocusControlAfterValidationWindowResponse);
//        $('#txtMobileNumber').focus();
        return false;
    }
    var Specimen = document.getElementById('hdnRoundNo').value;
    if (Specimen == 'Y') {
        //debugger;
        if (document.getElementById('txtRoundNo').value == '') {

            //alert('Enter Specimen Count');
            CommonControlFocus = "#txtRoundNo";
            
            ValidationWindowResponse(vEnterSpecimen, AlertType, FocusControlAfterValidationWindowResponse);
//            document.getElementById('txtRoundNo').focus();
            return false;
        }
    }
    var phlebo = document.getElementById('hdnPhlebotomist').value;
    if (phlebo == 'Y') {
        if (document.getElementById('txtPhleboName').value == '') {
            //alert('Select Phlebotomist Name');
            CommonControlFocus = "#txtPhleboName";
            
            ValidationWindowResponse(vPleaseselectPhlebotomist, AlertType);
//            document.getElementById('txtPhleboName').focus();
            return false;
        }
    }
    //    if (document.getElementById('txtAddress').value == '') {
    //        alert('Provide contact address');
    //        document.getElementById('txtAddress').focus();
    //        return false;
    //    }

    //    if (document.getElementById('txtCity').value == '') {
    //        alert('Provide city');
    //        document.getElementById('txtCity').focus();
    //        return false;
    //    }
    //Added  By Arivalagan.kk for exception in looping cross browser//
    var CPEDIT = document.getElementById('billPart_hdnCpedit').value;
    var lblDocflag = false;
    var lblHomeflag = false;

    $('#chkDisPatchType input[type=checkbox]:checked').each(function() {
        if ($('label[for=' + this.id + ']').html() == "Doctor/Clinic Delivery" && CPEDIT != 'Y') {
            if (document.getElementById('txtInternalExternalPhysician').value.trim() == '') {
                lblDocflag = true;
            }
        }
        if ($('label[for=' + this.id + ']').html() == "HomeDelivery" && CPEDIT != 'Y') {
            if (document.getElementById('txtAddress').value.trim() == '') {
                lblHomeflag = true;
            }
        }
    });
     
    if ($('#billPart_hdnEnableHistoryTestConfig').val() == "Y") 
    {      
        var FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;

        var FeeGotValue = new Array();
        FeeGotValue = FeeViewStateValue.split('|');
        var feeIDALready = new Array();
        var tempFeeID, tempFeeType, IsMandatoryHis,tempFeeName;
       var tempFeeNameAll= '';
        var isNoHisValue = 0;
          var ISHisValue=0;

        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        
        var tarrayChildData = new Array();

        for (iMain = 0; iMain < FeeGotValue.length - 1; iMain++) {

            tarraySubData = FeeGotValue[iMain].split('~');
		if(tarraySubData[31] == "IsMandatoryHis^true")
		{
            for (tiChild = 0; tiChild < tarraySubData.length; tiChild++) {
                tarrayChildData = tarraySubData[tiChild].split('^');
                if (tarrayChildData.length > 0) {

                    if (tarrayChildData[0] == "FeeID") {
                        tempFeeID = tarrayChildData[1];
                    }
                    if (tarrayChildData[0] == "FeeType") {
                        tempFeeType = tarrayChildData[1];
                    }
                     if (tarrayChildData[0] == "IsMandatoryHis") {
                        IsMandatoryHis = tarrayChildData[1];
                    }
                    if (tarrayChildData[0] == "Descrip") {
                        tempFeeName = tarrayChildData[1];
                    }
                    if(IsMandatoryHis==true || IsMandatoryHis=="true")
                    {
                     //if(isNoHisValue==0 || isNoHisValue==2)
                     //{
                         isNoHisValue=1;
                      

                    //  } 
                      
                       if($('#hdnTestHistoryPatient').val()!='' && $('#hdnTestHistoryPatient').val()!=undefined)
                       {
                          
                            var jsonresult = JSON.parse($('#hdnTestHistoryPatient').val());

                            for (his = 0; his < jsonresult.length; his++) {
                                if(tempFeeType==jsonresult[his].TestType &&
                                  tempFeeID==jsonresult[his].ReferenceID)
                                  {
                            
                                     isNoHisValue=2;
                                      
                                  }

                            }
                             if(isNoHisValue!=2)
                                  {
                                      if(tempFeeNameAll == '')
                         {
                         tempFeeNameAll = tempFeeName;
                         }
                         else
                         {
			if(tempFeeNameAll.indexOf(tempFeeName) == -1)
{
                         tempFeeNameAll = tempFeeNameAll + '<br/>' + tempFeeName;
}
                         }
ISHisValue =1;
                                    //ValidationWindow( tempFeeNameAll + " <br/> <br/> need to continue registration. Please capture the Clinical Details", AlertType);
                                     //return false;
                                  }
else 
{
IsMandatoryHis=false;
}


                        }
                    }
		    
                }
            }
if(isNoHisValue == 1 && ISHisValue !=1)
{
if(tempFeeNameAll == '')
                         {
                         tempFeeNameAll = tempFeeName;
                         }
                         else
                         {
                         tempFeeNameAll = tempFeeNameAll + '<br/> ' + tempFeeName;
                         }
		}
}
        
	
}
if(ISHisValue==1)
{
isNoHisValue=1;
}
 if(isNoHisValue==1)
        {
          ValidationWindow( tempFeeNameAll  + " <br/> <br/> need to continue registration. Please capture the Clinical Details", AlertType);
          return false;
        }
    }


    if (lblDocflag == true) {
        //alert("You selected Doctor/Clinic Delivery,  Provide Ref Dr ");
        CommonControlFocus = "#txtInternalExternalPhysician";
        ValidationWindowResponse(vYouselectedDoctor, AlertType, FocusControlAfterValidationWindowResponse);
//        document.getElementById('txtInternalExternalPhysician').focus();
        return false;
    }
    else if (lblHomeflag == true) {
    //alert("You selected Home Delivery, Provide address");
    CommonControlFocus = "#txtAddress";
    ValidationWindowResponse(vYouselectedHome, AlertType, FocusControlAfterValidationWindowResponse);
//        document.getElementById('txtAddress').focus();
        return false;
    }
    //End Added  By Arivalagan.kk for exception in looping cross browser//


    if ($('#hdnConfigTRFMandatory').val() == "Y") {
        var istrfavail = uploadtrfvalidation();
        if (!istrfavail) {
            return istrfavail;
        }
    }

    //Comented  By Arivalagan.kk  for auto add amount grid details//

    //var CPEDIT = document.getElementById('billPart_hdnCpedit').value;
    /* var elements = document.getElementById('chkDisPatchType');
    if (elements != null) {
    for (i = 0; i < elements.rows[0].cells.length; i++) {
    if (elements.cells[i].childNodes[0].checked) {
    if (document.getElementById('chkDisPatchType').childNodes[0].childNodes[0].cells[i].innerText == "Doctor/Clinic Delivery" && CPEDIT != 'Y') {
    if (document.getElementById('txtInternalExternalPhysician').value.trim() == '') {
    alert("You selected Doctor/Clinic Delivery,  Provide Ref Dr ");
    document.getElementById('txtInternalExternalPhysician').focus();
    return false;
    }
    }

                if (document.getElementById('chkDisPatchType').childNodes[0].childNodes[0].cells[i].innerText == "HomeDelivery" && CPEDIT != 'Y') {
    if (document.getElementById('txtAddress').value.trim() == '') {
    alert("You selected Home Delivery, Provide address");
    document.getElementById('txtAddress').focus();
    return false;
    }
    //                if (document.getElementById('txtCity').value.trim() == '') {
    //                    alert("You selected Home Delivery, Provide city");
    //                    document.getElementById('txtCity').focus();
    //                    return false;
    //                }
    //                if (document.getElementById('txtPincode').value.trim() == '') {
    //                    alert("You selected Home Delivery, Provide pincode");
    //                    document.getElementById('txtPincode').focus();
    //                    return false;
    //                }
    } 
    } 
    } 
    }*/

    //    if (document.getElementById('txtInternalExternalPhysician').value.trim() != '') {

    //        $('[id$="chkDisPatchType"] input[type=checkbox]').each(function(i) {
    //            if (($("#" + $(this).filter().context.id).next().text()) == "Doctor/Clinic Delivery") {

    //                if (this.checked == false) {
    //                    alert("You select Doctor/Clinic Dispatch Type ");
    //                    return false;
    //                }
    //            }

    //        });

    //    }
    //Comented  By Arivalagan.kk  for auto add amount grid details//
    if (CPEDIT != 'Y') {
        if (document.getElementById('txtEmail') != null) {
            if ($.trim($('#txtEmail').val()) != '') {
                var x = document.getElementById('txtEmail').value;
                var atpos = x.indexOf("@");
                var dotpos = x.lastIndexOf(".");
                if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
                    //alert("Provide a valid e-mail address");
                    CommonControlFocus = "#txtEmail";
                    ValidationWindowResponse(vProvideavalidemail, AlertType, FocusControlAfterValidationWindowResponse);
//                    $('#txtEmail').focus();
                    return false;
                }
            }
        }
        if (obj == 'After') {
            var HasHistory = document.getElementById('billPart_hdnCapture').value;
            var HistoryValue = document.getElementById('billPart_hdnHistoryTableList').value;
            if (HasHistory == 1) {
                var isNeedToCaptureHistory = false;
                if (HistoryValue == '') {
                    isNeedToCaptureHistory = true;
                }
                else {
                    var HistoryAttributeList = document.getElementById('billPart_hdnHistoryAttributeList').value;
                    var lstHistoryTableList = HistoryValue.split('|');
                    var isHistoryExists = false;
                    if (HistoryAttributeList != null && HistoryAttributeList != "") {
                        var lstHistoryAttributeList = HistoryAttributeList.split('^');
                        if (lstHistoryAttributeList != null && lstHistoryAttributeList.length > 0) {
                            for (k = 0; k < lstHistoryAttributeList.length; k++) {
                                var lstAttributeList = lstHistoryAttributeList[k].split('~');
                                if (lstAttributeList != null && lstAttributeList.length > 0) {
                                    if (lstAttributeList[1] != null && lstAttributeList[9] != null && lstAttributeList[9] == "Y") {
                                        if (lstHistoryTableList != null && lstHistoryTableList.length > 0) {
                                            for (i = 0; i < lstHistoryTableList.length; i++) {
                                                lstHistoryList = lstHistoryTableList[i].split('~');
                                                if (lstHistoryList != null && lstHistoryList.length > 0) {
                                                    for (j = 0; j < lstHistoryList.length; j++) {
                                                        lstHistory = lstHistoryList[j].split('^');
                                                        if (lstHistory[0] == "HistoryID" && lstAttributeList[1] == lstHistory[1]) {
                                                            isHistoryExists = true;
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        if (!isHistoryExists) {
                                            isNeedToCaptureHistory = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                if (isNeedToCaptureHistory) {
                    //alert('History needs to be captured for this Patient');
                    ValidationWindow(vHistoryneeds, AlertType);
                    return false;
                }
            }
        }
        if (obj == 'Before' && $('[id$="hdnPatientAlreadyExists"]').val() == 0) {
            IsPatientAlreadyExists();
        }
        //Added  By Arivalagan.kk  for auto add amount grid details//
        var lblemailflag = false;
        var lblsmsflag = false;
        var lblcourierflag = false;

        $('#chkDespatchMode input[type=checkbox]:checked').each(function() {
            if ($('label[for=' + this.id + ']').html().toLowerCase() == "email") {
                lblemailflag = true;
            }
            if ($('label[for=' + this.id + ']').html().toLowerCase() == "sms") {
                lblsmsflag = true;
            }
            if ($('label[for=' + this.id + ']').html().toLowerCase() == "courier" || $('label[for=' + this.id + ']').html().toLowerCase() == "rcourier") {
                lblcourierflag = true;
            }
        });

        if (lblemailflag == true) {
            if (document.getElementById('txtEmail').value != null) {
                if (document.getElementById('txtEmail').value.trim() == '') {
                    //alert("You select despatch mode as E-mail , Provide e-mail address");
                    CommonControlFocus = "#txtEmail";
                    ValidationWindowResponse(vYouselectdespatchmodeasEmail, AlertType, FocusControlAfterValidationWindowResponse);
//                    document.getElementById('txtEmail').focus();
                    return false;
                }
            }
        }
        else if (lblsmsflag == true) {
            if (document.getElementById('txtMobileNumber').value.trim() == '') {
                //alert('You select despatch mode as sms , Provide contact mobile number');
                CommonControlFocus = "#txtMobileNumber";                
                ValidationWindowResponse(vYouselectdespatchmodeassms, AlertType, FocusControlAfterValidationWindowResponse);
//                document.getElementById('txtMobileNumber').focus();
                return false;
            }
        }
        else if (lblcourierflag == true) {
            if (document.getElementById('txtAddress').value.trim() == '') {
                //alert("You select despatch mode as courier , Provide address");
                CommonControlFocus = "#txtAddress";                
                
                ValidationWindowResponse(vYouSelectCouriorAddress, AlertType, FocusControlAfterValidationWindowResponse);
//                document.getElementById('txtAddress').focus();
                return false;
            }
            if (document.getElementById('txtCity').value.trim() == '') {
                //alert("You select despatch mode as courier , Provide city");
                CommonControlFocus = "#txtCity";
                ValidationWindowResponse(vYouSelectCouriorCity, AlertType, FocusControlAfterValidationWindowResponse);
//                document.getElementById('txtCity').focus();
                return false;
            }
            if (document.getElementById('txtPincode').value.trim() == '') {
                //alert("You select despatch mode as courier , Provide pincode");
                CommonControlFocus = "#txtPincode";

                ValidationWindowResponse(vYouSelectCouriorPincode, AlertType, FocusControlAfterValidationWindowResponse);
//                document.getElementById('txtPincode').focus();
                return false;
            }
        }
        //End Added  By Arivalagan.kk  for auto add amount grid details//

        //Comented  By Arivalagan.kk  for auto add amount grid details//
        /*var elements = document.getElementById('chkDespatchMode');
        if (elements != null) {
        for (i = 0; i < elements.rows[0].cells.length; i++) {
        if (elements.cells[i].childNodes[0].checked) {
        if (document.getElementById('chkDespatchMode').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "email") {
        if (document.getElementById('txtEmail').value != null) {
        if (document.getElementById('txtEmail').value.trim() == '') {
        alert("You select despatch mode as E-mail , Provide e-mail address");
        document.getElementById('txtEmail').focus();
        return false;
        }
        }
        }
        if (document.getElementById('chkDespatchMode').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "sms") {
        if (document.getElementById('txtMobileNumber').value.trim() == '') {
        alert('You select despatch mode as sms , Provide contact mobile number');
        document.getElementById('txtMobileNumber').focus();
        return false;
        }
        }
        if (document.getElementById('chkDespatchMode').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "courier") {
        if (document.getElementById('txtAddress').value.trim() == '') {
        alert("You select despatch mode as courier , Provide address");
        document.getElementById('txtAddress').focus();
        return false;
        }
        if (document.getElementById('txtCity').value.trim() == '') {
        alert("You select despatch mode as courier , Provide city");
        document.getElementById('txtCity').focus();
        return false;
        }
        if (document.getElementById('txtPincode').value.trim() == '') {
        alert("You select despatch mode as courier , Provide pincode");
        document.getElementById('txtPincode').focus();
        return false;
        }
        }
        }
        }
        }*/
        //End Comented  By Arivalagan.kk  for auto add amount grid details//

        /**** Credit Client and Advanced Client******/
        var hdnAdvanceClient = $('[id$="hdnAdvanceClient"]').val();
        var hdnTotalDepositAmount = $('[id$="hdnTotalDepositAmount"]').val();
        var hdnTotalDepositUsed = $('[id$="hdnTotalDepositUsed"]').val();
        var hdnAvailDepositAmt = $('[id$="hdnAvailDepositAmt"]').val();

        var hdncreditlimit1 = $('[id$="hdnCreditLimit"]').val();
        var PendingCreditLimit = $('[id$="hdnTotalCreditLimit"]').val();
        var NotInvoicedAmt = $('[id$="hdnTotalCreditUsed"]').val();
        var hdnCreditExpiresdays = $('[id$="hdnCreditExpires"]').val();
        var hdnIsBlockReg = $('[id$="hdnIsBlockReg"]').val();

        var hdnThresholdType = $('[id$="hdnThresholdType"]').val();
        var hdnThresholdValue = $('[id$="hdnThresholdValue"]').val();
        var hdnThresholdValue2 = $('[id$="hdnThresholdValue2"]').val();
        var hdnThresholdValue3 = $('[id$="hdnThresholdValue3"]').val();
        var hdnVirtualCreditType = $('[id$="hdnVirtualCreditType"]').val();
        var hdnVirtualCreditValue = $('[id$="hdnVirtualCreditValue"]').val();
        var hdnNetAmount = $('[id$="hdnNetAmount"]').val();
        var virtualVal = 0;
        var depositAmountFlag = 0;
         if (hdncreditlimit1 > 0 && document.getElementById('txtClient').value!='') {

            if (parseInt(hdnCreditExpiresdays) < 0) {
                ValidationWindow(UsrAlrtMsg16, AlrtWinHdr);
                return false;
            }

            if ((parseInt(PendingCreditLimit) < parseInt(hdnNetAmount)) ) {
                ValidationWindow(UsrAlrtMsg17, AlrtWinHdr);
                depositAmountFlag = "1";
            }
            else if ( ((parseInt(PendingCreditLimit) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue3))) {

                ValidationWindow(UsrAlrtMsg18, AlrtWinHdr);
                if (hdnIsBlockReg == 'Y') {
                      depositAmountFlag = "1";
                }
            }

            else if ((parseInt(PendingCreditLimit) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue2)) {
                //alert('Second Alert:Threshold value exceed');
                ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                //return false;
            }
            else if ((parseInt(PendingCreditLimit) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue)) {
                // alert('First Alert: Threshold value exceed');
                ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                //return false;
            }
        }
        else {
            try {
                //debugger;
                if (hdnAdvanceClient.trim() == 1) {
                    $.ajax({
                        type: "POST",
                        url: "../OPIPBilling.asmx/GetAdvanceAmountDetails",
                        data: "{ 'collectionID': '" + parseInt(document.getElementById('hdnCollectionID').value) + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function(data) {

                            var ArrayItems = data.d;
                            var Items = ArrayItems[0];
                            var SamplesItems = ArrayItems[1];
                            var TotalAvailablebalance = 0
                            hdnTotalDepositAmount = Items.TotalDepositAmount;
                            hdnTotalDepositUsed = Items.TotalDepositUsed;
                            TotalAvailablebalance = Items.AmtRefund
                            if ((parseInt(TotalAvailablebalance) < parseInt(hdnNetAmount)) || ((parseInt(TotalAvailablebalance) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue3))) {
                                // alert('Insufficient balance, Please deposit the advance amount');
                                ValidationWindow(UsrAlrtMsg12, AlrtWinHdr);
                                depositAmountFlag = "1";
                                return false;
                            }

                            else if ((parseInt(TotalAvailablebalance) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue2)) {
                                //alert('Second Alert:Threshold value exceed');
                                ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                                return false;
                            }
                            else if ((parseInt(TotalAvailablebalance) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue)) {
                                // alert('First Alert: Threshold value exceed');
                                ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                                return false;
                            }

                        },
                        failure: function(msg) {
                            ShowErrorMessage(msg);
                        }
                    });
                    //parseInt(hdnTotalDepositUsed)- parseInt(hdnNetAmount)
                }
            }
            catch (e) {
            }
        }
        if (depositAmountFlag == "1") {
            return false;
        }
        
        /**** End ***/
        if (document.getElementById('hdnIsEditMode').value == 'N') {
            if (obj == 'After') {
                if (document.getElementById('hdnCashClient').value != 'C') {
                    if (document.getElementById('txtClient').value.trim() != '') {
                        var NetAmount = $('[id$="hdnNetAmount"]').val();
                        var BalanaceAmount = $('[id$="hdnClientBalanceAmount"]').val();
                        if (Number(NetAmount) > Number(BalanaceAmount)) {
                            //                        if (alert('Ordered test items exceed balance client amount'))
                            //                            return false;
                            //                        else
                            //                            return false;
                        }
                    }
                }
            }

            if (document.getElementById('chkSamplePickup').checked == true) {
                if (document.getElementById('txtSampleDate').value == '') {
                    //alert('Provide Sample Pickup Date');
                    CommonControlFocus = "#txtSampleDate";

                    ValidationWindowResponse(vSamplePickupDate, AlertType, FocusControlAfterValidationWindowResponse);
//                    document.getElementById('txtSampleDate').focus();
                    return false;
                }
            }
            if ($('[id$="hdfBillType1"]').val() == '' && obj != 'Before') {
                //alert('Include billing items');
                CommonControlFocus = "#billPart_txtTestName";

                ValidationWindowResponse(vBillingitems, AlertType, FocusControlAfterValidationWindowResponse);
//                document.getElementById('billPart_txtTestName').focus();
                return false;
            }
            var KeySlabDiscount = document.getElementById('billPart_hdnIsSlabDiscount').value;

            if (KeySlabDiscount == 'N') {

                if (Number($('[id$="hdnDiscountAmt"]').val()) > 0 && obj == 'After') {
                    if ($.trim($('[id$="txtAuthorised"]').val()) == '' && document.getElementById('billPart_hdnGrossValue').value == document.getElementById('billPart_hdnDiscountAmt').value) {
                        //alert('Provide discount authorised by');
                        CommonControlFocus = "#" + $('[id$="txtAuthorised"]').prop("id");
                        ValidationWindowResponse(vDiscountAuthorised, AlertType, FocusControlAfterValidationWindowResponse);
//                        $('[id$="txtAuthorised"]').focus();
                        return false;

                    }
                    if (document.getElementById('billPart_hdnAllowMulDisc').value != 'Y') {
                        if ($('[id$="ddlDiscountReason"]').val() == '0') {
                            //alert('Provide discount reason');
                            CommonControlFocus = "#"+$('[id$="ddlDiscountReason"]').prop("id");
                            ValidationWindowResponse(vDiscountReason, AlertType, FocusControlAfterValidationWindowResponse);
//                            $('[id$="ddlDiscountReason"]').focus();
                            return false;
                        }
                    }
                }
            }
            else {
                var strDiscountPercent = document.getElementById('billPart_ddDiscountPercent');
                var strDPselectedValue = strDiscountPercent.options[strDiscountPercent.selectedIndex].value;
                var Discount = strDPselectedValue.split('~');
                var DiscountType;
                if (Discount[3] != "") {
                    DiscountType = Discount[3];
                }
                if (Discount != 0 && Discount != "") {
                    if (DiscountType != "") {
                        if (DiscountType == "Percentage") {
                            if (document.getElementById('billPart_ddlSlab').value == 0) {
                                //alert('Select the slab');
                                ValidationWindow(vSlab, AlertType);
                                return false;
                            }
                            if (document.getElementById('billPart_ddlDiscountReason').value == 0 || document.getElementById('billPart_ddlDiscountReason').value == "") {
                                //alert('Provide discount reason');
                                ValidationWindow(vDiscountReason, AlertType);
                                return false;
                            }
                            if (document.getElementById('billPart_txtAuthorised').value == "") {
                                //alert('Provide discount authorised by');
                                ValidationWindow(vDiscountAuthorisedBy, AlertType);
                                return false;
                            }
                        }
                        else if (DiscountType == "Value") {
                            if (document.getElementById('billPart_txtCeiling').value == "") {
                                //alert('Provide the Ceiling Value');
                                ValidationWindow(vCeilingValue, AlertType);
                                return false;
                            }
                            if (document.getElementById('billPart_ddlDiscountReason').value == 0 || document.getElementById('billPart_ddlDiscountReason').value == "") {
                                //alert('Provide discount reason');
                                ValidationWindow(vDiscountReason, AlertType);
                                return false;
                            }
                            if (document.getElementById('billPart_txtAuthorised').value == "") {
                                //alert('Provide discount authorised by');
                                ValidationWindow(vDiscountAuthorisedBy, AlertType);
                                return false;
                            }

                        }
                        else {
                            if (document.getElementById('billPart_ddlDiscountReason').value == 0 || document.getElementById('billPart_ddlDiscountReason').value == "") {
                                //alert('Provide discount reason');
                                ValidationWindow(vDiscountReason, AlertType);
                                return false;
                            }
                            if (document.getElementById('billPart_txtAuthorised').value == "") {
                                //alert('Provide discount authorised by');\
                                ValidationWindow(vDiscountAuthorisedBy, AlertType);
                                return false;
                            }

                        }
                    }
                }
            }

            if ($('[id$="hdfBillType1"]').val() != '' && obj == 'After') {
                var flag = true;
                flag = PaymentSaveValidationQuickBill();
                if (flag == false) {
                    return false;
                }
                if (document.getElementById('billPart_hdnIsInvestigationAdded').value == 0) {
                    var ans = ConfirmWindow('' + vOnlyMiscellaneous + '');
                    if (ans == false)
                     return false;
//                    else
//                        return false;
                }
                var IsCashClient = document.getElementById('billPart_hdnIsCashClient').value.trim();
                var ClientType = document.getElementById('billPart_hdnClientType').value.trim();
                if (IsCashClient == '') {
                    IsCashClient = 'Y';
                }

                if (Number($('[id$="hdnNetAmount"]').val()) > Number($('[id$="hdnAmountReceived"]').val()) && $('#hdnNotAllowDue').val() == 'Y' && IsCashClient == 'Y') {
                    var pBill = ConfirmWindow("Collect Whole Net Amount!!!", Information, OkMsg, CancelMsg);
                    if (pBill == true) {
                        $('#billPart_PaymentType_txtAmount').focus();
                        $('[id$="btnGenerate"]').show();
                        return false;
                    }
                    else {
                        $('[id$="btnGenerate"]').show();
                        return false;
                    }
                }

                // for HomeCollection
                if (document.getElementById('billPart_hdnHCPayments').value == 'Y') {
                    if (Number($('#billPart_txtAmtReceived').val()) > 0) {
                        document.getElementById('billPart_hdnAmountReceived').value = $('#billPart_txtAmtReceived').val();
                    }
                    else {
                        alert('Amount Received should not be zero');
                        return false;
                    }
                }

                //Modified by arivalagan.kk for copayment//
                var IsCopayClient = document.getElementById('HdnCoPay').value;

                if ((document.getElementById("txtClient").value.trim() == '' || IsCashClient == 'Y' || ClientType == 'WAK') && IsCopayClient != 'Y') {
                    if (document.getElementById('hdnMinimumDue').value == 'Y') {
                        if (document.getElementById('hdnMinimumDuePercent').value != '') {
                            var perc = document.getElementById('hdnMinimumDuePercent').value;

                            var tot = $('[id$="hdnNetAmount"]').val();
                            var per = Number(document.getElementById('hdnMinimumDuePercent').value) / 100;
                            var dis = tot * per;
                            var amr = Number($('[id$="hdnAmountReceived"]').val());
                            if (amr < dis) {
                                if ($('#HdnDueBillalertMsg').val() != 'Y') {
                                    var ans = ConfirmWindow('Received amount atleast ' + perc + '% of Net amount (Rs:' + dis + ').\n Do you want to continue?');
                                    if (ans == true) {
                                        $('[id$="hdnDue"]').val((Number($('[id$="hdnNetAmount"]').val()) - Number($('[id$="hdnAmountReceived"]').val())));
                                        $('[id$="btnGenerate"]').hide();
                                    }
                                    else {
                                        return false;
                                    }
                                }
                            }
                            $('[id$="hdnDue"]').val((Number($('[id$="hdnNetAmount"]').val()) - Number($('[id$="hdnAmountReceived"]').val())));
                            $('[id$="btnGenerate"]').hide();
                        }
                    }
                    var Needduereason = document.getElementById('hdnDueReasonCollect').value;
                    if (Number($('[id$="hdnNetAmount"]').val()) > Number($('[id$="hdnAmountReceived"]').val()) && Needduereason == "Y") {
                        if ($('#HdnDueBillalertMsg').val() != 'Y') {

                           
                            if (document.getElementById('hdnduechecked').value == "0") {
                                var pBill = ConfirmWindow(vBillAmount, Information, OkMsg, CancelMsg);
                                //    var pBill = confirm("" + vBillAmount + "");
                                if (pBill != true) {
                                    $('[id$="hdnDue"]').val("0.00");
                                    $('[id$="btnGenerate"]').show();
                                    $('[id$="btnClose"]').show();
                                    return false;
                                }
                                else {
                                    var Needduereason = document.getElementById('hdnDueReasonCollect').value; //selva
                                    if (Number($('[id$="hdnNetAmount"]').val()) > Number($('[id$="hdnAmountReceived"]').val()) && $('#hdnNotAllowDue').val() != 'Y' && IsCashClient == 'Y' && Needduereason == "Y") {
                                        if (document.getElementById('hdnduechecked').value == "0") {
                                            $("#dialogdue").empty();
                                            $('#dialogdue').dialog('open');
											var divsToHide = document.getElementsByClassName("ui-dialog-titlebar-close");
                                            //document.getElementsByClassName('ui-button ui-corner-all ui-widget ui-button-icon-only ui-dialog-titlebar-close').style.visibility = 'hidden';
                                            if (divsToHide != null && divsToHide != undefined && divsToHide.length > 0) {
                                                if (divsToHide.length == 3)
                                                    document.getElementsByClassName('ui-dialog-titlebar-close')[2].style.visibility = 'hidden';
                                                else if (divsToHide.length == 2)
                                                    document.getElementsByClassName('ui-dialog-titlebar-close')[1].style.visibility = 'hidden';
                                                else if (divsToHide.length == 1)
                                                    document.getElementsByClassName('ui-dialog-titlebar-close')[0].style.visibility = 'hidden';
                                            }
                                            BindDynamicDueReasonDetails();
                                        }
                                    }
                                    $('[id$="hdnDue"]').val((Number($('[id$="hdnNetAmount"]').val()) - Number($('[id$="hdnAmountReceived"]').val())));
                                    $('[id$="btnGenerate"]').hide();
                                }
                            }
                        }
                    }
                    if (Number($('[id$="hdnNetAmount"]').val()) > Number($('[id$="hdnAmountReceived"]').val()) && $.trim($('[id$="txtClient"]').val()) == '' && Needduereason != "Y") {
                        if ($('#HdnDueBillalertMsg').val() != 'Y') {


                            
                                var pBill = ConfirmWindow(vBillAmount, Information, OkMsg, CancelMsg);
                                //    var pBill = confirm("" + vBillAmount + "");
                                if (pBill != true) {
                                    $('[id$="hdnDue"]').val("0.00");
                                    $('[id$="btnGenerate"]').show();
                                    $('[id$="btnClose"]').show();
                                    return false;
                                }
                                else {
                                    
                                    $('[id$="hdnDue"]').val((Number($('[id$="hdnNetAmount"]').val()) - Number($('[id$="hdnAmountReceived"]').val())));
                                    $('[id$="btnGenerate"]').hide();
                                }
                        }
                    }
                }
                if (IsCopayClient == 'Y') {
                    $('[id$="hdnDue"]').val(0.00);

                }
                //  $('[id$="hdnDue"]').val((Number($('[id$="hdnNetAmount"]').val()) - Number($('[id$="hdnAmountReceived"]').val())));
                $('[id$="btnGenerate"]').hide();
                $('[id$="btnClose"]').hide();
            }
            $('[id$="hdnPatientAlreadyExists"]').val(0);
        }
        //End Modified by arivalagan.kk for copayment//
        else {
            var IsEditPatient;
            IsEditPatient = checkPatientEdit(obj);
            if (IsEditPatient == false) {
                var ans = ConfirmWindow('' + vThereChange + '');
                if (ans == true) {
                    $('#ddlSex').attr("disabled", false);
                    IsRegistrationDeflag()
                    return true;
                }
                else {
                    return false;
                }
            }
        }
    }
    else if (CPEDIT == 'Y' && document.getElementById('hdnIsEditMode').value == 'N') {
        if ($('[id$="hdfBillType1"]').val() == '' && obj != 'Before') {
            //alert('Include billing items');
            CommonControlFocus = "#billPart_txtTestName";
            ValidationWindowResponse(vBillingitems, AlertType, FocusControlAfterValidationWindowResponse);
//            document.getElementById('billPart_txtTestName').focus();
            return false;
        }
    }
    if ((document.getElementById('hdnIsEditMode').value == 'Y') && (document.getElementById('hdnIsEditDeFlag').value != 'Y')) {
        IsRegistrationRepush()
    }
    $('#billPart_hdnMycarddetailsSave').val("");
    var mycardDetails = "";
    var totalRedemAmt = 0.00;
    var RedemAmtData = 0.00;
    var hdnRedeemPoints = $('#billPart_txtRedeem').val();
    $('#cardPoints tr').each(function(i, n) {
        if (i == 0) {
        }
        else {
            var $row = $(n);
            var hdnmyCardDetailsval = $row.find($('input[id$="hdnmyCardDetailsval"]')).val();
            if (typeof (hdnmyCardDetailsval) === "undefined") {
            }
            else {
                var CreditValue = $('#billPart_lblCreditValue').html();
                var splitData = hdnmyCardDetailsval.split('~');

                RedemAmtData = splitData[2];

                if (hdnRedeemPoints - splitData[2] < 0) {
                    splitData[2] = hdnRedeemPoints;
                    splitData[3] = hdnRedeemPoints;
                    hdnRedeemPoints = 0;
                }
                else {
                    hdnRedeemPoints = hdnRedeemPoints - splitData[2];
                }

                mycardDetails = mycardDetails + splitData[0] + "~" + splitData[1] + "~" + splitData[2] + "~" + splitData[3] + "|"

            }
        }
    });
    $('#billPart_hdnMycarddetailsSave').val(mycardDetails);


    AddSpecimenDetails();
    UnDisablePatientDetails();

        var Needduereason = document.getElementById('hdnDueReasonCollect').value; 
        if (Number($('[id$="hdnNetAmount"]').val()) > Number($('[id$="hdnAmountReceived"]').val()) && $('#hdnNotAllowDue').val() != 'Y' && IsCashClient == 'Y' && Needduereason == "Y") {
            return false;
        }
}
function validationEvents(obj) {
    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var vProvidepatient = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_11') == null ? "Provide patient name" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_11');
    var vProvidepatientage = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_13') == null ? "Provide patient age or date of birth" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_13');
    var vSelectpatien = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_14') == null ? "Select patient sex" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_14');
    var vProvidecontactmobile = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_17') == null ? "Provide contact mobile or telephone number" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_17');
    var vProvideavalidemail = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_22') == null ? "Provide a valid e-mail address" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_22');

    if ($('#txtName').val() != undefined && $.trim($('#txtName').val()) == '') {
        var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
        alert(AlertType);
        //alert('Provide patient name');
        CommonControlFocus = "#txtName";
        ValidationWindowResponse(vProvidepatient, AlertType, FocusControlAfterValidationWindowResponse);
        //        $('#txtName').focus();
        return false;
    }
    if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' ||
    document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' ||
    document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy') && (document.getElementById('hdnIncompleteAge').value != 'Y')) {
        //alert('Provide patient age or date of birth');
        CommonControlFocus = "#txtDOBNos";

        ValidationWindowResponse(vProvidepatientage, AlertType, FocusControlAfterValidationWindowResponse);
//        document.getElementById('txtDOBNos').focus();
        return false;
    }
    if ((document.getElementById('ddlSex').selectedIndex != '-1') || (document.getElementById('ddlSex').selectedIndex != '0')) {
        if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
            //alert('Select patient sex');
            CommonControlFocus = "#ddlSex";
            ValidationWindowResponse(vSelectpatien, AlertType, FocusControlAfterValidationWindowResponse);
//            document.getElementById('ddlSex').focus();
            return false;
        }

    }
    if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '') {
        //alert('Provide contact mobile or telephone number');
        CommonControlFocus = "#txtMobileNumber";

        ValidationWindowResponse(vProvidecontactmobile, AlertType, FocusControlAfterValidationWindowResponse);
//        $('#txtMobileNumber').focus();
        return false;
    }


    if ($.trim($('#txtEmail').val()) != '') {
        var x = document.getElementById('txtEmail').value;
        var atpos = x.indexOf("@");
        var dotpos = x.lastIndexOf(".");
        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
            //alert("Provide a valid e-mail address");
            CommonControlFocus = "#txtEmail";

            ValidationWindowResponse(vProvideavalidemail, AlertType, FocusControlAfterValidationWindowResponse);
//            $('#txtEmail').focus();
            return false;
        }
    }

}
function BindDynamicDueReasonDetails() {
    
    document.getElementById('hdnduereasonddl').value = "";
    document.getElementById('hdnduereasontext').value = "";
    document.getElementById('hdndueauthorisedbyid').value = "";
    document.getElementById('hdndueauthorisedbyname').value = "";
    //document.getElementById('hdnduechecked').value = "0";
    
    
var tablehead = "";
var ReasonID = 0;
var ReasonTypeID = 0;
var ReasonCode = "DIS";

tablehead = "<table id='tblduereason' class='w-100p lh35'><tr>"
var Reinptstr = "";
var Reinptstr1 = "";
var Reinptstr2  = "";

		Reinptstr = BindDynamicReasonDetails(ReasonID, ReasonTypeID, ReasonCode);
        tablehead += "<td><span>  Reason  </span></td><td>" + Reinptstr + "</td>";
        Reinptstr1 = '<input type="text" name="txtDueReason" id="txtDueReason" style="visibility:hidden;">';
        Reinptstr2 = '<input type="text" name="txtDueAuthorizedby" id="txtDueAuthorizedby">';
        tablehead += "<td>" + Reinptstr1 + "</td> <td><span> Authorised By</span></td> <td> " + Reinptstr2 + "</td>";
        tablehead += "</tr>";

        tablehead += "</table><br/><div><table style='width: 100%;'><tr><td style='width: 50%;' align= 'Center'><input type='button' id='btndueSave' Class='btn' onclick='return SaveDueReasonDetails()' value='Save' /></td></tr></table></div>";
        //onclick='SaveDueReasonDetails()'
        $('#dialogdue').append(tablehead);
        

        $("#ddlduereasonj").change(function() {
            var selectedDuereason = $('option:selected', this).text();
            if (selectedDuereason == "Others") {
                $('#txtDueReason').css('visibility', 'visible');
                document.getElementById('hdnduereasonddl').value = $('option:selected', this).text();
                document.getElementById('hdnduereasontext').value = $('#txtDueReason').val();
                //$("#txtDueReason").show()
            }
            else {
                $('#txtDueReason').css('visibility', 'hidden');
               // document.getElementById('hdnduereasontext').value = $('option:selected', this).text();
                document.getElementById('hdnduereasonddl').value = $('option:selected', this).text();
                
                
            }
        });

        var OrgID = document.getElementById('hdnOrgID').value;
        var AuthTypeName = "";

        $("[id$=txtDueAuthorizedby]").autocomplete({
            source: function(request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: '../WebService.asmx/getauthrisorsWithNameandID',
                    data: "{'prefixText': '" + request.term + "','contextKey':'" + OrgID + '~' + AuthTypeName + "'}",
                    dataType: "json",
                    success: function(data) {
                        if (data.d.length > 0) {
                            response($.map(data.d, function(item) {

                                try {
                                
                                    var rsltlable = item.SpecialityName;
                                    var rsltvalue = item.LoginID;
                                    return {
                                        label: rsltlable,
                                        val: rsltvalue

                                    }
                                }
                                catch (er) {
                                }
                            }


                    ))
                        } else {
                            response([{ label: 'No results found.', val: -1}]);
                            Clear();

                        }
                    },
                    error: function(response) {
                        alert(response.responseText);
                    },
                    failure: function(response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function(e, i) {
                if (i.item.val == -1) {
                    $("#hdndueauthorisedbyname").val("");
                    $("#hdndueauthorisedbyid").val("");
                }
                else {
                    $("#hdndueauthorisedbyid").val(i.item.val);
                    $("#hdndueauthorisedbyname").val(i.item.label);
                }
            },
            minLength: 2
        });
        return false; 
    }


    function SaveDueReasonDetails() {
        
        if (document.getElementById('hdnduereasonddl').value == 'Others') {
            document.getElementById('hdnduereasontext').value = $('#txtDueReason').val();
            if (document.getElementById('hdnduereasontext').value == '') {
                alert('Please Enter the Due Reason');
                return false;
            }
        }
        if (document.getElementById('hdnduereasonddl').value == '') {
            alert('Please select the Due Reason');
            return false;
        }
        if (document.getElementById('txtDueAuthorizedby').value == ""  || document.getElementById('txtDueAuthorizedby').value == null ||
        document.getElementById('txtDueAuthorizedby').value == undefined) {
            document.getElementById('hdndueauthorisedbyid').value = "";
            alert('Please select the Due Authorizer');
            return false;
            
        }
        if (document.getElementById('hdndueauthorisedbyid').value == '' || document.getElementById('hdndueauthorisedbyid').value == -1) {
            alert('Please Select the Due Authorizer');
            return false;
        }
        if (document.getElementById('hdnduereasontext').value != '' || document.getElementById('hdnduereasonddl').value != '' && document.getElementById('hdndueauthorisedbyid').value != '' && document.getElementById('hdndueauthorisedbyid').value != -1) {
            document.getElementById('hdnduechecked').value = "1";
            $('#dialogdue').dialog('close');
            validateEvents('After');
            alert('Due Save completed');
            javascript: __doPostBack('btnGenerate');
            return true;
        }
        
   }
function BindDynamicReasonDetails(ReasonID, ReasonTypeID, ReasonCode) {//selva
    var Result = [];
    var drpdwn = "<Select id=ddlduereasonj>";
    var Others = "Others"
    drpdwn += "<option value=" + "001" + " >" + "Select" + "</option>"
if (ReasonCode != null && ReasonCode != "") {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetDueReasonMaster",
            data: "{ 'pReasonCategoryID': " + ReasonID + ",'pReasonTypeID':" + ReasonTypeID + ",'ReasonCode': '" + ReasonCode + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
            Result = JSON.parse(data.d);
            $.each(Result, function(key, value) {            
            
            drpdwn += "<option value=" + value.ReasonCode + " >" + value.Reason + "</option>"//selected='selected'
        });
           drpdwn += "<option value=" + Others + " >" + Others + "</option>"
            drpdwn += "</Select>";
},
            failure: function(msg) {
            ShowErrorMessage(msg);
        }
    });
    return drpdwn;
}
}
//jayamoorthi--------------------------------------------
function checkPatientEdit(obj) {
    // alert(document.getElementById('hdnPatientAge').value);
    //       alert(document.getElementById('hdnPatientDOB').value);
    //       alert(document.getElementById('hdnPatientSex').value);
    //       alert(document.getElementById('hdnIsEditMode').value);
    if (document.getElementById('hdnIsEditMode').value == 'Y' && obj == 'After') {
        //if ((parseInt(document.getElementById('txtDOBNos').value) != parseInt(document.getElementById('hdnPatientAge').value)) || (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value != document.getElementById('hdnPatientSex').value) || (document.getElementById('tDOB').value.trim() != document.getElementById('hdnPatientDOB').value)) {
        if (((document.getElementById('txtDOBNos').value.trim()) != (document.getElementById('hdnPatientAge').value.trim())) || (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value != document.getElementById('hdnPatientSex').value) || (document.getElementById('tDOB').value.trim() != document.getElementById('hdnPatientDOB').value) || (document.getElementById('tDOB').value.trim() != document.getElementById('hdnDOBMonth').value)) {

            return false;
        }
        else {
            return true;
        }
    }

}

function SelectedTemp(source, eventArgs) {
    document.getElementById('hdnSelectedPatientTempDetails').value = eventArgs.get_value();
    Tblist();

}
function PatientdetailsHide() {
    var x = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");
    if ($('#txtName').val() != '' && x[0] == $('#txtName').val()) {
        $('[id$="trPatientDetails"]').show();
    }
    else {
        document.getElementById('hdnSelectedPatientTempDetails').value = '';
        $('[id$="trPatientDetails"]').hide();
    }
    var searchvalue, searchtype;
    var searchtypeRadioList = document.getElementsByName('rblSearchType');
    var OrgID = document.getElementById('hdnOrgID').value;
    var NewOrgID = document.getElementById('hdnNewOrgID').value;

    for (var i = 0; i < searchtypeRadioList.length; i++) {
        if (searchtypeRadioList[i].checked) {
            searchtype = searchtypeRadioList[i].value
            break;
        }
    }
    document.getElementById('billPart_chkAddExtraTest').checked = false;
    if (document.getElementById('hdnExternalBarcode').value == "Y") {
        if (searchtype == 0 || searchtype == 1) {
            document.getElementById('billPart_tdAdditionalTest').style.display = "block";
            document.getElementById('billPart_tdlblAdditionalTest').style.display = "block";
        }
        else {
            document.getElementById('billPart_tdAdditionalTest').style.display = "none";
            document.getElementById('billPart_tdlblAdditionalTest').style.display = "none";
            document.getElementById('billPart_chkAddExtraTest').checked = false;
        }
    }
}

function Tblist() {
    var vName = SListForAppDisplay.Get("Billing_LabQuickBilling_js_01") == null ? "Name" : SListForAppDisplay.Get("Billing_LabQuickBilling_js_01");
    var vNumber = SListForAppDisplay.Get("Billing_LabQuickBilling_js_02") == null ? "Number" : SListForAppDisplay.Get("Billing_LabQuickBilling_js_02");
    var vOrgName = SListForAppDisplay.Get("Billing_LabQuickBilling_js_03") == null ? "OrgName" : SListForAppDisplay.Get("Billing_LabQuickBilling_js_03");
    var vURNNo = SListForAppDisplay.Get("Billing_LabQuickBilling_js_04") == null ? "URNNo" : SListForAppDisplay.Get("Billing_LabQuickBilling_js_04");
    var vAddress = SListForAppDisplay.Get("Billing_LabQuickBilling_js_05") == null ? "Address" : SListForAppDisplay.Get("Billing_LabQuickBilling_js_05");
    var vPhone = SListForAppDisplay.Get("Billing_LabQuickBilling_js_06") == null ? "Phone" : SListForAppDisplay.Get("Billing_LabQuickBilling_js_06");
    $('[id$="trPatientDetails"]').show();
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    $('[id$="lblPatientDetails"]').html("");
    table = "<table cellpadding='1' class='dataheaderInvCtrl gridView' cellspacing='0' border='0'"
                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
                           + "<th style='width:80px;'>"+vName+"</th>"
                           + "<th style='width:50px;'>"+vNumber+"</th>"
                           + "<th style='width:40px;'>"+vOrgName+"</th>"
                            + "<th style='width:20px;'>"+vURNNo+"</th>"
                           + "<th style='width:300px;'>"+vAddress+"</th>"
                           + "<th style='Widht:100px;'>" + vPhone + "</th> </thead>";
    var x = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");

    tr = "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
                        + x[0] + "</td><td style='width:100px;'>"
                        + x[1] + "</td><td style='width:100px;'>"
                        + x[2] + "</td><td style='width:100px;'>"
                        + x[3] + "</td><td style='width:20px;'>"
                        + x[4] + ',' + x[5] + ',' + x[6] + "</td><td style='width:100px;'>"
                        + x[7] + "</td></tr>";
    var tab = table + tr + end;
    $('[id$="lblPatientDetails"]').html(tab);
    tbshow();

}
function SelectedPatientClient(patientVal) {
    var vPatientDetails = SListForAppDisplay.Get("Billing_CommonBilling_js_69") == null ? "Patient Details" : SListForAppDisplay.Get("Billing_CommonBilling_js_69")
    var vPatientNo = SListForAppDisplay.Get("Billing_CommonBilling_js_68") == null ? "Patient No:" : SListForAppDisplay.Get("Billing_CommonBilling_js_68")
    $("#showimage").attr("style", "display:none");
    var isPatientDetails = "";
    //    isPatientDetails = eventArgs.get_value().split('|')[0];
    var PatientName = patientVal.split(':')[0];
    var PatientNumber = patientVal.split(':')[1];
    var PatientVisitType = patientVal.split(':')[2];
    var contextKey = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");
    contextKey = contextKey[8] + ':' + contextKey[10]; //Added by Jayaramanan L 
    var a = $('#hdnContextText').val().split('~');
    if (a[2] == 3) {
        var contextKeyType = document.getElementById('hdnSelectedPatientTempDetails').value.split("~")
        document.getElementById('hdnBookingType').value = contextKeyType[9];
        document.getElementById('hdnHealthiBookingID').value = contextKeyType[10]; //Added by Jayaramanan L 
    }

    if (contextKey != '') {
        var PatientID;
        PatientID = patientVal.split(':')[1];
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../OPIPBilling.asmx/GetQuickPatientSearchDetails",
            data: JSON.stringify({ PatientID: PatientID, contextKey: contextKey }),
            dataType: "json",
            async: false,
            success: function(data, value) {

                var GetData = "";
                if (data.d.length > 0) {
                    GetData = JSON.parse(data.d[0]);

                    //var PatientName = GetData.First.split(':')[0];
                    var isPatientDetails = GetData.Second;
                    var PatientTITLECode = isPatientDetails.split('~')[0];
                    var PatientName = isPatientDetails.split('~')[1];
                    var PatientNumber = isPatientDetails.split('~')[2];
                    var PatientAge = isPatientDetails.split('~')[3];
                    var PatientDOB = isPatientDetails.split('~')[4];
                    var PatientSex = isPatientDetails.split('~')[5];
                    var PatientMaritalStatus = isPatientDetails.split('~')[6];
                    var PatientMobile = isPatientDetails.split('~')[7].split(',')[0].trim();
                    if (isPatientDetails.split('~')[7].split(',')[1] != null) {
                        var PatientPhone = isPatientDetails.split('~')[7].split(',')[1].trim();
                    }
                    var PatientAddress = isPatientDetails.split('~')[8];
                    var PatientCity = isPatientDetails.split('~')[9];
                    var PostalCode = isPatientDetails.split('~')[10];
                    var PatientNationality = isPatientDetails.split('~')[11];
                    var PatientCountryID = isPatientDetails.split('~')[12];
                    var PatientStateID = isPatientDetails.split('~')[13];
                    var PatientID = isPatientDetails.split('~')[14];
                    var PatientEmailID = isPatientDetails.split('~')[15];
                    var URNNo = isPatientDetails.split('~')[16];
                    var URNofId = isPatientDetails.split('~')[17];
                    var URNTypeId = isPatientDetails.split('~')[18];
                    var VisitPurpose = 3
                    var PatientPreviousDue = isPatientDetails.split('~')[19];
                    var Address2 = isPatientDetails.split('~')[20];
                    var ExternalPatientNumber = isPatientDetails.split('~')[21];
                    var PatientType = isPatientDetails.split('~')[22];
                    var PatientStatus = isPatientDetails.split('~')[23];
                    var ClientName = isPatientDetails.split('~')[24];
                    
                    if (ClientName != null && ClientName != '' && ClientName != 'GENERAL') {
                        document.getElementById('txtClient').value = ClientName;
                    }
                    var ReferedPhydtls = isPatientDetails.split('~')[25];
                    var ReferedPhyName = ReferedPhydtls.split(':')[0];
                    var ReferedPhyID = 0;
                    if (ReferedPhydtls.split(':').length > 1) { ReferedPhyID = ReferedPhydtls.split(':')[1] };
                    //var NewOrgID = isPatientDetails.split('~')[24];
                    //var DispatchedMode = isPatientDetails.split('~')[33];
                    var ExternelVisitID = isPatientDetails.split('~')[42];
                    var Notifications = isPatientDetails.split('~')[44];
                    //var ClientName = isPatientDetails.split('~')[29];

                    var NewOrgID = isPatientDetails.split('~')[33];
                    var DispatchedMode = isPatientDetails.split('~')[29];

                    var patientvid = isPatientDetails.split('~')[30];
                    //var IsCashClient = isPatientDetails.split('~')[34];
                    var ClientID = isPatientDetails.split('~')[45]
                    $('#hdnSelectedClientClientID').val(ClientID);
                    counti = 0;
                    BindDynamicFields();
                    document.getElementById('hdnVisitID').value = patientvid;
                    var IsCashClient = isPatientDetails.split('~')[46];
                    if (document.getElementById('hdnBookedID') != null) {
                        document.getElementById('hdnBookedID').value = isPatientDetails.split('~')[47];
                    }
                    //End Modified by arivalagan.kk for copayment//
                    var IsCopay = isPatientDetails.split('~')[48];
//                    var IsCopay = isPatientDetails.split('~')[48].trim();

                    var patientvid = isPatientDetails.split('~')[30];

                    var HealthHubID = isPatientDetails.split('~')[50];
                    
                    if (HealthHubID != null) {
                        document.getElementById('txtHealthHubID').value = HealthHubID;
                    }

                    if (URNNo != "" && URNTypeId == 6) {
                        SetDiscountLimit(URNNo);
                    }
                    var HasMyCard = document.getElementById('billPart_hdnHasMyCard').value;
                    if (HasMyCard == 'Y') {
                        $('#dvMycard').show();
                    }
                    var PhleboName = isPatientDetails.split('~')[35];
                    if (PhleboName != null) {
                        document.getElementById('txtPhleboName').value = PhleboName;
                        document.getElementById('HdnPhleboName').value = PhleboName;
                    }
                    var PhleboID = isPatientDetails.split('~')[36];
                    document.getElementById('HdnPhleboID').value = PhleboID;

                    document.getElementById('ddSalutation').value = PatientTITLECode
                    document.getElementById('txtName').value = PatientName;
                    document.getElementById('txtInternalExternalPhysician').value = ReferedPhyName;
                    document.getElementById('hdnReferedPhyID').value = ReferedPhyID;

                    document.getElementById('hdnPatientNumber').value = PatientNumber
                    document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
                    document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
                    document.getElementById('ddlSex').value = PatientSex;
                    if (document.getElementById('hdnEditSex') != null) {
                        document.getElementById('hdnEditSex').value = PatientSex;
                    }
                    document.getElementById('ddMarital').value = PatientMaritalStatus;
                    document.getElementById('txtMobileNumber').value = PatientMobile;
                    CheckSMS();
                    if (PatientPhone != null) {
                        document.getElementById('txtPhone').value = PatientPhone;
                    }
                    document.getElementById('txtAddress').value = PatientAddress.trim();
                    document.getElementById('txtCity').value = PatientCity;
                    if (PatientNationality != '') {
                        if (document.getElementById('ddlNationality') != null) {
                            document.getElementById('ddlNationality').value = PatientNationality;
                        }
                    }
                    if ($('#txtExternalVisitID').val() != undefined) {
                        document.getElementById('txtExternalVisitID').value = ExternelVisitID;
                        //document.getElementById('txtExternalVisitID').disabled = true;
                    }
                    document.getElementById('ddCountry').value = PatientCountryID;
                    //document.getElementById('ddCountry').onchange();
                    document.getElementById('hdnPatientStateID').value = PatientStateID;
                    document.getElementById('ddState').value = PatientStateID;
                    if (PatientStateID == "") {
                        loadState("11");
                    }
                    document.getElementById('hdnPatientID').value = PatientID;
                    var textBox = $get('tDOB');
                    if (textBox.AjaxControlToolkitTextBoxWrapper) {
                        textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
                    }
                    else {
                        textBox.value = PatientDOB;
                    }
                    document.getElementById('txtPincode').value = PostalCode;
                    document.getElementById('txtEmail').value = PatientEmailID;
                    document.getElementById('txtURNo').value = URNNo;
                    document.getElementById('hdnNewOrgID').value = NewOrgID;
                    document.getElementById('ddlUrnoOf').value = URNofId;
                    document.getElementById('ddlUrnType').value = URNTypeId;
                    document.getElementById('lblPatientDetails').innerHTML = '';
                    document.getElementById('trPatientDetails').style.display = "none";

                    if (DispatchedMode != undefined) {
                        var LstDispatchedMode = DispatchedMode.split(",");
                        for (var j = 0; j < LstDispatchedMode.length; j++) {
                            $('[id$="chkDespatchMode"] input[type=checkbox]').each(function(i) {
                                if (($("#" + $(this).filter().context.id).next().text()) == LstDispatchedMode[j]) {
                                    this.checked = true;
                                }
                            });
                        }
                    }
                    if (Notifications != undefined) {
                        var lstNotification = Notifications.split(",");
                        for (var j = 0; j < lstNotification.length; j++) {
                            $('[id$="ChkNotification"] input[type=checkbox]').each(function(i) {
                                if (($("#" + $(this).filter().context.id).next().text()) == lstNotification[j]) {
                                    this.checked = true;
                                }
                            });
                        }
                    }
                    //Modified by arivalagan.kk for copayment//
                    if (ClientName != null && ClientName != undefined && ClientName != "" && ClientName != 'GENERAL') {
                        document.getElementById('txtClient').value = ClientName;
                        document.getElementById('hdnSelectedClientClientID').value = ClientID;
                        if (IsCopay != null && IsCopay != undefined && IsCopay != "") {
                            document.getElementById('HdnCoPay').value = IsCopay;
                        }
                    }
                    //Modified by arivalagan.kk for copayment//
                    //Getdigitalnumber(document.getElementById('lblPreviousDueText'), PatientPreviousDue);
                    if (document.getElementById('billPart_lblPreviousDueText') != null) {
                        document.getElementById('billPart_lblPreviousDueText').innerHTML = PatientPreviousDue;
                    }
                    if (document.getElementById('txtSuburban') != null) {
                        document.getElementById('txtSuburban').value = Address2;
                    }
                    if (document.getElementById('txtExternalPatientNumber') != null) {
                        document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
                    }
                    var panelLegend = $('#PnlPatientDetail legend');
                    //panelLegend.html("Patient Details ").append('<b>(Patient No: ' + PatientNumber + ' )</b>');
                    panelLegend.html(vPatientDetails).append('<b>(' + vPatientNo + PatientNumber + ')</b>');
                    document.getElementById('PnlPatientDetail');
                    document.getElementById('hdnPatientName').value = PatientName;
                    document.getElementById('hdnPatientID').value = PatientID;
                    document.getElementById('hdnPatientEmailId').value = PatientEmailID;
                    document.getElementById('hdnDOBMonth').value = PatientDOB;
                    // document.getElementById('hdnReferringDoctor').value = ReferingPhysicianName;
                    document.getElementById('hdnPhoneNo').value = PatientPhone;
                    document.getElementById('hdnMobileNo').value = PatientMobile;
                    document.getElementById('hdnPatientAddress').value = PatientAddress;
                    document.getElementById('hdnIsCashClient').value = IsCashClient;
                    document.getElementById('billPart_hdnIsCashClient').value = IsCashClient;
                    ClearmycardDetails('Y');
                    if (document.getElementById('txtClient') != null) {
                        if (document.getElementById('hdnBookedID').value != '0' && document.getElementById('hdnBookedID').value != '') {
                            LoadBookedpatientDetails();
                        }
                        else if (document.getElementById('hdnHealthiBookingID').value != '0' && document.getElementById('hdnHealthiBookingID').value != '') {
                            LoadBookedpatientDetailsForHealthiAPI();
                        }
                        else {
                            LoadPreviousBillingItemsForPatient();
                        }
                    }
                    else {
                        document.getElementById('hdnPatientID').value = PatientID;
                        if (document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML != "") {
                            document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML = "";
                        }
                        document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
                        LoadComplaintItems((eventArgs.get_value().split('|')[1]));
                        document.getElementById('txtAddress').focus();
                        var list = ((eventArgs.get_value().split('|')[2]).substring(0, (eventArgs.get_value().split('|')[2]).length - 1)).split('~');
                        while (count = document.getElementById('PatientPreference1_PatientPreference').rows.length) {

                            for (var j = 0; j < document.getElementById('PatientPreference1_PatientPreference').rows.length; j++) {
                                document.getElementById('PatientPreference1_PatientPreference').deleteRow(j);

                            }
                        }
                        if ((eventArgs.get_value().split('|')[2]) != "") {
                            for (var count = 0; count < list.length; count++) {
                                var CList = list[count].split('~');
                                var row = document.getElementById('PatientPreference1_PatientPreference').insertRow(0);
                                row.id = parseInt(count);
                                var rwNumber = row.id;
                                var cell1 = row.insertCell(0);
                                var cell2 = row.insertCell(1);
                                var cell3 = row.insertCell(2);
                                cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclickPreference(" + parseInt(rwNumber) +
                            ");' style='cursor:pointer;'  src='../Images/Delete.jpg' />";
                                cell2.innerHTML = CList[0];
                                cell3.innerHTML = "<input onclick='btnEditPreference_OnClick(name);' name='" + parseInt(rwNumber) + "^" + CList[0] +
                            "' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                                if (rwNumber == '0') {
                                    document.getElementById('hdnPreference').value += rwNumber + "^" + CList[0];
                                }
                                else {
                                    document.getElementById('hdnPreference').value += "~" + rwNumber + "^" + CList[0];
                                }
                                document.getElementById('PatientPreference1_PatientPreference').style.display = 'block';
                            }

                        }
                        if (document.getElementById('billPart_UcHistory_hdnPreference') != null) {
                            document.getElementById('billPart_UcHistory_hdnPreference').value = (eventArgs.get_value().split('|')[2]).substring(0,
                        (eventArgs.get_value().split('|')[2]).length - 1);
                        }
                        document.getElementById('btnSaveEMR').value = 'Update';
                    }
                }
            },
            error: function(result) {
                alert("Error");
            }
        });
    }
}
function SelectedPatient(source, eventArgs) {
    var vPatientDetails = SListForAppDisplay.Get("Billing_CommonBilling_js_69") == null ? "Patient Details" : SListForAppDisplay.Get("Billing_CommonBilling_js_69")
    var vPatientNo = SListForAppDisplay.Get("Billing_CommonBilling_js_68") == null ? "Patient No:" : SListForAppDisplay.Get("Billing_CommonBilling_js_68")
    $("#showimage").attr("style", "display:none");
    var isPatientDetails = "";
    //    isPatientDetails = eventArgs.get_value().split('|')[0];
    var PatientName = eventArgs.get_text().split(':')[0];
    var PatientNumber = eventArgs.get_text().split(':')[1];
    var PatientVisitType = eventArgs.get_text().split(':')[2];
    var contextKey = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");
    contextKey = contextKey[8];
    var a = $find('AutoCompleteExtenderPatient')._contextKey.split('~');
    if (a[2] == 3) {
        var contextKeyType = document.getElementById('hdnSelectedPatientTempDetails').value.split("~")
        document.getElementById('hdnBookingType').value = contextKeyType[9];
    }                                                        
    
    if (contextKey != '') {
        var PatientID;
        PatientID = contextKey.split(':')[1];
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../OPIPBilling.asmx/GetQuickPatientSearchDetails",
            data: JSON.stringify({ PatientID: PatientID, contextKey: contextKey }),
            dataType: "json",
            async: false,
            success: function(data, value) {
                var GetData = JSON.parse(data.d[0]);
                //var PatientName = GetData.First.split(':')[0];
                var isPatientDetails = GetData.Second;
                var PatientTITLECode = isPatientDetails.split('~')[0];
                var PatientName = isPatientDetails.split('~')[1];
                var PatientNumber = isPatientDetails.split('~')[2];
                var PatientAge = isPatientDetails.split('~')[3];
                var PatientDOB = isPatientDetails.split('~')[4];
                var PatientSex = isPatientDetails.split('~')[5];
                var PatientMaritalStatus = isPatientDetails.split('~')[6];
                var PatientMobile = isPatientDetails.split('~')[7].split(',')[0].trim();
                if (isPatientDetails.split('~')[7].split(',')[1] != null) {
                    var PatientPhone = isPatientDetails.split('~')[7].split(',')[1].trim();
                }
                var PatientAddress = isPatientDetails.split('~')[8];
                var PatientCity = isPatientDetails.split('~')[9];
                var PostalCode = isPatientDetails.split('~')[10];
                var PatientNationality = isPatientDetails.split('~')[11];
                var PatientCountryID = isPatientDetails.split('~')[12];
                var PatientStateID = isPatientDetails.split('~')[13];
                var PatientID = isPatientDetails.split('~')[14];
                var PatientEmailID = isPatientDetails.split('~')[15];
                var URNNo = isPatientDetails.split('~')[16];
                var URNofId = isPatientDetails.split('~')[17];
                var URNTypeId = isPatientDetails.split('~')[18];
                var VisitPurpose = 3
                var PatientPreviousDue = isPatientDetails.split('~')[19];
                var Address2 = isPatientDetails.split('~')[20];
                var ExternalPatientNumber = isPatientDetails.split('~')[21];
                var PatientType = isPatientDetails.split('~')[22];
                var PatientStatus = isPatientDetails.split('~')[23];
                var ClientName = isPatientDetails.split('~')[24];
                
                //var NewOrgID = isPatientDetails.split('~')[24];
                //var DispatchedMode = isPatientDetails.split('~')[33];
                var Notifications = isPatientDetails.split('~')[44];
                //var ClientName = isPatientDetails.split('~')[29];

                var NewOrgID = isPatientDetails.split('~')[33];
                var DispatchedMode = isPatientDetails.split('~')[29];


                //var IsCashClient = isPatientDetails.split('~')[34];
                var ClientID = isPatientDetails.split('~')[45]
                var IsCashClient = isPatientDetails.split('~')[46];
                if (document.getElementById('hdnBookedID') != null) {
                    document.getElementById('hdnBookedID').value = isPatientDetails.split('~')[47];
                }
                //End Modified by arivalagan.kk for copayment//
                var IsCopay = isPatientDetails.split('~')[48].trim();

                if (URNNo != "" && URNTypeId == 6) {
                    SetDiscountLimit(URNNo);
                }
                var HasMyCard = document.getElementById('billPart_hdnHasMyCard').value;
                if (HasMyCard == 'Y') {
                    $('#dvMycard').show();
                }
                document.getElementById('ddSalutation').value = PatientTITLECode
                document.getElementById('txtName').value = PatientName;
                document.getElementById('hdnPatientNumber').value = PatientNumber
                document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
                document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
                document.getElementById('ddlSex').value = PatientSex;
                if (document.getElementById('hdnEditSex') != null) {
                    document.getElementById('hdnEditSex').value = PatientSex;
                }
                document.getElementById('ddMarital').value = PatientMaritalStatus;
                document.getElementById('txtMobileNumber').value = PatientMobile;
                CheckSMS();
                if (PatientPhone != null) {
                    document.getElementById('txtPhone').value = PatientPhone;
                }
                document.getElementById('txtAddress').value = PatientAddress.trim();
                document.getElementById('txtCity').value = PatientCity;
                if (PatientNationality != '') {
                    if (document.getElementById('ddlNationality') != null) {
                        document.getElementById('ddlNationality').value = PatientNationality;
                    }
                }
                document.getElementById('ddCountry').value = PatientCountryID;
                //document.getElementById('ddCountry').onchange();
                document.getElementById('hdnPatientStateID').value = PatientStateID;
                document.getElementById('ddState').value = PatientStateID;
                if (PatientStateID == "") {
                    loadState("11");
                }
                document.getElementById('hdnPatientID').value = PatientID;
                var textBox = $get('tDOB');
                if (textBox.AjaxControlToolkitTextBoxWrapper) {
                    textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
                }
                else {
                    textBox.value = PatientDOB;
                }
                document.getElementById('txtPincode').value = PostalCode;
                document.getElementById('txtEmail').value = PatientEmailID;
                document.getElementById('txtURNo').value = URNNo;
                document.getElementById('hdnNewOrgID').value = NewOrgID;
                document.getElementById('ddlUrnoOf').value = URNofId;
                document.getElementById('ddlUrnType').value = URNTypeId;
                document.getElementById('lblPatientDetails').innerHTML = '';
                document.getElementById('trPatientDetails').style.display = "none";

                if (DispatchedMode != undefined) {
                    var LstDispatchedMode = DispatchedMode.split(",");
                    for (var j = 0; j < LstDispatchedMode.length; j++) {
                        $('[id$="chkDespatchMode"] input[type=checkbox]').each(function(i) {
                            if (($("#" + $(this).filter().context.id).next().text()) == LstDispatchedMode[j]) {
                                this.checked = true;
                            }
                        });
                    }
                }
                if (Notifications != undefined) {
                    var lstNotification = Notifications.split(",");
                    for (var j = 0; j < lstNotification.length; j++) {
                        $('[id$="ChkNotification"] input[type=checkbox]').each(function(i) {
                            if (($("#" + $(this).filter().context.id).next().text()) == lstNotification[j]) {
                                this.checked = true;
                            }
                        });
                    }
                }
                //Modified by arivalagan.kk for copayment//
                if (ClientName != null && ClientName != undefined && ClientName != "") {
                    document.getElementById('txtClient').value = ClientName;
                    document.getElementById('hdnSelectedClientClientID').value = ClientID;
                    if (IsCopay != null && IsCopay != undefined && IsCopay != "") {
                        document.getElementById('HdnCoPay').value = IsCopay;
                    }
                }
                //Modified by arivalagan.kk for copayment//
                //Getdigitalnumber(document.getElementById('lblPreviousDueText'), PatientPreviousDue);
                if (document.getElementById('billPart_lblPreviousDueText') != null) {
                    document.getElementById('billPart_lblPreviousDueText').innerHTML = PatientPreviousDue;
                }
                if (document.getElementById('txtSuburban') != null) {
                    document.getElementById('txtSuburban').value = Address2;
                }
                if (document.getElementById('txtExternalPatientNumber') != null) {
                    document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
                }
                var panelLegend = $('#PnlPatientDetail legend');
                //panelLegend.html("Patient Details ").append('<b>(Patient No: ' + PatientNumber + ' )</b>');
                panelLegend.html(vPatientDetails).append('<b>(' + vPatientNo + PatientNumber + ')</b>');
                document.getElementById('PnlPatientDetail');
                document.getElementById('hdnPatientName').value = PatientName;
                document.getElementById('hdnPatientID').value = PatientID;
                document.getElementById('hdnPatientEmailId').value = PatientEmailID;
                document.getElementById('hdnDOBMonth').value = PatientDOB;
                // document.getElementById('hdnReferringDoctor').value = ReferingPhysicianName;
                document.getElementById('hdnPhoneNo').value = PatientPhone;
                document.getElementById('hdnMobileNo').value = PatientMobile;
                document.getElementById('hdnPatientAddress').value = PatientAddress;
                document.getElementById('hdnIsCashClient').value = IsCashClient;
                document.getElementById('billPart_hdnIsCashClient').value = IsCashClient;
                ClearmycardDetails('Y');
                if (document.getElementById('txtClient') != null) {
                    if (document.getElementById('hdnBookedID').value != '0') {
                        LoadBookedpatientDetails();
                    }
                    else {
                        LoadPreviousBillingItemsForPatient();
                    }
                }
                else {
                    document.getElementById('hdnPatientID').value = PatientID;
                    if (document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML != "") {
                        document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML = "";
                    }
                    document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
                    LoadComplaintItems((eventArgs.get_value().split('|')[1]));
                    document.getElementById('txtAddress').focus();
                    var list = ((eventArgs.get_value().split('|')[2]).substring(0, (eventArgs.get_value().split('|')[2]).length - 1)).split('~');
                    while (count = document.getElementById('PatientPreference1_PatientPreference').rows.length) {

                        for (var j = 0; j < document.getElementById('PatientPreference1_PatientPreference').rows.length; j++) {
                            document.getElementById('PatientPreference1_PatientPreference').deleteRow(j);

                        }
                    }
                    if ((eventArgs.get_value().split('|')[2]) != "") {
                        for (var count = 0; count < list.length; count++) {
                            var CList = list[count].split('~');
                            var row = document.getElementById('PatientPreference1_PatientPreference').insertRow(0);
                            row.id = parseInt(count);
                            var rwNumber = row.id;
                            var cell1 = row.insertCell(0);
                            var cell2 = row.insertCell(1);
                            var cell3 = row.insertCell(2);
                            cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclickPreference(" + parseInt(rwNumber) +
                            ");' style='cursor:pointer;'  src='../Images/Delete.jpg' />";
                            cell2.innerHTML = CList[0];
                            cell3.innerHTML = "<input onclick='btnEditPreference_OnClick(name);' name='" + parseInt(rwNumber) + "^" + CList[0] +
                            "' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                            if (rwNumber == '0') {
                                document.getElementById('hdnPreference').value += rwNumber + "^" + CList[0];
                            }
                            else {
                                document.getElementById('hdnPreference').value += "~" + rwNumber + "^" + CList[0];
                            }
                            document.getElementById('PatientPreference1_PatientPreference').style.display = 'block';
                        }

                    }
                    if (document.getElementById('billPart_UcHistory_hdnPreference') != null) {
                        document.getElementById('billPart_UcHistory_hdnPreference').value = (eventArgs.get_value().split('|')[2]).substring(0,
                        (eventArgs.get_value().split('|')[2]).length - 1);
                    }
                    document.getElementById('btnSaveEMR').value = 'Update';
                }
            },
            error: function(result) {
                alert("Error");
            }
        });
    }
}
function LoadComplaintItems(source, eventArgs) {

    if (source != undefined) {
        var HidValue = source;

    }
    else {
        var HidValue = document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value;
    }
    var list = HidValue.split('^');
    document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value = HidValue;
    document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
    while (count = document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').rows.length) {

        for (var j = 0; j < document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').rows.length; j++) {
            document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').deleteRow(j);

        }
    }
    if (HidValue != "") {

        for (var count = 0; count < list.length - 1; count++) {
            var CList = list[count].split('~');
            var row = document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').insertRow(0);
            row.id = CList[0];
            var rwNumber = CList[0];
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell7 = row.insertCell(4);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell2.innerHTML = CList[1];
            cell3.innerHTML = CList[3];
            cell4.innerHTML = CList[4];
            cell1.width = "1%";
            cell2.width = "1%";
            cell3.width = "1%";
            cell4.width = "1%";
            cell7.width = "1%";
            var CLists = '';
            cell7.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + CList[1] + "~" + CList[2] + "~" + CList[3] + "~" + CList[4] + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
            document.getElementById('PatientPreference1_PatientPreference').style.display = 'block';
        }
    }
    if (HidValue == "") {
        document.getElementById('PatientPreference1_PatientPreference').style.display = 'none';
    }
}
function ImgOnclickComplaint(ImgID) {
    document.getElementById(ImgID).style.display = "none";
    var HidValue = document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value;
    var list = HidValue.split('^');
    var newCList = '';
    if (document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value != "") {
        for (var count = 0; count < list.length; count++) {
            var CList = list[count].split('~');
            if (CList[0] != '') {
                if (CList[0] != ImgID) {
                    newCList += list[count] + '^';
                }

                if (CList[0] == ImgID && CList[6] == "Y") {
                    document.getElementById('<%=chkPrimary.ClientID %>').disabled = false;
                }
            }
        }
        document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value = newCList;
    }
    if (document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value == '') {
        document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').style.display = 'none';
    }
}
function ImgOnclickComplaints(ImgID) {
    document.getElementById(ImgID).style.display = "none";
    var HidValue = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value;
    var list = HidValue.split('^');
    var newCList = '';
    if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value != "") {
        for (var count = 0; count < list.length; count++) {
            var CList = list[count].split('~');
            if (CList[0] != '') {
                if (CList[0] != ImgID) {
                    newCList += list[count] + '^';
                }

                if (CList[0] == ImgID && CList[6] == "Y") {
                    document.getElementById('<%=chkPrimary.ClientID %>').disabled = false;
                }
            }
        }
        document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value = newCList;
    }
    if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value == '') {
        document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').style.display = 'none';
    }
}
function LoadComplaintItem(source, eventArgs) {

    if (source != undefined) {
        var HidValue;
        var HidValue1;
        var HidValues = source;
        HidValue1 = HidValues.split('|');
        HidValue = HidValue1[1];
        var list = (HidValue1[2].substring(0, HidValue1[2].length - 3)).split('~');
        while (count = document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').rows.length) {

            for (var j = 0; j < document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').rows.length; j++) {
                document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').deleteRow(j);

            }
            document.getElementById('billPart_UcHistory_hdnPreference').value = '';
        }
        var rowcount = '509';
        if (HidValue1[2].substring(0, HidValue1[2].length - 3) != "") {
            for (var count = 0; count < list.length; count++) {

                var CList = list[count].split('~');

                var row = document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').insertRow(0);
                row.id = rowcount;
                var rwNumber = rowcount;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell2.align = 'left';
                cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclickPreference(" + parseInt(rwNumber) + ");' style='cursor:pointer;'  src='../Images/Delete.jpg' />";
                cell2.innerHTML = CList[0];
                if (rwNumber == '509') {
                    document.getElementById('billPart_UcHistory_hdnPreference').value += rwNumber + "^" + CList[0];
                }
                else {
                    document.getElementById('billPart_UcHistory_hdnPreference').value += "~" + rwNumber + "^" + CList[0];
                }
                rowcount++;
            }
            document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').style.display = 'block';
        }
    }
    else {
        var HidValue = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value;
    }
    var list = HidValue.split('^');
    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value = HidValue;

    while (count = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').rows.length) {

        for (var j = 0; j < document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').rows.length; j++) {
            document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').deleteRow(j);

        }
    }
    if (HidValue != "") {
        for (var count = 0; count < list.length - 1; count++) {
            var CList = list[count].split('~');
            var row = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').insertRow(0);
            row.id = CList[0];
            var rwNumber = CList[0];
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaints(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell2.innerHTML = CList[1];
            cell3.innerHTML = CList[2];
            cell4.innerHTML = CList[3];
            cell1.width = "1%";
            cell2.width = "1%";
            cell3.width = "1%";
            cell4.width = "1%";
            var CLists = '';
        }
    }

}
function edit_Click(source, eventArgs) {

    if (source != undefined) {
        var HidValue = source;
    }
    else {
        var HidValue = document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value;
    }
    var list = HidValue.split('^');
    document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value = HidValue;

    while (count = document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').rows.length) {

        for (var j = 0; j < document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').rows.length; j++) {
            document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').deleteRow(j);

        }
    }
    if (HidValue != "") {


        for (var count = 0; count < list.length - 1; count++) {
            var CList = list[count].split('~');
            var row = document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').insertRow(0);
            row.id = CList[0];
            var rwNumber = CList[0];
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell7 = row.insertCell(4);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaint(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell2.innerHTML = CList[1];
            cell3.innerHTML = CList[3];
            cell4.innerHTML = CList[4];
            cell1.width = "1%";
            cell2.width = "1%";
            cell3.width = "1%";
            cell4.width = "1%";
            cell7.width = "1%";

            var CLists = '';
            cell7.innerHTML = "<input onclick='btnEditC_OnClick(name);' name='" + parseInt(rwNumber) + "~" + CList[1] + "~" + CList[2] + "~" + CList[3] + "~" + CList[4] + "'  value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";

        }
    }
}
function btnEditC_OnClick(sEditedData) {


    var arrayAlreadyPresentDatas = new Array();
    var iAlreadyPresent = 0;
    var iCount = 0;
    var tempDatas = document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value;

    arrayAlreadyPresentDatas = tempDatas.split('^');
    if (arrayAlreadyPresentDatas.length > 0) {
        for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {

            if (arrayAlreadyPresentDatas[iCount].toLowerCase() == sEditedData.toLowerCase()) {
                arrayAlreadyPresentDatas[iCount] = "";

            }
        }
    }


    tempDatas = "";
    for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
        if (arrayAlreadyPresentDatas[iCount] != "") {
            tempDatas += arrayAlreadyPresentDatas[iCount] + "^";

        }
    }

    var arrayGotValue = new Array();

    arrayGotValue = sEditedData.split('~');


    if (arrayGotValue.length > 0) {

        document.getElementById('ComplaintICDCodeBP1_hdnCID').value = arrayGotValue[2];
        document.getElementById('ComplaintICDCodeBP1_txtCpmlaint').value = arrayGotValue[1];
        document.getElementById('ComplaintICDCodeBP1_txtICDCode').value = arrayGotValue[3];
        document.getElementById('ComplaintICDCodeBP1_txtICDName').value = arrayGotValue[4];
        //  if (arrayGotValue[5].trim() != '') {
        //       document.getElementById('<%=chkIsfirstdiagnosis.ClientID %>').checked = true;
        //   }
        //if (arrayGotValue[6].trim() == 'Y') {
        //   document.getElementById('<%=chkPrimary.ClientID %>').checked = true;
        //   document.getElementById('<%=chkPrimary.ClientID %>').disabled = false;

        //}
    }

    document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value = tempDatas;
    LoadComplaintItems();
}
function btnEditC_OnClicks(sEditedData) {


    var arrayAlreadyPresentDatas = new Array();
    var iAlreadyPresent = 0;
    var iCount = 0;
    var tempDatas = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value;

    arrayAlreadyPresentDatas = tempDatas.split('^');
    if (arrayAlreadyPresentDatas.length > 0) {
        for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {

            if (arrayAlreadyPresentDatas[iCount].toLowerCase() == sEditedData.toLowerCase()) {
                arrayAlreadyPresentDatas[iCount] = "";

            }
        }
    }


    tempDatas = "";
    for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
        if (arrayAlreadyPresentDatas[iCount] != "") {
            tempDatas += arrayAlreadyPresentDatas[iCount] + "^";

        }
    }

    var arrayGotValue = new Array();

    arrayGotValue = sEditedData.split('~');


    if (arrayGotValue.length > 0) {

        document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnCID').value = arrayGotValue[2];
        document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtCpmlaint').value = arrayGotValue[1];
        document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDCode').value = arrayGotValue[3];
        document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDName').value = arrayGotValue[4];
        //  if (arrayGotValue[5].trim() != '') {
        //       document.getElementById('<%=chkIsfirstdiagnosis.ClientID %>').checked = true;
        //   }
        //if (arrayGotValue[6].trim() == 'Y') {
        //   document.getElementById('<%=chkPrimary.ClientID %>').checked = true;
        //   document.getElementById('<%=chkPrimary.ClientID %>').disabled = false;

        //}
    }

    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value = tempDatas;
    LoadComplaintItem();
}

function SelectedPatientDetails(source, eventArgs) {

    var isPatientDetails = "";

    isPatientDetails = eventArgs.get_value();

    var PatientName = eventArgs.get_text().split(':')[0];
    var PatientNumber = eventArgs.get_text().split(':')[1];
    var PatientVisitType = eventArgs.get_text().split(':')[2];

    var PatientTITLECode = isPatientDetails.split('~')[0];
    var PatientAge = isPatientDetails.split('~')[3];
    var PatientDOB = isPatientDetails.split('~')[4];
    var PatientSex = isPatientDetails.split('~')[5];
    var PatientMaritalStatus = isPatientDetails.split('~')[6];
    var PatientMobile = isPatientDetails.split('~')[7].split(',')[0].trim();
    var PatientPhone = isPatientDetails.split('~')[7].split(',')[1].trim();
    var PatientAddress = isPatientDetails.split('~')[8];
    var PatientCity = isPatientDetails.split('~')[9];
    var PostalCode = isPatientDetails.split('~')[10];
    var PatientNationality = isPatientDetails.split('~')[11];
    var PatientCountryID = isPatientDetails.split('~')[12];
    var PatientStateID = isPatientDetails.split('~')[13];
    var PatientID = isPatientDetails.split('~')[14];
    var PatientEmailID = isPatientDetails.split('~')[15];
    var URNNo = isPatientDetails.split('~')[16];
    var URNofId = isPatientDetails.split('~')[17];
    var URNTypeId = isPatientDetails.split('~')[18];
    var VisitPurpose = 3
    var PatientPreviousDue = isPatientDetails.split('~')[19];
    var Suburban = isPatientDetails.split('~')[20];
    var ExternalPatientNumber = isPatientDetails.split('~')[21];
    var PatientType = isPatientDetails.split('~')[22];
    var PatientStatus = isPatientDetails.split('~')[23];


    document.getElementById('txtPatientName').value = PatientName;
    document.getElementById('txtPatientNumber').value = PatientNumber

    document.getElementById('txtPhoneNumber').value = PatientMobile;




}
function SelectedPatientEdit() {
    var vPatientDetails = SListForAppDisplay.Get("Billing_CommonBilling_js_69") == null ? "Patient Details" : SListForAppDisplay.Get("Billing_CommonBilling_js_69")
    var vPatientNo = SListForAppDisplay.Get("Billing_CommonBilling_js_68") == null ? "Patient No:" : SListForAppDisplay.Get("Billing_CommonBilling_js_68")
    var arrGotValue = new Array();
    var OrgID = document.getElementById('hdnOrgID').value;
    var PatientID = document.getElementById('hdnPatientID').value;
    var prefixText = document.getElementById('hdnPatientName').value;
    var Role = document.getElementById('hdnRoleName').value;
    var Rolevalue = document.getElementById('hdnrolevalue').value;
    var EditDoc = document.getElementById('hdneditdoc').value;
    var PatientVisitID = document.getElementById('hdnVisitID').value;  
    sval = OrgID + '~' + PatientID;
    document.getElementById('hdnEditBill').value = 'Y';
    //    $.ajax({
    //        type: "POST",
    //        contentType: "application/json; charset=utf-8",
    //        url: "../OPIPBilling.asmx/GetLabQuickBillPatientList",
    //        data: JSON.stringify({ prefixText: prefixText, count: '0', contextKey: document.getElementById('hdnOrgID').value + '~' + document.getElementById('hdnPatientID').value + '~' + '4' }),
    //        dataType: "json",

    var contextKey = OrgID + ':' + PatientID + ':' + 0 + ':' + PatientVisitID+ ':'+0;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetQuickPatientSearchDetails",
        data: JSON.stringify({ PatientID: PatientID, contextKey: contextKey }),
        dataType: "json",
        async: false,
        success: function(data, value) {
            var GetData = JSON.parse(data.d[0]);
            //var PatientName = GetData.First.split(':')[0];
            var isPatientDetails = GetData.Second;
            //var PatientNumber = GetData.First.split(':')[1];
            var PatientTITLECode = isPatientDetails.split('~')[0];
            var PatientName = isPatientDetails.split('~')[1];
            var PatientNumber = isPatientDetails.split('~')[2];
            var PatientAge = isPatientDetails.split('~')[3];
            var PatientDOB = isPatientDetails.split('~')[4];
            var PatientSex = isPatientDetails.split('~')[5];
            var PatientMaritalStatus = isPatientDetails.split('~')[6];
            var PatientMobile = isPatientDetails.split('~')[7].split(',')[0].trim();
            if (isPatientDetails.split('~')[7].split(',')[0].length > 1) {
                PatientPhone = isPatientDetails.split('~')[7].split(',')[1].trim();
            }
            else {
                PatientPhone = "";
            }
            var PatientAddress = isPatientDetails.split('~')[8];
            var PatientCity = isPatientDetails.split('~')[9];
            var PostalCode = isPatientDetails.split('~')[10];
            var PatientNationality = isPatientDetails.split('~')[11];
            var PatientCountryID = isPatientDetails.split('~')[12];
            var PatientStateID = isPatientDetails.split('~')[13];
            var PatientID = isPatientDetails.split('~')[14];
            var PatientEmailID = isPatientDetails.split('~')[15];
            var URNO = isPatientDetails.split('~')[16];
            var URNOFID = isPatientDetails.split('~')[17];
            var URNOFTypeID = isPatientDetails.split('~')[18];
            var VisitPurpose = 3
            var PatientPreviousDue = isPatientDetails.split('~')[19];
            var Suburban = isPatientDetails.split('~')[20];
            var ExternalPatientNumber = isPatientDetails.split('~')[21];
            var PatientType = isPatientDetails.split('~')[22];
            var PatientStatus = isPatientDetails.split('~')[23];
            var ClientName = isPatientDetails.split('~')[24];
            //var ReferingPhysicianName = isPatientDetails.split('~')[25];
            var ReferedPhydtls = isPatientDetails.split('~')[25];
            var ReferingPhysicianName = ReferedPhydtls.split(':')[0];
            var ReferedPhyID = ReferedPhydtls.split(':')[1];
            var HospitalName = isPatientDetails.split('~')[26];
            var WardNo = isPatientDetails.split('~')[27];
            //var Dispatchedtype = "HomeDelivery";
            var Dispatchedtype = isPatientDetails.split('~')[28];
            var DispatchedMode = isPatientDetails.split('~')[29];
            var PatientVisitID = isPatientDetails.split('~')[30];
            var PatientHistory = isPatientDetails.split('~')[31];
            var PatientRemarks = isPatientDetails.split('~')[32];
            var PhleboName = isPatientDetails.split('~')[35];
            var PhleboID = isPatientDetails.split('~')[36];
            var RoundNo = isPatientDetails.split('~')[37];
            var ExAutoAuthorization = isPatientDetails.split('~')[38];
            var LogisticsID = isPatientDetails.split('~')[39];
            var LogisticsName = isPatientDetails.split('~')[40];
            var NewOrgID = isPatientDetails.split('~')[33];
            var NotifyType = isPatientDetails.split('~')[41];
            var ExternelVisitID = isPatientDetails.split('~')[42];
            var Notifications = isPatientDetails.split('~')[44];
            var VisitClient = isPatientDetails.split('~')[45];
            var isIncomplete = isPatientDetails.split('~')[48].replace(/\s/g, '');
            var enableAttributes = isPatientDetails.split('~')[49];
            var SRFID = isPatientDetails.split('~')[51];
            var TRFID = isPatientDetails.split('~')[52];
            var PassportNo= isPatientDetails.split('~')[53];
            if (isIncomplete == "Y") {
                document.getElementById('chkIncomplete').checked = true;
                $('.InCom').hide();
            }
            else {
                document.getElementById('chkIncomplete').checked = false;
                $('.InCom').show();
            }
            document.getElementById('hdnNewOrgID').value = NewOrgID;
            document.getElementById('txtpassportno').value=PassportNo;
            document.getElementById('hdnPatientEmailId').value = PatientEmailID;
            document.getElementById('hdnReferringDoctor').value = ReferingPhysicianName;
            document.getElementById('hdnReferedPhyID').value = ReferedPhyID;
            document.getElementById('hdnDOBMonth').value = PatientDOB;
            document.getElementById('hdnPhoneNo').value = PatientPhone;
            document.getElementById('hdnMobileNo').value = PatientMobile;
            document.getElementById('hdnPatientAddress').value = PatientAddress;
            document.getElementById('hdnPatientAge').value = PatientAge.split(' ')[0];
            document.getElementById('hdnEdtPatientAge').value = PatientAge.split(' ')[0];
            document.getElementById('hdnPatientDOB').value = PatientDOB;
            document.getElementById('hdnPatientSex').value = PatientSex;
            // document.getElementById('hdnPatientReportStatus').value = isPatientDetails.split('~')[31];
            document.getElementById('EditPatientHistory').value = PatientHistory;
            document.getElementById('EdittxtRemarks').value = PatientRemarks;
            document.getElementById('ddSalutation').value = PatientTITLECode
            if (PatientTITLECode != "0")
            { document.getElementById('ddlSex').disabled = true; }

            document.getElementById('txtName').value = PatientName;
            document.getElementById('hdnPatientNumber').value = PatientNumber;
            if (Role != "") {
                if (Role != 'STAR ADMIN' && Role != 'Centre Manager') {
                    document.getElementById('txtDOBNos').disabled = true;
                    document.getElementById('ddlSex').disabled = true;
                    document.getElementById('tDOB').disabled = true;
                    document.getElementById('ddlDOBDWMY').disabled = true;
                }
            }
            document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
            document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
            document.getElementById('hdnEditDDlDOB').value = PatientAge.split(' ')[1];
            document.getElementById('ddlSex').value = PatientSex;
            document.getElementById('hdnEditSex').value = PatientSex;
            document.getElementById('ddMarital').value = PatientMaritalStatus;
            document.getElementById('hdnEditddMarital').value = PatientMaritalStatus;
            document.getElementById('txtMobileNumber').value = PatientMobile;
            document.getElementById('txtPhone').value = PatientPhone;
            document.getElementById('txtAddress').value = PatientAddress.trim();
            document.getElementById('txtCity').value = PatientCity;
            if (PatientNationality != '') {
                document.getElementById('ddlNationality').value = PatientNationality;
            }
            document.getElementById('ddCountry').value = PatientCountryID;
            document.getElementById('ddCountry').onchange();
            document.getElementById('hdnPatientStateID').value = PatientStateID;
            document.getElementById('ddState').value = PatientStateID;
            if (document.getElementById('billPart_hdnCpedit').value != 'Y') {
                loadState(PatientStateID);
            }

            document.getElementById('hdnPatientID').value = '';
            document.getElementById('hdnPatientID').value = PatientID;
            var textBox = $get('tDOB');
            if (textBox.AjaxControlToolkitTextBoxWrapper) {
                textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
            }
            else {
                textBox.value = PatientDOB;
                if (textBox.value == '01/01/1800') {
                    document.getElementById('hdnIncompleteAge').value = 'Y';
                }
                else {
                    document.getElementById('hdnIncompleteAge').value = 'N';
                }
            }
            document.getElementById('txtPincode').value = PostalCode;
            document.getElementById('txtEmail').value = PatientEmailID;
            document.getElementById('lblPatientDetails').innerHTML = '';
            document.getElementById('trPatientDetails').style.display = "none";
            document.getElementById('txtSuburban').value = Suburban;
            document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
            if (HospitalName != undefined) {
                document.getElementById('txtReferringHospital').value = HospitalName;
            }
            if (ReferingPhysicianName != undefined) {
                document.getElementById('txtInternalExternalPhysician').value = ReferingPhysicianName;
            }
            document.getElementById('ddlPatientStatus').value = PatientStatus;
            document.getElementById('ddlPatientType').value = PatientType;
            if (ClientName != undefined) {
                document.getElementById('txtClient').value = ClientName;
                if (document.getElementById('hdnIsEditMode').value == 'Y') {
                    document.getElementById('txtClient').disabled = true;
                    if (enableAttributes == "Y") {
                        document.getElementById('tdClientAttribute').style.display = 'block';
                    }
                    $('#hdnSelectedClientClientID').val(VisitClient);
                }

            }
            document.getElementById('txtWardNo').value = SRFID!=''?SRFID:WardNo;
            document.getElementById('txtURNo').value = URNO;
            document.getElementById('ddlUrnType').value = URNOFTypeID;
            document.getElementById('ddlUrnoOf').value = URNOFID;
            document.getElementById('txtReferringHospital').disabled = false;
            document.getElementById('txtInternalExternalPhysician').disabled = false;

            //document.getElementById('txtClient').disabled = true;
            document.getElementById('HDPatientVisitID').value = PatientVisitID;
            if (document.getElementById('txtPhleboName') != null) {
                document.getElementById('txtPhleboName').value = PhleboName;
            }
            //document.getElementById('HdnPhleboID').value = PhleboID;
            if (document.getElementById('txtLogistics') != null) {
                document.getElementById('txtLogistics').value = LogisticsName;
            }
            if (document.getElementById('txtRoundNo') != null) {
                document.getElementById('txtRoundNo').value = TRFID!='' ?TRFID:RoundNo;
            }
            if (document.getElementById('hdnEdtLogisticsID') != null) {
                document.getElementById('hdnEdtLogisticsID').value = LogisticsID
            }
            if (document.getElementById('hdnEdtPhleboID') != null) {
                document.getElementById('hdnEdtPhleboID').value = PhleboID;
            }
            if (document.getElementById('chkExcludeAutoathz') != null) {
                if (ExAutoAuthorization == 'Y') {
                    document.getElementById('chkExcludeAutoathz').checked = true;
                }
                else {
                    document.getElementById('chkExcludeAutoathz').checked = false;
                }
            }
            if (NotifyType == 1) {
                document.getElementById('chkMobileNotify').checked = true;
            }
            else {
                document.getElementById('chkMobileNotify').checked = false;
            }

            if ($('#txtExternalVisitID').val() != undefined) {
                document.getElementById('txtExternalVisitID').value = ExternelVisitID;
                document.getElementById('txtExternalVisitID').disabled = true;
            }

            var panelLegend = $('#PnlPatientDetail legend');
            panelLegend.html(vPatientDetails).append('<b>(' + vPatientNo + PatientNumber + ')</b>');
            //panelLegend.html("Patient Details ").append('<b>(Patient No: ' + PatientNumber + ')</b>');
            document.getElementById('PnlPatientDetail');

            if (Dispatchedtype != undefined) {
                var LstDispatchedtype = Dispatchedtype.split(",");
                for (var j = 0; j < LstDispatchedtype.length; j++) {
                    $('[id$="chkDisPatchType"] input[type=checkbox]').each(function(i) {
                        if (($("#" + $(this).filter().context.id).next().text()) == LstDispatchedtype[j]) {
                            this.checked = true;
                        }
                    });
                }
            }

            if (DispatchedMode != undefined) {
                var LstDispatchedMode = DispatchedMode.split(",");
                for (var j = 0; j < LstDispatchedMode.length; j++) {
                    $('[id$="chkDespatchMode"] input[type=checkbox]').each(function(i) {
                        if (($("#" + $(this).filter().context.id).next().text()) == LstDispatchedMode[j]) {
                            this.checked = true;
                        }
                    });
                }
            }
            if (Notifications != undefined) {
                var lstNotification = Notifications.split(",");
                for (var j = 0; j < lstNotification.length; j++) {
                    $('[id$="ChkNotification"] input[type=checkbox]').each(function(i) {
                        if (($("#" + $(this).filter().context.id).next().text()) == lstNotification[j]) {
                            this.checked = true;
                        }
                    });
                }
            }
        },
        error: function(result) {
            alert("Error");
        }
    });
    if (EditDoc == "Y" && Rolevalue == "Y") {
        DisableAllField();
    }
    else if(EditDoc != "Y" && Rolevalue == "Y")
    {
    document.getElementById('txtInternalExternalPhysician').disabled=true;
    }
}
function DisableAllField() {
    $('#ddSalutation').attr("disabled","disabled");
    $("#txtName").attr("disabled","disabled");
    $("#ddlSex").attr("disabled","disabled");
    $("#tDOB").attr("disabled","disabled");
    $("#txtDOBNos").attr("disabled","disabled");
    $("#ddlDOBDWMY").attr("disabled","disabled");
    $("#ddMarital").attr("disabled","disabled");
    $("#txtMobileNumber").attr("disabled","disabled");
    $("#txtPhone").attr("disabled","disabled");
    $("#txtEmail").attr("disabled","disabled");
    $("#txtAddress").attr("disabled","disabled");
    $("#txtSuburban").attr("disabled","disabled");
    $("#txtCity").attr("disabled","disabled");
    $("#txtPincode").attr("disabled","disabled");
    $("#ddCountry").attr("disabled","disabled");
    document.getElementById('ddState').disabled = true;
    $("#ddlUrnType").attr("disabled","disabled");
    $("#ddlUrnoOf").attr("disabled","disabled");
    $("#txtURNo").attr("disabled","disabled");
    $("#ddlPatientType").attr("disabled","disabled");
    $("#txtClient").attr("disabled","disabled");
    $("#txtReferringHospital").attr("disabled","disabled");
    $("#txtInternalExternalPhysician").attr("disabled", false);
    $("#txtLocClient").attr("disabled","disabled");
    $("#chkSamplePickup").attr("disabled","disabled");
    $("#ddlPriority").attr("disabled","disabled");
    $("#ddlIsExternalPatient").attr("disabled","disabled");
    $("#txtWardNo").attr("disabled","disabled");
    $("#txtExternalPatientNumber").attr("disabled","disabled");
    $("#ddlPatientStatus").attr("disabled","disabled");
    $("#txtSampleDate").attr("disabled","disabled");
    $("#txtPhleboName").attr("disabled","disabled");
    $("#txtLogistics").attr("disabled","disabled");
    $("#txtRoundNo").attr("disabled","disabled");
    $("#txtHealthHubID").attr("disabled","disabled");
    $("#chkExcludeAutoathz").attr("disabled","disabled");
    $("#ChkTRFImage").attr("disabled","disabled");
    $("#panelDispatchType input").attr("disabled", true);
    $('#panelDispatchMode input').attr("disabled", true);
    $('#panelnotification input').attr("disabled", true);  
    $("#EditPatientHistory").attr("disabled","disabled");
    $("#EdittxtRemarks").attr("disabled","disabled");
}
function reloadPage() {
    // window.location.href = "../Billing/LabQuickBilling.aspx?IsPopup=Y" //this is a possibility
    window.location.assign = "../Billing/LabQuickBilling.aspx?IsPopup=Y" //this is a possibility
    //window.location.reload(); //another possiblity
}

//function redirectPage() {
//window.location.href = "../Reception/LabPatientSearch.aspx?IsPopup=Y" //this is a possibility
//window.location.reload(); //another possiblity
//}
function redirectPage() {
    //window.location.href = "../Reception/VisitDetails.aspx?IsPopup=Y" //this is a possibility
    window.location.assign = "../Reception/VisitDetails.aspx?IsPopup=Y" //this is a possibility
    //window.location.reload(); //another possiblity
}

function setDDlDOBYear(id) {
    /* Added By Venkatesh S */
    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var vYear = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_43') == null ? "Provide the age in Years" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_43');
    var vMonth = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_44') == null ? "Provide the age in Months" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_44');
    var vWeeks = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_45') == null ? "Provide the age in Weeks or Months" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_45');
    var vDecimalValue = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_46') == null ? "Can not give the Decimal value" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_46');

    var ageVal = document.getElementById('txtDOBNos');

    // ageVal = document.getElementById('txtDOBNos');


    var ddlDOB = document.getElementById('ddlDOBDWMY');


    var dob = document.getElementById('tDOB');


    var date = dob.value;


    var ddlval = ddlDOB.value;
    //if (ddlval.toLowerCase() == 'm' && ageVal.value > 11) {
    if (ddlval.toLowerCase() == 'month(s)' && ageVal.value > 11) {
        //alert('Provide th age in Years');
        ValidationWindow(vYear, AlertType);
        document.getElementById('tDOB').value = '';
        document.getElementById('txtDOBNos').value = '';
        //document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        $('select[id$="ddlDOBDWMY"] option[value="Year(s)"]').attr("selected", true);
        return false;
    }
    //if (ddlval.toLowerCase() == 'w' && ageVal.value > 3) {
    if (ddlval.toLowerCase() == 'week(s)' && ageVal.value > 3) {
        //alert('Provide th age in Months');
        ValidationWindow(vMonth, AlertType);
        document.getElementById('tDOB').value = '';
        document.getElementById('txtDOBNos').value = '';
        //document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        $('select[id$="ddlDOBDWMY"] option[value="Year(s)"]').attr("selected", true);
        return false;
    }
    //if (ddlval.toLowerCase() == 'd' && ageVal.value > 30) {
    if (ddlval.toLowerCase() == 'day(s)' && ageVal.value > 30) {
        //alert('Provide th age in Weeks or Months');
        ValidationWindow(vWeeks, AlertType);
        document.getElementById('tDOB').value = '';
        document.getElementById('txtDOBNos').value = '';
        //document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        $('select[id$="ddlDOBDWMY"] option[value="Year(s)"]').attr("selected", true);
        return false;
    }

    var decimalAge = ageVal.value.split('.');
    //if (decimalAge.length > 1 && ddlval != 'Y') {
    if (decimalAge.length > 1 && ddlval != 'Year(s)') {
        //alert('Can not give the Decimal value');
        ValidationWindow(vDecimalValue, AlertType);
        document.getElementById('tDOB').value = '';
        document.getElementById('txtDOBNos').value = '';
        //document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        $('select[id$="ddlDOBDWMY"] option[value="Year(s)"]').attr("selected", true);
        return false;
    }
    var days = new Date();

    if (ageVal.value != '') {
        if (ageVal.value.length < 3 && ddlval == 'Year(s)') {
        //if (ageVal.value.length < 3 && ddlval == 'Y') {

            //var gdate = days.getDate();

            //var gmonth = days.getMonth();

            var gyear = days.getFullYear();

            dobYear = gyear - ageVal.value;
            var gmonth = days.getMonth();
            gmonth = parseInt(gmonth) + 1;
            if (gmonth < 10) {
                gmonth = '0' + gmonth;
            }

            var gday = days.getDate();
            gday = parseInt(gday);
            if (gday < 10) {
                gday = '0' + gday;
            }
            //Changed by arivakagan.kk//

            var Cday = new Date(dobYear, gmonth, gday);
            var Cmth = Cday.getMonth();
            if (Cmth < 10) {
                Cmth = '0' + Cmth;
            }
//            if ((Cmth == (gmonth))) {
//                var dm = DaysInMonth(dobYear, gmonth);
//                //gday = dm;
//                if (((Cmth == (gmonth)) && (Cmth == (02)) && ((gmonth) == (02))) && (dm == 28 || dm == 29)) {
//                    if (dm == 28) { gday = dm; }
//                    if (dm == 29) { gday = dm; }
//                }
//            }

            document.getElementById('tDOB').value = gday + '/' + gmonth + '/' + dobYear;
            //Changed by arivakagan.kk//
        }
        //else if ((ddlval != 'Y') && (ddlval == 'M' || ddlval == 'D' || ddlval == 'W')) {
        else if ((ddlval != 'Year(s)') && (ddlval == 'Month(s)' || ddlval == 'Day(s)' || ddlval == 'Week(s)')) {

            if (ageVal.value <= 1 && (ddlval == 'Year(s)')) {
            //if (ageVal.value <= 1 && (ddlval == 'Y')) {
                document.getElementById('tDOB').value = date;

            }

            else {

                if (ddlval == 'Day(s)') {
                    document.getElementById('tDOB').value = subDate(days, ageVal.value).format('dd/MM/yyyy'); //days.setDate(days.getDay() - ageVal.value);

                }

                if (ddlval == 'Week(s)') {
                    document.getElementById('tDOB').value = subWeek(days, ageVal.value).format('dd/MM/yyyy'); //days.setDate(days.getDay() - ageVal.value);

                }

                if (ddlval == 'Month(s)') {

                    document.getElementById('tDOB').value = subMonth(days, ageVal.value).format('dd/MM/yyyy'); //days.setDate(days.getDay() - ageVal.value);

                }

            }

        }
        if (document.getElementById('hdnPatientDOB') != null) {
            document.getElementById('hdnPatientDOB').value = document.getElementById('tDOB').value;
        }
    }
}
function DaysInMonth(Y, M) {
    with (new Date(Y, M, 1, 24)) {
        setDate(0);
        return getDate();
    }
}
function subDate(o, days) {
    var newDate = new Date(o.getFullYear(), o.getMonth(), o.getDate() - days);
    return newDate;
}
function subMonth(o, days) {
    var newDate = new Date(o.getFullYear(), o.getMonth() - days, o.getDate());
    return newDate;
}
function subWeek(o, days) {
    var newDate = new Date(o.getFullYear(), o.getMonth(), o.getDate() - 7 * days);
    return newDate;
}
function onListPopulated() {
    var completionList = $find("AutoCompleteExtenderPatient").get_completionList();
    completionList.style.width = '250';
}


function CheckPatientName() {
    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var vPatientName = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_47') == null ? "Enter The Patient Name" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_47');
    if (document.getElementById('txtName').value.trim() == "") {
        //alert("Enter The Patient Name");
        CommonControlFocus = "#txtName";
        ValidationWindowResponse(vPatientName, AlertType, FocusControlAfterValidationWindowResponse);
//        document.getElementById('txtName').focus();
        return false;
    }
}

function ChangeVisit() {
    var visitID;
    visitID = document.getElementById('ddlVisitDetails').value;

    if (visitID.selectedIndex = 1) {
        document.getElementById('hdnTodayVisitID').value = -1;
    }
    else {
        document.getElementById('hdnTodayVisitID').value = document.getElementById('hdnTempTodayVisitID').value;
    }
}


/// This  function cheanged by arivalagan.k on 27-04-2015
function ChangeVisit() {
    //    var visitID;
    //    visitID = document.getElementById('ddlVisitDetails').value;

    //    if (visitID.selectedIndex = 1) {
    //        document.getElementById('hdnTodayVisitID').value = -1;
    //    }
    //    else {
    //        document.getElementById('hdnTodayVisitID').value = document.getElementById('hdnTempTodayVisitID').value;
    //    }

    var selectedText = $("#ddlVisitDetails option:selected").text();
    if (selectedText = "Today's Visit") {
        document.getElementById('hdnTodayVisitID').value = document.getElementById('hdnTempTodayVisitID').value;
        //document.getElementById('hdnTodayVisitID').value = -1;
    }
    else {
        document.getElementById('hdnTodayVisitID').value = -1;
        //document.getElementById('hdnTodayVisitID').value = document.getElementById('hdnTempTodayVisitID').value;
    }
}


//End on 27-04-2015//

function ClearDiscountLimitValues() {
    if (document.getElementById('hdnDiscountLimitType').value != 'EMPL') {
        document.getElementById('hdnDiscountLimitAmt').value = 0;
        document.getElementById('hdnSumDiscountAmt').value = 0;
        document.getElementById('hdnAvailableDiscountAmt').value = 0;
    }
}
function ValidationWindowEmail(message, tt) {
    jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
            close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                        document.getElementById('txtEmail').focus();
                    }
                }
            },
            create: function() {

                var canceltxt = jQuery('#Language').text();
                jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("Scripts_Common_js_Ok") == null ? "Ok" : SListForAppDisplay.Get("Scripts_Common_js_Ok");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }

                jQuery('#okbtnid').text(oktxt);
                jQuery('#okbtnid').css("width", "100px");
                jQuery('#okbtnid').css("height", "30px");
            }
        }).dialog("open");
}
function validateMultipleEmailsCommaSeparated(emailcntl, seperator) {
    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var vCheck = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_48') == null ? "Please check," : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_48');
    var vEmailAddress = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_49') == null ? "email addresses not valid!" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_49');
    var value = emailcntl.value;
    if (value != '') {
        var result = value.split(seperator);
        for (var i = 0; i < result.length; i++) {
            if (result[i] != '') {
                if (!validateEmail(result[i])) {
                   // emailcntl.focus();
                    ValidationWindowEmail(vCheck + ' "' + result[i] + '" ' + vEmailAddress , AlertType);

                    var elements = document.getElementById('chkDespatchMode');
                    if (document.getElementById('txtEmail').value != '') {

                        //elements.cells[0].childNodes[0].checked = false;
                        document.getElementById('chkDespatchMode_0').checked = false;
                        /*changed by arivalagan.kk*/
                        //elements.cells[0].childNodes[0].checked = false;
                        /*changed by arivalagan.kk*/
                    }
                    return false;
                }
            }
        }
    }
    return true;
}

function validateEmail(field) {
    var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/;
    return (regex.test(field)) ? true : false;
}
/***********************Added by Arivalagan.kk for  freeze the do from visit patient details***************************/
function DofromVisitfreeze() {
    if (document.getElementById('txtDoFrmVisitNumber').value != '') {
        $('#rblSearchType_0').attr("disabled", "disabled");
        $('#rblSearchType_1').attr("disabled", "disabled");
        $('#rblSearchType_2').attr("disabled", "disabled");
        $('#rblSearchType_3').attr("disabled", "disabled");
        $('#rblSearchType_4').attr("disabled", "disabled");
        $('#rblSearchType_5').attr("disabled", "disabled");
        $('#ddSalutation').attr("disabled", "disabled");
        $('#txtName').attr("disabled", "disabled");
        $('#ddlSex').attr("disabled", "disabled");
        $('#tDOB').attr("disabled", "disabled");
        $('#txtDOBNos').attr("disabled", "disabled");
        $('#ddlDOBDWMY').attr("disabled", "disabled");
        $('#ddMarital').attr("disabled", "disabled");
        $('#txtMobileNumber').attr("disabled", "disabled");
        $('#txtPhone').attr("disabled", "disabled");
        $('#txtEmail').attr("disabled", "disabled");
        $('#txtAddress').attr("disabled", "disabled");
        $('#txtSuburban').attr("disabled", "disabled");
        $('#txtCity').attr("disabled", "disabled");
        $('#txtPincode').attr("disabled", "disabled");
        $('#ddCountry').attr("disabled", "disabled");
        $('#ddState').attr("disabled", "disabled");
        $('#ddlUrnType').attr("disabled", "disabled");
        $('#ddlUrnoOf').attr("disabled", "disabled");
        $('#txtURNo').attr("disabled", "disabled");
        $('#txtClient').attr("disabled", "disabled");
        $('#txtReferringHospital').attr("disabled", "disabled");
        $('#txtInternalExternalPhysician').attr("disabled", "disabled");
        $('#txtLocClient').attr("disabled", "disabled");
        $('#ddlIsExternalPatient').attr("disabled", "disabled");
        $('#txtWardNo').attr("disabled", "disabled");
        $('#txtExternalPatientNumber').attr("disabled", "disabled");
        $('#ddlPatientStatus').attr("disabled", "disabled");
        $('#txtSampleDate').attr("disabled", "disabled");
        $('#chkSamplePickup').attr("disabled", "disabled");
        $('#txtPhleboName').attr("disabled", "disabled");
        $('#txtLogistics').attr("disabled", "disabled");
        $('#txtRoundNo').attr("disabled", "disabled");
        $('#chkExcludeAutoathz').attr("disabled", "disabled");
        $('#ChkTRFImage').attr("disabled", "disabled");
		$('#FileUpload1').attr("disabled", "disabled");
        $('#txtpassportno').attr("disabled", "disabled");
		  //cahnges by arun - without trf billing should be restrict
        if ($('#hdnConfigTRFMandatory').val() == "Y" && found == false) {
          //  $('#ChkTRFImage').attr("disabled", "disabled");
            $('#ChkTRFImage').attr("disabled", false);
			$('#FileUpload1').attr("disabled", false);
        }
        //        
        $('#chkDisPatchType_0').attr("disabled", "disabled");
        $('#chkDisPatchType_1').attr("disabled", "disabled");
        $('#chkDespatchMode_0').attr("disabled", "disabled");
        $('#chkDespatchMode_1').attr("disabled", "disabled");
        $('#chkDespatchMode_2').attr("disabled", "disabled");
        $('#ChkNotification_0').attr("disabled", "disabled");
        $('#ChkNotification_1').attr("disabled", "disabled");
        $('#ddlVisitDetails').attr("disabled", "disabled");
        $('#ddlreplang').attr("disabled", "disabled");
        $('#btnAddlang').attr("disabled", "disabled");

    }
    else {
        UnDisablePatientDetails();
    }
}
/***********************End by Arivalagan.kk for  freeze the do from visit patient details***************************/

//////////////////JQUERY PART

////function clearfn() {
////    if (document.getElementById('billPart_txtTestName').value.length <= 0) {
////        $('[id$="lblInvType"]').val("");
////        $('[id$="hdnIsDiscountableTest"]').val("Y");
////        $('[id$="hdnIsNABL"]').val("Y");
////        $('[id$="hdnIsTaxable"]').val("Y");
////        $('[id$="hdnIsRepeatable"]').val("N");
////        $('[id$="hdnIsSTAT"]').val("N");
////        $('[id$="hdnIsSMS"]').val("N");
////        $('[id$="hdnIsOutSource"]').val("N");
////        $('[id$="hdnIsNABL"]').val("N");
////        $('[id$="hdnBillingItemRateID"]').val("0");
////    }
////}

////function SelectVisitType() {
////    if ($('[id$="ddlIsExternalPatient"]').val() == 1) {
////        $('[id$="tdlblWardNo"]').show();
////        $('[id$="tdtxtWardNo"]').show();
////    }
////    else {
////        $('[id$="tdlblWardNo"]').hide();
////        $('[id$="tdtxtWardNo"]').hide();
////    }
////}



////function ShowPrevious() {
////    $('[id$="ShowBillingItems"]').show();
////    $('[id$="ShowPreviousData"]').hide();
////}

////function IsPatientAlreadyExists() {
////    if ($('[id$="hdnPatientID"]').val() <= 0 && $('[id$="hdnPatientAlreadyExistsWebCall"]').val() == 0) {
////        if (document.getElementById('txtMobileNumber').value.trim().length > 0 || document.getElementById('txtPhone').value.trim().length > 0) {
////            $.ajax({
////                type: "POST",
////                url: "../OPIPBilling.asmx/CheckPatientforDuplicate",
////                data: "{ 'patientName': '" + document.getElementById('txtName').value + "','mobileNo': '" + document.getElementById('txtMobileNumber').value + "','llNo': '" + document.getElementById('txtPhone').value + "','orgID': '" + parseInt(document.getElementById('hdnOrgID').value) + "','patientNumber': '-1'}",
////                contentType: "application/json; charset=utf-8",
////                dataType: "json",
////                async: true,
////                success: function(data) {
////                    $('[id$="hdnPatientAlreadyExistsWebCall"]').val(1);
////                    if (data.d >= 1) {
////                        $('[id$="hdnPatientAlreadyExists"]').val(1); ;
////                        alert('Patient already registered with the given details');
////                        $('[id$="txtMobileNumber"]').focus();
////                        return false;
////                    }
////                },
////                failure: function(msg) {
////                    alert(msg);
////                }
////            });
////        }
////    }
////    else {
////        return true;
////    }
////}

////function SetPreviousVisitItems() {

////    var tblStatr = "";
////    var tblBoody = "";

////    var tblEnd = "";
////    var tblResult = "";
////    var tblTotal = "";
////    var listLen = document.getElementById('hdnPreviousVisitDetails').value.split('^').length;
////    var sum = 0.00;
////    var temp = 0.00;
////    var res = new Array();
////    var ItemArray = new Array();
////    var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
////    //    FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
////    //                + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8] + "|";
////    //document.getElementById('hdfBillType1').value = FeeViewStateValue;

////    if (listLen > 0) {
////        tblStatr = " <div style='overflow: auto; height: 120px;width: 475px;'>"
////                + "<table border='1' id='tblItems' cellpadding='1' cellspacing='0' class='dataheaderInvCtrl' style='text-align: left; font-size: 11px;' width='100%'>"
////                + "<tr class = 'dataheader1' style='font-weight:bold;'><td style='width:30px;'>S.No</td><td  style='width:330px;'>Test Name</td><td  style='display:none;width:30px;'>ID</td><td style='display:block;width:30px;'>Type</td>"
////                + "<td style='display:block;width:30px;'><input id='chkAll' name='chkAll1' onclick='chkSelectAll(document.form1.chkAll);' value='SelectAll' type='checkbox'>All</input></td><td  style='display:none;'>IsAddToday</td><td  style='display:none;'>IsOutSource</td><td  style='display:none;'>TestCode</td></tr>";

////        ItemArray = document.getElementById('hdnPreviousVisitDetails').value.split('^');

////        var curdate = '';
////        var predate = '';
////        var j = 0;
////        var k = 0;
////        var count = 0;
////        for (var i = 0; i < ItemArray.length; i++) {
////            if (ItemArray[i] != "") {
////                res = ItemArray[i].split('$');
////                curdate = res[3];

////                var strPatientHistory = '';
////                if (res[4] == null || res[4] == 'null') {
////                    strPatientHistory = '';
////                }
////                else {
////                    strPatientHistory = res[4];
////                }

////                if (predate == curdate) {
////                    var str = "chkboxItem" + k;
////                    var txt = "txtBillItems" + j;
////                    if (defalutdata[0] != res[1] && defalutdata[1] != res[2]) {

////                        tblBoody += "<tr><td>" + parseInt(j + 1) + "</td><td>" + res[0] + "</td><td style='display:none;'>" + res[1] + "</td><td style='display:block;'>" + res[2] +
////                                "</td><td style='display:block;'><input  id='" + str + "' name='chkAll'  value='" + '' + "' type='checkbox'  /></td><td style='display:none;'>" + res[5] + "</td><td style='display:none;'>" + res[6] + "</td><td style='display:none;'>" + res[7] + "</td>";

////                        j++;
////                        k++;
////                    }
////                }
////                else {
////                    count++;
////                    if (count == 6) {
////                        break;
////                    }
////                    tblBoody += "<tr><td style='font-weight:bold' colspan='5' title='" + strPatientHistory + "'>Visit Date : " + curdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Patient History: " + strPatientHistory.substring(0, 25) + "</td></tr>";
////                    predate = curdate;
////                    j = 0;
////                    i--;

////                }
////            }

////        }
////        tblTotal += "<tr><td colspan='5' style='display:block;' align='center'><input id='adds' type='button' value='Add' class='btn' onclick='javascript:AddPreviousVisitItemsToBilling();' ></td></tr>";
////        tblEnd = "</table></div>";
////    }
////    tblResult = tblStatr + tblBoody + tblTotal + tblEnd;
////    $('[id$="lblPreviousItems"]').html(tblResult);
////    if (document.getElementById('lblPreviousItems').innerHTML.trim() != '') {
////        tbItemshow();
////    }
////    else {
////        $('[id$="ShowBillingItems"]').hide();
////    }
////}
////function chkSelectAll(obj) {
////    for (i = 0; i < obj.length; i++) {
////        obj[i].checked = document.form1.chkAll1.checked == true ? true : false;
////    }
////}
////function AddPreviousVisitItemsToBilling() {
////    if (IsItemChecked()) {
////        var OrgID = document.getElementById('hdnOrgID').value;
////        CallBillItems(OrgID);
////        var tbl = document.getElementById('tblItems').rows.length;
////        var td = document.getElementById('tblItems');
////        var rate = document.getElementById('txtClient').value;
////        var pretex = new Array();
////        var idv = new Array();
////        if (tbl > 1) {
////            var j = 0;
////            var x = -1;
////            for (var i = 1; i < tbl - 1; i++) {
////                var cellcount = td.rows[i].cells.length;
////                if (cellcount > 1) {
////                    var tdID = td.rows[i].cells[4].childNodes[0].id;
////                    if (document.getElementById(tdID).checked == true) {
////                        x++;
////                        var testName = td.rows[i].cells[1].childNodes[0];
////                        var id = td.rows[i].cells[2].childNodes[0];
////                        var FeeType = td.rows[i].cells[3].childNodes[0];
////                        var IsOutSource = td.rows[i].cells[6].childNodes[0];
////                        var TestCode = td.rows[i].cells[7].childNodes[0];
////                        idv[x] = td.rows[i].cells[2].childNodes[0];
////                        if (testName.data != "Test Name") {
////                            var prefixText = testName.data;
////                            pretex[x] = testName.data;
////                            var autoComplete = $find('billPart_AutoCompleteExtender3');
////                            $.ajax({
////                                type: "POST",
////                                url: "../OPIPBilling.asmx/GetBillingItemsDetails",
////                                data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, FeeID: id.data, FeeType: FeeType.data, Description: testName.data, ClientID: document.getElementById('hdnSelectedClientClientID').value, VisitID: 0, Remarks: '' }),
////                                contentType: "application/json; charset=utf-8",
////                                dataType: "json",
////                                async: true,
////                                success: function(data) {
////                                    var Items = data.d;
////                                    $.each(Items, function(index, Item) {
////                                        var valu;
////                                        for (var k = 0; k < Items.length; k++) {
////                                            valu = Items[k].ProcedureName;
////                                            for (var m = 0; m < pretex.length; m++) {
////                                                var idvalu = valu.split('^');

////                                                var defalutdata = valu.split('^');
////                                                if (DuplicateInv(defalutdata[0], defalutdata[2])) {
////                                                    FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[2] + "~Descrip^" + defalutdata[1] +
////                                                                        "~Amount^" + defalutdata[3] + "~Quantity^" + 1 + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[7] +
////                                                                        "~IsReimbursable^" + defalutdata[6] + "~ActualAmount^" + defalutdata[8] + "~IsDiscountable^" + defalutdata[9]
////                                                                         + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13]
////                                                                         + "~IsOutSource^" + IsOutSource.data + "~IsNABL^" + defalutdata[14] + "~BillingItemRateID^" + defalutdata[15] + "~Code^" + TestCode.data + "|";
////                                                    document.getElementById('billPart_hdfBillType1').value = (document.getElementById('billPart_hdfBillType1').value).replace(FeeViewStateValue, '');
////                                                    document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;
////                                                    j++;

////                                                }
////                                            }
////                                        }


////                                    });
////                                    if (j >= (pretex.length)) {
////                                        CreateBillItemsTable(0);
////                                        var FeeViewStateValue = '';
////                                    }

////                                },
////                                failure: function(msg) {
////                                    ShowErrorMessage(msg);
////                                }

////                            });
////                        }
////                    }
////                }
////            }
////        }
////    }
////}

////function IsItemChecked() {
////    var flag = 0;
////    var flagAlreadyToday = 0;
////    var tbl = document.getElementById('tblItems').rows.length;
////    var td = document.getElementById('tblItems');
////    if (tbl > 0) {
////        for (var i = 0; i < tbl - 1; i++) {
////            var cellcount = td.rows[i].cells.length;
////            if (cellcount > 1) {
////                var tdID = td.rows[i].cells[4].childNodes[0].id;
////                if (document.getElementById(tdID).checked == true) {
////                    var FeeID = td.rows[i].cells[2].childNodes[0];
////                    var FeeType = td.rows[i].cells[3].childNodes[0];
////                    var IsAddedToday = td.rows[i].cells[5].childNodes[0];
////                    var ItemArrayAlreadyToday = new Array();
////                    var resAlreadyToday = new Array();
////                    ItemArrayAlreadyToday = document.getElementById('hdnPreviousVisitDetails').value.split('^');
////                    for (i = 0; i < ItemArrayAlreadyToday.length; i++) {
////                        res = ItemArrayAlreadyToday[i].split('$');
////                        if (FeeID.data == res[1] && 'Y' == res[5] && FeeType.data == res[2]) {
////                            flagAlreadyToday++;
////                        }
////                    }

////                    flag++;
////                }
////            }
////        }
////    }

////    if (flag == 0) {
////        alert('Does not allowed to add  to click the checkbox');
////    }
////    else {
////        if (flagAlreadyToday == 1) {
////            if (window.confirm("Warning: The selected test already ordered today...!  Do you want to continue?")) {
////                flagAlreadyToday = 0;
////            }
////            else {
////                flagAlreadyToday = 1;
////            }
////        }
////        if (flagAlreadyToday == 0)
////            return true;
////        else
////            return false;
////    }
////}

////function LoadPreviousBillingItemsForPatient() {
////    $('[id$="hdnPreviousVisitDetails"]').val("");
////    $.ajax({
////        type: "POST",
////        url: "../OPIPBilling.asmx/GetPreviousVisitBilling",
////        data: "{ 'PatientID': '" + parseInt(document.getElementById('hdnPatientID').value) + "','VisitID': '" + parseInt(0) + "','Type': ''}",
////        contentType: "application/json; charset=utf-8",
////        dataType: "json",
////        async: true,
////        success: function(data) {
////            var Items = data.d;
////            $.each(Items, function(index, Item) {
////                document.getElementById('hdnPreviousVisitDetails').value += Item.FeeDescription + '$' + Item.FeeId + '$' + Item.FeeType + '$' + Item.Address + '$' + Item.PatientHistory + '$' + Item.Status + '$' + Item.IsOutSource + '$' + Item.ServiceCode + '^';
////                //alert(document.getElementById('hdnPreviousVisitDetails').value);
////            });

////            SetPreviousVisitItems();
////            //alert(Items);
////        },
////        failure: function(msg) {
////            ShowErrorMessage(msg);
////        }

////    });
////}

////function OpenBillPrint(url) {
////    window.open(url, "billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
////}
////function OpenBillPrints(url) {
////    window.open(url, "billprints", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
////}

////function CheckExistingURN1(ctl) {
////    if (document.getElementById('hdnUrn').value == '0') {
////        if (document.getElementById('txtURNo').value != '' && document.getElementById('ddlUrnType').value != '0') {
////            WebService.GetURN(document.getElementById('ddlUrnType').value, document.getElementById('txtURNo').value, GetURN1);
////        }
////    }

////}
////function GetURN1(URnList) {
////    if (URnList.length > 0) {
////        alert('Already exist in this URN type');
////        document.getElementById('txtURNo').value = "";
////        document.getElementById('txtURNo').focus();
////        return false;
////    }
////}

////function setRate(id) {
////    if (id > 0) {
////        document.getElementById("hdnSelectedClientRateID").value = id;
////    }
////}
////function clearDespatchMode() {
////    $('[id$="chkDespatchMode"] input[type=checkbox]:checked').each(function() {
////        $('[id$="chkDespatchMode"] input[type=checkbox]:checked').attr('checked', false);
////    });
////}
////function clearPageControlsValue(ClearType) {
////    if ($('[id$="hdnIsEditMode"]').val() == 'N') {
////        if (ClearType == "N") {
////            $('[id$="txtName"]').val("");
////            if (document.getElementById('txtName') != null) {
////                try {
////                    $('[id$="txtName"]').focus();
////                }
////                catch (err) { }
////            }
////        }
////        $('[id$="tDOB"]').val("dd//MM//yyyy");
////        $('[id$="txtMobileNumber"]').val("");
////        $('[id$="txtPhone"]').val("");
////        $('[id$="txtAddress"]').val("");
////        $('[id$="txtPincode"]').val("");
////        $('[id$="txtCity"]').val("");
////        $('[id$="txtDOBNos"]').val("");
////        $('[id$="txtReferringHospital"]').val("");
////        $('[id$="ddlDOBDWMY"]').val("Year(s)");
////        $('[id$="txtInternalExternalPhysician"]').val("");
////        document.getElementById('hdnReferralType').value = "0";
////        $('[id$="txtCollectionCode"]').val("");
////        $('[id$="txtClient"]').val("");
////        $('[id$="txtEmail"]').val("");
////        document.getElementById('ChkTRFImage').checked = false;
////        document.getElementById('chkMobileNotify').checked = false;
////        $('[id$="hdnOPIP"]').val("OP");
////        $('[id$="hdnPreviousVisitDetails"]').val("");
////        $('[id$="lblPreviousItems"]').html("");
////        $('[id$="ShowBillingItems"]').hide();
////        $('[id$="ShowPreviousData"]').hide();
////        $('[id$="hdnPatientID"]').val("-1");
////        $('[id$="hdnVisitPurposeID"]').val("-1");
////        $('[id$="hdnClientID"]').val("-1");
////        $('[id$="hdnTPAID"]').val("-1");
////        $('[id$="hdnClientType"]').val("CRP");
////        $('[id$="hdnReferedPhyID"]').val("0");
////        $('[id$="hdnReferedPhyName"]').val("");
////        $('[id$="hdnReferedPhysicianCode"]').val("0");
////        $('[id$="lblPatientDetails"]').html("");
////        $('[id$="trPatientDetails"]').hide();
////        $('[id$="hdnReferedPhyType"]').val("");
////        document.getElementById('hdnBillGenerate').value = "N";
////        $('[id$="hdnLstPatientInvSample"]').val("");
////        $('[id$="hdnLstSampleTracker"]').val("");
////        $('[id$="hdnLstPatientInvSampleMapping"]').val("");
////        $('[id$="hdnLstInvestigationValues"]').val("");
////        $('[id$="hdnLstCollectedSampleStatus"]').val("");
////        $('[id$="hdnPatientAlreadyExists"]').val("0");
////        $('[id$="hdnPatientAlreadyExistsWebCall"]').val("0");
////        $('[id$="hdnVisitID"]').val("-1");
////        $('[id$="hdnFinalBillID"]').val("-1");
////        $('[id$="hdnCashClient"]').val("");
////        $('[id$="hdnSelectedClientClientID"]').val($('[id$="hdnBaseClientID"]').val());
////        $('[id$="hdnRateID"]').val($('[id$="hdnBaseRateID"]').val());
////        $('[id$="hdnMappingClientID"]').val("-1");
////        $('[id$="hdnIsMappedItem"]').val("N");
////        $('[id$="hdfReferalHospitalID"]').val("0");
////        $('[id$="txtSampleDate"]').val("");
////        $('[id$="lblClientDetails"]').html("");
////        $('[id$="ddlDespatchMode"]').val(0);
////        $('[id$="txtSuburban"]').val("");
////        $('[id$="txtExternalPatientNumber"]').val("");
////        $('[id$="ddCountry"]').val($('[id$="hdnDefaultCountryID"]').val());
////        $('[id$="lblCountryCode"]').html($('[id$="hdnDefaultCountryStdCode"]').val());
////        $('[id$="ddlUrnoOf"]').val(1);
////        $('[id$="ddlUrnType"]').val(0);
////        $('[id$="txtURNo"]').val("");
////        clearBillPartValues();
////        clearDespatchMode();
////    }
////}

////function validateEvents(obj) {
////    if ($.trim($('#txtName').val()) == '') {
////        alert('Provide patient name');
////        $('#txtName').focus();
////        return false;
////    }
////    if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy')) {
////        alert('Provide patient age or date of birth');
////        document.getElementById('txtDOBNos').focus();
////        return false;
////    }
////    if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
////        alert('Select patient sex');
////        document.getElementById('ddlSex').focus();
////        return false;
////    }
////    //    if (document.getElementById('ddMarital').options[document.getElementById('ddMarital').selectedIndex].value === "0") {
////    //        alert('Select Patient Marital Staus');
////    //        document.getElementById('ddMarital').focus();
////    //        return false;
////    //    }
////    if (document.getElementById('chkMobileNotify').checked == true) {
////        if (document.getElementById('txtMobileNumber').value == '') {
////            alert('Provide contact mobile number');
////            document.getElementById('txtMobileNumber').focus();
////            return false;
////        }
////    }
////    if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '') {
////        alert('Provide contact mobile or telephone number');
////        $('#txtMobileNumber').focus();
////        return false;
////    }
////    //    if (document.getElementById('txtAddress').value == '') {
////    //        alert('Provide contact address');
////    //        document.getElementById('txtAddress').focus();
////    //        return false;
////    //    }

////    //    if (document.getElementById('txtCity').value == '') {
////    //        alert('Provide city');
////    //        document.getElementById('txtCity').focus();
////    //        return false;
////    //    }

////    if ($.trim($('#txtEmail').val()) != '') {
////        var x = document.getElementById('txtEmail').value;
////        var atpos = x.indexOf("@");
////        var dotpos = x.lastIndexOf(".");
////        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
////            alert("Provide a valid e-mail address");
////            $('#txtEmail').focus();
////            return false;
////        }
////    }
////    if (document.getElementById('ddlDespatchMode').value == 1) {
////        if ($.trim($('#txtEmail').val()) == '') {
////            $('#txtEmail').focus();
////            alert("You select despatch mode as E-mail , Provide e-mail address");
////            return false;
////        }
////    }
////    else if (document.getElementById('ddlDespatchMode').value == 3) {
////        if ($.trim($('#txtMobileNumber').val()) == '') {
////            $('#txtMobileNumber').focus();
////            alert('You select despatch mode as sms , Provide contact mobile number');
////            return false;
////        }
////    }
////    else if (document.getElementById('ddlDespatchMode').value == 4) {
////        if ($('#txtAddress') == '' || $.trim($('#txtCity')) == '') {
////            document.getElementById('txtAddress').focus();
////            alert("You select despatch mode as courier , Provide address");
////            return false;
////        }
////    }
////    if (document.getElementById('hdnIsEditMode').value == 'N') {
////        if (obj == 'After') {
////            if (document.getElementById('hdnCashClient').value != 'C') {
////                if (document.getElementById('txtClient').value.trim() != '') {
////                    var NetAmount = $('[id$="hdnNetAmount"]').val();
////                    var BalanaceAmount = $('[id$="hdnClientBalanceAmount"]').val();
////                    if (Number(NetAmount) > Number(BalanaceAmount)) {
////                        if (alert('Ordered test items exceed balance client amount'))
////                            return false;
////                        else
////                            return false;
////                    }
////                }
////            }
////        }


////        if (obj == 'Before' && $('[id$="hdnPatientAlreadyExists"]').val() == 0) {
////            IsPatientAlreadyExists();
////        }
////        if ($('[id$="hdfBillType1"]').val() == '' && obj != 'Before') {
////            alert('Include billing items');
////            $('[id$="txtTestName"]').focus();
////            return false;
////        }
////        if (Number($('[id$="hdnDiscountAmt"]').val()) > 0 && obj == 'After') {
////            if ($.trim($('[id$="txtAuthorised"]').val()) == '') {
////                alert('Provide discount authorised by');
////                $('[id$="txtAuthorised"]').focus();
////                return false;
////            }
////            if ($('[id$="ddlDiscountReason"]').val() == '0') {
////                alert('Provide discount reason');
////                $('[id$="ddlDiscountReason"]').focus();
////                return false;
////            }
////        }

////        if ($('[id$="hdfBillType1"]').val() != '' && obj == 'After') {
////            PaymentSaveValidationQuickBill();
////            if (document.getElementById("txtClient").value.trim() == '') {
////                if (document.getElementById('hdnMinimumDue').value == 'Y') {
////                    if (document.getElementById('hdnMinimumDuePercent').value != '') {
////                        var perc = document.getElementById('hdnMinimumDuePercent').value;

////                        var tot = $('[id$="hdnGrossValue"]').val();
////                        var per = Number(document.getElementById('hdnMinimumDuePercent').value) / 100;
////                        var dis = tot * per;
////                        var amr = Number($('[id$="hdnAmountReceived"]').val());
////                        if (amr < dis) {
////                            alert('Received amount atleast ' + perc + '% of Gross amount (Rs:' + dis + ')');
////                            return false;
////                        }

////                    }
////                }

////                if (Number($('[id$="hdnNetAmount"]').val()) > Number($('[id$="hdnAmountReceived"]').val()) && $.trim($('[id$="txtClient"]').val()) == '') {
////                    var pBill = confirm("Bill amount will be added to due.\n Do you want to continue");
////                    if (pBill != true) {
////                        $('[id$="hdnDue"]').val("0.00");
////                        $('[id$="btnGenerate"]').show();
////                        $('[id$="btnClose"]').show();
////                        return false;
////                    }
////                    else {
////                        $('[id$="hdnDue"]').val((Number($('[id$="hdnNetAmount"]').val()) - Number($('[id$="hdnAmountReceived"]').val())));
////                        $('[id$="btnGenerate"]').hide();
////                    }
////                }
////            }
////            $('[id$="hdnDue"]').val((Number($('[id$="hdnNetAmount"]').val()) - Number($('[id$="hdnAmountReceived"]').val())));
////            $('[id$="btnGenerate"]').hide();
////            $('[id$="btnClose"]').hide();
////        }
////        $('[id$="hdnPatientAlreadyExists"]').val(0);
////    }


////}


////function SelectedTemp(source, eventArgs) {
////    document.getElementById('hdnSelectedPatientTempDetails').value = eventArgs.get_value();
////    Tblist();

////}

////function Tblist() {
////    $('[id$="trPatientDetails"]').show();
////    var table = '';
////    var tr = '';
////    var end = '</table>';
////    var y = '';
////    $('[id$="lblPatientDetails"]').html("");
////    table = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
////                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
////                           + "<th style='width:80px;'>Name</th>"
////                           + "<th style='width:50px;'>Number</th>"
////                           + "<th style='width:300px;'>Address</th>"
////                           + "<th style='Widht:100px;'>Phone</th> </thead>";
////    var x = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");

////    tr = "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
////                        + x[1] + "</td><td style='width:100px;'>"
////                        + x[2] + "</td><td style='width:100px;'>"
////                        + x[8] + ',' + x[20] + ',' + x[9] + "</td><td style='width:100px;'>"
////                        + x[7] + "</td></tr>";



////    var tab = table + tr + end;
////    $('[id$="lblPatientDetails"]').html(tab);
////    tbshow();


////}
////function SelectedPatient(source, eventArgs) {

////    var isPatientDetails = "";

////    isPatientDetails = eventArgs.get_value();

////    var PatientName = eventArgs.get_text().split(':')[0];
////    var PatientNumber = eventArgs.get_text().split(':')[1];
////    var PatientVisitType = eventArgs.get_text().split(':')[2];

////    var PatientTITLECode = isPatientDetails.split('~')[0];
////    var PatientAge = isPatientDetails.split('~')[3];
////    var PatientDOB = isPatientDetails.split('~')[4];
////    var PatientSex = isPatientDetails.split('~')[5];
////    var PatientMaritalStatus = isPatientDetails.split('~')[6];
////    var PatientMobile = isPatientDetails.split('~')[7].split(',')[0].trim();
////    var PatientPhone = isPatientDetails.split('~')[7].split(',')[1].trim();
////    var PatientAddress = isPatientDetails.split('~')[8];
////    var PatientCity = isPatientDetails.split('~')[9];
////    var PostalCode = isPatientDetails.split('~')[10];
////    var PatientNationality = isPatientDetails.split('~')[11];
////    var PatientCountryID = isPatientDetails.split('~')[12];
////    var PatientStateID = isPatientDetails.split('~')[13];
////    var PatientID = isPatientDetails.split('~')[14];
////    var PatientEmailID = isPatientDetails.split('~')[15];
////    var URNNo = isPatientDetails.split('~')[16];
////    var URNofId = isPatientDetails.split('~')[17];
////    var URNTypeId = isPatientDetails.split('~')[18];
////    var VisitPurpose = 3
////    var PatientPreviousDue = isPatientDetails.split('~')[19];
////    var Suburban = isPatientDetails.split('~')[20];
////    var ExternalPatientNumber = isPatientDetails.split('~')[21];
////    var PatientType = isPatientDetails.split('~')[22];
////    var PatientStatus = isPatientDetails.split('~')[23];

////    document.getElementById('ddSalutation').value = PatientTITLECode
////    document.getElementById('txtName').value = PatientName;
////    document.getElementById('hdnPatientNumber').value = PatientNumber
////    document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
////    document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
////    document.getElementById('ddlSex').value = PatientSex;
////    document.getElementById('ddMarital').value = PatientMaritalStatus;
////    document.getElementById('txtMobileNumber').value = PatientMobile;
////    document.getElementById('txtPhone').value = PatientPhone;
////    document.getElementById('txtAddress').value = trim(PatientAddress, ' ');
////    document.getElementById('txtCity').value = PatientCity;
////    document.getElementById('ddlNationality').value = PatientNationality;
////    document.getElementById('ddCountry').value = PatientCountryID;
////    //document.getElementById('ddCountry').onchange();
////    document.getElementById('hdnPatientStateID').value = PatientStateID;
////    document.getElementById('ddState').value = PatientStateID;
////    loadState("1");
////    document.getElementById('hdnPatientID').value = PatientID;
////    var textBox = $get('tDOB');
////    if (textBox.AjaxControlToolkitTextBoxWrapper) {
////        textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
////    }
////    else {
////        textBox.value = PatientDOB;
////    }
////    document.getElementById('txtPincode').value = PostalCode;
////    document.getElementById('txtEmail').value = PatientEmailID;
////    document.getElementById('txtURNo').value = URNNo;
////    document.getElementById('ddlUrnoOf').value = URNofId;
////    document.getElementById('ddlUrnType').value = URNTypeId;
////    document.getElementById('lblPatientDetails').innerHTML = '';
////    document.getElementById('trPatientDetails').style.display = "none";
////    document.getElementById('txtClient').focus();
////    //Getdigitalnumber(document.getElementById('lblPreviousDueText'), PatientPreviousDue);
////    document.getElementById('billPart_lblPreviousDueText').innerHTML = PatientPreviousDue;
////    document.getElementById('txtSuburban').value = Suburban;
////    document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
////    LoadPreviousBillingItemsForPatient();
////}
////function SelectedPatientEdit() {

////    var arrGotValue = new Array();
////    var OrgID = document.getElementById('hdnOrgID').value;
////    var PatientID = document.getElementById('hdnPatientID').value;
////    sval = OrgID + '~' + PatientID;

////    $.ajax({
////        type: "POST",
////        contentType: "application/json; charset=utf-8",
////        url: "../OPIPBilling.asmx/GetLabQuickBillPatientList",
////        data: JSON.stringify({ prefixText: '', count: '0', contextKey: document.getElementById('hdnOrgID').value + '~' + document.getElementById('hdnPatientID').value }),
////        dataType: "json",
////        success: function(data, value) {
////            var GetData = JSON.parse(data.d[0]);
////            var PatientName = GetData.First.split(':')[0];
////            var isPatientDetails = GetData.Second;
////            var PatientNumber = GetData.First.split(':')[1];
////            var PatientTITLECode = isPatientDetails.split('~')[0];
////            var PatientAge = isPatientDetails.split('~')[3];
////            var PatientDOB = isPatientDetails.split('~')[4];
////            var PatientSex = isPatientDetails.split('~')[5];
////            var PatientMaritalStatus = isPatientDetails.split('~')[6];
////            var PatientMobile = isPatientDetails.split('~')[7].split(',')[0].trim();
////            var PatientPhone = isPatientDetails.split('~')[7].split(',')[1].trim();
////            var PatientAddress = isPatientDetails.split('~')[8];
////            var PatientCity = isPatientDetails.split('~')[9];
////            var PostalCode = isPatientDetails.split('~')[10];
////            var PatientNationality = isPatientDetails.split('~')[11];
////            var PatientCountryID = isPatientDetails.split('~')[12];
////            var PatientStateID = isPatientDetails.split('~')[13];
////            var PatientID = isPatientDetails.split('~')[14];
////            var PatientEmailID = isPatientDetails.split('~')[15];
////            var VisitPurpose = 3
////            var PatientPreviousDue = isPatientDetails.split('~')[19];
////            var Suburban = isPatientDetails.split('~')[20];
////            var ExternalPatientNumber = isPatientDetails.split('~')[21];
////            var PatientType = isPatientDetails.split('~')[22];
////            var PatientStatus = isPatientDetails.split('~')[23];

////            document.getElementById('ddSalutation').value = PatientTITLECode
////            document.getElementById('txtName').value = PatientName;
////            document.getElementById('hdnPatientNumber').value = PatientNumber
////            document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
////            document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
////            document.getElementById('ddlSex').value = PatientSex;
////            document.getElementById('ddMarital').value = PatientMaritalStatus;
////            document.getElementById('txtMobileNumber').value = PatientMobile;
////            document.getElementById('txtPhone').value = PatientPhone;
////            document.getElementById('txtAddress').value = trim(PatientAddress, ' ');
////            document.getElementById('txtCity').value = PatientCity;
////            document.getElementById('ddlNationality').value = PatientNationality;
////            document.getElementById('ddCountry').value = PatientCountryID;
////            //document.getElementById('ddCountry').onchange();
////            document.getElementById('hdnPatientStateID').value = PatientStateID;
////            document.getElementById('ddState').value = PatientStateID;
////            loadState("1");
////            document.getElementById('hdnPatientID').value = PatientID;
////            var textBox = $get('tDOB');
////            if (textBox.AjaxControlToolkitTextBoxWrapper) {
////                textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
////            }
////            else {
////                textBox.value = PatientDOB;
////            }
////            document.getElementById('txtPincode').value = PostalCode;
////            document.getElementById('txtEmail').value = PatientEmailID;
////            document.getElementById('lblPatientDetails').innerHTML = '';
////            document.getElementById('trPatientDetails').style.display = "none";
////            document.getElementById('txtSuburban').value = Suburban;
////            document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
////        },
////        error: function(result) {
////            alert("Error");
////        }
////    });
////}

////function reloadPage() {
////    window.location.href = "../Billing/LabQuickBilling.aspx" //this is a possibility
////    //window.location.reload(); //another possiblity
////}


////   
/////////END JQUERY PART
function ConfirmWindow(message, tt, btnoktext, btnclosetext) {
    //    jQuery('<div>')
    //        .html("<p>" + message + "</p>")
    //        .dialog({
    //            autoOpen: false,
    //            modal: true,
    //            title: tt,
    //            buttons: {
    //                Yes: function() {
    //                    jQuery(this).dialog("close");
    //                   
    //                },
    //                No: function() {
    //                    jQuery(this).dialog("close");


    //                }
    //            },
    //            close: function(event, ui) {
    //                $(this).remove();
    //            }
    //        }).dialog("open");
    //    return false;
    return confirm(message);
}
function UnDisablePatientDetails() {
    $('#rblSearchType_0').attr("disabled", false);
    $('#rblSearchType_1').attr("disabled", false);
    $('#rblSearchType_2').attr("disabled", false);
    $('#rblSearchType_3').attr("disabled", false);
    $('#rblSearchType_4').attr("disabled", false);
    $('#rblSearchType_5').attr("disabled", false);
    $('#ddSalutation').attr("disabled", false);
    $('#txtName').attr("disabled", false);
    $('#ddlSex').attr("disabled", false);
    $('#tDOB').attr("disabled", false);
    $('#txtDOBNos').attr("disabled", false);
    $('#ddlDOBDWMY').attr("disabled", false);
    $('#ddMarital').attr("disabled", false);
    $('#txtMobileNumber').attr("disabled", false);
    $('#txtPhone').attr("disabled", false);
    $('#txtEmail').attr("disabled", false);
    $('#txtAddress').attr("disabled", false);
    $('#txtSuburban').attr("disabled", false);
    $('#txtCity').attr("disabled", false);
    $('#txtPincode').attr("disabled", false);
    $('#ddCountry').attr("disabled", false);
    $('#ddState').attr("disabled", false);
    $('#ddlUrnType').attr("disabled", false);
    $('#ddlUrnoOf').attr("disabled", false);
    $('#txtURNo').attr("disabled", false);
    $('#txtClient').attr("disabled", false);
    $('#txtReferringHospital').attr("disabled", false);
    $('#txtInternalExternalPhysician').attr("disabled", false);
    $('#txtLocClient').attr("disabled", false);
    $('#ddlIsExternalPatient').attr("disabled", false);
    $('#txtWardNo').attr("disabled", false);
    $('#txtExternalPatientNumber').attr("disabled", false);
    $('#ddlPatientStatus').attr("disabled", false);
    $('#txtSampleDate').attr("disabled", false);
    $('#chkSamplePickup').attr("disabled", false);
    $('#txtPhleboName').attr("disabled", false);
    $('#txtLogistics').attr("disabled", false);
    $('#txtRoundNo').attr("disabled", false);
    $('#chkExcludeAutoathz').attr("disabled", false);
    $('#ChkTRFImage').attr("disabled", false);
    $('#FileUpload1').attr("disabled", false);
    $('#chkDisPatchType_0').attr("disabled", false);
    $('#chkDisPatchType_1').attr("disabled", false);
    $('#chkDespatchMode_0').attr("disabled", false);
    $('#chkDespatchMode_1').attr("disabled", false);
    $('#chkDespatchMode_2').attr("disabled", false);
    $('#ChkNotification_0').attr("disabled", false);
    $('#ChkNotification_1').attr("disabled", false);
    $('#ddlVisitDetails').attr("disabled", false);
    $('#ddlreplang').attr("disabled", false);
    $('#btnAddlang').attr("disabled", false);
}

function SavePatientHistory() {
    try {
        var strPattenName, IName, InvestigationID;
        var hdnDisplayTblIDValue = $("#hdnDisplayTblID").val().split('^');
        $('[id$="hdnPatientHistory"]').val(''); 
       
        for (var i = 0; i < hdnDisplayTblIDValue.length; i++) {

            if ($.trim(hdnDisplayTblIDValue[i]) != "") {

                var SplitVal = hdnDisplayTblIDValue[i].split('~');
                strPattenName = SplitVal[0];
                InvestigationID = SplitVal[1];
                IName = SplitVal[2];
        
                switch (strPattenName) {
                    case "Germline Format":
                        ReadGermlineFormat(InvestigationID, IName);
                break;

                    case "MST Format":
                        ReadMSTFormat(InvestigationID, IName);  
                break;
                    case "Somatic Format":
                        ReadSomaticpatientHistary(InvestigationID, IName);
                break;
                    case "TSP Breast Format":
                        ReadTSPBreastFormat(InvestigationID, IName);   
                break;
                    case "TSP Colon Format":
                        ReadTSPColonFormat(InvestigationID, IName);  
                break;
                    case "TST lung Format":
                        ReadTSTlungFormat(InvestigationID, IName); 
                break;
            default:
                break;
                }
            }
        }     
 
        return false;
    }
    catch (e) {
        alert("Unable to Save");
        return false;
    }
}

function CallCapturePatientHistoryPattern() {

    var InvIDD = $("#hdnPhcInvID").val().split('~');
    var param = { strInvestigationID: InvIDD[0], OrgID: $("#billPart_PaymentType_hdnOrgID").val(), Type: "CPH" };

   return  $.ajax({
        type: "POST",

        url: "../WebService.asmx/GetCapturePatientHistoryPatten",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(param),
        dataType: "json",
        success: function(data) {
        var val = $("#hdnDisplayTblID").val() + '^' + data.d + '~' + InvIDD[0] + '~' + InvIDD[1];
            $("#hdnDisplayTblID").val('');
            $("#hdnDisplayTblID").val(val);
            return false;

        },
        error: function(xhr, ajaxOptions, thrownError) {


            alert("Error in Webservice Calling");
            return false;

        }



    });

            }







            function SelectedExtVisitID() {
                var searchtypeRadioList;
                if (document.getElementsByName('rblSearchType') != null) {
                    searchtypeRadioList = document.getElementsByName('rblSearchType');
                    for (var i = 0; i < searchtypeRadioList.length; i++) {
                        if (searchtypeRadioList[i].checked) {
                            searchtype = searchtypeRadioList[i].value
                            break;
                        }
                    }
                }
                if (searchtype != "3") {
                    var ExtVisitID = document.getElementById('txtExternalVisitID').value;
                    if (ExtVisitID != '') {
                        var arrGotValue = new Array();
                        var OrgID = document.getElementById('hdnOrgID').value;
                        var PatientID = document.getElementById('hdnPatientID').value;
                        var prefixText = document.getElementById('hdnPatientName').value;
                        var Role = document.getElementById('hdnRoleName').value;

                        sval = OrgID + '~' + PatientID;

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../OPIPBilling.asmx/GetLabQuickBillPatientList_Quantum",
                            data: JSON.stringify({ prefixText: prefixText, count: '0', contextKey: document.getElementById('hdnOrgID').value + '~' + document.getElementById('hdnPatientID').value + '~' + '5' + '~' + ExtVisitID }),
                            dataType: "json",
                            success: function(data, value) {
                                if (data.d.length > 0) {
                                    var GetData = JSON.parse(data.d[0]);
                                    var PatientName1 = GetData.First.split(':')[0];
                                    var PatientName = PatientName1.split('(')[0];
                                    var isPatientDetails = GetData.Second;
                                    var PatientNumber = isPatientDetails.split('~')[2];
                                    var PatientTITLECode = isPatientDetails.split('~')[0];
                                    var PatientAge = isPatientDetails.split('~')[3];
                                    var PatientDOB = isPatientDetails.split('~')[4];
                                    var PatientSex = isPatientDetails.split('~')[5];
                                    var PatientMaritalStatus = isPatientDetails.split('~')[6];
                                    var PatientMobile = isPatientDetails.split('~')[7].split(',')[0].trim();
                                    if (isPatientDetails.split('~')[7].split(',')[0].length > 1) {
                                        PatientPhone = isPatientDetails.split('~')[7].split(',')[1].trim();
                                    }
                                    else {
                                        PatientPhone = "";
                                    }
                                    var PatientAddress = isPatientDetails.split('~')[8];
                                    var PatientCity = isPatientDetails.split('~')[9];
                                    var PostalCode = isPatientDetails.split('~')[10];
                                    var PatientNationality = isPatientDetails.split('~')[11];
                                    var PatientCountryID = isPatientDetails.split('~')[12];
                                    var PatientStateID = isPatientDetails.split('~')[13];
                                    var PatientID = isPatientDetails.split('~')[14];
                                    var PatientEmailID = isPatientDetails.split('~')[15];
                                    var URNO = isPatientDetails.split('~')[16];
                                    var URNOFID = isPatientDetails.split('~')[17];
                                    var URNOFTypeID = isPatientDetails.split('~')[18];
                                    var VisitPurpose = 3
                                    var PatientPreviousDue = isPatientDetails.split('~')[19];
                                    var Suburban = isPatientDetails.split('~')[20];
                                    var ExternalPatientNumber = isPatientDetails.split('~')[21];
                                    var PatientType = isPatientDetails.split('~')[22];
                                    var PatientStatus = isPatientDetails.split('~')[23];
                                    var ClientName = isPatientDetails.split('~')[24];
                                    var ReferingPhysicianName = isPatientDetails.split('~')[25];
                                    var HospitalName = isPatientDetails.split('~')[26];
                                    var WardNo = isPatientDetails.split('~')[27];
                                    //var Dispatchedtype = "HomeDelivery";
                                    var Dispatchedtype = isPatientDetails.split('~')[28];
                                    var DispatchedMode = isPatientDetails.split('~')[29];
                                    var PatientVisitID = isPatientDetails.split('~')[30];
                                    var PatientHistory = isPatientDetails.split('~')[31];
                                    var PatientRemarks = isPatientDetails.split('~')[32];
                                    var PhleboName = isPatientDetails.split('~')[35];
                                    var PhleboID = isPatientDetails.split('~')[36];
                                    var RoundNo = isPatientDetails.split('~')[37];
                                    var ExAutoAuthorization = isPatientDetails.split('~')[38];
                                    var LogisticsID = isPatientDetails.split('~')[39];
                                    var LogisticsName = isPatientDetails.split('~')[40];
                                    var NewOrgID = isPatientDetails.split('~')[33];
                                    var NotifyType = isPatientDetails.split('~')[41];
                                    var ExternelVisitID = isPatientDetails.split('~')[42];
                                    var ApprovalNo = isPatientDetails.split('~')[43];
                                    var OnBehalfOfClient = isPatientDetails.split('~')[44];
                                    var ClientID = isPatientDetails.split('~')[46];
                                    var ClientMapCode = isPatientDetails.split('~')[47];
                                    var IsCash = isPatientDetails.split('~')[48];
                                    var PatientEmailCC = isPatientDetails.split('~')[49];
                                    if (document.getElementById('billPart_hdnIsCashClient') != null) {
                                        document.getElementById('billPart_hdnIsCashClient').value = IsCash;
                                        document.getElementById('hdnIsCashClient').value = IsCash;
                                    }
                                    if (document.getElementById('TxtClientCodeMap') != null) {
                                        if ((ClientMapCode != '') && (ClientMapCode != undefined)) {
                                            document.getElementById('TxtClientCodeMap').value = ClientMapCode;
                                        }
                                    }
                                    document.getElementById('hdnSelectedClientClientID').value = ClientID;
                                    document.getElementById('hdnNewOrgID').value = NewOrgID;

                                    document.getElementById('hdnPatientAge').value = PatientAge.split(' ')[0];
                                    document.getElementById('hdnEdtPatientAge').value = PatientAge.split(' ')[0];
                                    document.getElementById('hdnPatientDOB').value = PatientDOB;
                                    document.getElementById('hdnPatientSex').value = PatientSex;
                                    // document.getElementById('hdnPatientReportStatus').value = isPatientDetails.split('~')[31];
                                    document.getElementById('EditPatientHistory').value = PatientHistory;
                                    document.getElementById('EdittxtRemarks').value = PatientRemarks;
                                    document.getElementById('ddSalutation').value = PatientTITLECode

                                    document.getElementById('txtName').value = PatientName;
                                    document.getElementById('hdnPatientNumber').value = PatientNumber;
//                                    if (Role != "") {
//                                        if (Role != 'STAR ADMIN' && Role != 'Centre Manager') {
//                                            document.getElementById('txtDOBNos').disabled = true;
//                                            document.getElementById('ddlSex').disabled = true;
//                                            document.getElementById('tDOB').disabled = true;
//                                            document.getElementById('ddlDOBDWMY').disabled = true;
//                                        }
//                                    }
                                    document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
                                    document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
                                    document.getElementById('hdnEditDDlDOB').value = PatientAge.split(' ')[1];
                                    document.getElementById('ddlSex').value = PatientSex;
                                    document.getElementById('hdnEditSex').value = PatientSex;
                                    document.getElementById('ddMarital').value = PatientMaritalStatus;
                                    document.getElementById('hdnEditddMarital').value = PatientMaritalStatus;
                                    if (document.getElementById('txtMobileNumber') != null) {
                                        document.getElementById('txtMobileNumber').value = PatientMobile;
                                    }
                                    if (document.getElementById('txtPhone') != null) {
                                        document.getElementById('txtPhone').value = PatientPhone;
                                    }
                                    if (document.getElementById('txtAddress') != null) {
                                        document.getElementById('txtAddress').value = PatientAddress.trim();
                                    }
                                    if (document.getElementById('txtCity') != null) {
                                        document.getElementById('txtCity').value = PatientCity;
                                    }
                                    if (PatientNationality != '') {
                                        document.getElementById('ddlNationality').value = PatientNationality;
                                    }
                                    if (document.getElementById('ddCountry') != null) {
                                        document.getElementById('ddCountry').value = PatientCountryID;
                                    }
                                    if (document.getElementById('ddCountry') != null) {
                                        document.getElementById('ddCountry').onchange();
                                    }
                                    document.getElementById('hdnPatientStateID').value = PatientStateID;
                                    if (document.getElementById('ddState') != null) {
                                        document.getElementById('ddState').value = PatientStateID;
                                    }
                                    if (document.getElementById('billPart_hdnCpedit').value != 'Y') {
                                        loadState(PatientStateID);
                                    }

                                    document.getElementById('hdnPatientID').value = '';
                                    document.getElementById('hdnPatientID').value = PatientID;
                                    var textBox = $get('tDOB');
                                    if (textBox.AjaxControlToolkitTextBoxWrapper) {
                                        textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
                                    }
                                    else {
                                        textBox.value = PatientDOB;
                                    }
                                    if (document.getElementById('hdnDateFormatConfig').value == 'MM/dd/yyyy') {
                                        var Dformate = PatientDOB.split('/');
                                        textBox.value = Dformate[1] + '/' + Dformate[0] + '/' + Dformate[2];

                                    }
                                    if (document.getElementById('txtPincode') != null) {
                                        document.getElementById('txtPincode').value = PostalCode;
                                    }
                                    if (document.getElementById('txtEmail') != null) {
                                        document.getElementById('txtEmail').value = PatientEmailID;
                                    }
                                    if (document.getElementById('txtCC') != null) {
                                        document.getElementById('txtCC').value = PatientEmailCC;
                                    }
                                    if (document.getElementById('lblPatientDetails') != null) {
                                        document.getElementById('lblPatientDetails').innerHTML = '';
                                    }
                                    if (document.getElementById('trPatientDetails') != null) {
                                        document.getElementById('trPatientDetails').style.display = "none";
                                    }
                                    if (document.getElementById('txtSuburban') != null) {
                                        document.getElementById('txtSuburban').value = Suburban;
                                    }
                                    document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
                                    if (HospitalName != undefined) {
                                        document.getElementById('txtReferringHospital').value = HospitalName;
                                    }
                                    if (ReferingPhysicianName != undefined) {
                                        document.getElementById('txtInternalExternalPhysician').value = ReferingPhysicianName;
                                    }
                                    if (document.getElementById('ddlPatientStatus') != null) {
                                        document.getElementById('ddlPatientStatus').value = PatientStatus;
                                    }
                                    if (document.getElementById('ddlPatientType') != null) {
                                        document.getElementById('ddlPatientType').value = PatientType;
                                    }
                                    if (ClientName != undefined) {
                                        document.getElementById('txtClient').value = ClientName;
                                        document.getElementById('hdnClientName').value = ClientName;
//                                        if (document.getElementById('hdnIsEditMode').value == 'Y') {
//                                            //document.getElementById('txtClient').disabled = true;
//                                        }
//                                        else {
//                                           // document.getElementById('txtClient').disabled = true;
//                                        }

                                    }
                                    if (document.getElementById('txtWardNo') != null) {
                                        document.getElementById('txtWardNo').value = WardNo;
                                    }
                                    document.getElementById('txtURNo').value = URNO;
                                    document.getElementById('ddlUrnType').value = URNOFTypeID;
                                    document.getElementById('ddlUrnoOf').value = URNOFID;
                                    document.getElementById('txtReferringHospital').disabled = false;
                                    document.getElementById('txtInternalExternalPhysician').disabled = false;
                                    //document.getElementById('txtClient').disabled = true;
                                    document.getElementById('HDPatientVisitID').value = PatientVisitID;
                                    document.getElementById('hdnDoFrmVisit').value = PatientVisitID;
                                    if (document.getElementById('txtPhleboName') != null) {
                                        document.getElementById('txtPhleboName').value = PhleboName;
                                    }
                                    //document.getElementById('HdnPhleboID').value = PhleboID;
                                    if (document.getElementById('txtLogistics') != null) {
                                        document.getElementById('txtLogistics').value = LogisticsName;
                                    }
                                    if (document.getElementById('txtRoundNo') != null) {
                                        document.getElementById('txtRoundNo').value = RoundNo;
                                    }
                                    if (document.getElementById('hdnEdtLogisticsID') != null) {
                                        document.getElementById('hdnEdtLogisticsID').value = LogisticsID
                                    }
                                    if (document.getElementById('hdnEdtPhleboID') != null) {
                                        document.getElementById('hdnEdtPhleboID').value = PhleboID;
                                    }
                                    if (document.getElementById('chkExcludeAutoathz') != null) {
                                        if (ExAutoAuthorization == 'Y') {
                                            document.getElementById('chkExcludeAutoathz').checked = true;
                                        }
                                        else {
                                            document.getElementById('chkExcludeAutoathz').checked = false;
                                        }
                                    }
                                    if (NotifyType == 1) {
                                        if (document.getElementById('chkMobileNotify') != null) {
                                            document.getElementById('chkMobileNotify').checked = true;
                                        }
                                    }
                                    else {
                                        if (document.getElementById('chkMobileNotify') != null) {
                                            document.getElementById('chkMobileNotify').checked = false;
                                        }
                                    }

                                    if ($('#txtExternalVisitID').val() != undefined) {
                                        document.getElementById('txtExternalVisitID').value = ExternelVisitID;

                                    }

                                    var panelLegend = $('#PnlPatientDetail legend');
                                    if (panelLegend != null) {
                                        panelLegend.html("Patient Details ").append('<b>(Patient No: ' + PatientNumber + ')</b>');
                                    }
                                    document.getElementById('PnlPatientDetail');

                                    if (Dispatchedtype != undefined && Dispatchedtype != "") {
                                        var LstDispatchedtype = Dispatchedtype.split(",");
                                        for (var j = 0; j < LstDispatchedtype.length; j++) {
                                            //var DispatchedMode = LstDispatchedMode[j].split("!");
                                            $('[id$="chkDisPatchType"] input[type=checkbox]').each(function(i) {
                                                if (($("#" + $(this).filter().context.id).next().text()) == LstDispatchedMode[j]) {
                                                    this.checked = true;
                                                }
                                            });
                                        }
                                    }

                                    if (DispatchedMode != undefined && DispatchedMode != "") {
                                        var LstDispatchedMode = DispatchedMode.split(",");
                                        for (var j = 0; j < LstDispatchedMode.length; j++) {
                                            var DispatchedMode = LstDispatchedMode[j].split("!");
                                            $('[id$="chkDespatchMode"] input[type=checkbox]').each(function(i) {
                                                if (($("#" + $(this).filter().context.id).next().text()) == DispatchedMode[0]) {
                                                    this.checked = true;
                                                }
                                            });
                                            if (DispatchedMode[0] == "FAX") {
                                                $('[id$="FaxNumber"]').val(DispatchedMode[1]);
                                            }
                                        }
                                    }
                                     if (NotifyType != undefined && NotifyType != "") {
                                        var LstNotifyType = NotifyType.split(",");
                                        for (var j = 0; j < LstNotifyType.length; j++) {
                                            $('[id$="ChkNotification"] input[type=checkbox]').each(function(i) {
                                                if (($("#" + $(this).filter().context.id).next().text()) == LstNotifyType[j]) {
                                                    this.checked = true;
                                                }
                                            });
                                        }
                                    }

                                    if (document.getElementById('txtApprovalNo') != null) {
                                        document.getElementById('txtApprovalNo').value = ApprovalNo;
                                    }
                                    if (document.getElementById('txtLocClient') != null) {
                                        document.getElementById('txtLocClient').value = OnBehalfOfClient;
                                    }
                                    //----Diabling
//                                    document.getElementById('txtDOBNos').disabled = true;
//                                    document.getElementById('ddlDOBDWMY').disabled = true;
//                                    document.getElementById('ddlSex').disabled = true;
//                                    document.getElementById('txtURNo').disabled = true;
//                                    document.getElementById('ddlUrnoOf').disabled = true;
//                                    document.getElementById('ddlUrnType').disabled = true;
//                                    document.getElementById('tDOB').disabled = true;

//                                    if (document.getElementById('txtClient') != null) {
//                                        if (document.getElementById('hdnBookedID').value != '0') {
//                                            LoadBookedpatientDetails();
//                                        }
//                                        else {
                                            LoadPreviousBillingItemsForPatient();
//                                        }
//                                    }
//                                    else {
                                        document.getElementById('hdnPatientID').value = PatientID;
                                        if (document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML != "") {
                                            document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML = "";
                                        }
                                        document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
                                        LoadComplaintItems((eventArgs.get_value().split('|')[1]));
                                        if (document.getElementById('txtAddress') != null) {
                                            document.getElementById('txtAddress').focus();
                                        }
                                        var list = ((eventArgs.get_value().split('|')[2]).substring(0, (eventArgs.get_value().split('|')[2]).length - 1)).split('~');
                                        while (count = document.getElementById('PatientPreference1_PatientPreference').rows.length) {

                                            for (var j = 0; j < document.getElementById('PatientPreference1_PatientPreference').rows.length; j++) {
                                                document.getElementById('PatientPreference1_PatientPreference').deleteRow(j);

                                            }
                                        }
                                        if ((eventArgs.get_value().split('|')[2]) != "") {
                                            for (var count = 0; count < list.length; count++) {
                                                var CList = list[count].split('~');
                                                var row = document.getElementById('PatientPreference1_PatientPreference').insertRow(0);
                                                row.id = parseInt(count);
                                                var rwNumber = row.id;
                                                var cell1 = row.insertCell(0);
                                                var cell2 = row.insertCell(1);
                                                var cell3 = row.insertCell(2);
                                                cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclickPreference(" + parseInt(rwNumber) + ");' style='cursor:pointer;'  src='../Images/Delete.jpg' />";
                                                cell2.innerHTML = CList[0];
                                                cell3.innerHTML = "<input onclick='btnEditPreference_OnClick(name);' name='" + parseInt(rwNumber) + "^" + CList[0] + "' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                                                if (rwNumber == '0') {
                                                    document.getElementById('hdnPreference').value += rwNumber + "^" + CList[0];
                                                }
                                                else {
                                                    document.getElementById('hdnPreference').value += "~" + rwNumber + "^" + CList[0];
                                                }
                                                document.getElementById('PatientPreference1_PatientPreference').style.display = 'block';
                                            }

                                        }
                                        if (document.getElementById('billPart_UcHistory_hdnPreference') != null) {
                                            document.getElementById('billPart_UcHistory_hdnPreference').value = (eventArgs.get_value().split('|')[2]).substring(0, (eventArgs.get_value().split('|')[2]).length - 1);
                                        }
                                        document.getElementById('btnSaveEMR').value = 'Update';
                                    }
                                //}
                            },
                            error: function(result) {
                                alert("Error");
                            }
                        });
                    }
                }
            }
            function onAttDocumentScanner()
            {
                var uuid = Attguid();
                window.location.href = "attunedocscanner:" + uuid;
                docScCount = 0;
                setTimeout(function () { checkdocScannerFile(uuid.trim()) }, 20000);
            }
            function Attguid() {
                function s4() {
                    return Math.floor((1 + Math.random()) * 0x10000)
                      .toString(16)
                      .substring(1);
                }
                return s4() + s4() +s4();
            }
            var docScanner = [];
            var docScCount = 0;
            function checkdocScannerFile(pFileName)
            {
                docScCount += 1;
                $.ajax({
                    type: "Post",
                    url: "../WebService/DocumentScanner.asmx/CheckFile",
                    data: "{ fileName: '" + pFileName + ".jpg'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        var p = data.d;
                        if (p === true) {
                            docScanner.push(pFileName)
                            docScannerTblist()
                        }
                        else {
                            if (docScCount < 3) {
                                setTimeout(function () { checkdocScannerFile(pFileName) }, 4000);
                            }
                        }
                    }
                });

            }
            function deletedocScannerFileFile(pFileName) {
                $.ajax({
                    type: "Post",
                    url: "../WebService/DocumentScanner.asmx/DeleteFile",
                    data: "{ fileName: '" + pFileName + ".jpg'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        var p = data;
                        docScanner.splice(docScanner.indexOf(pFileName), 1);
                        docScannerTblist()
                    }
                });

            }
            function docScannerTblist() {
                var s = '';
                $('#tblDocumentScanner').empty();
                $.each(docScanner, function (obj, value) {
                    if(value)
                    {
                        s += '<div class="MultiFile-label"><a class="MultiFile-remove" onclick="deletedocScannerFileFile(\''+value+'\')" href="#" style="color: red; font-size: large; font-weight: 900">x</a> <span class="MultiFile-title" title="">' + value + '.jpg</span></div>';
                    }
                });
                $('#tblDocumentScanner').append($(s));
                $("#hdnDocScanner").val(JSON.stringify(docScanner));
            }

            //Get HCPayments
            function getHCPayments() {
                var pBookingID = 0;
                var TotalNetAmt = 0;
                var IsHas = 'N';
                pBookingID = document.getElementById('hdnBookedID').value;
                ShowTRFfiles();
                $.ajax({
                    type: "POST",
                    url: "../OPIPBilling.asmx/GetHCPaymentDetails",
                    data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, BookingID: pBookingID }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        var Items = data.d;
                        var jsonCount = jsonObjCount(Items);
                        var singleValue = 'N';
                        if (jsonCount == 1)
                        { singleValue = 'Y' }

                        IsHas = 'Y';
                        if (jsonCount > 0) {
                            if (Items[0].IsTemplateText == 'Y' && Items[0].ProcedureName != "") { // for HomeCollection Bookings Only
                                document.getElementById('billPart_hdnHCPayments').value = 'Y';
                                controlsdisable();
                            }
                        }

                        $.each(Items, function(index, Item) {
                            var val, DiscValue = 0, splChar = '~',
                               Disval = 0, DisAmt = 0;
                            for (var k = 0; k < Items.length; k++) {
                                jsonCount--;
                                val = Items[k].ProcedureName;
                                DiscValue = Items[k].ProcedureType;
                                if (DiscValue.indexOf(splChar) != -1) {
                                    Disval = DiscValue;
                                }
                                else {
                                    Disval = 0;
                                    DisAmt = DiscValue;
                                }
                                var Pay = val.split('~');

                                $('#billPart_ddDiscountPercent option').map(function() {
                                    if ($(this).val() == Disval) return this;
                                }).attr('selected', 'selected');

                                if (Disval == 0 && DisAmt != 0) {
                                   $('#billPart_txtDiscount').val(DisAmt);
                                 }
                                 
                                if (val != null && val != "" && (jsonCount != -1 && jsonCount != 0 || singleValue == 'Y')) {
                                    var NetAmt = parseFloat(Pay[1]).toFixed(2);
                                    TotalNetAmt = parseFloat(Number(TotalNetAmt) + Number(NetAmt)).toFixed(2);
                                    $('#billPart_txtAmtReceived').val(parseFloat(TotalNetAmt).toFixed(2));

                                    CmdAddPaymentType_onclick(val);
                                    $('input[value="Edit"]').prop('disabled', true);
                                    $('.deleteIcons').attr('disabled', 'disabled');
                                    document.getElementById('hdnIsPaymentAdded').value = 'Y';

                                    if (Items[0].IsTemplateText == 'Y' && val != null && val != "") {
                                        document.getElementById('billPart_PaymentType_txtAmount').value = '0.00';
                                        ToTargetFormat($("#billPart_PaymentType_txtAmount"));
                                        document.getElementById('billPart_txtDue').value = '0.00';
                                        ToTargetFormat($("#billPart_txtDue"));
                                        document.getElementById('billPart_hdnDue').value = '0.00';
                                        ToTargetFormat($("#billPart_hdnDue"));
                                        document.getElementById('billPart_txtMRPDue').value = '0.00';
                                        ToTargetFormat($("#billPart_txtMRPDue"));
                                        document.getElementById('billPart_hdnMRPDue').value = '0.00';
                                        ToTargetFormat($("#billPart_hdnMRPDue"));
                                        controlsdisable();
                                    }
                                }
                            }
                        });
                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }
                });
            }

            function jsonObjCount(obj) {
                var prop;
                var propCount = 0;

                for (prop in obj) {
                    propCount++;
                }
                return propCount;
            }

            function controlsdisable() {
                $("#billPart_PaymentType_ddlPaymentType").attr('disabled', 'disabled');
                //$('#billPart_btnDiscountPercent').prop('disabled', true);
                $('#billPart_ddDiscountPercent').attr('disabled', 'disabled');
                $('#billPart_PaymentType_txtAmount').prop('disabled', true);
                $("#addNewPayment").css("display", "none");
                $("#billPart_btnAdd").attr('disabled', 'disabled');
                $("#billPart_txtTestName").attr('disabled', 'disabled');
                $("#txtPhleboName").attr('disabled', 'disabled');
                $("#txtClient").attr('disabled', 'disabled');
            }

            function ValidateHealthHubID() {
                var pBookingID = document.getElementById('hdnBookedID').value;
                var pHealthHubID = document.getElementById('txtHealthHubID').value.trim();
                var pName = document.getElementById('txtName').value.trim();
                var pGender = document.getElementById('ddlSex').value;
                var pDOB = document.getElementById('tDOB').value;
                var pMob = document.getElementById('txtMobileNumber').value.trim();
                var pEmail = document.getElementById('txtEmail').value.trim();

                $.ajax({
                    type: "POST",
                    url: "../OPIPBilling.asmx/ValidateHealthHubID",
                    data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, BookingID: pBookingID, HealthHubID: pHealthHubID, Name: pName, DOB: pDOB, Gender: pGender, Mob: pMob, Email: pEmail }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        var Items = data.d;
                        if (data.d.length != 0 && Items[0].HasHealthCard != "") {
                            if (Items[0].Comments == "Y") {
                                document.getElementById('txtHealthHubID').value = pHealthHubID;
                                return true;
                            }
                            else {
                                if (Items[0].PatientNumber == "") {
                                    ValidationWindow('Already exists of HealthHubID - ' + pHealthHubID + ' to the PatientName - ' + Items[0].Name + ' in Bookings', 'Alert');
                                    document.getElementById('txtHealthHubID').value = "";
                                    return false;
                                }
                                else {
                                    ValidationWindow('Already exists of HealthHubID - ' + pHealthHubID + ' to the PatientNumber - ' + Items[0].PatientNumber + ', PatientName - ' + Items[0].Name, 'Alert');
                                    document.getElementById('txtHealthHubID').value = "";
                                    return false;
                                }
                            }
                        }
                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }
                });
            }

   function ShowTRFfiles() {
                if (document.getElementById('billPart_hdnHCPayments').value == 'N') {
                    var pBookingID = document.getElementById('hdnBookedID').value;
                    $.ajax({
                        type: "POST",
                        url: "../OPIPBilling.asmx/GetHCTRFfile",
                        data: JSON.stringify({ BookingID: pBookingID }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function(data) {
                            var Items = data.d;
                            var jsonCount = jsonObjCount(Items);
                            var sFile = '', FileName= '', tempName = '', htmlStart = '', htmlEnd = '</div>',
                                inputStr = '', mStr = '<div class="MultiFile-list" id="FileUpload1_wrap_list">', Count = 0;
                            $('#FileUpload1_wrap').empty();
                            $.each(Items, function(index, Item) {
                                var val='';
                                if (Items != '') {
                                    for (var k = 0; k < Items.length; k++) {
                                        val = Items[k].Descrip;
                                      //  FileName = 'F:\\Attune\\TRFImages\\TRF_Upload\\220\\2021\\7\\6\\Home_Collection\\K89157770011.png'
                                        FileName = Items[k].IsTemplateText;
                                        $('#hdnTRFimageFileName').val(val);
                                         $('#hdnTRFimageFilePath').val(FileName);
//                                    $('#imgPatient').attr('src', "../PlatForm/Handler/ViewCameraImage.ashx?FileName=" + FileName);
//                                    $('#imgPatient').attr('width', "200px");
//                                    $('#imgPatient').attr('height', "80px");
//                                    $('#imgPatient').attr('style', "box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);border-radius: 10px;");
//                                        
                                        if (val != '' && tempName != val) {
                                            Count++
                                            tempName = '';
                                            tempName = val;
                                            document.getElementById('ChkTRFImage').checked = true;
                                            $('[id$="TRFimage"]').show();
                                            htmlStart = '<input type="file" name="FileUpload1" id="FileUpload1" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF" class="multi MultiFile-applied" value="" style="position: absolute; top: -3000px;">';
                                            if (jsonCount == Count) {
                                                inputStr += '<input type="file" name="FileUpload1" id="FileUpload1_F' + Count + '" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF" class="multi MultiFile-applied MultiFile" value="" >'
                                            }
                                            else {
                                                inputStr += '<input type="file" name="FileUpload1" id="FileUpload1_F' + Count + '" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF" class="multi MultiFile-applied MultiFile" value="" style="position: absolute; top: -3000px;">'
                                            }
                                            sFile += '<div class="MultiFile-label"><a class="MultiFile-remove" href="#FileUpload1_wrap" style="color: red; font-size: large; font-weight: 900">x</a> <span class="MultiFile-title" title="File selected: C:\\fakepath\\' + tempName + '">' + tempName + '</span></div>';
                                        }
                                    }
                                    $('#FileUpload1_wrap').append($(htmlStart + inputStr + mStr + sFile + htmlEnd));
                                }
                            });
                        },
                        failure: function(msg) {
                            ShowErrorMessage(msg);
                        }
                    });
                }
            }
