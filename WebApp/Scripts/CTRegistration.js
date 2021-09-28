function SelectedTest(source, eventArgs) {
    var list = eventArgs.get_value().split('^');
    if (list.length > 0) {
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                //document.getElementById('lblInvType').innerHTML = list[2];
            }
        }
    }
}
function clearfn() {
    if (document.getElementById('txtTestName').value.length <= 0) {
        document.getElementById('lblInvType').innerHTML = '';
    }
}




function chkSelectAll(obj) {
    for (i = 0; i < obj.length; i++) {
        obj[i].checked = document.form1.chkAll1.checked == true ? true : false;
    }
}



function IsItemChecked(objVal) {
    var pvalList = objVal.split("@@");
   var res =document.getElementById('hdnPatineEpisodeDetails').value.split("#")
   for (k = 0; k < res.length; k++) {
       if (res[k] != "") {
            pval = res[k].split('~');
            if (pvalList[1] > pval[0] && pval[6] != "N" && pval[12] != "Completed") {
                 
                var pConform = confirm("The visit is already pending do you still wish to continue?");
                if (pConform) {
                    return true;
              }
              return false;
                
            }
            
        }
    }
    return true;
}



function OpenBillPrint(url) {
    window.open(url, "billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
}
function onchangeState() {
    $('#hdnPatientStateID').val(document.getElementById('ddState').value);
}

function alpha(e) {
    var k;
    document.all ? k = e.keyCode : k = e.which;
    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
}
function CheckBillItems() {
    if (Number(document.getElementById('hdnDiscountAmt').value) >= 0 && document.getElementById('ddDiscountPercent').value == 0) {
        alert('Select discount from drop down then enter Authorised by');
        //document.getElementById('ddDiscountPercent').focus();
        return false;
    }
    if (document.getElementById('ddDiscountPercent').value == 0) {
        document.getElementById('txtAuthorised').value = '';
        document.getElementById('txtDiscountReason').value = '';
    }
}

function SetRateCard() {

    document.getElementById("hdnRateID").value = Number(document.getElementById("hdnBaseRateID").value);
    document.getElementById("hdnClientID").value = Number(document.getElementById("hdnBaseClientID").value);
    document.getElementById("hdnMappingClientID").value = -1;
}
function CheckOrderedItems() {
    if (document.getElementById('hdfBillType1').value != '') {
        var pBill = confirm("Delete the Ordered Items then only you can Change.\n Do you want to delete the items, Press OK Else Cancel");
        if (pBill != true) {
            document.getElementById('txtTestName').focus();
            return false;
        }
        else {
            document.getElementById('txtClient').value = "";
            document.getElementById('txtClient').focus();
            document.getElementById('hdfBillType1').value = "";
            document.getElementById('hdnRateID').value = Number(document.getElementById("hdnBaseRateID").value);
            document.getElementById('hdnClientID').value = Number(document.getElementById("hdnBaseClientID").value);
            defaultbillflag = 0
            CreateBillItemsTable();
            ClearPaymentControlEvents1();
        }
    }
    else {
        return true;
    }
}
function ShowTRFUpload(obj, id) {
    if (obj.checked) {
        document.getElementById('TRFimage').style.display = 'block';
    }
    else {
        document.getElementById('TRFimage').style.display = 'none';
    }
}

function CheckMRD() {

    //    var obj = document.getElementById('ddlUrnType');

    //    if (obj.options[obj.selectedIndex].value == 6) {
    //        document.getElementById('txtURNo').disabled = true;
    //        document.getElementById('ddlUrnoOf').disabled = true;

    //    }
    //    else {
    //        document.getElementById('txtURNo').disabled = false;
    //        document.getElementById('ddlUrnoOf').disabled = false;
    //    }
    //    return false;
}

function CheckExistingURN1(ctl) {
    if (document.getElementById('hdnUrn').value == '0') {
        if (document.getElementById('txtURNo').value != '' && document.getElementById('ddlUrnType').value != '0') {
            WebService.GetURN(document.getElementById('ddlUrnType').value, document.getElementById('txtURNo').value, GetURN);
        }
    }

}
function GetURN(URnList) {
    if (URnList.length > 0) {
        alert('Already exist in this URN type');
        document.getElementById('txtURNo').value = "";
        document.getElementById('txtURNo').focus();
        return false;
    }
}

function ConverttoUpperCase(id) {
    var lowerCase = document.getElementById(id).value;
    var upperCase = lowerCase.toUpperCase();
    document.getElementById(id).value = upperCase;
}

function ReferHospitalSelected(source, eventArgs) {
    //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());

    //        //debugger;

    document.getElementById('hdfReferalHospitalID').value = eventArgs.get_value();

}
function DiscountAuthSelected(source, eventArgs) {
    //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
    document.getElementById('hdnDiscountApprovedBy').value = eventArgs.get_value();
}
function ClientSelected(source, eventArgs) {


    document.getElementById('hdnSelectedClientID').value = eventArgs.get_value().split("^")[0];


}
function SittingEpisodeSelected(source, eventArgs) {
  
    document.getElementById('hdnPatineEpisodeDetails').value = eventArgs.get_value();
    document.getElementById('hdnClientByEpisodeID').value = eventArgs.get_value().split("#")[0].split("~")[9];
    document.getElementById('hdnNoOfPatient').value = eventArgs.get_value().split("#")[0].split("~")[15];
    document.getElementById('hdnRegistredPatient').value = eventArgs.get_value().split("#")[0].split("~")[16];
    document.getElementById('hdnEpisodeClientID').value = eventArgs.get_value().split("#")[0].split("~")[17];
    BindEpisodeDetails();
}
function SetSiteContextKey() {
    var OrgID = document.getElementById('hdnOrgID').value;
    var ClinetID = document.getElementById('hdnEpisodeClientID').value;
    var sval = OrgID + '~' + ClinetID;  
    $find('AutoCompleteSite').set_contextKey(sval);
}
function SetConsignContextKey() {
    var OrgID = document.getElementById('hdnOrgID').value;
    var sid = document.getElementById('hdnClientBySiteID').value;
    var eps = document.getElementById('hdnClientByEpisodeID').value;
    var ClinetID = document.getElementById('hdnSelectedClientID').value;
    var sval = eps + '~' + sid + '~' + OrgID + '~' + ClinetID;
    $find('AutoConsignment').set_contextKey(sval);
}

function SittingSiteSelected(source, eventArgs) {

    document.getElementById('hdnPatineEpisodeDetails').value = eventArgs.get_value();
    document.getElementById('hdnClientBySiteID').value = eventArgs.get_value().split("#")[0].split("~")[17];
    BindEpisodeDetails();
}

function ConsignmentSelected(source, eventArgs) {
       
    //document.getElementById('hdnVisitTrackID').value = eventArgs.get_value();
    document.getElementById('hdnPatineEpisodeDetails').value = eventArgs.get_value().split("^")[0];
    document.getElementById('txtClient').value = eventArgs.get_value().split("^")[1];
    document.getElementById('txtSiteNo').value = eventArgs.get_value().split("#")[0].split("~")[1];
    document.getElementById('txtSittingEpisode').value = eventArgs.get_value().split("#")[0].split("~")[3];
    document.getElementById('hdnClientByEpisodeID').value = eventArgs.get_value().split("#")[0].split("~")[9];
    
    BindEpisodeDetails();
}

function getSittingEpisoe() {
    var OrgID = document.getElementById('hdnOrgID').value;
    var ClinetID = document.getElementById('hdnSelectedClientID').value;
    var sval = OrgID + '~' + ClinetID;  //'STUDY';
    $find('AutoCompleteSittingEpisode').set_contextKey(sval);
}
function LoadEpisodeByClientID() {
    
    document.getElementById('hdnClientByEpisodeID').value = '';
    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetClientEpisode",
        data: "{ 'OrgID': '" + parseInt(document.getElementById('hdnOrgID').value) + "','ClientID': '" + parseInt(document.getElementById('hdnSelectedClientID').value) + "','Type': 'CT'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function(data) {
            var Items = data.d;
            $.each(Items, function(index, Item) {
                document.getElementById('hdnClientByEpisodeID').value += Item.EpisodeID + '$' + Item.EpisodeName + '$' + Item.EpisodeNumber + '$' + Item.StudyTypeID
                                + '$' + Item.hdnClientByEpisodeID + '$' + Item.ISAdhoc + '$' + Item.Description + '^';

            });
            alert(document.getElementById('hdnClientByEpisodeID').value);
        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }

    });
}

function setRate(id) {
    if (id > 0) {
        document.getElementById("hdnSelectedClientRateID").value = id;
    }
}
function countQuickAge(id) {
    //alert(document.getElementById(id).value);
    if (document.getElementById(id).value != '') {
        bD = document.getElementById(id).value.split('/');
        var agetemp = 0;
        dd = bD[0];
        mm = bD[1];
        yy = bD[2];
        main = "valid";
        if ((dd == "__") || (mm == "__") || (yy == "____")) {
            //document.getElementById('txtAge').value = '';
            return false;
        }
        if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1) || (mm == "") || (dd == "") || (yy == ""))
            main = "Invalid";
        else
            if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
            main = "Invalid";
        else
            if (mm == 2) {
            if (dd > 29)
                main = "Invalid";
            else if ((dd > 28) && (!lyear(yy)))
                main = "Invalid";
        }
        else
            if ((yy > 9999) || (yy < 0))
            main = "Invalid";
        else
            main = main;
        if (main == "valid") {
            function leapyear(a) {
                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
                    return true;
                else
                    return false;
            }
            var days = new Date();

            var gdate = days.getDate();
            var gmonth = days.getMonth();
            var gyear = days.getFullYear();
            age = gyear - yy;
            if ((mm == (gmonth + 1)) && (dd <= parseInt(gdate))) {
                age = age;
            }
            else {
                if (mm <= (gmonth)) {
                    age = age;
                }
                else {
                    age = age - 1;
                }
            }
            if (age == 0)
                age = age;
            agetemp = age;
            if (mm <= (gmonth + 1))
                age = age - 1;
            if ((mm == (gmonth + 1)) && (dd > parseInt(gdate)))
                age = age + 1;
            var m;
            var n;
            if (mm == 12) { n = 31 - dd; }
            if (mm == 11) { n = 61 - dd; }
            if (mm == 10) { n = 92 - dd; }
            if (mm == 9) { n = 122 - dd; }
            if (mm == 8) { n = 153 - dd; }
            if (mm == 7) { n = 184 - dd; }
            if (mm == 6) { n = 214 - dd; }
            if (mm == 5) { n = 245 - dd; }
            if (mm == 4) { n = 275 - dd; }
            if (mm == 3) { n = 306 - dd; }
            if (mm == 2) { n = 334 - dd; if (leapyear(yy)) n = n + 1; }
            if (mm == 1) { n = 365 - dd; if (leapyear(yy)) n = n + 1; }
            if (gmonth == 1) m = 31;
            if (gmonth == 2) { m = 59; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 3) { m = 90; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 4) { m = 120; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 5) { m = 151; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 6) { m = 181; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 7) { m = 212; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 8) { m = 243; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 9) { m = 273; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 10) { m = 304; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 11) { m = 334; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 12) { m = 365; if (leapyear(gyear)) m = m + 1; }
            totdays = (parseInt(age) * 365);
            totdays += age / 4;
            totdays = parseInt(totdays) + gdate + m + n;
            months = age * 12;
            var t = parseInt(mm);
            months += 12 - mm;
            months += gmonth + 1;
            if (gmonth == 1) p = 31 + gdate;
            if (gmonth == 2) { p = 59 + gdate; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 3) { p = 90 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 4) { p = 120 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 5) { p = 151 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 6) { p = 181 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 7) { p = 212 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 8) { p = 243 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 9) { p = 273 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 10) { p = 304 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 11) { p = 334 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 12) { p = 365 + gdate; if (leapyear(gyear)) p = p + 1; }
            weeks = totdays / 7;
            weeks += " weeks";
            weeks = parseInt(weeks);
            if (agetemp <= 0) {
                if (months <= 0) {
                    if (weeks <= 0) {
                        if (totdays >= 0) {
                            if (totdays == 1) {
                                document.getElementById('txtDOBNos').value = totdays;
                                document.getElementById('ddlDOBDWMY').value = 'Day(s)';
                            }
                            else {
                                document.getElementById('txtDOBNos').value = totdays;
                                document.getElementById('ddlDOBDWMY').value = 'Day(s)';
                            }
                        }
                    }
                    else {
                        if (weeks == 1) {
                            document.getElementById('txtDOBNos').value = weeks;
                            document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                        }
                        else {
                            document.getElementById('txtDOBNos').value = weeks;
                            document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                        }
                    }
                }
                else {
                    if (months == 1) {
                        document.getElementById('txtDOBNos').value = months;
                        document.getElementById('ddlDOBDWMY').value = 'Month(s)';
                    }
                    else {
                        document.getElementById('txtDOBNos').value = months;
                        document.getElementById('ddlDOBDWMY').value = 'Month(s)';
                    }
                }
            }
            else {
                if (agetemp == 1) {
                    document.getElementById('txtDOBNos').value = agetemp;
                    document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                }
                else {
                    document.getElementById('txtDOBNos').value = agetemp;
                    document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                }
            }

            function lyear(a) {
                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
                else return false;
            }
            //document.getElementById('ddlSex').focus();
        }
        else {
            alert(main + ' Date');
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('tDOB').value = '';
            document.getElementById('tDOB').value = '__/__/____';
            document.getElementById('tDOB').focus();
        }
    }
}

function getDOB() {
    if (document.getElementById('txtDOBNos').value == '') {
        alert('Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
        document.getElementById('txtDOBNos').focus();
        return false;
    }
    return true;
}


function CallBillItems(OrgID) {
    if (!validateEvents('Before')) {
        SetRateCard();
        var radio = "ALL";
        var pvalue = document.getElementById('hdnOPIP').value;
        var sRateID = document.getElementById('hdnRateID').value;
        var LocationID = document.getElementById('hndLocationID').value;
        var pVisitID = -1;
        var IsMapped = "N";
        if (Number(document.getElementById('hdnRateID').value) > 0) {
            IsMapped = "Y"
        }
        var BasePage = "LAB";
        var sval = "COM";
        sval = sval + '~' + OrgID + '~' + sRateID + '~' + pvalue + '~' + pVisitID + '~' + IsMapped + "~" + BasePage;
        $find('AutoCompleteExtender3').set_contextKey(sval);
    }

}
function resetpreviousradiodetails() {
    document.getElementById('txtTestName').value = "";
}
function boxExpand(me) {
    // alert(me);
    boxValue = me.value.length;
    // alert(boxValue);
    boxSize = me.size;
    minNum = 30;
    maxNum = 500;


    if (boxValue > minNum) {
        me.size = boxValue
    }
    else
        if (boxValue < minNum || boxValue != minNnum) {
        me.size = minNum
    }
}
function IAmSelected(source, eventArgs) {

    var varGetVal = eventArgs.get_value();
    var arrGetVal = new Array();
    arrGetVal = varGetVal.split("^");
    document.getElementById('txtTestName').value = arrGetVal[1];

    //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
    var ID;
    var name;
    var feeType;
    var amount;
    var isReimursable;
    var Remarks;
    var ReportDate;
    //            eventArgs.get_value()[0].PatientID;
    var list = eventArgs.get_value().split('^');
    if (list.length > 0) {
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                ID = list[0];
                name = list[1];
                feeType = list[2];
                amount = list[3];
                Remarks = list[5];
                isReimursable = list[6];
                ReportDate = list[7];

                document.getElementById('hdnID').value = ID;
                document.getElementById('hdnName').value = name;
                document.getElementById('hdnFeeTypeSelected').value = feeType;
                document.getElementById('hdnAmt').value = amount;
                document.getElementById('hdnRemarks').value = Remarks;
                document.getElementById('hdnIsRemimbursable').value = isReimursable;
                document.getElementById('hdnReportDate').value = ReportDate;


            }
        }


    }
    else {
        document.getElementById('hdnFeeID').value = -1;
        document.getElementById('hdnFeeTypeSelected').value = "OTH";
    }
    pageLoad();

    $find('AutoCompleteExtender3')._onMethodComplete = function(result, context) {

        $find('AutoCompleteExtender3')._update(context, result, /* cacheResults */false);

        webservice_callback(result, context);



    };
}

function InvPopulated(sender, e) {

    var behavior = $find('AutoCompleteExtender3');

    var target = behavior.get_completionList();

    var i;
    for (i = 0; i < target.childNodes.length; i++) {

        var arrOutSourceInvestigaions = new Array();
        arrOutSourceInvestigaions = document.getElementById('hdnOutSourceInvestigations').value.split('~');

        for (var j = 0; j < arrOutSourceInvestigaions.length; j++) {
            var strInv = arrOutSourceInvestigaions[j];
            if (strInv == target.childNodes[i].innerHTML) {
                target.childNodes[i].innerHTML = "<div style='background-color:Orange; color:Black;'>" + target.childNodes[i].innerHTML + "</div>";
            }
        }
    }
}
function expandTextBox(id) {
    // //debugger;
    document.getElementById(id).rows = "8";
    document.getElementById(id).cols = "20";
    ConverttoUpperCase(id);
}
function collapseTextBox(id) {

    document.getElementById(id).rows = "1";
    document.getElementById(id).cols = "20";
    ConverttoUpperCase(id);

}
function setDiscount() {

}
function AddItems() {


    if (document.getElementById('txtTestName').value == "") {
        alert('Search test names')
        document.getElementById('txtTestName').focus();
        return false;
    }

    else {
        var FeeID = document.getElementById('hdnID').value;
        var Descrip = document.getElementById('hdnName').value;
        var FeeType = document.getElementById('hdnFeeTypeSelected').value;
        var Amount = document.getElementById('hdnAmt').value;
        var Remarks = document.getElementById('hdnRemarks').value;
        var IsRI = document.getElementById('hdnIsRemimbursable').value;
        var ReportDate = document.getElementById('hdnReportDate').value;

        if (Descrip != '') {
            if (Number(Amount) <= 0) {
                var pBill = confirm("Item amount is zero.\n Do you want to add this item");
                if (pBill) {
                    CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate);
                    document.getElementById('lblInvType').innerHTML = '';
                }
            }
            else {
                CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate);
                document.getElementById('lblInvType').innerHTML = '';
            }
        }

    }

}
var defaultbillflag = 0;
function CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate) {
    if (document.getElementById('txtClient').value.trim() == '' && document.getElementById('hdnDefaultOrgBillingItems').value.trim() != '' && defaultbillflag == 0) {
        defaultbillflag = 1;
        var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
        FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
                + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "|";
        document.getElementById('hdfBillType1').value = FeeViewStateValue;

    }

    var FeeViewStateValue = document.getElementById('hdfBillType1').value;

    var FeeGotValue = new Array();
    FeeGotValue = FeeViewStateValue.split('|');
    var feeIDALready = new Array();
    var tempFeeID, tempFeeType, tempOtherID, tempDateTime, tempDescrip, tempPerphyname, tempPerphyID, Quantity = 1;


    var PaymentAAlreadyPresent = new Array();
    var iPaymentAlreadyPresent = 0;
    var iPaymentCount = 0;
    var arrayMainData = new Array();
    var arrayChildData = new Array();

    for (iMain = 0; iMain < FeeGotValue.length - 1; iMain++) {

        arraySubData = FeeGotValue[iMain].split('~');
        for (iChild = 0; iChild < arraySubData.length; iChild++) {
            arrayChildData = arraySubData[iChild].split('^');
            if (arrayChildData.length > 0) {

                if (arrayChildData[0] == "FeeID") {
                    tempFeeID = arrayChildData[1];
                }
                if (arrayChildData[0] == "FeeType") {
                    tempFeeType = arrayChildData[1];
                }
                if (arrayChildData[0] == "Descrip") {
                    tempDescrip = arrayChildData[1];
                }
                if (FeeID == tempFeeID && FeeType == tempFeeType && Descrip == tempDescrip) {
                    iPaymentAlreadyPresent = 1;
                }
            }
        }

    }


    if (iPaymentAlreadyPresent == 0) {
        FeeViewStateValue = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^"
                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsRI + "|" + FeeViewStateValue;

        document.getElementById('hdfBillType1').value = FeeViewStateValue;
        CreateBillItemsTable();



    }
    else {
        alert("Item already added");
        ClearSelectedData();
    }

}
function CreateBillItemsTable() {

    document.getElementById('divItemTable').innerHTML = "";
    var newPaymentTables, startPaymentTag, endPaymentTag;
    var FeeViewStateValue = document.getElementById('hdfBillType1').value;
    startPaymentTag = "<TABLE nowrap='nowrap' ID='tabDrg1' Cellpadding='0' Cellspacing='0' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> FeeID </th><th scope='col'  style='width:5%;display:none;'> FeeType </th> <th scope='col' style='width:4%;'> S.No </th> <th scope='col' align='left' style='width:75%;padding-left:2px;'> Description </th>  <th scope='col' align='right' style='display:none;width:5%;'>  Quantity </th><th scope='col' align='right' style='width:8%;'> Amount </th> <th scope='col' style='width:20%;padding-left:2px;display:none;'>Remarks </th> <th scope='col' style='width:10%;display:none;'> Report Date </th> <th scope='col' style='display:none;'> IsReimbursable </th> <th scope='col' align='center'>Delete</th></tr>";
    endPaymentTag = "</TBODY></TABLE>";
    newPaymentTables = startPaymentTag;

    var arrayMainData = new Array();
    var arraySubData = new Array();
    var arrayChildData = new Array();
    var iMain = 0;
    var iChild = 0;
    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable;
    var GrossAmt = 0;
    var sno = 1;
    arrayMainData = FeeViewStateValue.split('|');
    if (arrayMainData.length > 0) {
        for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {

            arraySubData = arrayMainData[iMain].split('~');
            for (iChild = 0; iChild < arraySubData.length; iChild++) {
                arrayChildData = arraySubData[iChild].split('^');
                if (arrayChildData.length > 0) {
                    if (arrayChildData[0] == "FeeID") {
                        FeeID = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "FeeType") {
                        FeeType = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Descrip") {
                        Descrip = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Quantity") {
                        Quantity = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Amount") {
                        Amount = arrayChildData[1];
                        GrossAmt = Number(GrossAmt) + Number(Amount);
                    }
                    if (arrayChildData[0] == "Remarks") {
                        Remarks = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "ReportDate") {
                        ReportDate = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsReimbursable") {
                        IsReimbursable = arrayChildData[1];
                    }
                }

            }
            document.getElementById('divItemTable').style.height = "auto";
            if (iMain >= 4) {
                document.getElementById('divItemTable').style.height = "100px";
            }


            newPaymentTables += "<TR><TD style='display:none;'>" + FeeID + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + FeeType + "</TD>";
            newPaymentTables += "<TD>" + sno + "</TD>";
            newPaymentTables += "<TD style='padding-left:5px' align='left'>" + Descrip + "</TD>"
            newPaymentTables += "<TD  style='display:none;' align='right'>" + Quantity + "</TD>";
            newPaymentTables += "<TD  align='right'>" + Amount + "</TD>";
            newPaymentTables += "<TD  style='display:none;>" + Remarks + "</TD>";
            newPaymentTables += "<TD  style='display:none;>" + ReportDate + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsReimbursable + "</TD>";
            newPaymentTables += "<TD align='center'><input name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "' onclick='btnDeleteBillingItems_OnClick1(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";
            sno++;

        }
    }

    newPaymentTables += endPaymentTag;
    document.getElementById('divItemTable').innerHTML += newPaymentTables;

    ClearSelectedData();
    SetGrossValue(GrossAmt)
    SetOtherCurrValues();
}

function SetGrossValue(Amount) {
    document.getElementById('txtGross').value = parseFloat(Number(Amount)).toFixed(2);
    document.getElementById('hdnGrossValue').value = document.getElementById('txtGross').value;
    SetNetValue();
}
function SetNetValue() {

    var roundOffAmt = 0;
    if (Number(document.getElementById('txtGross').value) > 0) {
        if (document.getElementById('txtClient').value.trim() != '') {
            document.getElementById('ddDiscountPercent').disabled = true;
        }
        else {
            document.getElementById('ddDiscountPercent').disabled = false;
        }
        if ((document.getElementById('ddDiscountPercent').value) != '0' && (document.getElementById('ddDiscountPercent').value) != '') {
            if (Number(document.getElementById('hdnAmountReceived').value) <= 0) {
                if (Number(document.getElementById('hdnGrossValue').value) > 0) {
                    if ((document.getElementById('ddDiscountPercent').value) == '0.00') {
                        document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);

                    }
                    else {
                        document.getElementById('txtDiscount').value = parseFloat((parseFloat(document.getElementById('txtGross').value) / 100) * (document.getElementById('ddDiscountPercent').value)).toFixed(2);
                        document.getElementById('hdnDiscountAmt').value = document.getElementById('txtDiscount').value;
                    }
                    document.getElementById('txtDiscount').readOnly = true;
                }
            }
            else {
                alert('Amount already received, delete the amount received and include discount');
                document.getElementById('ddDiscountPercent').value = '0';
                document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
                document.getElementById('txtAuthorised').value = "";
                document.getElementById('txtDiscountReason').value = "";
                document.getElementById('hdnDiscountAmt').value = parseFloat(0).toFixed(2);
                SetNetValue();
                return false;
            }

        }

        else {
            document.getElementById('txtAuthorised').value = "";
            document.getElementById('txtDiscountReason').value = "";
            document.getElementById('txtDiscount').readOnly = false;
            document.getElementById('txtDiscountReason').readOnly = false;
            document.getElementById('hdnDiscountAmt').value = 0;
            document.getElementById('txtDiscount').value = (0).toFixed(2)
        }
        var gross = document.getElementById('hdnGrossValue').value;
        var discount = document.getElementById('hdnDiscountAmt').value;
        var TaxAMount = Number(document.getElementById('txtTax').value, 2);

        var netvalue = Math.round(Number(gross) + Number(TaxAMount) - Number(discount));
        if ((Number(gross) + Number(TaxAMount) - Number(discount)) - Number(netvalue) < 0) {
            roundOffAmt = Number(netvalue) - (Number(gross) + Number(TaxAMount) - Number(discount));
        }
        else {
            roundOffAmt = (Number(gross) + Number(TaxAMount) - Number(discount)) - Number(netvalue);
        }
        document.getElementById('txtRoundoffAmt').value = parseFloat(roundOffAmt).toFixed(2);
        document.getElementById('hdnRoundOff').value = parseFloat(roundOffAmt).toFixed(2);

        document.getElementById('txtNetAmount').value = parseFloat(netvalue).toFixed(2);
        document.getElementById('hdnNetAmount').value = parseFloat(netvalue).toFixed(2);
        if (document.getElementById('txtClient').value.trim() == '') {
            document.getElementById('PaymentType_txtAmount').value = parseFloat(netvalue).toFixed(2);
            document.getElementById('PaymentType_txtTotalAmount').innerHTML = parseFloat(netvalue).toFixed(2);
        }
    }
    else {
        document.getElementById('txtGross').value = (0).toFixed(2);
        document.getElementById('hdnGrossValue').value = (0).toFixed(2);
        document.getElementById('hdnDiscountAmt').value = (0).toFixed(2);
        document.getElementById('txtDiscount').value = (0).toFixed(2);
        document.getElementById('hdnTaxAmount').value = (0).toFixed(2);
        document.getElementById('hdfTax').value = (0).toFixed(2);
        document.getElementById('txtTax').value = (0).toFixed(2);
        document.getElementById('txtServiceCharge').value = (0).toFixed(2);
        document.getElementById('hdnServiceCharge').value = (0).toFixed(2);
        document.getElementById('txtRoundoffAmt').value = (0).toFixed(2);
        document.getElementById('hdnRoundOff').value = (0).toFixed(2);
        document.getElementById('txtNetAmount').value = (0).toFixed(2);
        document.getElementById('hdnNetAmount').value = (0).toFixed(2);

        document.getElementById('txtAmtReceived').value = (0).toFixed(2);
        document.getElementById('hdnAmountReceived').value = (0).toFixed(2);
        document.getElementById('ddDiscountPercent').value = 0;
        document.getElementById('ddDiscountPercent').disabled = true;
        return false;
    }
    SetOtherCurrValues();

}
function getOtherCurrAmtValues(pType, ConValue) {
    if (pType == "REC") {
        var pAMt = document.getElementById(ConValue + "_hdnOterCurrReceived").value == "" ? "0" : document.getElementById(ConValue + "_hdnOterCurrReceived").value;
        return parseFloat(pAMt).toFixed(2);
    }
    if (pType == "PAY") {
        var pAMt = document.getElementById(ConValue + "_hdnOterCurrPayble").value == "" ? "0" : document.getElementById(ConValue + "_hdnOterCurrPayble").value;
        return parseFloat(pAMt).toFixed(2);
    }
    if (pType == "SER") {
        var pAMt = document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value == "" ? "0" : document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value;
        return parseFloat(pAMt).toFixed(2);
    }
}
function SetOtherCurrReceived(pCurrAmount, pNetAmount, pServiceCharge, ConValue) {
    var pTotalNetAmt = Number(pNetAmount);
    document.getElementById(ConValue + "_lblOtherCurrRecdAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById(ConValue + "_hdnOterCurrReceived").value = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value = parseFloat(pServiceCharge).toFixed(2);

}
function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

    var sVal = 0;
    var ConValue = "OtherCurrencyDisplay1";

    var sVal = getOtherCurrAmtValues("REC", ConValue);
    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
    var tempService = getOtherCurrAmtValues("SER", ConValue);
    var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
    sVal = format_number(Number(sVal) + Number(TotalAmount), 4);

    if (PaymentAmount > 0) {

        if (Number(sNetValue) >= Number(sVal)) {
            sVal = format_number(sVal, 4);
            SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 4), ConValue);
            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 4);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);

            document.getElementById('txtServiceCharge').value = Number(format_number(pScrAmt, 2)).toFixed(2);
            document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2)
            document.getElementById('txtAmtReceived').value = Number(format_number(Number(pAmt), 2)).toFixed(2);
            document.getElementById('hdnAmountReceived').value = format_number(Number(pAmt), 2);

            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);
            document.getElementById('hdnPaymentControlReceivedtemp').value = format_number(Number(pAmt), 2);

            return true;

        }
        else {
            alert('Amount received is greater than net amount')
            return false;
        }
    }

}
function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
    GetCurrencyValues();
    var ConValue = "OtherCurrencyDisplay1";
    var sVal = getOtherCurrAmtValues("REC", ConValue);
    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
    var tempService = getOtherCurrAmtValues("SER", ConValue);
    var CurrRate = GetOtherCurrency("OtherCurrRate");
    sVal = Number(Number(sVal) - Number(TotalAmount));
    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
    var pScrAmt = Number(pScr) * Number(CurrRate);
    var pAmt = Number(sVal) * Number(CurrRate);

    document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2);
    document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);

    var amtRec = 0;
    document.getElementById('hdnAmountReceived').value = format_number(Number(sVal) + Number(amtRec), 2);
    document.getElementById('txtAmtReceived').value = format_number(Number(sVal) + Number(amtRec), 2);
    SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);
    SetNetValue();



}
function ClearPaymentControlEvents1() {
    document.getElementById('PaymentType_hdfPaymentType').value = "";
    PaymentControlclear1();
    CreatePaymentTables();
    document.getElementById('OtherCurrencyDisplay1_hdnOterCurrPayble').value = "0";
    document.getElementById('OtherCurrencyDisplay1_hdnOterCurrReceived').value = "0";
    document.getElementById('OtherCurrencyDisplay1_hdnOterCurrServiceCharge').value = "0";

}
function PaymentControlclear1() {
    document.getElementById('PaymentType_txtAmount').value = document.getElementById('PaymentType_hdfDefaultPaymentMode').value;
    document.getElementById('PaymentType_txtAmount').value = "";
    document.getElementById('PaymentType_txtNumber').value = "";
    document.getElementById('PaymentType_txtBankType').value = "";
    document.getElementById('PaymentType_txtRemarks').value = "";
    document.getElementById('PaymentType_txtServiceCharge').value = "0";
    document.getElementById('PaymentType_txtTotalAmount').innerHTML = "";
    document.getElementById('txtAmtReceived').value = "0.00";

}

function ClearSelectedData() {
    document.getElementById('txtTestName').value = "";
    document.getElementById('hdnID').value = 0;
    document.getElementById('hdnName').value = '';
    document.getElementById('hdnFeeTypeSelected').value = 'COM';
    document.getElementById('hdnAmt').value = 0;
    document.getElementById('hdnRemarks').value = '';
    document.getElementById('hdnIsRemimbursable').value = '';
    document.getElementById('hdnReportDate').value = '';
   // document.getElementById('txtTestName').focus();
    if (document.getElementById('hdfBillType1').value == '')
        document.getElementById('spanAddItems').style.display = "block";
    if (document.getElementById('hdfBillType1').value != '')
        document.getElementById('spanAddItems').style.display = "none";

}
function btnDeleteBillingItems_OnClick1(sEditedData) {
    ClearPaymentControlEvents1();
    var PaymentAAlreadyPresent = new Array();
    var iPaymentAlreadyPresent = 0;
    var iPaymentCount = 0;

    var PaymenttempDatas = document.getElementById('hdfBillType1').value;

    PaymentAAlreadyPresent = PaymenttempDatas.split('|');
    if (PaymentAAlreadyPresent.length > 0) {
        for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
            if (PaymentAAlreadyPresent[iPaymentCount].toLowerCase() == sEditedData.toLowerCase()) {

                var tempFeeID, tempFeeType, tempOtherID, iChild, tempFeeDate, tempNRI;
                var arrayChildData = new Array();

                arraySubData = PaymentAAlreadyPresent[iPaymentCount].split('~');
                for (iChild = 0; iChild < arraySubData.length; iChild++) {
                    arrayChildData = arraySubData[iChild].split('^');
                    if (arrayChildData.length > 0) {

                        if (arrayChildData[0] == "FeeID") {
                            tempFeeID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "FeeType") {
                            tempFeeType = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "DTime") {
                            tempFeeDate = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "IsReimbursable") {
                            tempNRI = arrayChildData[1];
                        }
                    }
                }

                
                PaymentAAlreadyPresent[iPaymentCount] = "";
            }
        }
    }
    PaymenttempDatas = "";
    for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
        if (PaymentAAlreadyPresent[iPaymentCount] != "") {
            PaymenttempDatas += PaymentAAlreadyPresent[iPaymentCount] + "|";
        }
    }

    var FeeGotValue = new Array();
    var arrayAmount = new Array();

    FeeGotValue = sEditedData.split('~');
    var FeeID;

    if (FeeGotValue.length > 0) {
        FeeID = FeeGotValue[2];

        arrayAmount = FeeID.split('^');
    }

    document.getElementById('hdfBillType1').value = PaymenttempDatas;
    CreateBillItemsTable();
    DeleteAmountValue(0, 0, 0);
    SetOtherCurrValues();
    ClearPaymentControlEvents();
}



function clearPageControlsValue(ClearType) {
    if (ClearType == "N") {
        document.getElementById('txtName').value = "";
        document.getElementById('txtName').focus();
    }
    document.getElementById('txtSujectNo').value = "";
    
    document.getElementById('txtDOBNos').value = "";
    document.getElementById('tDOB').value = "";
    document.getElementById('ddlDOBDWMY').value = "Year(s)";

    document.getElementById('txtTestName').value = "";
    document.getElementById('divItemTable').innerHTML = "";
    document.getElementById('txtAuthorised').value = "";
    document.getElementById('txtPatientHistory').value = "";
    document.getElementById('txtGross').value = "0.00";
    document.getElementById('hdnGrossValue').value = "0.00";
    document.getElementById('txtDiscount').value = "0.00";
    document.getElementById('txtDiscountReason').value = "";
    document.getElementById('hdnDiscountAmt').value = "0.00";
    document.getElementById('txtTax').value = "0.00";
    document.getElementById('hdnTaxAmount').value = "0.00";
    document.getElementById('hdfTax').value = "0.00";
    document.getElementById('txtServiceCharge').value = "0.00";
    document.getElementById('hdnServiceCharge').value = "0.00";
    document.getElementById('txtRoundoffAmt').value = "0.00";
    document.getElementById('hdnRoundOff').value = "0.00";
    document.getElementById('txtNetAmount').value = "0.00";
    document.getElementById('hdnNetAmount').value = "0.00";
    document.getElementById('txtAmtReceived').value = "0.00";
    document.getElementById('hdnAmountReceived').value = "0.00";
    document.getElementById('txtDue').value = "0.00";
    document.getElementById('hdnDue').value = "0.00";
    document.getElementById('hdnRateID').value = Number(document.getElementById("hdnBaseRateID").value);
    //document.getElementById('hdnOutSourceInvestigations').value = "";
    document.getElementById('hdnOPIP').value = "OP";
    document.getElementById('hdfBillType1').value = "";
    document.getElementById('hdnFeeTypeSelected').value = "COM";
    document.getElementById('hdnName').value = "";
    document.getElementById('hdnAmt').value = "0.00";
    document.getElementById('hdnID').value = "";
    document.getElementById('hdnReportDate').value = "";
    document.getElementById('hdnRemarks').value = "";
    document.getElementById('hdnIsRemimbursable').value = "";
    document.getElementById('hdnPaymentControlReceivedtemp').value = "";
    document.getElementById('hdnPatientID').value = "-1";
    document.getElementById('hdnVisitPurposeID').value = "-1";
    document.getElementById('hdnClientID').value = "-1";
    document.getElementById('hdnTPAID').value = "-1";
    document.getElementById('hdnClientType').value = "CRP";
    document.getElementById('hdnReferedPhyID').value = "-1";
    document.getElementById('lblPatientDetails').innerHTML = "";
    document.getElementById('trPatientDetails').style.display = "none";
    document.getElementById('hdnReferedPhyType').value = "-1";
    document.getElementById('hdnPreviousVisitDetails').value = '';
    document.getElementById('lblPreviousItems').innerHTML = '';
    document.getElementById('ShowBillingItems').style.display = "none";
    document.getElementById('hdnPatientAlreadyExists').value = 0;
    document.getElementById('hdnPatientAlreadyExistsWebCall').value = 0;
    document.getElementById('ddDiscountPercent').value = 0;
    document.getElementById('hdnBillGenerate').value = "N";
    document.getElementById('hdnLstPatientInvSample').value = "";
    document.getElementById('hdnLstSampleTracker').value = "";
    document.getElementById('hdnLstPatientInvSampleMapping').value = "";
    document.getElementById('hdnLstInvestigationValues').value = "";
    document.getElementById('hdnLstCollectedSampleStatus').value = "";
    document.getElementById('hdnVisitID').value = "-1";
    document.getElementById('hdnGuID').value = "";
    document.getElementById('hdnFinalBillID').value = "-1";
    
    ClearPaymentControlEvents1();
    GetCurrencyValues();
    defaultbillflag = 0
}
function ClearControlValues() {
    document.getElementById('PaymentType_hdfPaymentType').value = "";
    document.getElementById('PaymentType_hdnPaymentsDeleted').value = "";
    document.getElementById('PaymentType_hdnOtherCurrencyID').value = "0";
    document.getElementById('PaymentType_hdnOtherCurrency').value = "0";
    document.getElementById('PaymentType_hdnPayVariableAmount').value = "0";
    document.getElementById('PaymentType_hdnRecdAmount').value = "0";
    document.getElementById('PaymentType_hdnlastreceivedamt').value = "0";
    document.getElementById('OtherCurrencyDisplay1_hdnOterCurrPayble').value = "0";
    document.getElementById('OtherCurrencyDisplay1_hdnOterCurrReceived').value = "0";
    document.getElementById('OtherCurrencyDisplay1_hdnOterCurrServiceCharge').value = "0";
    

}

function validateEvents(obj) {
    if (document.getElementById('txtClient').value == '') {
        alert('Provide client name');
        document.getElementById('txtClient').focus();
        return false;
    }
    if (document.getElementById('txtSittingEpisode').value == '') {
        alert('Provide Study Protocol');
        document.getElementById('txtSittingEpisode').focus();
        return false;
    }
//    if (document.getElementById('txtName').value == '') {
//        alert('Provide patient name');
//        document.getElementById('txtName').focus();
//        return false;
//    }
    if (document.getElementById('tDOB').value == '') {
        alert('Provide patient date of birth');
        document.getElementById('tDOB').focus();
        return false;
    }
    if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
        alert('Select patient sex');
        document.getElementById('ddlSex').focus();
        return false;
    }
    if (document.getElementById('txtSujectNo').value == '') {
        alert('Provide Client Subject No.');
        document.getElementById('txtSujectNo').focus();
        return false;
    }
    if (document.getElementById('txtName').value == '') {
        alert('Provide Client Subject Name');
        document.getElementById('txtName').focus();
        return false;
    }
    if (document.getElementById('txtSampleDate').value == '') {
        alert('Provide Sample Pickup Date');
        document.getElementById('txtSampleDate').focus();
        return false;
    }
    if (document.getElementById('ddlStatus').options[document.getElementById('ddlStatus').selectedIndex].value == "0") {
        alert('Select patient status in during collection');
        document.getElementById('ddlStatus').focus();
        return false;
    }

    if (document.getElementById('hdfBillType1').value == '' && obj != 'Before') {
        alert('Include billing items');
        document.getElementById('txtTestName').focus();
        return false;
    }
    if (Number(document.getElementById('hdnDiscountAmt').value) > 0) {
        if (document.getElementById('txtAuthorised').value == '') {
            alert('Provide discount authorised by');
            document.getElementById('txtAuthorised').focus();
            return false;
        }
        if (document.getElementById('txtDiscountReason').value == '') {
            alert('Provide discount reason');
            document.getElementById('txtDiscountReason').focus();
            return false;
        }
    }

    if (document.getElementById('hdfBillType1').value != '' && obj == 'After') {
        PaymentSaveValidationQuickBill();
         
        if (Number(document.getElementById('hdnNetAmount').value) > Number(document.getElementById('hdnAmountReceived').value)) {
            var pBill = true;
            if (pBill != true) {
                document.getElementById('hdnDue').value = "0.00";
                document.getElementById('btnGenerate').style.display = 'block';
                document.getElementById('btnClose').style.display = 'block';
                return false;
            }
            else {
                document.getElementById('hdnDue').value = (Number(document.getElementById('hdnNetAmount').value) - Number(document.getElementById('hdnAmountReceived').value));
                document.getElementById('btnGenerate').style.display = 'none';
            }
        }
        document.getElementById('btnGenerate').style.display = 'none';
        document.getElementById('btnClose').style.display = 'none';
    }

    document.getElementById('hdnPatientAlreadyExists').value = 0;

}
function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
    var key;
    var isCtrl = false;
    var keychar;
    var reg;

    if (window.event) {
        key = e.keyCode;
        isCtrl = window.event.ctrlKey
    }
    else if (e.which) {
        key = e.which;
        isCtrl = e.ctrlKey;
    }

    if (isNaN(key)) return true;

    keychar = String.fromCharCode(key);

    // check for backspace or delete, or if Ctrl was pressed
    if (key == 8 || isCtrl) {
        return true;
    }

    reg = /\d/;
    var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
    var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

    return isFirstN || isFirstD || reg.test(keychar);
}
function SelectedTemp(source, eventArgs) {
   
    document.getElementById('hdnSelectedPatientTempDetails').value = eventArgs.get_value();
    Tblist();

}

function Tblist() {
    document.getElementById('trPatientDetails').style.display = "block";
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    document.getElementById('lblPatientDetails').innerHTML = '';
    table = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
                           + "<th style='width:80px;'>Name</th>"
                           + "<th style='width:50px;'>Number</th>"
                           + "<th style='width:300px;'>Address</th>"
                           + "<th style='Widht:100px;'>Phone</th> </thead>";
    var x = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");

    tr = "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
                        + x[1] + "</td><td style='width:100px;'>"
                        + x[2] + "</td><td style='width:100px;'>"
                        + x[8] + ',' + x[9] + "</td><td style='width:100px;'>"
                        + x[7] + "</td></tr>";



    var tab = table + tr + end;
    document.getElementById('lblPatientDetails').innerHTML = tab;
    tbshow();


}
function SelectedTempClient(source, eventArgs) {
    document.getElementById('hdnSelectedClientTempDetails').value = eventArgs.get_value();
    TbClientlist();

}
function TbClientlist() {
    var y = '';
    var x = document.getElementById('hdnSelectedClientTempDetails').value.split("###");


}

function SelectedPatient(source, eventArgs) {

     
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
    
     
     
     
     
     
     
     
    var PatientID = isPatientDetails.split('~')[14];
    var PatientEmailID = isPatientDetails.split('~')[15];
    var VisitPurpose = 3
    var PatientPreviousDue = isPatientDetails.split('~')[19];


    document.getElementById('ddSalutation').value = PatientTITLECode
    document.getElementById('txtName').value = PatientName;
    document.getElementById('hdnPatientNumber').value = PatientNumber
    document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
    document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
    document.getElementById('ddlSex').value = PatientSex;
    document.getElementById('ddMarital').value = PatientMaritalStatus;
    document.getElementById('hdnPatientID').value = PatientID;
    var textBox = $get('tDOB');
    if (textBox.AjaxControlToolkitTextBoxWrapper) {
        textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
    }
    else {
        textBox.value = PatientDOB;
    }
    document.getElementById('lblPatientDetails').innerHTML = '';
    document.getElementById('trPatientDetails').style.display = "none";

}





//

var ns4 = document.layers
var ie4 = document.all
var ns6 = document.getElementById && !document.all


var dragswitch = 0
var nsx
var nsy
var nstemp

function drag_dropns(name) {
    if (!ns4)
        return
    temp = eval(name)
    temp.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP)
    temp.onmousedown = gons
    temp.onmousemove = dragns
    temp.onmouseup = stopns
}

function gons(e) {
    temp.captureEvents(Event.MOUSEMOVE)
    nsx = e.x
    nsy = e.y
}
function dragns(e) {
    if (dragswitch == 1) {
        temp.moveBy(e.x - nsx, e.y - nsy)
        return false
    }
}

function stopns() {
    temp.releaseEvents(Event.MOUSEMOVE)
}

//drag drop function for ie4+ and NS6////
/////////////////////////////////


function drag_drop(e) {
    if (ie4 && dragapproved) {
        crossobj.style.left = tempx + event.clientX - offsetx
        crossobj.style.top = tempy + event.clientY - offsety
        return false
    }
    else if (ns6 && dragapproved) {
        crossobj.style.left = tempx + e.clientX - offsetx + "px"
        crossobj.style.top = tempy + e.clientY - offsety + "px"
        return false
    }
}

function initializedrag(e) {
    crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage
    var firedobj = ns6 ? e.target : event.srcElement
    var topelement = ns6 ? "html" : document.compatMode != "BackCompat" ? "documentElement" : "body"
    while (firedobj.tagName != topelement.toUpperCase() && firedobj.id != "dragbar") {
        firedobj = ns6 ? firedobj.parentNode : firedobj.parentElement
    }

    if (firedobj.id == "dragbar") {
        offsetx = ie4 ? event.clientX : e.clientX
        offsety = ie4 ? event.clientY : e.clientY

        tempx = parseInt(crossobj.style.left)
        tempy = parseInt(crossobj.style.top)

        dragapproved = true
        document.onmousemove = drag_drop
    }
}

////drag drop functions end here//////

function hidebox() {
    crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage

    crossobj.style.display = "none"

}
function Itemhidebox() {
    crossobj = ns6 ? document.getElementById("ShowBillingItems") : document.all.ShowBillingItems

    crossobj.style.display = "none"

}

function tbItemshow() {
    document.onmouseup = new Function("dragapproved=false")

    document.getElementById("ShowBillingItems").style.display = "block";
}

function tbshow() {
    document.onmouseup = new Function("dragapproved=false")

    document.getElementById("showimage").style.display = "block";
}
function Make_OnClick(sEditedData) {
}

function SetOtherCurrValues() {
    var pnetAmt = document.getElementById('hdnNetAmount').value;
    var ConValue = "OtherCurrencyDisplay1";
    SetPaybleOtherCurr(pnetAmt, ConValue, true);

}
function SetOtherCurrPayble(pCurrName, pCurrAmount, pNetAmount, ConValue, IsDisplay) {

    var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(4) / parseFloat(pCurrAmount).toFixed(2)).toFixed(4);
    document.getElementById(ConValue + "_lblOtherCurrPaybleName").innerHTML = pCurrName;
    document.getElementById(ConValue + "_lblOtherCurrRecdName").innerHTML = pCurrName;
    document.getElementById(ConValue + "_lblOtherCurrPaybleAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById(ConValue + "_hdnOterCurrPayble").value = parseFloat(pTotalNetAmt).toFixed(4);

}
function isOtherCurrDisplay(pType) {
    if (pType == "B") {
        //        document.getElementById("OtherCurrencyDisplay1_tbOtherCurr").style.display = "block";
    }
}
function isOtherCurrDisplay1(pType) {
    if (pType == "B") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "block";
        document.getElementById("trOtherCurrency").style.display = "block";
    }
    if (pType == "N") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "none";
        document.getElementById("trOtherCurrency").style.display = "none";
    }


}
function setSexValueQB(sexId, msId, ddMaritalID) {

    //       alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //        alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    if (document.getElementById(msId).value == '6' || document.getElementById(msId).value == '7' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12' || document.getElementById(msId).value == '9') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '2' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }
    else {

        document.getElementById(sexId).value = '0'

    }
    if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4') {
        document.getElementById(ddMaritalID).value = 'S';
    }
    else {
        document.getElementById(ddMaritalID).value = '0';
    }
}
function setSexValueopt(sexId, msId) {
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);

    if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }

}
function pageLoad() {
    // //debugger;
    if ($find('AutoCompleteExtender3')._onMethodComplete != undefined) {
        $find('AutoCompleteExtender3')._onMethodComplete = function(result, context) {

            $find('AutoCompleteExtender3')._update(context, result, /* cacheResults */false);

            webservice_callback(result, context);
        };

    }
}
function webservice_callback(result, context) {

    if (result == "") {
        document.getElementById('alert').innerHTML = 'One or more items does not seem to be selected from the predefined list. This may not get reflected in the reports.';
    }
    else {
        document.getElementById('alert').innerHTML = "";
    }
}
function ClearDOB() {

    if (document.getElementById('txtDOBNos').value <= 0) {
        document.getElementById('txtDOBNos').value = '';
    }
    if (document.getElementById('txtDOBNos').value >= 150) {
        alert('Provide a valid year');
        document.getElementById('tDOB').value = '__/__/____';
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('txtDOBNos').focus();
        return false;
    }
}

function AddEpisodeBillingItemsToBilling(prefixText) {
    
    if (IsItemChecked(prefixText)) {
        var pretex = new Array();
        var OrgID = document.getElementById('hdnOrgID').value;
        var items = prefixText.toString().split('@@');
        CallBillItems(OrgID);
        var autoComplete = $find('AutoCompleteExtender3');
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetQuickBillItems",
            data: '{prefixText:"' + items[4] + '",count:"' + 0 + '",contextKey:"' + autoComplete._contextKey + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                $.each(Items, function(index, Item) {
                    var valu;
                    for (var k = 0; k < Items.length; k++) {
                        valu = Items[k];
                        var idvalu = valu.split('^');
                        var invid = idvalu[0].split(':');
                        var fvalu = idvalu[1];
                        fvalu = fvalu.replace('"', '');
                        fvalu = fvalu.replace('\\t', '');
                        var idval = invid[2].replace('"', '');
                        if (idval == items[3]) {
                            document.getElementById('hdnEpisodeVisitID').value = items[5];
                            var fdes = idval + '^' + idvalu[2] + '^' + fvalu + '^' + idvalu[3] + '^' + idvalu[4] + '^' + idvalu[5] + '^' + idvalu[6] + '^' + idvalu[7].replace('"}', '') + '^';

                            var defalutdata = fdes.split('^');
                            FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] +
                                                                        "~Amount^" + defalutdata[3] + "~Quantity^" + 1 + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[7] +
                                                                        "~IsReimbursable^" + defalutdata[6] + "|";
                            document.getElementById('hdfBillType1').value = (document.getElementById('hdfBillType1').value).replace(FeeViewStateValue, '');
                            document.getElementById('hdfBillType1').value += FeeViewStateValue;
                        }
                        
                    }

                });

                CreateBillItemsTable();


            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }

}

function Cleargrid() {
    document.getElementById('hdnPatineEpisodeDetails').value = '';
    BindEpisodeDetails();
}
function LoadEpisodeBillingItemsForPatient() {
  
    if (document.getElementById("txtName").value.trim() != "") {
        document.getElementById('hdnPatineEpisodeDetails').value = '';
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetPatientEpisodeVisitDetails",
            data: "{ 'PatientID': '" + parseInt(document.getElementById('hdnPatientID').value) + "','EpisodeID': '" + parseInt(document.getElementById('hdnClientByEpisodeID').value) + "','Type': 'CT'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                $.each(Items, function(index, Item) {
                    document.getElementById('hdnPatineEpisodeDetails').value += Item.Description + '#';
                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
                });

                BindEpisodeDetails();
                //alert(Items);
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }
   
}

function BindEpisodeDetails() {
    while (count = document.getElementById('tblOrederedItems').rows.length) {

        for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
            document.getElementById('tblOrederedItems').deleteRow(j);
        }
    }
    var x = document.getElementById('hdnPatineEpisodeDetails').value.split("#");

    var Headrow = document.getElementById('tblOrederedItems').insertRow(0);
    Headrow.id = "HeadID";
    Headrow.style.fontWeight = "bold";
    Headrow.className = "dataheader1"
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);
    var cell8 = Headrow.insertCell(7);
    var cell9 = Headrow.insertCell(8);
    var cell10 = Headrow.insertCell(9);
    var cell11 = Headrow.insertCell(10);
    var pIsShowStatus = x[0].split("~")[14];


    cell1.innerHTML = "S.No.";
    cell2.innerHTML = "Episode Name";
    cell3.innerHTML = "Episode No.";
    cell4.innerHTML = "Visit Name";
    cell5.innerHTML = "Visit No.";
    cell6.innerHTML = "Timed Type";
    cell7.innerHTML = "Timed No.";
    cell8.innerHTML = "Mandatory";
    cell9.innerHTML = "Allow Adhoc Visit";

    cell10.innerHTML = "Status";
    cell11.innerHTML = "Action";
    cell9.style.display = 'none';
    if (pIsShowStatus == "Hide") {
        cell10.style.display = 'none';
        cell11.style.display = 'none';
    }

    var pCount = x.length;
    pCount = pCount - 1;
    var pVisitStatus=false;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');

            var row = document.getElementById('tblOrederedItems').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);
            var cell9 = row.insertCell(8);
            var cell10 = row.insertCell(9);
            var cell11 = row.insertCell(10);
            
            cell1.innerHTML = pCount;
            cell2.innerHTML = y[3];
            cell3.innerHTML = y[1];
            cell4.innerHTML = y[2];
            cell5.innerHTML = y[0];
            cell6.innerHTML = y[4];
            cell7.innerHTML = y[5];
            cell8.innerHTML = y[6];
            cell9.innerHTML = y[7];
            cell10.innerHTML = y[12];
            cell9.style.display = 'none';
            if (y[12] == "Completed") {
                cell11.innerHTML = "<input name='" + y[2] + '@@' + y[0] + '@@' + y[6] + '@@' + y[10] + '@@' + y[13] + +'@@' + y[8] + "' onclick='AddEpisodeBillingItemsToBilling(name);' value = 'Add Services' type='button' disabled='disabled' style='text-align: left; font-size: 11px;background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />";
                if (pVisitStatus != true) {
                    pVisitStatus = true;
                }
            }
            else {
                cell11.innerHTML = "<input name='" + y[2] + '@@' + y[0] + '@@' + y[6] + '@@' + y[10] + '@@' + y[13] + '@@' + y[8] + "' onclick='AddEpisodeBillingItemsToBilling(name);' value = 'Add Services' type='button' style='text-align: left; font-size: 11px;background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />";
            }
            pCount = pCount - 1;
            if (pIsShowStatus == "Hide") {
                cell10.style.display = 'none';
                cell11.style.display = 'none';
            }
            
        }
    }
    if (pVisitStatus) {
         
            document.getElementById("divAdhocVisit").style.display = "block";
         
    }
}
function chkPatientRegisterCount() {
    var pNoOfPatient = document.getElementById('hdnNoOfPatient').value;
    var pRegistredPatient = document.getElementById('hdnRegistredPatient').value;

    if (Number(pNoOfPatient) < Number(pRegistredPatient)) {
        alert("Patient registration exceeded ");
        document.getElementById('txtName').focus();
        return;
    }


}

function AdhocChange() {


    for (var j = 0; j < document.getElementById('tblOrederedItems').rows.length; j++) {
        document.getElementById('tblOrederedItems').rows(j).cells[10].style.display = "block";
        
        if (document.getElementById('chkAdhocVisit').checked) {
            document.getElementById('tblOrederedItems').rows(j).cells[10].style.display = "none";
          
        }
    }
}