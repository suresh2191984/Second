var hdnID = "";
var queryStringColl = null;
var objSelect;
var objClear;
var objAlert;
var btnoktext;
var btnclosetext;
var Specarray = [];
var Specheaders = [];
var SpecFeeID = '';
var SpecFeetype = '';
var SpecFeeName = '';
var arr = [];
//By Dhanaselvam to check Selected From Test Name Autocomplete

var AutoCompSelected = false;
//
////$(document).ready(function() {
// objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
//   objSelect = SListForAppMsg.Get("Scripts_CommonBiling_js_04") == null ? "--Select--" : SListForAppMsg.Get("Scripts_CommonBiling_js_04");
//    objClear = SListForAppMsg.Get("Scripts_CommonBiling_js_01") == null ? "Are you sure you want to clear?" : SListForAppMsg.Get("Scripts_CommonBiling_js_01");
//});

//changed by Arivalagan.k
function clearBillPartValues() {

    $("#billPart_hdnTotalRedeemPoints").val("");
    $("#billPart_hdnTotalRedeemAmount").val("");
    $("#billPart_hdntotalredemPoints").val("");
    document.getElementById('billPart_txtTestName').value = '';
    document.getElementById('billPart_divItemTable').value = '';
    document.getElementById('billPart_txtAuthorised').value = '';
    document.getElementById('billPart_txtPatientHistory').value = '';
    document.getElementById('billPart_txtGross').value = '0.00';
    ToTargetFormat($("#billPart_txtGross"));
    document.getElementById('billPart_hdnGrossValue').value = '0.00';
    ToTargetFormat($("#billPart_hdnGrossValue"));
    document.getElementById('billPart_txtDiscount').value = '0.00';
    ToTargetFormat($("#billPart_txtDiscount"));
    document.getElementById('billPart_txtDiscountReason').value = '0.00';
    ToTargetFormat($("#billPart_txtDiscountReason"));
    document.getElementById('billPart_hdnDiscountAmt').value = '0.00';
    ToTargetFormat($("#billPart_hdnDiscountAmt"));
    document.getElementById('billPart_txtTax').value = '0.00';
    ToTargetFormat($("#billPart_txtTax"));
    document.getElementById('billPart_hdnTaxAmount').value = '0.00';
    ToTargetFormat($("#billPart_hdnTaxAmount"));
    document.getElementById('billPart_hdfTax').value = '0.00';
    ToTargetFormat($("#billPart_hdfTax"));
    document.getElementById('billPart_txtServiceCharge').value = '0.00';
    ToTargetFormat($("#billPart_txtServiceCharge"));
    document.getElementById('billPart_hdnServiceCharge').value = '0.00';
    ToTargetFormat($("#billPart_hdnServiceCharge"));
    document.getElementById('billPart_txtRoundoffAmt').value = '0.00';
    ToTargetFormat($("#billPart_txtRoundoffAmt"));
    document.getElementById('billPart_hdnRoundOff').value = '0.00';
    ToTargetFormat($("#billPart_hdnRoundOff"));
    document.getElementById('billPart_txtNetAmount').value = '0.00';
    ToTargetFormat($("#billPart_txtNetAmount"));
    document.getElementById('billPart_hdnNetAmount').value = '0.00';
    ToTargetFormat($("#billPart_hdnNetAmount"));
    document.getElementById('billPart_txtAmtReceived').value = '0.00';
    ToTargetFormat($("#billPart_txtAmtReceived"));
    document.getElementById('billPart_hdnDiscountableTestTotal').value = '0.00';
    document.getElementById('billPart_hdnRedeemableTestAmount').value = '0.00';
    ToTargetFormat($("#billPart_hdnDiscountableTestTotal"));
    document.getElementById('billPart_hdnAmountReceived').value = '0.00';
    ToTargetFormat($("#billPart_hdnAmountReceived"));
    document.getElementById('billPart_txtDue').value = '0.00';
    ToTargetFormat($("#billPart_txtDue"));
    document.getElementById('billPart_hdnDue').value = '0.00';
    ToTargetFormat($("#billPart_hdnDue"));
    document.getElementById('billPart_hdfBillType1').value = '';
    ToTargetFormat($("#billPart_hdfBillType1"));
    document.getElementById('billPart_hdnName').value = '';
    document.getElementById('billPart_hdnID').value = '';
    document.getElementById('billPart_hdnReportDate').value = '';
    ToTargetFormat($("#billPart_hdnReportDate"));
    document.getElementById('billPart_hdnRemarks').value = '';
    document.getElementById('billPart_hdnIsRemimbursable').value = '';
    ToTargetFormat($("#billPart_hdnIsRemimbursable"));
    document.getElementById('billPart_hdnPaymentControlReceivedtemp').value = '';
    ToTargetFormat($("#billPart_hdnPaymentControlReceivedtemp"));
    document.getElementById('billPart_hdnAmt').value = '0.00';
    ToTargetFormat($("#billPart_hdnAmt"));
    document.getElementById('billPart_ddDiscountPercent').value = '0';
    ToTargetFormat($("#billPart_ddDiscountPercent"));
    document.getElementById('billPart_hdnDiscountPercentage').value = '0';
    ToTargetFormat($("#billPart_hdnDiscountPercentage"));
    document.getElementById('billPart_hdnActualAmount').value = '0.00';
    ToTargetFormat($("#billPart_hdnActualAmount"));
    document.getElementById('billPart_hdnBaseRateID').value = '0';
    ToTargetFormat($("#billPart_hdnBaseRateID"));
    document.getElementById('billPart_hdnDiscountPolicyID').value = '0';
    ToTargetFormat($("#billPart_hdnDiscountPolicyID"));
    document.getElementById('billPart_hdnDiscountCategoryCode').value = '';
    ToTargetFormat($("#billPart_hdnDiscountCategoryCode"));
    document.getElementById('billPart_hdnDeliveryDate').value = '';
    ToTargetFormat($("#billPart_hdnDeliveryDate"));
    document.getElementById('billPart_ddlDiscountReason').value = '0';
    ToTargetFormat($("#billPart_ddlDiscountReason"));
    document.getElementById('billPart_hdnIsDiscount').value = 'N';
    ToTargetFormat($("#billPart_hdnIsDiscount"));
    document.getElementById('billPart_hdnFeeTypeSelected').value = 'COM';
    ToTargetFormat($("#billPart_hdnFeeTypeSelected"));
    document.getElementById('billPart_hdnIsRepeatable').value = 'Y';
    ToTargetFormat($("#billPart_hdnIsRepeatable"));
    document.getElementById('billPart_hdnIsRepeatable').value = 'N';
    ToTargetFormat($("#billPart_hdnIsRepeatable"));
    document.getElementById('billPart_lblPreviousDueText').value = '0.00';
    ToTargetFormat($("#billPart_lblPreviousDueText"));
    document.getElementById('billPart_ddlTaxPercent').value = '0';
    ToTargetFormat($("#billPart_ddlTaxPercent"));
    document.getElementById('billPart_txtEDCess').value = '0.00';
    ToTargetFormat($("#billPart_txtEDCess"));
    document.getElementById('billPart_hdnEDCess').value = '0.00';
    ToTargetFormat($("#billPart_hdnEDCess"));
    document.getElementById('billPart_txtSHEDCess').value = '0.00';
    ToTargetFormat($("#billPart_txtSHEDCess"));
    document.getElementById('billPart_hdnSHEDCess').value = '0.00';
    ToTargetFormat($("#billPart_hdnSHEDCess"));
    document.getElementById('billPart_hdnfinduplicate').value = '';
    ToTargetFormat($("#billPart_hdnfinduplicate"));
    document.getElementById('billPart_ddlDiscountReason').disabled = true;
    document.getElementById('billPart_ddlDiscountType').disabled = true;
    document.getElementById('billPart_ddlTaxPercent').disabled = true
    document.getElementById('billPart_ddDiscountPercent').disabled = true
    document.getElementById('billPart_btnDiscountPercent').disabled = true
    document.getElementById('billPart_trOrderedItemsCount').style.display = "none";
    document.getElementById('billPart_chkEDCess').checked = false;
    document.getElementById('billPart_chkSHEDCess').checked = false;
    document.getElementById('billPart_txtRemarks').value = '';
    document.getElementById('billPart_hdnIsInvestigationAdded').value = '0';
    if (document.getElementById('billPart_hdnIsSlabDiscount').value == 'Y') {
        document.getElementById('billPart_chkFoc').checked = false;
    }

    //  document.getElementById('billPart_hdnIsCashClient').value = document.getElementById('hdnIsCashClient').value;

    document.getElementById('billPart_ddlDiscountType').options.length = '0';
    document.getElementById("billPart_ddlSlab").options.length = 0;
    document.getElementById('billPart_txtCeiling').value = '';
    document.getElementById("billPart_trDiscountType").style.display = 'none';
    document.getElementById("billPart_trSlab").style.display = 'none';
    document.getElementById("billPart_trCeiling").style.display = 'none';
    document.getElementById('billPart_hdnIsCashClient').value = 'Y';
    ToTargetFormat($("#billPart_hdnIsCashClient"));
    $("#billPart_hdnMycardDetails").val("");
    ClearPaymentControlEvents1();
    ClearControlValues();
    GetCurrencyValues();
    document.getElementById('billPart_divItemTable').innerHTML = "";
    defaultbillflag = 0;
    if ($("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y" && $('#billPart_hdnOrgHealthCoupon').val() == "Y") {
        document.getElementById("billPart_dvHealhcard").style.display = "block";

        CheckMyCard();
    }

    //VEL
    document.getElementById('billPart_txtMRPGross').value = '0.00';
    ToTargetFormat($("#billPart_txtMRPGross"));
    document.getElementById('billPart_hdnMRPGrossValue').value = '0.00';
    ToTargetFormat($("#billPart_hdnMRPGrossValue"));
    document.getElementById('billPart_txtMRPNetAmount').value = '0.00';
    ToTargetFormat($("#billPart_txtMRPNetAmount"));
    document.getElementById('billPart_hdnMRPNetAmount').value = '0.00';
    ToTargetFormat($("#billPart_hdnMRPNetAmount"));
    document.getElementById('billPart_txtMRPDue').value = '0.00';
    ToTargetFormat($("#billPart_txtMRPDue"));
    document.getElementById('billPart_hdnMRPDue').value = '0.00';
    ToTargetFormat($("#billPart_hdnMRPDue"));
    //VEL

}

function clearbuttonClick() {
    // if (window.confirm("Are you sure you want to clear?")) {
    //debugger;
    objClear = SListForAppMsg.Get("Scripts_CommonBiling_js_01") == null ? "Are you sure you want to clear?" : SListForAppMsg.Get("Scripts_CommonBiling_js_01");

    if (window.confirm(objClear)) {
        clearPageControlsValue('N');
        clearControls();
       // return true;
    }
   // else {
        return false;
  //  }
}
function clearpatientbuttonClick() {
    //if (window.confirm("Are you sure you want to clear?")) {
    objClear = SListForAppMsg.Get("Scripts_CommonBiling_js_01") == null ? "Are you sure you want to clear?" : SListForAppMsg.Get("Scripts_CommonBiling_js_01");
    if (window.confirm(objClear)) {

        clearpatientmgntControls();
        return true;
    }
    else {
        return false;
    }
}


function clearClientbuttonClick() {

    //debugger;
    objClear = SListForAppMsg.Get("Scripts_CommonBiling_js_01") == null ? "Are you sure you want to clear?" : SListForAppMsg.Get("Scripts_CommonBiling_js_01");
    // if (window.confirm("Are you sure you want to clear?")) {
    if (window.confirm(objClear)) {
        clearPageControlsValue('N');
        clearClientControls();
        return true;
    }
    else {
        return false;
    }
}

function clearpatientmgntControls() {


    document.getElementById('txtName').value = "";
    document.getElementById('txtDOBNos').value = "";
    document.getElementById('tDOB').value = "";
    document.getElementById('txtMobileNumber').value = "";
    document.getElementById('txtSuburban').value = "";
    document.getElementById('txtPhone').value = "";
    document.getElementById('txtAddress').value = "";
    document.getElementById('txtPincode').value = "";
    document.getElementById('txtCity').value = "";
    document.getElementById('txtDOBNos').value = "";
    document.getElementById('ddlDOBDWMY').value = "Year(s)";
    document.getElementById('txtEmail').value = "";
    document.getElementById('hdnPatientID').value = "-1";
    document.getElementById('ddCountry').value = document.getElementById('hdnDefaultCountryID').value;
    document.getElementById('lblCountryCode').innerHTML = document.getElementById('hdnDefaultCountryStdCode').value;
    document.getElementById('ddlUrnoOf').value = 0;
    document.getElementById('ddlUrnType').value = 0;
    document.getElementById('ddMarital').value = 0;

    document.getElementById('ddState').value = 11;

    document.getElementById('ddCountry').value = 75;

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
    document.getElementById('hdnReferedPhyID').value = "";
    document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value = "";
    if (document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText != "") {
        document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
    }

}
function SetDiscountAmt() {

    objSelect = SListForAppMsg.Get("Scripts_CommonBiling_js_04") == null ? "--Select--" : SListForAppMsg.Get("Scripts_CommonBiling_js_04");
    var DiscountType = "";
    var pDiscountPercent = document.getElementById('billPart_ddDiscountPercent');
    if (pDiscountPercent.selectedIndex == 0 && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y")
        $('#billPart_dvHealhcard').show();
    else
        $('#billPart_dvHealhcard').hide();
    var DiscountPercent = pDiscountPercent.options[pDiscountPercent.selectedIndex].value;
    var DiscountPercentName = pDiscountPercent.options[pDiscountPercent.selectedIndex].Text;
    var SDiscountId = DiscountPercent.split('~');
    var DiscountId = SDiscountId[1];
    if (SDiscountId[3] != "") {
        DiscountType = SDiscountId[3];
    }
    document.getElementById('billPart_hdnDiscountDetails').value = DiscountPercentName + '~';

    if (document.getElementById('billPart_ddDiscountPercent').value == '0') {
        document.getElementById('billPart_txtDiscount').value = '0.00';
        ToTargetFormat($('#billPart_txtDiscount'));
        document.getElementById('billPart_hdnDiscountAmt').value = '0';
        ToTargetFormat($('#billPart_hdnDiscountAmt'));
    }
    if (document.getElementById('billPart_hdnDiscountPercentage').value == '0') {
        document.getElementById('billPart_txtDiscount').value = '0.00';
        ToTargetFormat($('#billPart_txtDiscount'));
        document.getElementById('billPart_hdnDiscountAmt').value = '0';
        ToTargetFormat($('#billPart_hdnDiscountAmt'));
    }
    /*************Added by Arivalagan.kk*****************/

    if ($('#billPart_ddDiscountPercent option:selected').val() != 0) {
        document.getElementById('billPart_txtAuthorised').disabled = false;
        document.getElementById('billPart_txtAuthorised').readOnly = false;
        document.getElementById('billPart_txtDiscountReason').readOnly = false;
        document.getElementById('billPart_ddlDiscountReason').disabled = false;
        document.getElementById('billPart_ddlDiscountType').disabled = false;
    }
    else if ($('#billPart_txtDiscount').val() > 0) {

        document.getElementById('billPart_txtAuthorised').disabled = false;
        document.getElementById('billPart_txtAuthorised').readOnly = false;
        document.getElementById('billPart_txtDiscountReason').readOnly = false;
        document.getElementById('billPart_ddlDiscountReason').disabled = false;
        document.getElementById('billPart_ddlDiscountType').disabled = false;
    }
    else {

        document.getElementById('billPart_txtAuthorised').disabled = true;
        document.getElementById('billPart_txtAuthorised').readOnly = true;
        document.getElementById('billPart_txtDiscountReason').readOnly = true;
        document.getElementById('billPart_ddlDiscountReason').disabled = true;
        document.getElementById('billPart_ddlDiscountType').disabled = true;
    }
    /************End*Added by Arivalagan.kk**************/
    var KeySlabDiscount = document.getElementById('billPart_hdnIsSlabDiscount').value;
    if (KeySlabDiscount == 'Y') {
        if (DiscountPercent == "0") {
            document.getElementById("billPart_trDiscountType").style.display = 'none';
            document.getElementById("billPart_trSlab").style.display = 'none';
            document.getElementById('billPart_ddlSlab').value = 0;
            document.getElementById("billPart_trCeiling").style.display = 'none';
            document.getElementById('billPart_txtCeiling').value = 0;
            document.getElementById('billPart_ddlDiscountReason').options.length = 0;
            var ddlDiscountReason = document.getElementById("billPart_ddlDiscountReason");
            var optn = document.createElement("option");
            ddlDiscountReason.options.add(optn);
            // optn.text = "--Select--";
            optn.text = objSelect;
            optn.value = "0";

        } else {
            if (DiscountId != '' && DiscountId > 0) {
                if (DiscountType == "Foc") {
                    document.getElementById("billPart_chkFoc").checked = true;
                    document.getElementById("billPart_trDiscountType").style.display = 'none';
                    document.getElementById("billPart_trSlab").style.display = 'none';
                    document.getElementById("billPart_trCeiling").style.display = 'none';
                    document.getElementById('billPart_txtAuthorised').disabled = false;
                    document.getElementById('billPart_chkEDCess').disabled = true;
                    document.getElementById('billPart_txtEDCess').disabled = true;
                    document.getElementById('billPart_chkSHEDCess').disabled = true;
                    document.getElementById('billPart_txtSHEDCess').disabled = true;
                    document.getElementById('billPart_txtTax').disabled = true;
                    document.getElementById('billPart_ddlTaxPercent').disabled = true;
                    document.getElementById('billPart_hdnDiscountType').value = 0;
                    document.getElementById('billPart_hdnSlabPercentAndValue').value = 0;
                    document.getElementById('billPart_hdnCeilingValue').value = "";

                    GetSlab(DiscountId);
                }
                else {
                    document.getElementById("billPart_chkFoc").checked = false;
                    document.getElementById("billPart_ddlSlab").options.length = 0;
                    document.getElementById('billPart_txtAuthorised').value = "";
                    document.getElementById('billPart_hdnDiscountCeiling').value = "0";
                    document.getElementById('billPart_txtCeiling').value = "";
                    document.getElementById('billPart_hdnCeilingValue').value = "";
                    GetSlab(DiscountId);
                }
            }
        }
    }
    else {
        SetNetValue('ADD');
    }
}
function DocPopulated(sender, e) {
    var behavior = $find('AutoCompleteExtenderRefPhy');
    var target = behavior.get_completionList();
    for (i = 0; i < target.childNodes.length; i++) {
        var text = target.childNodes[i]._value;
        var ItemArry;
        ItemArry = text.split('^');
        if (ItemArry[0].trim().toLowerCase() == 'p') {
            target.childNodes[i].style.color = "Black";
        }
        else {
            target.childNodes[i].style.color = "orange";
        }
    }
}
function SetTaxAmt() {
    if (document.getElementById('billPart_ddlTaxPercent').value == '0') {
        document.getElementById('billPart_txtTax').value = '0.00';
        ToTargetFormat($('#billPart_txtTax'));
        document.getElementById('billPart_hdnTaxAmount').value = '0.00';
        ToTargetFormat($('#billPart_hdnTaxAmount'));
    }
}
function MaxLengthAlert(id) {
    var objMoreChar = SListForAppMsg.Get("Scripts_CommonBiling_js_02") == null ? "More than 250 characters are not allowed" : SListForAppMsg.Get("Scripts_CommonBiling_js_02");
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");

    var s = document.getElementById(id).value;
    var str = s.substring(0, 250);
    if (s.length >= 250) {
        //alert("More than 250 characters are not allowed");
        ValidationWindow(objMoreChar, objAlert);
        document.getElementById(id).value = str;
        document.getElementById('billPart_txtPatientHistory').focus();
        return false;
    }
    else {
        return true;
    }

}
function getOPCustomRoundoff(netRound) {
    //var DefaultRound = document.getElementById('hdnDefaultRoundoff').value;
    var DefaultRound = ToInternalFormat($('#hdnDefaultRoundoff'));
    // var RoundType = document.getElementById('hdnRoundOffType').value;
    var RoundType = ToInternalFormat($('#hdnRoundOffType'));
    if (RoundType == "0") {
        RoundType = "none";
    }
    if (RoundType != undefined) {
        if (RoundType.toLowerCase() == "lower value") {
            result = (Math.floor(Number(netRound) / Number(DefaultRound))) * (Number(DefaultRound));
        }
        else if (RoundType.toLowerCase() == "upper value") {
            var lastdigit = Math.round(netRound % 10);
            if (lastdigit < 5.00) {
                result = (Math.floor(Number(netRound) / Number(5.00))) * (Number(5.00));
            }
            else if (lastdigit > 5.00) {
               // result = (Math.ceil(Number(netRound) / Number(10.00)) * (Number(10.00)));
		 result = (Math.ceil((Number(netRound) / Number(10.00))*Number(10.00)));
            }
            else {
                result = (Math.floor(Number(netRound) / Number(10.00))) * (Number(10.00));
            }
        }
        else if (RoundType.toLowerCase() == "none") {
            result = format_number_withSignNone(netRound, 2);
        }
	else if (RoundType.toLowerCase() == "normal") {
        result = Math.round(netRound);
        }
        else {
            result = parseFloat(netRound).toFixed(2);
        }
    }
    result = parseFloat(result).toFixed(2);
    return result;
}


function GetReferingHospID(source, eventArgs) {
    document.getElementById('txtReferringHospital').value = eventArgs.get_text();
    document.getElementById('hdfReferalHospitalID').value = eventArgs.get_value();
}

//function SelectedTest(source, eventArgs) {
//    var list = eventArgs.get_value().split('^');
//    if (list.length > 0) {
//        for (i = 0; i < list.length; i++) {
//            if (list[i] != "") {
//                //document.getElementById('lblInvType').innerHTML = list[2];
//            }
//        }
//    }
//}

function TempBillingItemSelected(source, eventArgs) {

    var list = eventArgs.get_value().split('^');
    if (list.length > 0) {
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                if (list[1] != "" && list[1] != null) {
                    document.getElementById('billPart_txtTestName').value = list[1];
                    if (list[7] == "Y") {
                        document.getElementById('billPart_txtVariableRate').style.display = 'block';
                        document.getElementById('billPart_txtVariableRate').value = list[6];
                    }
                    else {
                        document.getElementById('billPart_txtVariableRate').style.display = 'none';
                        document.getElementById('billPart_txtVariableRate').value = "";
                    }
                }

                //document.getElementById('lblInvType').innerHTML = list[2];
            }
        }
    }

    var varGetVal = eventArgs.get_value();
    var arrGetVal = new Array();
    arrGetVal = varGetVal.split("^");
    document.getElementById('billPart_txtTestName').value = arrGetVal[1]
    //$('[id$="txtTestName"]').val(arrGetVal[1]);
    //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
    var ID;
    var name;
    var feeType;
    var amount;
    var IsDicountableTest;
    var IsRepeatable;
    var Code;
    var IsOutSource;
    var outRInSourceLocation;
    var list = eventArgs.get_value().split('^');
    if (list.length > 0) {
        if (list[i] != "") {
            ID = list[0];
            name = list[1].trim();
            feeType = list[2];
            Code = list[3];
            IsOutSource = list[4];
            outRInSourceLocation = list[5];
            document.getElementById('billPart_hdnID').value = ID;
            document.getElementById('billPart_hdnName').value = name;
            document.getElementById('billPart_hdnFeeTypeSelected').value = feeType;
            document.getElementById('billPart_hdnInvCode').value = Code;
            document.getElementById('billPart_hdnIsOutSource').value = IsOutSource;
            document.getElementById('billPart_hdnoutsourcelocation').value = outRInSourceLocation;
        }
    }
    else {
        document.getElementById('billPart_hdnID').value = -1;
        document.getElementById('billPart_hdnFeeTypeSelected').value = "OTH";
    }
    pageLoad();

    $find('billPart_AutoCompleteExtender3')._onMethodComplete = function(result, context) {
        $find('billPart_AutoCompleteExtender3')._update(context, result, /* cacheResults */false);
        webservice_callback(result, context);
    };
}
function loadState(obj) {
    var EditDocConfig = document.getElementById('hdnrolevalue').value;
    var EditDoc = document.getElementById('hdneditdoc').value;
    objSelect = SListForAppMsg.Get("Scripts_CommonBiling_js_04") == null ? "--Select--" : SListForAppMsg.Get("Scripts_CommonBiling_js_04");
    if (obj != 0) {
        $("select[id$=ddState] > option").remove();
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetStateByCountry",
            data: "{ 'CountryID': '" + parseInt($('#ddCountry').val()) + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                if (EditDocConfig == "Y" && EditDoc == "Y") {
                    $('#ddState').attr("disabled", true);
                }
                else {
                    $('#ddState').attr("disabled", false);
                }
                // $('#ddState').append('<option value="-1">--Select--</option>');
                $('#ddState').append('<option value="-1">' + objSelect + '</option>');
                $.each(Items, function(index, Item) {
                    $('#ddState').append('<option value="' + Item.StateID + '">' + Item.StateName + '</option>');
                    $('#lblCountryCode').html("+" + Item.ISDCode);
                    // document.getElementById('lblCountryCode').innerHTML = "+" + Item.ISDCode;
                });
                if (obj != "0") {
                    if (Number($('#hdnPatientID').val()) > 0 && Number($('#hdnPatientStateID').val()) > 0) {
                        $('#ddState').val($('#hdnPatientStateID').val());
                    }
                    else {
                        onchangeState();
                    }
                }
                else {
                    $('#ddState').val($('#hdnDefaultStateID').val());
                }

            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }
    else {
        document.getElementById('ddCountry').value = document.getElementById('hdnDefaultCountryID').value;
        document.getElementById('ddState').value = document.getElementById('hdnDefaultStateID').value;
    }
}


function onchangeState() {
    $('#hdnPatientStateID').val($('#ddState').val());
}

function alpha(e) {
    //    var k;
    //    document.all ? k = e.keyCode : k = e.which;
    //    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
    var k;
    k = e.keyCode || e.charCode;
    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 9 || k == 32 || (k >= 48 && k <= 57));
}
function alphaSpl(e) {
    /** Including ", /" **/
    var k;
    document.all ? k = e.keyCode : k = e.which;
    k = e.keyCode || e.charCode;
    //  return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57) || k == 44 || k == 47);
    if (document.getElementById('hdnAllowSplChar') != null) {
        if (document.getElementById('hdnAllowSplChar').value == 'N') {
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 9 || k == 32 || k == 46 || k == 44 || k == 40 || k == 64 || k == 41 || k == 47 || (k >= 48 && k <= 57));
        }


        else {
            //  return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || k == 44 || (k >= 48 && k <= 57));

        }
    }
}
function CheckBillItems() {
    if (Number(document.getElementById('billPart_hdnDiscountAmt').value) <= 0) {
        //alert('Provide discount for bill, then give approved by and reason');
        //document.getElementById('billPart_txtAuthorised').disabled = true;
        document.getElementById('billPart_txtAuthorised').disabled = false;
        //return false;
    }
    var AuthTypeName = "";
    if (document.getElementById('billPart_hdnIsSlabDiscount').value == 'Y') {
        if (document.getElementById('billPart_chkFoc').checked == true) {
            AuthTypeName = "FOC";
        }
        else {
            AuthTypeName = "Discount";
        }
    }
    var orgId = document.getElementById('billPart_hdnOrgIDC').value;
    $find('billPart_AutoAuthorizer').set_contextKey(orgId + '~' + AuthTypeName);
}

function SetRateCard() {
    var CreditFlag = 0;
    if (Number(document.getElementById('hdnSelectedClientRateID').value) > 0 && document.getElementById('txtClient').value.trim() != '')
        CreditFlag = 1;

    if (Number(CreditFlag) > 0) {
        document.getElementById('hdnRateID').value = Number(document.getElementById('hdnSelectedClientRateID').value);
        document.getElementById('hdnClientID').value = Number(document.getElementById('hdnSelectedClientClientID').value);
        document.getElementById('hdnMappingClientID').value = Number(document.getElementById('hdnSelectedClientMappingID').value);
    }
    else {
        document.getElementById('hdnRateID').value = Number(document.getElementById('hdnBaseRateID').value);
        document.getElementById('hdnClientID').value = Number(document.getElementById('hdnBaseClientID').value);
        document.getElementById('hdnMappingClientID').value = -1;
    }
    if ((document.getElementById('billPart_hdnOrgid').value == "Y") && (document.getElementById('billPart_hdnIsCashClient').value == "Y")) {
        
       // document.getElementById('billPart_txtDiscount').disabled = false;
        document.getElementById('billPart_txtAuthorised').disabled = false;
        document.getElementById('billPart_txtDiscountReason').readOnly = false;
    }
    else {
        document.getElementById('billPart_txtDiscount').disabled = true;
        document.getElementById('billPart_txtAuthorised').disabled = true;
        document.getElementById('billPart_txtDiscountReason').readOnly = true;
    }

    if (document.getElementById('billPart_hdnIsDiscount').value == "Y") {
        document.getElementById('billPart_txtDiscount').disabled = false;
        document.getElementById('billPart_txtAuthorised').disabled = false;
        document.getElementById('billPart_txtDiscountReason').readOnly = false;
    }
}
function CheckOrderedItems() {
    if (document.getElementById('billPart_hdnCpedit').value != "Y") {
        if (document.getElementById('billPart_hdfBillType1').value != '') {
            var objDelOrder = SListForAppMsg.Get("Scripts_CommonBiling_js_03") == null ? "Delete the Ordered Items then only you can Change.\n Do you want to delete the items, Press OK Else Cancel" : SListForAppMsg.Get("Scripts_CommonBiling_js_03");
            //var pBill = confirm("Delete the Ordered Items then only you can Change.\n Do you want to delete the items, Press OK Else Cancel");
            var pBill = confirm(objDelOrder);
            if (pBill != true) {
                document.getElementById('billPart_txtTestName').focus();
                return false;
            }
            else {
                ClearmycardDetails('N');
				$('#hdnClientAttrList').val("");
                document.getElementById('txtClient').value = '';
                document.getElementById('billPart_hdfBillType1').value = '';
                document.getElementById('billPart_hdnfinduplicate').value = ''
                document.getElementById('hdnRateID').value = Number(document.getElementById('hdnBaseRateID').value);
                document.getElementById('hdnClientID').value = Number(document.getElementById('hdnBaseClientID').value);
                document.getElementById('hdnSelectedClientClientID').value = Number(document.getElementById('hdnBaseClientID').value);
                document.getElementById('hdnIsCashClient').value = 'N';

                var ddlobj = document.getElementById("ddlRate");
                ddlobj.options.length = 0;
                defaultbillflag = 0
                CreateBillItemsTable(1);
                ClearPaymentControlEvents1();
                document.getElementById('txtClient').focus();
                document.getElementById('billPart_tdClientAttributes').style.display = 'none';
                //Added by Arivalagan.kk Co Paymnet//
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
                //End Added by Arivalagan.kk Co Paymnet//
            }
        }
        else {
            if ($("#txtClient").val() == "" && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y") {
                document.getElementById("billPart_dvHealhcard").style.display = "block";

                CheckMyCard();
            }
        }
    }
    return true;
}
function ShowTRFUpload(obj, id) {
    if (obj.checked) {
        $('[id$="TRFimage"]').show();
    }
    else {
        $('[id$="TRFimage"]').hide();
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


function ConverttoUpperCase(id) {
    var lowerCase = document.getElementById(id).value;
    var upperCase = lowerCase.toUpperCase();
    document.getElementById(id).value = upperCase;
}
function DiscountAuthSelectedOver(source, eventArgs) {
    $find('billPart_AutoAuthorizer')._onMethodComplete = function(result, context) {
        //var Perphysicianname = document.getElementById('txtperphy').value;
        $find('billPart_AutoAuthorizer')._update(context, result, /* cacheResults */false);
        if (result == "") {
            //alert('Please select discount authroise from the list');
            document.getElementById('billPart_txtAuthorised').value = '';
        }
    };
}

function DiscountAuthSelected(source, eventArgs) {
    document.getElementById('billPart_hdnDiscountApprovedBy').value = eventArgs.get_value();
}
function PhysicianSelected(source, eventArgs) {
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");


    var PhysicianID;
    var PhysicianName;
    var PhysicianCode;
    var PhysicianType;
    document.getElementById('txtInternalExternalPhysician').value = eventArgs.get_text();
    var PhyType;
    var list = eventArgs.get_value().split('^');
    //List[0] PhysicianType
    //List[1] PhysicianID
    //List[2] PhysicianName
    //List[3] PhysicianCode
    if (list.length > 0) {
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                PhysicianID = list[1];
                PhysicianName = list[2];
                PhysicianCode = list[3];
                PhysicianType = list[0].trim();
                PhyType = list[4];
            }
        }
    }
    document.getElementById('hdnReferedPhyID').value = PhysicianID;
    document.getElementById('hdnReferedPhyName').value = PhysicianName;
    document.getElementById('hdnReferedPhysicianCode').value = PhysicianCode;
    document.getElementById('hdnReferedPhyType').value = PhysicianType;

    //syed

    if (PhyType == "EX") {
        PhyType = 'REFPHY';
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetDiscountLimit",
            data: "{ 'ReferType': '" + PhyType + "','ReferID': '" + PhysicianID + "','llNo': '" + "','orgID': '" + parseInt(document.getElementById('hdnOrgID').value) + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {

                if (data.d.length >= 1) {
                    if (data.d[0].GrossBillValue > 0) {
                        if (document.getElementById('hdnDiscountLimitType').value != "EMPL") {
                            $('[id$="hdnDiscountLimitAmt"]').val(data.d[0].GrossBillValue);
                            $('[id$="hdnSumDiscountAmt"]').val(data.d[0].DiscountAmount);
                            $('[id$="hdnAvailableDiscountAmt"]').val(data.d[0].NetValue);

                            $('[id$="hdnDiscountLimitType"]').val(PhyType);

                            //  alert('Discount Limit: ' + data.d[0].GrossBillValue + ' Total Discount: ' + data.d[0].DiscountAmount + ' Avialable Balance: ' + data.d[0].NetValue);
                        }
                    }
                }
            },
            failure: function(msg) {
                //                alert(msg);

                ValidationWindow(msg, objAlert);
            }
        });
    }
}
function CollectionCenterSelected(source, eventArgs) {

    var CollectionCenterID;
    var CollectionCenterName;
    var CollectionCenterCode;
    var CollectionCenterRateID;
    var CollectionCenterClientID;
    var CollectionCenterMappingID;

    var list = eventArgs.get_value().split('^');
    if (list.length > 0) {
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                CollectionCenterID = list[0];
                CollectionCenterName = list[2];
                CollectionCenterCode = list[3];
                CollectionCenterRateID = list[4];
                CollectionCenterClientID = list[5];
                CollectionCenterMappingID = list[6];
            }
        }
    }
    document.getElementById('hdnCollectionCenterID').value = CollectionCenterID;
    document.getElementById('hdnCollectionCenterName').value = CollectionCenterName;
    document.getElementById('hdnCollectionCenterCode').value = CollectionCenterCode;
    document.getElementById('hdnCollectionCenterRateID').value = CollectionCenterRateID;
    document.getElementById('hdnCollectionCenterClientID').value = CollectionCenterClientID;
    document.getElementById('hdnCollectionCenterMappingID').value = CollectionCenterMappingID;
}
function ClientSelected(source, eventArgs) {
    ClearClientAttr();
    var ClientCorpID;
    var ClientCorpName;
    var ClientCorpCode;
    var ClientCorpRateID;
    var ClientCorpClientID;
    var ClientCorpMappingID;
    var Ismappeditem = "N";
    var IsDiscount = "N";
    var ClientType;
    var ReferingID;
    var list = eventArgs.get_value().split('^');
    var slist = eventArgs.get_value().split('###');
    var flist;
    var temp = 0;
    var ClientStatus = '';
    var BoolValue = true;
    var IsCashClient = "N";
    var PRateType;
    var CoPayment;
    var Hashealthcoupon = '';

    var CollectionID = 0;
    var TotalDepositAmount = 0;
    var TotalDepositUsed = 0;
    var AmtRefund = 0;
    var ThresholdType = "";
    var ThresholdValue = 0;
    var ThresholdValue2 = 0;
    var ThresholdValue3 = 0;
    var VirtualCreditType = "";
    var VirtualCreditValue = 0;
    var MinimumAdvanceAmt = 0;
    var MaximumAdvanceAmt = 0;
    var hdnAdvanceClient = 0;
    var hdnCreditClient = 0;
    var PendingCreditLimit = 0;
    var NotInvoicedAmt = 0;
    var IsEnableAttributes = "N";
    var CreditExpiresday = 0;
    var IsBlockReg = "N";
    
    if (slist.length > 0) {
        for (j = 0; j < slist.length - 1; j++) {
            flist = slist[j].split('^');
            var rat = flist[4].split('~');
            if (j == 0) {
                ClientStatus = flist[13].trim();
                if (ClientStatus == 'S' || ClientStatus == 'T') {
                    BoolValue = CheckClientStatus(ClientStatus, flist[15], flist[16]);
                    //return BoolValue;
                    if (BoolValue == true) {
                    }
                    else {
                        return BoolValue;
                    }

                }
                ClientCorpID = flist[0];
                ClientCorpName = flist[2];
                ClientCorpCode = flist[3];
                ClientCorpRateID = rat[0];
                ClientCorpClientID = flist[5];
                ClientCorpMappingID = flist[6];
                temp = flist[8];
                Ismappeditem = flist[9];
                IsDiscount = flist[10];
                ClientType = flist[7];
                ReferingID = flist[12];
                IsCashClient = flist[17];
                PRateType = flist[20];
                CoPayment = flist[22];
                Hashealthcoupon = flist[23];
                CollectionID = flist[24];
                TotalDepositAmount = flist[25];
                TotalDepositUsed = flist[26];
                AmtRefund = flist[27];
                ThresholdType = flist[28];
                ThresholdValue = flist[29];
                ThresholdValue2 = flist[30];
                ThresholdValue3 = flist[31];
                VirtualCreditType = flist[32];
                VirtualCreditValue = flist[33];
                MinimumAdvanceAmt = flist[34];
                MaximumAdvanceAmt = flist[35];
                hdnAdvanceClient = flist[36];
                IsEnableAttributes = flist[41];
                hdnCreditClient = flist[42];
                PendingCreditLimit = flist[43];
                NotInvoicedAmt = flist[44];
                CreditExpiresday = flist[45];
                IsBlockReg = flist[46];
            }
            if (temp > flist[8]) {
                ClientStatus = flist[13].trim();
                if (ClientStatus == 'S' || ClientStatus == 'T') {
                    BoolValue = CheckClientStatus(ClientStatus, flist[15], flist[16]);
                    //return BoolValue;
                    if (BoolValue == true) {
                    }
                    else {
                        return BoolValue;
                    }
                }
                ClientCorpID = flist[0];
                ClientCorpName = flist[2];
                ClientCorpCode = flist[3];
                ClientCorpRateID = rat[0];
                ClientCorpClientID = flist[5];
                ClientCorpMappingID = flist[6];
                temp = flist[8];
                Ismappeditem = flist[9];
                IsDiscount = flist[10];
                ClientType = flist[7];
                ReferingID = flist[12];
                IsCashClient = flist[17];
            }
        }
    }
    /*credit limit */
    if (hdnCreditClient >0) {
        objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");

        document.getElementById('trCreditLimit').style.display = "block";
        var deduction = parseInt(PendingCreditLimit);

        $('#billPart_lblCreditLimitAmt').html(deduction);
        document.getElementById('hdnCreditLimit').value = hdnCreditClient;
        document.getElementById('hdnTotalCreditLimit').value = PendingCreditLimit;
        document.getElementById('hdnTotalCreditUsed').value = NotInvoicedAmt;
        document.getElementById('hdnCreditExpires').value = CreditExpiresday;
        document.getElementById('hdnIsBlockReg').value = IsBlockReg;
        

        /*AB Code*/
        var objClientZero = SListForAppMsg.Get("Scripts_CommonBiling_js_58") == null ? "Client deposit balance amount is Zero" : SListForAppMsg.Get("Scripts_CommonBiling_js_58");

        var amount = $('#billPart_lblCreditLimitAmt').text();

        if (amount <= 0) {
            //alert('Client deposit balance amount is Zero');
            ValidationWindow(objClientZero, objAlert);
            document.getElementById('txtClient').value = '';
            document.getElementById('txtClient').focus();
            document.getElementById('trCreditLimit').style.display = "none";
            return false;
        }

    }
    else {
        document.getElementById('trCreditLimit').style.display = "none";
        document.getElementById('hdnCreditLimit').value = 0;
        document.getElementById('hdnTotalCreditLimit').value = 0;
        document.getElementById('hdnTotalCreditUsed').value = 0;
        document.getElementById('hdnCreditExpires').value = 0;
    }
    /*end*/
    
    
    
    if (hdnAdvanceClient == "1") {
        objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");

        document.getElementById('trRollingAdvance').style.display = "block";
        var deduction = parseInt(TotalDepositUsed) + parseInt(AmtRefund);

        $('#billPart_lblRollingBalAmt').html(TotalDepositAmount - deduction);

        /*AB Code*/
        var objClientZero = SListForAppMsg.Get("Scripts_CommonBiling_js_05") == null ? "Client deposit balance amount is Zero" : SListForAppMsg.Get("Scripts_CommonBiling_js_05");

        var amount = $('#billPart_lblRollingBalAmt').text();

        if (amount <= 0) {
            //alert('Client deposit balance amount is Zero');
            ValidationWindow(objClientZero, objAlert);
            document.getElementById('txtClient').value = '';
            document.getElementById('txtClient').focus();
            document.getElementById('trRollingAdvance').style.display = "none";
            return false;
        }

    }
    else {
        document.getElementById('trRollingAdvance').style.display = "none";
    }
    counti = 0;
    if (IsEnableAttributes == "Y") {
        document.getElementById('billPart_tdClientAttributes').style.display = "block";
    }
    else {
        document.getElementById('billPart_tdClientAttributes').style.display = "none";
    }
    //Co payment//
    if (document.getElementById('HdnCoPay') != null) {
        document.getElementById('HdnCoPay').value = CoPayment;
	DisplayCoPayMent();
    }
    //end  co payment//
    document.getElementById('billPart_hdnHasClientHealthcoupon').value = Hashealthcoupon;
    document.getElementById('hdnIsMappedItem').value = Ismappeditem;
    document.getElementById('billPart_hdnIsDiscount').value = IsDiscount;
    document.getElementById('hdnSelectedClientID').value = ClientCorpID;
    document.getElementById('hdnSelectedClientName').value = ClientCorpName;
    document.getElementById('hdnSelectedClientCode').value = ClientCorpCode;
    document.getElementById('hdnSelectedClientRateID').value = ClientCorpRateID;
    document.getElementById('hdnSelectedClientClientID').value = ClientCorpClientID;
    //Searching patient name with clientID
    document.getElementById('hdnSerachPatientwithClientID').value = ClientCorpClientID;
    //if (document.getElementById('hdnSampleforPrevious').value != '') {
    //  document.getElementById('hdnValidateclient').value = ClientCorpClientID;
    //}



    $('[id$="hdnAdvanceClient"]').val(hdnAdvanceClient);
    document.getElementById('hdnSelectedClientMappingID').value = ClientCorpMappingID;
    document.getElementById('hdnIsCashClient').value = IsCashClient;
    document.getElementById('billPart_hdnIsCashClient').value = IsCashClient.trim();
    document.getElementById('billPart_hdnClientType').value = ClientType.trim();
    //    if (IsCashClient.trim() == "N") {
    //        if (document.getElementById("billPart_dvHealhcard") != null) {
    //            document.getElementById("billPart_dvHealhcard").style.display = "none";
    //            document.getElementById("billPart_chkMycard").checked = false;
    //        }
    document.getElementById('hdnCollectionID').value = CollectionID;
    document.getElementById('hdnTotalDepositAmount').value = TotalDepositAmount;
    document.getElementById('hdnTotalDepositUsed').value = TotalDepositUsed;
    if (document.getElementById('hdnAmtRefund') != null) {
        document.getElementById('hdnAmtRefund').value = AmtRefund;
    }
    document.getElementById('hdnThresholdType').value = ThresholdType;

    document.getElementById('hdnThresholdValue').value = ThresholdValue;
    document.getElementById('hdnThresholdValue2').value = ThresholdValue2;
    document.getElementById('hdnThresholdValue3').value = ThresholdValue3;
    document.getElementById('hdnVirtualCreditType').value = VirtualCreditType;
    document.getElementById('hdnVirtualCreditValue').value = VirtualCreditValue;
    document.getElementById('hdnMinimumAdvanceAmt').value = MinimumAdvanceAmt;
    document.getElementById('hdnMaximumAdvanceAmt').value = MaximumAdvanceAmt;
    //    }
    //    else {
    if ($("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y" && IsCashClient.trim() == "Y" && Hashealthcoupon == "Y") {
        document.getElementById("billPart_dvHealhcard").style.display = "block";

        CheckMyCard();
    }
    else {
        document.getElementById("billPart_dvHealhcard").style.display = "none";

        CheckMyCard();
    }
    //   }
    document.getElementById('txtClient').value = ClientCorpName;

    // ValidateCreditLimit(ClientCorpClientID);
    SetRateCard();
    document.getElementById('lblClientDetails').innerHTML = "";
    document.getElementById('divShowClientDetails').style.display = "none";

    if (ClientType.trim() == 'RPH') {
        document.getElementById('txtInternalExternalPhysician').value = ClientCorpName;
        document.getElementById('hdnReferedPhyID').value = ReferingID;
    }
    if (ClientType.trim() == 'HOS') {
        document.getElementById('txtReferringHospital').value = ClientCorpName;
        document.getElementById('hdfReferalHospitalID').value = ReferingID;
    }
    if (document.getElementById('billPart_hdnCpedit').value == "Y") {
        AddBillingItemsDetailsForEdit(ClientCorpClientID);
    }
}

function CheckClientStatus(ClientStatus, BlockFrom, BlockTo) {
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");

    var objTo = SListForAppMsg.Get("Scripts_CommonBiling_js_07") == null ? " to " : SListForAppMsg.Get("Scripts_CommonBiling_js_07");
    var objvar25 = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_52") == null ? "This Client was Terminated. Terminated from " : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_52");

    if (ClientStatus == 'S' || ClientStatus == 'T') {
        var displayTxt = '';
        var objClientSuspend = SListForAppMsg.Get("Scripts_CommonBiling_js_06") == null ? "This Client was suspended. Suspended from " : SListForAppMsg.Get("Scripts_CommonBiling_js_06");

        if (ClientStatus == 'S') {
            displayTxt = objClientSuspend + BlockFrom + ' ' + objTo + ' ' + BlockTo;
            var IsContinue = confirm(objClientSuspend + BlockFrom + ' ' + objTo + ' ' + BlockTo);
            if (IsContinue == true) {
                return true;
            }
            else {
                document.getElementById('txtClient').value = '';
                document.getElementById('txtClient').focus();
                return false;
            }


        }
        else if (ClientStatus == 'T') {
            displayTxt = objvar25 + BlockFrom + ' ' + objTo + ' ' + BlockTo;
            // alert(displayTxt);
            ValidationWindow(displayTxt, objAlert);

        }
        if (displayTxt != '') {

            document.getElementById('txtClient').value = '';
            document.getElementById('txtClient').focus();
            return false;
        }
    }
}

function ValidateCreditLimit(ClientID) {
    if (ClientID != '') {
        OPIPBilling.CheckClientCreditLimit(ClientID, GetResult);
    }
}
function GetResult(StatusAndAmount) {
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");

    if (StatusAndAmount != '') {
        var CreditStatus = StatusAndAmount.split('~')[0];
        var BalanceAmount = StatusAndAmount.split('~')[1];
        var objWarning = SListForAppMsg.Get("Scripts_CommonBiling_js_08") == null ? "Warning: Credit Limit have exceeded for this Client..!" : SListForAppMsg.Get("Scripts_CommonBiling_js_08");

        if (CreditStatus == 'Y') {
            //alert('Warning: Credit Limit have exceeded for this Client..!');
            ValidationWindow(objWarning, objAlert);

            document.getElementById('hdnIsMappedItem').value = "N";
            document.getElementById('txtClient').value = "";
            document.getElementById('hdnSelectedClientClientID').value = document.getElementById('hdnBaseClientID').value;
            document.getElementById('hdnRateID').value = document.getElementById('hdnBaseRateID').value;
            document.getElementById('hdnMappingClientID').value = -1;
            document.getElementById('hdnIsCashClient').value = "N";
            return false;
        }
        else {
            document.getElementById('hdnCashClient').value = CreditStatus;
        }
        document.getElementById('hdnClientBalanceAmount').value = BalanceAmount;
    }
}


function countQuickAge(id) {
    $('#txtDOBNos').val('');
    if (document.getElementById(id).value != '' && document.getElementById('txtDOBNos').value != "0" && document.getElementById('txtDOBNos').value != ".") {
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
                    //                    if (weeks <= 0) {
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
                    //}
                    //                    else {
                    //                        if (weeks == 1) {
                    //                            document.getElementById('txtDOBNos').value = weeks;
                    //                            document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                    //                        }
                    //                        else {
                    //                            document.getElementById('txtDOBNos').value = weeks;
                    //                            document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                    //                        }
                    //                    }
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

                    decimalAgeValue(agetemp, mm);
                    document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                }
                else {

                    decimalAgeValue(agetemp, mm);
                    document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                }
            }

            function lyear(a) {
                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
                else return false;
            }
            // document.getElementById('ddlSex').focus();
            if (document.getElementById('hdnDoFrmVisit').value == "") {
                document.getElementById('txtDOBNos').focus();
            }
            else {
                document.getElementById('ddlSex').focus();
            }
        }
        else {
            alert(main + ' Date');
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('tDOB').value = "";
            document.getElementById('tDOB').value = "";
            document.getElementById('tDOB').focus();
        }
    }
}

function getDOB() {
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");

    var objProvideAge = SListForAppMsg.Get("Scripts_CommonBiling_js_09") == null ? "Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list" : SListForAppMsg.Get("Scripts_CommonBiling_js_09");

    if (document.getElementById('txtDOBNos').value.trim() == '') {
        //alert('Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
        ValidationWindow(objProvideAge, objAlert);

        document.getElementById('txtDOBNos').focus();
        return false;
    }
    return true;
}
function resetpreviousradiodetails() {
    document.getElementById('billPart_txtTestName').value = '';
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
        if (boxValue < minNum || boxValue != minNum) {
        me.size = minNum
    }
    if (me.id = 'billPart_txtTestName') {
        document.getElementById('billPart_hdnID').value = 0;
        document.getElementById('billPart_hdnName').value = '';
    }
}
var IsMandatoryHis=false;
function AddBillingItemsDetails() {
    $("#hdnPhcInvID").val(hdnID + '~' + $("#billPart_txtTestName").val());
    document.getElementById('billPart_hdnID').value = hdnID;
    var FeeID1 = document.getElementById('billPart_hdnID').value;
    var FeeType1 = document.getElementById('billPart_hdnFeeTypeSelected').value;
    var arrGotValue = new Array();
    var batchString = new Array();
    if (document.getElementById('hdnDoFrmVisit').value != "") {
        if (document.getElementById('hdnDoFrmVisit').value <= "0") {
            if (document.getElementById('billPart_hdnValidation').value != 'N') {
                if (!GetDuplicateValidationonEntry(FeeID1, FeeType1)) {
                    return false;
                }
            }
        }
        if ((document.getElementById('hdnSelectedClientName').value != document.getElementById('txtClient').value) && (document.getElementById('hdnDefaultClienName').value != document.getElementById('txtClient').value)) {
            document.getElementById('hdnSelectedClientClientID').value = '';
        }
    }
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",        
    /*BEGIN | Bug ID[NA] | TAT |  | A |  TAT Integration  */
        //url: "../OPIPBilling.asmx/GetBillingItemsDetails",
        url: "../OPIPBilling.asmx/GetBillingTestItemsDetails",        
    /*END | Bug ID[NA] | TAT |  | A |  TAT Integration  */
        data: JSON.stringify({ OrgID: document.getElementById('billPart_hdnOrgIDC').value, FeeID: document.getElementById('billPart_hdnID').value, FeeType: document.getElementById('billPart_hdnFeeTypeSelected').value, Description: document.getElementById('billPart_txtTestName').value, ClientID: $('[id$="hdnSelectedClientClientID"]').val(), VisitID: 0, Remarks: '', IsCollected: document.getElementById('billPart_hdnIsCollected').value, CollectedDatetime: document.getElementById('billPart_hdnCollectedDateTime').value, locationName: document.getElementById('billPart_hdnLocName').value }),
        dataType: "json",
        async: false,
        success: function(data) {
            $('#billPart_hdnEnableHistoryTest').val('N');
            if (data.d.length > 0) {
                for (var i = 0; i < data.d.length; i++) {
                    arrGotValue = data.d[0].ProcedureName.split('^');
                    if (arrGotValue.length > 0) {
                        ID = arrGotValue[0];
                        name = arrGotValue[1].trim();
                        feeType = arrGotValue[2];
                        if (document.getElementById('billPart_txtVariableRate').value == "") {
                            amount = arrGotValue[3];
                        } else {
                            amount = document.getElementById('billPart_txtVariableRate').value;
                        }
                        if (document.getElementById('billPart_hdnpopuporgid').value == 'Y') {
                            var batchString = data.d[0].Descrip.split('~');
                            if (batchString.length > 0) {
                                if (batchString[1] == 'validityChk') {
                                    var batchValidation = SListForAppMsg.Get("Scripts_CommonBiling_js_BatchAlert") == null ? "Client Batch ID Validity expired" : SListForAppMsg.Get("Scripts_CommonBiling_js_BatchAlert");
                                    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_BatchAlert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_BatchAlert");
                                    ValidationWindow(batchValidation, objAlert);
                                    document.getElementById('billPart_txtTestName').value = "";
                                    return false;
                                }
                                else if (batchString[1] == 'CountChk') {
                                    var batchValidation = SListForAppMsg.Get("Scripts_CommonBiling_js_BatchAlert") == null ? "Client Registration Count exceeded" : SListForAppMsg.Get("Scripts_CommonBiling_js_BatchAlert");
                                    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_BatchAlert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_BatchAlert");
                                    ValidationWindow(batchValidation, objAlert);
                                    document.getElementById('billPart_txtTestName').value = "";
                                    return false;
                                }
                            }
                        }
                        Remarks = arrGotValue[5];
                        isReimursable = arrGotValue[6];
                        ReportDate = arrGotValue[7];
                        ActualAmount = arrGotValue[8];
						 //change by arun -- if client not having any Baserate Ratecard then the alert should be changed
                        if (document.getElementById('hdnAlrtBaseRateNotMappng').value == 'Y') {
                            var isbaseratecardavail = 'N';
                            isbaseratecardavail = amount.indexOf('Y') > -1 || amount.indexOf('N') > -1 ? amount.split(' ')[1] : 'N';
                            amount = amount.indexOf('Y') > -1 || amount.indexOf('N') > -1 ? amount.split(' ')[0] : amount;
                            if (isbaseratecardavail == 'N') {
                                alert("Base Ratecard was not Mapped to the Selected Client. Please Map the base Ratecard.");
                                return false;
                            }
                        }
                        else {
                            amount = amount.indexOf('Y') > -1 || amount.indexOf('N') > -1 ? amount.split(' ')[0] : amount;
                        }
                        //
                        if (parseFloat(ActualAmount) < parseFloat(amount) && document.getElementById('hdnAllowGreaterAmtfromMrp').value == 'N') {
                            alert("Test rate Should not be greater than General rate");
                            return false;
                        }
                        IsDiscountable = arrGotValue[9];
                        IsTaxable = arrGotValue[10];
                        IsRepeatable = arrGotValue[11];
                        IsSTAT = arrGotValue[12];
                        IsSMS = arrGotValue[13];
                        IsNABL = arrGotValue[14];
                        RateID = arrGotValue[15];
                        HasHistory = arrGotValue[16];
                        ProcessingLoc = arrGotValue[17];
                        BaseRateID = arrGotValue[19];
                        DiscountPolicyID = arrGotValue[20];
                        DiscountCategoryCode = arrGotValue[21];
                        ReportDeliveryDate = arrGotValue[22];
                        MaxDiscount = arrGotValue[23];
                        IsNormalRateCard = arrGotValue[24];
                        IsRedeem = arrGotValue[25];
                        RedeemAmount = arrGotValue[26];
                        IsHistoryMandatory = data.d[0].IsHistoryMandatory;
                        Ishtmltab = data.d[0].Ishtml;
                        IsTemplateID = data.d[0].TemplateID;
                        IsSpecialTest = data.d[0].IsSpecialTest;

                        //Seetha
                        IsEnableTestHistory = data.d[0].IsEnableTestHistory;
                        document.getElementById('billPart_hdnEnableHistoryTest').value = IsEnableTestHistory;

                        IsMandatoryHis = data.d[0].IsMandatoryHis;
                        document.getElementById('billPart_hdnIsMandatoryHis').value = IsMandatoryHis;
                        
                        //
                        //VEL
                        DisplayMRPAmt = arrGotValue[27];
                        document.getElementById('hdnMRPBillDisplay').value = DisplayMRPAmt;
                        //VEL
                       
              /*BEGIN | Bug ID[NA] | TAT |  | A |  TAT Integration  */
                        
                        
                        TATProcessDateType = data.d[i].TATProcessDateType;
                        Tatreferencedatetime = data.d[i].Tatreferencedatetime;
                        Tatsamplereceiptdatetime = data.d[i].Tatsamplereceiptdatetime;
                        Tatprocessstartdatetime = data.d[i].Tatprocessstartdatetime;          
                        Logistictimeinmins = data.d[i].Logistictimeinmins;
                        Processingtimeinmins = data.d[i].Processingtimeinmins;
                        Labendtime = data.d[i].Labendtime;
                        Earlyreporttime = data.d[i].Earlyreporttime;
                        Tatreferencedatebase = data.d[i].Tatreferencedatebase;
                      
                       document.getElementById('billPart_hdnTATProcessDateTime').value = Tatreferencedatetime;
                       document.getElementById('billPart_hdnTATSampleReceiptDateTime').value = Tatsamplereceiptdatetime;
                       document.getElementById('billPart_hdnTATProcessStartDateTime').value = Tatprocessstartdatetime; 
                        document.getElementById('billPart_hdnTATLogisticTimeasmins').value = Logistictimeinmins;
                        document.getElementById('billPart_hdnTATProcessinghoursasmins').value = Processingtimeinmins;
                        document.getElementById('billPart_hdnTATLabendTime').value = Labendtime;
                        document.getElementById('billPart_hdnTATEarlyReportTime').value = Earlyreporttime;
                        document.getElementById('billPart_hdnTatreferencedatebase').value = Tatreferencedatebase;
                        
                    
             /*END | Bug ID[NA] | TAT |  | A |  TAT Integration  */
                        
                        //prem
                        IsOutSource = document.getElementById('billPart_hdnIsOutSource').value;
                        outRInSourceLocation = document.getElementById('billPart_hdnoutsourcelocation').value;
                        document.getElementById('billPart_hdnID').value = ID;
                        document.getElementById('billPart_hdnName').value = name;
                        document.getElementById('billPart_hdnFeeTypeSelected').value = feeType;
                        document.getElementById('billPart_hdnAmt').value = amount;
                        document.getElementById('billPart_hdnRemarks').value = Remarks;
                        document.getElementById('billPart_hdnIsRemimbursable').value = isReimursable;
                        document.getElementById('billPart_hdnReportDate').value = ReportDate;
                        document.getElementById('billPart_hdnActualAmount').value = ActualAmount;
                        document.getElementById('billPart_hdnIsDiscountableTest').value = IsDiscountable;
                        document.getElementById('billPart_hdnIsTaxable').value = IsTaxable;
                        document.getElementById('billPart_hdnIsRepeatable').value = IsRepeatable;
                        document.getElementById('billPart_hdnIsSTAT').value = IsSTAT;
                        document.getElementById('billPart_hdnIsSMS').value = IsSMS;
                        document.getElementById('billPart_hdnIsNABL').value = IsNABL;
                        document.getElementById('billPart_hdnBillingItemRateID').value = RateID;
                        document.getElementById('billPart_hdnHasHistory').value = HasHistory;
                        document.getElementById('billPart_hdnIsHistoryMandatory').value = IsHistoryMandatory;
                        document.getElementById('billPart_hdnProcessingLoc').value = ProcessingLoc;
                        document.getElementById('billPart_hdnBaseRateID').value = BaseRateID;
                        document.getElementById('billPart_hdnDiscountPolicyID').value = DiscountPolicyID;
                        document.getElementById('billPart_hdnDiscountCategoryCode').value = DiscountCategoryCode;
                        document.getElementById('billPart_hdnDeliveryDate').value = ReportDeliveryDate;
                        document.getElementById('billPart_hdnMaxDiscount').value = MaxDiscount;
                        document.getElementById('billPart_hdnIsNormalRateCard').value = IsNormalRateCard;
                        document.getElementById('billPart_hdnIsRedeem').value = IsRedeem;
                        document.getElementById('billPart_hdnRedeemAmount').value = RedeemAmount;
                        document.getElementById('billPart_hdnIshtml').value = Ishtmltab;
                        document.getElementById('billPart_hdnIsTemplateID').value = IsTemplateID;
                        document.getElementById('billPart_hdnIsSpecialTest').value = IsSpecialTest;
                        //document.getElementById('billPart_btnAdd').disabled = false;
                        var FeeID = document.getElementById('billPart_hdnID').value;
                        var FeeType = document.getElementById('billPart_hdnFeeTypeSelected').value;
                        var Templatediv = $('#billPart_divtemplate').find('div[FeeID="' + FeeID + '"]');
                        if (Templatediv.length > 0) {
                            $(Templatediv).remove();
                        }
                        $('#billPart_divtemplate').append('<div FeeID="' + FeeID + '">' + data.d[0].IsTemplateText + '</div>');
                        DuplicateInv(FeeID, FeeType, IsSpecialTest);
                    }
                }
            }
            else {
                DuplicateInv(FeeID, FeeType, IsSpecialTest);
                //alert('Item Amount is Zero, you cannot add this item for billing');
                document.getElementById('billPart_txtTestName').value = '';
                document.getElementById('billPart_txtTestName').focus();
            }
            if (IsSpecialTest == "Y") {
                SpecFeeID = ID;     
                document.getElementById('billPart_hdnTestFeeID').value = ID;
                SpecFeetype = feeType;
                SpecFeeName = name;
                $('#divspectab').hide();
                $('#billPart_btnspec').click();
                $('#billPart_btnspec').show();
            }
            if ($('#billPart_hdnEnableHistoryTest').val() == "Y" && $('#billPart_hdnEnableHistoryTestConfig').val() == "Y" && $("#hdnPageType").val() != "DEOH") {
                $("#dialog1").empty();
                BindDynamicTestHistoryFields(FeeID, FeeType, name);

                BindInstructionMApping(FeeID, FeeType);
                
                $('#dialog1').dialog('open');
            }
        },
        error: function(result) {
            var objSelClient = SListForAppMsg.Get("Scripts_CommonBiling_js_10") == null ? "Select the ClientName From List" : SListForAppMsg.Get("Scripts_CommonBiling_js_10");
            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
            ValidationWindow(objSelClient, objAlert);

            //alert("Select the ClientName From List");
        }
    });
    if ($('#hdnConfigCapturehistory').val() == "Y") {
        var ar = [];
        ar.push(CallCapturePatientHistoryPattern());
        $.when.apply(this, ar).done(function() {
            DisplayPatten();
        });
    }
}
function CallBillItems(OrgID) {
    if (document.getElementById('hdnDoFrmVisit').value != '') {
        if (document.getElementById('hdnDOFromVisitFlag').value == "0") {
            //Added by Vijayalakshmi.M       
            if ($('#billPart_divItemTable tr').length > 0) {
                //if ($('#billPart_trOrderedItemsCount').length > 0) {                
                AdditionalDetails();
                // }
            }
            else {
                validateForClient();
                AdditionalDetails();
            }
        }
    }
    var FeeType = document.getElementById('billPart_hdnFeeType1').value;
    var ClientID = document.getElementById('hdnSelectedClientClientID').value;
    var Gender = document.getElementById('ddlSex').value;
    document.getElementById('hdnGender').value = Gender;
    var pVisitID = -1;
    var IsMapped = "N";
    IsMapped = (document.getElementById('hdnIsMappedItem').value == "" || document.getElementById('hdnIsMappedItem').value) == undefined ? "N" : document.getElementById('hdnIsMappedItem').value;
    var Remarks = "";
    sval = FeeType + '~' + ClientID + '~' + IsMapped + '~' + Remarks + '~' + Gender;
    if ($find('billPart_AutoCompleteExtender3') != null) {
        $find('billPart_AutoCompleteExtender3').set_contextKey(sval);
    }
}
function clearfn() {
    if (document.getElementById('billPart_txtTestName').value.length <= 0) {
        document.getElementById('billPart_hdnID').value = 0;
        document.getElementById('billPart_hdnName').value = '';
        document.getElementById('billPart_lblInvType').innerHTML = "";
        document.getElementById('billPart_hdnIsDiscountableTest').value = "Y";
        document.getElementById('billPart_hdnIsNABL').value = "Y";
        document.getElementById('billPart_hdnIsTaxable').value = "Y";
        document.getElementById('billPart_hdnIsRepeatable').value = "N";
        document.getElementById('billPart_hdnIsSTAT').value = "N";
        document.getElementById('billPart_hdnIsSMS').value = "N";
        document.getElementById('billPart_hdnIsOutSource').value = "N";
        document.getElementById('billPart_hdnoutsourcelocation').value = "";
        document.getElementById('billPart_hdnBillingItemRateID').value = "0";
        document.getElementById('billPart_hdnHasHistory').value = "N";
        document.getElementById('billPart_txtVariableRate').value = "";
        document.getElementById('billPart_txtVariableRate').style.display = 'none';
        document.getElementById('billPart_hdnDiscountPolicyID').value = "0";
        document.getElementById('billPart_hdnDiscountCategoryCode').value = "";
        document.getElementById('billPart_hdnDeliveryDate').value = "";
    }
}

function BillingItemSelected(source, eventArgs) {
    AutoCompSelected = true;
    var varGetVal = eventArgs.get_value();
    var arrGetVal = new Array();
    arrGetVal = varGetVal.split("^");
    document.getElementById('billPart_txtTestName').value = arrGetVal[1]
    //$('[id$="txtTestName"]').val(arrGetVal[1]);
    //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
    var ID;
    var name;
    var feeType;
    var amount;
    var IsDicountableTest;
    var IsRepeatable;
    var Code;
    var IsOutSource;
    var outRInSourceLocation;
    var list = eventArgs.get_value().split('^');
    if (list.length > 0) {
        if (list[i] != "") {
            ID = list[0];
            name = list[1].trim();
            feeType = list[2];
            Code = list[3];
            IsOutSource = list[4];
            outRInSourceLocation = list[5];
            document.getElementById('billPart_hdnID').value = ID;
            document.getElementById('billPart_hdnName').value = name;
            document.getElementById('billPart_hdnFeeTypeSelected').value = feeType;
            document.getElementById('billPart_hdnInvCode').value = Code;
            document.getElementById('billPart_hdnIsOutSource').value = IsOutSource;
            document.getElementById('billPart_hdnoutsourcelocation').value = outRInSourceLocation;
            hdnID = ID;
        }
    }
    else {
        document.getElementById('billPart_hdnID').value = -1;
        document.getElementById('billPart_hdnFeeTypeSelected').value = "OTH";
    }
    pageLoad();
    $find('billPart_AutoCompleteExtender3')._onMethodComplete = function(result, context) {
        $find('billPart_AutoCompleteExtender3')._update(context, result, /* cacheResults */false);
        webservice_callback(result, context);
    };
    var FeeItemArray = new Array();
    var listLen = document.getElementById('hdnPreviousVisitDetails').value.split('^').length;
    var flag = 0;
    var LabNo;
    if (document.getElementById('hdnDoFrmVisit') != null) {
        LabNo = $('#hdnDoFrmVisit').val();
    }
    if (Number(listLen) > 0) {
        var ItemArray = new Array();
        var res = new Array();
        ItemArray = document.getElementById('hdnPreviousVisitDetails').value.split('^');
        for (i = 0; i < ItemArray.length; i++) {
            res = ItemArray[i].split('$');
            /*Comented By Arivalagan.k Restricting existing ordered visit test*/
            //if (number(document.getelementbyid('billPart_hdnID').value) == res[1] && 'y' == res[5] && document.getelementbyid('billPart_hdnFeeTypeSelected').value == res[2]) {
            if (Number(document.getElementById('billPart_hdnID').value) == res[1] && LabNo == res[9] && document.getElementById('billPart_hdnFeeTypeSelected').value == res[2]) {
                flag = 1;
                break;
            }
        }
    }

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
    //if (flag == 1 && selectedText == "Today's Visit") {
    if (flag == 1 && searchtype != '3') {
        var objTestAlready = SListForAppMsg.Get("Scripts_CommonBiling_js_11") == null ? "This test already ordered ...! Not allow to add for this test" : SListForAppMsg.Get("Scripts_CommonBiling_js_11");
        objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
        /*******Code commented and  Modified by Arivalagan.k Bcoz to awoid duplicate entey ordered test*************/
        //alert('This test already ordered ...! Not allow to add for this test');-->Comment Localization
        ValidationWindow(objTestAlready, objAlert);
        flag = 0;

        //}
        //        else {
        document.getElementById('billPart_txtTestName').value = "";
        document.getElementById('billPart_hdnID').value = "";
        document.getElementById('billPart_hdnName').value = "";
        document.getElementById('billPart_hdnFeeTypeSelected').value = "";
        document.getElementById('billPart_hdnInvCode').value = "";
        document.getElementById('billPart_hdnIsOutSource').value = "N";
        document.getElementById('billPart_hdnoutsourcelocation').value = "";
        document.getElementById('billPart_txtTestName').focus();
        //        }

    }
    else if (flag == 1 && selectedText == 'New Visit') {
        var objWarningSel = SListForAppMsg.Get("Scripts_CommonBiling_js_12") == null ? "Warning: The selected test already ordered today...!  Do you want to continue?" : SListForAppMsg.Get("Scripts_CommonBiling_js_12");

        //        if (window.confirm("Warning: The selected test already ordered today...!  Do you want to continue?")) {
        if (window.confirm(objWarningSel)) {
            flag = 0;
        }
        else {
            document.getElementById('billPart_txtTestName').value = "";
            document.getElementById('billPart_hdnID').value = "";
            document.getElementById('billPart_hdnName').value = "";
            document.getElementById('billPart_hdnFeeTypeSelected').value = "";
            document.getElementById('billPart_hdnInvCode').value = "";
            document.getElementById('billPart_hdnIsOutSource').value = "N";
            document.getElementById('billPart_hdnoutsourcelocation').value = "";
            document.getElementById('billPart_txtTestName').focus();
        }
    }
    document.getElementById('billPart_btnAdd').focus();
    //    if (flag == 0) {
    //        AddBillingItemsDetails();
    //    }
    /*******End Code commented and  Modified by Arivalagan.k Bcoz to awoid duplicate entey ordered test*************/
}


function InvPopulated(sender, e) {

    var behavior = $find('billPart_AutoCompleteExtender3');
    var target = behavior.get_completionList();
    for (i = 0; i < target.childNodes.length; i++) {
        var text = target.childNodes[i]._value;
        var ItemArray;
        ItemArray = text.split('^');
        if (ItemArray[4].trim().toLowerCase() == 'y') {
            // target.childNodes[i].className = "focus"
        }
        if (ItemArray[2].trim().toLowerCase() == 'inv') {
            // target.childNodes[i].className = "focus"

            target.childNodes[i].style.color = "Black";
            //target.childNodes[i].style.fontcolor('Orange');
        }
        else if (ItemArray[2].trim().toLowerCase() == 'pkg') {
            target.childNodes[i].style.color = "blue";

        }
        else {

            target.childNodes[i].style.color = "MediumVioletRed";
            //target.childNodes[i].style.fontcolor('red');
        }

    }
}

function InvPopulated_old(source, eventArgs) {

    var behavior = $find('AutoCompleteExtender3');

    var target = behavior.get_completionList();

    var i;
    for (i = 0; i < target.childNodes.length; i++) {

        var arrOutSourceInvestigaions = new Array();
        arrOutSourceInvestigaions = document.getElementById('hdnOutSourceInvestigations').value.split('~');

        for (var j = 0; j < arrOutSourceInvestigaions.length; j++) {
            var strInv = arrOutSourceInvestigaions[j];
            if (strInv.trim().toLowerCase() == target.childNodes[i].innerHTML.trim().toLowerCase()) {
                //target.childNodes[i].innerHTML = "<div style='background-color:Orange; color:Black;'>" + target.childNodes[i].innerHTML + "</div>";
                target.childNodes[i].className = "OutSource .boxOutSource"
            }
        }
    }
}
function expandTextBox(id) {

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
function AssignClientPage() {

    document.getElementById('billPart_hdnIsClientBilling').value = "Y";
}

function GetDuplicateValidationonEntry(Obj1, obj2) {

    var Name = document.getElementById('txtName').value;
    var Age = document.getElementById('txtDOBNos').value + " " + document.getElementById('ddlDOBDWMY').value;
    var ClientID = document.getElementById('hdnSelectedClientClientID').value;
    if (Obj1 != null && Obj1 != undefined) {

        var ID = Obj1;
    }
    else {
        var ID = 0;
    }
    if (obj2 != null && obj2 != undefined) {
        var Type = obj2;
    }
    else {
        var Type = "";
    }
    var Validation = "";
    var registerdDate = "";

    var prefixText = "";
    var _Validation = 0;
    //var contextKey = document.getElementById('hdnorgIDCl').value + '~' + 'LogisticsZone' + '~' + document.getElementById('hdnZoneID').value;
    if (document.getElementById('txtDOBNos').value != "") {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetDuplicateValidationonEntry",
            data: "{ 'pOrgID': '" + document.getElementById('hdnorgIDCl').value + "','Name': '" + Name + "','Age': '"
             + Age + "','ClientID': '" + ClientID + "','registerdDate': '"
                 + registerdDate + "','ID': '"
                 + ID + "','type': '"
                 + Type + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                Items = data.d[0];
                if (Items != undefined) {
                    _Validation = 1;

                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });


        if (_Validation == 1) {
            var objvar1 = SListForAppMsg.Get("Scripts_CommonBiling_js_13") == null ? "Patient with Same Name,age,Client with Same Tests are Already entered Do You Want to continue ?" : SListForAppMsg.Get("Scripts_CommonBiling_js_13");

            //window.confirm('Patient with Same Name and Age are Already entered ?');
            if (!window.confirm(objvar1)) {
                document.getElementById('billPart_hdnValidation').value = 'N';
                //  Validation = 0;
                return false;
            }
            else {
                document.getElementById('billPart_hdnValidation').value = 'N';
                //Validation = 0;
                return true;
            }
        }
        else if (_Validation == 0) {
            return true;

        }
    }
    else {
        return true;
    }

}

function AddItems() {



    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    // For Co-Payment //
    //debugger;
    var BToBhdnCopay

    if (document.getElementById('HdnCoPay') != null) {
        BToBhdnCopay = document.getElementById('HdnCoPay').value;
    }
    else {
        BToBhdnCopay = 'N';
    }
    var TotalcardAmt = 0.00;
    var sds = $('#cardPoints tr');
    $('#cardPoints tr').each(function(i, n) {
        if (i == 0) {
        }
        else {
            var $row = $(n);
            var lblCardAmt = $row.find($('span[id$="lblCardAmt"]')).html();
            if (typeof (lblCardAmt) === "undefined") {
            }
            else {
                TotalcardAmt = TotalcardAmt + parseFloat(lblCardAmt);

            }
        }
    });
    $("#billPart_hdnTotalRedeemPoints").val(TotalcardAmt.toFixed(2));
    $("#billPart_hdnTotalRedeemAmount").val(TotalcardAmt.toFixed(2));
    $("#billPart_hdntotalredemPoints").val(TotalcardAmt.toFixed(2));


    $('#billPart_txtRedeem').val(TotalcardAmt.toFixed(2));
    $('#billPart_hdnRedeemValue').val(TotalcardAmt.toFixed(2));
    $('#billPart_hdnRedeemPoints').val(TotalcardAmt.toFixed(2));
    if (BToBhdnCopay == 'Y') {
        var objCoPayType = SListForAppMsg.Get("Scripts_CommonBiling_js_14") == null ? "Select Co-Payment type" : SListForAppMsg.Get("Scripts_CommonBiling_js_14");
        var objCoPayvalue = SListForAppMsg.Get("Scripts_CommonBiling_js_15") == null ? "Enter Co-Payment Value" : SListForAppMsg.Get("Scripts_CommonBiling_js_15");

        var ddlCopaymentType = document.getElementById('uctlClientTpa_ddlCopaymentType').value;
        var txtCoperent = parseFloat(document.getElementById('uctlClientTpa_txtCoperent').value);
        //if (document.getElementById('HdnCoPay').value == 'Y') {
        if (ddlCopaymentType == 0) {
            //alert('Select Co-Payment type');
            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
//            ValidationWindow(objCoPayType, objAlert);
            //            document.getElementById('uctlClientTpa_ddlCopaymentType').focus();

            CommonControlFocus = "#uctlClientTpa_ddlCopaymentType";
            ValidationWindowResponse(objCoPayType, objAlert, FocusControlAfterValidationWindowResponse);
            return false;
        }
        if (txtCoperent < 0.00) {
            //alert('Enter Co-Payment Value');
            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
//            ValidationWindow(objCoPayvalue, objAlert);
            //            document.getElementById('uctlClientTpa_txtCoperent').focus();

            CommonControlFocus = "#uctlClientTpa_txtCoperent";
            ValidationWindowResponse(objCoPayvalue, objAlert, FocusControlAfterValidationWindowResponse);
            return false;
        }
        //}
    }


    if ($('#hdnlabnumber').val() == 'Y')
    {

    var objLabNumber = SListForAppMsg.Get("Scripts_CommonBiling_js_57") == null ? "Provide Lab Number" : SListForAppMsg.Get("Scripts_CommonBiling_js_57");
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    // For Co-Payment  end//
    if ($('#txtlabnumber').val() != undefined && $.trim($('#txtlabnumber').val()) == '') {
        // alert('Provide patient name');

        //        ValidationWindow(objPatName, objAlert);
        //        $('#txtName').focus();
        CommonControlFocus = "#txtlabnumber";
        ValidationWindowResponse(objLabNumber, objAlert, FocusControlAfterValidationWindowResponse);
        return false;
    }
    if ($('#txtExternalVisitID').val() != undefined && $.trim($('#txtExternalVisitID').val()) == '') {
        // alert('Provide patient name');

        //        ValidationWindow(objPatName, objAlert);
        //        $('#txtName').focus();
        CommonControlFocus = "#txtExternalVisitID";
        ValidationWindowResponse(objLabNumber, objAlert, FocusControlAfterValidationWindowResponse);
        return false;
    }
    }
    var objPatName = SListForAppMsg.Get("Scripts_CommonBiling_js_16") == null ? "Provide patient name" : SListForAppMsg.Get("Scripts_CommonBiling_js_16");
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    // For Co-Payment  end//
    if ($('#txtName').val() != undefined && $.trim($('#txtName').val()) == '') {
        // alert('Provide patient name');
        
//        ValidationWindow(objPatName, objAlert);
        //        $('#txtName').focus();
        CommonControlFocus = "#txtName";
        ValidationWindowResponse(objPatName, objAlert, FocusControlAfterValidationWindowResponse);
        return false;
    }
    var objExvisitID = SListForAppMsg.Get("Scripts_CommonBiling_js_17") == null ? "Provide External VisitID" : SListForAppMsg.Get("Scripts_CommonBiling_js_17");
     objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    if ($('#txtExternalVisitID').val() != undefined && $.trim($('#txtExternalVisitID').val()) == '') {
        //alert('Provide External VisitID');
//        ValidationWindow(objExvisitID, objAlert);
        //        $('#txtExternalVisitID').focus();

        CommonControlFocus = "#txtExternalVisitID";
        ValidationWindowResponse(objExvisitID, objAlert, FocusControlAfterValidationWindowResponse);
        return false;
    }
    if (document.getElementById('HdnPhleboNameMandatory') != null) {
        if (document.getElementById('HdnPhleboNameMandatory').value != 'N') {
        var objPhlebotomistNameList = SListForAppMsg.Get("Scripts_CommonBiling_js_18") == null ? "Please select Phlebotomist Name from list" : SListForAppMsg.Get("Scripts_CommonBiling_js_18");
         objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
            if ($('#txtPhleboName').val() != "" && document.getElementById('HdnPhleboID').value == "") {
            //alert('Please select Phlebotomist Name from list');
//            ValidationWindow(objPhlebotomistNameList, objAlert);
                $('#txtPhleboName').val("");
                //                document.getElementById('txtPhleboName').focus();
                CommonControlFocus = "#txtPhleboName";
                ValidationWindowResponse(objPhlebotomistNameList, objAlert, FocusControlAfterValidationWindowResponse);
                

                return false;
            }
            if (document.getElementById('HdnPhleboID').value == "" && $("#hdnPageType").val() == "B2C") {
            var objPhlebotomistName = SListForAppMsg.Get("Scripts_CommonBiling_js_19") == null ? "Please select Phlebotomist Name" : SListForAppMsg.Get("Scripts_CommonBiling_js_19");
            //alert('Please select Phlebotomist Name');
//            ValidationWindow(objPhlebotomistName, objAlert);
                $('#txtPhleboName').val("");
//                document.getElementById('txtPhleboName').focus();

                CommonControlFocus = "#txtPhleboName";
                ValidationWindowResponse(objPhlebotomistName, objAlert, FocusControlAfterValidationWindowResponse);
                
                return false;
            }
        }
    }
    var objProvidedob = SListForAppMsg.Get("Scripts_CommonBiling_js_20") == null ? "Provide patient age or date of birth" : SListForAppMsg.Get("Scripts_CommonBiling_js_20");
    var objSelectPat = SListForAppMsg.Get("Scripts_CommonBiling_js_21") == null ? "Select patient sex" : SListForAppMsg.Get("Scripts_CommonBiling_js_21");
    if (document.getElementById('hdnDoFrmVisit').value != "") {
        if (document.getElementById('hdnDOFromVisitFlag').value == "0") {
            if (document.getElementById('chkIncomplete').checked != true) {
                if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy')) {
                    //alert('Provide patient age or date of birth');
                     objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
//                    ValidationWindow(objProvidedob, objAlert);
                     //                    document.getElementById('txtDOBNos').focus();


                     CommonControlFocus = "#txtDOBNos";
                     ValidationWindowResponse(objProvidedob, objAlert, FocusControlAfterValidationWindowResponse);
                     
                    return false;
                }
                if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
                    if (document.getElementById('ddlSex').disabled != true) {
                        //alert('Select patient sex');
                         objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
//                        ValidationWindow(objSelectPat, objAlert);
                         //                        document.getElementById('ddlSex').focus();

                         CommonControlFocus = "#ddlSex";
                         ValidationWindowResponse(objSelectPat, objAlert, FocusControlAfterValidationWindowResponse);
                        return false;
                    }
                }
            }
        }
    }
    else {
        if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy') && document.getElementById('chkIncomplete').checked == false) {
            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
            //alert('Provide patient age or date of birth');
            ValidationWindow(objProvidedob, objAlert);
            document.getElementById('txtDOBNos').focus();
            return false;
        }
        if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0")  {
            if (document.getElementById('ddlSex').disabled != true) {
                //alert('Select patient sex');
                ValidationWindow(objSelectPat, objAlert);
                document.getElementById('ddlSex').focus();
                return false;
            }
        }
    }

 var objEmailNeed = SListForAppMsg.Get("Scripts_CommonBiling_js_60") == null ? "Please Provide a Email" : SListForAppMsg.Get("Scripts_CommonBiling_js_60");
    if ($('#hdnEmailNeed').val() == 'Y') {
        if (document.getElementById('txtEmail').value == '') {
            ValidationWindow(objEmailNeed, objAlert);
            document.getElementById('txtEmail').focus();
            return false;
        }
    }
    
    var objRefphyNeed = SListForAppMsg.Get("Scripts_CommonBiling_js_59") == null ? "Provide Physician Name" : SListForAppMsg.Get("Scripts_CommonBiling_js_59");
    if ($('#hdnRefPhyNeed').val() == 'Y') {
        if (document.getElementById('txtInternalExternalPhysician').value == '') {
            ValidationWindow(objRefphyNeed, objAlert);
            document.getElementById('txtInternalExternalPhysician').focus();
            return false;
        }
    }
    //    //Uncommented by vijayalakshmi.M
    //    if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '') {
    //      alert('Provide contact mobile or telephone number');
    //    $('#txtMobileNumber').focus();
    //     return false;
    // }

    var objSelClientName = SListForAppMsg.Get("Scripts_CommonBiling_js_22") == null ? "Select Phlebetomist Name" : SListForAppMsg.Get("Scripts_CommonBiling_js_22");
    var objClientName = SListForAppMsg.Get("Scripts_CommonBiling_js_23") == null ? "Provide Client Name" : SListForAppMsg.Get("Scripts_CommonBiling_js_23");
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    if (document.getElementById('HdnPhleboNameMandatory') != null) {
        if (document.getElementById('HdnPhleboNameMandatory').value != 'N') {
            if (document.getElementById('hdnDoFrmVisit').value == "") {
                if (document.getElementById('txtPhleboName') != null) {
                    if (document.getElementById('txtPhleboName').value.trim() == "") {
                        //alert('Select Phlebetomist Name');
                        ValidationWindow(objSelClientName, objAlert);
                        document.getElementById('txtPhleboName').focus();
                        return false;
                    }
                }
            }
        }
    }
    if (document.getElementById('txtClient').value == '') {
        if (document.getElementById('billPart_hdnIsClientBilling').value == 'Y' && document.getElementById('chkIncomplete').checked != true) {
            //alert('Provide Client Name');
            ValidationWindow(objClientName, objAlert);
            document.getElementById('txtClient').focus();
            return false;
        }
    }
    else {
    }
    //changes by arun
    if ($('#hdnConfigTRFMandatory').val() == "Y") {
        var istrfavail = uploadtrfvalidation();
        if (!istrfavail) {
            return istrfavail;
        }
    }
  
    //
   // debugger;
    var objTestName = SListForAppMsg.Get("Scripts_CommonBiling_js_24") == null ? "Search test names" : SListForAppMsg.Get("Scripts_CommonBiling_js_24");
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    var IsCopayClient = 'N';
    if (document.getElementById('HdnCoPay') != null) {
        IsCopayClient = document.getElementById('HdnCoPay').value;
    }
    if (document.getElementById('hdnIsCashClient') != null) {
        if (document.getElementById('hdnIsCashClient').value == "N" && IsCopayClient == "N" && document.getElementById('hdncollectcashforcreditclient').value!="Y") {
            document.getElementById('billPart_PaymentType_txtAmount').disabled = true;
        }
        else {
            document.getElementById('billPart_PaymentType_txtAmount').disabled = false;
        }
    }
    if (document.getElementById('billPart_txtTestName').value.trim() == "") {
        // alert('Search test names')
        ValidationWindow(objTestName, objAlert);
        document.getElementById('billPart_txtTestName').focus();
        return false;
    }
    //    else if (document.getElementById('txtClient').value == '') {
    //        alert('Provide Client Name');
    //        document.getElementById('txtClient').focus();
    //        return false;
    //    }

    else {

        document.getElementById('billPart_hdnDiscountPolicyID').value = "0";
        document.getElementById('billPart_hdnDiscountCategoryCode').value = "";

        AddBillingItemsDetails();

        //By Dhanaselvam To check test name selected from Autocompleted
        

        AutoCompSelected = false;

        //
        //  document.getElementById('billPart_txtVariableRate').value = "";
        document.getElementById('billPart_txtVariableRate').style.display = 'none';

    }
    var KeySlabDiscount = document.getElementById('billPart_hdnIsSlabDiscount').value;
    var ddDiscountPercent = document.getElementById('billPart_ddDiscountPercent').value;
    if (KeySlabDiscount == 'Y' && ddDiscountPercent == 0) {
        //      if (KeySlabDiscount == 'Y'  ) {
        document.getElementById('billPart_ddDiscountPercent').value = "0";
        document.getElementById('billPart_ddlDiscountType').value = "0";
        document.getElementById('billPart_ddlDiscountReason').value = "0";
        document.getElementById('billPart_trCeiling').value = "";
        document.getElementById('billPart_txtAuthorised').value = "";
        document.getElementById('billPart_txtDiscount').value = 0.00;
        document.getElementById("billPart_trDiscountType").style.display = 'none';
        document.getElementById("billPart_trSlab").style.display = 'none';
        document.getElementById("billPart_trCeiling").style.display = 'none';
    }
    //VEL
    if (document.getElementById('hdnMRPBillDisplay').value == "Y") {
        document.getElementById('billPart_tdDue').style.display = "none";
        document.getElementById('billPart_tdNetAmount').style.display = "none";
        document.getElementById('billPart_tdGross').style.display = "none";
        document.getElementById('billPart_tdMRPDue').style.display = "block";
        document.getElementById('billPart_tdMRPNetAmount').style.display = "block";
        document.getElementById('billPart_tdMRPGross').style.display = "block";
    }
    //VEL
    return false;

}
//changes by arun
function uploadtrfvalidation() {
    //changes by arun
    //$('#FileUpload1_wrap_list > div').length
    var objUploadLst = SListForAppMsg.Get("Scripts_CommonBiling_js_61") == null ? "Upload TRF files" : SListForAppMsg.Get("Scripts_CommonBiling_js_61");
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    // For Co-Payment  end//
    var trfuploadlist = $('#FileUpload1_wrap_list > div') != undefined && $('#FileUpload1_wrap_list > div') != null &&
                        $('#FileUpload1_wrap_list > div') != "" && $('#FileUpload1_wrap_list > div').length > 0 ? "avail" : "";
   // debugger;
    var url = window.location.href;
    var indexavail =false;
    if (url.indexOf('PID') > -1 && url.indexOf('PID') > -1 && url.indexOf('PNAME') > -1) {
        indexavail = true;
    }
    if (trfuploadlist == "avail" || found == true || indexavail == true) {
        return true;
    }
    else {
		 //cahnges by arun - without trf billing should be restrict
        if (found == false) {
           // $('#ChkTRFImage').attr("disabled", "disabled");
            $('#ChkTRFImage').attr("disabled", false);
			$('#FileUpload1').attr("disabled", false);
        }
        //
        CommonControlFocus = "#ChkTRFImage";
        //        CommonControlFocus = "#FileUpload1_wrap_list";
        //        CommonControlFocus = "#FileUpload1";
        ValidationWindowResponse(objUploadLst, objAlert, FocusControlAfterValidationWindowResponse);
        return false;   
    }
    //
}
//
var defaultbillflag = 0;
function CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsNormalRateCard, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID, DiscountCategoryCode, ReportDeliveryDate, MaxDiscount, IsRedeem, RedeemAmount,IsSpecialTest, Ishtmltab, IsTemplateID) {
    if (IsSpecialTest == null || IsSpecialTest == '') {
        IsSpecialTest = 'N';
    }
    var IsMandatoryHis=document.getElementById('billPart_hdnIsMandatoryHis').value ;
    if (document.getElementById('txtClient').value.trim() == '' && document.getElementById('hdnDefaultOrgBillingItems').value != '' && defaultbillflag == 0) {
        defaultbillflag = 1;
        var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
        //        FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
        //                + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8] + "~IsDiscountable^" + defalutdata[9]
        //                + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + defalutdata[14] + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + document.getElementById('hdnRateID').value + "~Code^" + defalutdata[16] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + "N" + "~BaseRateID^" + 0 + "~DiscountPolicyID^" + 0 + "~DiscountCategoryCode^" + '' + "~ReportDeliveryDate^" + '' + "~MaxDiscount^" + '' + "~IsNormalRateCard^" + '' + "~IsRedeem^" + '' + "~RedeemAmount^" + '' + "|";

        FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
                + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] +
				"~ActualAmount^" + defalutdata[8]
				+ "~IsNormalRateCard^" + ''
				+ "~IsDiscountable^" + defalutdata[9]
                + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" +
				defalutdata[13] + "~IsOutSource^" + defalutdata[14] + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" +
				document.getElementById('hdnRateID').value + "~Code^" + defalutdata[16] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + "N" +
				"~BaseRateID^" + 0 + "~DiscountPolicyID^" + 0 + "~DiscountCategoryCode^" + '' + "~ReportDeliveryDate^" + '' + "~MaxDiscount^" + ''
				 + '' + "~IsRedeem^" + '' + "~RedeemAmount^" + '' + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "~IsMandatoryHis^" + IsMandatoryHis+ "|";
        document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;

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
                if (FeeID == tempFeeID && FeeType == tempFeeType && Descrip == tempDescrip) {
                    iPaymentAlreadyPresent = 1;
                }
            }
        }

    }


    if (iPaymentAlreadyPresent == 0) {
        FeeViewStateValue = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^"
                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsRI + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable
                + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID+ "~IsMandatoryHis^" + IsMandatoryHis+"|" + FeeViewStateValue;

        document.getElementById('billPart_hdfBillType1').value = FeeViewStateValue;

        CreateBillItemsTable(0);
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
    else if (iPaymentAlreadyPresent == 0 && queryStringColl != null) {

        FeeViewStateValue = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^"
                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsRI + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable
		//arun prasad --22/10/2020-- can't remove the test in b2b when search the patient details
		+ "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "~IsMandatoryHis^" + IsMandatoryHis + +"|" + FeeViewStateValue;

        document.getElementById('billPart_hdfBillType1').value = FeeViewStateValue;
        CreateBillItemsTable(0);

    }
    else {
        var objItem = SListForAppMsg.Get("Scripts_CommonBiling_js_25") == null ? "Item already added" : SListForAppMsg.Get("Scripts_CommonBiling_js_25");
        ValidationWindow(objItem, objAlert);
        //alert("Item already added");
        ClearSelectedData(0);
        return false;
    }

}
function chkChange(value, objid) {
    //    btnDeleteBillingItems_OnClick1(value);
    var IsSpecialTest = '';
    var PaymentAAlreadyPresent = new Array();
    var iPaymentAlreadyPresent = 0;
    var iPaymentCount = 0;
    var FeeViewStateValue = '';
    var viewsstatevalie;
    var PaymenttempDatas = document.getElementById('billPart_hdfBillType1').value;
    var istat;
    if (document.getElementById(objid).checked) {
        istat = 'Y';

    }
    else {
        istat = 'N';
    }
    PaymentAAlreadyPresent = PaymenttempDatas.split('|');
    if (PaymentAAlreadyPresent.length > 0) {
        for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length - 1; iPaymentCount++) {
            if (PaymentAAlreadyPresent[iPaymentCount].toLowerCase() != value.toLowerCase()) {

                FeeViewStateValue += PaymentAAlreadyPresent[iPaymentCount] + "|";

            }
        }
    }



    document.getElementById('billPart_hdfBillType1').value = '';

    var arrayMainData = new Array();
    var arraySubData = new Array();
    var arrayChildData = new Array();
    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID, DiscountCategoryCode, ReportDeliveryDate, IsRedeem, RedeemAmount;
    var GrossAmt = 0;
    var DiscountableTestAmount = 0;
    var TaxableTestAmount = 0;
    var sno = 1;
    var IsInvestigationAdded = 0;

    arrayMainData = value.split('~');
    for (iMain = 0; iMain < arrayMainData.length; iMain++) {
        arrayChildData = arrayMainData[iMain].split('^');
        if (arrayChildData.length > 0) {
            if (arrayChildData[0] == "FeeID") {
                FeeID = arrayChildData[1];
                document.getElementById('billPart_hdnInvHistory').value += FeeID + "~";
            }
            if (arrayChildData[0] == "FeeType") {
                FeeType = arrayChildData[1];
                if (FeeType == 'INV' || FeeType == 'GRP' || FeeType == 'PKG') {
                    IsInvestigationAdded = IsInvestigationAdded + 1;
                }
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
            if (arrayChildData[0] == "ActualAmount") {
                ActualAmount = arrayChildData[1];
            }
            if (arrayChildData[0] == "IsNormalRateCard") {
                IsNormalRateCard = arrayChildData[1];
            }
            if (arrayChildData[0] == "IsDiscountable") {
                IsDiscountable = arrayChildData[1];
                if (IsDiscountable == "Y" && IsNormalRateCard == "Y")
                    DiscountableTestAmount = Number(DiscountableTestAmount) + Number(Amount);
            }
            if (arrayChildData[0] == "IsTaxable") {
                IsTaxable = arrayChildData[1];
                if (IsTaxable == "Y")
                    TaxableTestAmount = Number(TaxableTestAmount) + Number(Amount);
            }
            if (arrayChildData[0] == "IsRepeatable") {
                IsRepeatable = arrayChildData[1];
            }
            if (arrayChildData[0] == "IsSTAT") {
                IsSTAT = istat;
            }
            if (arrayChildData[0] == "IsSMS") {
                IsSMS = arrayChildData[1];
            }
            if (arrayChildData[0] == "IsOutSource") {
                IsOutSource = arrayChildData[1];
            }
            if (arrayChildData[0] == "IsNABL") {
                IsNABL = arrayChildData[1];
            }
            if (arrayChildData[0] == "BillingItemRateID") {
                BillingItemRateID = arrayChildData[1];
                //BillingItemRateID = document.getElementById('hdnRateID').value;
            }
            if (arrayChildData[0] == "Code") {
                Code = arrayChildData[1];
            }
            if (arrayChildData[0] == "HasHistory") {
                HasHistory = arrayChildData[1];
                if (HasHistory == "Y")
                    HasHistoryflag = 1;

            }
            if (arrayChildData[0] == "outRInSourceLocation") {
                outRInSourceLocation = arrayChildData[1];
            }

            if (arrayChildData[0] == "BaseRateID") {
                BaseRateID = arrayChildData[1];
            }

            if (arrayChildData[0] == "DiscountPolicyID") {
                DiscountPolicyID = arrayChildData[1];
            }
            if (arrayChildData[0] == "DiscountCategoryCode") {
                DiscountCategoryCode = arrayChildData[1];
            }
            if (arrayChildData[0] == "ReportDeliveryDate") {
                ReportDeliveryDate = arrayChildData[1];
            }
            if (arrayChildData[0] == "MaxDiscount") {
                MaxDiscount = arrayChildData[1];
            }
            if (arrayChildData[0] == "IsRedeem") {
                IsRedeem = arrayChildData[1];
            }
            if (arrayChildData[0] == "RedeemAmount") {
                RedeemAmount = arrayChildData[1];
            }
             if (arrayChildData[0] == "Ishtmltab") {
                Ishtmltab = arrayChildData[1];
            }
            if (arrayChildData[0] == "IsTemplateID") {
                IsTemplateID = arrayChildData[1];
            }
            if (arrayChildData[0] == "IsSpecialTest") {
                if (arrayChildData[1] != "") {
                    IsSpecialTest = arrayChildData[1];
                }
                else {
                    IsSpecialTest = "N";
                }
            }
        }



    }
//arun prasad -- 22/10/2020 -- can't remove the test in b2b when search the patient details
    var IsMandatoryHis1 = document.getElementById('billPart_hdnIsMandatoryHis').value;
    //
    var lstInvestigations = FeeViewStateValue != null && FeeViewStateValue != undefined ? FeeViewStateValue.split('|') : [];
    
    var overallInvestigations = "";
    viewsstatevalie = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^"
                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable +
                "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable
                + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^"
                + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory +
                "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID +
                "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount +
                "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab +
                "~IsTemplateID^" + IsTemplateID + "~IsMandatoryHis^" + IsMandatoryHis1;
    //arun avoid duplicate investigation list while IsStat checkbox is checked// + FeeViewStateValue;
    //debugger;
    if (lstInvestigations != null && lstInvestigations != undefined && lstInvestigations.length > 0) {
        var finddata = "~Descrip^" + Descrip + "~Amount^";
        for (var f = 0; f <= lstInvestigations.length-1; f++) {
            var checkdata = lstInvestigations[f];
            if (checkdata != null && checkdata != "" && checkdata != undefined) {
                if (checkdata.includes(finddata)) {
                    overallInvestigations = overallInvestigations != "" && overallInvestigations != null && overallInvestigations != undefined ? 
                                    overallInvestigations.concat("|" + viewsstatevalie) : viewsstatevalie;
                }
                else {
                    overallInvestigations =overallInvestigations != "" && overallInvestigations != null && overallInvestigations != undefined ?
                             overallInvestigations.concat("|" + checkdata) : checkdata;
                }
            }
        }
    }
    //debugger;
    document.getElementById('billPart_hdfBillType1').value = overallInvestigations + "|";
    //arun avoid duplicate investigation list while IsStat checkbox is checked
   // document.getElementById('billPart_hdfBillType1').value = viewsstatevalie
    CreateBillItemsTable(1)




}
function CreateBillItemsTable(id) {
    var HasHistoryflag = 0;
    document.getElementById('billPart_hdnCapture').value = 0;
    document.getElementById('billPart_divItemTable').innerHTML = "";
    var newPaymentTables, startPaymentTag, endPaymentTag;
    var FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;
    var ItemLevel = document.getElementById('billPart_hdnItems');
    var ItemLevelHealthCard = document.getElementById('billPart_hdnHealthCardItems');
    var TempString = document.getElementById('billPart_hdnCpedit').value;
    //    document.getElementById('billPart_ddlSlab').selectedIndex = 0;
    //    document.getElementById('billPart_txtCeiling').value = 0;
    document.getElementById('billPart_hdnItems').value = "";
    document.getElementById('billPart_hdnItemsNoDiscount').value = "";
    document.getElementById('billPart_hdnHealthCardItems').value = "";
    var popuporgidform = document.getElementById('billPart_hdnpopuporgid').value;
    var popuporgid = 'display:table-cell';
    if (popuporgidform == "N" || popuporgidform == "") {
        popuporgid = 'display:none';
    }
    
    var Tempdisplay = 'display:table-cell';
    if (TempString == "Y") {
        Tempdisplay = 'display:none';
    }
    var RedeemDisplay = 'display :table-cell';
    if ($("#billPart_hdnIsCashClient").val() == "N") {
        RedeemDisplay = 'display :none';
    }
// Seetha 


var Testhistoryconfig = document.getElementById('billPart_hdnEnableHistoryTestConfig').value;
var testhistorystyle = 'display:none';
if (Testhistoryconfig == "Y" && $("#hdnPageType").val() != "DEOH")
{
testhistorystyle = 'display:table-cell';
}
//
    var vFeeID = SListForAppDisplay.Get("Billing_CommonBilling_js_01") == null ? "FeeID" : SListForAppDisplay.Get("Billing_CommonBilling_js_01");
    var vFeeType = SListForAppDisplay.Get("Billing_CommonBilling_js_02") == null ? "FeeType" : SListForAppDisplay.Get("Billing_CommonBilling_js_02");
    var vS = SListForAppDisplay.Get("Billing_CommonBilling_js_03") == null ? "S.No" : SListForAppDisplay.Get("Billing_CommonBilling_js_03");
    var vCode = SListForAppDisplay.Get("Billing_CommonBilling_js_04") == null ? "Code" : SListForAppDisplay.Get("Billing_CommonBilling_js_04");
    var vDescription = SListForAppDisplay.Get("Billing_CommonBilling_js_05") == null ? "Description" : SListForAppDisplay.Get("Billing_CommonBilling_js_05");
    var vIsSTAT = SListForAppDisplay.Get("Billing_CommonBilling_js_06") == null ? "IsSTAT" : SListForAppDisplay.Get("Billing_CommonBilling_js_06");
    var vPL = SListForAppDisplay.Get("Billing_CommonBilling_js_07") == null ? "PL/OutSource" : SListForAppDisplay.Get("Billing_CommonBilling_js_07");
    var vQuantity = SListForAppDisplay.Get("Billing_CommonBilling_js_08") == null ? "Quantity" : SListForAppDisplay.Get("Billing_CommonBilling_js_08");
    var vAmount = SListForAppDisplay.Get("Billing_CommonBilling_js_09") == null ? "Amount" : SListForAppDisplay.Get("Billing_CommonBilling_js_09");
    var vRemarks = SListForAppDisplay.Get("Billing_CommonBilling_js_10") == null ? "Remarks" : SListForAppDisplay.Get("Billing_CommonBilling_js_10");
    var vRm = SListForAppDisplay.Get("Billing_CommonBilling_js_11") == null ? "Rm.Amt" : SListForAppDisplay.Get("Billing_CommonBilling_js_11");
    var vReport = SListForAppDisplay.Get("Billing_CommonBilling_js_12") == null ? "Report Date" : SListForAppDisplay.Get("Billing_CommonBilling_js_12");
    var vIsReimbursable = SListForAppDisplay.Get("Billing_CommonBilling_js_13") == null ? "IsReimbursable" : SListForAppDisplay.Get("Billing_CommonBilling_js_13");
    var vActualAmount = SListForAppDisplay.Get("Billing_CommonBilling_js_14") == null ? "ActualAmount" : SListForAppDisplay.Get("Billing_CommonBilling_js_14");
    var vIsNormalRateCard = SListForAppDisplay.Get("Billing_CommonBilling_js_15") == null ? "IsNormalRateCard" : SListForAppDisplay.Get("Billing_CommonBilling_js_15");
    var vIsDiscountable = SListForAppDisplay.Get("Billing_CommonBilling_js_16") == null ? "IsDiscountable" : SListForAppDisplay.Get("Billing_CommonBilling_js_16");
    var vBaseRateID = SListForAppDisplay.Get("Billing_CommonBilling_js_17") == null ? "BaseRateID" : SListForAppDisplay.Get("Billing_CommonBilling_js_17");
    var vDPID = SListForAppDisplay.Get("Billing_CommonBilling_js_18") == null ? "DPID" : SListForAppDisplay.Get("Billing_CommonBilling_js_18");
    var vDCC = SListForAppDisplay.Get("Billing_CommonBilling_js_19") == null ? "DCC" : SListForAppDisplay.Get("Billing_CommonBilling_js_19");
    var vDeliveryDate = SListForAppDisplay.Get("Billing_CommonBilling_js_20") == null ? "DeliveryDate" : SListForAppDisplay.Get("Billing_CommonBilling_js_20");
    var vIsTaxable = SListForAppDisplay.Get("Billing_CommonBilling_js_21") == null ? "IsTaxable" : SListForAppDisplay.Get("Billing_CommonBilling_js_21");
    var vIsRepeatable = SListForAppDisplay.Get("Billing_CommonBilling_js_22") == null ? "IsRepeatable" : SListForAppDisplay.Get("Billing_CommonBilling_js_22");
    var vIsSTAT = SListForAppDisplay.Get("Billing_CommonBilling_js_23") == null ? "IsSTAT" : SListForAppDisplay.Get("Billing_CommonBilling_js_23");
    var vIsSMS = SListForAppDisplay.Get("Billing_CommonBilling_js_24") == null ? "IsSMS" : SListForAppDisplay.Get("Billing_CommonBilling_js_24");
    var vIsOutSource = SListForAppDisplay.Get("Billing_CommonBilling_js_25") == null ? "IsOutSource" : SListForAppDisplay.Get("Billing_CommonBilling_js_25");
    var vIsNABL = SListForAppDisplay.Get("Billing_CommonBilling_js_26") == null ? "IsNABL" : SListForAppDisplay.Get("Billing_CommonBilling_js_26");
    var vBillingItemRateID = SListForAppDisplay.Get("Billing_CommonBilling_js_27") == null ? "BillingItemRateID" : SListForAppDisplay.Get("Billing_CommonBilling_js_27");
    var vHasHistory = SListForAppDisplay.Get("Billing_CommonBilling_js_28") == null ? "HasHistory" : SListForAppDisplay.Get("Billing_CommonBilling_js_28");
    var vMaxDiscount = SListForAppDisplay.Get("Billing_CommonBilling_js_29") == null ? "MaxDiscount" : SListForAppDisplay.Get("Billing_CommonBilling_js_29");
    var vIsRedeem = SListForAppDisplay.Get("Billing_CommonBilling_js_30") == null ? "IsRedeem" : SListForAppDisplay.Get("Billing_CommonBilling_js_30");
    var vRedeemAmount = SListForAppDisplay.Get("Billing_CommonBilling_js_31") == null ? "RedeemAmount" : SListForAppDisplay.Get("Billing_CommonBilling_js_31");
    var vhtml = SListForAppDisplay.Get("Billing_CommonBilling_js_311") == null ? "History" : SListForAppDisplay.Get("Billing_CommonBilling_js_311");
    var vDelete = SListForAppDisplay.Get("Billing_CommonBilling_js_32") == null ? "Delete" : SListForAppDisplay.Get("Billing_CommonBilling_js_32");
    var SpecialTest = "SpecialTest";
    var Ishistory = "History";


    startPaymentTag = "<TABLE nowrap='nowrap' ID='tabDrg1' class='dataheaderInvCtrl w-100p bg-row b-grey' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> " + vFeeID + " </th><th scope='col'  style='width:5%;display:none;'> " + vFeeType + " </th> "
    + "<th scope='col' style='width:5%;'> " + vS + " </th> <th scope='col' style='width:6%;'> " + vCode + " </th> <th scope='col' align='left' style='width:35%;padding-left:2px;'> " + vDescription + " </th>  <th scope='col' style='" + testhistorystyle + "'> " + Ishistory + " </th> <th scope='col' align='center' style='width:8%;'>" + vIsSTAT + "</th><th scope='col' align='center' style='width:12%;'>" + vPL + "</th> <th scope='col' align='right' style='display:none;width:5%;'>  " + vQuantity + " </th><th scope='col' align='right' style='width:8%;'> " + vAmount + " </th> " 
    + "<th scope='col' style='width:20%;padding-left:2px;display:none;'>" + vRemarks + " </th><th scope='col' style='width:10%;padding-left:2px;" + RedeemDisplay + "'> " + vRm + " </th> <th scope='col' style='align:right;width:15%;display:table-cell;'> " + vReport + " </th> <th scope='col' style='display:none;'> " + vIsReimbursable + " </th><th scope='col' style='display:none;'> " + vActualAmount + " </th><th scope='col' style='display:none;'> " + vIsNormalRateCard + " </th> <th scope='col' style='display:none;'> " + vIsDiscountable + " </th><th scope='col' style='display:none;'> " + vBaseRateID + " </th> <th scope='col' style='display:none;'> " + vDPID + " </th><th scope='col' style='display:none;'> " + vDCC + " </th> <th scope='col' style='display:none;'> " + vDeliveryDate + " </th> <th scope='col' style='display:none;'> " + SpecialTest + " </th>"
    + "<th scope='col' style='display:none;'> " + vIsTaxable + " </th><th scope='col' style='display:none;'> " + vIsRepeatable + " </th><th scope='col' style='display:none;'> " + vIsSTAT + " </th><th scope='col' style='display:none;'> " + vIsSMS + " </th><th scope='col' style='display:none;'> " + vIsOutSource + " </th><th scope='col' style='display:none;'> " + vIsNABL + " </th>"
    + "<th scope='col' style='display:none;'> " + vBillingItemRateID + " </th><th scope='col' style='display:none;'> " + vHasHistory + " </th><th scope='col' style='display:none;'> " + vMaxDiscount + " </th><th scope='col' style='display:none;'> " + vIsRedeem + " </th><th scope='col' style='display:none;'> " + vRedeemAmount + " </th><th scope='col'style='" + popuporgid + "'> " + vhtml + " </th><th scope='col' style='" + Tempdisplay + "'> " + vDelete + " </th> </tr>";
    endPaymentTag = "</TBODY></TABLE>";
    newPaymentTables = startPaymentTag;
    document.getElementById('billPart_hdnDiscountableTestTotal').value = 0;
    document.getElementById('billPart_hdnRedeemableTestAmount').value = 0;
    document.getElementById('billPart_hdnTaxableTestToal').value = 0;
    // document.getElementById('billPart_trSTATOutSource').style.display = "none";
    var arrayMainData = new Array();
    var arraySubData = new Array();
    var arrayChildData = new Array();
    var iMain = 0;
    var iChild = 0;
    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable, ActualAmount, IsNormalRateCard, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID,
    DiscountCategoryCode, ReportDeliveryDate, MaxDiscount, IsRedeem, RedeemAmount, Ishtmltab, IsTemplateID, IsTemplateText;
    var GrossAmt = 0;
    //VEL
    var MRPGrossAmt = 0;
    var DiscountableTestAmount = 0;
    var RedeemableTestAmount = 0;
    var TaxableTestAmount = 0;
    var sno = 1;
    var IsInvestigationAdded = 0;
    var RedeemabelAmt = 0;
    var IsSpecialTest = 'N';
    var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
    if (id == 0) {
        if (document.getElementById('txtClient').value == '' && document.getElementById('hdnDefaultOrgBillingItems').value != '' && defaultbillflag == 0) {
            defaultbillflag = 1;
            // defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
            FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
                        + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8]
                        + "~IsDiscountable^" + defalutdata[9] + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~outRInSourceLocation^" + defalutdata[14]
                        + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + defalutdata[16] + "~Code^" + defalutdata[17] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + "N" + "|";
            document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;

        }
    }
    FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;
    document.getElementById('billPart_hdnInvHistory').value = '';
    arrayMainData = FeeViewStateValue.split('|');
    var IsMandatoryHis='';
    if (arrayMainData.length > 0) {
        for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {

            arraySubData = arrayMainData[iMain].split('~');
            for (iChild = 0; iChild < arraySubData.length; iChild++) {
                arrayChildData = arraySubData[iChild].split('^');
                if (arrayChildData.length > 0) {
                    if (arrayChildData[0] == "FeeID") {
                        FeeID = arrayChildData[1];
                        document.getElementById('billPart_hdnInvHistory').value += FeeID + "~";
                    }
                    if (arrayChildData[0] == "FeeType") {
                        FeeType = arrayChildData[1];
                        if (FeeType == 'INV' || FeeType == 'GRP' || FeeType == 'PKG') {
                            IsInvestigationAdded = IsInvestigationAdded + 1;
                        }
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
                    //VEL
                    if (arrayChildData[0] == "ActualAmount") {
                        ActualAmount = arrayChildData[1];
                        MRPGrossAmt = Number(MRPGrossAmt) + Number(ActualAmount);
                    }
                    if (arrayChildData[0] == "IsNormalRateCard") {
                        IsNormalRateCard = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsDiscountable") {
                        IsDiscountable = arrayChildData[1];
                        if (IsDiscountable == "Y" && IsNormalRateCard == "Y")
                            DiscountableTestAmount = Number(DiscountableTestAmount) + Number(Amount);
                    }
                    if (arrayChildData[0] == "IsTaxable") {
                        IsTaxable = arrayChildData[1];
                        if (IsTaxable == "Y")
                            TaxableTestAmount = Number(TaxableTestAmount) + Number(Amount);
                    }
                    if (arrayChildData[0] == "IsRepeatable") {
                        IsRepeatable = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsSTAT") {
                        IsSTAT = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsSMS") {
                        IsSMS = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsOutSource") {
                        IsOutSource = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsNABL") {
                        IsNABL = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "BillingItemRateID") {
                        BillingItemRateID = arrayChildData[1];
                        //BillingItemRateID = document.getElementById('hdnRateID').value;
                    }
                    if (arrayChildData[0] == "Code") {
                        Code = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "HasHistory") {
                        HasHistory = arrayChildData[1];
                        if (HasHistory == "Y")
                            HasHistoryflag = 1;

                    }
                    if (arrayChildData[0] == "outRInSourceLocation") {
                        outRInSourceLocation = arrayChildData[1];
                    }

                    if (arrayChildData[0] == "BaseRateID") {
                        BaseRateID = arrayChildData[1];
                    }

                    if (arrayChildData[0] == "DiscountPolicyID") {
                        DiscountPolicyID = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "DiscountCategoryCode") {
                        DiscountCategoryCode = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "ReportDeliveryDate") {
                        ReportDeliveryDate = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "MaxDiscount") {
                        MaxDiscount = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsRedeem") {
                        IsRedeem = arrayChildData[1];
                        if (IsRedeem == "Y" && IsNormalRateCard == "Y")
                            RedeemableTestAmount = Number(RedeemableTestAmount) + Number(Amount);
                    }
                    if (arrayChildData[0] == "RedeemAmount") {
                        RedeemAmount = arrayChildData[1];
                        if (IsRedeem == "Y" && IsNormalRateCard == "Y")
                            RedeemabelAmt = Number(Number((Amount * arrayChildData[1])) / 100).toFixed(2);
                        else
                            RedeemabelAmt = (0.00).toFixed(2);
                    }
                    if (arrayChildData[0] == "Ishtmltab") {
                        Ishtmltab = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsTemplateID") {
                        IsTemplateID = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsSpecialTest") {
                        IsSpecialTest = arrayChildData[1];
                    }
		    if (arrayChildData[0] == "IsMandatoryHis") {
                        IsMandatoryHis= arrayChildData[1];
                    }
                    
                }
            }
            var lstitem;
            var lstHeathCard;
            if (IsDiscountable == 'Y' && IsDiscountable != '' && IsNormalRateCard == 'Y') {
                var lstitem = FeeID + '~' + FeeType + '~' + Amount + '~' + MaxDiscount + '~' + IsDiscountable + '-';
                ItemLevel = lstitem;
                if (ItemLevel != '') {
                    document.getElementById('billPart_hdnItems').value += ItemLevel;
                }
            }
            else {
                lstitem = FeeID + '~' + FeeType + '~' + Amount + '~' + MaxDiscount + '~' + IsDiscountable + '-';
                ItemLevel = lstitem;
                if (ItemLevel != '') {
                    document.getElementById('billPart_hdnItemsNoDiscount').value += ItemLevel;
                }
            }
            if (IsRedeem != '' && IsRedeem == 'Y') {
                var lstHeathCard = FeeID + '~' + FeeType + '~' + Amount + '~' + RedeemAmount + '~' + IsRedeem + '-';
                ItemLevel = lstHeathCard;
                if (ItemLevel != '') {
                    document.getElementById('billPart_hdnHealthCardItems').value += ItemLevel;
                }
            }





            document.getElementById('billPart_divItemTable').style.height = "auto";
            if (iMain >= 6) {
                document.getElementById('billPart_divItemTable').style.height = "150px";
                document.getElementById('billPart_divItemTable').style.overflow = "scroll";
                //$('[id$="divItemTable"]').height("100px");
            }
            if (IsSTAT == 'Y') {
                newPaymentTables += "<TR Tooltip='STAT Test' style='background-color:#EEB4B4;'>";
                document.getElementById('billPart_trSTATOutSource').style.display = "table-row";
            }
            else if (IsOutSource == 'Y') {
                newPaymentTables += "<TR Tooltip='Out Source Test' style='background-color:#D0FA58;'>";
                document.getElementById('billPart_trSTATOutSource').style.display = "table-row";
            }
            else if (FeeType == 'GRP') {
                newPaymentTables += "<TR Tooltip='Group Test' style='color:#C71585;'>";
            }
            else if (FeeType == 'PKG') {
                newPaymentTables += "<TR Tooltip='Group Test' style='color:#6699FF;'>";
            }
            else {
                newPaymentTables += "<TR>";
            }
            var str = 'checkboxs' + sno;
            newPaymentTables += "<TD style='display:none;'>" + FeeID + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + FeeType + "</TD>";
            newPaymentTables += "<TD align='Center'>" + sno + "</TD>";
            newPaymentTables += "<TD align='Center'>" + Code + "</TD>";
            if (FeeType == 'GRP') {
                newPaymentTables += "<TD ><input value ='" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "," + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "' onclick='GetGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"
            }
            else if (FeeType == 'PKG') {
                newPaymentTables += "<TD ><input value ='" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "," + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "' onclick='GetGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#6699FF;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"
            }
            else if (FeeType != "INV") {
            newPaymentTables += "<TD ><input value ='" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "," + IsSpecialTest +  "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID +"' onclick='GetGroupName(name);'type='button' style='width:250px;word-wrap: break-word;background-color:Transparent;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"
            }
            else {
                // newPaymentTables += "<TD  style='align:left;'>" + Descrip + "</TD>"
                newPaymentTables += "<TD ><input value ='" + Descrip + "' type='button' style='width:250px;word-wrap: break-word;background-color:Transparent;font-size:10px;border-style:none;text-align:left;' /></TD>"
                //                newPaymentTables += "<TD style='padding-left:5px;'>" + Descrip + "</TD>"
            }

            
            newPaymentTables += "<TD align='center' style='" + testhistorystyle + "'><input name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard +
            "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID +
            "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "~IsMandatoryHis^" + IsMandatoryHis + "' onclick='CaptureHistoryfortest(name);' value = 'History'  type='button' class='historyIcons'  style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'   /></TD>";


            //
            //            newPaymentTables += "<TD>" + sno + "</TD>";
            //            newPaymentTables += "<TD>" + Code + "</TD>";
            //             if (FeeType != "INV") {
            //                newPaymentTables += "<TD align='left'><input value = '" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "' onclick='GetGroupName(name);'type='button' style='background-color:Transparent;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"
            //            }
            //            else {
            //                newPaymentTables += "<TD  align='left'>" + Descrip + "</TD>"
            //            }
            newPaymentTables += "<TD  style='display:none;' align='right'>" + Quantity + "</TD>";
            //andrews
            if (FeeType == 'GEN' && Descrip == 'TEST') {
                if (document.getElementById('billPart_hdnIsBillable').value.trim() == "N") {
                    if (IsSTAT == 'Y') {
                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input  style='display:none;'  id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID +"' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true'  disabled type='checkbox'  /></TD>";
                    }
                    else {
                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   style='display:none;' id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID +"' onclick='chkChange(value,this.id);'  name='chkAlls'  disabled type='checkbox'  /></TD>";
                    }
                }
                else {
                    if (IsSTAT == 'Y') {
                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount +"~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true' disabled  type='checkbox'  /></TD>";
                    } else {
                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID +"' onclick='chkChange(value,this.id);'  name='chkAlls' disabled  type='checkbox'  /></TD>";
                    }
                }

            }
            else {
                //old
                if (document.getElementById('billPart_hdnIsBillable').value.trim() == "N") {
                    if (IsSTAT == 'Y') {
                        //                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input  style='display:none;'  id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "~IsMandatoryHis^" + IsMandatoryHis + "' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true'   type='checkbox'  /></TD>";
                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input  style='display:none;'  id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID +  "' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true'   type='checkbox'  /></TD>";
                    }
                    else {
                        //                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   style='display:none;' id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "~IsMandatoryHis^" + IsMandatoryHis + "' onclick='chkChange(value,this.id);'  name='chkAlls'   type='checkbox'  /></TD>";
                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   style='display:none;' id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID +  "' onclick='chkChange(value,this.id);'  name='chkAlls'   type='checkbox'  /></TD>";
                    }
                }
                else {
                    if (IsSTAT == 'Y') {
                        //                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "~IsMandatoryHis^" + IsMandatoryHis + "' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true'   type='checkbox'  /></TD>";
                        newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" +  "' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true'   type='checkbox'  /></TD>";
                    } else {
                    //                    newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "~IsMandatoryHis^" + IsMandatoryHis + "' onclick='chkChange(value,this.id);'  name='chkAlls'   type='checkbox'  /></TD>";
                    newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "' onclick='chkChange(value,this.id);'  name='chkAlls'   type='checkbox'  /></TD>";
                    }
                }
                //old
            }
            //andrews
            newPaymentTables += "<TD style='display:table-cell;'>" + outRInSourceLocation + "</TD>";
            //VEL
            //newPaymentTables += "<TD  align='right'>" + Amount + "</TD>";
            //newPaymentTables += "<TD  align='right'>" + ActualAmount + "</TD>";
            if (document.getElementById('hdnMRPBillDisplay').value == "Y") {
                newPaymentTables += "<TD  align='right'>" + ActualAmount + "</TD>";
            }
            else {
                newPaymentTables += "<TD  align='right'>" + Amount + "</TD>";
            }
            //VEL
            newPaymentTables += "<TD  align='right' style='" + RedeemDisplay + "'>" + RedeemabelAmt + "</TD>";
            newPaymentTables += "<TD  style='display:none;'>" + Remarks + "</TD>";
            newPaymentTables += "<TD style='display:table-cell;' align='center'>" + ReportDate + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsReimbursable + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + ActualAmount + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsDiscountable + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsTaxable + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsRepeatable + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsSTAT + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsSMS + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + outRInSourceLocation + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsNABL + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + BillingItemRateID + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + HasHistory + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + BaseRateID + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + DiscountPolicyID + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + DiscountCategoryCode + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + ReportDeliveryDate + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsSpecialTest + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + MaxDiscount + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsRedeem + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + RedeemAmount + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsNormalRateCard + "</TD>";
            if (document.getElementById('billPart_hdnpopuporgid').value.trim() == "Y") {
            if (Ishtmltab == 'Y') {
                //  newPaymentTables += "<TD><input name='FeeID^" + FeeID + "~IsTemplateID^" + IsTemplateID + "~IsTemplateText^" + IsTemplateText + "'onclick='getTemplates(name);'  value = 'Icon'  type='button' /></TD>";
                //newPaymentTables += "<TD><input type='button' onclick='getTemplates(FeeID,TemplateID,TemplateText);'  value = 'Icon'   /></TD>";
                newPaymentTables += "<TD class='template'><input id='" + FeeID + "-" + IsTemplateID + "-" + FeeType + "' orderedItems='" + FeeID + "^" + IsTemplateID + "^" + FeeType + "' Feeid='" + FeeID + "' Templateid='" + IsTemplateID + "' onclick='getTemplates(this);' value='Icon' type='button'/></TD>";

            }
            else {
                newPaymentTables += "<TD><input name='FeeID^" + FeeID + "' value = 'Icon'  type='button' disabled /></TD>";
                }
            }
            
            newPaymentTables += "<TD align='center' style='" + Tempdisplay + "'><input name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~IsSpecialTest^" + IsSpecialTest + "~Ishtmltab^" + Ishtmltab + "~IsTemplateID^" + IsTemplateID + "~IsMandatoryHis^" + IsMandatoryHis+  "' onclick='btnDeleteBillingItems_OnClick1(name);' value = 'Delete' class='deleteIcons' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";


            sno++;
        }
        if (iMain > 0) {
            //document.getElementById('billPart_lblOrderedItemsCount"]').val(iMain);
            //$('[id$="lblOrderedItemsCount"]').html(Number(iMain));
            document.getElementById('billPart_lblOrderedItemsCount').innerHTML = Number(iMain);
            document.getElementById('billPart_trOrderedItemsCount').style.display = "table-row";
        }
        else {
            document.getElementById('billPart_trOrderedItemsCount').style.display = "none";
        }
    }

    newPaymentTables += endPaymentTag;
    document.getElementById('billPart_divItemTable').innerHTML += newPaymentTables;
    document.getElementById('billPart_hdnDiscountableTestTotal').value = DiscountableTestAmount;
    document.getElementById('billPart_hdnRedeemableTestAmount').value = RedeemableTestAmount;
    ToTargetFormat($("#billPart_hdnDiscountableTestTotal"));
    ToTargetFormat($("#billPart_hdnRedeemableTestAmount"));
    document.getElementById('billPart_hdnTaxableTestToal').value = TaxableTestAmount;
    ToTargetFormat($("#billPart_hdnTaxableTestToal"));
    //    $('[id$="hdnDiscountableTestTotal"]').val(DiscountableTestAmount);
    //    $('[id$="hdnTaxableTestToal"]').val(TaxableTestAmount);

    ClearSelectedData();
    //VEL
    //SetGrossValue(GrossAmt)
    SetGrossValue(GrossAmt, MRPGrossAmt)
    //VEL
    SetOtherCurrValues();
    // if (HasHistoryflag == 1) {
    document.getElementById('billPart_tdHistory').style.display = "table-cell";
    if (HasHistoryflag == 1) {
        if (document.getElementById('billPart_hdnIsHistoryMandatory').value == "Y") {
            document.getElementById('billPart_hdnCapture').value = 1;
        }
        AddHistoryDetail();
    }
    else {
        document.getElementById('billPart_hdnCapture').value = 0;
    }
    document.getElementById('billPart_tdHistory').style.display = "table-cell";

    // }
    //
    // else {
    //    document.getElementById('billPart_tdHistory').style.display = "none";
    //   document.getElementById('billPart_hdnCapture').value = 0;
    // }
    if (IsInvestigationAdded >= 1) {

        document.getElementById('billPart_hdnIsInvestigationAdded').value = 1;
        ToTargetFormat($("#billPart_hdnIsInvestigationAdded"));
    }
    else {
        document.getElementById('billPart_hdnIsInvestigationAdded').value = 0;
        ToTargetFormat($("#billPart_hdnIsInvestigationAdded"));
    }
}

function CaptureHistoryfortest(sEditdata) {

    var Feevalues = new Array();
    Feevalues = sEditdata.split('~');
    var FeeID, FeeType, FeeName;

    if (Feevalues.length > 0) {
        FeeID = Feevalues[0];
        FeeType = Feevalues[1];
        FeeName = Feevalues[2];
        FeeID = FeeID.split('^');
        FeeType = FeeType.split('^');
        FeeName = FeeName.split('^');
        FeeID = FeeID[1];
        FeeType = FeeType[1];
        FeeName = FeeName[1];
    }
    
    var TestHistory = document.getElementById('hdnTestHistoryPatient').value;
    $("#dialog1").empty();
    BindDynamicTestHistoryCapturedValues(FeeID, FeeType, FeeName, TestHistory);
    BindInstructionMApping(FeeID, FeeType);
    $('#dialog1').dialog('open');

}
function CaptureHistoryfortestEdit(sEditdata) {

    var Feevalues = new Array();
    Feevalues = sEditdata.split('~');
    var FeeID, FeeType, FeeName;
    
    if (Feevalues.length > 0) {
        FeeID = Feevalues[0];
        FeeType = Feevalues[1];
        FeeName = Feevalues[2];
        FeeID = FeeID.split('^');
        FeeType = FeeType.split('^');
        FeeName = FeeName.split('^');
        FeeID = FeeID[1];
        FeeType = FeeType[1];
        FeeName = FeeName[1];
    }
    var PatientVisitID = document.getElementById('hdnVisitID').value;
    var OrgID = document.getElementById('hdnOrgID').value;



    if (PatientVisitID != "" && OrgID != 0) {

        if (PatientVisitID > 0) {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/PatientTestHistoryValues",
                data: "{'OrgID' :" + parseInt(OrgID) + ",'PatientVisitID' :" + parseInt(PatientVisitID) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Validate(data) {
                    if (data.d.length > 0) {

                        var TestHistory = data.d;
                        $("#dialog1").empty();
                        BindDynamicTestHistoryCapturedValues(FeeID, FeeType, FeeName, TestHistory);
                        BindInstructionMApping(FeeID, FeeType);
                        $('#dialog1').dialog('open');

                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice Calling for PatientTestHistoryValues");
                    return false;
                }

            });



        }
    }

    

}

function getTemplates(tempdata) {
    //debugger;
    
    var id = $(tempdata).attr('id');
    var feeid = $(tempdata).attr('Feeid');
    var templateid = $(tempdata).attr('Templateid');
    var templatetext="";
    var TemplateDiv = $('#billPart_divtemplate').find('div[FeeID="' + feeid + '"]');
    templatetext=$(TemplateDiv).prop('outerHTML');
    
    $('#div7').attr('iconid', id);


    var jsondata = $(tempdata).attr('jsonData');


    var obj = {};
    obj.InvestigationID = feeid;
    obj.TemplateID = templateid;


    obj.Invtype = 'Inv';
    obj.SType = 'SearchWithID';
    $('#div7').empty();
    $('#div7').append(templatetext);
    if (jsondata != null && jsondata != "") {
        var jobject = JSON.parse(jsondata);
        $.each($('#div7').find('[key]'), function(id, val) {

            var key = $(val).closest('.form-group').find('label').attr('key');
            var ctrl = $(val).closest('.form-group').find('[control-type]');

            if (key != null && key != 'undefined') {
                var value = "";
                if ($(ctrl).attr('control-type') == 'radio-group') {
                    $(ctrl).attr('value', jobject[key]);
                    var rbtn = $(ctrl).find('input[value="' + jobject[key] + '"]');
                    $(rbtn).prop('checked', true);
                }
                else if ($(ctrl).attr('control-type') == 'NwithUnits') {
                    $(ctrl).attr('value', jobject[key]);
                    var bval = jobject[key];
                    if (bval != null && bval != 'undefined') {
                        var arrBval = bval.split("_");
                        $(ctrl[0]).val(arrBval[0]);
                        $(ctrl[1]).val(arrBval[1]);
                    }
                }
                else {
                    $(ctrl).val(jobject[key]);
                }

            }
        });
    }
    $find('billPart_mpopOutDoc').show();
    }


function GetGroupName(FeeId, FeeType) {
    objgrp = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_58") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_58");
    objpkg = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_59") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_59");
   // debugger;
    //    var FeeType = 'GRP';
    if (FeeId != '') {
        var FeeIds = FeeId.split(',')[0];
        SpecFeeID = FeeIds;
        SpecFeeName = FeeId.split(',')[2];
        SpecFeetype = FeeId.split(',')[1];
        var pFeeType = FeeId.split(',')[1];
        var pDescrip = FeeId.split(',')[2];
		    var strSpecialTest = FeeId.split(',')[3];
		    var IsSpecialTest = '';
		    if (strSpecialTest.indexOf("~") !=-1) {
			      var lstSpecialTest = strSpecialTest.split('~');
			      IsSpecialTest = lstSpecialTest[0];
		    }
		    else
		    {
			      IsSpecialTest = strSpecialTest;
		    }
        if (IsSpecialTest == '') {
            IsSpecialTest = 'N';
        }

        if (IsSpecialTest == 'Y') {
            SelectedHistopathTest(FeeIds);
            $('#billPart_btnspec').click();
            return false;
        }
        else
        {
            $find('billPart_ModalPopupShow').show();
            $.ajax({
                type: "POST",
                url: "../OPIPBilling.asmx/GetGroupInfo",
                data: "{ 'pkgid': '" + FeeIds + "','Type': '" + pFeeType + "' }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    var Items = data.d;
                    GetLabHistory(Items)
                    if (pFeeType == 'GRP') {
                        document.getElementById('billPart_Lbl_GroupName').innerHTML = pDescrip + ' : ' + objgrp;
                    }
                    else {
                        document.getElementById('billPart_Lbl_GroupName').innerHTML = pDescrip + ' : ' + objpkg;
                    }
                }
            });
        }
    }
}
function GetLabHistory(result) {
    result.reverse();
    function sortNumber(a, b) {
        return a - b;
    }
    for (var n = 0; n < result.length; n++) {
        var TableInvValue = '';
        var row = document.getElementById('tblGroupHistory').insertRow(1);
        row.id = n;
        var element1 = document.createElement("input");
        element1.type = "checkbox";
        element1.name = "chkbox";
        element1.id = result[n].InvestigationID;
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var SNo = result.length - n;

        cell1.innerHTML = "<b>" + SNo + "</b>";
        cell2.innerHTML = "<b>" + result[n].InvestigationName + "</b>";
        cell3.innerHTML = "<b>" + result[n].Status + "</b> ";
        cell4.innerHTML = "<b>" + result[n].Location + "</b>";
        cell5.appendChild(element1);
        cell5.id = result[n].PackageID;
        document.getElementById('tblGroupHistory').style.display = 'table';

    }

}
var lstInvDetails = [];
function FindCheckedItems(tableID) {
    try {
        var table = document.getElementById(tableID);
        var lstitems = new Array();
        var j = 0;
        var FlagPop = 0;
        var rowCount = table.rows.length;

        if (lstInvDetails.length > 0 && FlagPop == 0) {
            var len = lstInvDetails.length;
            for (var j = 0; j < len; j++) {
                if (lstInvDetails[j].PkgID == document.getElementById('billPart_hdnID').value) {
                    lstInvDetails.splice(j, 1);
                    //pop(lstInvDetails[j]);                    
                    FlagPop = 1;
                    len = lstInvDetails.length;
                    j--;

                }
            }
        }

        for (var i = 1; i < rowCount; i++) {
            var row = table.rows[i];
            var chkbox = row.cells[4].childNodes[0];

            if (null != chkbox && true == chkbox.checked) {
                lstInvDetails.push({
                    PkgID: document.getElementById('billPart_hdnID').value,
                    ID: chkbox.id,
                    ReferralID: row.cells[4].id

                });
            }

        }
        document.getElementById('billPart_hdnPkgandgrpID').value = JSON.stringify(lstInvDetails);

    } catch (e) {
        alert(e);
    }
}
function GetGroupName1(lblInvestigationID, lblType, lbInvName) {

    //    var FeeType = 'GRP';
    //    if (FeeId != '') {
    var FeeIds = lblInvestigationID;
    var pFeeType = lblType;
    var pDescrip = lbInvName;
    //        var FeeIds = FeeId.split(',')[0];
    //        var pFeeType = FeeId.split(',')[1];
    //        var pDescrip = FeeId.split(',')[2];
    $find('OrderedSamples1_ModalPopupShow').show();
    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetGroupInfo",
        data: "{ 'pkgid': '" + FeeIds + "','Type': '" + pFeeType + "' }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function(data) {
            //                var Items = data.d;
            //                GetLabHistory(Items)
            //                document.getElementById('OrderedSamples1_Lbl_GroupName').innerHTML = pDescrip + ' : ' + pFeeType;
            var Items = data.d;
            GetLabHistory1(Items)
            if (pFeeType == 'GRP') {
                document.getElementById('OrderedSamples1_Lbl_GroupName').innerHTML = pDescrip + ' : ' + 'GROUP';
            }
            else {
                document.getElementById('OrderedSamples1_Lbl_GroupName').innerHTML = pDescrip + ' : ' + 'PACKAGE';
            }
        }
    });
}

function GetLabHistory1(result) {
    result.reverse();
    function sortNumber(a, b) {
        return a - b;
    }
    for (var n = 0; n < result.length; n++) {
        var TableInvValue = '';
        var row = document.getElementById('tblGroupHistory').insertRow(1);
        row.id = n;

        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var SNo = result.length - n;

        cell1.innerHTML = "<b>" + SNo + "</b>";
        cell2.innerHTML = "<b>" + result[n].InvestigationName + "</b>";
        cell3.innerHTML = "<b>" + result[n].Status + "</b> ";
        cell4.innerHTML = "<b>" + result[n].Location + "</b> ";

        document.getElementById('tblGroupHistory').style.display = 'table';

    }

}

function SetGrossValue(Amount) {
    document.getElementById('billPart_txtGross').value = parseFloat(Number(Amount)).toFixed(2);
    ToTargetFormat($("#billPart_txtGross"));
    document.getElementById('billPart_hdnGrossValue').value = document.getElementById('billPart_txtGross').value;
    ToTargetFormat($("#billPart_hdnGrossValue"));
    // SetNetValue("ADD");
    ItemLevelCreditCal("", "", "");
}

//VEL
function SetGrossValue(Amount,MRPAmount) {
    document.getElementById('billPart_txtGross').value = parseFloat(Number(Amount)).toFixed(2);
    ToTargetFormat($("#billPart_txtGross"));
    document.getElementById('billPart_hdnGrossValue').value = document.getElementById('billPart_txtGross').value;
    ToTargetFormat($("#billPart_hdnGrossValue"));
    
    document.getElementById('billPart_txtMRPGross').value = parseFloat(Number(MRPAmount)).toFixed(2);
    ToTargetFormat($("#billPart_txtMRPGross"));
    document.getElementById('billPart_hdnMRPGrossValue').value = document.getElementById('billPart_txtMRPGross').value;
    ToTargetFormat($("#billPart_hdnMRPGrossValue"));
    
    ItemLevelCreditCal("", "", "");
}
//VEL

function ClearPaymentValues() {

    document.getElementById('billPart_txtGross').value = "0.00";
    ToTargetFormat($("#billPart_txtGross"));
    document.getElementById('billPart_hdnGrossValue').value = "0.00";
    ToTargetFormat($("#billPart_hdnGrossValue"));
    document.getElementById('billPart_hdnDiscountAmt').value = "0.00";
    ToTargetFormat($("#billPart_hdnDiscountAmt"));
    document.getElementById('billPart_txtDiscount').value = "0.00";
    ToTargetFormat($("#billPart_txtDiscount"));
    document.getElementById('billPart_hdnTaxAmount').value = "0.00";
    ToTargetFormat($("#billPart_hdnTaxAmount"));
    document.getElementById('billPart_hdfTax').value = "0.00";
    ToTargetFormat($("#billPart_hdfTax"));
    document.getElementById('billPart_txtTax').value = "0.00";
    ToTargetFormat($("#billPart_txtTax"));
    document.getElementById('billPart_txtServiceCharge').value = "0.00";
    ToTargetFormat($("#billPart_txtServiceCharge"));
    document.getElementById('billPart_hdnServiceCharge').value = "0.00";
    ToTargetFormat($("#billPart_hdnServiceCharge"));
    document.getElementById('billPart_txtRoundoffAmt').value = "0.00";
    ToTargetFormat($("#billPart_txtRoundoffAmt"));
    document.getElementById('billPart_hdnRoundOff').value = "0.00";
    ToTargetFormat($("#billPart_hdnRoundOff"));
    document.getElementById('billPart_txtNetAmount').value = "0.00";
    ToTargetFormat($("#billPart_txtNetAmount"));
    document.getElementById('billPart_hdnNetAmount').value = "0.00";
    ToTargetFormat($("#billPart_hdnNetAmount"));
    document.getElementById('billPart_txtAmtReceived').value = "0.00";
    ToTargetFormat($("#billPart_txtAmtReceived"));
    document.getElementById('billPart_hdnAmountReceived').value = "0.00";
    ToTargetFormat($("#billPart_hdnAmountReceived"));
    document.getElementById('billPart_txtDue').value = "0.00";
    ToTargetFormat($("#billPart_txtDue"));
    document.getElementById('billPart_hdnDue').value = "0.00";
    ToTargetFormat($("#billPart_hdnDue"));
    document.getElementById('billPart_ddDiscountPercent').disabled = true;
    document.getElementById('billPart_txtAuthorised').disabled = true;
    document.getElementById('billPart_ddlDiscountReason').disabled = true;
    document.getElementById('billPart_ddlDiscountReason').value = "0";
    document.getElementById('billPart_btnDiscountPercent').disabled = true;
    /* Start --Added By Jayaramanan L--*/
    document.getElementById('billPart_ddDiscountPercent').value = "0";
    ToTargetFormat($("#billPart_ddDiscountPercent"));
    /*End*/
    document.getElementById('billPart_hdnDiscountPercentage').value = "0";
    document.getElementById('billPart_txtEDCess').value = "0.00";
    ToTargetFormat($("#billPart_txtEDCess"));
    document.getElementById('billPart_hdnEDCess').value = "0.00";
    ToTargetFormat($("#billPart_hdnEDCess"));
    document.getElementById('billPart_txtSHEDCess').value = "0.00";
    ToTargetFormat($("#billPart_txtSHEDCess"));
    document.getElementById('billPart_hdnSHEDCess').value = "0.00";
    ToTargetFormat($("#billPart_txtGross"));
    document.getElementById('billPart_ddlTaxPercent').disabled = true;
    document.getElementById('billPart_txtAuthorised').value = "";

    //VEL
    document.getElementById('billPart_txtMRPGross').value = '0.00';
    ToTargetFormat($("#billPart_txtMRPGross"));
    document.getElementById('billPart_hdnMRPGrossValue').value = '0.00';
    ToTargetFormat($("#billPart_hdnMRPGrossValue"));
    document.getElementById('billPart_txtMRPNetAmount').value = '0.00';
    ToTargetFormat($("#billPart_txtMRPNetAmount"));
    document.getElementById('billPart_hdnMRPNetAmount').value = '0.00';
    ToTargetFormat($("#billPart_hdnMRPNetAmount"));
    document.getElementById('billPart_txtMRPDue').value = '0.00';
    ToTargetFormat($("#billPart_txtMRPDue"));
    document.getElementById('billPart_hdnMRPDue').value = '0.00';
    ToTargetFormat($("#billPart_hdnMRPDue"));
    //VEL
}
function setDiscountValuesDisable() {

    document.getElementById('billPart_ddDiscountPercent').disabled = true;
    document.getElementById('billPart_btnDiscountPercent').disabled = true;
    document.getElementById('billPart_txtDiscount').readOnly = true;
    document.getElementById('billPart_txtAuthorised').readOnly = true;
    document.getElementById('billPart_txtDiscountReason').readOnly = true;
    document.getElementById('billPart_ddDiscountPercent').value = "0";
    ToTargetFormat($("#billPart_ddDiscountPercent"));
    document.getElementById('billPart_hdnDiscountPercentage').value = "0";
    ToTargetFormat($("#billPart_hdnDiscountPercentage"));
    document.getElementById('billPart_ddDiscountPercent').value = "0";
    ToTargetFormat($("#billPart_ddDiscountPercent"));
    document.getElementById('billPart_txtCeiling').value = "";
    document.getElementById('billPart_ddlSlab').value = "0";
    ToTargetFormat($("#billPart_ddlSlab"));
    document.getElementById('billPart_txtDiscount').value = "0.00";
    ToTargetFormat($("#billPart_txtDiscount"));
    document.getElementById('billPart_txtAuthorised').value = "";
    document.getElementById('billPart_txtDiscountReason').value = "";
    document.getElementById('billPart_hdnDiscountAmt').value = "0.00";
    ToTargetFormat($("#billPart_hdnDiscountAmt"));
    document.getElementById('billPart_ddlDiscountReason').value = "0";
    ToTargetFormat($("#billPart_ddlDiscountReason"));
    document.getElementById('billPart_ddlDiscountReason').disabled = true;
    document.getElementById('billPart_ddlDiscountType').disabled = true;

}

function SetNetValue(obj) {
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    var roundOffAmt = 0;
    var gross = 0;
    //VEL
    var MRPgross = 0;
    //VEL
    var discount = 0;
    var TaxAMount = 0;
    var EDCess = 0;
    var SHEDCess = 0;
    var ServiceCharge = 0;
    var Discount = 0;
    var strType = "";
    var CalForoneRupee = 0.00;
    var focDiscount;
    var TotalTest;
    var DiscounType;
    var OtherOrgDisPer = 0.00;
    if (document.getElementById('billPart_hdnDiscountableTestTotal').value != "") {
        TotalTest = document.getElementById('billPart_hdnDiscountableTestTotal').value;
    }
    if ($('#billPart_ddDiscountPercent option:selected').val() == 0) {
        document.getElementById('billPart_ddlDiscountReason').value = 0;
    }
    if (Number(document.getElementById('billPart_txtGross').value) > 0) {
        if (Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) > 0) {
            /***********Modified By Arivalagan.KK***********/
            if (document.getElementById('billPart_hdnNotallowDiscashClient').value == 'N') {
                document.getElementById('billPart_ddDiscountPercent').disabled = false;
            }
            else if (document.getElementById('billPart_hdnNotallowDiscashClient').value == 'Y' && ($('#hdnSelectedClientCode').val() == 'GENERAL' || $('#hdnSelectedClientCode').val() == '-1'))
             {
                document.getElementById('billPart_ddDiscountPercent').disabled = false;
            }
            else {
                document.getElementById('billPart_ddDiscountPercent').disabled = true;
            }
            document.getElementById('billPart_btnDiscountPercent').disabled = false;
            document.getElementById('billPart_ddlTaxPercent').disabled = false;
            document.getElementById('billPart_txtDiscount').readOnly = false;
            /*************Added by Arivalagan.kk*****************/

            if ($('#billPart_ddDiscountPercent option:selected').val() != 0) {
                document.getElementById('billPart_txtAuthorised').disabled = false;
                document.getElementById('billPart_txtAuthorised').readOnly = false;
                document.getElementById('billPart_txtDiscountReason').readOnly = false;
                document.getElementById('billPart_ddlDiscountReason').disabled = false;
                document.getElementById('billPart_ddlDiscountType').disabled = false;
            }
            else if ($('#billPart_txtDiscount').val() > 0) {

                document.getElementById('billPart_txtAuthorised').disabled = false;
                document.getElementById('billPart_txtAuthorised').readOnly = false;
                document.getElementById('billPart_txtDiscountReason').readOnly = false;
                document.getElementById('billPart_ddlDiscountReason').disabled = false;
                document.getElementById('billPart_ddlDiscountType').disabled = false;
            }
            else {

                document.getElementById('billPart_txtAuthorised').disabled = true;
                document.getElementById('billPart_txtAuthorised').readOnly = true;
                document.getElementById('billPart_txtDiscountReason').readOnly = true;
                document.getElementById('billPart_ddlDiscountReason').disabled = true;
                document.getElementById('billPart_ddlDiscountType').disabled = true;
            }
            /************End*Added by Arivalagan.kk**************/
        }
        else if (Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) <= 0 || document.getElementById('txtClient').value.trim() != '') {
            setDiscountValuesDisable();
        }

        if (Number(document.getElementById('billPart_hdnTaxableTestToal').value) > 0) {
            document.getElementById('billPart_ddlTaxPercent').disabled = false;
            document.getElementById('billPart_txtTax').readOnly = false;
        }

        else if (Number(document.getElementById('billPart_hdnTaxableTestToal').value) <= 0) {
            document.getElementById('billPart_ddlTaxPercent').disabled = false;
            document.getElementById('billPart_txtTax').readOnly = false;
            document.getElementById('billPart_txtTax').value = "0.00";
            ToTargetFormat($('#billPart_txtTax'));
            document.getElementById('billPart_hdnTaxAmount').value = "0";
            ToTargetFormat($('#billPart_hdnTaxAmount'));
        }

        if (Number(document.getElementById('billPart_hdnAmountReceived').value) <= 0) {
            //  gross = Number(document.getElementById('billPart_hdnGrossValue').value);
            var objValue = obj;
            if (objValue == 'ADD') {
                objValue = "";
            }

            var HasMyCard = document.getElementById('billPart_hdnHasMyCard').value;
            if (HasMyCard == 'Y' && objValue == '') {
                var hdnRedeem = $('#billPart_hdnRedeemPoints').val();
                gross = Number(ToTargetFormat($('#billPart_hdnGrossValue')));
                gross = parseFloat(gross - hdnRedeem).toFixed(2);
            }
            else if (objValue == 'RedeemUncheck') {
                gross = Number(ToTargetFormat($('#billPart_hdnGrossValue')));
                $('#billPart_txtRedeem').val('');
            }
            else {
                gross = Number(ToTargetFormat($('#billPart_hdnGrossValue')));
            }



            if (Number(document.getElementById('billPart_ddlTaxPercent').value) > 0) {
                document.getElementById('billPart_txtTax').value = parseFloat((parseFloat(Number(document.getElementById('billPart_hdnTaxableTestToal').value)) / 100) * (Number(document.getElementById('billPart_ddlTaxPercent').value))).toFixed(2);
                ToTargetFormat($('#billPart_txtTax'));
            }

            TaxAMount = Number(document.getElementById('billPart_txtTax').value).toFixed(2);
            document.getElementById('billPart_hdnTaxAmount').value = TaxAMount;
            ToTargetFormat($('#billPart_hdnTaxAmount'));
            var UDiscount = 0;
            if (document.getElementById('billPart_txtDiscount').value != "") {
                UDiscount = document.getElementById('billPart_txtDiscount').value;
            }

            if (document.getElementById('billPart_hdnAllowMulDisc').value == "Y") {
                //if (Number(document.getElementById('billPart_hdnDiscountPercentage').value) > 0) {
                document.getElementById('billPart_txtDiscount').value = parseFloat((parseFloat(Number(document.getElementById('billPart_hdnDiscountableTestTotal').value)) / 100) * (Number(document.getElementById('billPart_hdnDiscountPercentage').value))).toFixed(2);
                ToTargetFormat($('#billPart_txtDiscount'));
                //}
            }
            else {
                var dispercent = 0.00;
                var dd = document.getElementById('billPart_ddDiscountPercent').value;
                DisDetails = dd.split('~');
                dispercent = DisDetails[0];
                if (DisDetails[3] != "") {
                    DiscounType = DisDetails[3];
                }
                $("#billPart_hdnDiscountID").val(DisDetails[1]);
                var DisDetails = new Array();
                if (dd === "0") {
                    strType = "WithoutDiscount";
                    focDiscount = false;
                    GetDiscount(CalForoneRupee, focDiscount, strType, OtherOrgDisPer);
                }

                var KeySlabDiscount = document.getElementById('billPart_hdnIsSlabDiscount').value;
                if (KeySlabDiscount == 'Y') {
                    if (document.getElementById('billPart_chkFoc').checked == false) {
                        var ddlDiscountType = document.getElementById("billPart_ddlDiscountType");
                        var trDiscountType = document.getElementById("billPart_trDiscountType");
                        var DiscountPercent = document.getElementById('billPart_ddlSlab').value;
                        var txtCeiling = document.getElementById('billPart_txtCeiling').value;
                        if ((DiscountPercent != 0 && DiscountPercent != null) || (txtCeiling != '' && typeof (txtCeiling) != "undefined")) {
                            TotalTest = document.getElementById('billPart_hdnDiscountableTestTotal').value;
                            var CalForoneRupee;
                            var DiscountValue = '';
                            var TotalTestDiscount;

                            //Discount Type of value Calculation
                            if (txtCeiling != '' && typeof (txtCeiling) != "undefined") {
                                var hdnCeilingValue;
                                document.getElementById('billPart_hdnSlabPercentAndValue').value = "0";
                                document.getElementById("billPart_ddlSlab").options.length = 0;
                                hdnCeilingValue = document.getElementById('billPart_hdnCeilingValue').value;
                                if (hdnCeilingValue != 0 && hdnCeilingValue != '' && typeof (hdnCeilingValue) != 'undefined') {
                                    var MasterCeiling = hdnCeilingValue.split('~');
                                    var MasterCeilingValue = MasterCeiling[0];
                                    TotalTestDiscount = parseInt(txtCeiling);
                                    DiscountSlabValue = MasterCeilingValue;
                                    //Assign DiscountCeilingValue
                                    document.getElementById('billPart_hdnDiscountCeiling').value = DiscountSlabValue;
                                }

                            }
                            //Discount Type of Percentage Calculation
                            if (DiscountPercent != 0) {
                                document.getElementById('billPart_hdnDiscountCeiling').value = "0";
                                document.getElementById('billPart_txtCeiling').value = "";
                                document.getElementById('billPart_hdnCeilingValue').value = "";

                                DisDetails = DiscountPercent.split('~');
                                var dispercent = DisDetails[0];
                                var DiscountSlabValue = DisDetails[2];
                                document.getElementById('billPart_hdnSlabPercentAndValue').value = dispercent + "~" + DiscountSlabValue;

                                //                //$("#billPart_hdnDiscountID").val(DisDetails[2]);
                                //1. Calculate Total Bill Level Discount
                                if (dispercent > 0) {
                                    TotalTestDiscount = (parseFloat((TotalTest / 100) * (Number(dispercent)))).toFixed(2);
                                }
                            }
                            //Calculation For 1rupee
                            //2. Compare Total Bill Level Discount with Slap Celling
                            if (TotalTestDiscount <= parseInt(DiscountSlabValue)) {
                                CalForoneRupee = (TotalTestDiscount / TotalTest);
                                DiscountValue = TotalTestDiscount;
                                focDiscount = false;
                                strType = "WithDiscount";
                                // GetDiscount(DiscountValue, CalForoneRupee, focDiscount);
                                GetDiscount(CalForoneRupee, focDiscount, strType, OtherOrgDisPer);
                            }
                            else {

                                CalForoneRupee = (parseInt(DiscountSlabValue) / TotalTest);
                                DiscountValue = DiscountSlabValue;
                                var focDiscount = false;
                                strType = "WithDiscount";
                                // GetDiscount(DiscountValue, CalForoneRupee, focDiscount);
                                GetDiscount(CalForoneRupee, focDiscount, strType, OtherOrgDisPer);
                            }
                        }
                        else {
                            if (DiscountPercent == "0") {
                                document.getElementById('billPart_txtDiscount').value = "0.00";
                                document.getElementById('billPart_hdnDiscountAmt').value = "0.00";
                                document.getElementById('billPart_ddlSlab').value == 0;
                            }
                        }
                    }
                    else {

                        focDiscount = true;
                        strType = "FocDiscount";
                        var TotaltestAmount = document.getElementById('billPart_hdnDiscountableTestTotal').value;
                        var TotalTestDiscount = (parseFloat((parseFloat(Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) / 100) * (100))).toFixed(2));
                        CalForoneRupee = TotalTestDiscount / TotaltestAmount;
                        GetDiscount(CalForoneRupee, focDiscount, strType, OtherOrgDisPer);
                    }
                }

                if (KeySlabDiscount == 'N' && (dispercent > 0 || Number(UDiscount) > 0)) {
                    strType = "Others";
                    focDiscount = false;
                    if (dispercent > 0) {
                        UDiscount = 0;
                        CalForoneRupee = dispercent / TotalTest;
                    }
                    if (Number(UDiscount) > 0) {
                        var PerX = Number(UDiscount) * 100 / Number(document.getElementById('billPart_hdnDiscountableTestTotal').value);
                        dispercent = Number(PerX);
                        CalForoneRupee = dispercent / TotalTest;
                    }
                    OtherOrgDisPer = dispercent;
                    GetDiscount(CalForoneRupee, focDiscount, strType, OtherOrgDisPer);
                    document.getElementById('billPart_txtDiscount').value =
                    (parseFloat((parseFloat(Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) / 100) *
                    (Number(dispercent)))).toFixed(2));
                    ToTargetFormat($('#billPart_txtDiscount'));
                }
            }

            var objvar33 = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_60") == null ? "Ordered test net amount, less then discount amount" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_60");
            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_Alert");

            document.getElementById('billPart_hdnDiscountAmt').value = document.getElementById('billPart_txtDiscount').value;
            discount = document.getElementById('billPart_hdnDiscountAmt').value;
            if (KeySlabDiscount == "N") {
                if (Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) < Number(document.getElementById('billPart_txtDiscount').value)) {
                    //alert('Ordered test net amount, less then discount amount');
                    ValidationWindow(objvar33, objAlert);
                    discount = 0;
                    document.getElementById('billPart_txtDiscount').value = "0.00";
                    ToTargetFormat($('#billPart_txtDiscount'));
                    document.getElementById('billPart_hdnDiscountAmt').value = "0.00";
                    ToTargetFormat($('#billPart_hdnDiscountAmt'));
                    document.getElementById('billPart_txtAuthorised').value = "";
                    document.getElementById('billPart_txtDiscountReason').value = "";
                    document.getElementById('billPart_txtDiscount').focus();
                }
            } else {
            }
            if (document.getElementById('billPart_chkEDCess').checked) {
                EDCess = Number(document.getElementById('billPart_txtGross').value) * 2 / 100;
                document.getElementById('billPart_txtEDCess').value = parseFloat(EDCess).toFixed(2);
                ToTargetFormat($('#billPart_txtEDCess'));
                document.getElementById('billPart_hdnEDCess').value = parseFloat(EDCess).toFixed(2);
                ToTargetFormat($('#billPart_hdnEDCess'));
            }
            else {
                EDCess = 0;
                document.getElementById('billPart_txtEDCess').value = "0.00";
                ToTargetFormat($('#billPart_txtEDCess'));
                document.getElementById('billPart_hdnEDCess').value = 0;
            }
            if (document.getElementById('billPart_chkSHEDCess').checked) {
                SHEDCess = Number(document.getElementById('billPart_txtGross').value) * 1 / 100;
                document.getElementById('billPart_txtSHEDCess').value = parseFloat(SHEDCess).toFixed(2);
                ToTargetFormat($('#billPart_txtSHEDCess'));
                document.getElementById('billPart_hdnSHEDCess').value = parseFloat(SHEDCess).toFixed(2);
                ToTargetFormat($('#billPart_hdnSHEDCess'));
            }
            else {
                SHEDCess = 0;
                document.getElementById('billPart_txtSHEDCess').value = "0.00";
                ToTargetFormat($('#billPart_txtSHEDCess'));
                document.getElementById('billPart_hdnSHEDCess').value = 0;
            }
            ServiceCharge = Number(document.getElementById('billPart_txtServiceCharge').value);
            var netvalue = Number(gross) + Number(TaxAMount) + Number(EDCess) + Number(SHEDCess) + Number(ServiceCharge) - Number(discount);
            //VEL
            MRPgross = Number(ToTargetFormat($('#billPart_hdnMRPGrossValue')));
            var MRPnetvalue = Number(MRPgross) + Number(TaxAMount) + Number(EDCess) + Number(SHEDCess) + Number(ServiceCharge) - Number(discount);
            //VEL
            
            //            if (Number(netvalue) - Number(getOPCustomRoundoff(netvalue.toFixed(2))) > 0)
            //                roundOffAmt = Number(netvalue) - Number(getOPCustomRoundoff(netvalue));
            //            else
            //                roundOffAmt = Number(getOPCustomRoundoff(netvalue)) - Number(netvalue);
            var HDCashClient = document.getElementById('billPart_hdnIsCashClient').value;
           // if (HDCashClient == "N") {
                var hdnTpaRoundoff;
                var hdnTpaRoundOffType;
                if (document.getElementById('hdnTpaRoundoff') != null) {
                    hdnTpaRoundoff = document.getElementById('hdnTpaRoundoff').value;
                    document.getElementById('hdnDefaultRoundoff').value = hdnTpaRoundoff;
                }
                if (document.getElementById('hdnTpaRoundOffType') != null) {
                    hdnTpaRoundOffType = document.getElementById('hdnTpaRoundOffType').value;
                    document.getElementById('hdnRoundOffType').value = hdnTpaRoundOffType;
                }
           // }
            roundOffAmt = Number(getOPCustomRoundoff(netvalue)) - Number(netvalue);

            document.getElementById('billPart_txtRoundoffAmt').value = (parseFloat(roundOffAmt).toFixed(2));
            ToTargetFormat($('#billPart_txtRoundoffAmt'));
            document.getElementById('billPart_hdnRoundOff').value = (parseFloat(roundOffAmt).toFixed(2));
            ToTargetFormat($('#billPart_hdnRoundOff'));

            document.getElementById('billPart_txtEdtNetAmt').value = (parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2));
            ToTargetFormat($('#billPart_txtEdtNetAmt'));
            document.getElementById('billPart_txtNetAmount').value = (parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2));
            ToTargetFormat($('#billPart_txtNetAmount'));

            document.getElementById('billPart_hdnNetAmount').value = (parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2));
            ToTargetFormat($('#billPart_hdnNetAmount'));

            //VEL
            document.getElementById('billPart_txtMRPNetAmount').value = (parseFloat(getOPCustomRoundoff(MRPnetvalue)).toFixed(2));
            ToTargetFormat($('#billPart_txtMRPNetAmount'));

            document.getElementById('billPart_hdnMRPNetAmount').value = (parseFloat(getOPCustomRoundoff(MRPnetvalue)).toFixed(2));
            ToTargetFormat($('#billPart_hdnMRPNetAmount'));
            //VEL
            
            var IsCashClient = document.getElementById('billPart_hdnIsCashClient').value;
            var ClientType = document.getElementById('billPart_hdnClientType').value
            if (IsCashClient == '') {
                IsCashClient = 'Y';
            }
            var IsCopayClient = 'N';
            if (document.getElementById('HdnCoPay') != null) {
                IsCopayClient = document.getElementById('HdnCoPay').value;
            }

            var IsHCPayments = document.getElementById('billPart_hdnHCPayments').value;
            if ((document.getElementById('txtClient').value == '' || IsCashClient == 'Y' || ClientType == 'WAK') && obj == "ADD" && IsCopayClient != 'Y') {
              
                ////for HomeCollection data
//                if (IsHCPayments == 'Y' &&
//                      (Number(document.getElementById('billPart_hdnNetAmount').value) == Number(document.getElementById('billPart_txtAmtReceived').value))) 
                 if (IsHCPayments == 'Y')
                   {
                      $("#billPart_PaymentType_txtAmount").removeAttr("disabled");
                      document.getElementById('billPart_PaymentType_txtAmount').value = '0.00';
                      ToTargetFormat($('#billPart_PaymentType_txtAmount'));

                      document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = '0.00';
                      ToTargetFormat($('#billPart_PaymentType_txtTotalAmount')); 
                }
                else { //Previous Logic
                    $("#billPart_PaymentType_txtAmount").removeAttr("disabled");
                    document.getElementById('billPart_PaymentType_txtAmount').value = parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2);
                    ToTargetFormat($('#billPart_PaymentType_txtAmount'));

                    document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2);
                    ToTargetFormat($('#billPart_PaymentType_txtTotalAmount'));
                }

            }
            else {

                $("#billPart_PaymentType_txtAmount").attr("enabled", "enabled");
            }
            SetOtherCurrValues();

        }
        else {
            if (obj != 'ED') {
                if (document.getElementById('billPart_hdnCpedit').value == 'Y') {
                    ClearPaymentControlEvents1();
                    SetNetValue('ADD');
                }
                else {
                    var objvar34 = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_61") == null ? "Amount already received, delete the amount received... Do you want to Delete the amount received?" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_61");
if ($('#billPart_ddDiscountPercent option:selected').val() != 0) {
                    if (confirm(objvar34)) {
                        document.getElementById('billPart_ddDiscountPercent').value = 0;
                        document.getElementById('billPart_hdnDiscountPercentage').value = 0;
                        document.getElementById('billPart_txtDiscount').value = "0.00";
                        ToTargetFormat($('#billPart_txtDiscount'));
                        document.getElementById('billPart_txtAuthorised').value = '';
                        document.getElementById('billPart_txtDiscountReason').value = '';
                        document.getElementById('billPart_hdnDiscountAmt').value = 0;
                        document.getElementById('billPart_ddlDiscountReason').value = 0;
                        document.getElementById('billPart_txtServiceCharge').value = "0.00";
                        document.getElementById('billPart_hdnServiceCharge').value = 0;


                        ClearPaymentControlEvents1();
                        SetNetValue('ADD');
                        if (($("#billPart_hdnHasClientHealthcoupon").val() == "Y") && $("#billPart_hdnHasMyCard").val() == "Y" && $("#billPart_hdnIsCashClient").val() == "Y" && $("#billPart_hdnOrgHealthCoupon").val() == "Y" && document.getElementById('billPart_ddDiscountPercent').value == 0 && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y") {
                            $('#hdnIsMycardChecked').val('Y');
                            $('#dvExistingCard').show();
                        }
                    }
                    else {
                        document.getElementById('billPart_ddDiscountPercent').value = 0;
                        document.getElementById('billPart_ddlDiscountReason').value = 0;
                        document.getElementById('billPart_hdnDiscountPercentage').value = 0;
                        return false;
                    }
}
else if ($('#billPart_ddDiscountPercent option:selected').val() == 0) {
	document.getElementById('billPart_ddDiscountPercent').value = 0;
	document.getElementById('billPart_ddlDiscountReason').value = 0;
	
                        document.getElementById('billPart_hdnDiscountPercentage').value = 0;
                        document.getElementById('billPart_txtDiscount').value = "0.00";
                        ToTargetFormat($('#billPart_txtDiscount'));
                        document.getElementById('billPart_txtAuthorised').value = '';
                        document.getElementById('billPart_txtDiscountReason').value = '';
                        document.getElementById('billPart_hdnDiscountAmt').value = 0;
                        
                        document.getElementById('billPart_txtServiceCharge').value = "0.00";
                        document.getElementById('billPart_hdnServiceCharge').value = 0;


                        ClearPaymentControlEvents1();
                        SetNetValue('ADD');
}
                    else {
                        return false;
                    }

                }
            }
        }
    }
    else {
        SetOtherCurrValues();
        ClearPaymentValues();
        return false;
    }
    if (document.getElementById('txtClient').value.trim() != '') {
        if (document.getElementById('hdnIsCashClient').value == "N") {
            setDiscountValuesDisable();
        }
    }

    var IsHCPay = document.getElementById('billPart_hdnHCPayments').value;
    if (document.getElementById('HdnCoPay') != null) {
        if (document.getElementById('HdnCoPay').value == 'N' || document.getElementById('HdnCoPay').value == '') {
            if (IsHCPay == 'Y') { // for Home Collection
                document.getElementById('billPart_txtDue').value = '0.00';
                document.getElementById('billPart_hdnDue').value = '0.00';
                ToTargetFormat($('#billPart_txtDue'));
                ToTargetFormat($('#billPart_hdnDue'));

                
                document.getElementById('billPart_txtMRPDue').value = '0.00';
                document.getElementById('billPart_hdnMRPDue').value = '0.00';
                ToTargetFormat($('#billPart_txtMRPDue'));
                ToTargetFormat($('#billPart_hdnMRPDue'));
                
            }
            else { //Previous Logic
                document.getElementById('billPart_txtDue').value = parseFloat(Number(document.getElementById('billPart_hdnNetAmount').value) - Number(document.getElementById('billPart_hdnAmountReceived').value)).toFixed(2);
                document.getElementById('billPart_hdnDue').value = parseFloat(Number(document.getElementById('billPart_hdnNetAmount').value) - Number(document.getElementById('billPart_hdnAmountReceived').value)).toFixed(2);
                ToTargetFormat($('#billPart_txtDue'));
                ToTargetFormat($('#billPart_hdnDue'));

                //VEL
                document.getElementById('billPart_txtMRPDue').value = parseFloat(Number(document.getElementById('billPart_hdnMRPNetAmount').value) - Number(document.getElementById('billPart_hdnAmountReceived').value)).toFixed(2);
                document.getElementById('billPart_hdnMRPDue').value = parseFloat(Number(document.getElementById('billPart_hdnMRPNetAmount').value) - Number(document.getElementById('billPart_hdnAmountReceived').value)).toFixed(2);
                ToTargetFormat($('#billPart_txtMRPDue'));
                ToTargetFormat($('#billPart_hdnMRPDue'));
            }
 if ($('#hdnCheckIsDiscout').val() == 'Y') {
     if (document.getElementById('billPart_hdnNotallowDiscashClient').value == 'N') {

                if ($('#hdnIsCashClient').val() == 'Y' && $('#billPart_hdnIsDiscount').val() == 'Y' &&
                $('#hdnSelectedClientCode').val() != '-1' && $('#hdnSelectedClientCode').val() != 'GENERAL' && $.trim($('#txtClient').val()) != '') {

                    $("#billPart_ddDiscountPercent").prop("disabled", false);
                    $("#billPart_ddlDiscountReason").prop("disabled", false);

                }
                else if ($('#hdnSelectedClientCode').val() == '-1' || $('#hdnSelectedClientCode').val() == 'GENERAL') {
                    $("#billPart_ddDiscountPercent").prop("disabled", false);
                    $("#billPart_ddlDiscountReason").prop("disabled", false);
                }
                else {
                    $("#billPart_ddDiscountPercent").prop("disabled", true);
                    $("#billPart_ddlDiscountReason").prop("disabled", true);
         }
     } 
                else if (document.getElementById('billPart_hdnNotallowDiscashClient').value == 'Y' && ($('#hdnSelectedClientCode').val() == 'GENERAL' || $('#hdnSelectedClientCode').val() == '-1'))
                
                {
                if ($('#hdnIsCashClient').val() == 'Y' && $('#billPart_hdnIsDiscount').val() == 'Y' &&
                $('#hdnSelectedClientCode').val() != '-1' && $('#hdnSelectedClientCode').val() != 'GENERAL' && $.trim($('#txtClient').val()) != '') {

                    $("#billPart_ddDiscountPercent").prop("disabled", false);
                    $("#billPart_ddlDiscountReason").prop("disabled", false);

                }
                else if ($('#hdnSelectedClientCode').val() == '-1' || $('#hdnSelectedClientCode').val() == 'GENERAL') {
                    $("#billPart_ddDiscountPercent").prop("disabled", false);
                    $("#billPart_ddlDiscountReason").prop("disabled", false);
                }
                else {
                    $("#billPart_ddDiscountPercent").prop("disabled", true);
                    $("#billPart_ddlDiscountReason").prop("disabled", true);
         }
                }
                
            }
        }
    }
}




function getOtherCurrAmtValues(pType, ConValue) {
    if (pType == "REC") {
        var pAMt = document.getElementById("billPart_" + ConValue + "_hdnOterCurrReceived").value == "" ? "0" : document.getElementById("billPart_" + ConValue + "_hdnOterCurrReceived").value;
        return parseFloat(pAMt).toFixed(2);
    }
    if (pType == "PAY") {
        var pAMt = document.getElementById("billPart_" + ConValue + "_hdnOterCurrPayble").value == "" ? "0" : document.getElementById("billPart_" + ConValue + "_hdnOterCurrPayble").value;
        return parseFloat(pAMt).toFixed(2);
    }
    if (pType == "SER") {
        var pAMt = document.getElementById("billPart_" + ConValue + "_hdnOterCurrServiceCharge").value == "" ? "0" : document.getElementById("billPart_" + ConValue + "_hdnOterCurrServiceCharge").value;
        return parseFloat(pAMt).toFixed(2);
    }
}
function SetOtherCurrReceived(pCurrAmount, pNetAmount, pServiceCharge, ConValue) {
    var pTotalNetAmt = Number(pNetAmount);
    document.getElementById("billPart_" + ConValue + "_lblOtherCurrRecdAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById("billPart_" + ConValue + "_hdnOterCurrReceived").value = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById("billPart_" + ConValue + "_hdnOterCurrServiceCharge").value = parseFloat(pServiceCharge).toFixed(2);
    ToTargetFormat($("#" + ConValue + "_lblOtherCurrRecdAmount"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrReceived"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrServiceCharge"));
}
function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

    var sVal = 0;
    var ConValue = "OtherCurrencyDisplay1";

    var sVal = getOtherCurrAmtValues("REC", ConValue);
    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
    var tempService = getOtherCurrAmtValues("SER", ConValue);
    var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    sNetValue = format_number(Number(document.getElementById('billPart_hdnNetAmount').value) + Number(ServiceCharge), 2);

    sVal = format_number(Number(sVal) + Number(TotalAmount), 2);

    if (PaymentAmount > 0) {

        if (Number(sNetValue) >= Number(sVal)) {
            sVal = format_number(sVal, 2);
            SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);

            // added for service charges   : document.getElementById('billPart_PaymentType_ddlPaymentType').options[document.getElementById('billPart_PaymentType_ddlPaymentType').selectedIndex].text
            if (document.getElementById('billPart_PaymentType_ddlPaymentType') != undefined && document.getElementById('billPart_PaymentType_ddlPaymentType') != null)
            {

                var pSrv = document.getElementById('billPart_PaymentType_ddlPaymentType').options[document.getElementById('billPart_PaymentType_ddlPaymentType').selectedIndex].text
                var serviceAmt = document.getElementById('billPart_txtServiceCharge').value;  
            }
            //end
            if (pSrv == "Cash") {
                document.getElementById('billPart_txtServiceCharge').value = parseFloat(serviceAmt).toFixed(2);
                ToTargetFormat($('#billPart_txtServiceCharge'));

                document.getElementById('billPart_hdnServiceCharge').value = format_number(serviceAmt, 2);
                ToTargetFormat($('#billPart_hdnServiceCharge'));
            } 
            else {
                document.getElementById('billPart_txtServiceCharge').value = parseFloat(pScrAmt).toFixed(2);
                ToTargetFormat($('#billPart_txtServiceCharge'));

                document.getElementById('billPart_hdnServiceCharge').value = format_number(pScrAmt, 2);
                ToTargetFormat($('#billPart_hdnServiceCharge'));
            }

            document.getElementById('billPart_txtAmtReceived').value = parseFloat(pAmt).toFixed(2);
            ToTargetFormat($('#billPart_txtAmtReceived'));
            document.getElementById('billPart_hdnAmountReceived').value = parseFloat(pAmt).toFixed(2);
            ToTargetFormat($('#billPart_hdnAmountReceived'));

            document.getElementById('billPart_txtNetAmount').value = sNetValue;
            ToTargetFormat($('#billPart_txtNetAmount'));
            document.getElementById('billPart_hdnNetAmount').value = sNetValue;
            ToTargetFormat($('#billPart_hdnNetAmount'));

            if (sNetValue == '0.00') {
                document.getElementById('billPart_txtDue').value = sNetValue;
                ToTargetFormat($('#billPart_txtDue'));
                document.getElementById('billPart_hdnDue').value = sNetValue;
                ToTargetFormat($('#billPart_hdnDue'));
            }

            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);
            document.getElementById('billPart_hdnPaymentControlReceivedtemp').value = format_number(Number(pAmt), 2);
            ToTargetFormat($('#billPart_hdnPaymentControlReceivedtemp'));
            SetNetValue("ED");
            return true;

        }
        else {
            var objvar2 = SListForAppMsg.Get("Scripts_CommonBiling_js_26") == null ? "Amount received is greater than net amount" : SListForAppMsg.Get("Scripts_CommonBiling_js_26");
            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
            ValidationWindow(objvar2, objAlert);
            //alert('Amount received is greater than net amount')
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
    document.getElementById('billPart_hdnServiceCharge').value = format_number(pScrAmt, 2);
    ToTargetFormat($('#billPart_hdnServiceCharge'));
    document.getElementById('billPart_txtServiceCharge').value = parseFloat(pScrAmt).toFixed(2);
    ToTargetFormat($('#billPart_txtServiceCharge'));

    document.getElementById('billPart_txtNetAmount').value = (Number(document.getElementById('billPart_txtNetAmount').value) - Number(ServiceCharge)).toFixed(2);
    ToTargetFormat($('#billPart_txtNetAmount'));
    document.getElementById('billPart_hdnNetAmount').value = document.getElementById('billPart_txtNetAmount').value;
    ToTargetFormat($('#billPart_hdnNetAmount'));

   //VEL

    document.getElementById('billPart_txtMRPNetAmount').value = (Number(document.getElementById('billPart_txtMRPNetAmount').value) - Number(ServiceCharge)).toFixed(2);
    ToTargetFormat($('#billPart_txtMRPNetAmount'));
    document.getElementById('billPart_hdnMRPNetAmount').value = document.getElementById('billPart_txtMRPNetAmount').value;
    ToTargetFormat($('#billPart_hdnMRPNetAmount'));
     
    //VEL

    var amtRec = 0;
    document.getElementById('billPart_hdnAmountReceived').value = format_number(Number(sVal) + Number(amtRec), 2);
    ToTargetFormat($('#billPart_hdnAmountReceived'));
    document.getElementById('billPart_txtAmtReceived').value = parseFloat(Number(sVal) + Number(amtRec)).toFixed(2);
    ToTargetFormat($('#billPart_txtAmtReceived'));
    SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);
    SetNetValue("ED");



}
function ClearPaymentControlEvents1() {
    document.getElementById('billPart_PaymentType_hdfPaymentType').value = "";
    PaymentControlclear1();
    CreatePaymentTables();
    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrPayble').value = "0";
    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrReceived').value = "0";
    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrServiceCharge').value = "0";
}
function PaymentControlclear1() {
    document.getElementById('billPart_PaymentType_txtAmount').value = document.getElementById('billPart_PaymentType_hdfDefaultPaymentMode').value;
    ToTargetFormat($('#billPart_PaymentType_txtAmount'));
    document.getElementById('billPart_PaymentType_txtAmount').value = "";
    document.getElementById('billPart_PaymentType_txtNumber').value = "";
    document.getElementById('billPart_PaymentType_txtBankType').value = "";
    document.getElementById('billPart_PaymentType_txtRemarks').value = "";
    document.getElementById('billPart_PaymentType_txtServiceCharge').value = "0";
    document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = "";
    document.getElementById('billPart_txtAmtReceived').value = "0.00";
    document.getElementById('billPart_hdnAmountReceived').value = (0).toFixed(2);
    ToTargetFormat($('#billPart_hdnAmountReceived'));
}

function ClearSelectedData() {

    document.getElementById('billPart_txtTestName').value = '';
    document.getElementById('billPart_hdnID').value = 0;
    document.getElementById('billPart_hdnName').value = '';
    document.getElementById('billPart_hdnInvCode').value = '';
    document.getElementById('billPart_hdnFeeTypeSelected').value = "COM";
    document.getElementById('billPart_hdnAmt').value = 0;
    document.getElementById('billPart_hdnRemarks').value = '';
    document.getElementById('billPart_hdnIsRemimbursable').value = '';
    document.getElementById('billPart_hdnReportDate').value = '';
    document.getElementById('billPart_hdnActualAmount').value = '';
    document.getElementById('billPart_hdnBaseRateID').value = 0;
    document.getElementById('billPart_hdnIsDiscountableTest').value = "Y";
    document.getElementById('billPart_hdnIsRepeatable').value = "N";
    document.getElementById('billPart_hdnIsSTAT').value = "N";
    document.getElementById('billPart_hdnIsSMS').value = "N";
    document.getElementById('billPart_hdnIsOutSource').value = "N";
    document.getElementById('billPart_hdnoutsourcelocation').value = "";
    document.getElementById('billPart_hdnIsTaxable').value = "Y";
    document.getElementById('billPart_hdnIsNABL').value = "Y";
    document.getElementById('billPart_hdnBillingItemRateID').value = "0";
    document.getElementById('billPart_hdnHasHistory').value = "N";
    document.getElementById('billPart_txtTestName').focus();
    document.getElementById('billPart_hdnIshtml').value = "N";
    document.getElementById('billPart_hdnIsTemplateID').value = '';
    document.getElementById('billPart_hdnIsTemplateText').value='';
    //document.getElementById('billPart_btnAdd').disabled = true;
    if (document.getElementById('billPart_hdfBillType1').value == '')
        document.getElementById('billPart_spanAddItems').style.display = "block";
    if (document.getElementById('billPart_hdfBillType1').value != '')
        document.getElementById('billPart_spanAddItems').style.display = "none";

    document.getElementById('billPart_UcHistory_hdnHistoryIds').value = '';
}
function btnDeleteBillingItems_OnClick1(sEditedData) {
    ClearPaymentControlEvents1();
    var PaymentAAlreadyPresent = new Array();
    var iPaymentAlreadyPresent = 0;
    var iPaymentCount = 0;

    var PaymenttempDatas = document.getElementById('billPart_hdfBillType1').value;

    PaymentAAlreadyPresent = PaymenttempDatas.split('|');
    if (PaymentAAlreadyPresent.length > 0) {
        for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
            if (PaymentAAlreadyPresent[iPaymentCount].toLowerCase() == sEditedData.toLowerCase()) {

                var tempFeeID, tempFeeType, tempOtherID, iChild, tempFeeDate, tempNRI;
                var arrayChildData = new Array();

                arraySubData = PaymentAAlreadyPresent[iPaymentCount].split('~');

                DeleteFindduplicatcatsItems(arraySubData[0].split('^')[1]);
                deleteHistory(arraySubData[0].split('^')[1]);

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
                        //                        DeleteFindduplicatcatsItems(tempFeeID);
                    }
                }

                //                if ("PKG" == tempFeeType) {
                //                    showorHidechkBox(tempFeeID);
                //                }
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

    if (PaymenttempDatas.split('|').length < 3) {
        $("#billPart_hdnTotalRedeemPoints").val("0.00");
        $("#billPart_hdnTotalRedeemAmount").val("0.00");
        $("#billPart_hdntotalredemPoints").val("0.00");
        $('#billPart_txtRedeem').val("0.00");
        $('#billPart_hdnRedeemValue').val("0.00");
        $('#billPart_hdnRedeemPoints').val("0.00");
    }
    else {

    }
    FeeGotValue = sEditedData.split('~');
    var FeeID;

    if (FeeGotValue.length > 0) {
        FeeID = FeeGotValue[2];

        arrayAmount = FeeID.split('^');
    }
    // Delete Test History Seetha
    var Feevalues = new Array();
    Feevalues = sEditedData.split('~');
    var FeeID1, FeeType1;

    if (Feevalues.length > 0) {
        FeeID1 = Feevalues[0];
        FeeType1 = Feevalues[1];
        FeeID1 = FeeID1.split('^');
        FeeType1 = FeeType1.split('^');
        FeeID1 = FeeID1[1];
        FeeType1 = FeeType1[1];
    }
    var TestHistory = document.getElementById('hdnTestHistoryPatient').value;
     DeleteTestHistory(TestHistory, FeeID1, FeeType1);

    // Seetha
    document.getElementById('billPart_hdfBillType1').value = PaymenttempDatas;
    //$('[id$="hdfBillType1"]').val(PaymenttempDatas);
    CreateBillItemsTable(0);
    DeleteAmountValue(0, 0, 0);
    ClearPaymentControlEvents();
    if (tempFeeID > 0) {
        DeleteHistoSpecimenDetails(tempFeeID);
    }
    var GrossAmt = document.getElementById('billPart_hdnGrossValue').value;
    if (GrossAmt < 0) {
        defaultbillflag = 0;
    }
    //VEL
    //SetGrossValue(GrossAmt);
    var MRPGrossAmt = document.getElementById('billPart_hdnMRPGrossValue').value;
    if (MRPGrossAmt < 0) {
        MRPGrossAmt = 0;
    }
    SetGrossValue(GrossAmt,MRPGrossAmt);
    //VEL
    SetOtherCurrValues();

    // Co Paymnet//
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

function DeleteTestHistory(TestHistory, FeeID1, FeeType1) {




    $.ajax({
        type: "POST",
        url: "../WebService.asmx/DeleteTestHistoryFieldDetails",
        data: "{ 'JsonData': '" + TestHistory + "','FeeID':" + FeeID1 + ",'FeeType':'" + FeeType1 + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {

            document.getElementById('hdnTestHistoryPatient').value = data.d;

        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }
    });


  
}

function ClearControlValues() {
    document.getElementById('billPart_PaymentType_hdfPaymentType').value = "";
    document.getElementById('billPart_PaymentType_hdnPaymentsDeleted').value = "";
    if (document.getElementById('billPart_UctHistory_txtAttribute1') != null) {
        document.getElementById('billPart_UctHistory_txtAttribute1').value = "";
    }
    if (document.getElementById('billPart_UctHistory_txtAttribute2') != null) {
        document.getElementById('billPart_UctHistory_txtAttribute2').value = "";
    }
    if (document.getElementById('billPart_UctHistory_txtAttribute3') != null) {
        document.getElementById('billPart_UctHistory_txtAttribute3').value = "";
    }
    if (document.getElementById('billPart_UctHistory_txtAttribute4') != null) {
        document.getElementById('billPart_UctHistory_txtAttribute4').value = "";
    }
    if (document.getElementById('billPart_UctHistory_txtAttribute5') != null) {
        document.getElementById('billPart_UctHistory_txtAttribute5').value = "";
    }
    document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference').value = "";
    document.getElementById('billPart_PaymentType_hdnOtherCurrencyID').value = "0";
    document.getElementById('billPart_PaymentType_hdnOtherCurrency').value = "0";
    document.getElementById('billPart_PaymentType_hdnPayVariableAmount').value = "0";
    document.getElementById('billPart_PaymentType_hdnRecdAmount').value = "0";
    document.getElementById('billPart_PaymentType_hdnlastreceivedamt').value = "0";
    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrPayble').value = "0";
    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrReceived').value = "0";
    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrServiceCharge').value = "0";
    document.getElementById('ddCountry').value = document.getElementById('hdnDefaultCountryID').value;
    if (document.getElementById('hdnBillingPageName').value != 'CB') {
        //loadState("0");
    }
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

function SelectedTempClient(source, eventArgs) {
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_Alert");
    var objvar35 = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_62") == null ? "Please select client from the list" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_62");

    document.getElementById('hdnSelectedClientTempDetails').value = eventArgs.get_value();
    //    ShowClientDetails();
    //    TbClientlist();
    $find('AutoCompleteExtenderClientCorp')._onMethodComplete = function(result, context) {
        //var Perphysicianname = document.getElementById('txtperphy').value;
        $find('AutoCompleteExtenderClientCorp')._update(context, result, /* cacheResults */false);
        if (result == "") {
            // alert('Please select client from the list');
            ValidationWindow(objvar35, objAlert);

            document.getElementById('txtClient').value = "";
            document.getElementById("hdnIsCashClient").value = 'N';
        }
    };

}
function GetTempReferingHospID(source, eventArgs) {
    var objvar36 = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_63") == null ? "Please select hospital from the list" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_63");
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_Alert");

    $find('AutoCompleteExtenderReferringHospital')._onMethodComplete = function(result, context) {
        //var Perphysicianname = document.getElementById('txtperphy').value;
        $find('AutoCompleteExtenderReferringHospital')._update(context, result, /* cacheResults */false);
        if (result == "") {
            //alert('Please select hospital from the list');
            ValidationWindow(objvar36, objAlert);
            $('[id$="txtReferringHospital"]').val("");
        }
    };

}
function PhysicianTempSelected(source, eventArgs) {
    var AlertType = SListForAppMsg.Get('Billing_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_Header_Alert');
    var vRefAlert = SListForAppMsg.Get('Billing_LabQuickBilling_aspx_09') == null ? "Please select the physician from the completion list" : SListForAppMsg.Get('Billing_LabQuickBilling_aspx_09');
    $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
        //var Perphysicianname = document.getElementById('txtperphy').value;
        $find('AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
        if (_AllowFreeText != 'Y') {
            if (result == "") {
                ValidationWindow(vRefAlert, AlertType);
                //alert('Please select the physician from the completion list');
                document.getElementById('txtInternalExternalPhysician').value = '';
            }
        }
    };

}
function ShowClientDetails() {
    $('[id$="divShowClientDetails"]').hide();
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    $('[id$="lblClientDetails"]').html("");
    table = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
                           + "<th style='width:80px;'>Client Name</th>"
                           + "<th style='width:50px;'>Client Type</th> </thead>";
    var SelectedClientList = document.getElementById('hdnSelectedClientTempDetails').value.split("###");
    var SelectedClientListDetails = SelectedClientList[0].split('^');
    tr = "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
                        + SelectedClientListDetails[1] + "</td><td style='width:100px;'>"
                        + SelectedClientListDetails[11] + "</td></tr>";



    var tab = table + tr + end;
    $('[id$="lblClientDetails"]').html(tab);

}
function TbClientlist() {
    var y = '';
    var x = document.getElementById('hdnSelectedClientTempDetails').value.split("###");
    var ddlobj = document.getElementById("ddlRate");
    ddlobj.options.length = 0;
    for (i = 0; i < x.length - 1; i++) {
        var y = x[i].split("^");
        var client = y[4].split("~");
        var opt = document.createElement("option");
        document.getElementById("ddlRate").options.add(opt);
        opt.text = client[1];
        opt.value = client[0];
    }

}
function ClearRate() {

    objSelect = SListForAppMsg.Get("Scripts_CommonBiling_js_04") == null ? "--Select--" : SListForAppMsg.Get("Scripts_CommonBiling_js_04");
    if (($("#txtClient").val() == "" || $("#billPart_hdnHasClientHealthcoupon").val() == "Y") && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y") {
        document.getElementById("billPart_dvHealhcard").style.display = "block";
        $("#billPart_hdnIsCashClient").val() == "Y";

        CheckMyCard();
    }
    else {
        document.getElementById("billPart_dvHealhcard").style.display = "none";

        CheckMyCard();
    }
    if (document.getElementById('txtClient').value == '') {
        document.getElementById('hdnSelectedClientClientID').value = 0;
        var ddlobj = document.getElementById("ddlRate");
        ddlobj.options.length = 0;
        var opt1 = document.createElement("option");
        document.getElementById("ddlRate").options.add(opt1);
        opt1.text = objSelect;
        opt1.value = "0";
        if (document.getElementById('billPart_hdnCpedit').value == "Y") {
            AddBillingItemsDetailsForEdit(-1);
        }
    }
    if ($('[id$="hdnBillingPageName"]').val() == 'LABB') {
        if ($.trim($('[id$="txtClient"]').val()) != '') {
            $('[id$="ddlDespatchMode"]').val("0");
            $('[id$="ddlDespatchMode"]').attr("disabled", true);
        }
        else {
            $('[id$="ddlDespatchMode"]').val("0");
            $('[id$="ddlDespatchMode"]').attr("disabled", false);
        }
    }
    $('[id$="txtDiscount"]').attr("readOnly", false);
    $('[id$="txtAuthorised"]').attr("readOnly", false);
    $('[id$="txtDiscountReason"]').attr("readOnly", false);
    // DisplayCoPayMent();
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
    document.getElementById("ShowPreviousData").style.display = "block";

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
    var pnetAmt = document.getElementById('billPart_hdnNetAmount').value;
    var ConValue = "OtherCurrencyDisplay1";
    SetPaybleOtherCurr(pnetAmt, ConValue, true);

}
function SetOtherCurrPayble(pCurrName, pCurrAmount, pNetAmount, ConValue, IsDisplay) {

    var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(4) / parseFloat(pCurrAmount).toFixed(2)).toFixed(4);
    document.getElementById("billPart_" + ConValue + "_lblOtherCurrPaybleName").innerHTML = pCurrName;
    document.getElementById("billPart_" + ConValue + "_lblOtherCurrRecdName").innerHTML = pCurrName;
    document.getElementById("billPart_" + ConValue + "_lblOtherCurrPaybleAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById("billPart_" + ConValue + "_hdnOterCurrPayble").value = parseFloat(pTotalNetAmt).toFixed(4);
    ToTargetFormat($("#" + ConValue + "_lblOtherCurrPaybleAmount"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrPayble"));
}
function isOtherCurrDisplay(pType) {
    if (pType == "B") {
        //        document.getElementById("OtherCurrencyDisplay1_tbOtherCurr").style.display = "block";
    }
}
function isOtherCurrDisplay1(pType) {
    if (pType == "B") {
        document.getElementById("billPart_" + "OtherCurrencyDisplay1_tbAmountPayble").style.display = "table-row";
        document.getElementById("billPart_" + "trOtherCurrency").style.display = "table-row";
    }
    if (pType == "N") {
        document.getElementById("billPart_" + "OtherCurrencyDisplay1_tbAmountPayble").style.display = "none";
        document.getElementById("billPart_" + "trOtherCurrency").style.display = "none";
    }


}
function setSexValueQBLab(sexId, msId, ddMaritalID, Type) {
    document.getElementById('hdnGender').value = '';
    //       alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //        alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
    if (document.getElementById(msId).value == '6'
    || document.getElementById(msId).value == '7'
    || document.getElementById(msId).value == '8'
    || document.getElementById(msId).value == '12'
    || document.getElementById(msId).value == '9'
    || document.getElementById(msId).value == '4'
    || document.getElementById(msId).value == '19'
    || document.getElementById(msId).value == '20') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '1'
    || document.getElementById(msId).value == '2'
    || document.getElementById(msId).value == '3'
    || document.getElementById(msId).value == '11'
    || document.getElementById(msId).value == '15') {
        document.getElementById(sexId).value = 'F';
    }
    else if (document.getElementById(msId).value == '14') {
        document.getElementById(sexId).value = '0';
      
    }
    else if (document.getElementById(msId).value == '22') {
        document.getElementById(sexId).value = 'F';
    }
    else {
        if (Type != 'ddlgender') {
            document.getElementById(sexId).value = '0';
        }
    }
    if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4') {
        // document.getElementById(ddMaritalID).value = 'S';
    }
    else if (document.getElementById(msId).value == '3') {
        //        if (document.getElementById(ddMaritalID) != null) {
        //            document.getElementById(ddMaritalID).value = 'M';
        //        }
    }
    else if ((document.getElementById(msId).value == '7' || document.getElementById(msId).value == '5')) {
        document.getElementById(ddMaritalID).value = '0';
    }

    var Gender = document.getElementById(sexId).value;
    document.getElementById('hdnGender').value = Gender;
  document.getElementById('hdnGender').value = Gender;
       if( Gender =='M' || Gender =='F')
    {
        if (document.getElementById('hdnBabysalutationeditgender').value == "Y" && document.getElementById(msId).value == '15') {
            $('#ddlSex').attr("disabled", false);
        }
        else {
            $('#ddlSex').attr("disabled", true);
        }
    }
    else
    {
       $('#ddlSex').attr("disabled", false); 
        
    }


}
function setSalutationValueQBLab(sexId, msId, ddMaritalID, Type) {
    //        if (document.getElementById(sexId).value == 'M') {
    //            document.getElementById(msId).value = '7';
    //        }
    //        else if (document.getElementById(sexId).value == 'F') {
    //            document.getElementById(msId).value = '2';
    //        }
    //        else if (document.getElementById(sexId).value == '0') {
    //            document.getElementById(msId).value = '0';
    //        }
    //    if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4') {
    //        document.getElementById(ddMaritalID).value = 'S';
    //    }
    //    else if (document.getElementById(msId).value == '3') {
    //        if (document.getElementById(ddMaritalID) != null) {
    //            document.getElementById(ddMaritalID).value = 'M';
    //        }
    //    }
    //    else if ((document.getElementById(msId).value == '7')) {
    //        document.getElementById(ddMaritalID).value = '0';
    //    }

    //    var Gender = document.getElementById(sexId).value;
    //    document.getElementById('hdnGender').value = Gender;
    //    if (document.getElementById(msId).value == '1'
    //    || document.getElementById(msId).value == '3'
    //    || document.getElementById(msId).value == '8' 
    //    || document.getElementById(msId).value == '12') {
    //        document.getElementById(sexId).value = 'M';
    //    }
    //    else if (document.getElementById(msId).value == '2'
    //    || document.getElementById(msId).value == '4'
    //    || document.getElementById(msId).value == '9'
    //    || document.getElementById(msId).value == '10' 
    //    || document.getElementById(msId).value == '11') {
    //        document.getElementById(sexId).value = 'F';
    //    }

    var Gender = document.getElementById(sexId).value;
    document.getElementById('hdnGender').value = Gender;
    ClearOrderedItems();
}
//Added by Arivalagan.kk Co Paymnet//
function GetGenderValue(sexId) {
    var Gender = document.getElementById(sexId).value;
    if (document.getElementById('hdnchangedGender') != null) {
        document.getElementById('hdnchangedGender').value = Gender;
    }
}
function ClearOrderedItems() {
    var objDelOrder = SListForAppMsg.Get("Scripts_CommonBiling_js_03") == null ? "Delete the Ordered Items then only you can Change.\n Do you want to delete the items, Press OK Else Cancel" : SListForAppMsg.Get("Scripts_CommonBiling_js_03");
    if (document.getElementById('billPart_hdnCpedit').value != "Y") {
        if (document.getElementById('billPart_hdfBillType1').value != '') {
            var pBill = confirm(objDelOrder);
            if (pBill != true) {
                document.getElementById('billPart_txtTestName').focus();
                if (document.getElementById('hdnchangedGender') != null) {
                    $("#ddlSex").val(document.getElementById('hdnchangedGender').value);
                    document.getElementById('hdnGender').value = document.getElementById('hdnchangedGender').value;
                }
                return false;
            }
            else {
                ClearmycardDetails('N');
                //document.getElementById('txtClient').value = '';
                document.getElementById('billPart_hdfBillType1').value = '';
                document.getElementById('billPart_hdnfinduplicate').value = ''
                document.getElementById('hdnRateID').value = Number(document.getElementById('hdnBaseRateID').value);
                document.getElementById('hdnClientID').value = Number(document.getElementById('hdnBaseClientID').value);
                if (!isNaN(Number(document.getElementById('hdnBaseClientID').value)))
                {
                document.getElementById('hdnSelectedClientClientID').value = Number(document.getElementById('hdnBaseClientID').value);
                }
                document.getElementById('hdnIsCashClient').value = 'N';

                var ddlobj = document.getElementById("ddlRate");
                ddlobj.options.length = 0;
                defaultbillflag = 0
                CreateBillItemsTable(1);
                ClearPaymentControlEvents1();
                // document.getElementById('txtClient').focus();
                //Added by Arivalagan.kk Co Paymnet//
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
                //End Added by Arivalagan.kk Co Paymnet//
            }
        }
        //        else {
        //            if ($("#txtClient").val() == "" && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y") {
        //                document.getElementById("billPart_dvHealhcard").style.display = "block";

        //                CheckMyCard();
        //            }
        //        }
    }
    return true;
    //Added by Arivalagan.kk Co Paymnet//
}


function setSexValueoptLab(sexId, msId) {
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);

    if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }

    var Gender = document.getElementById(sexId).value;
    document.getElementById('hdnGender').value = Gender;
    ClearOrderedItems();
}
function pageLoad() {

    if ($find('billPart_AutoCompleteExtender3') != null && $find('billPart_AutoCompleteExtender3')._onMethodComplete != undefined) {
        $find('billPart_AutoCompleteExtender3')._onMethodComplete = function(result, context) {

            $find('billPart_AutoCompleteExtender3')._update(context, result, /* cacheResults */false);

            webservice_callback(result, context);
        };

    }
}
function webservice_callback(result, context) {
    var objService = SListForAppMsg.Get("Scripts_CommonBiling_js_27") == null ? "This Services would not been available for this Client (or) it would be a Gender based test." : SListForAppMsg.Get("Scripts_CommonBiling_js_27");

    if (result == "") {
        //document.getElementById('billPart_alert').innerHTML = 'This Services would not been available for this Client (or) it would be a Gender based test.';
        document.getElementById('billPart_alert').innerHTML = objService;
    }
    else {
        document.getElementById('billPart_alert').innerHTML = "";
    }
}
function ClearDOB() {
    var objVaildyr = SListForAppMsg.Get("Scripts_CommonBiling_js_28") == null ? "Provide a valid Age" : SListForAppMsg.Get("Scripts_CommonBiling_js_28");
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    if (document.getElementById('billPart_hdnValidation') != null) {
        document.getElementById('billPart_hdnValidation').value = 'Y';
    }
    if (document.getElementById('txtDOBNos').value < 0) {
        document.getElementById('txtDOBNos').value = '';
    }
    if (document.getElementById('txtDOBNos').value > 120) {
        //alert('Provide a valid Age');
        ValidationWindow(objVaildyr, objAlert);
        document.getElementById('tDOB').value = "dd/MM/yyyy";
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('txtDOBNos').focus();
        return false;
    }
    var valAge = 120;
    var valage1 = 95;
    var objAgeGreater = SListForAppMsg.Get("Scripts_CommonBiling_js_29") == null ? "Age Should not be Greater than 105" : SListForAppMsg.Get("Scripts_CommonBiling_js_29");
    var objvar3 = SListForAppMsg.Get("Scripts_CommonBiling_js_30") == null ? "Age is Greater than 95 Do You want to continue" : SListForAppMsg.Get("Scripts_CommonBiling_js_30");
    var AGE = document.getElementById('txtDOBNos').value;
    if (AGE > valAge) {
        //alert('Age Should not be Greater than 120');
        ValidationWindow(AlertMesg, objAlert);
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('tDOB').value = "dd/MM/yyyy";
        return false;
    }
    /*********Modified by ********/
    //    else if (AGE >= valage1 && AGE <= valAge) {
    //        var Userval = confirm('Age is Greater than 95 Do You want to continue');
    //    }
}
var retVal = true;
function DuplicateInv(Id, Type, IsSpecialTest) {

    btnoktext = SListForAppMsg.Get("Scripts_CommonBiling_js_50") == null ? "OK" : SListForAppMsg.Get("Scripts_CommonBiling_js_50");
    btnclosetext = SListForAppMsg.Get("Scripts_CommonBiling_js_51") == null ? "Cancel" : SListForAppMsg.Get("Scripts_CommonBiling_js_51");
    
    var FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;
    var boolval = true;
    var FeeGotValue = new Array();
    var setvar = "";
   // var OrgID = document.getElementById('hdnOrgID').value;
    if (document.getElementById('billPart_hdnfinduplicate').value != '' && document.getElementById('billPart_hdnallowduplicatetesttobill').value != 'Y')
     {
        setvar = document.getElementById('billPart_hdnfinduplicate').value;
        document.getElementById('billPart_hdnfinduplicate').value = '';
    }
    var FeeID = document.getElementById('billPart_hdnID').value;
    var Descrip = document.getElementById('billPart_hdnName').value;
    var FeeType = document.getElementById('billPart_hdnFeeTypeSelected').value;
    // var Amount = document.getElementById('billPart_hdnAmt').value;
    var Amount = ToInternalFormat($("#billPart_hdnAmt"));
    var Remarks = document.getElementById('billPart_hdnRemarks').value;
    var IsRI = document.getElementById('billPart_hdnIsRemimbursable').value;
    var ReportDate = document.getElementById('billPart_hdnReportDate').value;
    //var ActualAmount = document.getElementById('billPart_hdnActualAmount').value;
    var ActualAmount = ToInternalFormat($("#billPart_hdnActualAmount"));
    var BaseRateID = document.getElementById('billPart_hdnBaseRateID').value;
    var DiscountPolicyID = document.getElementById('billPart_hdnDiscountPolicyID').value;
    var DiscountCategoryCode = document.getElementById('billPart_hdnDiscountCategoryCode').value;
    var ReportDeliveryDate = document.getElementById('billPart_hdnDeliveryDate').value;
    var IsDiscountable = document.getElementById('billPart_hdnIsDiscountableTest').value;
    var IsTaxable = document.getElementById('billPart_hdnIsTaxable').value;
    var IsRepeatable = document.getElementById('billPart_hdnIsRepeatable').value;
    var IsSTAT = document.getElementById('billPart_hdnIsSTAT').value;
    var IsSMS = document.getElementById('billPart_hdnIsSMS').value;
    var IsOutSource = document.getElementById('billPart_hdnIsOutSource').value;

    if (document.getElementById('billPart_hdnoutsourcelocation').value != null && document.getElementById('billPart_hdnoutsourcelocation').value != 'N') {
        var outRInSourceLocation = document.getElementById('billPart_hdnoutsourcelocation').value;
    }
    else {
        var outRInSourceLocation = document.getElementById('billPart_hdnProcessingLoc').value;
    }


    var IsNABL = document.getElementById('billPart_hdnIsNABL').value;
    var BillingItemRateID = document.getElementById('billPart_hdnBillingItemRateID').value;
    var Code = document.getElementById('billPart_hdnInvCode').value;
    var HasHistory = document.getElementById('billPart_hdnHasHistory').value;
    var Ishtmltab = document.getElementById('billPart_hdnIshtml').value;
    var IsTemplateID = document.getElementById('billPart_hdnIsTemplateID').value;
    var MaxDiscount = document.getElementById('billPart_hdnMaxDiscount').value;
    var IsNormalRateCard = document.getElementById('billPart_hdnIsNormalRateCard').value;
    var IsRedeem = document.getElementById('billPart_hdnIsRedeem').value;
    var RedeemAmount = document.getElementById('billPart_hdnRedeemAmount').value;
    var LstTestAdded = {};
    var oTestAdded = [];
    var IsSampleContainerMatch = 0;
    if (document.getElementById('hdnDoFrmVisit').value != "") {
        if (document.getElementById('hdnSampleforPrevious').value != '') {
            var lstSampleContainer = JSON.parse($('input[id$="hdnSampleforPrevious"]').val());
        }
    }

    if (Id != undefined && Type != undefined) {
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetInvestigationInfo",
            data: "{ 'ID': '" + Id + "','Type': '" + Type + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                var Items = data.d;
                if (document.getElementById('hdnDoFrmVisit').value != "") {
                    if (document.getElementById('hdnSampleforPrevious').value != '') {
                        var SampleCount = lstSampleContainer.length;
                    }
                }
                var i = 0;
                $.each(Items, function(index, Item) {
                    //  alert(Item.InvestigationID);
                    document.getElementById('billPart_hdnfinduplicate').value += Item.InvestigationID + '~' + Item.InvestigationValueID + '~' +
		Item.InvestigationName + '~' + Type + '~' + Item.ConvUOMCode + '~' + Item.ConvValue + '^';
                    //                document.getElementById('hdnsampleforcurrent').value += Item.SampleCode + '~' + Item.SampleContainerID;
                    if (document.getElementById('hdnDoFrmVisit').value != "") {
                        if (document.getElementById('hdnSampleforPrevious').value != '') {
                            for (i = 0; i < SampleCount; i++) {
                                if (lstSampleContainer[i].SampleCode == Item.SampleCode) {
                                    if (lstSampleContainer[i].SampleContainerID == Item.SampleContainerID) {
                                        IsSampleContainerMatch = 1;
                                    }
                                }
                            }
                        }
                    }
                    //FindDuplicate(Item.InvestigationID, Type)

                });
                if (Type !='PKG' && document.getElementById('hdnExternalBarcode').value == "Y" && document.getElementById('billPart_chkAddExtraTest').checked == true) {
                    var ItemArray = new Array();
                    var listLen = 0;
                    var sampleName;
                    var containername;
                    var IsSameSample = 'N';
                    var IsRejectorNotGiven = '';
                    listLen = document.getElementById('hdnPreviousVisitDetails').value.split('^').length;
                    ItemArray = document.getElementById('hdnPreviousVisitDetails').value.split('^');
                    var SampleArray = document.getElementById('billPart_hdnfinduplicate').value.split('^'); ;
                    var SampleSplit;
                    SampleSplit = SampleArray[0].split('~');
                    if (listLen > 0) {
                        for (var i = 0; i < ItemArray.length; i++) {
                            if (ItemArray[i] != "") {
                                res = ItemArray[i].split('$');
                                sampleName = res[11];
                                containername = res[12];
                                
                                    if (SampleSplit[4] == sampleName && SampleSplit[5] == containername) {
                                        IsSameSample = 'Y';
                                    IsRejectorNotGiven = res[14];
                                } 
                            }
                        }

                    }
                    if (IsSameSample != 'Y') {
                        alert("Its not an additional test new sample need to collect for the ordered for the patient ");
                    }
                    if (IsRejectorNotGiven == 'Rejected' || IsRejectorNotGiven == 'Not given') {
                        alert(" Additional test is not possible previous sample rejected/Not given ");
                    }
                }

                //                SetPreviousVisitItems();
                if (setvar != "") {
                    retVal = FindDuplicatesItems(setvar);
                }
                //alert(Items);
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }
    if (document.getElementById('hdnDoFrmVisit').value != "") {
        var objvar4 = SListForAppMsg.Get("Scripts_CommonBiling_js_31") == null ? "This Test's Sample & Container doesn't Match with Previous Items" : SListForAppMsg.Get("Scripts_CommonBiling_js_31");
        if (document.getElementById('hdnSampleforPrevious').value != '') {
            if (document.getElementById('hdnDOFromVisitFlag').value == "0" || document.getElementById('hdnDOFromVisitFlag').value == "1") {
                if (IsSampleContainerMatch == '0') {
                    //alert("This Test's Sample & Container doesn't Match with Previous Items");
                    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                    ValidationWindow(objvar4, objAlert);
                    document.getElementById('billPart_hdnfinduplicate').value = "";//Added by Muthumani.
                    return false;
                }
            }
        }
    }
    if (Descrip != '' && retVal == true) {
        var objvar5 = SListForAppMsg.Get("Scripts_CommonBiling_js_32") == null ? "Item amount is zero.Kindly Map Rate for the Item..." : SListForAppMsg.Get("Scripts_CommonBiling_js_32");
        var objvar6 = SListForAppMsg.Get("Scripts_CommonBiling_js_33") == null ? "Item amount is zero.\n Do you want to add this item" : SListForAppMsg.Get("Scripts_CommonBiling_js_33");
        var pBill;
        if (Number(Amount) <= 0) {
            if (document.getElementById('billPart_hdnZeroAmount').value == 'N' && Id == undefined) {
                //alert("Item amount is zero.Kindly Mapped Rate for the Item...");
                objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                ValidationWindow(objvar5, objAlert);
                return false;
            }
            else {
                //var pBill = confirm("Item amount is zero.\n Do you want to add this item");
                objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                //ValidationWindow(objvar6, objAlert);
                pBill = ConfirmWindow(objvar6, objAlert, btnoktext, btnclosetext);
                if (document.getElementById('billPart_hdnAllowZeroAmt').value == 'Y') {
                    pBill = false;
                }
            }
            if (pBill) {
                CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsNormalRateCard, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID, DiscountCategoryCode, ReportDeliveryDate, MaxDiscount, IsRedeem, RedeemAmount,IsSpecialTest,Ishtmltab, IsTemplateID);
                document.getElementById('billPart_lblInvType').innerHTML = "";
            } else {
                document.getElementById('billPart_txtTestName').value = '';
                document.getElementById('billPart_txtTestName').focus();
            }
        }
        else {
            CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsNormalRateCard, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID, DiscountCategoryCode, ReportDeliveryDate, MaxDiscount, IsRedeem, RedeemAmount,IsSpecialTest,Ishtmltab, IsTemplateID);
            document.getElementById('billPart_lblInvType').innerHTML = "";
        }
    }

    //VEL
    if (document.getElementById('hdnMRPBillDisplay').value == "Y" && Number(ActualAmount) <= 0) {
        var objvar5 = SListForAppMsg.Get("Scripts_CommonBiling_js_32") == null ? "Item amount is zero.Kindly Map Rate for the Item..." : SListForAppMsg.Get("Scripts_CommonBiling_js_32");
        objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
        ValidationWindow(objvar5, objAlert);
        document.getElementById('billPart_txtTestName').focus();
        return false;
    }
    //VEL
    
}
function FindDuplicatesItems(setvar) {
    var objvar7 = SListForAppMsg.Get("Scripts_CommonBiling_js_34") == null ? "Selected test is already available as a part of ordered test. You can't order again" : SListForAppMsg.Get("Scripts_CommonBiling_js_34");
    var objvar8 = SListForAppMsg.Get("Scripts_CommonBiling_js_35") == null ? "Selected test is already available as a part of ordered test.Do you want to proceed ?" : SListForAppMsg.Get("Scripts_CommonBiling_js_35");

    //debugger;
    var dup = document.getElementById('billPart_hdnfinduplicate').value.split('^');
    var beforedup = setvar.split('^');
    if (dup.length > 1) {
        for (i = 0; i < dup.length; i++) {
            for (j = 0; j < beforedup.length; j++) {
                if (dup[i] != "") {
                    if (dup[i].split('~')[0] == beforedup[j].split('~')[0]) {
                        var Userval = false;
                        if (document.getElementById('billPart_hdnallowduplicatetesttobill1').value != 'Y') {
                            if ((dup[i].split('~')[3] == 'GEN' || beforedup[j].split('~')[3] == 'GEN') || (dup[i].split('~')[3] == 'INV' || beforedup[j].split('~')[3] == 'INV') || ((dup[i].split('~')[1] == beforedup[j].split('~')[1]) && (dup[i].split('~')[3] == 'GRP' && beforedup[j].split('~')[3] == 'GRP'))
                         || ((dup[i].split('~')[1] == beforedup[j].split('~')[1]) && (dup[i].split('~')[3] == 'PKG' && beforedup[j].split('~')[3] == 'PKG'))) {
                            //alert("Selected test is already available as a part of ordered test. You can't order again");
                            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                            ValidationWindow(objvar7, objAlert);
                            DeleteFindduplicatcatsItems(dup[i].split('~')[1]);
                            document.getElementById('billPart_hdnfinduplicate').value += setvar; //Added by Vijayalakshmi.M
                            ClearSelectedData();
                            }
                            else {
                                var Userval = confirm(objvar8)
                                if (Userval) { document.getElementById('billPart_hdnfinduplicate').value += setvar; }
                                else { document.getElementById('billPart_hdnfinduplicate').value += setvar; DeleteFindduplicatcatsItems(dup[i].split('~')[1]); ClearSelectedData(); closeModdalDialog('mymodaldiag2', 'myModalclass2');}
                            }
                        }
                        else {
                            var Userval = confirm(objvar8)
                            if (Userval) { document.getElementById('billPart_hdnfinduplicate').value += setvar; }
                            else { document.getElementById('billPart_hdnfinduplicate').value += setvar; DeleteFindduplicatcatsItems(dup[i].split('~')[1]); ClearSelectedData(); }
                        }
                        //var Userval = confirm('This Test is already available as a part of Ordered Package / Group.Do you want to proceed ?')
                        //if (Userval) { document.getElementById('billPart_hdnfinduplicate').value += setvar; }
                        //else { document.getElementById('billPart_hdnfinduplicate').value += setvar; DeleteFindduplicatcatsItems(dup[i].split('~')[1]); ClearSelectedData(); }
                        return Userval;
                    }
                }

            }
        }
        document.getElementById('billPart_hdnfinduplicate').value += setvar;
    }
    return true;
}
function DeleteFindduplicatcatsItems(ID) {
    var temp = $('[id$="hdnfinduplicate"]').val();
    var temp1 = temp.split('^');
    $('[id$="hdnfinduplicate"]').val("");
    if (temp != '') {
        for (i = 0; i < temp1.length; i++) {
            if (temp1[i].split('~')[1] != ID) {
                document.getElementById('billPart_hdnfinduplicate').value += temp1[i] + '^';
            }
        }
    }
}

function PrintBillClear() {
    clearPageControlsValue('N');
    //        return true;
}
function ServiceQuotationClearControls() {
    document.getElementById('txtName').value = "";
    document.getElementById('txtDOBNos').value = "";
    document.getElementById('tDOB').value = "";
    document.getElementById('txtMobileNumber').value = "";
    document.getElementById('txtPhone').value = "";
    document.getElementById('txtEmail').value = "";
    document.getElementById('txtInternalExternalPhysician').value = "";
    document.getElementById('hdnReferedPhyID').value = "";
    document.getElementById('hdnReferedPhyName').value = "";
    document.getElementById('hdnReferedPhysicianCode').value = "";
    document.getElementById('hdnReferedPhyType').value = "";
    $('billPart_tdAttributes').hide();
    $('billPart_dvHealhcard').hide();
    $('billPart_LnkAttributes').hide();
    $('billPart_LnkHistory').hide();
    $('billPart_PanelHistory').hide();
    $('billPart_tdBillDetails').hide();
    $('billPart_tdGrossBillDetails').hide();
    $('billPart_PanelAttributes').hide();
    $('billPart_table_GroupItem').hide();
    $('billPart_Panel1').hide();
}

function clearControls() {

    document.getElementById('txtName').value = "";
    document.getElementById('txtDOBNos').value = "";
    document.getElementById('tDOB').value = "";
    if (document.getElementById('txtExternalVisitID') != null)
        document.getElementById('txtExternalVisitID').value = "";
    if (document.getElementById('txtlabnumber') != null)
        document.getElementById('txtlabnumber').value = "";
    document.getElementById('txtPhleboName').value = "";
    document.getElementById('txtLogistics').value = "";
    document.getElementById('txtRoundNo').value = "";
    document.getElementById('chkExcludeAutoathz').checked = false;
    document.getElementById('HdnPhleboName').value = "";
    document.getElementById('hdnLogisticsName').value = "";
    document.getElementById('hdnLogisticsID').value = "";
    document.getElementById('HdnPhleboID').value = "";
    if (document.getElementById('hdnEdtLogisticsID') !=null)
        document.getElementById('hdnEdtLogisticsID').value = "";
    if (document.getElementById('hdnEdtPhleboID') != null)
        document.getElementById('hdnEdtPhleboID').value = "";
    if (document.getElementById('txtSuburban') != null)
        document.getElementById('txtSuburban').value = "";
    if (document.getElementById('txtAddress') != null)
        document.getElementById('txtAddress').value = "";
    if (document.getElementById('txtCity') != null)
        document.getElementById('txtCity').value = "";
    if (document.getElementById('txtPincode') != null)
        document.getElementById('txtPincode').value = "";
    if (document.getElementById('txtURNo') != null)
    document.getElementById('txtURNo').value = "";
    document.getElementById('txtReferringHospital').value = "";
    document.getElementById('txtInternalExternalPhysician').value = "";
    if (document.getElementById('txtWardNo') != null)
    document.getElementById('txtWardNo').value = "";
    document.getElementById('txtExternalPatientNumber').value = "";
document.getElementById('txtSampleDate').value = today.getDate();
    document.getElementById('txtLocClient').value = "";

    //document.getElementById('chkboxPrintQuotation').checked = false;
    CheckAll();
    document.getElementById('hdnLogisticsName').value = "";
    document.getElementById('tDOB').value = "";
    if (document.getElementById('hdnClientPortal') != null) {
        if (document.getElementById('hdnClientPortal').value != 'Y') {
            if (document.getElementById('hdnLocationclient') !=null && document.getElementById('hdnLocationclient').value != 'Y') {
                document.getElementById('txtzone').value = "";
                document.getElementById('hdnZoneID').value = 0;
            }
        }
    }
    document.getElementById('txtDoFrmVisitNumber').value = "";
    document.getElementById('hdnDoFrmVisit').value = "";
    document.getElementById('ShowBillingItems').style.display = "none";
    document.getElementById('txtMobileNumber').value = "";
    if (document.getElementById('txtPhone') != null)
    document.getElementById('txtPhone').value = "";
    document.getElementById('txtEmail').value = "";
    document.getElementById('chkIncomplete').checked = false;
}
function ClearReadOnlyPropertys() {
var vPatientDetails = SListForAppDisplay.Get("Billing_CommonBilling_js_69") == null ? "Patient Details" : SListForAppDisplay.Get("Billing_CommonBilling_js_69")
    $(function() {
        $("[name='txtName']").prop("disabled", false);
        $("[name='ddSalutation']").prop("disabled", false);
        $("[name='txtDOBNos']").prop("readonly", false);
        $("[name='ddlDOBDWMY']").prop("disabled", false);
        $("[name='ddlSex']").prop("disabled", false);
        $("[name='ddlIsExternalPatient']").prop("disabled", false);
        $("[name='txtExternalPatientNumber']").prop("readonly", false);
        $("[name='txtLocClient']").prop("readonly", false);
        $("[name='txtReferringHospital']").prop("readOnly", false);
        $("[name='txtInternalExternalPhysician']").prop("readOnly", false);
        $("[name='txtEmail']").prop("readonly", false);
        $("[name='chkMobileNotify']").prop("disabled", false);
        $("[name='txtMobileNumber']").prop("readonly", false);
        $("[name='txtRoundNo']").prop("readonly", false);
        $("[name='txtPhleboName']").prop("readonly", false);
        $("[name='txtLogistics']").prop("disabled", false);
        $("[name='chkExcludeAutoathz']").prop("disabled", false);
        $("[name='ddlNationality']").prop("disabled", false);
        $("[name='ddCountry']").prop("readOnly", false);
        $("[name='ddState']").prop("readOnly", false);
        if (document.getElementById('hdnClientPortal') != null) {
            if (document.getElementById('hdnClientPortal').value != 'Y') {
                if (document.getElementById('hdnLocationClient').value != 'Y') {
                    $("[name='txtClient']").prop("disabled", false);
                    $("[name='txtzone']").prop("disabled", false);
                }
            }
        }
        $("[name='tDOB']").prop("disabled", false);
        $('[id$="chkDespatchMode"] input[type=checkbox]').each(function() {
            $('[id$="chkDespatchMode"]').prop('disabled', false);
        });
        var panelLegend = $('#PnlPatientDetail legend');
        panelLegend.html(vPatientDetails);
        $('[id$="chkDespatchMode"] input[type=checkbox]:checked').each(function() {
            $('[id$="chkDespatchMode"] input[type=checkbox]:checked').attr('checked', false);
        });
    });
}
function clearClientControls() {
    document.getElementById('billPart_hdnValidation').value = 'Y';
    ClearReadOnlyPropertys();
    document.getElementById('txtName').value = "";
    document.getElementById('txtDOBNos').value = "";
    document.getElementById('tDOB').value = "";
    document.getElementById('hdnSampleforPrevious').value = "";
    document.getElementById('hdnDoFrmVisit').value = '0';
    document.getElementById('hdnsampleforcurrent').value = '';
    document.getElementById('hdnEdtPatientAge').value = '0';
    document.getElementById('hdnEditDDlDOB').value = '0';
    document.getElementById('hdnEditSex').value = '0';
    document.getElementById('hdnddlsalutation').value = '0';

    document.getElementById('txtPhleboName').value = "";
    document.getElementById('txtLogistics').value = "";
    document.getElementById('txtRoundNo').value = "";
    document.getElementById('chkExcludeAutoathz').checked = false;
    document.getElementById('HdnPhleboName').value = "";
    document.getElementById('hdnLogisticsName').value = "";
    document.getElementById('hdnLogisticsID').value = "";
    document.getElementById('HdnPhleboID').value = "";
    //document.getElementById('hdnEdtLogisticsID').value = "";
    //document.getElementById('hdnEdtPhleboID').value = "";
    //document.getElementById('txtSuburban').value = "";
    //document.getElementById('txtAddress').value = "";
    //document.getElementById('txtCity').value = "";
    //document.getElementById('txtPincode').value = "";
    //document.getElementById('txtURNo').value = "";
    document.getElementById('txtReferringHospital').value = "";
    document.getElementById('txtInternalExternalPhysician').value = "";
    //document.getElementById('txtWardNo').value = "";
    document.getElementById('txtExternalPatientNumber').value = "";
    document.getElementById('txtSampleDate').value = today.getDate();

    //document.getElementById('chkboxPrintQuotation').checked = false;
    CheckAll();
    document.getElementById('hdnLogisticsName').value = "";
    document.getElementById('tDOB').value = "";
    if (document.getElementById('hdnClientPortal').value != 'Y') {
        if (document.getElementById('hdnLocationClient').value != 'Y') {
            document.getElementById('txtzone').value = "";
            document.getElementById('hdnZoneID').value = 0;
        }
    }
    document.getElementById('txtDoFrmVisitNumber').value = "";
    document.getElementById('hdnDoFrmVisit').value = 0;
    document.getElementById('ShowBillingItems').style.display = "none";
    document.getElementById('txtMobileNumber').value = "";
    //document.getElementById('txtPhone').value = "";
    document.getElementById('txtEmail').value = "";
    document.getElementById('hdnpatName').value = "";
    document.getElementById('txtPhleboName').value = "";
    document.getElementById('HdnPhleboID').value = "";
    document.getElementById('HdnPhleboName').value = "";
    document.getElementById('txtName').focus();
}
//This function changed by Arivalagan.kk//
function CheckAll() {
    //var chkbx = document.getElementById("CheckBox2");
    var chkbxList = document.getElementById("chkDisPatchType");
    if (chkbxList != null) {
        var Count = chkbxList.childNodes.length;  //chkbxList.document.getElementById("chkDisPatchType");
        var chkbxListCount = chkbxList.getElementsByTagName('input'); //Count.getElementsByTagName('input');
        // var chkbxListCount = chkbxList.getElementsByTagName('input');
        if (chkbxList.checked == true) {

            for (var i = 0; i < Count.length; i++) {
                chkbxListCount[i].checked = true;
            }
        }
        else {
            for (var i = 0; i < chkbxListCount.length; i++) {
                chkbxListCount[i].checked = false;
            }
        }
        var chkbxList1 = document.getElementById("chkDespatchMode");
        var Count1 = chkbxList1.childNodes.lenght; //chkbxList1.document.getElementById("chkDespatchMode");
        var chkbxListCount1 = chkbxList1.getElementsByTagName('input'); //Count1.getElementsByTagName('input');
        if (chkbxList1.checked == true) {

            for (var i = 0; i < chkbxListCount1.length; i++) {
                chkbxListCount1[i].checked = true;
            }
        }
        else {
            for (var i = 0; i < chkbxListCount1.length; i++) {
                chkbxListCount1[i].checked = false;
            }
        }
    }
}
//End changed by Arivalagan.kk//
function PrintBillItemsTable() {
    var SerQuation = SListForAppDisplay.Get("Billing_CommonBilling_js_33") == null ? "Service Quotation" : SListForAppDisplay.Get("Billing_CommonBilling_js_33");
    var DispPName = SListForAppDisplay.Get("Billing_CommonBilling_js_34") == null ? "Patient Name:" : SListForAppDisplay.Get("Billing_CommonBilling_js_34");
    var DispSex = SListForAppDisplay.Get("Billing_CommonBilling_js_35") == null ? "Sex:" : SListForAppDisplay.Get("Billing_CommonBilling_js_35");
    var DispAge = SListForAppDisplay.Get("Billing_CommonBilling_js_36") == null ? "Age:" : SListForAppDisplay.Get("Billing_CommonBilling_js_36");
    var DispMobNo = SListForAppDisplay.Get("Billing_CommonBilling_js_37") == null ? "Mobile Number:" : SListForAppDisplay.Get("Billing_CommonBilling_js_37");
    var DispTelNo = SListForAppDisplay.Get("Billing_CommonBilling_js_38") == null ? "Telephone:" : SListForAppDisplay.Get("Billing_CommonBilling_js_38");
    var DispEmail = SListForAppDisplay.Get("Billing_CommonBilling_js_39") == null ? "Email:" : SListForAppDisplay.Get("Billing_CommonBilling_js_39");
    var DispCliName = SListForAppDisplay.Get("Billing_CommonBilling_js_40") == null ? "Client Name:" : SListForAppDisplay.Get("Billing_CommonBilling_js_40");
    var DispRefDrName = SListForAppDisplay.Get("Billing_CommonBilling_js_70") == null ? "Ref Doctor:" : SListForAppDisplay.Get("Billing_CommonBilling_js_70");
    var DispBookId = SListForAppDisplay.Get("Billing_CommonBilling_js_71") == null ? "Booking ID:" : SListForAppDisplay.Get("Billing_CommonBilling_js_70");
    
    var vFeeID = SListForAppDisplay.Get("Billing_CommonBilling_js_01") == null ? "FeeID" : SListForAppDisplay.Get("Billing_CommonBilling_js_01");
    var vFeeType = SListForAppDisplay.Get("Billing_CommonBilling_js_02") == null ? "FeeType" : SListForAppDisplay.Get("Billing_CommonBilling_js_02");
    var vS = SListForAppDisplay.Get("Billing_CommonBilling_js_03") == null ? "S.No" : SListForAppDisplay.Get("Billing_CommonBilling_js_03");
    var DispDescrip = SListForAppDisplay.Get("Billing_CommonBilling_js_41") == null ? "Description" : SListForAppDisplay.Get("Billing_CommonBilling_js_41");
    var DispQnty = SListForAppDisplay.Get("Billing_CommonBilling_js_42") == null ? "Quantity" : SListForAppDisplay.Get("Billing_CommonBilling_js_42");
    var DispAmt = SListForAppDisplay.Get("Billing_CommonBilling_js_43") == null ? "Amount" : SListForAppDisplay.Get("Billing_CommonBilling_js_43");
    var DispRmrk = SListForAppDisplay.Get("Billing_CommonBilling_js_44") == null ? "Remarks" : SListForAppDisplay.Get("Billing_CommonBilling_js_44");
    var DispRprtDt = SListForAppDisplay.Get("Billing_CommonBilling_js_45") == null ? "Report Date" : SListForAppDisplay.Get("Billing_CommonBilling_js_45");
    var DispIsReim = SListForAppDisplay.Get("Billing_CommonBilling_js_46") == null ? "IsReimbursable" : SListForAppDisplay.Get("Billing_CommonBilling_js_46");
    var DispActual = SListForAppDisplay.Get("Billing_CommonBilling_js_47") == null ? "ActualAmount" : SListForAppDisplay.Get("Billing_CommonBilling_js_47");
    var DispIsDis = SListForAppDisplay.Get("Billing_CommonBilling_js_48") == null ? "IsDiscountable" : SListForAppDisplay.Get("Billing_CommonBilling_js_48");
    var DispIsTax = SListForAppDisplay.Get("Billing_CommonBilling_js_49") == null ? "IsTaxable" : SListForAppDisplay.Get("Billing_CommonBilling_js_49");
    var DispIsRepeat = SListForAppDisplay.Get("Billing_CommonBilling_js_50") == null ? "IsRepeatable" : SListForAppDisplay.Get("Billing_CommonBilling_js_50");
    var DispIsStat = SListForAppDisplay.Get("Billing_CommonBilling_js_51") == null ? "IsSTAT" : SListForAppDisplay.Get("Billing_CommonBilling_js_51");
    var DispIsSms = SListForAppDisplay.Get("Billing_CommonBilling_js_52") == null ? "IsSMS" : SListForAppDisplay.Get("Billing_CommonBilling_js_52");
    var DispIsSOtSurs = SListForAppDisplay.Get("Billing_CommonBilling_js_53") == null ? "IsOutSource" : SListForAppDisplay.Get("Billing_CommonBilling_js_53");
    var DispIsNabl = SListForAppDisplay.Get("Billing_CommonBilling_js_54") == null ? "IsNABL" : SListForAppDisplay.Get("Billing_CommonBilling_js_54");
    var DispBillItemRate = SListForAppDisplay.Get("Billing_CommonBilling_js_55") == null ? "BillingItemRateID" : SListForAppDisplay.Get("Billing_CommonBilling_js_55");
    var DispHasHistory = SListForAppDisplay.Get("Billing_CommonBilling_js_56") == null ? "HasHistory" : SListForAppDisplay.Get("Billing_CommonBilling_js_56");

    $('[id$="divItemTable"]').val("");
    var startHeaderTag, newPaymentTables, startPaymentTag, endPaymentTag, taxDetailsTag;
    var FeeViewStateValue = $('[id$="hdfBillType1"]').val();
    startHeaderTag = "<table width='100%' class='dataheaderInvCtrl'><tr><td colspan='3'>";
    startHeaderTag = startHeaderTag + "<h3 align='center'><u>" + SerQuation + "</u></h3>";
    startHeaderTag = startHeaderTag + "</td></tr><tr><td colspan='3'> </td></tr><tr><td colspan='3'></td></tr><tr><td colspan='3'>"
    startHeaderTag = startHeaderTag + "</td></tr><tr><td>"
    startHeaderTag = startHeaderTag + DispPName + $('[id$="txtName"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + DispSex + $('[id$="ddlSex"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + DispAge + $('[id$="txtDOBNos"]').val() + ' ' + $('[id$="ddlDOBDWMY"]').val();
    startHeaderTag = startHeaderTag + "</td></tr><tr><td>"
    startHeaderTag = startHeaderTag + DispMobNo + $('[id$="txtMobileNumber"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + DispTelNo + $('[id$="txtPhone"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + DispEmail + $('[id$="txtEmail"]').val();
    startHeaderTag = startHeaderTag + "</td></tr><tr><td colspan='3'> </td></tr><tr><td colspan='3'></td></tr><tr><td colspan='3'>"
    startHeaderTag = startHeaderTag + "</td></tr><tr><td>"
    startHeaderTag = startHeaderTag + "<b>" + DispCliName + "</b> " + $('[id$="txtClient"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + DispRefDrName + $('[id$="txtInternalExternalPhysician"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + DispBookId + $('[id$="hdnId"]').val(); 
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + "</td></tr><tr><td colspan='3'></td></tr><tr><td colspan='3'>"
    startPaymentTag = "<TABLE nowrap='nowrap' ID='tabDrg1' Cellpadding='0' Cellspacing='0' border='1' width='100%' class='dataheaderInvCtrl bg-row b-grey' style='font-size: 12px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> " + vFeeID + " </th><th scope='col'  style='width:5%;display:none;'> " + vFeeType + " </th> <th scope='col' style='width:7%;'>" + vS + "</th><th scope='col' align='left' style='width:65%;padding-left:2px;'> " + DispDescrip + " </th>  <th scope='col' align='right' style='display:none;width:5%;'>  " + DispQnty + " </th><th scope='col' align='right' style='width:8%;'> " + DispAmt + " </th> <th scope='col' style='width:20%;padding-left:2px;display:none;'>" + DispRmrk + " </th> <th scope='col' style='align:right;width:15%;display:none;'> " + DispRprtDt + " </th> <th scope='col' style='display:none;'> " + DispIsReim + " </th><th scope='col' style='display:none;'> " + DispActual + " </th><th scope='col' style='display:none;'> " + DispIsDis + " </th><th scope='col' style='display:none;'> " + DispIsTax + " </th><th scope='col' style='display:none;'> " + DispIsRepeat + " </th><th scope='col' style='display:none;'> " + DispIsStat + " </th><th scope='col' style='display:none;'> " + DispIsSms + " </th><th scope='col' style='display:none;'> " + DispIsSOtSurs + " </th><th scope='col' style='display:none;'> " + DispIsNabl + " </th><th scope='col' style='display:none;'> " + DispBillItemRate + " </th><th scope='col' style='display:none;'> " + DispHasHistory + " </th>"; // <th scope='col' align='center'>Delete</th></tr>";
    endPaymentTag = "</TBODY></TABLE>";
    newPaymentTables = startPaymentTag;
    //    $('[id$="hdnDiscountableTestTotal"]').val(0);
    //    $('[id$="hdnTaxableTestToal"]').val(0);
    var arrayMainData = new Array();
    var arraySubData = new Array();
    var arrayChildData = new Array();
    var iMain = 0;
    var iChild = 0;
    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable, ActualAmount, IsNormalRateCard, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, MaxDiscount, IsRedeem, RedeemAmount;
    var GrossAmt = 0;
    //VEL
    var MRPGrossAmt = 0;
    var DiscountableTestAmount = 0;
    var TaxableTestAmount = 0;
    var sno = 1;
    var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
    //    if (id == 0) {
    //        if (document.getElementById('txtClient').value.trim() == '' && document.getElementById('hdnDefaultOrgBillingItems').value.trim() != '' && defaultbillflag == 0) {
    //            defaultbillflag = 1;
    //            // defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
    //            FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
    //                        + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8]
    //                        + "~IsDiscountable^" + defalutdata[9] + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + defalutdata[14] + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + defalutdata[16] + "~Code^" + defalutdata[17] + "|";
    //            document.getElementById('hdfBillType1').value += FeeViewStateValue;

    //        }
    //    }
    FeeViewStateValue = $('[id$="hdfBillType1"]').val();
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
                    if (arrayChildData[0] == "ActualAmount") {
                        ActualAmount = arrayChildData[1];
                        MRPGrossAmt = Number(MRPGrossAmt) + Number(ActualAmount);
                    }
                    if (arrayChildData[0] == "IsDiscountable") {
                        IsDiscountable = arrayChildData[1];
                        if (IsDiscountable == "Y")
                            DiscountableTestAmount = Number(DiscountableTestAmount) + Number(Amount);
                    }
                    if (arrayChildData[0] == "IsTaxable") {
                        IsTaxable = arrayChildData[1];
                        if (IsTaxable == "Y")
                            TaxableTestAmount = Number(TaxableTestAmount) + Number(Amount);
                    }
                    if (arrayChildData[0] == "IsRepeatable") {
                        IsRepeatable = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsSTAT") {
                        IsSTAT = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsSMS") {
                        IsSMS = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsOutSource") {
                        IsOutSource = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "IsNABL") {
                        IsNABL = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "BillingItemRateID") {
                        BillingItemRateID = arrayChildData[1];
                        //BillingItemRateID = document.getElementById('hdnRateID').value;
                    }
                    if (arrayChildData[0] == "Code") {
                        Code = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "HasHistory") {
                        HasHistory = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "HasHistory") {
                        HasHistory = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "HasHistory") {
                        HasHistory = arrayChildData[1];
                    }
                }
            }
            var str = "chkAllChild" + iChild;
            document.getElementById('billPart_divItemTable').style.height = "auto";
            if (iMain >= 6) {
                document.getElementById('billPart_divItemTable').style.height = "150px";
                document.getElementById('billPart_divItemTable').style.overflow = "scroll";
            }
            newPaymentTables += "<TR><TD style='display:none;'>" + FeeID + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + FeeType + "</TD>";
            newPaymentTables += "<TD>" + sno + "</TD>";
            newPaymentTables += "<TD style='padding-left:5px' align='left'>" + Descrip + "</TD>"
            newPaymentTables += "<TD  style='display:none;' align='right'>" + Quantity + "</TD>";
            newPaymentTables += "<TD  align='right'>" + Amount + "</TD>";
            newPaymentTables += "<TD  style='display:none;'>" + Remarks + "</TD>";
            newPaymentTables += "<TD style='display:none;' align='center'>" + ReportDate + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsReimbursable + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + ActualAmount + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsDiscountable + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsTaxable + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsRepeatable + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsSTAT + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsSMS + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsOutSource + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsNABL + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + BillingItemRateID + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + HasHistory + "</TD>";
            //            newPaymentTables += "<TD align='center'><input name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "' onclick='btnDeleteBillingItems_OnClick1(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";

            sno++;
            if (IsSMS == 'Y')
                $(".divItemTable tr:first").css("background-color", "red")
        }
        if (iMain > 0) {
            document.getElementById('billPart_lblOrderedItemsCount').innerHTML = Number(iMain);
            $('[id$="trOrderedItemsCount"]').show();
        }
        else {
            $('[id$="trOrderedItemsCount"]').hide();
        }
    }

    newPaymentTables += endPaymentTag;
    var vddDiscountID;
    //vddDiscountID = document.getElementById('billPart_ddDiscountPercent');

    if (document.getElementById('billPart_hdnAllowMulDisc').value == "Y") {
        vddDiscountID = ToInternalFormat($("#billPart_hdnDiscountPercentage"));
        if (vDiscount != undefined) {
            var vDiscount = vddDiscountID.options[vddDiscountID.selectedIndex].value;
        }
    }
    else {
        vddDiscountID = ToInternalFormat($("#billPart_ddDiscountPercent"));
        if (vDiscount != undefined) {
            var vDiscount = vddDiscountID.value;
        }
    }

    var vDiscountText = '';
    var DispQuoteGivenBy = SListForAppDisplay.Get("Billing_CommonBilling_js_57") == null ? "Quote Given By:" : SListForAppDisplay.Get("Billing_CommonBilling_js_57");
    var DispQuoteDate = SListForAppDisplay.Get("Billing_CommonBilling_js_58") == null ? "Quote Date:" : SListForAppDisplay.Get("Billing_CommonBilling_js_58");
    if (vDiscount == null || vDiscount == '0') {
        vDiscountText = '';
    }
    else {
        vDiscountText = " (" + vddDiscountID.options[vddDiscountID.selectedIndex].text + ")";
    }
    newPaymentTables = newPaymentTables + "</td></tr><tr><td> </td></tr><tr><td> </td></tr><tr><td colspan='3'><table align='right' cellpadding='2' cellspacing='2'>";
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblGross').innerHTML + " </b></td><td>" + document.getElementById('billPart_hdnGrossValue').value + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblDiscount').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtDiscount').value + vDiscountText + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblTaxt').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtTax').value + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_Rs_EDCess').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtEDCess').value + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_Rs_SHEDCess').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtSHEDCess').value + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblServiceCharge').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtServiceCharge').value + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblRoundOffAmt').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtRoundoffAmt').value + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td> </td><td>---------</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblNetValue').innerHTML + " </b></td><td>" + document.getElementById('billPart_hdnNetAmount').value + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td> </td><td>---------</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td colspan='3' align='right'>";
    newPaymentTables = newPaymentTables + DispQuoteGivenBy + $('[id$="hdnQuotesGivenBy"]').val();
    newPaymentTables = newPaymentTables + "</td></tr><tr><td colspan='3' align='right'>"
    newPaymentTables = newPaymentTables + DispQuoteDate + $('[id$="hdnQuotesDate"]').val();
    newPaymentTables = newPaymentTables + "</table></td></tr></table>"
    document.getElementById('lblPrintCCBillDetail').innerHTML += startHeaderTag + newPaymentTables;
    //    $('[id$="hdnDiscountableTestTotal"]').val(DiscountableTestAmount);
    //    $('[id$="hdnTaxableTestToal"]').val(TaxableTestAmount);
    ClearSelectedData();

     //VEL
    //SetGrossValue(GrossAmt)
    SetGrossValue(GrossAmt, MRPGrossAmt)
    //VEL
    SetOtherCurrValues();

}


function AddHistory() {
    var arrGotValue = new Array();
    var invList = document.getElementById('billPart_hdnInvHistory').value == '' ? 0 : document.getElementById('billPart_hdnInvHistory').value;
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_Quantum_js_Alert");

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetInvestigationHistoryMapping",
        data: JSON.stringify({ OrgID: document.getElementById('billPart_hdnOrgIDC').value, VisitID: 0, PatientID: 0, FeeID: document.getElementById('billPart_hdnID').value, Remarks: invList }),
        dataType: "json",
        success: function(data) {
            if (data.d.length > 0) {
                for (var i = 0; i < data.d.length; i++) {
                    arrGotValue = data.d[0].Description;
                    if (arrGotValue.length > 0) {
                        //alert(arrGotValue);
                        ValidationWindow(arrGotValue, objAlert);


                        //                        ID = arrGotValue[0];
                        //                        name = arrGotValue[1].trim();
                        //                        feeType = arrGotValue[2];

                    }
                }
            }
            else {
                var objvar9 = SListForAppMsg.Get("Scripts_CommonBiling_js_36") == null ? "you cannot add History  for this item" : SListForAppMsg.Get("Scripts_CommonBiling_js_36");
                objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                ValidationWindow(objvar9, objAlert);
                // alert(' you cannot add History  for this item');

            }
        },
        error: function(result) {
            alert("Error");
        }
    });
}

function AddHistoryDetail() {
    var invList = document.getElementById('billPart_hdnInvHistory').value == "" ? 0 : document.getElementById('billPart_hdnInvHistory').value;
    var OrgID = document.getElementById('billPart_hdnOrgIDC').value;
    var VisitID = 0;
    var PatientID = 0;
    var InvID = document.getElementById('billPart_hdnID').value;
    OPIPBilling.GetInvestigationHistoryMapping(OrgID, VisitID, PatientID, InvID, invList, GetListItems);

}
function onEditedcheck(id) {
    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    ValidationWindow(id, objAlert);
    //    alert(id);
    //    alert(id);


}
function DisplayOff() {
    document.getElementById('billPart_UcHistory_tblMain').style.display = "none";
    document.getElementById('billPart_UcHistory_tblAtt').style.display = "none";
    document.getElementById('billPart_UcHistory_tblBtnAtt').style.display = "none";
    if (document.getElementById('trBackground_Problem_Patient_Preference') != null) {
        document.getElementById('trBackground_Problem_Patient_Preference').style.display = "none";
    }

    document.getElementById('billPart_UcHistory_tr1PatientHistory_LMP_1097').style.display = "none";
    document.getElementById('billPart_UcHistory_divchkLMP').style.display = "none";

    document.getElementById('billPart_UcHistory_trFasting_Duration_1098').style.display = "none";
    document.getElementById('billPart_UcHistory_divFasting_Duration').style.display = "none";

    document.getElementById('billPart_UcHistory_trLastMealTime_1099').style.display = "none";
    document.getElementById('billPart_UcHistory_divLastMealTime').style.display = "none";

    document.getElementById('billPart_UcHistory_trRecent_Sonography_Report_1100').style.display = "none";
    document.getElementById('billPart_UcHistory_divRecent_Sonography_Report').style.display = "none";

    document.getElementById('billPart_UcHistory_trurine_volume_Collected_1101').style.display = "none";
    document.getElementById('billPart_UcHistory_divurine_volume_Collected').style.display = "none";

    document.getElementById('billPart_UcHistory_trAbstinence_days_1102').style.display = "none";
    document.getElementById('billPart_UcHistory_divAbstinence_days').style.display = "none";

    document.getElementById('billPart_UcHistory_trOn_anti_thyroid_disease_drugs_1103').style.display = "none";
    document.getElementById('billPart_UcHistory_divOn_anti_thyroid_disease_drugs').style.display = "none";

    document.getElementById('billPart_UcHistory_trReading_taken_between_48_72_hrs_1104').style.display = "none";
    document.getElementById('billPart_UcHistory_divReading_taken_between_48_72_hrs').style.display = "none";

    document.getElementById('billPart_UcHistory_trDynamicControlsTable').style.display = "none";

    document.getElementById('billPart_UcHistory_divviewHistory').style.display = "none";
    document.getElementById('billPart_UcHistory_tblMain').style.display = "none";
    document.getElementById('billPart_Butsave').style.display = "none";
    document.getElementById('billPart_ButPrint').style.display = "none";
    document.getElementById('billPart_ButEdit').style.display = "none";
    document.getElementById('billPart_UcHistory_tblhistoryview').innerHTML = "";
    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtCpmlaint').value = "";
    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDCode').value = "";
    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_txtICDName').value = "";
    document.getElementById('billPart_UcHistory_tblbackgroundProbview').innerHTML = "";
    document.getElementById('billPart_UcHistory_tblpatientPreferenceview').innerHTML = "";
    document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference').value = '';
    //document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML = "";
    // document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
    if (document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference') != null) {
        document.getElementById('billPart_UcHistory_PatientPreference1_txtEnterPreference').value = '';
    }
}

function GetListItems(lstPatientDueChart) {
    document.getElementById('billPart_hdnHistoryAttributeList').value = '';
    if (lstPatientDueChart.length > 0) {
        for (var i = 0; i < lstPatientDueChart.length; i++) {
            // alert(lstPatientDueChart[i].Description);
            document.getElementById('billPart_hdnHistoryAttributeList').value += lstPatientDueChart[i].Description + "^";

        }
    }

}
function onShowAttributes() {
    document.getElementById('billPart_UcHistory_tblAtt').style.display = "table";
    document.getElementById('billPart_UcHistory_tblBtnAtt').style.display = "table";
    if (document.getElementById('trBackground_Problem_Patient_Preference') != null) {
        document.getElementById('trBackground_Problem_Patient_Preference').style.display = "none";
    }

}
function onDntShowAttributes() {
    $find('billPart_PATattributes').hide();
}

function ClearAddAttributesItemList() {
    var i = 0;
    var textvalue;
    for (i = 1; i < document.getElementById('billPart_UctHistory_tblAtt').getElementsByTagName("tr").length; i++) {
        var txtValue = ('billPart_UctHistory_txtAttribute' + i)
        document.getElementById(txtValue).value = '';
    }
}

function Capturepatienthistory() {

    var strPattenName, IName;
  
      
        $('#DivGermlineFormat').hide();
        $('#divMSTPatten').hide();
        $('#divSomaticpatientHistory').hide();
        $('#divTSPBreastFormat').hide();
        $('#divTSPColonFormat').hide();
        $('#divTSTlungFormat').hide();

    var hdnDisplayTblIDValue = $("#hdnDisplayTblID").val().split('^');
    for (var i = 0; i < hdnDisplayTblIDValue.length; i++) {
        if ($.trim(hdnDisplayTblIDValue[i]) != "") {
            var SplitVal = hdnDisplayTblIDValue[i].split('~');
            strPattenName = SplitVal[0];
            IName = SplitVal[2];
            switch (strPattenName) {
                case "Germline Format":                    
                    $('#DivGermlineFormat').show();
                    $('#patientcapturehistory1_lblformat').text(IName);
                    break;
                case "MST Format":
                    $('#patientcapturehistory1_lblMstName').text(IName);                                     
                    $('#divMSTPatten').show();
                    break;
                case "Somatic Format":
                    $('#patientcapturehistory1_lblSomaticTestname').text(IName);                                      
                    $('#divSomaticpatientHistory').show();
                    break;
                case "TSP Breast Format":
                    $('#patientcapturehistory1_lblTSPTestName').text(IName);                                   
                    $('#divTSPBreastFormat').show();
                    break;

                case "TSP Colon Format":
                    $('#patientcapturehistory1_lblColon').text(IName);                                     
                    $('#divTSPColonFormat').show();
                    break;
                case "TST lung Format":
                    $('#patientcapturehistory1_lblTSPlungTestname').text(IName);
                    $('#divTSTlungFormat').show();                    
                    break;
                default:                    
                    break;
            }
        }
    }
    return false;

}
function onShowHistoryNameList() {
    var HistoryAttributeValue;
    var arrayHistoryData = new Array();
    var iMain = 0;
    var iChild = 0;
    var y;
    var val = new Array();
    var InvestigationID, HistoryID, HistoryName, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName, Type;

    DisplayOff();


    if (document.getElementById('billPart_hdnHistoryAttributeList').value != '') {

        HistoryAttribute = document.getElementById('billPart_hdnHistoryAttributeList').value;
        arrayHistoryData = HistoryAttribute.split('^');
        if (arrayHistoryData.length > 0) {
            for (iMain = 0; iMain < arrayHistoryData.length - 1; iMain++) {
                val = arrayHistoryData[iMain].split('~');
                //                                        if ( val.length >0 ) {
                //                                            InvestigationID = val[0];
                //                                            HistoryID = val[1];
                //                                            HistoryName = val[2];
                //                                            HistoryName = val[3];
                //                                        
                //
                //
                document.getElementById('billPart_Butsave').style.display = "inline";
                document.getElementById('billPart_UcHistory_tblMain').style.display = "table";
                //                                  billPart_UcHistory_txtLMP
                //                                  billPart_UcHistory_txtHours
                //                                  billPart_UcHistory_txtDateTime
                //                                  billPart_UcHistory_txtRecent_Sonography_ReportDate
                //                                  billPart_UcHistory_txtRecent_Sonography_ReportComments
                //                                  billPart_UcHistory_txtHeight
                //                                  billPart_UcHistory_txtWeight
                //                                  billPart_UcHistory_txtAbstinence_days
                //                                  billPart_UcHistory_ddlCheck
                //                                  billPart_UcHistory_txtFreeText
                //tblMain.Style.Add("display", "block");
                if (arrayHistoryData[iMain].split('~')[1] == 1097) {
                    //                            tr1PatientHistory_LMP_1097.Style.Add("display", "block");
                    //                            divchkLMP.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_tr1PatientHistory_LMP_1097').style.display = "table-row";
                    document.getElementById('billPart_UcHistory_divchkLMP').style.display = "block";

                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1098) {
                    //                            trFasting_Duration_1098.Style.Add("display", "block");
                    //                            divFasting_Duration.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trFasting_Duration_1098').style.display = "table-row";
                    document.getElementById('billPart_UcHistory_divFasting_Duration').style.display = "block";
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1099) {
                    //                            trLastMealTime_1099.Style.Add("display", "block");
                    //                            divLastMealTime.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trLastMealTime_1099').style.display = "table-row";
                    document.getElementById('billPart_UcHistory_divLastMealTime').style.display = "block";
                    document.getElementById('billPart_UcHistory_ChkLastMealTime').checked = true;
                    document.getElementById('billPart_UcHistory_txtDateTime').value = '';
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1100) {
                    //                            trRecent_Sonography_Report_1100.Style.Add("display", "block");
                    //                            divRecent_Sonography_Report.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trRecent_Sonography_Report_1100').style.display = "table-row";
                    document.getElementById('billPart_UcHistory_divRecent_Sonography_Report').style.display = "block";

                }

                else if (arrayHistoryData[iMain].split('~')[1] == 1101) {
                    //                            trurine_volume_Collected_1101.Style.Add("display", "block");
                    //                            divurine_volume_Collected.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trurine_volume_Collected_1101').style.display = "table-row";
                    document.getElementById('billPart_UcHistory_divurine_volume_Collected').style.display = "block";
                }

                else if (arrayHistoryData[iMain].split('~')[1] == 1102) {
                    //                            trAbstinence_days_1102.Style.Add("display", "block");
                    //                            divAbstinence_days.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trAbstinence_days_1102').style.display = "table-row";
                    document.getElementById('billPart_UcHistory_divAbstinence_days').style.display = "block";
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1103) {
                    //                            trOn_anti_thyroid_disease_drugs_1103.Style.Add("display", "block");
                    //                            divOn_anti_thyroid_disease_drugs.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trOn_anti_thyroid_disease_drugs_1103').style.display = "table-row";
                    document.getElementById('billPart_UcHistory_divOn_anti_thyroid_disease_drugs').style.display = "block";
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1104) {
                    //                            trReading_taken_between_48_72_hrs_1104.Style.Add("display", "block");
                    //                            divReading_taken_between_48_72_hrs.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trReading_taken_between_48_72_hrs_1104').style.display = "table-row";
                    document.getElementById('billPart_UcHistory_divReading_taken_between_48_72_hrs').style.display = "block";
                }
                else if (arrayHistoryData[iMain].split('~')[1] != "" && arrayHistoryData[iMain].split('~')[1] != "0") {


                    document.getElementById('billPart_UcHistory_trDynamicControlsTable').style.display = "table-row";
                    var IsnewHistory = "YES";
                    if (document.getElementById('billPart_UcHistory_hdnHistoryIds').value != "") {
                        var DynamicHistoryIds = new Array();
                        DynamicHistoryIds = document.getElementById('billPart_UcHistory_hdnHistoryIds').value.split('^');
                        if (DynamicHistoryIds.length > 0) {
                            for (var i = 0; i < DynamicHistoryIds.length - 1; i++) {
                                if (DynamicHistoryIds[i] == arrayHistoryData[iMain].split('~')[1]) {
                                    IsnewHistory = "NO";
                                }
                            }
                        }
                    }
                    if (IsnewHistory == "YES") {
                        var TableInvValue = '';
                        var row = document.getElementById('billPart_UcHistory_tblDynamicControls').insertRow(1);
                        row.id = iMain;
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        var cell5 = row.insertCell(4);

                        var ChkID = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + "_chk";
                        var TxtID = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + "_txt";
                        var HdnID = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1];
                        var HdnID1 = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + '_h1';
                        var HdnID2 = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + '_h2';


                        cell1.innerHTML = "<input type='checkbox' id='" + ChkID + "' runat='server'  onclick='javascript:SetCheckboxIndex(this.id);' />";

                        cell2.innerHTML = "<b>" + arrayHistoryData[iMain].split('~')[2] + "</b>";
                        cell3.innerHTML = "<input type='text' id='" + TxtID + "' runat='server' onblur='javascript:SetCheckingCheckBox(this.id);' />";
                        cell4.innerHTML = "<input type='hidden' runat='server' id='" + HdnID1 + "'  value='" + HdnID + "' />"
                        cell5.innerHTML = "<input type='hidden' runat='server' id='" + HdnID2 + "'  value='" + HdnID + "' />"

                        document.getElementById('billPart_UcHistory_hdnHistoryIds').value += arrayHistoryData[iMain].split('~')[1] + "^";

                    }
                    document.getElementById('billPart_UcHistory_tblDynamicControls').style.display = 'table';
                }
                else {
                    // document.getElementById('billPart_UcHistory_divStatus').style.display = "block";
                    // billPart_UcHistory_lblStatus
                    //tableHistory.Style.Add("display", "none");
                    //tblMain.Style.Add("display", "none");
                    //divStatus.Style.Add("display", "block");
                    //lblStatus.Text = "There is no History for this test";
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey", "javascript:alert('No History for this test.');", true);

                }

            }

        }

    }

    var PatientID = document.getElementById('hdnPatientID').value;
    if (document.getElementById('hdnPatientName') != null) {
        var PatientName = document.getElementById('hdnPatientName').value;
    }
    var Items = 0;
    var count = 0;
    var OrgID = document.getElementById('hdnOrgID').value;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetLabQuickBillPatientListdetails",
        data: "{'prefixText': '" + PatientName + "','count': " + count + ",'contextKey':'" + OrgID + '~' + PatientID + '~' + '0' + "'}",
        dataType: "json",
        success: function(data) {
            Items = data.d[0];
            if (Items != undefined) {
                LoadComplaintItem(Items);
            }
        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }
    });
    if (Items == '0') {
        if (document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').innerHTML == '') {
            document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').style.display = 'none';
        }
        else {
            document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').style.display = 'block';
        }
    }
    else {
        document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').style.display = 'block';
    }

    var child = document.getElementById('ViewTRF');
    if (child != null) {
        child.parentNode.removeChild(child);
    }
    if (document.getElementById('trBackground_Problem_Patient_Preference') != null) {
        document.getElementById('trBackground_Problem_Patient_Preference').style.display = "block";
    }
    document.getElementById('billPart_Butsave').style.display = "inline";
    GetConfig();
}
function SetCheckboxIndex(id) {
    //  alert(id);
}
function SetCheckingCheckBox(id) {
    //debugger;
    if (document.getElementById(id).value != "") {
        var TextID;
        TextID = id.replace('_txt', '_chk');
        document.getElementById(TextID).checked = true;
    }

}
function GetConfig() {
    if (document.getElementById('billPart_UcHistory_hdnConfig').value != 'Y') {
        document.getElementById('trBackground_Problem_Patient_Preference').style.display = 'block';
    }
    else {
        document.getElementById('trBackground_Problem_Patient_Preference').style.display = 'none';
    }
}
function AddHistoryItemList() {
    var objSno = SListForAppMsg.Get("Scripts_CommonBiling_js_52") == null ? "S.No" : SListForAppMsg.Get("Scripts_CommonBiling_js_52");
    var objbprob = SListForAppMsg.Get("Scripts_CommonBiling_js_53") == null ? "Background Problem" : SListForAppMsg.Get("Scripts_CommonBiling_js_53");
    var objval = SListForAppMsg.Get("Scripts_CommonBiling_js_54") == null ? "Values" : SListForAppMsg.Get("Scripts_CommonBiling_js_54");
    var objpatpre = SListForAppMsg.Get("Scripts_CommonBiling_js_55") == null ? "Patient Preference" : SListForAppMsg.Get("Scripts_CommonBiling_js_55");
    var objHisName = SListForAppMsg.Get("Scripts_CommonBiling_js_56") == null ? "History Name" : SListForAppMsg.Get("Scripts_CommonBiling_js_56");
    if (document.getElementById('trBackground_Problem_Patient_Preference') != null) {
        document.getElementById('trBackground_Problem_Patient_Preference').style.display = "none";
    }
    var HistoryAttributeValue;
    var arrayHistoryData = new Array();
    var iMain = 0;
    var iChild = 0;
    var y;
    var val = new Array();
    var InvestigationID, HistoryID, HistoryName, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName, Type, id;
    id = 0;
    document.getElementById('billPart_hdnHistoryTableList').value = '';
    document.getElementById('billPart_hdnHistoryTableLists').value = '';
    document.getElementById('billPart_hdnHistoryTableListsP').value = '';
    if (document.getElementById('billPart_hdnHistoryAttributeList').value != '') {

        HistoryAttribute = document.getElementById('billPart_hdnHistoryAttributeList').value;
        arrayHistoryData = HistoryAttribute.split('^');
        if (arrayHistoryData.length > 0) {
            for (iMain = arrayHistoryData.length - 1; iMain >= 0; iMain--) {
                val = arrayHistoryData[iMain].split('~');
                //                                        if ( val.length >0 ) {
                //                                            InvestigationID = val[0];
                //                                            HistoryID = val[1];
                //                                            HistoryName = val[2];
                //                                            HistoryName = val[3];
                //                                        }
                //
                //

                document.getElementById('billPart_UcHistory_tblMain').style.display = "table";

                if (arrayHistoryData[iMain].split('~')[1] == 1097) {
                    var objvar10 = SListForAppMsg.Get("Scripts_CommonBiling_js_37") == null ? "Please Select LMP Date !!!" : SListForAppMsg.Get("Scripts_CommonBiling_js_37");

                    if (document.getElementById('billPart_UcHistory_chkLMP').checked == true) {
                        if (document.getElementById('billPart_UcHistory_txtLMP').value == "__/__/____" || document.getElementById('billPart_UcHistory_txtLMP').value == "") {
                            //alert('Please Select LMP Date !!!');
                            var objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                            ValidationWindow(objvar10, objAlert);
                            return false;
                        }
                        InvestigationID = arrayHistoryData[iMain].split('~')[0];
                        HistoryID = arrayHistoryData[iMain].split('~')[1];
                        HistoryName = arrayHistoryData[iMain].split('~')[2];
                        Type = arrayHistoryData[iMain].split('~')[3];
                        HashAttribute = arrayHistoryData[iMain].split('~')[4];
                        AttributeID = arrayHistoryData[iMain].split('~')[5];
                        AttributeName = arrayHistoryData[iMain].split('~')[6];
                        AttributevalueID = arrayHistoryData[iMain].split('~')[7];
                        AttributeValueName = document.getElementById('billPart_UcHistory_txtLMP').value;
                        Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
                    }

                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1098) {
                    if (document.getElementById('billPart_UcHistory_ChkFasting_Duration').checked == true) {
                        InvestigationID = arrayHistoryData[iMain].split('~')[0];
                        HistoryID = arrayHistoryData[iMain].split('~')[1];
                        HistoryName = arrayHistoryData[iMain].split('~')[2];
                        Type = arrayHistoryData[iMain].split('~')[3];
                        HashAttribute = arrayHistoryData[iMain].split('~')[4];
                        AttributeID = arrayHistoryData[iMain].split('~')[5];
                        AttributeName = arrayHistoryData[iMain].split('~')[6];
                        AttributevalueID = arrayHistoryData[iMain].split('~')[7];
                        AttributeValueName = document.getElementById('billPart_UcHistory_txtHours').value;
                        Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
                    }
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1099) {
                    if (document.getElementById('billPart_UcHistory_ChkLastMealTime').checked == true) {
                        InvestigationID = arrayHistoryData[iMain].split('~')[0];
                        HistoryID = arrayHistoryData[iMain].split('~')[1];
                        HistoryName = arrayHistoryData[iMain].split('~')[2];
                        Type = arrayHistoryData[iMain].split('~')[3];
                        HashAttribute = arrayHistoryData[iMain].split('~')[4];
                        AttributeID = arrayHistoryData[iMain].split('~')[5];
                        AttributeName = arrayHistoryData[iMain].split('~')[6];
                        AttributevalueID = arrayHistoryData[iMain].split('~')[7];
                        AttributeValueName = document.getElementById('billPart_UcHistory_txtDateTime').value;
                        Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
                    }
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1100) {
                    if (document.getElementById('billPart_UcHistory_ChkRecent_Sonography_Report').checked == true) {
                        InvestigationID = arrayHistoryData[iMain].split('~')[0];
                        HistoryID = arrayHistoryData[iMain].split('~')[1];
                        HistoryName = arrayHistoryData[iMain].split('~')[2];
                        Type = arrayHistoryData[iMain].split('~')[3];
                        HashAttribute = arrayHistoryData[iMain].split('~')[4];
                        AttributeID = arrayHistoryData[iMain].split('~')[5];
                        AttributeName = arrayHistoryData[iMain].split('~')[6];
                        AttributevalueID = arrayHistoryData[iMain].split('~')[7];
                        AttributeValueName = document.getElementById('billPart_UcHistory_txtRecent_Sonography_ReportDate').value + "-" + document.getElementById('billPart_UcHistory_txtRecent_Sonography_ReportComments').value;
                        Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
                    }
                }

                else if (arrayHistoryData[iMain].split('~')[1] == 1101) {
                    if (document.getElementById('billPart_UcHistory_chkurine_volume_Collected').checked == true) {
                        InvestigationID = arrayHistoryData[iMain].split('~')[0];
                        HistoryID = arrayHistoryData[iMain].split('~')[1];
                        HistoryName = arrayHistoryData[iMain].split('~')[2];
                        Type = arrayHistoryData[iMain].split('~')[3];
                        HashAttribute = arrayHistoryData[iMain].split('~')[4];
                        AttributeID = arrayHistoryData[iMain].split('~')[5];
                        AttributeName = arrayHistoryData[iMain].split('~')[6];
                        AttributevalueID = arrayHistoryData[iMain].split('~')[7];
                        AttributeValueName = document.getElementById('billPart_UcHistory_txtHeight').value;  //+ "-" + document.getElementById('billPart_UcHistory_txtWeight').value;
                        Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
                    }
                }

                else if (arrayHistoryData[iMain].split('~')[1] == 1102) {
                    if (document.getElementById('billPart_UcHistory_ChkAbstinence_days').checked == true) {
                        InvestigationID = arrayHistoryData[iMain].split('~')[0];
                        HistoryID = arrayHistoryData[iMain].split('~')[1];
                        HistoryName = arrayHistoryData[iMain].split('~')[2];
                        Type = arrayHistoryData[iMain].split('~')[3];
                        HashAttribute = arrayHistoryData[iMain].split('~')[4];
                        AttributeID = arrayHistoryData[iMain].split('~')[5];
                        AttributeName = arrayHistoryData[iMain].split('~')[6];
                        AttributevalueID = arrayHistoryData[iMain].split('~')[7];
                        AttributeValueName = document.getElementById('billPart_UcHistory_txtAbstinence_days').value;
                        Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
                    }
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1103) {
                    if (document.getElementById('billPart_UcHistory_ChkOn_anti_thyroid_disease_drugs').checked == true) {
                        InvestigationID = arrayHistoryData[iMain].split('~')[0];
                        HistoryID = arrayHistoryData[iMain].split('~')[1];
                        HistoryName = arrayHistoryData[iMain].split('~')[2];
                        Type = arrayHistoryData[iMain].split('~')[3];
                        HashAttribute = arrayHistoryData[iMain].split('~')[4];
                        AttributeID = arrayHistoryData[iMain].split('~')[5];
                        AttributeName = arrayHistoryData[iMain].split('~')[6];
                        AttributevalueID = arrayHistoryData[iMain].split('~')[7];
                        var ddlValue = document.getElementById('billPart_UcHistory_ddlCheck').options[document.getElementById('billPart_UcHistory_ddlCheck').selectedIndex].innerHTML;
                        AttributeValueName = ddlValue == "---Select---" ? "" : ddlValue;
                        Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
                    }
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1104) {
                    if (document.getElementById('billPart_UcHistory_ChkReading_taken_between_48_72_hrs').checked == true) {
                        InvestigationID = arrayHistoryData[iMain].split('~')[0];
                        HistoryID = arrayHistoryData[iMain].split('~')[1];
                        HistoryName = arrayHistoryData[iMain].split('~')[2];
                        Type = arrayHistoryData[iMain].split('~')[3];
                        HashAttribute = arrayHistoryData[iMain].split('~')[4];
                        AttributeID = arrayHistoryData[iMain].split('~')[5];
                        AttributeName = arrayHistoryData[iMain].split('~')[6];
                        AttributevalueID = arrayHistoryData[iMain].split('~')[7];
                        AttributeValueName = AttributeValueName = document.getElementById('billPart_UcHistory_txtFreeText').value;
                        Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
                    }
                }
                else if (arrayHistoryData[iMain].split('~')[1] != "" && arrayHistoryData[iMain].split('~')[1] != "0") {

                    document.getElementById('billPart_UcHistory_trDynamicControlsTable').style.display = 'table-row';
                    var txtid = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + "_txt";
                    var chkid = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + "_chk";
                    var RowID = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1];
                    var HdnID1 = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + '_h1';
                    var HdnID2 = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + '_h2';

                    var pHistoryvalue;
                    var Ischeck;
                    $('#billPart_UcHistory_tblDynamicControls tr:not(:first)').each(function(i, n) {
                        $row = $(n);
                        count = count + 1;
                        if ($row.find($('input[id$="' + HdnID1 + '"]')).val() == RowID) {
                            if ($row.find($('[id$="' + Ischeck + '"] input[type=checkbox]:checked'))) {

                                pHistoryvalue = $row.find($('input[id$="' + txtid + '"]')).val();
                                InvestigationID = arrayHistoryData[iMain].split('~')[0];
                                HistoryID = arrayHistoryData[iMain].split('~')[1];
                                HistoryName = arrayHistoryData[iMain].split('~')[2];
                                Type = arrayHistoryData[iMain].split('~')[3];
                                HashAttribute = arrayHistoryData[iMain].split('~')[4];
                                AttributeID = arrayHistoryData[iMain].split('~')[5];
                                AttributeName = arrayHistoryData[iMain].split('~')[6];
                                AttributevalueID = arrayHistoryData[iMain].split('~')[7];
                                AttributeValueName = pHistoryvalue;  //document.getElementById('billPart_UcHistory_txtHeight').value + "-" + document.getElementById('billPart_UcHistory_txtWeight').value;
                                Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);

                            }

                        }
                    });
                }
                else {
                    // document.getElementById('billPart_UcHistory_divStatus').style.display = "block";
                    // billPart_UcHistory_lblStatus

                }

            }

        }

    }
    if (document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').innerText != '') {
        var Hid = document.getElementById('billPart_UcHistory_hdnPreference').value;
        var list = Hid.split('~');
        InvestigationID = '0';
        HistoryID = '0';
        Type = '0';
        HashAttribute = '0';
        AttributeID = '0';
        AttributevalueID = '0';
        AttributeName = 'Patient Preference';
        HistoryName = 'Patient Preference';
        for (var count = 0; count < list.length; count++) {
            if (list[count] != "") {
                var CList = list[count].split('^');
                if (CList[1] != undefined) {
                    AttributeValueName = CList[1];
                }
                Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
            }
        }
    }
    if (document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').innerText != '') {
        var Hid = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value;
        var list = Hid.split('^');
        InvestigationID = '0';
        Type = '0';
        HashAttribute = '0';
        AttributeID = '0';
        AttributevalueID = '0';
        AttributeName = 'Background Problem';
        for (var count = 0; count < list.length - 1; count++) {
            var CList = list[count].split('~');
            HistoryName = CList[1];
            HistoryID = parseInt(CList[2]);
            AttributeValueName = CList[3];
            Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName);
        }

    }
    var tables = "";
    var arrayMainHistoryData = new Array();
    var arraySubHistoryData = new Array();
    var arrayChildData = new Array();
    var ViewHistoryTableValue = "";
    var jMain, jChild;
    var startHeaderTag, newPaymentTables, startPaymentTag, endPaymentTag, taxDetailsTag;
    document.getElementById('billPart_UcHistory_tblhistoryview').innerHTML = "";
    document.getElementById('billPart_UcHistory_tblbackgroundProbview').innerHTML = "";
    document.getElementById('billPart_UcHistory_tblpatientPreferenceview').innerHTML = "";
    document.getElementById('billPart_UcHistory_divviewHistory').style.display = "none";
    document.getElementById('billPart_UcHistory_tblMain').style.display = "none";
    document.getElementById('billPart_Butsave').style.display = "none";
    document.getElementById('billPart_ButPrint').style.display = "block";
    document.getElementById('billPart_ButEdit').style.display = "block";


    if (document.getElementById('billPart_hdnHistoryTableList').value != '') {
        startHeaderTag = "<table width='100%'  border='1px;' cellpadding='0' cellspacing='0'>";
        startHeaderTag += "<TR class='dataheader1'><th  scope='col' style='width:5%;display:none;'>HistoryID</th><th  scope='col' style='width:2%;'>" + objSno + " </th><th scope='col' style='width:5%;'> " + objHisName + " </th> <th style='width:5%;'> " + objval + "</th></TR>"

        newPaymentTables = startHeaderTag;

        endTag = "</table>";
        var tparent = document.getElementById('billPart_hdnHistoryTableList').value.split('|');
        ViewHistoryTableValue = document.getElementById('billPart_hdnHistoryTableList').value;

        arrayMainHistoryData = ViewHistoryTableValue.split('|');
        if (arrayMainHistoryData.length > 0) {
            for (jMain = 0; jMain < arrayMainHistoryData.length - 1; jMain++) {
                var Sno = 0;
                arraySubHistoryData = arrayMainHistoryData[jMain].split('~');
                for (jChild = 0; jChild < arraySubHistoryData.length; jChild++) {
                    arrayChildData = arraySubHistoryData[jChild].split('^');
                    if (arrayChildData.length > 0) {
                        if (arrayChildData[0] == "InvestigationID") {
                            InvestigationID = arrayChildData[1];

                        }
                        if (arrayChildData[0] == "HistoryID") {
                            HistoryID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "HistoryName") {
                            HistoryName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Type") {
                            Type = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "HashAttribute") {
                            HashAttribute = arrayChildData[1];

                        }
                        if (arrayChildData[0] == "AttributeID") {
                            AttributeID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "AttributeName") {
                            AttributeName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "AttributevalueID") {
                            AttributevalueID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "AttributeValueName") {
                            AttributeValueName = arrayChildData[1];
                        }

                    }
                }
                Sno = jMain + 1;
                newPaymentTables += "<TD style='display:none;'>" + HistoryID + "</TD>";
                newPaymentTables += "<TD style='padding-left:5px' align='center' >" + Sno + "</TD>";
                newPaymentTables += "<TD style='padding-left:5px' align='left'>" + HistoryName + "</TD>";
                if (HistoryName == "24h urine volume Collected in ml") {

                    var y = AttributeValueName.split('-')[0];
                    newPaymentTables += "<TD  align='left'>" + y + "</TD>"

                }
                else if (HistoryName == "Recent Sonography Report") {
                    var y1 = "Date :" + AttributeValueName.split('-')[0] + " <br>  Comments : " + AttributeValueName.split('-')[1];
                    newPaymentTables += "<TD  align='left'>" + y1 + "</TD>"
                }
                else {
                    newPaymentTables += "<TD style='padding-left:5px' align='left'>" + AttributeValueName + "</TD>"
                }

                newPaymentTables += "</TR>";
            }

        }
        newPaymentTables += endTag;
        document.getElementById('billPart_UcHistory_tblhistoryview').innerHTML = newPaymentTables;


    }

    if (document.getElementById('billPart_hdnHistoryTableListsP').value != '') {
        startHeaderTag = "<table width='50%'  border='1px;' cellpadding='0' cellspacing='0'>";
        startHeaderTag += "<TR class='dataheader1'><th  scope='col' style='width:5%;display:none;'>Slno </th><th  scope='col' style='width:1%;'>"+objSno+" </th><th scope='col' style='width:5%;'> "+objpatpre+" </th></TR>"

        newPaymentTables = startHeaderTag;

        endTag = "</table>";
        var tparent = document.getElementById('billPart_hdnHistoryTableListsP').value.split('|');
        ViewHistoryTableValue = document.getElementById('billPart_hdnHistoryTableListsP').value;

        arrayMainHistoryData = ViewHistoryTableValue.split('|');
        if (arrayMainHistoryData.length > 0) {
            for (jMain = 0; jMain < arrayMainHistoryData.length - 1; jMain++) {
                var Sno = 0;
                arraySubHistoryData = arrayMainHistoryData[jMain].split('~');
                for (jChild = 0; jChild < arraySubHistoryData.length; jChild++) {
                    arrayChildData = arraySubHistoryData[jChild].split('^');
                    if (arrayChildData.length > 0) {
                        if (arrayChildData[0] == "InvestigationID") {
                            InvestigationID = arrayChildData[1];

                        }
                        if (arrayChildData[0] == "HistoryID") {
                            HistoryID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "HistoryName") {
                            HistoryName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Type") {
                            Type = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "HashAttribute") {
                            HashAttribute = arrayChildData[1];

                        }
                        if (arrayChildData[0] == "AttributeID") {
                            AttributeID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "AttributeName") {
                            AttributeName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "AttributevalueID") {
                            AttributevalueID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "AttributeValueName") {
                            AttributeValueName = arrayChildData[1];
                        }

                    }
                }
                Sno = jMain + 1;
                newPaymentTables += "<TD style='padding-left:5px' align='center' >" + Sno + "</TD>";
                //newPaymentTables += "<TD>" + HistoryName + "</TD>";
                newPaymentTables += "<TD style='padding-left:5px' align='left'>" + AttributeValueName + "</TD>"
                newPaymentTables += "</TR>";
            }

        }
        newPaymentTables += endTag;
        document.getElementById('billPart_UcHistory_tblpatientPreferenceview').innerHTML = newPaymentTables;



    }
    if (document.getElementById('billPart_hdnHistoryTableLists').value != '') {
        startHeaderTag = "<table width='50%'  border='1px;' cellpadding='0' cellspacing='0'>";
        startHeaderTag += "<TR class='dataheader1'><th  scope='col' style='width:5%;display:none;'>Slno </th><th  scope='col' style='width:1%;'>" + objSno + "</th><th scope='col' style='width:5%;'>" + objbprob + "</th><th style='width:3%;'> " + objval + " </th></TR>"

        newPaymentTables = startHeaderTag;

        endTag = "</table>";
        var tparent = document.getElementById('billPart_hdnHistoryTableLists').value.split('|');
        ViewHistoryTableValue = document.getElementById('billPart_hdnHistoryTableLists').value;

        arrayMainHistoryData = ViewHistoryTableValue.split('|');
        if (arrayMainHistoryData.length > 0) {
            for (jMain = 0; jMain < arrayMainHistoryData.length - 1; jMain++) {
                var Sno = 0;
                arraySubHistoryData = arrayMainHistoryData[jMain].split('~');
                for (jChild = 0; jChild < arraySubHistoryData.length; jChild++) {
                    arrayChildData = arraySubHistoryData[jChild].split('^');
                    if (arrayChildData.length > 0) {
                        if (arrayChildData[0] == "InvestigationID") {
                            InvestigationID = arrayChildData[1];

                        }
                        if (arrayChildData[0] == "HistoryID") {
                            HistoryID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "HistoryName") {
                            HistoryName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "Type") {
                            Type = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "HashAttribute") {
                            HashAttribute = arrayChildData[1];

                        }
                        if (arrayChildData[0] == "AttributeID") {
                            AttributeID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "AttributeName") {
                            AttributeName = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "AttributevalueID") {
                            AttributevalueID = arrayChildData[1];
                        }
                        if (arrayChildData[0] == "AttributeValueName") {
                            AttributeValueName = arrayChildData[1];
                        }

                    }
                }
                Sno = jMain + 1;
                newPaymentTables += "<TD  style='padding-left:5px' align='center' >" + Sno + "</TD>";
                newPaymentTables += "<TD  style='padding-left:5px' align='left'>" + HistoryName + "</TD>";
                newPaymentTables += "<TD  style='padding-left:5px' align='left'>" + AttributeValueName + "</TD>"
                newPaymentTables += "</TR>";
            }

        }
        newPaymentTables += endTag;
        document.getElementById('billPart_UcHistory_tblbackgroundProbview').innerHTML = newPaymentTables;
    }
    return false;

}

function IsCheckDuplicateHistory(HistoryID) {
    var isTrue = false;
    var HistoryValues = new Array();

    if (document.getElementById('billPart_hdnHistoryTableList').value == "") {
        isTrue = true;
    }
    else {
        HistoryValues = document.getElementById('billPart_hdnHistoryTableList').value.split('|');
        for (zMain = 0; zMain < HistoryValues.length - 1; zMain++) {
            if (HistoryValues[zMain].split('~')[1].split('^')[1] == HistoryID) {
                isTrue = false;
                break;
            }
            else {
                isTrue = true;

            }

        }
    }
    return isTrue;

}

function Save_onClick(id, InvestigationID, HistoryID, HistoryName, Type, HashAttribute, AttributeID, AttributeName, AttributevalueID, AttributeValueName) {
    var FeeViewStateValue;
    var zMain;
    var HistoryValues = new Array();

    var defalutdata = document.getElementById('billPart_hdnHistoryTableList').value.split('^');
    if ((AttributeName != 'Background Problem') && (AttributeName != 'Patient Preference')) {
        if (id != 0) {


            // defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
            FeeViewStateValue = "InvestigationID^" + InvestigationID + "~HistoryID^" + HistoryID + "~HistoryName^" + HistoryName + "~Type^"
                        + Type + "~HashAttribute^" + HashAttribute + "~AttributeID^" + defalutdata[5] + "~AttributeName^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8]
                        + "~IsDiscountable^" + defalutdata[9] + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + defalutdata[14] + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + defalutdata[16] + "~Code^" + defalutdata[17] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + "N" + "|";
            document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;


        }

        //                HistoryValues=document.getElementById('billPart_hdnHistoryTableList').value.split('|');
        //                for (zMain = 0; zMain < HistoryValues.length - 1; zMain++) {

        if (document.getElementById('billPart_hdnHistoryTableList').value == "") {
            FeeViewStateValue = "InvestigationID^" + InvestigationID + "~HistoryID^" + HistoryID + "~HistoryName^" + HistoryName + "~Type^"
                        + Type + "~HashAttribute^" + HashAttribute + "~AttributeID^" + AttributeID + "~AttributeName^" + AttributeName
                        + "~AttributevalueID^" + AttributevalueID + "~AttributeValueName^" + AttributeValueName + "|";
            document.getElementById('billPart_hdnHistoryTableList').value += FeeViewStateValue;

        }
        else {


            //                    if (document.getElementById('billPart_hdnHistoryTableList').value.split('|')[0].split('~')[1].split('^')[1] != HistoryID) {
            if (IsCheckDuplicateHistory(HistoryID) == true) {

                FeeViewStateValue = "InvestigationID^" + InvestigationID + "~HistoryID^" + HistoryID + "~HistoryName^" + HistoryName + "~Type^"
                        + Type + "~HashAttribute^" + HashAttribute + "~AttributeID^" + AttributeID + "~AttributeName^" + AttributeName
                        + "~AttributevalueID^" + AttributevalueID + "~AttributeValueName^" + AttributeValueName + "|";
                document.getElementById('billPart_hdnHistoryTableList').value += FeeViewStateValue;

            }



        }
    }
    else {
        if (AttributeName == 'Background Problem') {
            FeeViewStateValue = "InvestigationID^" + InvestigationID + "~HistoryID^" + HistoryID + "~HistoryName^" + HistoryName + "~Type^"
                        + Type + "~HashAttribute^" + HashAttribute + "~AttributeID^" + AttributeID + "~AttributeName^" + AttributeName
                        + "~AttributevalueID^" + AttributevalueID + "~AttributeValueName^" + AttributeValueName + "|";
            document.getElementById('billPart_hdnHistoryTableLists').value += FeeViewStateValue;
        }
        if (AttributeName == 'Patient Preference') {
            FeeViewStateValue = "InvestigationID^" + InvestigationID + "~HistoryID^" + HistoryID + "~HistoryName^" + HistoryName + "~Type^"
                        + Type + "~HashAttribute^" + HashAttribute + "~AttributeID^" + AttributeID + "~AttributeName^" + AttributeName
                        + "~AttributevalueID^" + AttributevalueID + "~AttributeValueName^" + AttributeValueName + "|";
            document.getElementById('billPart_hdnHistoryTableListsP').value += FeeViewStateValue;
        }
    }

}

function deleteHistory(id) {

    var Invelist = new Array();
    var Invelistvalues = new Array();
    var k = 0;
    var val;
    var tempDatas = "";
    tempDatas = document.getElementById('billPart_hdfBillType1').value;


    if (tempDatas != "") {
        Invelist = tempDatas.split('|');
        for (k = 0; k < Invelist.length - 1; k++) {
            if (Invelist[k] != "") {
                if (k == 0) {
                    val = Invelist[k].split('~')[0].split('^')[1] + "~";
                }
                else {
                    val += Invelist[k].split('~')[0].split('^')[1] + "~";
                }

            }
        }
    }
    else {
        val = "";
    }
    document.getElementById('billPart_hdnInvHistory').value = val;
    Invelistvalues = document.getElementById('billPart_hdnHistoryTableList').value.split('|');

    document.getElementById('billPart_hdnHistoryTableList').value = '';
    if (Invelistvalues != '') {
        var i;
        for (i = 0; i < Invelistvalues.length - 1; i++) {

            if (Invelistvalues[i].split('~')[0].split('^')[1] != id) {
                // if (temp1[i].split('~')[1] != ID && temp1[i].split('~')[2] != type) {
                document.getElementById('billPart_hdnHistoryTableList').value += Invelistvalues[i] + "|";
            }
        }
    }

    //               if (tempDatas != "") {
    //                   Invelist = tempDatas.split('|');
    //                   for (k = 0; k < Invelist.length - 1; k++) {
    //                       if (Invelist[k] != "") {
    //                           if (k == 0) {
    //                               val = Invelist[k].split('~')[0].split('^')[1] + "~";
    //                           }
    //                           else {
    //                               val += Invelist[k].split('~')[0].split('^')[1] + "~";
    //                           }

    //                       }
    //                   }
    //               }
    //               else {
    //                   val = "";
    //               }

    //   document.getElementById('billPart_hdnHistoryTableList').value  =
    AddHistoryDetail();
    onShowHistoryNameList();

    if ($('#hdnConfigCapturehistory').val() == "Y") {
        DeleteCapturePatientHistory(id);
    }
}

function clearHistoryHiddenvalues() {
    document.getElementById('billPart_hdnHistoryTableList').value = '';
    document.getElementById('billPart_hdnHistoryAttributeList').value = '';
    document.getElementById('billPart_hdnInvHistory').value = '';
    clearHistoryValues();

}

function clearHistoryValues() {
    document.getElementById('billPart_UcHistory_chkLMP').checked = false;
    document.getElementById('billPart_UcHistory_ChkFasting_Duration').checked = false;
    document.getElementById('billPart_UcHistory_ChkLastMealTime').checked = false;
    document.getElementById('billPart_UcHistory_ChkRecent_Sonography_Report').checked = false;
    document.getElementById('billPart_UcHistory_chkurine_volume_Collected').checked = false;
    document.getElementById('billPart_UcHistory_ChkAbstinence_days').checked = false;
    document.getElementById('billPart_UcHistory_ChkOn_anti_thyroid_disease_drugs').checked = false;
    document.getElementById('billPart_UcHistory_ChkReading_taken_between_48_72_hrs').checked = false;

    document.getElementById('billPart_UcHistory_txtLMP').value = '';
    document.getElementById('billPart_UcHistory_txtHours').value = '';
    // document.getElementById('billPart_UcHistory_txtDateTime').value = '';
    document.getElementById('billPart_UcHistory_txtRecent_Sonography_ReportDate').value = '';
    document.getElementById('billPart_UcHistory_txtRecent_Sonography_ReportComments').value = '';
    document.getElementById('billPart_UcHistory_txtHeight').value = '';
    document.getElementById('billPart_UcHistory_txtWeight').value = '';
    document.getElementById('billPart_UcHistory_txtAbstinence_days').value = '';
    document.getElementById('billPart_UcHistory_txtFreeText').value = '';
    document.getElementById('billPart_UcHistory_ddlCheck').value = '0';

    // document.getElementById('billPart_UcHistory_tblMain').style.display = "none";
    // document.getElementById('billPart_UcHistory_tr1PatientHistory_LMP_1097').style.display = "none";
    //                document.getElementById('billPart_UcHistory_divchkLMP').style.display = "none";

    //                document.getElementById('billPart_UcHistory_trFasting_Duration_1098').style.display = "none";
    //                document.getElementById('billPart_UcHistory_divFasting_Duration').style.display = "none";

    //                document.getElementById('billPart_UcHistory_trLastMealTime_1099').style.display = "none";
    //                document.getElementById('billPart_UcHistory_divLastMealTime').style.display = "none";

    //                document.getElementById('billPart_UcHistory_trRecent_Sonography_Report_1100').style.display = "none";
    //                document.getElementById('billPart_UcHistory_divRecent_Sonography_Report').style.display = "none";

    //                document.getElementById('billPart_UcHistory_trurine_volume_Collected_1101').style.display = "none";
    //                document.getElementById('billPart_UcHistory_divurine_volume_Collected').style.display = "none";

    //                document.getElementById('billPart_UcHistory_trAbstinence_days_1102').style.display = "none";
    //                document.getElementById('billPart_UcHistory_divAbstinence_days').style.display = "none";

    //                document.getElementById('billPart_UcHistory_trOn_anti_thyroid_disease_drugs_1103').style.display = "none";
    //                document.getElementById('billPart_UcHistory_divOn_anti_thyroid_disease_drugs').style.display = "none";

    //                document.getElementById('billPart_UcHistory_trReading_taken_between_48_72_hrs_1104').style.display = "none";
    //                document.getElementById('billPart_UcHistory_divReading_taken_between_48_72_hrs').style.display = "none";

}

function popupprintHistory() {
    // document.getElementById('billPart_ButPrint').style.display = "none";
    //document.getElementById('billPart_Butsave').style.display = "none";
    //document.getElementById('billPart_Butclose').style.display = "none";

    var prtContent = document.getElementById('billPart_UcHistory_tblhistoryview');
    var prtContent1 = document.getElementById('billPart_UcHistory_tblbackgroundProbview');
    var prtContent2 = document.getElementById('billPart_UcHistory_tblpatientPreferenceview');
    var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,sta­tus=0');
    WinPrint.document.write(prtContent.innerHTML);
    WinPrint.document.write('<br/>');
    WinPrint.document.write(prtContent1.innerHTML);
    WinPrint.document.write('<br/>');
    WinPrint.document.write(prtContent2.innerHTML);
    WinPrint.document.close();
    WinPrint.focus();
    WinPrint.print();

}
function onTestListPopulated() {
    var completionList = $find("billPart_AutoCompleteExtender3").get_completionList();
    completionList.style.width = '350';
}

function edit_Click() {
    document.getElementById('billPart_UcHistory_divviewHistory').style.display = "none";
    document.getElementById('billPart_UcHistory_tblMain').style.display = "table";
    document.getElementById('billPart_Butsave').style.display = "inline";
    document.getElementById('billPart_ButPrint').style.display = "none";
    document.getElementById('billPart_ButEdit').style.display = "none";
    document.getElementById('billPart_UcHistory_tblhistoryview').innerHTML = "";



}
function getQueryStrings() {
    //Holds key:value pairs
    //changed by Arivalagan.k
    //var queryStringColl = null;
    queryStringColl = null;
    //Get querystring from url
    var requestUrl = window.location.search.toString();

    if (requestUrl != '') {
        //window.location.search returns the part of the URL 
        //that follows the ? symbol, including the ? symbol
        requestUrl = requestUrl.substring(1);

        queryStringColl = new Array();

        //Get key:value pairs from querystring
        var kvPairs = requestUrl.split('&');

        for (var i = 0; i < kvPairs.length; i++) {
            var kvPair = kvPairs[i].split('=');
            queryStringColl[kvPair[0]] = kvPair[1];
        }
    }

    return queryStringColl;
}


function edits_Click() {
    document.getElementById('billPart_UcHistory_divviewHistory').style.display = "none";
    document.getElementById('billPart_UcHistory_tblMain').style.display = "table";
    document.getElementById('billPart_Butsave').style.display = "inline";
    document.getElementById('billPart_ButPrint').style.display = "none";
    document.getElementById('billPart_ButEdit').style.display = "none";
    document.getElementById('billPart_UcHistory_tblhistoryview').innerHTML = "";
    document.getElementById('billPart_UcHistory_tblbackgroundProbview').innerHTML = "";
    document.getElementById('billPart_UcHistory_tblpatientPreferenceview').innerHTML = "";
    if ((document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML != "")
    || (document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').innerHTML != "")) {
        if (document.getElementById('trBackground_Problem_Patient_Preference') != null) {
            document.getElementById('trBackground_Problem_Patient_Preference').style.display = "table-row";
        }
    }
    else {
        if (document.getElementById('trBackground_Problem_Patient_Preference') != null) {
            document.getElementById('trBackground_Problem_Patient_Preference').style.display = "none";
        }
    }


}


function SelectedClientPatient(source, eventArgs) {
    var vPatientDetails = SListForAppDisplay.Get("Billing_CommonBilling_js_69") == null ? "Patient Details" : SListForAppDisplay.Get("Billing_CommonBilling_js_69")
    var vPatientNo = SListForAppDisplay.Get("Billing_CommonBilling_js_68") == null ? "Patient No:" : SListForAppDisplay.Get("Billing_CommonBilling_js_68")
    var isPatientDetails = "";
    isPatientDetails = eventArgs.get_value().split('|')[0];

    //changes by arun
  //  debugger;
    // var vlstOutput = isPatientDetails.split('~');

    // for (var i = 0; i < vlstOutput.length && !found; i++) {
        // if (vlstOutput[i].indexOf("TRFAVAIL") > -1) {
            // debugger;
            // found = true;
            // break;
        // }
    // }
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
    var PassportNo = isPatientDetails.split('~')[53];
    document.getElementById('txtpassportno').value = PassportNo;
    document.getElementById('txtsrfid').value = SRFID ;
    document.getElementById('txtLogistics').value = LogisticsName;
    document.getElementById('hdnLogisticsName').value = LogisticsName;
    document.getElementById('txtRoundNo').value =TRFID!=""?TRFID: RoundNo;
    document.getElementById('hdnLogisticsID').value = LogisticsID;
    document.getElementById('hdnEditDDlDOB').value = PatientAge.split(' ')[1];
    document.getElementById('hdnPatientAge').value = PatientAge.split(' ')[0];
    document.getElementById('hdnEdtPatientAge').value = PatientAge.split(' ')[0];
    document.getElementById('hdnPatientDOB').value = PatientDOB;
    document.getElementById('hdnPatientSex').value = PatientSex;
    document.getElementById('hdnpatName').value = PatientName;

    document.getElementById('txtPhleboName').value = PhleboName;
    document.getElementById('HdnPhleboID').value = PhleboID;
    document.getElementById('HdnPhleboName').value = PhleboName;
    document.getElementById('hdnpatName').value = PatientName;


    document.getElementById('tDOB').value = PatientDOB;
    document.getElementById('txtzone').value = ZoneName;
    document.getElementById('hdnZoneID').value = ZoneID
    document.getElementById('hdnautoautz').value = ExAutoAuthorization
    if (DispatchType != undefined) {
        document.getElementById('hdnDispatch').value = DispatchType;
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
    document.getElementById('txtClient').value = ClientntName;
    document.getElementById('hdnSelectedClientName').value = ClientntName;


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
    document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
    document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
    document.getElementById('ddlSex').value = PatientSex;
    if (document.getElementById('hdnEditSex') != null) {
        document.getElementById('hdnEditSex').value = PatientSex;
    }

    document.getElementById('ddMarital').value = PatientMaritalStatus;
    document.getElementById('txtMobileNumber').value = PatientMobile;
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
    if (document.getElementById('hdnClientPortal') != null) {
        if (document.getElementById('hdnClientPortal').value != 'Y') {
            if (document.getElementById('txtClient') != null) {
                document.getElementById('txtClient').focus();
            }
        }
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
    var panelLegend = $('#PnlPatientDetail legend');
    panelLegend.html(vPatientDetails).append('<b>('+ vPatientNo +  PatientNumber +   ')</b>');
    document.getElementById('PnlPatientDetail');
    document.getElementById('hdnPatientName').value = PatientName;
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
    if (document.getElementById('hdnDifferSanpleforDFV').value == "Y") {
        document.getElementById('hdnDOFromVisitFlag').value = 2;
    }

    EnabledFalse();

    // VEL | Rolling Amount | 10-01-2020 | Start | //
    var splitlist = eventArgs.get_value().split('#####');

    Rollingadamoutcalculation(splitlist[1]);
    // VEL | Rolling Amount | 10-01-2020 | END  | //
    
}
function LoadPreviousBillingItemsForClientPatient() {
    if (document.getElementById('hdnPreviousVisitDetails') != null) {
        document.getElementById('hdnPreviousVisitDetails').value = ''; //$('[id$="hdnPreviousVisitDetails"]').val("");

        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetPreviousVisitBilling",
            data: "{ 'PatientID': '" + parseInt(document.getElementById('hdnPatientID').value) + "','VisitID': '" + document.getElementById('hdnDoFrmVisit').value + "','Type': ''}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var ArrayItems = data.d;
                var Items = ArrayItems[0];
                var SamplesItems = ArrayItems[1];


                $.each(Items, function(index, Item) {
                    document.getElementById('hdnPreviousVisitDetails').value += Item.FeeDescription + '$' +
                    Item.FeeId + '$' + Item.FeeType + '$' + Item.Address + '$' +
                     Item.PatientHistory + '$' + Item.Status + '$' + Item.IsOutSource + '$' +
                     Item.ServiceCode + '$' + Item.IsAVisitPurpose + '$' + Item.VisitID + '^';

                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
                });
                $.each(SamplesItems, function(index, Item) {
                    if (document.getElementById('hdnDoFrmVisit').value != "") {
                        document.getElementById('hdnSampleforPrevious').value +=
                        Item.SampleCode + '$' + Item.SampleContainerID + '^';
                    }
                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
                });
                if (document.getElementById('hdnDoFrmVisit').value != "") {
                    $('input[id$="hdnSampleforPrevious"]').val(JSON.stringify(SamplesItems));
                }




                SetPreviousVisitItemsForClient();
                //alert(Items);
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }
}


function SetPreviousVisitItemsForClient() {
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
                + "<tr class = 'dataheader1' style='font-weight:bold;'><td style='width:30px;'>"+vS+"</td><td  style='width:330px;'>"+vTestName+"</td><td  style='display:none;width:30px;'>"+vID+"</td><td style='display:table-cell;width:30px;'>"+vType+"</td>"
                + "<td style='display:table-cell;width:30px;'><input id='chkAll' name='chkAll1' onclick='chkSelectAll(document.form1.chkAll);' value='SelectAll' type='checkbox'>"+vAll+"</input></td><td  style='display:none;'>"+vIsAddToday+"</td><td  style='display:none;'>"+vIsOutSource+"</td><td  style='display:none;'>"+vTestCode+"</td></tr>";

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
                    tblBoody += "<tr><td style='font-weight:bold' colspan='5' title='" + strPatientHistory + "'>"+vVisitDate +": " + curdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+vPatientHistory+": " + strPatientHistory.substring(0, 25) + "</td></tr>";
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
                    document.getElementById('tdVisitType1').style.display = "table-cell";
                    document.getElementById('tdVisitType2').style.display = "table-cell";
                    var NewOrgID = document.getElementById('hdnNewOrgID').value;
                    //                    document.getElementById('tdSex1').style.width = '10%';
                    //                    document.getElementById('tdSex2').style.width = '18%';
                }
            }

        }
        tblTotal += "<tr><td colspan='5' style='display:table-cell;' align='center'><input id='adds' type='button' value=" + UsrAdd + " class='btn' onclick='javascript:AddPreviousVisitItemsToBilling();' ></td></tr>";
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
function onClientListPopulated() {
    var completionList = $find("AutoCompleteExtenderVisitNo").get_completionList();
    completionList.style.width = '250';
}

function decimalAgeValue(Yr, M) {
    var DecimalAge;
    var days = new Date();
    var gmonth = days.getMonth();
    var tmonth;
    var Dobvalue = document.getElementById('txtDOBNos').value;
    Dobvalue = Dobvalue.split('.');
    gmonth = parseInt(gmonth + 1);
    if (gmonth > M) {
        if (Dobvalue.length > 1 || Dobvalue == '') {
            tmonth = parseInt(gmonth - M);
            DecimalAge = Yr + '.' + tmonth;
        }
        else {
            DecimalAge = Yr;
        }
    }
    else {
        if (gmonth == M) {
            DecimalAge = Yr;
        }
        else {
            tmonth = M - gmonth;
            tmonth = 12 - tmonth;
            DecimalAge = Yr + '.' + tmonth;
        }
    }

    document.getElementById('txtDOBNos').value = DecimalAge;

}
function CheckDecimalAges() {
    document.getElementById('tDOB').value = "";
}
function GetSelectedValue() {
    var ddlDiscountReason = document.getElementById("billPart_ddlDiscountReason");
    var DiscountReasonValue = ddlDiscountReason.options[ddlDiscountReason.selectedIndex].value;
    var DiscountReasonText = ddlDiscountReason.options[ddlDiscountReason.selectedIndex].text;
    document.getElementById("billPart_hdnDiscountReason").value = DiscountReasonValue + '~' + DiscountReasonText;
}

function GetSlab(DiscountId) {
    objSelect = SListForAppMsg.Get("Scripts_CommonBiling_js_04") == null ? "--Select--" : SListForAppMsg.Get("Scripts_CommonBiling_js_04");

    document.getElementById("billPart_ddlDiscountType").options.length = 0;
    document.getElementById("billPart_ddlDiscountReason").options.length = "";
    document.getElementById("billPart_ddlSlab").options.length = 0;
    var ddlDiscountType = document.getElementById("billPart_ddlDiscountType");
    var ddlSlab = document.getElementById("billPart_ddlSlab");
    var optn = document.createElement("option");
    ddlSlab.options.add(optn);
    optn.text = objSelect;
    optn.value = "0";
    var ddlDiscountReason = document.getElementById("billPart_ddlDiscountReason");
    var optn = document.createElement("option");
    ddlDiscountReason.options.add(optn);
    optn.text = objSelect;
    optn.value = "0";
    if (DiscountId != '' && DiscountId > 0) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetDiscountSlab",
            data: JSON.stringify({ DiscountId: DiscountId }),
            dataType: "json",
            success: function(data) {
                if (data.d.length > 0) {
                    var lstSlab = data.d[0];
                    var DiscountType = lstSlab[0].DiscountType;
                    var lstDiscountReason = data.d[1];
                    var DiscountType = '';
                    if (lstDiscountReason.length > 0) {
                        for (i = 0; i < lstDiscountReason.length; i++) {
                            var opt = document.createElement("option");
                            ddlDiscountReason.options.add(opt);
                            opt.text = lstDiscountReason[i].Reason;
                            opt.value = lstDiscountReason[i].ReasonCode;

                        }
                        opt = null;
                    }
                    if (lstSlab.length > 0) {
                        var DiscountType = lstSlab[0].DiscountType;
                        if (DiscountType == 'Foc') {
                            document.getElementById("billPart_chkFoc").checked = true;
                            document.getElementById("billPart_trDiscountType").style.display = 'none';
                            document.getElementById("billPart_trSlab").style.display = 'none';
                            document.getElementById("billPart_trCeiling").style.display = 'none';
                            document.getElementById('billPart_txtAuthorised').disabled = false;
                        }

                        else {
                            if (lstSlab.length > 0) {
                                for (i = 0; i < lstSlab.length; i++) {
                                    DiscountType = lstSlab[0].DiscountType;
                                    document.getElementById('billPart_hdnDiscountType').value = DiscountType;
                                }
                                var opt = document.createElement("option");
                                ddlDiscountType.options.add(opt);
                                if (DiscountType == 'Percentage') {
                                    opt.text = DiscountType;
                                    opt.value = 1;
                                    ddlDiscountType.selectedIndex = 0;
                                    opt = null;
                                }
                                else {
                                    opt.text = DiscountType;
                                    opt.value = 2;
                                    ddlDiscountType.selectedIndex = 0;
                                }
                                if (DiscountType == 'Percentage') {
                                    document.getElementById('billPart_txtCeiling').value = "";
                                    document.getElementById('billPart_hdnCeilingValue').value = "";

                                    document.getElementById("billPart_trDiscountType").style.display = 'table-row';
                                    document.getElementById("billPart_trSlab").style.display = 'table-row';
                                    document.getElementById("billPart_trCeiling").style.display = 'none';
                                    for (i = 0; i < lstSlab.length; i++) {
                                        var opt = document.createElement("option");
                                        ddlSlab.options.add(opt);
                                        //Modified by arivalagan.kk because Slab entity not  in object//
                                        opt.text = lstSlab[i].Discount + '%';
                                        opt.value = lstSlab[i].Discount + '~' + lstSlab[i].Code + '~' + lstSlab[i].CeilingValue;
                                        //End Modified by arivalagan.kk because Slab entity not  in object//
                                    }
                                    opt = null;
                                }
                                else {
                                    document.getElementById("billPart_ddlSlab").options.length = 0;
                                    document.getElementById("billPart_trDiscountType").style.display = 'table-row';
                                    document.getElementById("billPart_trSlab").style.display = 'none';
                                    document.getElementById("billPart_trCeiling").style.display = 'table-row';
                                    for (i = 0; i < lstSlab.length; i++) {
                                        // document.getElementsByName('billPart_txtCeiling').value = lstSlab[i].Ceiling;
                                        document.getElementById('billPart_hdnCeilingValue').value = lstSlab[i].CeilingValue + '~' + lstSlab[i].Code;
                                        var txtCeiling = document.getElementById('billPart_txtCeiling');
                                        if (txtCeiling != null && txtCeiling.value != '')
                                            SetNetValue('ADD');
                                    }

                                }
                            }

                            else {

                            }
                        }
                    }
                }
            },
            error: function(result) {
                alert("Eroor");
            }
        });
    }
}

function GetDiscount(CalForoneRupee, focDiscount, strType, OtherOrgDisPer) {

    var lstItems = document.getElementById('billPart_hdnItems').value + document.getElementById('billPart_hdnItemsNoDiscount').value;
    $('#billPart_hdnDiscountSlab').val("");
    arrayMainData = lstItems.split('-');
    var ItemLevelPercent = 0.00;
    var ItemLevelTotalPercent = 0.00;
    var ItemLevelDiscount = 0.00;
    var TotalDiscountAmount = 0.00;
    var lstDiscountDetails = [];
    var FinalItemDisPercentage = 0.00;
    var ItemDiscountPercent = 0.00;
    var ItemAmount = 0.00;
    var IsDiscountable;
    var DiscountTestTotalAmount = document.getElementById('billPart_hdnDiscountableTestTotal').value;
    if (arrayMainData.length > 0) {
        for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {
            var maindata = arrayMainData[iMain];
            var data = maindata.split('~');
            var Itemfeelid = data[0];
            var ItemType = data[1];
            if (data[2].trim() != "")
                ItemAmount = data[2];

            if (data[3].trim() != "" && data[3] != "undefined" && data[3] != null) {
                ItemDiscountPercent = data[3];
            }
            else {
                ItemDiscountPercent = 0.00;
            }
            if (data[4].trim() != "") {
                IsDiscountable = data[4];
            }


            if (strType === "WithoutDiscount") {
                ItemLevelAmount = ((ItemAmount * ItemDiscountPercent) / 100).toFixed(2);

            }
            else if (strType === "Others") {
            if (OtherOrgDisPer.trim != "") {
                if (IsDiscountable == "Y") {
                    ItemLevelAmount = ((ItemAmount * ItemDiscountPercent) / 100).toFixed(2);
                    ItemLevelDiscount = ((ItemAmount * OtherOrgDisPer) / 100).toFixed(2);
                    FinalItemDisPercentage = OtherOrgDisPer;
                }
                else if (IsDiscountable == "N") {
                ItemLevelAmount = ((ItemAmount * ItemDiscountPercent) / 100).toFixed(2);
                ItemLevelDiscount = 0.00;
                FinalItemDisPercentage = 0.00;
                }
                }
                else {
                    ItemLevelAmount = ((ItemAmount * ItemDiscountPercent) / 100).toFixed(2);
                    ItemLevelDiscount = ItemAmount * CalForoneRupee;
                    ItemLevelDiscount = (Math.round(ItemLevelDiscount)).toFixed(2);
                    FinalItemDisPercentage = parseFloat(((ItemLevelDiscount * 100) / ItemAmount)).toFixed(2);
                    FinalItemDisPercentage = Math.round(parseFloat(FinalItemDisPercentage)).toFixed(2);
                }

            }
            else {
                if (focDiscount === false) {
                    //3.1. Caclulate ItemLevel Discount Amount
                    if (IsDiscountable == 'Y') {
                        ItemLevelTotalPercent = ItemAmount * CalForoneRupee;
                        ItemLevelAmount = ((ItemAmount * ItemDiscountPercent) / 100).toFixed(2);
                    }
                    else {
                        ItemLevelTotalPercent = 0;
                        ItemLevelAmount = ((ItemAmount * ItemDiscountPercent) / 100).toFixed(2);
                    }
                }
                else {
                    ItemLevelTotalPercent = ItemAmount * CalForoneRupee;
                    ItemLevelAmount = ((ItemAmount * ItemDiscountPercent) / 100).toFixed(2);

                }

                //3.2. Calculate Item Level Celling Disocunt(MaxDiscount) Amount
                //if (Amount > 0 && MaxDiscount > 0) {
                //  ItemLevelAmount = ((ItemAmount * ItemDiscountPercent) / 100).toFixed(2);
                //}

                if (focDiscount === false) {

                    //4. Compare ItemLevel Discount Amount and Item Level Celling Disocunt(MaxDiscount) Amount and choose Less Value

                    if (ItemLevelAmount == ItemLevelTotalPercent) {
                        ItemLevelDiscount = ItemLevelAmount;
                    }
                    else if (ItemLevelAmount < ItemLevelTotalPercent) {
                        ItemLevelDiscount = ItemLevelAmount;
                    }
                    else if (ItemLevelTotalPercent < ItemLevelAmount) {
                        ItemLevelDiscount = ItemLevelTotalPercent;
                    }


                }
                else {
                    ItemLevelDiscount = ItemLevelTotalPercent;

                }
                if (ItemLevelDiscount != 0) {
                    if (IsDiscountable == 'Y') {
                        FinalItemDisPercentage = parseFloat(((ItemLevelDiscount * 100) / ItemAmount)).toFixed(2);
                        ItemLevelDiscount = Math.round(ItemLevelDiscount).toFixed(2);
                    }
                    else {
                        FinalItemDisPercentage = parseFloat(((ItemLevelDiscount * 100) / ItemAmount)).toFixed(2);
                        ItemLevelDiscount = Math.round(ItemLevelDiscount).toFixed(2);
                    }

                } else {
                    ItemLevelDiscount = 0.00;
                    FinalItemDisPercentage = 0.00;
                }
            }

            if (arrayMainData[iMain]) {
                lstDiscountDetails.push({
                    MaxTestDisPercentage: ItemDiscountPercent,
                    MaxTestDisAmount: ItemLevelAmount,
                    DiscountAmount: ItemLevelDiscount,
                    DiscountPercent: FinalItemDisPercentage,
                    feeID: Itemfeelid,
                    feeType: ItemType

                });

                $('#billPart_hdnDiscountSlab').val(JSON.stringify(lstDiscountDetails));
                TotalDiscountAmount = parseFloat(TotalDiscountAmount) + parseFloat(ItemLevelDiscount);
                document.getElementById('billPart_txtDiscount').value = Math.round(TotalDiscountAmount).toFixed(2);

            }
        }
    }
}
var Type;
var CardType;
function GetMemberDetails(Type, CardType) {
    //debugger;
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
        var objvar11 = SListForAppMsg.Get("Scripts_CommonBiling_js_38") == null ? "Please enter different card No." : SListForAppMsg.Get("Scripts_CommonBiling_js_38");
        ValidationWindow(objvar11, objAlert);
        objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
        //alert('Please enter different card No.');
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
    var objvar12 = SListForAppMsg.Get("Scripts_CommonBiling_js_39") == null ? "This coupon has already been redeemed on " : SListForAppMsg.Get("Scripts_CommonBiling_js_39");
    var objvar13 = SListForAppMsg.Get("Scripts_CommonBiling_js_40") == null ? "for  VID No" : SListForAppMsg.Get("Scripts_CommonBiling_js_40");
    var objvar14 = SListForAppMsg.Get("Scripts_CommonBiling_js_41") == null ? "Health coupon no is invalid." : SListForAppMsg.Get("Scripts_CommonBiling_js_41");
    var objvar15 = SListForAppMsg.Get("Scripts_CommonBiling_js_42") == null ? "Your Card Is Not Activated" : SListForAppMsg.Get("Scripts_CommonBiling_js_42");
    var objvar16 = SListForAppMsg.Get("Scripts_CommonBiling_js_43") == null ? "Your card is activated" : SListForAppMsg.Get("Scripts_CommonBiling_js_43");
    var objvar17 = SListForAppMsg.Get("Scripts_CommonBiling_js_44") == null ? "No data found" : SListForAppMsg.Get("Scripts_CommonBiling_js_44");

    var lstMycardDetails = [];
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/GetMemberDetails",
        data: JSON.stringify({ MemberCardNo: MemberCardNo, CardType: CardType, Type: Type }),
        dataType: "json",
        success: function(data) {

            if (data.d.length > 0) {
                var lstPatientHealthCard = data.d;
                if (data.d[0].CreditRedeemTye == "Redeem") {
                    $("#billPart_txtCardNo").val("");
                    $("#billPart_txtCardNo").focus();
                    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                    //alert("This coupon has already been redeemed on " + data.d[0].HasHealthCard + " for  VID No " + data.d[0].VisitID);
                    ValidationWindow(objvar12 + " " + data.d[0].HasHealthCard + " " + objvar13 + " " + data.d[0].VisitID, objAlert);
                    return false;
                }


                if (data.d[0].TotalCreditValue == 0) {
                    $("#billPart_txtCardNo").val("");
                    $("#billPart_txtCardNo").focus();
                    //                    alert("Health coupon no is invalid.");
                    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                    ValidationWindow(objvar14, objAlert);

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
                    //alert('Your card is activated');
                    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                    ValidationWindow(objvar16, objAlert);
return false;
                }
                else { //alert('Your card is not activated');
                    objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                    ValidationWindow(objvar15, objAlert);
return false;
                }

            }
            else {
                $('#DvRedeemOnetimePassword').hide();
                $("input#billPart_chkRedeem").attr('checked', false);
                $("input#billPart_chkCredit").attr('checked', false);
                //alert('No data found');
                objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                ValidationWindow(objvar17, objAlert);
return false;
            }





        },
        error: function(result) {
            alert("Error");
return false;
        }
    });
return false;

}
function AddCardPoints(cardNo, CreditValue, TotalReedemPointsAmt) {
    var TotalcardAmt = 0;
    try {
        if (CreditValue != 0) {
            $("#trTotal").remove();
            $("#trHeader").css("display", "")
            var row = $('<tr/>');
            var tdcardNo = $('<td/>').html("<span id='lblCardNo'>" + cardNo + "</span>");
            var tdPoints = $('<td/>').html("<span id='lblCardAmt'>" + Math.round(CreditValue).toFixed(2) + "</span>");
            var tddelete = $('<td/>').html('<INPUT style="BORDER-TOP-STYLE: none; CURSOR: pointer; TEXT-DECORATION: underline; BORDER-BOTTOM-STYLE: none; COLOR: red; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: transparent" type="button" value="Delete" id="lnkDelete" onclick="javascript:onDeleteCardDetails(this)">');

            var trTotal = $('<tr id="trTotal" />');
            var tdTotal = $('<td/>').html("Total");
            var previousRedemData = 0;
            var sds = $('#cardPoints tr');
            $('#cardPoints tr').each(function(i, n) {
                if (i == 0) {
                }
                else {
                    var $row = $(n);
                    var lblCardAmt = $row.find($('span[id$="lblCardAmt"]')).html();
                    if (typeof (lblCardAmt) === "undefined") {
                    }
                    else {
                        TotalcardAmt = TotalcardAmt + parseFloat(lblCardAmt);
                        previousRedemData = TotalcardAmt;
                    }
                }
            });

            var myCardDetails = $("#billPart_hdnmyCardDetailsbill").val();
            var InputData = "";
            var TotalcardAmt = parseFloat(CreditValue) + parseFloat(TotalcardAmt);
            var objvar18 = SListForAppMsg.Get("Scripts_CommonBiling_js_45") == null ? "Health coupon card Amount is zero." : SListForAppMsg.Get("Scripts_CommonBiling_js_45");

            InputData = '<input type="hidden" runat="server" value="' + myCardDetails + '" id="hdnmyCardDetailsval" />';
            //}
            row.append(tdcardNo).append(tdPoints).append(tddelete).append(InputData);
            $("#cardPoints").append(row);
            if (TotalcardAmt != 0) {
                var tdToalcardAmount = $('<td />').html(Math.round(TotalcardAmt).toFixed(2));
                var tdSpace = $('<td />').html("&nbsp;");
                trTotal.append(tdTotal).append(tdToalcardAmount).append(tdSpace);
                $("#cardPoints").append(trTotal);
                $('#billPart_lblCreditValue').text(Math.round(TotalcardAmt).toFixed(2));

            }
            else {
                $('#billPart_lblCreditValue').text('0');
                $("#trHeader").css("display", "none")
            }
            return Math.round(TotalcardAmt).toFixed(2);
        }
        else {
            // alert("Health coupon card Amount is zero.");
            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
            ValidationWindow(objvar18, objAlert);
            return "";
        }
    }
    catch (e) {
        return TotalcardAmt;
    }
}
function onDeleteCardDetails(obj) {

    var TotalcardAmt = 0;
    try {
        $("#trTotal").remove();
        if ($("#billPart_hdnMycardDetails").val() != "") {
            var lstCoAuth = JSON.parse($("#billPart_hdnMycardDetails").val());

            var $row1 = $(obj).closest('tr');
            var newArray = [];
            var rowIndex = $row1.index();
            var linqindex = 0;
            $.each(lstCoAuth, function(key, value) {
                if (rowIndex == key + 1) {

                }
                else {
                    newArray.push(lstCoAuth[linqindex])
                    linqindex = parseInt(linqindex) + 1
                }
            });

            $("#billPart_hdnMycardDetails").val(JSON.stringify(newArray));
            $(obj).closest('tr').remove();
            $('#cardPoints tr').each(function(i, n) {
                if (i == 0) {
                }
                else {
                    var $row = $(n);
                    var lblCardAmt = $row.find($('span[id$="lblCardAmt"]')).html();
                    if (typeof (lblCardAmt) === "undefined") {
                    }
                    else {
                        TotalcardAmt = TotalcardAmt + parseInt(lblCardAmt);
                    }
                }
            });
            var lstCoAuth = JSON.parse($('#billPart_hdnlstHealthCardItems').val());
            $.each(lstCoAuth, function(key, value) {
                value["RedeemAmount"] = TotalcardAmt;
                value["RedeemPoints"] = TotalcardAmt;
            });
            $("#billPart_hdnlstHealthCardItems").val(JSON.stringify(lstCoAuth));


            var trTotal = $('<tr id="trTotal" />');
            var tdTotal = $('<td/>').html("Total");
            var tdToalcardAmount = $('<td />').html(TotalcardAmt);
            var tdSpace = $('<td />').html("&nbsp;");
            trTotal.append(tdTotal).append(tdToalcardAmount).append(tdSpace);
            if (TotalcardAmt != 0) {
                $("#cardPoints").append(trTotal);
                $('#billPart_lblCreditValue').text(TotalcardAmt);

            }
            else {
                $("#trHeader").css("display", "none");
                $('#billPart_lblCreditValue').text('0');

            }
            if ($('#billPart_txtRedeem').val() > TotalcardAmt) {
                document.getElementById('billPart_hdnRedeemPoints').value = TotalcardAmt;
                $('#billPart_txtRedeem').val(parseFloat(TotalcardAmt).toFixed(2));
                $('#billPart_hdnRedeemValue').val(parseFloat(TotalcardAmt).toFixed(2));

                if (TotalcardAmt == "0") {
                    $("#billPart_hdnTotalRedeemPoints").val("");
                    $("#billPart_hdnTotalRedeemAmount").val("");
                    $("#billPart_hdntotalredemPoints").val("");
                }
                else {
                    $("#billPart_hdnTotalRedeemPoints").val(TotalcardAmt);
                    $("#billPart_hdnTotalRedeemAmount").val(TotalcardAmt);
                    $("#billPart_hdntotalredemPoints").val(TotalcardAmt);
                }
            }
        }
        SetNetValue('ADD');
        // $("#cardPoints").append(trTotal);
    }
    catch (e) {
        return false;
    }
    return false;
}

function GetMemberDetailsVerify(Type, CardType) {
    //  debugger;
    var MemberCardNo;
    if (CardType == 'CardNo') {
        MemberCardNo = $('#txtCardNo').val().trim();
    }
    else if (CardType == 'MobileNo') {
        MemberCardNo = $('#txtMobileNo').val().trim();
    }
    else {
        MemberCardNo = $('#txtCardNo').val().trim();
    }
    $('#lblCardStatus').text('');
    $('#lblCreditPoints').text('');
    $('#lblCreditValue').text('');
    var MembershipCardMappingID;
    var PatientID;
    var MembershipCardNo;
    var CreditPoints;
    var CreditValue;
    var Status;
    var OTP;
    var lstMycardDetails = [];
    $('#trStatus').css("display", "none");
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/GetMemberDetails",
        data: JSON.stringify({ MemberCardNo: MemberCardNo, CardType: CardType, Type: Type }),
        dataType: "json",
        success: function(data) {
            if (data.d.length > 0) {
                var lstPatientHealthCard = data.d;
                if (Type == 'VerifyMember') {
                    $('#trCreditValue').css("display", "");
                    for (i = 0; i < lstPatientHealthCard.length; i++) {
                        Status = lstPatientHealthCard[i].Status.trim();
                    }
                    $.each(lstPatientHealthCard, function(i, obj) {

                        PatientID = data.d[i].PatientID;
                        CreditPoints = data.d[i].TotalCreditPoints;
                        CreditValue = data.d[i].TotalCreditValue;
                        MembershipCardMappingID = data.d[i].MembershipCardMappingID;
                        OTP = data.d[i].OTP;
                        $('#hdnOtpExist').val(OTP);
                        $('#hdnMembershipCardMappingID').val(MembershipCardMappingID);

                    });

                    lstMycardDetails.push({
                        MembershipCardMappingID: MembershipCardMappingID,
                        TotalRedemPoints: CreditPoints,
                        TotalRedemValue: CreditValue,
                        PatientID: PatientID

                    });
                    $('#hdnMycardDetails').val(JSON.stringify(lstMycardDetails));
                    if (PatientID > 0 && PatientID != 0) {
                        $('#lblCreditPoints').text(CreditPoints);
                        $('#lblCreditValue').text(CreditValue);
                        $('#dvPoints').hide();
                    }
                    else {
                        $('#billPart_dvPoints').hide();
                    }
                }

                else if (Type == 'OTP') {
                    for (i = 0; i < lstPatientHealthCard.length; i++) {
                        Status = lstPatientHealthCard[i].Status.trim();
                    }
                    if (Status == "Active") {
                        alert('Your card is activated');
                    }
                    else { alert('Your card is not activated'); }
                }
            }
        },
        error: function(result) {
            alert("Error");
        }
    });

}



var OTPType;
function GenerateOtp(OTPType) {
    //debugger;
    var objvar19 = SListForAppMsg.Get("Scripts_CommonBiling_js_46") == null ? "Please provide the card number" : SListForAppMsg.Get("Scripts_CommonBiling_js_46");

    var MembershipCardMappingId;
    $('#lblOtpStatus').val('');
    $('#billPart_lblOtpStatus').text('');
    if (OTPType == 'VerifyOtp') {
        var CardNo = $('#txtCardNo').val();
        MembershipCardMappingId = $('#hdnMembershipCardMappingID').val();
    }
    else if (OTPType == 'Billing') {

        MembershipCardMappingId = $('#billPart_hdnMembershipCardMappingID').val();
    }
    if (OTPType === 'VerifyOtp' && CardNo == "") {
        //alert('Please provide the card number');
        objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
        ValidationWindow(objvar19, objAlert);
    }
    else {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/GetOTP",
            data: JSON.stringify({ MembershipCardMappingId: MembershipCardMappingId }),
            dataType: "json",
            success: function(data) {
                if (data != "") {
                    var NewOTP = data.d;
                    if (OTPType == 'Billing') {
                        $('#billPart_hdnOtpExist').val(NewOTP);
                        $('#trOtpVerifyStatus').css("display", "");
                        $('#billPart_lblOtpStatus').text('Your new OTP was sent your mobile number');
                        $('#billPart_lblOtpStatus').css("color", "Green");
                    }
                    else if (OTPType == 'VerifyOtp') {
                        $('#hdnOtpExist').val(NewOTP);
                        $('#lblOtpStatus').text('Your new OTP was sent your mobile number');
                        $('#lblOtpStatus').css("color", "Green");
                    }

                }
            },
            error: function(result) {
                alert("Error");
            }
        });
    }

}

function VerifyOtp() {
    // debugger;
    var objvar20 = SListForAppMsg.Get("Scripts_CommonBiling_js_47") == null ? "Your OTP is verified,You can continue billing" : SListForAppMsg.Get("Scripts_CommonBiling_js_47");
    var objvar21 = SListForAppMsg.Get("Scripts_CommonBiling_js_48") == null ? "Your OTP is InValid" : SListForAppMsg.Get("Scripts_CommonBiling_js_48");

    $('#billPart_lblOtpStatus').text('');
    var UserEnterOtp = $('#billPart_txtOTP').val().trim();
    var GeneratedOtp = $('#billPart_hdnOtpExist').val().trim();
    if (GeneratedOtp != "" && UserEnterOtp != "") {
        if (UserEnterOtp == GeneratedOtp) {
            $('#trOtpVerifyStatus').css("display", "");
            GetMemberDetails('OTP', '');
            //            $('#billPart_lblOtpStatus').text('Your OTP is verified,You can continue billing');
            $('#billPart_lblOtpStatus').text(objvar20);
            $('#billPart_lblOtpStatus').css("color", "Green");

        }
        else {
            $('#trOtpVerifyStatus').css("display", "")
            //            $('#billPart_lblOtpStatus').text('Your OTP is InValid');
            $('#billPart_lblOtpStatus').text(objvar21);
            $('#billPart_lblOtpStatus').css("color", "Red");
        }
    }
}
var TotalRedeemPoints, TotalRedeemAmount;
function ItemLevelCreditCal(TotalRedeemPoints, TotalRedeemAmount, totalredemPoints) {
    // debugger;

    TotalRedeemPoints = $("#billPart_hdnTotalRedeemPoints").val();
    TotalRedeemAmount = $("#billPart_hdnTotalRedeemAmount").val();
    totalredemPoints = $("#billPart_hdntotalredemPoints").val();
    var lstHealthCardItems = document.getElementById('billPart_hdnHealthCardItems').value;
    // $('#billPart_hdnHealthCardItems').val("");
    arrayMainData = lstHealthCardItems.split('-');
    var ItemAmount = 0.00;
    var ItemLevelRedeemAmount = 0.00;
    var RemainingReadingPoints;
    var RPoints;
    var newlstHealthCardItems = '';
    var IsEligible = 'N';
    var newlstHealthCardItemRedeem = [];
    var ToatlRPoints = 0;
    var TotalReedemPointsAmt = 0;
    // var DiscountTestTotalAmount = document.getElementById('billPart_hdnDiscountableTestTotal').value;
    var RedeemTestTotalAmount = document.getElementById('billPart_hdnRedeemableTestAmount').value;


    var TotalcardAmt1 = 0;
    //    $('#cardPoints tr').each(function(i, n) {
    //        if (i == 0) {
    //        }
    //        else {
    //            var $row = $(n);
    //            var lblCardAmt = $row.find($('span[id$="lblCardAmt"]')).html();
    //            if (typeof (lblCardAmt) === "undefined") {
    //            }
    //            else {
    //                TotalcardAmt1 = parseFloat(TotalcardAmt1) + parseFloat(lblCardAmt);
    //            }
    //            //  previousRedemData = TotalcardAmt;
    //        }
    //    });
    //  TotalReedemPointsAmt = TotalReedemPointsAmt + TotalcardAmt;
    ItemAmount = 0.00;
    ItemLevelRedeemAmount = 0.00;
    RemainingReadingPoints;
    RPoints;
    newlstHealthCardItems = '';
    IsEligible = 'N';
    newlstHealthCardItemRedeem = [];
    ToatlRPoints = 0;
    TotalRedeemAmount = totalredemPoints;
    if (Number(RedeemTestTotalAmount) < Number(TotalRedeemAmount)) {
        TotalRedeemAmount = RedeemTestTotalAmount;
    }

    var ItemLevelRedemableAmt = 0.00;
    var ItemLevelRedeemMasterpercent = 0;
    if (arrayMainData.length > 0) {
        for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {
            var maindata = arrayMainData[iMain];
            var data = maindata.split('~');
            var Itemfeelid = data[0];
            var ItemFeeType = data[1];
            var IsRedeem = data[4];
            if (data[2].trim() != "")
                ItemAmount = data[2];

            if (data[3].trim() != "") {
                ItemLevelRedeemMasterpercent = data[3];
            }
            else {
                ItemLevelRedeemMasterpercent = 0.00;
            }
            if (IsRedeem == "Y") {
                ItemLevelRedemableAmt = Number(parseFloat(ItemLevelRedemableAmt)) + Number(parseFloat((parseFloat(ItemAmount) * parseFloat(ItemLevelRedeemMasterpercent)) / 100).toFixed());
            }
        }
    }
    //var redeemAmnt = parseFloat(TotalRedeemAmount) / parseFloat(TotalReedemPointsAmt);
    var redeemAmntforSingleRupee = parseFloat(TotalRedeemAmount) / parseFloat(ItemLevelRedemableAmt);
    var TotalRedeemAmount1 = TotalRedeemAmount;
    var FinalItemLevelRedeemAmount = 0;
    var ItemLevelRedeemMasterpercent = 0;
    var ItemLevelRedeemMasterAmount = 0;
    if (TotalRedeemPoints != "" && TotalRedeemPoints != "0.00") {
        if (Number(redeemAmntforSingleRupee) > 0) {
            if (arrayMainData.length > 0) {
                for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {
                    var maindata = arrayMainData[iMain];
                    var data = maindata.split('~');
                    var Itemfeelid = data[0];
                    var ItemFeeType = data[1];
                    var IsRedeem = data[4];
                    if (data[2].trim() != "")
                        ItemAmount = data[2];
                    if (IsRedeem == "Y") {
                        if (data[3].trim() != "") {
                            ItemLevelRedeemMasterpercent = data[3];
                        }
                        else {
                            ItemLevelRedeemMasterpercent = 0.00;
                        }
                        ItemLevelRedeemMasterAmount = Number((Number(ItemAmount) * Number(ItemLevelRedeemMasterpercent)) / 100).toFixed();

                        RPoints = ItemLevelRedeemMasterAmount * redeemAmntforSingleRupee;

                        if (Number(ItemLevelRedeemMasterAmount) < Number(RPoints)) {
                            FinalItemLevelRedeemAmount = ItemLevelRedeemMasterAmount;
                        }
                        else {
                            FinalItemLevelRedeemAmount = RPoints;
                        }
                        RPoints = FinalItemLevelRedeemAmount;
                        //TotalRedeemAmount = Number(TotalRedeemAmount - ItemRedeemAmount).toFixed(2);
                        TotalRedeemAmount = Number(TotalRedeemAmount - FinalItemLevelRedeemAmount).toFixed(2);
                        // newlstHealthCardItems = newlstHealthCardItems + Itemfeelid + '~' + ItemFeeType + '~' + ItemAmount + '~' + ItemLevelRedeemAmount + '~' + IsRedeem + '~' + RPoints + '-';
                        IsEligible = 'Y';
                        var cardNo = $('#billPart_txtCardNo').val();

                        ToatlRPoints = Number(ToatlRPoints) + Number(RPoints);

                        newlstHealthCardItemRedeem.push({
                            FeeID: Itemfeelid,
                            FeeType: ItemFeeType,
                            IsRedeem: IsRedeem,
                            RedeemAmount: FinalItemLevelRedeemAmount,
                            RedeemPoints: FinalItemLevelRedeemAmount

                        });


                        $('#billPart_hdnlstHealthCardItems').val(JSON.stringify(newlstHealthCardItemRedeem));
                    }
                }
            }
        }
        else {
            if (arrayMainData.length > 0) {
                for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {
                    var maindata = arrayMainData[iMain];
                    var data = maindata.split('~');
                    var Itemfeelid = data[0];
                    var ItemFeeType = data[1];
                    var IsRedeem = data[4];
                    if (data[2].trim() != "")
                        ItemAmount = data[2];

                    if (data[3].trim() != "") {
                        ItemLevelRedeemMasterpercent = data[3];
                    }
                    else {
                        ItemLevelRedeemMasterpercent = 0.00;
                    }
                    ItemLevelRedeemMasterAmount = Number((Number(ItemAmount) * Number(ItemLevelRedeemMasterpercent)) / 100).toFixed();

                    RPoints = ItemLevelRedeemMasterAmount;
                    FinalItemLevelRedeemAmount = RPoints;
                    TotalRedeemAmount = Number(TotalRedeemAmount - ItemLevelRedeemMasterAmount).toFixed(2);
                    // newlstHealthCardItems = newlstHealthCardItems + Itemfeelid + '~' + ItemFeeType + '~' + ItemAmount + '~' + ItemLevelRedeemAmount + '~' + IsRedeem + '~' + RPoints + '-';
                    IsEligible = 'Y';
                    var cardNo = $('#billPart_txtCardNo').val();

                    //    }
                    //    else {
                    //        RPoints = 0;
                    // //       // newlstHealthCardItems = newlstHealthCardItems + Itemfeelid + '~' + ItemFeeType + '~' + ItemAmount + '~' + ItemLevelRedeemAmount + '~' + IsRedeem + '~' + 0.00 + '-';
                    //   }
                    ToatlRPoints = Number(ToatlRPoints) + Number(RPoints);

                    newlstHealthCardItemRedeem.push({
                        FeeID: Itemfeelid,
                        FeeType: ItemFeeType,
                        IsRedeem: IsRedeem,
                        RedeemAmount: FinalItemLevelRedeemAmount,
                        RedeemPoints: FinalItemLevelRedeemAmount

                    });
                    $('#billPart_hdnlstHealthCardItems').val(JSON.stringify(newlstHealthCardItemRedeem));
                }

            }
        }


        // document.getElementById('billPart_hdnRedeemPoints').value = TotalRedeemPoints;
        var objvar22 = SListForAppMsg.Get("Scripts_CommonBiling_js_49") == null ? "You are not eligible to redeem points" : SListForAppMsg.Get("Scripts_CommonBiling_js_49");
        var sds = ToatlRPoints;
        if (totalredemPoints != "") {
            document.getElementById('billPart_hdnRedeemPoints').value = parseFloat(ToatlRPoints).toFixed(2);
            $('#billPart_txtRedeem').val(parseFloat(ToatlRPoints).toFixed(2));
            if (ToatlRPoints == "") {
                $('#billPart_hdnRedeemValue').val(0);
            } else {
                $('#billPart_hdnRedeemValue').val(parseFloat(ToatlRPoints).toFixed(2));
            }

            if (IsEligible == 'N') {
                $('#DvRedeemOnetimePassword').hide();
                $('#billPart_pnlRedeem').hide();
                $("input#billPart_chkRedeem").attr('checked', false);
                //alert('You are not eligible to redeem points');
                objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
                ValidationWindow(objvar22, objAlert);

            }
        }
    }
    else {
        $('#billPart_txtRedeem').val("0.00");
        $('#billPart_hdnRedeemValue').val("0.00");
        $('#billPart_hdnRedeemPoints').val("0.00");

    }



    SetNetValue('ADD');
}
//function ItemLevelCreditCal(TotalRedeemPoints, TotalRedeemAmount) {
//    // debugger;
//    var lstHealthCardItems = document.getElementById('billPart_hdnHealthCardItems').value;
//    // $('#billPart_hdnHealthCardItems').val("");
//    arrayMainData = lstHealthCardItems.split('-');
//    var ItemAmount = 0.00;
//    var ItemLevelRedeemAmount = 0.00;
//    var RemainingReadingPoints;
//    var RPoints;
//    var newlstHealthCardItems = '';
//    var IsEligible = 'N';
//    var newlstHealthCardItemRedeem = [];
//    var ToatlRPoints = 0;
//    var DiscountTestTotalAmount = document.getElementById('billPart_hdnDiscountableTestTotal').value;
//    if (arrayMainData.length > 0) {
//        for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {
//            var maindata = arrayMainData[iMain];
//            var data = maindata.split('~');
//            var Itemfeelid = data[0];
//            var ItemFeeType = data[1];
//            var IsRedeem = data[4];
//            if (data[2].trim() != "")
//                ItemAmount = data[2];

//            if (data[3].trim() != "") {
//                ItemLevelRedeemAmount = data[3];
//            }
//            else {
//                ItemLevelRedeemAmount = 0.00;
//            }
//            ItemRedeemAmount = Number((Number(ItemAmount) * Number(ItemLevelRedeemAmount)) / 100).toFixed();

//            // if (Number(TotalRedeemAmount) >= Number(ItemRedeemAmount)) {
//            RPoints = ItemRedeemAmount;
//            //TotalRedeemAmount = Number(TotalRedeemAmount) - Number(ItemLevelRedeemAmount);
//            TotalRedeemAmount = Number(TotalRedeemAmount - ItemRedeemAmount).toFixed(2);
//            // newlstHealthCardItems = newlstHealthCardItems + Itemfeelid + '~' + ItemFeeType + '~' + ItemAmount + '~' + ItemLevelRedeemAmount + '~' + IsRedeem + '~' + RPoints + '-';
//            IsEligible = 'Y';
//            var cardNo = $('#billPart_txtCardNo').val();

//            //    }
//            //    else {
//            //        RPoints = 0;
//            // //       // newlstHealthCardItems = newlstHealthCardItems + Itemfeelid + '~' + ItemFeeType + '~' + ItemAmount + '~' + ItemLevelRedeemAmount + '~' + IsRedeem + '~' + 0.00 + '-';
//            //   }
//            ToatlRPoints = Number(ToatlRPoints) + Number(RPoints);

//            newlstHealthCardItemRedeem.push({
//                FeeID: Itemfeelid,
//                FeeType: ItemFeeType,
//                IsRedeem: IsRedeem,
//                RedeemAmount: RPoints,
//                RedeemPoints: TotalRedeemPoints

//            });
//            $('#billPart_hdnlstHealthCardItems').val(JSON.stringify(newlstHealthCardItemRedeem));
//        }


//        // document.getElementById('billPart_hdnRedeemPoints').value = TotalRedeemPoints;
//        document.getElementById('billPart_hdnRedeemPoints').value = ToatlRPoints;
//        $('#billPart_txtRedeem').val(parseFloat(ToatlRPoints).toFixed(2));
//        AddCardPoints(cardNo, TotalRedeemPoints);
//        if (ToatlRPoints == "") {
//            $('#billPart_hdnRedeemValue').val(0);
//        } else {
//            $('#billPart_hdnRedeemValue').val(parseFloat(ToatlRPoints).toFixed(2));
//        }

//        if (IsEligible == 'N') {
//            $('#DvRedeemOnetimePassword').hide();
//            $('#billPart_pnlRedeem').hide();
//            $("input#billPart_chkRedeem").attr('checked', false);
//            alert('You are not eligible to redeem points');

//        }
//    }
//    SetNetValue('ADD');
//}

function IsCheckMyCard() {
    document.getElementById('billPart_txtAuthorised').value = '';
    document.getElementById('billPart_txtPatientHistory').value = '';
    document.getElementById('billPart_txtRemarks').value = '';
    if (($("#txtClient").val() == "" || $("#billPart_hdnHasClientHealthcoupon").val() == "Y") && $("#billPart_hdnHasMyCard").val() == "Y" && $("#billPart_hdnIsCashClient").val() == "Y" && $("#billPart_hdnOrgHealthCoupon").val() == "Y" && (document.getElementById('billPart_ddDiscountPercent').selectedIndex == 0 || document.getElementById('billPart_ddDiscountPercent').value == 0) && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y") {
        $('#hdnIsMycardChecked').val('Y');
        $('#dvExistingCard').show();
        document.getElementById("billPart_dvHealhcard").style.display = "block";

    }
    else {

        $("#billPart_hdnMycardDetails").val("");
        $("#billPart_hdnTotalRedeemPoints").val("");
        $("#billPart_hdnTotalRedeemAmount").val("");
        $("#billPart_hdntotalredemPoints").val("");
        document.getElementById('billPart_hdnRedeemPoints').value = "0";
        $('#billPart_txtRedeem').val("0.00");
        $('#billPart_txtDiscount').val("0.00")
        $('#billPart_hdnRedeemValue').val("0.00");
        $('#billPart_lblCreditValue').text('0.00');

        onDeleteCardDetails();
        $('#cardPoints tr').each(function(i, n) {
            if (i == 0) {
            }
            else {
                var $row = $(n);
                $row.html("");
                $("#trHeader").css("display", "none");
            }
        });
        $('#hdnIsMycardChecked').val('N');
        $('#dvExistingCard').hide();
    }
    return false;

}

function ClearmycardDetails(obj) {
    if (obj == "N") {

        IsCheckMyCard();
        $('#dvMycard').hide();
        $('#trHealthCard').css("display", "none");
        $('#billPart_tdBillDetails').removeAttr("disabled");
        $('#dvExistingCard').hide();
        $('#billPart_txtDiscount').removeAttr("readonly");
        $("input#billPart_rbNewCard").attr('checked', false);
        $("input#billPart_chkRedeem").attr('checked', false);
        $("input#billPart_chkCredit").attr('checked', true);
        $("input#billPart_rbExistingCard").attr('checked', false);
        $('#dvExistingCard').hide();
        $('#dvPoints').hide();
    }
    $("#billPart_hdnMycardDetails").val("");
    $("#billPart_hdnTotalRedeemPoints").val("");
    $("#billPart_hdnTotalRedeemAmount").val("");
    $("#billPart_hdntotalredemPoints").val("");
    document.getElementById('billPart_hdnRedeemPoints').value = "0";
    $('#billPart_txtRedeem').val("0.00");
    $('#billPart_txtDiscount').val("0.00")
    $('#billPart_hdnRedeemValue').val("0.00");
    $('#billPart_lblCreditValue').text('0.00');

    onDeleteCardDetails();
    $('#cardPoints tr').each(function(i, n) {
        if (i == 0) {
        }
        else {
            var $row = $(n);
            $row.html("");
            $("#trHeader").css("display", "none");
        }
    });
}
function CalculateAge(birthday) {

    if (birthday.value != '') {
        var DOB = birthday.value.split('/');
        var calday = DOB[0];
        var calmon = DOB[1];
        var calyear = DOB[2];

        var dateObj = new Date();
        var curday = dateObj.getDate();
        var curmon = dateObj.getMonth() + 1;
        var curyear = dateObj.getFullYear();

        if (parseFloat(calyear) > parseFloat(curyear)) {
            alert("Enter  date of birth year less than current year");
            result_empty();
        }
        else if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) > parseFloat(curmon)) {
            alert("Enter date of birth month less than current month");
            result_empty();
        }
        else if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) == parseFloat(curmon) && parseFloat(calday) > parseFloat(curday)) {
            alert("Enter date of birth date less than current date");
            result_empty();
        }
        else {
            var curd = new Date(curyear, curmon - 1, curday);
            var cald = new Date(calyear, calmon - 1, calday);

            if (cald.getMonth() != (calmon - 1)) {
                //alert("Enter date of birth");
                // result_empty();
            }
            else if (curd.getMonth() != (curmon - 1)) {
                alert("Enter Valid Date");
                result_empty();
            }
            else {

                var dife = datediff(cald, curd);
                //var diff = Date.UTC(curyear, curmon - 1, curday, 0, 0, 0) - Date.UTC(calyear, calmon - 1, calday, 0, 0, 0);
                var splitAge = dife.split(':');
                var lAge = splitAge[0];
                var drpAge = splitAge[1];
//                var drpcode = "";
//                if (drpAge == "Day(s)") {
//                    drpcode = "D";
//                }
//                if (drpAge == "Month(s)") {
//                    drpcode = "M";
//                }
//                if (drpAge == "Week(s)") {
//                    drpcode = "W";
//                }
//                if (drpAge == "Year(s)") {
//                    drpcode = "Y";
//                }
                document.getElementById('txtDOBNos').value = lAge;
                document.getElementById('ddlDOBDWMY').value = drpAge;
            }
        }
    }
    //    var valAge = 105;
    //    var valage1 = 95;
    //    var AGE = document.getElementById('txtDOBNos').value;
    //    if (AGE >= valAge) {
    //        alert('Age Should not be Greater than 105');
    //        result_empty();
    //    }
    //    else if (AGE >= valage1 && AGE <= valAge) {
    //        var Userval = confirm('Age is Greater than 95 Do You want to continue');
    //    }

    //Changed by Arivalagan.kk//
    var valAge = 120;
    var valage1 = 95;
    var AGE = document.getElementById('txtDOBNos').value;
    if (AGE > valAge) {
        alert('Age Should not be Greater than 120');
        result_empty();
    }
    //Changed by Arivalagan.kk//

    if ($('#txtzone').length > 0) {
        if ($('#ddlSex').attr('disabled') == 'disabled') {
            $('#txtzone').focus();
        }
        else {$('#ddlSex').focus(); }
     }
     else {
         if (event.type == 'blur')
         {$('#txtDOBNos').focus();}
         else {
             $('#ddMarital').focus();
         }
     
     }
}
function datediff(dateFrom, dateTo) {
    var from = {
        d: dateFrom.getDate(),
        m: dateFrom.getMonth(),
        y: dateFrom.getFullYear()
    };

    var to = {
        d: dateTo.getDate(),
        m: dateTo.getMonth(),
        y: dateTo.getFullYear()
    };

    var daysFebruary = to.y % 4 != 0 || (to.y % 100 == 0 && to.y % 400 != 0) ? 28 : 29;
    var daysInMonths = [31, daysFebruary, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (to.d < from.d) {
        var monchg = parseInt(to.m) - 1;
        if (monchg < 0) { monchg = parseInt(to.m) };
        to.d += daysInMonths[monchg];
        from.m += 1;
    }

    if (to.m < from.m) {
        to.m += 12;
        from.y += 1;
    }
    var result = "";
    var days = to.d - from.d;
    var months = to.m - from.m;
    var years = to.y - from.y;
    if (years > 0 && months > 0) {
        result = years + "." + months + ':' + "Year(s)";
    }
    else if (years > 0) {
        result = years + ':' + "Year(s)";
    }
    else if (months > 0) {
        result = months + ':' + "Month(s)";
    }
    else {
        result = days + ':' + "Day(s)";
    }
    return result;
}
function result_empty() {
    document.getElementById('txtDOBNos').value = '';
    document.getElementById('tDOB').value = "dd/MM/yyyy";
    document.getElementById('tDOB').focus();
    return false;
}

function DeleteCapturePatientHistory(id) {
    var hdnDisplayTblIDValue = $("#hdnDisplayTblID").val().split('^');
    for (var i = 0; i < hdnDisplayTblIDValue.length; i++) {
        if ($.trim(hdnDisplayTblIDValue[i]) != "") {
            var SplitVal = hdnDisplayTblIDValue[i].split('~');
            strPattenName = SplitVal[0];
            InvestigationID = SplitVal[1];
            IName = SplitVal[2];
            if (Number(InvestigationID) == Number(id)) {
                var content = $("#hdnDisplayTblID").val().replace($.trim(hdnDisplayTblIDValue[i]), "");
                $("#hdnDisplayTblID").val('');
                $("#hdnDisplayTblID").val(content);
            }
        }
    }
}




function ClearAutocomp() {
    if (AutoCompSelected == false) {

        document.getElementById('billPart_txtTestName').value = '';

        return false;
    }

}

var counti = 0;
function BindDynamicFields() {
    var Result = [];
    counti++;
    var ClientID = $('#hdnSelectedClientClientID').val();
    if (ClientID != "" || ClientID != null) {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/ClientAttributesFieldDetails",
            data: "{ 'ReferenceID': " + ClientID + ",'ReferenceType':'CLIENT'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                Result = JSON.parse(data.d);
                if (Result.length == 0) {
                    document.getElementById('billPart_tdClientAttributes').style.display = 'none';
                }
                else {
                   
                    document.getElementById('billPart_tdClientAttributes').style.display = 'block';

                    var tablehead = "<table class='w-100p lh35'><tr>";
                    var inptstr = "";


                    var j = 0;
                    for (i = 0; i < Result.length; i++) {
                        j++;
                        if (Result[i].ControlType == "Textbox") {
                            inptstr = '<input type="text" class="client"  KEY="' + Result[i].LabelName + '"  name="lname">';
                        }
                        if (Result[i].ControlType == "DropDown") {
                            inptstr = MetaDataDropDown(Result[i].Domain, Result[i].LabelName);
                        }
                        if (Result[i].ControlType == "DateTime") {
                            inptstr = '<input type="text" class="attdatePicker client" placeholder="dd/mm/YYYY"  KEY="' + Result[i].LabelName + '"  name="lname">';
                        }
                        tablehead += "<td>" + Result[i].LabelName + "</td><td>" + inptstr + "</td>";
                        if (j == 3) {
                            tablehead += "</tr><tr>";
                            j = 0;
                        }

            }
            tablehead += "</table><br/><div><input type='button' style='margin-left: 50%;' id='btnAttrSave' onclick='SaveClientAttr()' Class='btn'  value='SAVE' /></div>";

            if (counti == 1) {
                $('#dialog').html('');
		$("#dialog").dialog({
                            closeText: "X"
                        });
                $('#dialog').append(tablehead);
            }

                    datetimepickerfnc();

                }

            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }

}
var countTest = 0;
function BindDynamicTestHistoryFields(FeeID, FeeType, name) {

    var Result = [];
    countTest++;
    document.getElementById('billPart_hdnTestHistFeeID').value = FeeID;
    document.getElementById('billPart_hdnTestHistFeeType').value = FeeType;
    if (FeeID != "" || FeeID != null || FeeType != "" || FeeType != null) {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/TestHistoryFieldDetails",
            data: "{ 'ReferenceID': " + FeeID + ",'ReferenceType':'TEST','TestType': '" + FeeType + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
            Result = JSON.parse(data.d);
                
                
                
                if (Result.length > 0) {

                  
                    var tablehead = "";
                    tablehead = "<table id='tblTestHistory' class='w-100p lh35'><tr>"
                    var inptstr = "";


                    var j = 0;
                    for (i = 0; i < Result.length; i++) {
                        j++;
                        if (Result[i].ControlType == "Textbox") {
                            inptstr = '<input type="text" class="testhistory"  KEY="' + Result[i].LabelName + '"  name="lname">';
                        }
                        if (Result[i].ControlType == "Label" && Result[i].LabelName == "Test Name") {
                            inptstr = '<span> ' + name + ' </span>';
                        }
                        if (Result[i].ControlType == "Label" && Result[i].LabelName != "Test Name") {
                            inptstr = '<span> ' + Result[i].LabelName + ' </span>';
                            Result[i].LabelName = 'Upload';

                        }
                        if (Result[i].ControlType == "DropDown") {
                            inptstr = MetaDataDropDowntesthistory(Result[i].Domain, Result[i].LabelName,"");
                        }
                        if (Result[i].ControlType == "DateTime") {
                            inptstr = '<input type="text" class="attdatePicker testhistory" placeholder="dd/mm/YYYY"  KEY="' + Result[i].LabelName + '"  name="lname">';
                        }
                        if (Result[i].ControlType == "CheckBox") {
                            inptstr = '<input type="checkbox" class="testhistory"  KEY="' + Result[i].LabelName + '"  name="lname" >';
                        }
                        tablehead += "<td>" + Result[i].LabelName + "</td><td>" + inptstr + "</td>";
                        if (j == 3) {
                            tablehead += "</tr><tr>";
                            j = 0;
                        }

                    }
			var vSave = SListForAppDisplay.Get("Billing_CommonBilling_js_76") == null ? "Save" : SListForAppDisplay.Get("Billing_CommonBilling_js_76");
                    var vClear = SListForAppDisplay.Get("Billing_CommonBilling_js_77") == null ? "Clear" : SListForAppDisplay.Get("Billing_CommonBilling_js_77");
                    tablehead += "</table><br/><div><table style='width: 100%;'><tr><td style='width: 50%;' align= 'right'><input  name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + name + "' type='button'  id='btnClearhistory' Class='btn' onclick='ClearTestHistroyPatient(name)'  value='"+vClear+"' /></td><td style='width: 50%;'><input type='button' id='btnhistorySave' onclick='SaveTestHistroyPatient()' Class='btn'  value='"+vSave+"' /></td></tr><t/table></div>";

                    if (countTest > 0) {
                        $('#dialog1').html('');
			$("#dialog1").dialog({
                            closeText: "X"
                        });
                        $('#dialog1').append(tablehead);
                    }

                    datetimepickerfnc();

                }

            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }

}

var countTestvalues = 0;
function BindDynamicTestHistoryCapturedValues(FeeID, FeeType, name, TestHistory) {
    var capturedarr;
    if (TestHistory != "") {
        capturedarr = JSON.parse(TestHistory);
    }
    var captureTestarr = [];
    if (capturedarr != undefined) {
        captureTestarr = capturedarr.filter(function(item) {
            return item.ReferenceID == FeeID && item.TestType == FeeType;
        });
    }
if (captureTestarr.length == 0) {
    BindDynamicTestHistoryFields(FeeID, FeeType, name);
    return false;
}
    var Result = [];
    countTestvalues++;
    document.getElementById('billPart_hdnTestHistFeeID').value = FeeID;
    document.getElementById('billPart_hdnTestHistFeeType').value = FeeType;
	var varTestName = SListForAppDisplay.Get("Billing_CommonBilling_js_59") == null ? "Test Name" : SListForAppDisplay.Get("Billing_CommonBilling_js_59");
    if (FeeID != "" || FeeID != null || FeeType != "" || FeeType != null) {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/TestHistoryFieldDetails",
            data: "{ 'ReferenceID': " + FeeID + ",'ReferenceType':'TEST','TestType': '" + FeeType + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                Result = JSON.parse(data.d);


                if (Result.length > 0) {

                    hash = Object.create(null);

                    Result.forEach(function(a) {
                        hash[a.LabelName] = a;
                    });

                    captureTestarr.forEach(function(a) {
                        Object.keys(a).forEach(function(k) {
                            hash[a.Key][k] = a[k];
                        });
                    });

                    var tablehead = "";
                    tablehead = "<table id='tblTestHistory' class='w-100p lh35'><tr>"
                    var inptstr = "";


                    var j = 0;
                    for (i = 0; i < Result.length; i++) {
                        j++;
                        if (Result[i].ControlType == "Textbox") {
                            inptstr = '<input type="text" class="testhistory"  KEY="' + Result[i].LabelName + '" value="' + Result[i].Valuedata + '"  name="lname">';
                        }
                        if (Result[i].ControlType == "Label" && Result[i].LabelName == varTestName) {
                            inptstr = '<span> ' + name + ' </span>';
                        }
                       if (Result[i].ControlType == "Label" && Result[i].LabelName != "Test Name") {
                            inptstr = '<span> ' + Result[i].LabelName + ' </span>';
                            Result[i].LabelName = 'Upload';

                        }
                        if (Result[i].ControlType == "DropDown") {
                            inptstr = MetaDataDropDowntesthistory(Result[i].Domain, Result[i].LabelName, Result[i].Valuedata);

                        }
                        if (Result[i].ControlType == "DateTime") {
                            inptstr = '<input type="text" class="attdatePicker testhistory" placeholder="dd/mm/YYYY"  KEY="' + Result[i].LabelName + '" value="' + Result[i].Valuedata + '"  name="lname">';
                        }
                        if (Result[i].ControlType == "CheckBox") {

                            if (Result[i].Valuedata == "Y") {
                                inptstr = '<input type="checkbox" class="testhistory"  KEY="' + Result[i].LabelName + '"  name="lname" checked="checked">';

                            }
                            else {
                                inptstr = '<input type="checkbox" class="testhistory"  KEY="' + Result[i].LabelName + '"  name="lname" >';

                            }
                            



                        }
                        tablehead += "<td>" + Result[i].LabelName + "</td><td>" + inptstr + "</td>";
                        if (j == 3) {
                            tablehead += "</tr><tr>";
                            j = 0;
                        }

                    }
		var vSave = SListForAppDisplay.Get("Billing_CommonBilling_js_76") == null ? "Save" : SListForAppDisplay.Get("Billing_CommonBilling_js_76");
                    var vClear = SListForAppDisplay.Get("Billing_CommonBilling_js_77") == null ? "Clear" : SListForAppDisplay.Get("Billing_CommonBilling_js_77");
                    var vUpdate = SListForAppDisplay.Get("Billing_CommonBilling_js_78") == null ? "Update" : SListForAppDisplay.Get("Billing_CommonBilling_js_78");
                    tablehead += "</table><br/><div><table style='width: 100%;'><tr><td style='width: 50%;' align= 'right'><input type='button' name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + name + "' id='btnClearhistory' Class='btn' onclick='ClearTestHistroyPatient(name)'  value="+vClear+" /></td><td style='width: 50%;'><input type='button' id='btnhistorySave' onclick='SaveTestHistroyPatient()' Class='btn'  value='"+vUpdate+"' /></td></tr><t/table></div>";

                    if (countTestvalues > 0) {
                        $('#dialog1').html('');
			$("#dialog1").dialog({
                            closeText: "X"
                        });
                        $('#dialog1').append(tablehead);
                    }

                    datetimepickerfnc();

                }

            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }

}
function MetaDataDropDown(Domain, LabelName) {
    var Result = [];
    drpdwn = "";
    var drpdwn = "<Select class='client' key='" + LabelName + "'>";
    var OrgID = document.getElementById('hdnOrgID').value;

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/LoadMetaDataDropDownValues",
        data: "{ 'OrgID': " + parseInt(OrgID) + ",'Domain':'" + Domain + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {

            Result = JSON.parse(data.d);
            $.each(Result, function(key, value) {
                drpdwn += "<option value=" + value.Code + ">" + value.DisplayText + "</option>"
            });
            drpdwn += "</Select>";
        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }
    });


    return drpdwn;
}
function MetaDataDropDowntesthistory(Domain, LabelName,AssigneeName) {
    var Result = [];
    drpdwn = "";
    var drpdwn = "<Select class='testhistory' key='" + LabelName + "'>";
    var OrgID = document.getElementById('hdnOrgID').value;

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/LoadMetaDataDropDownValues",
        data: "{ 'OrgID': " + parseInt(OrgID) + ",'Domain':'" + Domain + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {

            Result = JSON.parse(data.d);
            $.each(Result, function(key, value) {

            if (AssigneeName != "" && AssigneeName == value.DisplayText) {
                drpdwn += "<option value=" + value.Code + " selected='selected'>" + value.DisplayText + "</option>"
                }
                else {
                    drpdwn += "<option value=" + value.Code + ">" + value.DisplayText + "</option>"
                }
            });
            drpdwn += "</Select>";
        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }
    });


    return drpdwn;
}
function dialogfunc() {
          var vPatientHistory = SListForAppDisplay.Get("Billing_CommonBilling_js_72") == null ? "Patient History" : SListForAppDisplay.Get("Billing_CommonBilling_js_72");
    $(function() {
        $("#dialog").dialog({
            modal: true,
            autoOpen: false,
            resizable: false,
            title: "Client Attributes",
            width: 1100,
            height: 300
        });
        $("#dialog1").dialog({
            modal: true,
            autoOpen: false,
            resizable: false,
            title: vPatientHistory,
            width: 1100,
            height: 300
        });
        $("#dialogdue").dialog({
            modal: true,
            autoOpen: false,
            resizable: false,
            title: "Due Reason and Approved By",
            width: 1000,
            height: 150
        });
        $("#clientwise").click(function(e) {
            BindDynamicFields();
            GetAttributesValues();
            $('#dialog').dialog('open');
        });
        $("#clientwise1").click(function(e) {
            BindDynamicFields();
            GetAttributesValues();

            $('#dialog').dialog('open');
        });
    });
}
function datetimepickerfnc() {
    $(function() {
        $(".attdatePicker").datepicker();
    });
}


function SaveClientAttr() {
    $('#hdnClientAttrList').val("");
    var lstCtrl = $('.client');
    var keyName = "";
    var value = "";
    var ReferenceID = $('#hdnSelectedClientClientID').val();
    var arr = [];
    $.each(lstCtrl, function(key, result) {
        //  alert(key + ": " + value);
        if (result.tagName == "INPUT") {
            keyName = result.attributes.key.value;
            value = result.value;

        }
        else if (result.tagName == "SELECT") {
            keyName = result.attributes.key.value;
            if (result.selectedOptions[0].innerText.includes("Select")) {
                value = "";
            }
            else {
                value = result.selectedOptions[0].innerText;
            }
        }
        arr.push({
            Key: keyName,
            Valuedata: value,
            ReferenceID: parseInt(ReferenceID),
            ReferenceType: "Client"
        });
    });
    var jsonresult = JSON.stringify(arr);
    arr = [];
    $('#hdnClientAttrList').val(jsonresult);
    jsonresult = "";
    $("#dialog").dialog('close');
    ValidationWindow("Successfully Saved!!", "Alert");
}

function ClearTestHistroyPatient(name) {
    var Feevalues = new Array();
    Feevalues = name.split('~');
    var FeeID, FeeType, FeeName;

    if (Feevalues.length > 0) {
        FeeID = Feevalues[0];
        FeeType = Feevalues[1];
        FeeName = Feevalues[2];
        FeeID = FeeID.split('^');
        FeeType = FeeType.split('^');
        FeeName = FeeName.split('^');
        FeeID = FeeID[1];
        FeeType = FeeType[1];
        FeeName = FeeName[1];
    }
    BindDynamicTestHistoryFields(FeeID, FeeType, FeeName);
   return false;
}
var arr = [];
function SaveTestHistroyPatient() {
    var testvalidation = 0;
    var validationcheck = false;
    $('#hdnTestHistoryPatient').val("");
    var lstCtrlhistory = $('.testhistory');
   
    var keyName = "";
    var value = "";

    var ReferenceID = document.getElementById('billPart_hdnTestHistFeeID').value;
    var TestType = document.getElementById('billPart_hdnTestHistFeeType').value;

    arr = arr.filter(function(item) {
    return item.ReferenceID != ReferenceID;
    });

    $.each(lstCtrlhistory, function(key, result) {
        //  alert(key + ": " + value);
        if (result.tagName == "INPUT") {
            keyName = result.attributes.key.value;
            if (result.type == "checkbox") {
                if (result.checked == true) {
                    value = 'Y';
                }
                else {
                    value = 'N';
                }
            }
            else {
                value = result.value;
            }



        }
        else if (result.tagName == "SELECT") {
            keyName = result.attributes.key.value;
            if (result.selectedOptions[0].innerText.includes("Select")) {
                value = "";
            }
            else {
                value = result.selectedOptions[0].innerText;
            }
        }

        arr.push({
            Key: keyName,
            Valuedata: value,
            ReferenceID: parseInt(ReferenceID),
            ReferenceType: "TEST",
            TestType: TestType
        });
        if (value != "") {
            if (result.type != "checkbox") {
                testvalidation = 1;
            }
        }
    });

    if (testvalidation == 0) {
        validationcheck = ConfirmWindow('Collect Clinical History for this test', 'Alert', 'Ok', 'Close');

       
   }
   if (validationcheck == false) {
       var jsonresult = JSON.stringify(arr);
       //arr = [];


       $('#hdnTestHistoryPatient').val(jsonresult);

       jsonresult = "";
       $("#dialog1").dialog('close');
   }
    //ValidationWindow("Test History Successfully Saved!!", "Alert");
}

function GetAttributesValues() {
    var Result = [];
    var lstCtrl = $('.client');
    
    var ClientID = $('#hdnSelectedClientClientID').val();
    var PatientVisitID = document.getElementById('hdnVisitID').value;
    if (ClientID != "" || ClientID != null) {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/ClientAttributesFieldValues",
            data: "{ 'ReferenceID': " + ClientID + ",'ReferenceType':'CLIENT','PatientVisitID':" + PatientVisitID + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                Result = JSON.parse(data.d);
                for (var i = 0; i < Result.length; i++) {
                    $.each(lstCtrl, function(key, result1) {
                        if (result1.tagName == "INPUT") {
                            //keyName = result.attributes.key.value;
                            //value = result.value;
                            if (Result[i].Key == result1.attributes.key.value) {
                                result1.value = Result[i].Valuedata;
                            }

                        }
                        else if (result1.tagName == "SELECT") {
                        if (Result[i].Key == result1.attributes.key.value) {
                            //result1.selectedValue = Result[i].Valuedata;
                            var n = result1.options.length;
                            for (var j = 0; j < n; j++) {
                                if (result1.options[j].text == Result[i].Valuedata) {
                                    result1.options[j].selected = true;
                                    break;
                                }
                            }
                        }

                        }
                    });
                }
            }
        })
    }
}


function ClearClientAttr() {


    $("#txtClient").click(function() {
    $('#hdnClientAttrList').val("");
        var id = $(this).attr("id");
        // we have here tow states :#1 and #2 
        //#1  there is no Id, and thats mean we want to insert to database
        if (typeof id != 'undefined') {
            if (document.getElementById('billPart_tdClientAttributes').style.display == 'block') {
                counti = 0;
                document.getElementById('billPart_tdClientAttributes').style.display = 'none';
            }

        }
    });

    //});
}
$(function() {


    $("#txtSpecimen").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../OPIPBilling.asmx/LoadSpecialSamples',
                data: JSON.stringify({ prefixText: request.term }),
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {
                        response($.map(data.d, function(item) {
                            var rsltlable = item.SampleDesc;
                            var rsltvalue = item.SampleCode;
                            return {
                                label: rsltlable,
                                val: rsltvalue
                            }
                        }))
                    }
                    else {
                        response([{ label: 'No results found.', val: -1}]);
                        $("#billPart_hdnspecimenid").val("");
                        $("#billPart_hdnspecimenname").val("");
                        // Clear();
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
                $("#billPart_hdnspecimenid").val("");
                $("#billPart_hdnspecimenname").val("");
            }
            else {
                $("#billPart_hdnspecimenid").val(i.item.val);
                $("#billPart_hdnspecimenname").val(i.item.label);
            }
        },
        minLength: 2
    });

});

function addspecimentabledetails() {
    $('#divspectab').show();
    var Speccount = 0;
    var SpecisExists = 0;
    var SpecialSampleID;
    var SpecimenName;
    var SampleCount;
    var TestID = 0;
    var TestName;
    var TestType;
    var TTable = null;
    $('#billPart_lblTCCount').html('0');
    SpecialSampleID = $('#billPart_hdnspecimenid').val();
    SpecimenName = $('#billPart_hdnspecimenname').val();
    SampleCount = $('#txtContainercount').val();
    TestID = SpecFeeID;
    TestName = SpecFeeName;
    TestType = SpecFeetype;
    

    if (SpecialSampleID <= 0) {
        alert('please choose specimen!');
        $('#txtSpecimen').val('');
        return false;
    }

    if (SampleCount <= 0) {
        alert('please enter specimen count!');
        $('#txtContainercount').val('');
        return false;
    }

    if ($(this).attr('value') == 'Update') {
        $.each(arr, function(id, val) {

            if (val.SpecialSampleID == SpecialSampleID) {
                arr[id].SpecimenName = SpecimenName;
                arr[id].SampleCount = SampleCount;
            }

        });

        $.each(arr, function(id, val) {

            Speccount = parseInt(Speccount) + parseInt(val.SampleCount);

        });
        $('#billPart_lblTCCount').html(Speccount);
    }

    else {

        $.each(arr, function(id, val) {

            if (SpecisExists == 0 && SpecialSampleID == val.SpecialSampleID) {
                SpecisExists = 1;
            }
            Speccount = parseInt(Speccount) + parseInt(val.SampleCount);

        });

        if (SpecisExists == 1) {
            alert('Specimen Already Exist!');
            $('#billPart_hdnspecimenid').val('');
            $('#billPart_hdnspecimenname').val('');
            $('#txtContainercount').val('');
            $('#txtSpecimen').val('');
            return false;
        }

        else if (SpecisExists == 0) {

            arr.push(
        {
            TestID: TestID,
            TestName: TestName,
            TestType: TestType,
            SpecialSampleID: SpecialSampleID,
            SpecimenName: SpecimenName,
            SampleCount: SampleCount
        });

            Speccount = parseInt(Speccount) + parseInt(SampleCount);

        }
        $('#billPart_lblTCCount').html(Speccount);
    }

    $('#TblSpecimen').show();



    TTable = $('#TblSpecimen').dataTable({
        paging: false,
        "searching": false,
        "Info": false,
        "paging": false,
        "ordering": false,
        "info": false,
        data: arr,
        "bDestroy": true,
        "fnDrawCallback": function() {
            $('.deleteIcons').click(function() {
                var id = $(this).attr('SpecialSampleID');
                var row = $(this).closest("tr").get(0);
                TTable.fnDeleteRow(TTable.fnGetPosition(row));
                arr = $.grep(arr, function(ind, val) {
                    return ind.SpecialSampleID != id;

                });
                Speccount = 0;
                $.each(arr, function(id, val) {

                    Speccount = parseInt(Speccount) + parseInt(val.SampleCount);

                });
                $('#billPart_lblTCCount').html(Speccount);
            })

            $('.EditIcons').click(function() {
                $('#billPart_btnspecAdd').attr('value', 'Update');
                $("#billPart_hdnspecimenid").val($(this).attr('SpecialSampleID'));
                $("#billPart_hdnspecimenname").val($(this).attr('SpecimenName'));
                $('#txtContainercount').val($(this).attr('SampleCount'));
                $('#txtSpecimen').val($(this).attr('SpecimenName'));
                var id = $(this).attr('SpecialSampleID');
                var row = $(this).closest("tr").get(0);
                TTable.fnDeleteRow(TTable.fnGetPosition(row));
                arr = $.grep(arr, function(ind, val) {
                    return ind.SpecialSampleID != id;

                });
            })
        },
        columns: [
        { 'data': 'TestID',
            "sClass": "hide_Column"

        },
          { 'data': 'TestName', "sClass": "alignCenter" },
           { 'data': 'TestType',
               "sClass": "hide_Column"

           },

                                            { 'data': 'SpecialSampleID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'SpecimenName', "sClass": "alignCenter" },
                                             { 'data': 'SampleCount', "sClass": "alignCenter" },

                                            {

                                                "mRender": function(data, type, full, meta) {

                                                var txt = '<input TestID="' + full.TestID + '" TestName="' + full.TestName + '" TestType="' + full.TestType + '" SampleCount="' + full.SampleCount + '" SpecimenName="' + full.SpecimenName + '" SpecialSampleID="' + full.SpecialSampleID + '" type="button" class="EditIcons alignCenter" value ="Edit" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >';
                                                    txt = txt + '<label size="5"> / </label>';
                                                    txt = txt + '<input TestID="' + full.TestID + '" SpecialSampleID= "' + full.SpecialSampleID + '" type="button" class="deleteIcons alignCenter" value ="Delete" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >';
                                                    return txt;
                                                }

}]
    });


    $('#billPart_hdnspecimenid').val('');
    $('#billPart_hdnspecimenname').val('');
    $('#txtContainercount').val('');
    $('#txtSpecimen').val('');
    $('#billPart_btnspecAdd').attr('value', 'Add');

}

function btnspecclear() {
    var table = $('#TblSpecimen').DataTable();
//    arr = [];
//    Specarray = [];
    // table.clear();
   // table.row().remove();
   // $('#TblSpecimen').empty();
    $("#billPart_hdnspecimenid").val($(this).attr(''));
    $("#billPart_hdnTestFeeID").val($(this).attr(''));
    $("#billPart_hdnspecimenname").val($(this).attr(''));
    $('#txtContainercount').val($(this).attr(''));
    $('#txtSpecimen').val($(this).attr(''));
    $('#txtClinicalNotes').val($(this).attr(''));
    $('#txtClinicalDiag').val($(this).attr(''));
    $('#billPart_lblTCCount').html('0');
  //  $("#billPart_hdnSpecimenValues").val($(this).attr(''));
    $('#billPart_btnspecAdd').attr('value', 'Add');

}

function btnspecsaveclear() {
    var table = $('#TblSpecimen').DataTable();
    arr = [];
    Specarray = [];
    // table.clear();
    table.row().remove();
    $('#TblSpecimen').empty();
    $("#billPart_hdnspecimenid").val($(this).attr(''));
    $("#billPart_hdnspecimenname").val($(this).attr(''));
    $("#billPart_hdnTestFeeID").val($(this).attr(''));
    $('#txtContainercount').val($(this).attr(''));
    $('#txtSpecimen').val($(this).attr(''));
    $('#txtClinicalNotes').val($(this).attr(''));
    $('#txtClinicalDiag').val($(this).attr(''));
    $('#billPart_lblTCCount').html('0');
    $('#billPart_btnspecAdd').attr('value', 'Add');

}

//function btnspecclose() {
//    var table = $('#TblSpecimen').DataTable();
//    table.clear();
//    arr = [];
//    $('#TblSpecimen').empty();
//    $("#billPart_hdnspecimenid").val($(this).attr(''));
//    $("#billPart_hdnspecimenname").val($(this).attr(''));
//    $('#txtContainercount').val($(this).attr(''));
//    $('#txtSpecimen').val($(this).attr(''));
//    $('#txtClinicalNotes').val($(this).attr(''));
//    $('#txtClinicalDiag').val($(this).attr(''));
//    $('#billPart_lblTCCount').html('0');

//}

function saveSpecimendetails() {


    var table = $('#TblSpecimen').DataTable();
    var FeeID = 0;
    var Feetype = '';
    var Isspecialtest = '';
    Isspecialtest = $("#billPart_hdnIsSpecialTest").val();

    if ($('#billPart_btnspecAdd').val() == 'Add') {

        if (!table.data().count()) {
            alert('Empty specimen details cannot be save!');
            table.destroy();
            $('#TblSpecimen').hide();
            return false;
        }
        $('#TblSpecimen').show();
        var ClinicalNotes = $('#txtClinicalNotes').val();
        var ClinicalDiag = $('#txtClinicalDiag').val();

        $('#TblSpecimen th').each(function(index, item) {
            Specheaders[index] = $(item).html().split(" ").join("");
        });
        Specheaders[6] = 'ClinicalNotes';
        Specheaders[7] = 'ClinicalDiagnosis';

        var lstItem = '';
        $('#TblSpecimen tr').has('td').each(function() {
            var arrayItem = {};
            var text = '';
            $('td', $(this)).each(function(index, item) {
                if (index <= 5) {
                    arrayItem[Specheaders[index]] = $(item).html();
                    text = text + ',' + $(item).html();
                }
            });
            arrayItem[Specheaders[6]] = ClinicalNotes;
            arrayItem[Specheaders[7]] = ClinicalDiag;

        if (ClinicalNotes != '') {
            text = text + ',' + ClinicalNotes;
        }
        if (ClinicalDiag != '') {
            text = text + ',' + ClinicalDiag;
        }

           
            Specarray.push(arrayItem);
            lstItem = lstItem + text.substring(1, text.length) + '~';
        });
        lstItem = lstItem.substring(0, lstItem.length - 1);
        // $("#billPart_hdnSpecimenValues").val(lstItem);
        $('#billPart_btnspecclose').click();
        // SpecFeeID = '';
        // SpecFeetype = '';
        AddSpecimenDetails();
        if (Specarray != '') {
            alert('Saved Sucessfully!');
            closeModdalDialog('mymodaldiag2', 'myModalclass2');
        }
        Specarray = [];
        btnspecsaveclear();
        return false;
    }
    else {
        alert('Please update the specimen details!');
        return false;
    }
}

function AddSpecimenDetails() {
    var isEmpty = hasEmptyValues(Specarray);
    var SpecValue = '';
    if (isEmpty == true) {

       var totalList =GetSpecimenList();

       $.each(totalList, function(id, val) {

        SpecValue += val.TestID + ',' + val.TestName + ',' + val.TestType + ',' + val.SpecialSampleID + ',' + val.Specimen + ',' + val.ContainerCount + ',' + val.ClinicalNotes + ',' + val.ClinicalDiagnosis + '~';

        });

        SpecValue = SpecValue.substring(0, SpecValue.length - 1);
        if ($("#billPart_hdnSpecimenValues").val() == '') {
            $("#billPart_hdnSpecimenValues").val(SpecValue);
        }
        else {
            document.getElementById('billPart_hdnSpecimenValues').value= SpecValue;

        }
       
    }
    return false;
}

function hasEmptyValues(ary) {
    var l = ary.length,
        i = 0;

    if (l == 0) {
        return false;
    }

    return true;
}

//check for empty
function GetSpecimenList() {
    var txt = $('[id$="billPart_hdnSpecimenValues"]').val();
    var arr = [];

    if (txt != '') {
        var TCode = Specarray[0].TestID;
        var row = txt.split('~');
        $.each(row, function(id, column) {
            var cols = column.split(',');
            var obj = {};
            if (cols != '') {
                if (cols[0]  != TCode) {
                    obj.TestID = cols[0];
                    obj.TestName = cols[1];
                    obj.TestType = cols[2];
                    obj.SpecialSampleID = cols[3];
                    obj.Specimen = cols[4];
                    obj.ContainerCount = cols[5];
                    obj.ClinicalNotes = cols[6];
                    obj.ClinicalDiagnosis = cols[7];
                    arr.push(obj);
                }
            }
        });

        $.each(Specarray, function(id, val) {
            arr.push(val);
        });

    }
    else {
        arr = Specarray;
    
    }
        return arr;
}
function SetSpecimenText() {

}
function DeleteHistoSpecimenDetails(ID) {
    var SpecValue = "";
    var txt = $('[id$="billPart_hdnSpecimenValues"]').val();
    if (txt != '') {
        var row = txt.split('~');
        $.each(row, function(id, column) {
            var cols = column.split(',');
           
            if (cols != '') {
                if (cols[0] != ID) {
                    SpecValue += cols[0] + ',' + cols[1] + ',' + cols[2] + ',' + cols[3] + ',' + cols[4] + ',' + cols[5] + ',' + cols[6] + ',' + cols[7] + '~';
                }
            }
        });
        SpecValue = SpecValue.substring(0, SpecValue.length - 1);
        if ($("#billPart_hdnSpecimenValues").val() == '') {
            $("#billPart_hdnSpecimenValues").val(SpecValue);
        }
        else {
            document.getElementById('billPart_hdnSpecimenValues').value = SpecValue;

        }
    }
    btnspecsaveclear();
   
}

function SelectedHistopathTest(ID) {
    var Speccount = 0;
    var SpecialSampleID;
    var SpecimenName;
    var SampleCount;
    var TestID = ID;
    var TestName;
    var TestType;
    var ClinicalNotes ;
    var ClinicalDiag;
    var temp = $('[id$="hdnSpecimenValues"]').val();
    var temp1 = temp.split('~');
    btnspecsaveclear();
    if (temp != '') {
        for (i = 0; i < temp1.length; i++) {
            if (temp1[i].split(',')[0] == ID) {
                if (temp1[i] != '') {
                    TestID = temp1[i].split(',')[0];
                    TestName = temp1[i].split(',')[1];
                    TestType = temp1[i].split(',')[2];
                    SpecialSampleID = temp1[i].split(',')[3];
                    SpecimenName = temp1[i].split(',')[4];
                    SampleCount = temp1[i].split(',')[5];
                    ClinicalNotes = temp1[i].split(',')[6];
                    ClinicalDiag = temp1[i].split(',')[7];
                    AddSelectedSpecimenDetails(TestID, TestName, TestType, SpecialSampleID, SpecimenName, SampleCount, ClinicalNotes, ClinicalDiag);
                   // return false;
                }
            }            
        }
       
    }

}
function CheckExBarcode() {
    
    if (document.getElementById('billPart_chkAddExtraTest').checked == true)
    {
   
                          var samplecollecteddate = document.getElementById('hdnExBarcodeExpiry').value ;
                            var today = new Date();
                            var dd = today.getDate();
                            var mm = today.getMonth() + 1;
                            var yyyy = today.getFullYear();
                            if (dd < 10) {
                                dd = '0' + dd;
                            }
                            if (mm < 10) {
                                mm = '0' + mm;
                            }
                            var today1 = dd + '/' + mm + '/' + yyyy;
                            var todayDate = new Date(); //Today Date
                                            var dateOne = new Date(samplecollecteddate);
                                            todayDate.setHours(0, 0, 0, 0)
                                            dateOne.setHours(0, 0, 0, 0) 
                                            if (dateOne >= todayDate) {
                                                document.getElementById('hdnIsExbarcode').value = 'Y';  
                                                
                                            }
                                            else {
                                                $("input#billPart_chkAddExtraTest").attr('checked', false);
                                                alert("Sample is Expired Please collecte New Sample");
                                                document.getElementById('hdnIsExbarcode').value = 'N';
                                            }

                                        }
                                            
}

function AddSelectedSpecimenDetails(TestID, TestName, TestType, SpecialSampleID, SpecimenName, SampleCount, ClinicalNotes, ClinicalDiag) {
    $('#divspectab').show();
    var Speccount = 0;
    var SpecisExists = 0;
    var SpecialSampleID;
    var SpecimenName;
    var SampleCount;
   
    var TTable = null;

//    $.each(arr, function(id, val) {

//        if (SpecisExists == 0 && SpecialSampleID == val.SpecialSampleID) {
//            SpecisExists = 1;
//        }
//        Speccount = parseInt(Speccount) + parseInt(val.SampleCount);

//    });        

        arr.push(
        {
            TestID: TestID,
            TestName: TestName,
            TestType: TestType,
            SpecialSampleID: SpecialSampleID,
            SpecimenName: SpecimenName,
            SampleCount: SampleCount
        });

            Speccount = parseInt(Speccount) + parseInt(SampleCount);

            $('#billPart_lblTCCount').html(Speccount);
            $('#txtClinicalNotes').val(ClinicalNotes);
           $('#txtClinicalDiag').val(ClinicalDiag);
   

    $('#TblSpecimen').show();


    TTable = $('#TblSpecimen').dataTable({
        paging: false,
        "searching": false,
        "Info": false,
        "paging": false,
        "ordering": false,
        "info": false,
        data: arr,
        "bDestroy": true,
        "fnDrawCallback": function() {
            $('.deleteIcons').click(function() {
                var id = $(this).attr('SpecialSampleID');
                var row = $(this).closest("tr").get(0);
                TTable.fnDeleteRow(TTable.fnGetPosition(row));
                arr = $.grep(arr, function(ind, val) {
                    return ind.SpecialSampleID != id;

                });
                Speccount = 0;
                $.each(arr, function(id, val) {

                    Speccount = parseInt(Speccount) + parseInt(val.SampleCount);

                });
                $('#billPart_lblTCCount').html(Speccount);
            })

            $('.EditIcons').click(function() {
                $('#billPart_btnspecAdd').attr('value', 'Update');
                $("#billPart_hdnspecimenid").val($(this).attr('SpecialSampleID'));
                $("#billPart_hdnspecimenname").val($(this).attr('SpecimenName'));
                $('#txtContainercount').val($(this).attr('SampleCount'));
                $('#txtSpecimen').val($(this).attr('SpecimenName'));
                var id = $(this).attr('SpecialSampleID');
                var row = $(this).closest("tr").get(0);
                TTable.fnDeleteRow(TTable.fnGetPosition(row));
                arr = $.grep(arr, function(ind, val) {
                    return ind.SpecialSampleID != id;

                });
            })
        },
        columns: [
        { 'data': 'TestID',
            "sClass": "hide_Column"

        },
          { 'data': 'TestName', "sClass": "alignCenter" },
           { 'data': 'TestType',
               "sClass": "hide_Column"

           },

                                            { 'data': 'SpecialSampleID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'SpecimenName', "sClass": "alignCenter" },
                                             { 'data': 'SampleCount', "sClass": "alignCenter" },

                                            {

                                                "mRender": function(data, type, full, meta) {

                                                    var txt = '<input TestID="' + full.TestID + '" TestName="' + full.TestName + '" TestType="' + full.TestType + '" SampleCount="' + full.SampleCount + '" SpecimenName="' + full.SpecimenName + '" SpecialSampleID="' + full.SpecialSampleID + '" type="button" class="EditIcons alignCenter" value ="Edit" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >';
                                                    txt = txt + '<label size="5"> / </label>';
                                                    txt = txt + '<input TestID="' + full.TestID + '" SpecialSampleID= "' + full.SpecialSampleID + '" type="button" class="deleteIcons alignCenter" value ="Delete" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer" >';
                                                    return txt;
                                                }

}]
    });


    $('#billPart_hdnspecimenid').val('');
    $('#billPart_hdnspecimenname').val('');
    $('#txtContainercount').val('');
    $('#txtSpecimen').val('');
    $('#billPart_btnspecAdd').attr('value', 'Add');
}
function GetTestHistoryforPatient() {

    document.getElementById('billPart_BillingPanel1').style.display = 'none';
    document.getElementById('billPart_divOrder').style.display = 'none';
    
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetPreviousVisitBilling",
            data: "{ 'PatientID': '" + parseInt(document.getElementById('hdnPatientID').value) + "','VisitID': '" + parseInt(document.getElementById('hdnVisitID').value) + "','Type': ''}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var ArrayItems = data.d;
                var Items = ArrayItems[0];
                $.each(Items, function(index, Item) {
                     Item.FeeDescription + '$'
                    + Item.FeeId + '$'
                    + Item.FeeType + '$'
                    + Item.Address + '$'
                    + Item.PatientHistory + '$'
                    + Item.Status + '$'
                    + Item.IsOutSource + '$'
                    + Item.ServiceCode + '$'
                    + Item.IsAVisitPurpose + '$'
                    + Item.VisitID + '$'
                    + Item.LabNo + '^';
                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
                });

                LoadTestItems(Items);
                //alert(Items);
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }
    function LoadTestItems(Items) {

        var newPaymentTables, startPaymentTag, endPaymentTag;

        var i, Sno;
        startPaymentTag = "<TABLE nowrap='nowrap' ID='tbltestclinical' class='dataheaderInvCtrl w-40p bg-row b-grey' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> FeeID </th><th scope='col'  style='width:5%;display:none;'> FeeType </th> "
             + "<th scope='col' style='width:5%;'> S.No </th> <th scope='col' style='width:6%;'> Code </th> <th scope='col' align='left' style='width:35%;padding-left:2px;'> Description </th>  <th scope='col' > History </th>  </tr>";
        endPaymentTag = "</TBODY></TABLE>";
        newPaymentTables = startPaymentTag;
 for (i = 0; i < Items.length; i++) {
     Sno = i+1;
            
            newPaymentTables += "<tr>"
            newPaymentTables += "<td style='width:5%;display:none;'>" + Items[i].FeeId + "</td>";
            newPaymentTables += "<td style='width:5%;display:none;'>" + Items[i].FeeType + "</td>";
            newPaymentTables += "<TD align='Center'>" + Sno + "</TD>";
            newPaymentTables += "<TD align='Center'>" + Items[i].ServiceCode + "</TD>";

           

            if (Items[i].FeeType == 'GRP') {
                newPaymentTables += "<td><input value ='" + Items[i].FeeDescription + "'  name='" + Items[i].FeeId + "," + Items[i].FeeType + "," + Items[i].FeeDescription + "' onclick='GetGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></td>"
            }
            else if (Items[i].FeeType == 'PKG') {
            newPaymentTables += "<td><input value ='" + Items[i].FeeDescription + "'  name='" + Items[i].FeeId + "," + Items[i].FeeType + "," + Items[i].FeeDescription + "' onclick='GetGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#6699FF;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></td>"
            }
            else if (Items[i].FeeType != "INV") {
            newPaymentTables += "<td><input value ='" + Items[i].FeeDescription + "'  name='" + Items[i].FeeId + "," + Items[i].FeeType + "," + Items[i].FeeDescription + "' onclick='GetGroupName(name);'type='button' style='width:250px;word-wrap: break-word;background-color:Transparent;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></td>"
            }
            else {
                // newPaymentTables += "<TD  style='align:left;'>" + Descrip + "</TD>"
                newPaymentTables += "<td><input value ='" + Items[i].FeeDescription + "' type='button' style='width:250px;word-wrap: break-word;background-color:Transparent;font-size:10px;border-style:none;text-align:left;' /></TD>"
                //                newPaymentTables += "<TD style='padding-left:5px;'>" + Descrip + "</TD>"
            }
             newPaymentTables += " <td align='center'><input name='FeeID^" + Items[i].FeeId + "~FeeType^" + Items[i].FeeType + "~Descrip^" + Items[i].FeeDescription + "' onclick='CaptureHistoryfortestEdit(name);' value = 'History'  type='button' class='historyIcons'  style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'   /></td>";
            newPaymentTables += "</tr>";
            
          

            

        }
        newPaymentTables += endPaymentTag;
        $('#Billingforclinichistory').html('');
        $('#Billingforclinichistory').append(newPaymentTables);
        return false;

    }


    function BindInstructionMApping(FeeID, FeeType) {
        var vid = 0;
        var OrgID = 0;
        var Trinstruction = "";
        var tablehead1 = "";
        var tableEnd = "";
	var vType = SListForAppDisplay.Get("Billing_CommonBilling_js_73") == null ? "Type" : SListForAppDisplay.Get("Billing_CommonBilling_js_73");
        var vInvName = SListForAppDisplay.Get("Billing_CommonBilling_js_74") == null ? "Investigation Name" : SListForAppDisplay.Get("Billing_CommonBilling_js_74");
        var vDescription = SListForAppDisplay.Get("Billing_CommonBilling_js_75") == null ? "Description" : SListForAppDisplay.Get("Billing_CommonBilling_js_75");
        tablehead1 = "<table id='tblTestInstruction' class='searchPanel' cellpadding='3'><tr class='Duecolor h-17'><td class='w-20p'><span>"+vType+"</span></td><td class='w-20p'><span>"+vInvName+"</span></td><td><span>"+vDescription+"</span></td></tr>";

     if (FeeID != 0 || FeeType != "") {
         $.ajax({
             type: "POST",
             url: "../WebService.asmx/GetInvestigationInstruction",
             data: "{ 'PatientVisitID': " + vid + ",'OrgID':" + OrgID + ",'FeeID':" + FeeID + ",'FeeType':'" + FeeType + "' }",
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             async: false,
             success: function(data) {
                 Result = JSON.parse(data.d);
                 if (Result.length > 0) {
                     for (i = 0; i < Result.length; i++) {
                         tablehead1 += "<tr><td>" + Result[i].Performertype + "</td><td>" + Result[i].InvestigationName + "</td><td>" + Result[i].InvestigationComment + "</td></tr>";

                     }


                 }

             }
         });
         tablehead1 += "</table>";


     }
     $('#dialog1').append(tablehead1);
    }


    // VEL | Rolling Amount | 10-01-2020 | Start | //
    function Rollingadamoutcalculation(splitrolladvancevalue) {
        ClearClientAttr();
        var ClientCorpID;
        var ClientCorpName;
        var ClientCorpCode;
        var ClientCorpRateID;
        var ClientCorpClientID;
        var ClientCorpMappingID;
        var Ismappeditem = "N";
        var IsDiscount = "N";
        var ClientType;
        var ReferingID;
        var slist = splitrolladvancevalue.split('###');
        var flist;
        var temp = 0;
        var ClientStatus = '';
        var BoolValue = true;
        var IsCashClient = "N";
        var PRateType;
        var CoPayment;
        var Hashealthcoupon = '';

        var CollectionID = 0;
        var TotalDepositAmount = 0;
        var TotalDepositUsed = 0;
        var AmtRefund = 0;
        var ThresholdType = "";
        var ThresholdValue = 0;
        var ThresholdValue2 = 0;
        var ThresholdValue3 = 0;
        var VirtualCreditType = "";
        var VirtualCreditValue = 0;
        var MinimumAdvanceAmt = 0;
        var MaximumAdvanceAmt = 0;
        var hdnAdvanceClient = 0;
        var hdnCreditClient = 0;
        var PendingCreditLimit = 0;
        var NotInvoicedAmt = 0;
        var IsEnableAttributes = "N";
        var CreditExpiresday = 0;
        var IsBlockReg = "N";

        if (slist.length > 0) {
            for (j = 0; j < slist.length - 1; j++) {
                flist = slist[j].split('^');
                var rat = flist[4].split('~');
                if (j == 0) {
                    ClientStatus = flist[13].trim();
                    if (ClientStatus == 'S' || ClientStatus == 'T') {
                        BoolValue = CheckClientStatus(ClientStatus, flist[15], flist[16]);
                        //return BoolValue;
                        if (BoolValue == true) {
                        }
                        else {
                            return BoolValue;
                        }

                    }
                    ClientCorpID = flist[0];
                    ClientCorpName = flist[2];
                    ClientCorpCode = flist[3];
                    ClientCorpRateID = rat[0];
                    ClientCorpClientID = flist[5];
                    ClientCorpMappingID = flist[6];
                    temp = flist[8];
                    Ismappeditem = flist[9];
                    IsDiscount = flist[10];
                    ClientType = flist[7];
                    ReferingID = flist[12];
                    IsCashClient = flist[17];
                    PRateType = flist[20];
                    CoPayment = flist[22];
                    Hashealthcoupon = flist[23];
                    CollectionID = flist[24];
                    TotalDepositAmount = flist[25];
                    TotalDepositUsed = flist[26];
                    AmtRefund = flist[27];
                    ThresholdType = flist[28];
                    ThresholdValue = flist[29];
                    ThresholdValue2 = flist[30];
                    ThresholdValue3 = flist[31];
                    VirtualCreditType = flist[32];
                    VirtualCreditValue = flist[33];
                    MinimumAdvanceAmt = flist[34];
                    MaximumAdvanceAmt = flist[35];
                    hdnAdvanceClient = flist[36];
                    IsEnableAttributes = flist[41];
                    hdnCreditClient = flist[42];
                    PendingCreditLimit = flist[43];
                    NotInvoicedAmt = flist[44];
                    CreditExpiresday = flist[45];
                    IsBlockReg = flist[46];
                }
                if (temp > flist[8]) {
                    ClientStatus = flist[13].trim();
                    if (ClientStatus == 'S' || ClientStatus == 'T') {
                        BoolValue = CheckClientStatus(ClientStatus, flist[15], flist[16]);
                        //return BoolValue;
                        if (BoolValue == true) {
                        }
                        else {
                            return BoolValue;
                        }
                    }
                    ClientCorpID = flist[0];
                    ClientCorpName = flist[2];
                    ClientCorpCode = flist[3];
                    ClientCorpRateID = rat[0];
                    ClientCorpClientID = flist[5];
                    ClientCorpMappingID = flist[6];
                    temp = flist[8];
                    Ismappeditem = flist[9];
                    IsDiscount = flist[10];
                    ClientType = flist[7];
                    ReferingID = flist[12];
                    IsCashClient = flist[17];
                }
            }
        }
        /*credit limit */
        if (hdnCreditClient > 0) {
            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");

            document.getElementById('trCreditLimit').style.display = "block";
            var deduction = parseInt(PendingCreditLimit);

            $('#billPart_lblCreditLimitAmt').html(deduction);
            document.getElementById('hdnCreditLimit').value = hdnCreditClient;
            document.getElementById('hdnTotalCreditLimit').value = PendingCreditLimit;
            document.getElementById('hdnTotalCreditUsed').value = NotInvoicedAmt;
            document.getElementById('hdnCreditExpires').value = CreditExpiresday;
            document.getElementById('hdnIsBlockReg').value = IsBlockReg;


            /*AB Code*/
            var objClientZero = SListForAppMsg.Get("Scripts_CommonBiling_js_58") == null ? "Client deposit balance amount is Zero" : SListForAppMsg.Get("Scripts_CommonBiling_js_58");

            var amount = $('#billPart_lblCreditLimitAmt').text();

            if (amount <= 0) {
                //alert('Client deposit balance amount is Zero');
                ValidationWindow(objClientZero, objAlert);
                document.getElementById('txtClient').value = '';
                document.getElementById('txtClient').focus();
                document.getElementById('trCreditLimit').style.display = "none";
                return false;
            }

        }
        else {
            document.getElementById('trCreditLimit').style.display = "none";
            document.getElementById('hdnCreditLimit').value = 0;
            document.getElementById('hdnTotalCreditLimit').value = 0;
            document.getElementById('hdnTotalCreditUsed').value = 0;
            document.getElementById('hdnCreditExpires').value = 0;
        }
        /*end*/



        if (hdnAdvanceClient == "1") {
            objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");

            document.getElementById('trRollingAdvance').style.display = "block";
            var deduction = parseInt(TotalDepositUsed) + parseInt(AmtRefund);

            $('#billPart_lblRollingBalAmt').html(TotalDepositAmount - deduction);

            /*AB Code*/
            var objClientZero = SListForAppMsg.Get("Scripts_CommonBiling_js_05") == null ? "Client deposit balance amount is Zero" : SListForAppMsg.Get("Scripts_CommonBiling_js_05");

            var amount = $('#billPart_lblRollingBalAmt').text();

            if (amount <= 0) {
                //alert('Client deposit balance amount is Zero');
                ValidationWindow(objClientZero, objAlert);
                document.getElementById('txtClient').value = '';
                document.getElementById('txtClient').focus();
                document.getElementById('trRollingAdvance').style.display = "none";
                return false;
            }

        }
        else {
            document.getElementById('trRollingAdvance').style.display = "none";
        }
        counti = 0;
        if (IsEnableAttributes == "Y") {
            document.getElementById('billPart_tdClientAttributes').style.display = "block";
        }
        else {
            document.getElementById('billPart_tdClientAttributes').style.display = "none";
        }
        //Co payment//
        if (document.getElementById('HdnCoPay') != null) {
            document.getElementById('HdnCoPay').value = CoPayment;
            DisplayCoPayMent();
        }
        //end  co payment//
        document.getElementById('billPart_hdnHasClientHealthcoupon').value = Hashealthcoupon;
        document.getElementById('hdnIsMappedItem').value = Ismappeditem;
        document.getElementById('billPart_hdnIsDiscount').value = IsDiscount;
        document.getElementById('hdnSelectedClientID').value = ClientCorpID;
        document.getElementById('hdnSelectedClientName').value = ClientCorpName;
        document.getElementById('hdnSelectedClientCode').value = ClientCorpCode;
        document.getElementById('hdnSelectedClientRateID').value = ClientCorpRateID;
        document.getElementById('hdnSelectedClientClientID').value = ClientCorpClientID;
        //Searching patient name with clientID
        document.getElementById('hdnSerachPatientwithClientID').value = ClientCorpClientID;
        //if (document.getElementById('hdnSampleforPrevious').value != '') {
        //  document.getElementById('hdnValidateclient').value = ClientCorpClientID;
        //}



        $('[id$="hdnAdvanceClient"]').val(hdnAdvanceClient);
        document.getElementById('hdnSelectedClientMappingID').value = ClientCorpMappingID;
        document.getElementById('hdnIsCashClient').value = IsCashClient;
        document.getElementById('billPart_hdnIsCashClient').value = IsCashClient.trim();
        document.getElementById('billPart_hdnClientType').value = ClientType.trim();
        //    if (IsCashClient.trim() == "N") {
        //        if (document.getElementById("billPart_dvHealhcard") != null) {
        //            document.getElementById("billPart_dvHealhcard").style.display = "none";
        //            document.getElementById("billPart_chkMycard").checked = false;
        //        }
        document.getElementById('hdnCollectionID').value = CollectionID;
        document.getElementById('hdnTotalDepositAmount').value = TotalDepositAmount;
        document.getElementById('hdnTotalDepositUsed').value = TotalDepositUsed;
        if (document.getElementById('hdnAmtRefund') != null) {
            document.getElementById('hdnAmtRefund').value = AmtRefund;
        }
        document.getElementById('hdnThresholdType').value = ThresholdType;

        document.getElementById('hdnThresholdValue').value = ThresholdValue;
        document.getElementById('hdnThresholdValue2').value = ThresholdValue2;
        document.getElementById('hdnThresholdValue3').value = ThresholdValue3;
        document.getElementById('hdnVirtualCreditType').value = VirtualCreditType;
        document.getElementById('hdnVirtualCreditValue').value = VirtualCreditValue;
        document.getElementById('hdnMinimumAdvanceAmt').value = MinimumAdvanceAmt;
        document.getElementById('hdnMaximumAdvanceAmt').value = MaximumAdvanceAmt;
        //    }
        //    else {
        if ($("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y" && IsCashClient.trim() == "Y" && Hashealthcoupon == "Y") {
            document.getElementById("billPart_dvHealhcard").style.display = "block";

            CheckMyCard();
        }
        else {
            document.getElementById("billPart_dvHealhcard").style.display = "none";

            CheckMyCard();
        }
        //   }
        document.getElementById('txtClient').value = ClientCorpName;

        // ValidateCreditLimit(ClientCorpClientID);
        SetRateCard();
        document.getElementById('lblClientDetails').innerHTML = "";
        document.getElementById('divShowClientDetails').style.display = "none";

        if (ClientType.trim() == 'RPH') {
            document.getElementById('txtInternalExternalPhysician').value = ClientCorpName;
            document.getElementById('hdnReferedPhyID').value = ReferingID;
        }
        if (ClientType.trim() == 'HOS') {
            document.getElementById('txtReferringHospital').value = ClientCorpName;
            document.getElementById('hdfReferalHospitalID').value = ReferingID;
        }
        if (document.getElementById('billPart_hdnCpedit').value == "Y") {
            AddBillingItemsDetailsForEdit(ClientCorpClientID);
        }
    }
    // VEL | Rolling Amount | 10-01-2020 | END  | //