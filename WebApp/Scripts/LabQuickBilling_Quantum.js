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
}

function SetPreviousVisitItems() {
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
        tblStatr = " <div style='overflow: auto; height: 120px;width: 475px;'>"
                + "<table border='1' id='tblItems' cellpadding='1' cellspacing='0' class='dataheaderInvCtrl' style='text-align: left; font-size: 11px;' width='100%'>"
                + "<tr class = 'dataheader1' style='font-weight:bold;'><td style='width:30px;'>S.No</td><td  style='width:330px;'>Test Name</td><td  style='display:none;width:30px;'>ID</td><td style='display:block;width:30px;'>Type</td>"
                + "<td style='display:block;width:30px;'><input id='chkAll' name='chkAll1' onclick='chkSelectAll(document.form1.chkAll);' value='SelectAll' type='checkbox'>All</input></td><td  style='display:none;'>IsAddToday</td><td  style='display:none;'>IsOutSource</td><td  style='display:none;'>TestCode</td></tr>";

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

                        tblBoody += "<tr><td>" + parseInt(j + 1) + "</td><td>" + res[0] + "</td><td style='display:none;'>" + res[1] + "</td><td style='display:block;'>" + res[2] +
                                "</td><td style='display:block;'><input  id='" + str + "' name='chkAll'  value='" + '' + "' type='checkbox'  /></td><td style='display:none;'>" + res[5] + "</td><td style='display:none;'>" + res[6] + "</td><td style='display:none;'>" + res[7] + "</td>";

                        j++;
                        k++;
                    }
                }
                else {
                    count++;
                    if (count == 6) {
                        break;
                    }
                    tblBoody += "<tr><td style='font-weight:bold' colspan='5' title='" + strPatientHistory + "'>Visit Date : " + curdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Patient History: " + strPatientHistory.substring(0, 25) + "</td></tr>";
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
                    ddlVisitDetails.selectedIndex = 1;
                    document.getElementById('tdVisitType1').style.display = "none";
                    document.getElementById('tdVisitType2').style.display = "none";
                    var NewOrgID = document.getElementById('hdnNewOrgID').value;
                    //                    document.getElementById('tdSex1').style.width = '10%';
                    //                    document.getElementById('tdSex2').style.width = '18%';
                }
            }

        }
        tblTotal += "<tr><td colspan='5' style='display:block;' align='center'><input id='adds' type='button' value="+UsrAdd+" class='btn' onclick='javascript:AddPreviousVisitItemsToBilling();' ></td></tr>";
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
                + "<tr class = 'dataheader1' style='font-weight:bold;'><td style='width:30px;'>S.No</td><td  style='width:330px;'>Test Name</td><td  style='display:none;width:30px;'>ID</td><td style='display:block;width:30px;'>Type</td>"
                + "<td style='display:block;width:30px;'><input id='chkAll' name='chkAll1' onclick='chkSelectAll(document.form1.chkAll);' value='SelectAll' type='checkbox'>All</input></td><td  style='display:none;'>IsAddToday</td><td  style='display:none;'>IsOutSource</td><td  style='display:none;'>TestCode</td></tr>";

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

                        tblBoody += "<tr><td>" + parseInt(j + 1) + "</td><td>" + res[0] + "</td><td style='display:none;'>" + res[1] + "</td><td style='display:block;'>" + res[2] +
                                "</td><td style='display:block;'><input  id='" + str + "' name='chkAll'  value='" + '' + "' type='checkbox'  /></td><td style='display:none;'>" + res[5] + "</td><td style='display:none;'>" + res[6] + "</td><td style='display:none;'>" + res[7] + "</td><td style='display:none;'>" + res[10] + "</td>";

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
                    ddlVisitDetails.selectedIndex = 1;
                    document.getElementById('tdVisitType1').style.display = "block";
                    document.getElementById('tdVisitType2').style.display = "block";
                    //                    document.getElementById('tdSex1').style.width = '10%';
                    //                    document.getElementById('tdSex2').style.width = '18%';
                }
            }

        }
        tblTotal += "<tr><td colspan='5' style='display:block;' align='center'><input id='adds' type='button' value="+UsrAdd+" class='btn' onclick='javascript:AddPreviousVisitItemsToBilling();' ></td></tr>";
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


function chkSelectAll(obj) {
    for (i = 0; i < obj.length; i++) {
        obj[i].checked = document.form1.chkAll1.checked == true ? true : false;
    }
}
function AddPreviousVisitItemsToBilling() {
    if (IsItemChecked()) {
        var OrgID = document.getElementById('hdnOrgID').value;
        CallBillItems(OrgID);
        var tbl = document.getElementById('tblItems').rows.length;
        var td = document.getElementById('tblItems');
        var rate = document.getElementById('txtClient').value;

        var Billdate = document.getElementById('billPart_hdnBilledDate').value;
        var BillNo = document.getElementById('hdnqrystrBillNo').value;
        var PatientID = document.getElementById('hdnPatientID').value;
        if (PatientID > 0) {
            ExtVisitNUmber = $('#txtExternalVisitID').val();
        }
        else {
            ExtVisitNUmber = '';
        }
        
        var pretex = new Array();
        var idv = new Array();
        if (tbl > 1) {
            var i = 1;
            var j = 0;
            var x = -1;
            for (i = 1; i < tbl - 1; i++) {
                var cellcount = td.rows[i].cells.length;
                if (cellcount > 1) {
                    var tdID = td.rows[i].cells[4].childNodes[0].id;
                    if (document.getElementById(tdID).checked == true) {
                        x++;
                        var testName = td.rows[i].cells[1].childNodes[0];
                        var id = td.rows[i].cells[2].childNodes[0];
                        var FeeType = td.rows[i].cells[3].childNodes[0];
                        var IsOutSource = td.childNodes[0].rows[i].cells[6];
                        IsOutSource = IsOutSource.innerHTML;
                        //td.rows[i].cells[6].childNodes[0];
                        
                        if (document.getElementById('hdnBookedID').value != '0') {
                            var TestCode = td.rows[i].cells[8].childNodes[0];
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
                                data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, FeeID: id.data, FeeType: FeeType.data, Description: testName.data, ClientID: document.getElementById('hdnSelectedClientClientID').value, VisitID: 0, Remarks: '', IsCollected: document.getElementById('billPart_hdnIsCollected').value, CollectedDatetime: document.getElementById('billPart_hdnCollectedDateTime').value, locationName: document.getElementById('billPart_hdnLocName').value, OrderedItem: document.getElementById('hdnordereditems').value, ExtVisitNumber: document.getElementById('txtExternalVisitID').value, BilledDate: Billdate, BillNo: BillNo }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: true,
                                success: function(data) {
                                    var Items = data.d;
                                    $.each(Items, function(index, Item) {
                                        var valu;
                                        for (var k = 0; k < Items.length; k++) {
                                            valu = Items[k].ProcedureName;
                                            for (var m = 0; m < pretex.length; m++) {
                                                var idvalu = valu.split('^');

                                                var defalutdata = valu.split('^');

                                                FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[2] + "~Descrip^" + defalutdata[1] +
                                                                        "~Amount^" + defalutdata[3] + "~Quantity^" + 1 + "~Remarks^" + defalutdata[5] + "~ReportDate^" + "" +
                                                                        "~IsReimbursable^" + defalutdata[6] + "~ActualAmount^" + defalutdata[8] + "~IsDiscountable^" + defalutdata[9]
                                                                         + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13]
                                                                         + "~IsOutSource^" + IsOutSource + "~IsNABL^" + defalutdata[14] + "~BillingItemRateID^" + defalutdata[15] + "~Code^" + defalutdata[18] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + defalutdata[17] + "~BaseRateID^" + defalutdata[210] + "|";


                                                document.getElementById('billPart_hdfBillType1').value = (document.getElementById('billPart_hdfBillType1').value).replace(FeeViewStateValue, '');
                                                document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;
                                                j++;


                                            }
                                        }


                                    });
                                    if (j >= (pretex.length)) {
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

function IsItemChecked() {
    var flag = 0;
    var flagAlreadyToday = 0;
    var tbl = document.getElementById('tblItems').rows.length;
    var td = document.getElementById('tblItems');
    if (tbl > 0) {
        for (var i = 0; i < tbl - 1; i++) {
            var cellcount = td.rows[i].cells.length;
            if (cellcount > 1) {
                var tdID = td.rows[i].cells[4].childNodes[0].id;
                if (document.getElementById(tdID).checked == true) {
                    var FeeID = td.rows[i].cells[2].childNodes[0];
                    var FeeType = td.rows[i].cells[3].childNodes[0];
                    var IsAddedToday = td.rows[i].cells[5].childNodes[0];
                    var ItemArrayAlreadyToday = new Array();
                    var resAlreadyToday = new Array();
                    ItemArrayAlreadyToday = document.getElementById('hdnPreviousVisitDetails').value.split('^');
                    for (i = 0; i < ItemArrayAlreadyToday.length; i++) {
                        res = ItemArrayAlreadyToday[i].split('$');
                        if (FeeID.data == res[1] && 'Y' == res[5] && FeeType.data == res[2]) {
                            flagAlreadyToday++;
                        }
                    }

                    flag++;
                }
            }
        }
    }

    if (flag == 0) {
        alert('Does not allowed to add  to click the checkbox');
    }
    else {
        if (flagAlreadyToday == 1) {
            if (window.confirm("Warning: The selected test already ordered today...!  Do you want to continue?")) {
                flagAlreadyToday = 0;
            }
            else {
                flagAlreadyToday = 1;
            }
        }
        if (flagAlreadyToday == 0)
            return true;
        else
            return false;
    }
}

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
                    document.getElementById('hdnPreviousVisitDetails').value += Item.FeeDescription + '$' + Item.FeeId + '$' + Item.FeeType + '$' + Item.Address + '$' + Item.PatientHistory + '$' + Item.Status + '$' + Item.IsOutSource + '$' + Item.ServiceCode + '$' + Item.IsAVisitPurpose + '$' + Item.VisitID + '^';
                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
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

function LoadBookedpatientDetails() {
    //debugger;
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
                    document.getElementById('hdnPreviousVisitDetails').value += Item.Name + '$' + Item.ID + '$' + Item.Type + '$' + Item.SourceType + '$' + "" + '$' + "" + '$' + "N" + '$' + "0" + '$' + "" + '$' + "" + '$' + "" + '^';
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
    window.open(url, "billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");

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
    if (document.getElementById('ddlUrnType').value == 10) {
        $(document).ready(function() {
            $("#txtURNo").attr('maxlength', '12');
        });
    }
    else {
        document.getElementById('txtURNo').removeAttribute("MaxLength");
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
    if (document.getElementById('billPart_hdnCpedit').value != null) {
        if (document.getElementById('billPart_hdnCpedit').value != "Y") {

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

                var textBox = $get('tDOB');
                if (textBox.AjaxControlToolkitTextBoxWrapper) {
                    textBox.AjaxControlToolkitTextBoxWrapper.set_Value('');
                }
                if (document.getElementById('txtMobileNumber') != null) {
                    document.getElementById('txtMobileNumber').value = "";
                }
                if (document.getElementById('txtPhone') != null) {
                    document.getElementById('txtPhone').value = "";
                }
                if (document.getElementById('txtAddress') != null) {
                    document.getElementById('txtAddress').value = "";
                }
                if (document.getElementById('txtPincode') != null) {
                    document.getElementById('txtPincode').value = "";
                }
                if (document.getElementById('txtCity') != null) {
                    document.getElementById('txtCity').value = "";
                }
                document.getElementById('txtDOBNos').value = "";
                document.getElementById('txtReferringHospital').value = "";
                document.getElementById('ddlDOBDWMY').value = "Year(s)";
                document.getElementById('txtInternalExternalPhysician').value = "";
                if (document.getElementById('TxtClientCodeMap') != null) {
                    document.getElementById('TxtClientCodeMap').value = "";
                }
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
                if (document.getElementById('txtEmail') != null) {
                    document.getElementById('txtEmail').value = "";
                }
                document.getElementById('ChkTRFImage').checked = false;
                if (document.getElementById('chkMobileNotify') != null) {
                    document.getElementById('chkMobileNotify').checked = false;
                }
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
                if (document.getElementById('lblPatientDetails') != null) {
                    document.getElementById('lblPatientDetails').innerHTML = "";
                }
                if (document.getElementById('trPatientDetails') != null) {
                    document.getElementById('trPatientDetails').style.display = "none";
                }
                    document.getElementById('txtClient').value = '';
                    document.getElementById('txtClient').disabled = false;
                    document.getElementById('hdnClientName').value = "";
                    document.getElementById('txtInternalExternalPhysician').value = '';
                    document.getElementById('hdnSelectedClientClientID').value = "0";
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
                if ((document.getElementById('hdnDefaultClienID') != null) && (document.getElementById('hdnDefaultClienName') != null)) {
                    if ((document.getElementById('hdnDefaultClienID').value == "") ||
                ((document.getElementById('hdnDefaultClienName').value != "") && (document.getElementById('hdnDefaultClienName').value != document.getElementById('txtClient').value))) {

                        document.getElementById('hdnSelectedClientClientID').value = document.getElementById('hdnDefaultClienID').value;
                    }
                }
                else {
                    document.getElementById('hdnSelectedClientClientID').value = document.getElementById('hdnBaseClientID').value;
                }
                document.getElementById('hdnRateID').value = document.getElementById('hdnBaseRateID').value;
                document.getElementById('hdnMappingClientID').value = "-1";
                document.getElementById('hdnIsMappedItem').value = "N";
                document.getElementById('hdfReferalHospitalID').value = "0";
                //document.getElementById('txtSampleDate').value = "";
                document.getElementById('lblClientDetails').innerHTML = "";
                if (document.getElementById('ddlDespatchMode') != null) {
                    document.getElementById('ddlDespatchMode').value = 0;
                }
                if (document.getElementById('txtSuburban') != null) {
                    document.getElementById('txtSuburban').value = "";
                }
                document.getElementById('txtExternalPatientNumber').value = "";
                if (document.getElementById('ddCountry') != null) {
                    document.getElementById('ddCountry').value = document.getElementById('hdnDefaultCountryID').value;
                }
                if (document.getElementById('lblCountryCode') != null) {
                    document.getElementById('lblCountryCode').innerHTML = document.getElementById('hdnDefaultCountryStdCode').value;
                }
                document.getElementById('ddlUrnoOf').value = 0;
                document.getElementById('ddlUrnType').selectedIndex = 0;
                document.getElementById('txtURNo').value = "";
                document.getElementById('hdnPatientName').value = "";
                document.getElementById('billPart_UcHistory_hdnPreference').value = "";
                document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value = "";
                document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
                if (document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference') != null) {
                    document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference').value = "";
                }
                if (document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference') != null) {
                    document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').innerText = "";
                }
                if (document.getElementById('billPart_UcHistory_PatientPreference1hdnPreference') != null) {
                    document.getElementById('billPart_UcHistory_PatientPreference1hdnPreference').value = ""
                }
                document.getElementById('billPart_tdHistory').style.display = "none";
                clearBillPartValues();
                clearDespatchMode();
                var panelLegend = $('#PnlPatientDetail legend');
                panelLegend.html("Patient Details");
                ClearTodayVisitItems();
                    document.getElementById('txtDOBNos').disabled = false;
                    document.getElementById('ddlDOBDWMY').disabled = false;
                    document.getElementById('ddlSex').disabled = false;
                    document.getElementById('txtURNo').disabled = false;
                    document.getElementById('ddlUrnoOf').disabled = false;
                    document.getElementById('ddlUrnType').disabled = false;
                    document.getElementById('tDOB').disabled = false;
}
            }
        }
    }
}

function clearPageControlsVal(ClearType) {
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
        document.getElementById('tDOB').value = "";
        if (document.getElementById('txtMobileNumber') != null) {
            document.getElementById('txtMobileNumber').value = "";
        }
        if (document.getElementById('txtSuburban') != null) {
            document.getElementById('txtSuburban').value = "";
        }
        if (document.getElementById('txtPhone') != null) {
            document.getElementById('txtPhone').value = "";
        }
        if (document.getElementById('txtAddress') != null) {
            document.getElementById('txtAddress').value = "";
        }
        if (document.getElementById('txtPincode') != null) {
            document.getElementById('txtPincode').value = "";
        }
        if (document.getElementById('txtCity') != null) {
            document.getElementById('txtCity').value = "";
        }
        document.getElementById('txtDOBNos').value = "";
        document.getElementById('ddlDOBDWMY').value = "Year(s)";
        if (document.getElementById('txtEmail') != null) {
            document.getElementById('txtEmail').value = "";
        }
        document.getElementById('hdnPatientID').value = "-1";
        if (document.getElementById('ddCountry') != null) {
            document.getElementById('ddCountry').value = document.getElementById('hdnDefaultCountryID').value;
        }
        if (document.getElementById('lblCountryCode') != null) {
            document.getElementById('lblCountryCode').innerHTML = document.getElementById('hdnDefaultCountryStdCode').value;
        }
        document.getElementById('ddlUrnoOf').value = 0;
        document.getElementById('ddlUrnType').selectedIndex = 0;
        if (document.getElementById('ddState') != null) {
            document.getElementById('ddState').value = 11;
        }
        //document.getElementById('ddSalutation').value = 7;
        if (document.getElementById('ddCountry') != null) {
            document.getElementById('ddCountry').value = 75;
        }
        // loadState("31");
        document.getElementById('txtURNo').value = "";
        document.getElementById('ComplaintICDCodeBP1_txtICDName').value = "";
        document.getElementById('ComplaintICDCodeBP1_txtCpmlaint').value = "";
        document.getElementById('ComplaintICDCodeBP1_txtICDCode').value = "";
        document.getElementById('PatientPreference1_txtEnterPreference').value = "";
        if (document.getElementById('PatientPreference1_PatientPreference').innerText != "") {
            document.getElementById('PatientPreference1_PatientPreference').innerText = "";
        }
        if (document.getElementById('lblPatientDetails') != null) {
            document.getElementById('lblPatientDetails').innerHTML = "";
        }
        if (document.getElementById('trPatientDetails') != null) {
            document.getElementById('trPatientDetails').style.display = "none";
        }
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
        var panelLegend = $('#PnlPatientDetail legend');
        panelLegend.html("Patient Details");
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
    if (document.getElementById('txtSampleDate') != null) {
        if (document.getElementById('txtSampleDate').value != '') {
            var currentdate = document.getElementById('txtcurrendate').value;
            var Sampledt = document.getElementById('txtSampleDate').value;
            var dt1 = currentdate.split(' ');
            var dt2 = Sampledt.split(' ');
            if (Date.parse(Sampledt) > Date.parse(date)) {
                alert("Dont select sample pickup date as future Date.");
                document.getElementById('txtSampleDate').value = '';
                document.getElementById('txtSampleDate').value = date;
                return false;
            }
        }
    }
}
function FutureDateValidation() {
    if (document.getElementById('tDOB') != null) {
        if (document.getElementById('tDOB').value != '') {
            var obj = document.getElementById('tDOB').value;
            var currentTime;
            if (obj != '' && obj != '01/01/1901' && obj != '__/__/____' && obj != 'dd/MM/yyyy') {
                dobDt = obj.split('/');
                var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                var mMonth = dobDtTime.getMonth() + 1;
                var mDay = dobDtTime.getDate();
                var mYear = dobDtTime.getFullYear();
                currentTime = new Date();
                var month = currentTime.getMonth() + 1;
                var day = currentTime.getDate();
                var year = currentTime.getFullYear();
                if (mYear == year && mMonth == month && mDay > day) {
                    alert('Invalid Date. Please Select A Valid Date');
                    document.getElementById('tDOB').value = '';
                    document.getElementById('txtDOBNos').value = '';
                    return false;
                }
                else if (mYear > year) {
                    alert('Invalid Date. Please Select A Valid Date');
                    document.getElementById('tDOB').value = '';
                    document.getElementById('txtDOBNos').value = '';
                    return false;
                }
                else if (mYear == year && mMonth > month) {
                    alert('Invalid Date. Please Select A Valid Date');
                    document.getElementById('tDOB').value = '';
                    document.getElementById('txtDOBNos').value = '';
                    return false;
                }
            }
            return true;
        }
    }
}
function validateEvents(obj) {

    if (document.getElementById('txtDOBNos').disabled == true) {
        document.getElementById('txtDOBNos').disabled = false;
        document.getElementById('ddlDOBDWMY').disabled = false;
        document.getElementById('ddlSex').disabled = false;
        document.getElementById('txtURNo').disabled = false;
        document.getElementById('ddlUrnoOf').disabled = false;
        document.getElementById('ddlUrnType').disabled = false;
        document.getElementById('tDOB').disabled = false;
        if (document.getElementById('hdnHideControls') != null) {
            document.getElementById('hdnHideControls').value = 'Y';
        }
    }
    ForFutureDate();

    //Added By Prasanna.S
    var dateformat;
    if (document.getElementById('hdnDateFormatConfig') != null)
        dateformat = document.getElementById('hdnDateFormatConfig').value;
    else
        dateformat = "dd/MM/yyyy";


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
            alert("Referring Doctor discount limit is exceeded for this period, will not be able to provide further discounts.");
            //("Insufficient Discount Limit");
            return false;
        }
        else {
            alert("Employee discount limit is exceeded for this period, will not be able to provide further discounts.");
            return false;
        }

    }
    if ($('#txtName').val() != undefined && $.trim($('#txtName').val()) == '') {
        alert('Provide patient name');
        $('#txtName').focus();
        return false;
    }
    if ($('#txtExternalVisitID').val() != undefined && $.trim($('#txtExternalVisitID').val()) == '') {
        alert('Provide External VisitID');
        $('#txtExternalVisitID').focus();
        return false;
    }
    if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == dateformat.toLowerCase() || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'mm//dd//yyyy')) {
        alert('Provide patient age or date of birth');
        document.getElementById('txtDOBNos').focus();
        return false;
    }
    //  if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
    //      if (document.getElementById('ddlSex').disabled != true) {
    //          alert('Select patient sex');
    //          document.getElementById('ddlSex').focus();
    //           return false;
    //       }
    //  }
    if (document.getElementById('chkMobileNotify') != null) {
        if (document.getElementById('chkMobileNotify').checked == true) {
            if (document.getElementById('txtMobileNumber') != null) {
                if (document.getElementById('txtMobileNumber').value == '') {
                    alert('Provide contact mobile number');
                    document.getElementById('txtMobileNumber').focus();
                    return false;
                }
            }
        }
    }
    if (document.getElementById('hdnIsContactNumbermMndatory') != null) {
        if (document.getElementById('hdnIsContactNumbermMndatory').value == 'Y') {
            if ((document.getElementById('txtMobileNumber') != null) && (document.getElementById('txtPhone') != null)) {
                if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '') {
                    alert('Provide contact mobile or telephone number');
                    $('#txtMobileNumber').focus();
                    return false;
                }
            }
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
    var CPEDIT = document.getElementById('billPart_hdnCpedit').value;
    var elements = document.getElementById('chkDisPatchType');
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
    }

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
    if (CPEDIT != 'Y') {
        if (document.getElementById('txtEmail') != null) {
            if ($.trim($('#txtEmail').val()) != '') {
                var x = document.getElementById('txtEmail').value;
                var atpos = x.indexOf("@");
                var dotpos = x.lastIndexOf(".");
                if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
                    alert("Provide a valid e-mail address");
                    $('#txtEmail').focus();
                    return false;
                }
            }
        }
        if (obj == 'After') {
            var HasHistory = document.getElementById('billPart_hdnCapture').value;
            var HistoryValue = document.getElementById('billPart_hdnHistoryTableList').value;
            if (HasHistory == 1) {
                if (HistoryValue == '') {
                    alert('History needs to be captured for this Patient');
                    return false;
                }
            }
        }

        if (obj == 'After') {
            var externalVisitID = document.getElementById('hdnExternalVisitID').value;
            if (externalVisitID == 1) {
                var textBox = document.getElementById("txtExternalVisitID");
                var textLength = textBox.value.length;
                if (textLength < 9) {
                    alert('Invalid. Scan the correct barcode');
                    document.getElementById('txtExternalVisitID').focus();
                    return false;
                }
            }
        }



        if (obj == 'Before' && $('[id$="hdnPatientAlreadyExists"]').val() == 0) {
            IsPatientAlreadyExists();
        }
        var elements = document.getElementById('chkDespatchMode');
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

        }

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
            if (document.getElementById('chkSamplePickup') != null) {
                if (document.getElementById('chkSamplePickup').checked == true) {
                    if (document.getElementById('txtSampleDate').value == '') {
                        alert('Provide Sample Pickup Date');
                        document.getElementById('txtSampleDate').focus();
                        return false;
                    }
                }
            }
            if ($('[id$="hdfBillType1"]').val() == '' && obj != 'Before') {
                alert('Include billing items');
                document.getElementById('billPart_txtTestName').focus();
                return false;
            }
            if (Number($('[id$="hdnDiscountAmt"]').val()) > 0 && obj == 'After') {
                if ($.trim($('[id$="txtAuthorised"]').val()) == '') {
                    alert('Provide discount authorised by');
                    $('[id$="txtAuthorised"]').focus();
                    return false;
                }
                if (document.getElementById('billPart_hdnAllowMulDisc').value != 'Y') {
                    if ($('[id$="ddlDiscountReason"]').val() == '0') {
                        alert('Provide discount reason');
                        $('[id$="ddlDiscountReason"]').focus();
                        return false;
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
                    var ans = window.confirm('Only miscellaneous item is added, do you want to continue?');
                    if (ans == true)
                        return true;
                    else
                        return false;
                }
                if (document.getElementById("txtClient").value.trim() == '') {
                    if (document.getElementById('hdnMinimumDue').value == 'Y') {
                        if (document.getElementById('hdnMinimumDuePercent').value != '') {
                            var perc = document.getElementById('hdnMinimumDuePercent').value;

                            var tot = $('[id$="hdnNetAmount"]').val();
                            var per = Number(document.getElementById('hdnMinimumDuePercent').value) / 100;
                            var dis = tot * per;
                            var amr = Number($('[id$="hdnAmountReceived"]').val());
                            if (amr < dis) {
                                var ans = window.confirm('Received amount atleast ' + perc + '% of Net amount (Rs:' + dis + ').\n Do you want to continue?');
                                if (ans == true) {
                                    $('[id$="hdnDue"]').val((Number($('[id$="hdnNetAmount"]').val()) - Number($('[id$="hdnAmountReceived"]').val())));
                                    $('[id$="btnGenerate"]').hide();
                                }
                                else {
                                    return false;
                                }
                            }

                        }
                    }

                    if (Number($('[id$="hdnNetAmount"]').val()) > Number($('[id$="hdnAmountReceived"]').val()) && $.trim($('[id$="txtClient"]').val()) == '') {
                        var pBill = confirm("Bill amount will be added to due.\n Do you want to continue");
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
                $('[id$="hdnDue"]').val((Number($('[id$="hdnNetAmount"]').val()) - Number($('[id$="hdnAmountReceived"]').val())));
                $('[id$="btnGenerate"]').hide();
                $('[id$="btnClose"]').hide();
            }
            $('[id$="hdnPatientAlreadyExists"]').val(0);
        }
        else {
            var IsEditPatient;
            IsEditPatient = checkPatientEdit(obj);
            if (IsEditPatient == false) {
                var ans = window.confirm('There is a change in Age / Gender, Any Result entry completed reports for this Visit need to be re-validated');
                if (ans == true)
                    return true;
                else
                    return false;
            }
        }
    }



}
function validationEvents(obj) {

    //Added By Prasanna.S
    var dateformat;
    if (document.getElementById('hdnDateFormatConfig') != null)
        dateformat = document.getElementById('hdnDateFormatConfig').value;
    else
        dateformat = "dd/MM/yyyy";


    if ($('#txtName').val() != undefined && $.trim($('#txtName').val()) == '') {
        alert('Provide patient name');
        $('#txtName').focus();
        return false;
    }
    if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == dateformat.toLowerCase() || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'mm//dd//yyyy')) {
        alert('Provide patient age or date of birth');
        document.getElementById('txtDOBNos').focus();
        return false;
    }
    if ((document.getElementById('ddlSex').selectedIndex != '-1') || (document.getElementById('ddlSex').selectedIndex != '0')) {
        if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
            alert('Select patient sex');
            document.getElementById('ddlSex').focus();
            return false;
        }

    }
    if (document.getElementById('txtMobileNumber').value != null) {
        if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '') {
            alert('Provide contact mobile or telephone number');
            $('#txtMobileNumber').focus();
            return false;
        }
    }
    if (document.getElementById('txtEmail').value != null) {
        if ($.trim($('#txtEmail').val()) != '') {
            var x = document.getElementById('txtEmail').value;
            var atpos = x.indexOf("@");
            var dotpos = x.lastIndexOf(".");
            if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
                alert("Provide a valid e-mail address");
                $('#txtEmail').focus();
                return false;
            }
        }
    }
}
//jayamoorthi--------------------------------------------
function checkPatientEdit(obj) {
    // alert(document.getElementById('hdnPatientAge').value);
    //       alert(document.getElementById('hdnPatientDOB').value);
    //       alert(document.getElementById('hdnPatientSex').value);
    //       alert(document.getElementById('hdnIsEditMode').value);
    if (document.getElementById('hdnIsEditMode').value == 'Y' && obj == 'After') {
        if ((parseInt(document.getElementById('txtDOBNos').value) != parseInt(document.getElementById('hdnPatientAge').value)) || (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value != document.getElementById('hdnPatientSex').value) || (document.getElementById('tDOB').value.trim() != document.getElementById('hdnPatientDOB').value)) {

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

function Tblist() {
    $('[id$="trPatientDetails"]').show();
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    $('[id$="lblPatientDetails"]').html("");
    table = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
                           + "<th style='width:80px;'>Name</th>"
                           + "<th style='width:50px;'>Number</th>"
                           + "<th style='width:40px;'>OrgName</th>"
                            + "<th style='width:20px;'>URNNo</th>"
                           + "<th style='width:300px;'>Address</th>"
                           + "<th style='Widht:100px;'>Phone</th> </thead>";
    var x = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");

    tr = "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
                        + x[1] + "</td><td style='width:100px;'>"
                        + x[2] + "</td><td style='width:100px;'>"
                        + x[25] + "</td><td style='width:100px;'>"
                        + x[16] + "</td><td style='width:20px;'>"
                        + x[8] + ',' + x[20] + ',' + x[9] + "</td><td style='width:100px;'>"
                        + x[7] + "</td></tr>";



    var tab = table + tr + end;
    $('[id$="lblPatientDetails"]').html(tab);
    tbshow();


}
function SelectedPatient(source, eventArgs) {
    var dateformat;
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
    if (document.getElementById('hdnDateFormatConfig') != null) {
        dateformat = document.getElementById('hdnDateFormatConfig').value;
    }
    else {
        dateformat = "dd/MM/yyyy";
    }

    var isPatientDetails = "";
    isPatientDetails = eventArgs.get_value().split('|')[0];

    var PatientName1 = eventArgs.get_text().split(':')[0];
     var PatientName = PatientName1.split('(')[0]
    var PatientNumber = isPatientDetails.split('~')[2];
    //var PatientNumber = eventArgs.get_text().split(':')[1];
    var PatientVisitType = eventArgs.get_text().split(':')[2];

    var PatientTITLECode = isPatientDetails.split('~')[0];
    var PatientAge = isPatientDetails.split('~')[3];
    var FullPatientDOBAll = isPatientDetails.split('~')[4];

    //Sathish.E**************//

    var FullPatientDOB = FullPatientDOBAll.split('/');
    var dDate = FullPatientDOB[0];
    var dMonth = FullPatientDOB[1];
    var dYear = FullPatientDOB[2];
    if (dateformat == "dd/MM/yyyy") {
        var PatientDOB = dDate + '/' + dMonth + '/' + dYear;
    }
    else {
        var PatientDOB = dMonth + '/' + dDate + '/' + dYear;
    }
    //SAthish.E****************//
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
    var PatientEmailCC = isPatientDetails.split('~')[35];
    document.getElementById('hdnCalculateDays').value = isPatientDetails.split('~')[27];

    if (document.getElementById('hdnBookedID') != null) {
        document.getElementById('hdnBookedID').value = isPatientDetails.split('~')[26];
    }
    if (URNNo != "" && URNTypeId == 6) {
        SetDiscountLimit(URNNo);
    }
    if (searchtype == "3") {
    var ClientName = isPatientDetails.split('~')[29];
    var ClientIID = isPatientDetails.split('~')[28];
    if (ClientIID != null && ClientIID != undefined) {
        document.getElementById('hdnSelectedClientClientID').value = ClientIID;
    }
    if (ClientName != null && ClientName != undefined) {
        document.getElementById('txtClient').value = ClientName;
    }
    var RefPhyName = isPatientDetails.split('~')[30];
    if (RefPhyName != null && RefPhyName != undefined) {
        document.getElementById('txtInternalExternalPhysician').value = RefPhyName;
    }
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
    if (document.getElementById('txtMobileNumber') != null) {
        document.getElementById('txtMobileNumber').value = PatientMobile;
    }
    if (PatientPhone != null) {
        if (document.getElementById('txtPhone') != null) {
            document.getElementById('txtPhone').value = PatientPhone;
        }
    }
    if (document.getElementById('txtAddress') != null) {
        document.getElementById('txtAddress').value = PatientAddress.trim();
    }
    if (document.getElementById('txtCity') != null) {
        document.getElementById('txtCity').value = PatientCity;
    }
    if (PatientNationality != '') {
        if (document.getElementById('ddlNationality') != null) {
            document.getElementById('ddlNationality').value = PatientNationality;
        }
    }
    if (document.getElementById('ddCountry') != null) {
        document.getElementById('ddCountry').value = PatientCountryID;
    }
    //document.getElementById('ddCountry').onchange();
    document.getElementById('hdnPatientStateID').value = PatientStateID;
    if (document.getElementById('ddState') != null) {
        document.getElementById('ddState').value = PatientStateID;
        if (PatientStateID == "") {
            loadState("11");
        }
    }
    document.getElementById('hdnPatientID').value = PatientID;
    var textBox = $get('tDOB');
    if (textBox.AjaxControlToolkitTextBoxWrapper) {
        textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
    }
    else {
        textBox.value = PatientDOB;
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
    document.getElementById('txtURNo').value = URNNo;
    document.getElementById('hdnNewOrgID').value = NewOrgID;
    document.getElementById('ddlUrnoOf').value = URNofId;
    document.getElementById('ddlUrnType').value = URNTypeId;
    if (document.getElementById('lblPatientDetails') != null) {
        document.getElementById('lblPatientDetails').innerHTML = '';
    }
    if (document.getElementById('trPatientDetails') != null) {
        document.getElementById('trPatientDetails').style.display = "none";
    }
    if (document.getElementById('txtClient') != null) {
        document.getElementById('txtClient').focus();
    }
    //Getdigitalnumber(document.getElementById('lblPreviousDueText'), PatientPreviousDue);
    if (document.getElementById('billPart_lblPreviousDueText') != null) {
        document.getElementById('billPart_lblPreviousDueText').innerHTML = PatientPreviousDue;
    }
    if (document.getElementById('txtSuburban') != null) {
        document.getElementById('txtSuburban').value = Suburban;
    }
    if (document.getElementById('txtExternalPatientNumber') != null) {
        document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
    }
    if (searchtype == "3") {
        var NRICNType = isPatientDetails.split('~')[32];
        var NRICNNumber = isPatientDetails.split('~')[33];
        var ExternalPatNo = isPatientDetails.split('~')[34];
        document.getElementById('ddlUrnType').value = NRICNType;
        document.getElementById('txtURNo').value = NRICNNumber;
	 document.getElementById('hdnUrnNo').value = NRICNNumber;
	     
        if (document.getElementById('txtExternalPatientNumber') != null) {
            document.getElementById('txtExternalPatientNumber').value = ExternalPatNo;

        }
    }
    //Disabling the controls
    document.getElementById('txtDOBNos').disabled = true;
    document.getElementById('ddlDOBDWMY').disabled = true;
    document.getElementById('ddlSex').disabled = true;
    document.getElementById('txtURNo').disabled = true;
    document.getElementById('ddlUrnoOf').disabled = true;
    document.getElementById('ddlUrnType').disabled = true;
    document.getElementById('tDOB').disabled = true;


    var panelLegend = $('#PnlPatientDetail legend');
    panelLegend.html("Patient Details ").append('<b>(Patient No: ' + PatientNumber + ' )</b>');
    document.getElementById('PnlPatientDetail');
    document.getElementById('hdnPatientName').value = PatientName;
    document.getElementById('hdnPatientID').value = PatientID;

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


    var PatientName1 = eventArgs.get_text().split(':')[0];
    var PatientName = PatientName1.split('(')[0]
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
    var PatientEmailCC = isPatientDetails.split('~')[28];


    document.getElementById('txtPatientName').value = PatientName;
    document.getElementById('txtPatientNumber').value = PatientNumber

    document.getElementById('txtPhoneNumber').value = PatientMobile;




}
function SelectedPatientEdit() {
    
    var arrGotValue = new Array();
    var OrgID = document.getElementById('hdnOrgID').value;
    var PatientID = document.getElementById('hdnPatientID').value;
    var prefixText = document.getElementById('hdnPatientName').value;
    var Role = document.getElementById('hdnRoleName').value;
    var ExtVisitID = document.getElementById('hdnExternalVisitID').value;
    var VisitID = document.getElementById('hdnVisitID').value;
    sval = OrgID + '~' + PatientID;

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetLabQuickBillPatientList_Quantum",
        data: JSON.stringify({ prefixText: prefixText, count: '0', contextKey: document.getElementById('hdnOrgID').value + '~' + document.getElementById('hdnPatientID').value + '~' + '4' + '~' + ExtVisitID + '~' + VisitID }),
        dataType: "json",
        success: function(data, value) {
        var GetData = JSON.parse(data.d[0]);

        var PatientName1 = GetData.First.split(':')[0];
        var PatientName = PatientName1.split('(')[0]
            var isPatientDetails = GetData.Second;
            var PatientNumber = GetData.First.split(':')[1];
            if (PatientNumber == undefined && PatientNumber == null) {
                PatientNumber = isPatientDetails.split('~')[2];
            }
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
            var ClientMapCode = isPatientDetails.split('~')[47];
           var PatientEmailCC = isPatientDetails.split('~')[49];
            var ReferingID = isPatientDetails.split('~')[50];
            if (PatientEmailCC == undefined)
                var PatientEmailCC = "";
            if (document.getElementById('TxtClientCodeMap') != null) {
                if ((ClientMapCode != '') && (ClientMapCode != undefined)) {
                    document.getElementById('TxtClientCodeMap').value = ClientMapCode;

                }
            }
            document.getElementById('hdfReferalHospitalID').value = ReferingID;
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
            if (Role != "") {
                if (Role != 'STAR ADMIN' && Role != 'Centre Manager') {
                    document.getElementById('txtDOBNos').disabled = true;
                    document.getElementById('ddlSex').disabled = true;
                    document.getElementById('tDOB').disabled = true;
                    document.getElementById('ddlDOBDWMY').disabled = true;
                }
            }
            var CPEDIT = "";
            if (document.getElementById('hdnEditbillDisable') != null) {
                CPEDIT = document.getElementById('hdnEditbillDisable').value;
            }
            if (CPEDIT != null && CPEDIT != undefined && CPEDIT != "") {
                if (CPEDIT == "Y") {
                    document.getElementById('txtDOBNos').disabled = true;
                    document.getElementById('ddlSex').disabled = true;
                    document.getElementById('tDOB').disabled = true;
                    document.getElementById('ddlDOBDWMY').disabled = true;
                    document.getElementById('TxtClientCodeMap').disabled = true;
                    document.getElementById('txtExternalPatientNumber').disabled = true;
                    document.getElementById('txtApprovalNo').disabled = true;
                    document.getElementById('txtURNo').disabled = true;
                    document.getElementById('ddlUrnType').disabled = true;
                    document.getElementById('ddlUrnoOf').disabled = true;
                    document.getElementById('txtReferringHospital').disabled = true;
                    document.getElementById('txtInternalExternalPhysician').disabled = true;
                    document.getElementById('ddlPatientStatus').disabled = true;
                }

            }

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

            if (PatientCountryID != '') {
                document.getElementById('hdnDefaultCountryID').value = PatientCountryID;
            }

            if (document.getElementById('ddCountry') != null) {
                document.getElementById('ddCountry').value = PatientCountryID;
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
                document.getElementById('hdnPatientDOB').value = Dformate[1] + '/' + Dformate[0] + '/' + Dformate[2];

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
                if (document.getElementById('hdnIsEditMode').value == 'Y') {
                    document.getElementById('txtClient').disabled = true;
                }

            }
            if (document.getElementById('txtWardNo') != null) {
                document.getElementById('txtWardNo').value = WardNo;
            }
            document.getElementById('txtURNo').value = URNO;
            document.getElementById('hdnUrnNo').value = URNO;
            document.getElementById('ddlUrnType').value = URNOFTypeID;
            document.getElementById('URNOFTypeID').value = URNOFTypeID;
            document.getElementById('ddlUrnoOf').value = URNOFID;

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
                document.getElementById('txtExternalVisitID').disabled = true;
            }

            var panelLegend = $('#PnlPatientDetail legend');
            if (panelLegend != null) {
                panelLegend.html("Patient Details ").append('<b>(Patient No: ' + PatientNumber + ')</b>');
            }
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
            if (NotifyType != undefined) {
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

        },
        error: function(result) {
            alert("Error");
        }
    });
}

function reloadPage() {
    window.location.href = "../Billing/LabQuickBilling.aspx?IsPopup=Y" //this is a possibility
    //window.location.reload(); //another possiblity
}
function reloadModifiedPage() {

    window.location.href = "../Billing/ModifiedLabQuickBilling.aspx?IsPopup=Y" //this is a possibility
}

//function redirectPage() {
//window.location.href = "../Reception/LabPatientSearch.aspx?IsPopup=Y" //this is a possibility
//window.location.reload(); //another possiblity
//}
function redirectPage() {
    window.location.href = "../Reception/VisitDetails.aspx?IsPopup=Y" //this is a possibility
    //window.location.href = "../Reception/LabPatientSearch.aspx?IsPopup=Y"
    //window.location.reload(); //another possiblity
}
function setDOBYear1(id) {


    //Added By Prasanna.S
    var dateformat;
    if (document.getElementById('hdnDateFormatConfig') != null)
        dateformat = document.getElementById('hdnDateFormatConfig').value;
    else
        dateformat = "dd/MM/yyyy";

    var ageVal = document.getElementById(id);
    var decimalAge = ageVal.value.split('.');
    ageVal = decimalAge[0];
    var dob = document.getElementById('tDOB');


    var ddlDOB = document.getElementById('ddlDOBDWMY');

    var date = dob.value;


    var ddlval = ddlDOB.value;

    var days = new Date();

    if (ageVal.value != '') {

        if (ageVal.value.length < 3 && ddlval == 'Year(s)') {

            //var gdate = days.getDate();

            //var gmonth = days.getMonth();

            var gyear = days.getFullYear();

            dobYear = gyear - ageVal.value;

            document.getElementById('tDOB').value = '01/01/' + dobYear;

        }

        else if ((ddlval != 'Year(s)') && (ddlval == 'Month(s)' || ddlval == 'Day(s)' || ddlval == 'Week(s)')) {

            if (ageVal.value <= 1) {

                document.getElementById('tDOB').value = date;

            }

            else {

                if (ddlval == 'Day(s)') {

                    document.getElementById('tDOB').value = subDate(days, ageVal.value).format(dateformat); //days.setDate(days.getDay() - ageVal.value);

                }

                if (ddlval == 'Week(s)') {

                    document.getElementById('tDOB').value = subWeek(days, ageVal.value).format(dateformat); //days.setDate(days.getDay() - ageVal.value);

                }

                if (ddlval == 'Month(s)') {

                    document.getElementById('tDOB').value = subMonth(days, ageVal.value).format(dateformat); //days.setDate(days.getDay() - ageVal.value);

                }

            }

        }

    }

}

function setDDlDOBYear(id, flag) {



    //Added By Prasanna.S



    var agedays;
    var dateformat;
    if (document.getElementById('hdnDateFormatConfig') != null)
        dateformat = document.getElementById('hdnDateFormatConfig').value;
    else
        dateformat = "dd/MM/yyyy";

    if (flag == true || document.getElementById('tDOB').value == dateformat) {
        var ageVal = document.getElementById('txtDOBNos');

        // ageVal = document.getElementById('txtDOBNos');


        var ddlDOB = document.getElementById('ddlDOBDWMY');


        var dob = document.getElementById('tDOB');


        var date = dob.value;


        var ddlval = ddlDOB.value;


        var decimalAge = ageVal.value.split('.');
        if (decimalAge.length > 1 && ddlval != 'Year(s)') {
            alert('Can not give the Decimal value');
            document.getElementById('tDOB').value = '';
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('ddlDOBDWMY').value = 'Year(s)';
            return false;
        }
        var days = new Date();

        if (ageVal.value != '') {
            if (ageVal.value >= 106 && ddlval == 'Year(s)') {
                alert('Age Should not be Greater than 105');
                return false;
            }
            if (ageVal.value.length <= 3 && ddlval == 'Year(s)') {

                //var gdate = days.getDate();

                //var gmonth = days.getMonth();

                var gyear = days.getFullYear();

                dobYear = gyear - ageVal.value;

                //document.getElementById('tDOB').value = '01/01/' + dobYear;
                document.getElementById('tDOB').value = subyear(days, ageVal.value).format(dateformat); //days.setDate(days.getDay() - ageVal.value);

            }

            else if ((ddlval != 'Year(s)') && (ddlval == 'Month(s)' || ddlval == 'Day(s)' || ddlval == 'Week(s)')) {

                if (ageVal.value <= 1 && (ddlval == 'Year(s)')) {

                    document.getElementById('tDOB').value = date;
                    agedays = (ageVal.value * 365).toFixed(0);
                    document.getElementById('hdnCalculateDays').value = agedays;
                }

                else {

                    if (ddlval == 'Day(s)') {
                        document.getElementById('tDOB').value = subDate(days, ageVal.value).format(dateformat); //days.setDate(days.getDay() - ageVal.value);
                        agedays = ageVal.value;
                        document.getElementById('hdnCalculateDays').value = agedays;
                    }

                    if (ddlval == 'Week(s)') {
                        document.getElementById('tDOB').value = subWeek(days, ageVal.value).format(dateformat); //days.setDate(days.getDay() - ageVal.value);
                        agedays = (ageVal.value * 7).toFixed(0);
                        document.getElementById('hdnCalculateDays').value = agedays;
                    }

                    if (ddlval == 'Month(s)') {

                        document.getElementById('tDOB').value = subMonth(days, ageVal.value).format(dateformat); //days.setDate(days.getDay() - ageVal.value);
                        agedays = (ageVal.value * 30.416666667).toFixed(0);
                        document.getElementById('hdnCalculateDays').value = agedays;
                    }

                }

            }


            document.getElementById('hdnPatientDOB').value = document.getElementById('tDOB').value;
        }
    }
}
function subyear(o, days) {
    var newDate
    if (days > o.getFullYear()) {
        newDate = new Date(days - o.getFullYear(), o.getMonth(), o.getDate());
    }
    else {
        newDate = new Date(o.getFullYear() - days, o.getMonth(), o.getDate());
    }


    return newDate;
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
    if (document.getElementById('txtName').value.trim() == "") {
        alert("Enter The Patient Name");
        document.getElementById('txtName').focus();
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
function ClearDiscountLimitValues() {
    if (document.getElementById('hdnDiscountLimitType').value != 'EMPL') {
        document.getElementById('hdnDiscountLimitAmt').value = 0;
        document.getElementById('hdnSumDiscountAmt').value = 0;
        document.getElementById('hdnAvailableDiscountAmt').value = 0;
    }
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
                        if (document.getElementById('hdnIsEditMode').value == 'Y') {
                         //document.getElementById('txtClient').disabled = true;
                        }
                        else {
                            document.getElementById('txtClient').disabled = true;
                        }

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

                    if (Dispatchedtype != undefined) {
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

                    if (DispatchedMode != undefined) {
                        var LstDispatchedMode = DispatchedMode.split(",");
                        for (var j = 0; j < LstDispatchedMode.length; j++) {
                                var DispatchedMode = LstDispatchedMode[j].split("!");
                            $('[id$="chkDespatchMode"] input[type=checkbox]').each(function(i) {
                                if (($("#" + $(this).filter().context.id).next().text()) == DispatchedMode[0])  {
                                    this.checked = true;
                                }
                            });
                                if (DispatchedMode[0] == "FAX") {
                                    $('[id$="FaxNumber"]').val(DispatchedMode[1]);
                        }
                    }
                        }
                    if (NotifyType != undefined) {
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
                        document.getElementById('txtDOBNos').disabled = true;
                        document.getElementById('ddlDOBDWMY').disabled = true;
                        document.getElementById('ddlSex').disabled = true;
                        document.getElementById('txtURNo').disabled = true;
                        document.getElementById('ddlUrnoOf').disabled = true;
                        document.getElementById('ddlUrnType').disabled = true;
                        document.getElementById('tDOB').disabled = true;

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
                }
            },
            error: function(result) {
                alert("Error");
            }
        });
    }
}
}

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
