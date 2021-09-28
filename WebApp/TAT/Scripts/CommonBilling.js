/*BEGIN | 2851 | Nicholos/ Prabakaran | 20160606| A | Multi Browser Compatability )
Page modified for multibrowser compatability like ie,chrome and firefox. Here we have modified the styles,width and some functionalites for support 
all browsers.
END | 2851 | Nicholos/Prabakaran | 20160606 */

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
    document.getElementById('billPart_hdnTATProcessDateTime').value = '';
    ToTargetFormat($("#billPart_hdnTATProcessDateTime"));
    document.getElementById('billPart_hdnTATSampleReceiptDateTime').value = '';
    ToTargetFormat($("#billPart_hdnTATSampleReceiptDateTime"));
    document.getElementById('billPart_hdnTATProcessStartDateTime').value = '';
    ToTargetFormat($("#billPart_hdnTATProcessStartDateTime"));
    document.getElementById('billPart_hdnTATLogisticTimeasmins').value = '';
    ToTargetFormat($("#billPart_hdnTATLogisticTimeasmins"));
    document.getElementById('billPart_hdnTATProcessinghoursasmins').value = '';
    ToTargetFormat($("#billPart_hdnTATProcessinghoursasmins"));
    document.getElementById('billPart_hdnTATLabendTime').value = '';
    ToTargetFormat($("#billPart_hdnTATLabendTime"));
    document.getElementById('billPart_hdnTATEarlyReportTime').value = '';
    ToTargetFormat($("#billPart_hdnTATEarlyReportTime"));
    document.getElementById('billPart_hdnTatreferencedatebase').value = '';
    ToTargetFormat($("#billPart_hdnTatreferencedatebase"));

    if (document.getElementById('billPart_ddlTaxPercent').length > 1) {
        document.getElementById("billPart_ddlTaxPercent").selectedIndex = "1";
    }
    else {
        document.getElementById('billPart_ddlTaxPercent').value = '0';
    }
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

    $("#billPart_hdnHasClientHealthcoupon").val("Y");

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
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency   
    //Multi Currency concept
    var alertnotCurrencyselect = true;
    alertnotCurrencyselect = GetCurrencyValues();
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
    document.getElementById('billPart_divItemTable').innerHTML = "";
    defaultbillflag = 0;
    if ($("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y" && $('#billPart_hdnOrgHealthCoupon').val() == "Y" && $("#billPart_hdnHasClientHealthcoupon").val() == "Y") {
        document.getElementById("billPart_dvHealhcard").style.display = "block";
        CheckMyCard();
    }
    else {
        document.getElementById("billPart_dvHealhcard").style.display = "none";
        CheckMyCard();
    }

}

function clearbuttonClick() {
    if (window.confirm("Are you sure you want to clear?")) {
        clearPageControlsValue('N');
        clearControls();
        return true;
    }
    else {
        return false;
    }
}
function clearpatientbuttonClick() {
    if (window.confirm("Are you sure you want to clear?")) {

        clearpatientmgntControls();
        return true;
    }
    else {
        return false;
    }
}


function clearClientbuttonClick() {
    if (window.confirm("Are you sure you want to clear?")) {
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
    document.getElementById('tDOB').value = "dd//MM//yyyy";
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
    document.getElementById('ComplaintICDCodeBP1_hdnDiagnosisItems').value = "";
    if (document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText != "") {
        document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
    }
    /* BEGIN | NA | Sabari | 20171006 | Created | PID WORKFLOW Add  */
    //SABARI ADDED FOR MANAGE PATIENT
    document.getElementById('btnSaveEMR').value = 'Save';
    /* END | NA | Sabari | 20171006 | Created | PID WORKFLOW END  */
    /* BEGIN | NA | Vijay | 20171130 | Created | VIP Workflow  */
    document.getElementById('ddlPatientStatus').value = document.getElementById('hdnDefaultPatientStatus').value;
    /* END | NA | Vijay | 20171130 | Created | VIP Workflow  */
}







function SetDiscountAmt() {
    var DiscountType = "";
    var pDiscountPercent = document.getElementById('billPart_ddDiscountPercent');
    if (pDiscountPercent.selectedIndex == 0 && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnOrgHealthCoupon").val() == "Y" && $("#billPart_hdnHasMyCard").val() == "Y" && $("#billPart_hdnIsCashClient").val() == "Y") {
        $("#billPart_trHealthCard").css({ display: "table-row" });
        $("#billPart_trDisAmount").css({ display: "none" });
        $('#billPart_dvHealhcard').show();
    }
    else {
        $("#billPart_trHealthCard").css({ display: "none" });
        $("#billPart_trDisAmount").css({ display: "table-row" });
        $('#billPart_dvHealhcard').hide();
    }
    var DiscountPercent = pDiscountPercent.options[pDiscountPercent.selectedIndex].value;
    var DiscountPercentName = pDiscountPercent.options[pDiscountPercent.selectedIndex].Text;
    var SDiscountId = DiscountPercent.split('~');
    var DiscountId = SDiscountId[1];
    if (SDiscountId[3] != "") {
        DiscountType = SDiscountId[3];
    }
    /* BEGIN | 112  | Thiyagu | 20160703 | A | For DiscountAuthorizerMaster done by Balaji S*/
    if (SDiscountId[5] != "") {
        if (SDiscountId[5] == "1") {
            document.getElementById('billPart_isAuthMandatory').value = true;
            $('#billPart_lblAuthMandatory').html('*');
        }
    }
    /*END | 112 | Thiyagu |20160703 */
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
            /*BEGIN | 73 | Thiyagu | 20160503 | A | uncheck the Foc Checkbox when the discounttype changed from percentage to foc */
            document.getElementById("billPart_chkFoc").checked = false;
             /*End | 73 | Thiyagu | 20160503 */
            optn.text = "--Select--";
            optn.value = "0";

        } else {
            if (DiscountId != '' && DiscountId > 0) {
                /*BEGIN | 73 | Thiyagu | 20160503 | M | The value come from db is either Foc or FOC */
                if (DiscountType == "Foc" || DiscountType == "FOC") {
                    /*End | 73 | Thiyagu | 20160503 */
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
    var s = document.getElementById(id).value;
    var str = s.substring(0, 250);
    if (s.length >= 250) {
        alert("More than 250 characters are not allowed");
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
                result = (Math.ceil(Number(netRound) / Number(10.00))) * (Number(10.00));
            }
            else {
                result = (Math.floor(Number(netRound) / Number(10.00))) * (Number(10.00));
            }
        }
        else if (RoundType.toLowerCase() == "none") {
            result = format_number_withSignNone(netRound, 2);
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

                $('#ddState').attr("disabled", false);
                $('#ddState').append('<option value="-1">--Select--</option>');
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
    var k;
    document.all ? k = e.keyCode : k = e.which;
    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
}
//function alphaSpl(e) {
//    /** Including ", /" **/
//    var k;
//    document.all ? k = e.keyCode : k = e.which;
//    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57) || k == 44 || k == 47);
//}
function alphaSpl(e) {
    /** Including ", /" **/
    var k;
    document.all ? k = e.keyCode : k = e.which;
    k = e.keyCode || e.charCode;
    //  return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57) || k == 44 || k == 47);
    if (document.getElementById('hdnAllowSplChar') != null) {
        if (document.getElementById('hdnAllowSplChar').value == 'N') {
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 9 || k == 32 || k == 37 || k == 39 || k == 46 || k == 44 || k == 40 || k == 64 || k == 41 || k == 47 || (k >= 48 && k <= 57) || k == 45  );
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
    document.getElementById('billPart_txtDiscount').disabled = true;
    document.getElementById('billPart_txtAuthorised').disabled = true;
    document.getElementById('billPart_txtDiscountReason').readOnly = true;

    if (document.getElementById('billPart_hdnIsDiscount').value == "Y") {
        document.getElementById('billPart_txtDiscount').disabled = false;
        document.getElementById('billPart_txtAuthorised').disabled = false;
        document.getElementById('billPart_txtDiscountReason').readOnly = false;
    }
}

function CheckOrderedItems() {
    if (document.getElementById('billPart_hdnCpedit').value != "Y") {
        if (document.getElementById('billPart_hdfBillType1').value != '') {
            var pBill = confirm("Delete the Ordered Items then only you can Change.\n Do you want to delete the items, Press OK Else Cancel");
            if (pBill != true) {
                document.getElementById('billPart_txtTestName').focus();
                return false;
            }
            else {
                ClearmycardDetails('N');
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

                /* BEGIN |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */
                var clientAlert = document.getElementById('hdnB2CClientAlert').value == undefined ? "N" : "Y";
                if (clientAlert == 'Y') {
                    if (document.getElementById('hdnB2CClientAlert').value == "Y") {
                        document.getElementById('hdnBaseClientID').value = '';
                        document.getElementById('hdnSelectedClientClientID').value = '';
                    }
                }
                /* END |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */
            }
        }
        else {
            if ($("#txtClient").val() == "" && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y") {
                document.getElementById("billPart_dvHealhcard").style.display = "block";
                /* BEGIN |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */
                var clientAlert = document.getElementById('hdnB2CClientAlert').value == undefined ? "N" : "Y";
                if (clientAlert == 'Y') {
                    if (document.getElementById('hdnB2CClientAlert').value == "Y") {
                        document.getElementById('hdnBaseClientID').value = '';
                        document.getElementById('hdnSelectedClientClientID').value = '';
                    }
                }
                /* END |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */
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
                alert(msg);
            }
        });
    }
    $('[id$="DivRefDrDetails"]').hide();
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
    var VirtualCreditType = "";
    var VirtualCreditValue = 0;
    var MinimumAdvanceAmt = 0;
    var MaximumAdvanceAmt = 0;
    var hdnAdvanceClient = 0;
    var SAPLogicFlag = "";
    var SAPLogic = 0
    var ClientTaskStatus = "";
    var flag = 0;
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    var ItemCurrencyID = "";
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
    if (slist.length > 0) {
        for (j = 0; j < slist.length - 1; j++) {
            flist = slist[j].split('^');
            var rat = flist[4].split('~');
            if (j == 0) {
                ClientTaskStatus = flist[40];
                if (ClientTaskStatus == 'N') {
                   
                    document.getElementById('txtClient').value = '';
                    document.getElementById('txtClient').focus();
                    alert("This Client is Ammended, Please contact Admin");
                    flag = 1;
                }
                var ClientID = flist[5];
                var Amount = 0.00;
              
                //Begin |shabiya|SAP
                if (ClientID != "0") {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/GetClientCreditValue",
                        data: "{ 'ClientID': '" + ClientID + "','Amount': '" + Amount + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            // debugger;

                            var Items = [];
                            Items = data.d;
                            if (Items != '') {
                                var Status = Items[0].Status;
                                var SAPLogicFlag = Items[0].SAPLogicFlag;
                                var SAPLogic = Items[0].SAPLogic;
                                if (SAPLogicFlag == 'CreditLimitExist' && Status == 'A' && SAPLogic == 1) {
                                    document.getElementById('txtClient').value = '';
                                    document.getElementById('txtClient').focus();
                                    alert("This Client Regitration Stopped");

                                    flag = 1;
                                }
                                else if (SAPLogicFlag == 'CreditLimitExist' && Status == 'A' && SAPLogic == 3) {
                                    document.getElementById('txtClient').value = '';
                                    document.getElementById('txtClient').focus();
                                    alert("This Client Regitration Stopped and Report Regitration also Stopped");
                                    flag = 1;

                                }
                            }


                        },
                        failure: function (msg) {
                            ShowErrorMessage(msg);
                        }
                    });
                }
                //End |shabiya|SAP
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
                VirtualCreditType = flist[30];
                VirtualCreditValue = flist[31];
                MinimumAdvanceAmt = flist[32];
                MaximumAdvanceAmt = flist[33];
                hdnAdvanceClient = flist[34];
                //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
                ItemCurrencyID = flist[35];
                //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
                //	   BEGIN | 459 | thiyagu s | 20162206 | A | Multicurrency
                //document.getElementById('hdnIsRoundOffClient').value = flist[36];
                //document.getElementById('hdnRoundOffValue').value = flist[37];
                //	   END | 459 | thiyagu s  | 20162206 | A | Multicurrency
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
                //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
                ItemCurrencyID = flist[35];
                //	   END | 459 | Arun M | 20160806 | A | Multicurrency 
            }
        }
    }
    if (hdnAdvanceClient == "1") {
        document.getElementById('trRollingAdvance').style.display = "table-row";
        var deduction = parseInt(TotalDepositUsed) + parseInt(AmtRefund);

        $('#billPart_lblRollingBalAmt').html(TotalDepositAmount - deduction);

        /*AB Code*/

        var amount = $('#billPart_lblRollingBalAmt').text();

        if (amount <= 0) {
            alert('Client deposit balance amount is Zero');
            document.getElementById('txtClient').value = '';
            document.getElementById('txtClient').focus();
            document.getElementById('trRollingAdvance').style.display = "none";
            return false;
        }

    }
    else {
        document.getElementById('trRollingAdvance').style.display = "none";
    }
    
    
    //Co payment//
    if (document.getElementById('HdnCoPay') != null) {
        document.getElementById('HdnCoPay').value = CoPayment;
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
    //if (document.getElementById('hdnSampleforPrevious').value != '') {
    //  document.getElementById('hdnValidateclient').value = ClientCorpClientID;
    //}
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    //The below lines added for multi currency concept.
    var NeedCurrConv = document.getElementById('billPart_PaymentType_hdnNeedCurrConv').value;
    if ((IsCashClient.trim() == "N") || (NeedCurrConv == "N")) {
        document.getElementById("billPart_PaymentType_ddCurrency").disabled = true;
    }
    else {
        document.getElementById("billPart_PaymentType_ddCurrency").disabled = false;
    }
    document.getElementById('billPart_PaymentType_hdnSelectedClientCurrency').value = ItemCurrencyID;
    $('#billPart_PaymentType_ddCurrency').val(ItemCurrencyID);
    var ClientCurrencyID = document.getElementById('billPart_PaymentType_hdnSelectedClientCurrency').value.split('~')[0];
    if ((ClientCurrencyID != undefined) && (ClientCurrencyID != "0")) {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetCurrencyConvertedAmount",
            data: "{ 'baseCurrencyID': '" + ClientCurrencyID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                //debugger;
                var Items = [];
                Items = data.d;
                if (Items != undefined) {
                    _Validation = 1;

                    document.getElementById('billPart_PaymentType_hdnCurrencyExchangeValue').value = JSON.stringify(Items);

                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
    

    
    $('[id$="hdnAdvanceClient"]').val(hdnAdvanceClient);
    document.getElementById('hdnSelectedClientMappingID').value = ClientCorpMappingID;
    document.getElementById('hdnIsCashClient').value = IsCashClient;
    document.getElementById('billPart_hdnIsCashClient').value = IsCashClient.trim();
    document.getElementById('billPart_hdnClientType').value = ClientType.trim();
    if (IsCashClient == "Y" && $('#hdnDemographicPhleboIDB2B').val() == -1) {
        document.getElementById('hdnDemographicPhleboIDB2B').value = "";
        document.getElementById('trSampleTRFPart').style.display = "table-row";
        $("#txtSampleDate").attr("disabled", true);
        $("#txtLogistics").attr("disabled", true);
        $("#txtRoundNo").attr("disabled", true);
        document.getElementById('imgCalc').parentElement = "";
        //  document.getElementById('HdnPhleboID').value = "";
    }
    else if (document.getElementById('HdnPhleboID')!= null) {
        if (document.getElementById('HdnPhleboID').value == "-1") {
            document.getElementById('trSampleTRFPart').style.display = "none";
            $('#hdnDemographicPhleboIDB2B').val(document.getElementById('HdnPhleboID').value);
            $("#txtSampleDate").attr("enabled", true);
            $("#txtLogistics").attr("enabled", true);
            $("#txtRoundNo").attr("enabled", true);
        }
    }
    document.getElementById('billPart_hdnIsCashClient').value = IsCashClient.trim();
    document.getElementById('billPart_hdnClientType').value = ClientType.trim();


 
     var hdnClientValue = document.getElementById('hdnBillingPageType').value;
     if (hdnClientValue == "Client") {
         if (IsCashClient == "Y") {
             document.getElementById("billPart_" + "divPaymentType").style.display = "table-row";
             document.getElementById("billPart_" + "trAmountReceived").style.display = "table-row";
             document.getElementById("billPart_" + "tdPreviousDue").style.display = "table-cell";
         }
         else if (IsCashClient) {
             document.getElementById("billPart_" + "divPaymentType").style.display = "none";
             document.getElementById("billPart_" + "trAmountReceived").style.display = "none";
             document.getElementById("billPart_" + "tdPreviousDue").style.display = "none";
         }
     }
     
    document.getElementById('hdnCollectionID').value = CollectionID;
    document.getElementById('hdnTotalDepositAmount').value = TotalDepositAmount;
    document.getElementById('hdnTotalDepositUsed').value = TotalDepositUsed;
    if (document.getElementById('hdnAmtRefund') != null) {
        document.getElementById('hdnAmtRefund').value = AmtRefund;
    }
    document.getElementById('hdnThresholdType').value = ThresholdType;

    document.getElementById('hdnThresholdValue').value = ThresholdValue;
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
    if (flag == 1) {
        return false;
    }
     //   }
    document.getElementById('txtClient').value = ClientCorpName;
    // MultiCurrency Start
    var showalert = slist[1];
    if (showalert == "Y") {
        document.getElementById('txtClient').value = '';
        document.getElementById('txtClient').focus();
        alert("Please Contact Admin ratecard is not mapped for this Currency Type");

    }

    //Multicurrency End

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
    if (ClientStatus == 'S' || ClientStatus == 'T') {
        var displayTxt = '';
        if (ClientStatus == 'S') {
            displayTxt = 'This Client was suspended. Suspended from ' + BlockFrom + ' to ' + BlockTo;
            var IsContinue = confirm('This Client was suspended. Suspended from ' + BlockFrom + ' to ' + BlockTo);
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
            displayTxt = 'This Client was Terminated. Terminated from ' + BlockFrom + ' to ' + BlockTo;
            alert(displayTxt);
        }
        if (displayTxt != '') {

            document.getElementById('txtClient').value = '';
           // document.getElementById('txtClient').focus();
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
    if (StatusAndAmount != '') {
        var CreditStatus = StatusAndAmount.split('~')[0];
        var BalanceAmount = StatusAndAmount.split('~')[1];
        if (CreditStatus == 'Y') {
            alert('Warning: Credit Limit have exceeded for this Client..!')
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
    //alert(document.getElementById(id).value);
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
            document.getElementById('tDOB').value = "dd//MM//yyyy";
            document.getElementById('tDOB').value = "dd//MM//yyyy";
            document.getElementById('tDOB').focus();
        }
        /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
        $('#hdnIsDOBMandatoryDOBFlag').val("Y");
        $('#hdnIsDOBMandatoryAgeFlag').val("N");
        /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
    }
}

function getDOB() {
    if (document.getElementById('txtDOBNos').value.trim() == '') {
        alert('Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
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
        if (boxValue < minNum || boxValue != minNnum) {
        me.size = minNum
    }
    if (me.id = 'billPart_txtTestName') {
        document.getElementById('billPart_hdnID').value = 0;
        document.getElementById('billPart_hdnName').value = '';
    }
}
function AddBillingItemsDetails() {
    var FeeID1 = document.getElementById('billPart_hdnID').value;
    var FeeType1 = document.getElementById('billPart_hdnFeeTypeSelected').value;
    var arrGotValue = new Array();
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
        url: "../OPIPBilling.asmx/GetBillingItemsDetails",
        data: JSON.stringify({ OrgID: document.getElementById('billPart_hdnOrgIDC').value, FeeID: document.getElementById('billPart_hdnID').value, FeeType: document.getElementById('billPart_hdnFeeTypeSelected').value, Description: document.getElementById('billPart_txtTestName').value, ClientID: $('[id$="hdnSelectedClientClientID"]').val(), VisitID: 0, Remarks: '', IsCollected: document.getElementById('billPart_hdnIsCollected').value, CollectedDatetime: document.getElementById('billPart_hdnCollectedDateTime').value, locationName: document.getElementById('billPart_hdnLocName').value }),
        dataType: "json",
        success: function(data) {
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
                        Remarks = arrGotValue[5];
                        isReimursable = arrGotValue[6];
                        ReportDate = arrGotValue[7];
                        ActualAmount = arrGotValue[8];
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
                        TATProcessDateType = data.d[i].TATProcessDateType;

                        Tatreferencedatetime = data.d[i].Tatreferencedatetime;
                        Tatsamplereceiptdatetime = data.d[i].Tatsamplereceiptdatetime;
                        Tatprocessstartdatetime = data.d[i].Tatprocessstartdatetime;

                        Logistictimeinmins = data.d[i].Logistictimeinmins;
                        Processingtimeinmins = data.d[i].Processingtimeinmins;
                        Labendtime = data.d[i].Labendtime;
                        Earlyreporttime = data.d[i].Earlyreporttime;
                        Tatreferencedatebase = data.d[i].Tatreferencedatebase;

                        document.getElementById('hdnTatprocess').value = TATProcessDateType;
                        if (document.getElementById('hdnTatprocess').value == "3"&& (document.getElementById('billPart_hdnCollectedDateTime').value == "01/01/1900" || document.getElementById('billPart_hdnCollectedDateTime').value == "01-01-1900 07:00AM")) {
                            alert("Kindly Select Sample Pickup Date");
                            return false;
                        }
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
                        document.getElementById('billPart_hdnTATProcessDateTime').value = Tatreferencedatetime;
                        document.getElementById('billPart_hdnTATSampleReceiptDateTime').value = Tatsamplereceiptdatetime;
                        document.getElementById('billPart_hdnTATProcessStartDateTime').value = Tatprocessstartdatetime;
                        document.getElementById('billPart_hdnTATLogisticTimeasmins').value = Logistictimeinmins;
                        document.getElementById('billPart_hdnTATProcessinghoursasmins').value = Processingtimeinmins;
                        document.getElementById('billPart_hdnTATLabendTime').value = Labendtime;
                        document.getElementById('billPart_hdnTATEarlyReportTime').value = Earlyreporttime;
                        document.getElementById('billPart_hdnTatreferencedatebase').value = Tatreferencedatebase;
                        //document.getElementById('billPart_btnAdd').disabled = false;
                        var FeeID = document.getElementById('billPart_hdnID').value;
                        var FeeType = document.getElementById('billPart_hdnFeeTypeSelected').value;

                        DuplicateInv(FeeID, FeeType);
                    }
                }
            }
            else {
                DuplicateInv(FeeID, FeeType);
                //alert('Item Amount is Zero, you cannot add this item for billing');
                document.getElementById('billPart_txtTestName').value = '';
                document.getElementById('billPart_txtTestName').focus();
            }
        },
        error: function(result) {
            alert("Select the ClientName From List");
        }
    });
}
function CallBillItems(OrgID) {
    if (document.getElementById('hdnDoFrmVisit').value != '') {
        if (document.getElementById('hdnDOFromVisitFlag').value == "0") {
            validateForClient();
            AdditionalDetails();
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

        document.getElementById('billPart_hdnTATProcessDateTime').value = '';
        document.getElementById('billPart_hdnTATSampleReceiptDateTime').value = '';
        document.getElementById('billPart_hdnTATProcessStartDateTime').value = '';
        document.getElementById('billPart_hdnTATLogisticTimeasmins').value = '';
        document.getElementById('billPart_hdnTATProcessinghoursasmins').value = '';
        document.getElementById('billPart_hdnTATLabendTime').value = '';
        document.getElementById('billPart_hdnTATEarlyReportTime').value = '';
        document.getElementById('billPart_hdnTatreferencedatebase').value = '';
    }
}

function BillingItemSelected(source, eventArgs) {
    //debugger;
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
    var FeeItemArray = new Array();
    var listLen = document.getElementById('hdnPreviousVisitDetails').value.split('^').length;
    var flag = 0;

    if (Number(listLen) > 0) {
        var ItemArray = new Array();
        var res = new Array();
        ItemArray = document.getElementById('hdnPreviousVisitDetails').value.split('^');
        for (i = 0; i < ItemArray.length; i++) {
            res = ItemArray[i].split('$');
            if (Number(document.getElementById('billPart_hdnID').value) == res[1] && 'Y' == res[5] && document.getElementById('billPart_hdnFeeTypeSelected').value == res[2]) {
                flag = 1;
                break;

            }


        }

    }
    if (document.getElementById('hdnDoFrmVisit').value > "0") {
        flag = 0;
  }
    if (flag == 1) {
        if (window.confirm('Warning: This test already ordered today...! Do you want to continue?')) {
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

            //window.confirm('Patient with Same Name and Age are Already entered ?');
            if (!window.confirm('Patient with Same Name,age,Client with Same Tests are Already entered Do You Want to continue ?')) {
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
    // For Co-Payment //
    // debugger;
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
        var ddlCopaymentType = document.getElementById('uctlClientTpa_ddlCopaymentType').value;
        var txtCoperent = parseFloat(document.getElementById('uctlClientTpa_txtCoperent').value);
        //if (document.getElementById('HdnCoPay').value == 'Y') {
        if (ddlCopaymentType == 0) {
            alert('Select Co-Payment type');
            document.getElementById('uctlClientTpa_ddlCopaymentType').focus();
            return false;
        }
        if (txtCoperent < 0.00) {
            alert('Enter Co-Payment Value');
            document.getElementById('uctlClientTpa_txtCoperent').focus();
            return false;
        }
        //}
    }
    // For Co-Payment  end//
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
    
    if (document.getElementById('txtPhleboName')!= null && document.getElementById('HdnPhleboID')!= null) {
        if ($('#txtPhleboName').val() != "" && document.getElementById('HdnPhleboID').value == "") {
            alert('Please select Phlebotomist Name from list');
            $('#txtPhleboName').val("");
            document.getElementById('txtPhleboName').focus();
            return false;
        }
    }
    if (document.getElementById('HdnPhleboID') != null && document.getElementById('hdnPageType') != null) {
        if (document.getElementById('HdnPhleboID').value == "" && $("#hdnPageType").val() == "B2C") {
            alert('Please select Phlebotomist Name');
            $('#txtPhleboName').val("");
            document.getElementById('txtPhleboName').focus();
            return false;
        } 
    }
    var mobileNo_val = document.getElementById('txtMobileNumber').value;
    var Mob_Length = mobileNo_val.length;
    if (mobileNo_val != '' && mobileNo_val.length < 7) {
        alert('Please Enter Valid Mobile Number.');
        document.getElementById('txtMobileNumber').focus();
        return false;
    }
    if (mobileNo_val != '') {
        var _Repeatingcount = fn_RepeatingSequence(mobileNo_val, Mob_Length);
        if (_Repeatingcount == 1) {
            alert('Please Enter Valid Mobile Number.');
            document.getElementById('txtMobileNumber').focus();
            return false;
        }
    }
    if (document.getElementById('hdnDoFrmVisit').value != "") {
        if (document.getElementById('hdnDOFromVisitFlag').value == "0") {
            if (document.getElementById('chkIncomplete').checked != true) {
                if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy')) {
                    alert('Provide patient age or date of birth');
                    document.getElementById('txtDOBNos').focus();
                    return false;
                }
                if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
                    if (document.getElementById('ddlSex').disabled != true) {
                        alert('Select patient sex');
                        document.getElementById('ddlSex').focus();
                        return false;
                    }
                }
            }
        }
    }
    else {
        if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy')) {
            alert('Provide patient age or date of birth');
            document.getElementById('txtDOBNos').focus();
            return false;
        }
        if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
            if (document.getElementById('ddlSex').disabled != true) {
                alert('Select patient sex');
                document.getElementById('ddlSex').focus();
                return false;
            }
        }
    }
    //if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '') {
    //  alert('Provide contact mobile or telephone number');
    // $('#txtMobileNumber').focus();
    // return false;
    // }

    if (document.getElementById('hdnDoFrmVisit').value == "") {
        if (document.getElementById('txtPhleboName') != null) {
            if (document.getElementById('txtPhleboName').value.trim() == "") {
                alert('Select Phlebetomist Name');
                document.getElementById('txtPhleboName').focus();
                return false;
            }
        }
    }

    if (document.getElementById('txtClient').value == '') {
        if (document.getElementById('billPart_hdnIsClientBilling').value == 'Y') {
            alert('Provide Client Name');
            document.getElementById('txtClient').focus();
            return false;
        }
    }
    else {
    }

    var IsCopayClient = 'N';
    if (document.getElementById('HdnCoPay') != null) {
        IsCopayClient = document.getElementById('HdnCoPay').value;
    }
    if (document.getElementById('hdnIsCashClient') != null) {
        if ((document.getElementById('hdnIsCashClient').value == "N" && IsCopayClient == "N") || $('#hdnAdvanceClient').val() == "1") {
            document.getElementById('billPart_PaymentType_txtAmount').disabled = true;
        }
        else {
            document.getElementById('billPart_PaymentType_txtAmount').disabled = false;
        }
    }
    if (document.getElementById('billPart_txtTestName').value.trim() == "") {
        alert('Search test names')
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


}
var defaultbillflag = 0;
//	   BEGIN | 459 | Arun M | 20160303 | A | Multicurrency
/* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
/* BEGIN | NA | MALATHI | 20180404 | Bill Tag Line   */ 
function CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsNormalRateCard, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID, DiscountCategoryCode, ReportDeliveryDate, MaxDiscount, IsRedeem, RedeemAmount, ItemCurrencyID, Tatreferencedatetime, Tatsamplereceiptdatetime, Tatprocessstartdatetime, Logistictimeinmins, Processingtimeinmins, Labendtime, Earlyreporttime, Tatreferencedatebase, IsDOBMandatory,BillReceiptTagText ) {
//    var IsRedeem = '';
//    var RedeemAmount = '';
    if (document.getElementById('txtClient').value.trim() == '' && document.getElementById('hdnDefaultOrgBillingItems').value != '' && defaultbillflag == 0) {
        defaultbillflag = 1;
        var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
        FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
                + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8] + "~IsDiscountable^" + defalutdata[9]
                + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + defalutdata[14] + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + document.getElementById('hdnRateID').value + "~Code^" + defalutdata[16] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + "N" + "~BaseRateID^" + 0 + "~DiscountPolicyID^" + 0 + "~DiscountCategoryCode^" + '' + "~ReportDeliveryDate^" + '' + "~MaxDiscount^" + '' + "~IsNormalRateCard^" + '' + "~IsRedeem^" + '' + "~RedeemAmount^" + '' + "~ItemCurrencyID^" + defalutdata[16] + "~Tatreferencedatetime^" + defalutdata[17] + "~Tatsamplereceiptdatetime^" + defalutdata[18] + "~Tatprocessstartdatetime^" + defalutdata[19] + "~Logistictimeinmins^" + defalutdata[20] + "~Processingtimeinmins^" + defalutdata[21] + "~Labendtime^" + defaultdata[22] + "~Earlyreporttime^" + Earlyreporttime + "~Tatreferencedatebase^" + Tatreferencedatebase + "|";
        document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;

    }
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
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

    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    if (iPaymentAlreadyPresent == 0) {
        FeeViewStateValue = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^"
                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsRI + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable
                     + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~ItemCurrencyID^" + ItemCurrencyID + "~Tatreferencedatetime^" + Tatreferencedatetime + "~Tatsamplereceiptdatetime^" + Tatsamplereceiptdatetime + "~Tatprocessstartdatetime^" + Tatprocessstartdatetime + "~Logistictimeinmins^" + Logistictimeinmins + "~Processingtimeinmins^" + Processingtimeinmins + "~Labendtime^" + Labendtime + "~Earlyreporttime^" + Earlyreporttime + "~Tatreferencedatebase^" + Tatreferencedatebase + "~IsDOBMandatory^" + IsDOBMandatory + "~BillReceiptTagText^" + BillReceiptTagText + "|" + FeeViewStateValue;
        //	   END | 459 | Arun M | 20160303 | A | Multicurrency  
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
    else if (queryStringColl != null) {
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  

        FeeViewStateValue = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^"
                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsRI + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable
                         + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~ItemCurrencyID^" + ItemCurrencyID + "~Tatreferencedatetime^" + Tatreferencedatetime + "~Tatsamplereceiptdatetime^" + Tatsamplereceiptdatetime + "~Tatprocessstartdatetime^" + Tatprocessstartdatetime + "~Logistictimeinmins^" + Logistictimeinmins + "~Processingtimeinmins^" + Processingtimeinmins + "~Labendtime^" + Labendtime + "~Earlyreporttime^" + Earlyreporttime + "~Tatreferencedatebase^" + Tatreferencedatebase + "~IsDOBMandatory^" + IsDOBMandatory + "~BillReceiptTagText^" + BillReceiptTagText + "|" + FeeViewStateValue;
        //	   END | 459 | Arun M | 20160303 | A | Multicurrency  
        document.getElementById('billPart_hdfBillType1').value = FeeViewStateValue;
        CreateBillItemsTable(0);

    }
    else {
        alert("Item already added");
        ClearSelectedData(0);
        return false;
    }
    if (document.getElementById('billPart_hdfBillType1').value != '') {
        document.getElementById('txtSampleDate').disabled = true;
        if ($("#hdnPageType").val() != "B2C") {
    document.getElementById('txtSampleTime11').disabled  = true;
    document.getElementById('txtSampleTime22').disabled  = true;
    document.getElementById('ddlSampleTimeType1').disabled  = true;
        }
    }
}
//sabari comments:inpt parameter for this method :IsDOBMandatory, and form FeeViewStateValue with "IsDOBMandatory^" to billPart_hdfBillType1
/* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
/* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
function chkChange(value, objid) {
    //    btnDeleteBillingItems_OnClick1(value);

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
    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID, DiscountCategoryCode, ReportDeliveryDate, IsRedeem, RedeemAmount, ItemCurrencyID, IsDOBMandatory,BillReceiptTagText;
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
            //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency
            if (arrayChildData[0] == "ItemCurrencyID") {
                ItemCurrencyID = arrayChildData[1];
            }
            //	   END | 459 | Arun M | 20160303 | A | Multicurrency
            if (arrayChildData[0] == "Tatreferencedatetime") {
                Tatreferencedatetime = arrayChildData[1];
            }
            if (arrayChildData[0] == "TATSampleReceiptDateTime") {
                TATSampleReceiptDateTime = arrayChildData[1];
            }
            if (arrayChildData[0] == "Tatprocessstartdatetime") {
                Tatprocessstartdatetime = arrayChildData[1];
            }
            if (arrayChildData[0] == "Logistictimeinmins") {
                Logistictimeinmins = arrayChildData[1];
            }
            if (arrayChildData[0] == "Processingtimeinmins") {
                Processingtimeinmins = arrayChildData[1];
            }
            if (arrayChildData[0] == "Labendtime") {
                Labendtime = arrayChildData[1];
            }
            if (arrayChildData[0] == "Earlyreporttime") {
                Earlyreporttime = arrayChildData[1];
            }
            if (arrayChildData[0] == "Tatreferencedatebase") {
                Tatreferencedatebase = arrayChildData[1];
            }
            /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
            if (arrayChildData[0] == "IsDOBMandatory") {
                IsDOBMandatory = arrayChildData[1];
            }
            /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */

            if (arrayChildData[0] == "BillReceiptTagText") {
                BillReceiptTagText = arrayChildData[1];
            }
        }



    }

    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    viewsstatevalie = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^"
                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable
                + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~ItemCurrencyID^" + ItemCurrencyID + "~Tatreferencedatetime^" + Tatreferencedatetime + "~Tatsamplereceiptdatetime^" + Tatsamplereceiptdatetime + "~Tatprocessstartdatetime^" + Tatprocessstartdatetime + "~Logistictimeinmins^" + Logistictimeinmins + "~Processingtimeinmins^" + Processingtimeinmins + "~Labendtime^" + Labendtime + "~Earlyreporttime^" + Earlyreporttime + "~Tatreferencedatebase^" + Tatreferencedatebase + "~IsDOBMandatory^" + IsDOBMandatory  + "~BillReceiptTagText^" + BillReceiptTagText + "|" + FeeViewStateValue;
    document.getElementById('billPart_hdfBillType1').value = viewsstatevalie
    CreateBillItemsTable(1)

    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  


}
//sabari Comments:IsDOBMandatory Declared  and added in viewsstatevalie variable for billPart_hdfBillType1 append
/* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
/* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
function CreateBillItemsTable(id) {
   // debugger;
   //BEGIN || THIYAGU || 20160713 || Show MRP Total Amount in billing page and edit bill page
    var ClientID = document.getElementById('hdnSelectedClientClientID').value;
    var isMRPType = 'N';
    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetClientBillType",
        data: "{ 'pClientID': '" + ClientID + "' }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
           // debugger;
            isMRPType = data.d;
        },
        failure: function(msg) {
            //debugger;
            ShowErrorMessage(msg);
        }
    });
//END || THIYAGU || 20160713 || Show MRP Total Amount in billing page and edit bill page
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
    var Tempdisplay = 'display:block';
    if (TempString == "Y") {
        Tempdisplay = 'display:none';
    }
    var RedeemDisplay = 'display :block';
    if ($("#billPart_hdnIsCashClient").val() == "N") {
        RedeemDisplay = 'display :none';
    }


    startPaymentTag = "<TABLE nowrap='nowrap' ID='tabDrg1' Cellpadding='0' Cellspacing='0' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> FeeID </th><th scope='col'  style='width:5%;display:none;'> FeeType </th> "
    + "<th scope='col' style='width:5%;'> S.No </th> <th scope='col' style='width:6%;'> Code </th> <th scope='col' align='left' style='width:28%;padding-left:2px;'> Description </th> <th scope='col' align='center' style='width:8%;'>IsSTAT</th><th scope='col' align='center' style='width:12%;'>PL/OutSource</th> <th scope='col' align='right' style='display:none;width:5%;'>  Quantity </th><th scope='col' align='right' style='width:8%;'> Amount </th> "
    + "<th scope='col' style='width:20%;padding-left:2px;display:none;'>Remarks </th><th scope='col' style='width:10%;padding-left:2px;" + RedeemDisplay + "'> Rm.Amt </th> <th scope='col' align='right' style='width:10%;'> MRP </th><th scope='col' style='align:right;width:17%;display:table-cell;'> Report Date </th> <th scope='col' style='display:none;'> IsReimbursable </th><th scope='col' style='display:none;'> IsNormalRateCard </th> <th scope='col' style='display:none;'> IsDiscountable </th><th scope='col' style='display:none;'> BaseRateID </th> <th scope='col' style='display:none;'> DPID </th><th scope='col' style='display:none;'> DCC </th> <th scope='col' style='display:none;'> DeliveryDate </th>"
    + "<th scope='col' style='display:none;'> IsTaxable </th><th scope='col' style='display:none;'> IsRepeatable </th><th scope='col' style='display:none;'> IsSTAT </th><th scope='col' style='display:none;'> IsSMS </th><th scope='col' style='display:none;'> IsOutSource </th><th scope='col' style='display:none;'> IsNABL </th>"
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency    
    +"<th scope='col' style='display:none;'> BillingItemRateID </th><th scope='col' style='display:none;'> HasHistory </th><th scope='col' style='display:none;'> MaxDiscount </th><th scope='col' style='display:none;'> IsRedeem </th><th scope='col' style='display:none;'> RedeemAmount </th>  <th scope='col' style='display:none;'> ItemCurrencyID </th>  <th scope='col' style='" + Tempdisplay + "'> Delete </th> </tr>";
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
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
     DiscountCategoryCode, ReportDeliveryDate, MaxDiscount, IsRedeem, RedeemAmount, ItemCurrencyID, Tatreferencedatetime, Tatsamplereceiptdatetime, Tatprocessstartdatetime, Logistictimeinmins, Processingtimeinmins, Labendtime, Earlyreporttime, Tatreferencedatebase, IsDOBMandatory, BillReceiptTagText;
    //	   END | 459 | Arun M | 20160303 | A | Multicurrency  
    var GrossAmt = 0;
    var MRPTotal = 0;
    var DiscountableTestAmount = 0;
    var RedeemableTestAmount = 0;
    var TaxableTestAmount = 0;
    var sno = 1;
    var IsInvestigationAdded = 0;
    var RedeemabelAmt = 0;
    var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
    if (id == 0) {
        if (document.getElementById('txtClient').value == '' && document.getElementById('hdnDefaultOrgBillingItems').value != '' && defaultbillflag == 0) {
            defaultbillflag = 1;
            // defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
            FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
                        + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8]
                        + "~IsDiscountable^" + defalutdata[9] + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~outRInSourceLocation^" + defalutdata[14]
                        + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + defalutdata[16] + "~Code^" + defalutdata[17] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + "N" + "~Tatreferencedatetime^" + defalutdata[18] + "~Tatsamplereceiptdatetime^" + defalutdata[19] + "~Tatprocessstartdatetime^" + defalutdata[20] + "~Logistictimeinmins^" + defaultdata[21] + "~Processingtimeinmins^" + defalutdata[23] + "~Labendtime^" + defalutdata[24] + "~Earlyreporttime^" + defalutdata[25] + "~Tatreferencedatebase^" + Tatreferencedatebase + "|";
            document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;

        }
    }
    /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  for Global Flag */
    var a = 0, b = 0;
    var _Mainlistarr = new Array();
    var _subarr = new Array();
    var _parentarr = new Array();
    var _childarr = new Array();
    var configvalue = "N";
    _Mainlistarr = $('#billPart_hdfBillType1').val().split('|');
    if (_Mainlistarr.length > 0) {
        for (a = 0; a < _Mainlistarr.length - 1; a++) {
            _subarr = _Mainlistarr[a].split('~');
            if (_subarr.length > 0 && _subarr != "") {
                //37 is hot coded for IsDOBMandatory index
                for (b = 0; b < _subarr.length; b++) {
                    _parentarr = _subarr[b].split('^');
                    if (_parentarr.length > 0) {
                        if (_parentarr[0] == "IsDOBMandatory" && _parentarr[1] != "N") {
                            configvalue = _parentarr[1];
                        }
                    }
                }


            }

        }
    }
    $('#hdnIsDOBMandatoryconfig').val(configvalue);
    /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
    FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;
    document.getElementById('billPart_hdnInvHistory').value = '';
    arrayMainData = FeeViewStateValue.split('|');
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
                    if (arrayChildData[0] == "ActualAmount") {
                        ActualAmount = arrayChildData[1];
                        if (isMRPType == 'Y')
                            MRPTotal = Number(MRPTotal) + Number(ActualAmount);
                        else
                            MRPTotal = 0;
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
                    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
                    if (arrayChildData[0] == "ItemCurrencyID") {
                        ItemCurrencyID = arrayChildData[1];
                    }
                    //	   END | 459 | Arun M | 20160303 | A | Multicurrency
                    if (arrayChildData[0] == "Tatreferencedatetime") {
                        Tatreferencedatetime = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Tatsamplereceiptdatetime") {
                        Tatsamplereceiptdatetime = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Tatprocessstartdatetime") {
                        Tatprocessstartdatetime = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Logistictimeinmins") {
                        Logistictimeinmins = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Processingtimeinmins") {
                        Processingtimeinmins = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Labendtime") {
                        Labendtime = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Earlyreporttime") {
                        Earlyreporttime = arrayChildData[1];
                    }
                    if (arrayChildData[0] == "Tatreferencedatebase") {
                        Tatreferencedatebase = arrayChildData[1];
                    }
                    /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
                    if (arrayChildData[0] == "IsDOBMandatory") {
                        IsDOBMandatory = arrayChildData[1];
                    }
                    /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
/* BEGIN | NA | MALATHI | 20180404 | Bill Tag Line   */
                    if (arrayChildData[0] == "BillReceiptTagText") {
                        BillReceiptTagText = arrayChildData[1];
                    }
/* End | NA | MALATHI | 20180404 | Bill Tag Line   */
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
                newPaymentTables += "<TD ><input value ='" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "' onclick='GetGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"
            }
            else if (FeeType == 'PKG') {
            newPaymentTables += "<TD ><input value ='" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "' onclick='GetGroupName(name);'type='button' style='width:250px;word-wrap: break-word;color:#6699FF;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"
            }
            else if (FeeType != "INV") {
            newPaymentTables += "<TD ><input value ='" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "' onclick='GetGroupName(name);'type='button' style='width:250px;word-wrap: break-word;background-color:Transparent;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"
            }
            else {
                // newPaymentTables += "<TD  style='align:left;'>" + Descrip + "</TD>"
                newPaymentTables += "<TD ><input value ='" + Descrip + "' type='button' style='width:250px;word-wrap: break-word;background-color:Transparent;font-size:10px;border-style:none;text-align:left;' /></TD>"
                //                newPaymentTables += "<TD style='padding-left:5px;'>" + Descrip + "</TD>"
            }

            //            newPaymentTables += "<TD>" + sno + "</TD>";
            //            newPaymentTables += "<TD>" + Code + "</TD>";
            //             if (FeeType != "INV") {
            //                newPaymentTables += "<TD align='left'><input value = '" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "' onclick='GetGroupName(name);'type='button' style='background-color:Transparent;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"
            //            }
            //            else {
            //                newPaymentTables += "<TD  align='left'>" + Descrip + "</TD>"
            //            }
            newPaymentTables += "<TD  style='display:none;' align='right'>" + Quantity + "</TD>";
            if (document.getElementById('billPart_hdnIsBillable').value.trim() == "N") {
                if (IsSTAT == 'Y') {
                    newPaymentTables += "<TD style='display:table-cell;' align='Center'><input  style='display:none;'  id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~ItemCurrencyID^" + ItemCurrencyID + "~Tatreferencedatetime^" + Tatreferencedatetime + "~Tatsamplereceiptdatetime^" + Tatsamplereceiptdatetime + "~Tatprocessstartdatetime^" + Tatprocessstartdatetime + "~Logistictimeinmins^" + Logistictimeinmins + "~Processingtimeinmins^" + Processingtimeinmins + "~Labendtime^" + Labendtime + "~Earlyreporttime^" + Earlyreporttime + "~Tatreferencedatebase^" + Tatreferencedatebase + "~IsDOBMandatory^" + IsDOBMandatory  + "~BillReceiptTagText^" + BillReceiptTagText +"' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true'   type='checkbox'  /></TD>";
                } else {
                newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   style='display:none;' id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~ItemCurrencyID^" + ItemCurrencyID + "~Tatreferencedatetime^" + Tatreferencedatetime + "~Tatsamplereceiptdatetime^" + Tatsamplereceiptdatetime + "~Tatprocessstartdatetime^" + Tatprocessstartdatetime + "~Logistictimeinmins^" + Logistictimeinmins + "~Processingtimeinmins^" + Processingtimeinmins + "~Labendtime^" + Labendtime + "~Earlyreporttime^" + Earlyreporttime + "~Tatreferencedatebase^" + Tatreferencedatebase + "~IsDOBMandatory^" + IsDOBMandatory + "~BillReceiptTagText^" + BillReceiptTagText +"' onclick='chkChange(value,this.id);'  name='chkAlls'   type='checkbox'  /></TD>";
                }
            }
            else {
                if (IsSTAT == 'Y') {
                    newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~ItemCurrencyID^" + ItemCurrencyID + "~Tatreferencedatetime^" + Tatreferencedatetime + "~Tatsamplereceiptdatetime^" + Tatsamplereceiptdatetime + "~Tatprocessstartdatetime^" + Tatprocessstartdatetime + "~Logistictimeinmins^" + Logistictimeinmins + "~Processingtimeinmins^" + Processingtimeinmins + "~Labendtime^" + Labendtime + "~Earlyreporttime^" + Earlyreporttime + "~Tatreferencedatebase^" + Tatreferencedatebase + "~IsDOBMandatory^" + IsDOBMandatory + "~BillReceiptTagText^" + BillReceiptTagText +"' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true'   type='checkbox'  /></TD>";
                } else {
                newPaymentTables += "<TD style='display:table-cell;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~ItemCurrencyID^" + ItemCurrencyID + "~Tatreferencedatetime^" + Tatreferencedatetime + "~Tatsamplereceiptdatetime^" + Tatsamplereceiptdatetime + "~Tatprocessstartdatetime^" + Tatprocessstartdatetime + "~Logistictimeinmins^" + Logistictimeinmins + "~Processingtimeinmins^" + Processingtimeinmins + "~Labendtime^" + Labendtime + "~Earlyreporttime^" + Earlyreporttime + "~Tatreferencedatebase^" + Tatreferencedatebase + "~IsDOBMandatory^" + IsDOBMandatory + "~BillReceiptTagText^" + BillReceiptTagText + "' onclick='chkChange(value,this.id);'  name='chkAlls'   type='checkbox'  /></TD>";
                }
            }
            //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
            newPaymentTables += "<TD style='display:table-cell;'>" + outRInSourceLocation + "</TD>";
            newPaymentTables += "<TD  align='right'>" + Amount + "</TD>";
            newPaymentTables += "<TD  align='right' style='" + RedeemDisplay + "'>" + RedeemabelAmt + "</TD>";
            newPaymentTables += "<TD  style='display:none;'>" + Remarks + "</TD>";
	    //BEGIN || THIYAGU || 20160713 || Show MRP Total Amount in billing page and edit bill page
            if (isMRPType == 'Y') {
                newPaymentTables += "<TD align='right'>" + parseFloat(ActualAmount) + "</TD>";
            }
            else {
                newPaymentTables += "<TD align='right'>" + parseFloat(0) + "</TD>";
            }
	    //END || THIYAGU || 20160713 || Show MRP Total Amount in billing page and edit bill page
            newPaymentTables += "<TD style='display:table-cell;' align='center'>" + ReportDate + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsReimbursable + "</TD>";
            
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
            newPaymentTables += "<TD style='display:none;'>" + MaxDiscount + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsRedeem + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + RedeemAmount + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + IsNormalRateCard + "</TD>";
            //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
            newPaymentTables += "<TD style='display:none;'>" + ItemCurrencyID + "</TD>";

            newPaymentTables += "<TD style='display:none;'>" + Tatreferencedatetime + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + Tatsamplereceiptdatetime + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + Tatprocessstartdatetime + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + Logistictimeinmins + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + Processingtimeinmins + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + Labendtime + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + Earlyreporttime + "</TD>";
            newPaymentTables += "<TD style='display:none;'>" + Tatreferencedatebase + "</TD>";
            /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
            newPaymentTables += "<TD style='display:none;'>" + IsDOBMandatory + "</TD>";
            newPaymentTables += "<TD align='center' style='" + Tempdisplay + "'><input name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsNormalRateCard^" + IsNormalRateCard + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "~MaxDiscount^" + MaxDiscount + "~IsRedeem^" + IsRedeem + "~RedeemAmount^" + RedeemAmount + "~ItemCurrencyID^" + ItemCurrencyID + "~Tatreferencedatetime^" + Tatreferencedatetime + "~Tatsamplereceiptdatetime^" + Tatsamplereceiptdatetime + "~Tatprocessstartdatetime^" + Tatprocessstartdatetime + "~Logistictimeinmins^" + Logistictimeinmins + "~Processingtimeinmins^" + Processingtimeinmins + "~Labendtime^" + Labendtime + "~Earlyreporttime^" + Earlyreporttime + "~Tatreferencedatebase^" + Tatreferencedatebase + "~IsDOBMandatory^" + IsDOBMandatory + "~BillReceiptTagText^" + BillReceiptTagText + "' onclick='btnDeleteBillingItems_OnClick1(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";
            /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
            //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
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
    //BEGIN || THIYAGU || 20160713 || Show MRP Total Amount in billing page and edit bill page
    document.getElementById('billPart_lblMRPTotalAmount').innerText = parseFloat(Number(MRPTotal)).toFixed(2);
    //END || THIYAGU || 20160713 || Show MRP Total Amount in billing page and edit bill page
    //document.getElementById('billPart_txtEditBillMRPTotal').value = parseFloat(Number(MRPTotal)).toFixed(2);
    //    $('[id$="hdnDiscountableTestTotal"]').val(DiscountableTestAmount);
    //    $('[id$="hdnTaxableTestToal"]').val(TaxableTestAmount);

    ClearSelectedData();
    SetGrossValue(GrossAmt)
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
//sabari comments:IsDOBMandatory global flag add and append to table and TAT change event  value[IsDOBMandatory] pass and,Delete Event Form IsDOBMandatory
/* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
function GetGroupName(FeeId, FeeType) {
    debugger;
    //    var FeeType = 'GRP';
    if (FeeId != '') {
        var FeeIds = FeeId.split(',')[0];
        var pFeeType = FeeId.split(',')[1];
        var pDescrip = FeeId.split(',')[2];
        $find('billPart_ModalPopupShow').show();
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetGroupInfo",
            data: "{ 'pkgid': '" + FeeIds + "','Type': '" + pFeeType + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var Items = data.d;
                GetLabHistory(Items)
                if (pFeeType == 'GRP') {
                    document.getElementById('billPart_Lbl_GroupName').innerHTML = pDescrip + ' : ' + 'GROUP';
                }
                else {
                    document.getElementById('billPart_Lbl_GroupName').innerHTML = pDescrip + ' : ' + 'PACKAGE';
                }
            }
        });
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

        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var SNo = result.length - n;

        cell1.innerHTML = "<b>" + SNo + "</b>";
        cell2.innerHTML = "<b>" + result[n].InvestigationName + "</b>";
        cell3.innerHTML = "<b>" + result[n].Status + "</b> ";
        cell4.innerHTML = "<b>" + result[n].Location + "</b>";

        document.getElementById('tblGroupHistory').style.display = 'table';

    }

}
function GetGroupName1(lblInvestigationID, lblType, lbInvName) {
    debugger;
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
    document.getElementById('billPart_ddlDiscountReason').value = "0";
    document.getElementById('billPart_btnDiscountPercent').disabled = true;
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

    var roundOffAmt = 0;
    var gross = 0;
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
    if (Number(document.getElementById('billPart_txtGross').value) > 0) {
        if (Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) > 0) {

            document.getElementById('billPart_ddDiscountPercent').disabled = false;
            document.getElementById('billPart_btnDiscountPercent').disabled = false;
            document.getElementById('billPart_txtDiscount').readOnly = false;
            document.getElementById('billPart_txtAuthorised').disabled = false;
            document.getElementById('billPart_txtAuthorised').readOnly = false;
            document.getElementById('billPart_txtDiscountReason').readOnly = false;
            document.getElementById('billPart_ddlDiscountReason').disabled = false;
            document.getElementById('billPart_ddlDiscountType').disabled = false;
            document.getElementById('billPart_ddlTaxPercent').disabled = false;


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
            if (objValue == 'ED') {
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


            document.getElementById('billPart_hdnDiscountAmt').value = document.getElementById('billPart_txtDiscount').value;
            discount = document.getElementById('billPart_hdnDiscountAmt').value;
            if (KeySlabDiscount == "N") {
                if (Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) < Number(document.getElementById('billPart_txtDiscount').value)) {
                    alert('Ordered test net amount, less then discount amount');
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

            if (Number(document.getElementById('billPart_ddlTaxPercent').value) > 0) {
                document.getElementById('billPart_txtTax').value = parseFloat((parseFloat(Number(gross) - Number(discount)) / 100) * (Number(document.getElementById('billPart_ddlTaxPercent').value))).toFixed(2);
                ToTargetFormat($('#billPart_txtTax'));
            }

            TaxAMount = Number(document.getElementById('billPart_txtTax').value).toFixed(2);
            document.getElementById('billPart_hdnTaxAmount').value = TaxAMount;
            ToTargetFormat($('#billPart_hdnTaxAmount'));

            var netvalue = Number(gross) + Number(TaxAMount) + Number(EDCess) + Number(SHEDCess) + Number(ServiceCharge) - Number(discount);
            //            if (Number(netvalue) - Number(getOPCustomRoundoff(netvalue.toFixed(2))) > 0)
            //                roundOffAmt = Number(netvalue) - Number(getOPCustomRoundoff(netvalue));
            //            else
            //                roundOffAmt = Number(getOPCustomRoundoff(netvalue)) - Number(netvalue);
            var HDCashClient = document.getElementById('billPart_hdnIsCashClient').value;
            if (HDCashClient == "N") {
                var hdnTpaRoundoff = document.getElementById('hdnTpaRoundoff').value;
                var hdnTpaRoundOffType = document.getElementById('hdnTpaRoundOffType').value;
                document.getElementById('hdnDefaultRoundoff').value = hdnTpaRoundoff;
                document.getElementById('hdnRoundOffType').value = hdnTpaRoundOffType;

            }
            //BEGIN | 459 | Thiyagu S | 20162206 | A | Multicurrency
            var isCurrencyRoundOff = document.getElementById('hdnIsRoundOffClient').value;
            //END | 459 | Thiyagu S | 20162206 | A | Multicurrency
            if (isCurrencyRoundOff == 'Y') {

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
                //document.getElementById('hdnIsRoundOffClient').value = 'N';
            }
            else {
                roundOffAmt = 0.00;

                document.getElementById('billPart_txtRoundoffAmt').value = (parseFloat(roundOffAmt).toFixed(2));
                ToTargetFormat($('#billPart_txtRoundoffAmt'));
                document.getElementById('billPart_hdnRoundOff').value = (parseFloat(roundOffAmt).toFixed(2));
                ToTargetFormat($('#billPart_hdnRoundOff'));

                document.getElementById('billPart_txtEdtNetAmt').value = (parseFloat(netvalue).toFixed(2));
                ToTargetFormat($('#billPart_txtEdtNetAmt'));
                document.getElementById('billPart_txtNetAmount').value = (parseFloat(netvalue).toFixed(2));
                ToTargetFormat($('#billPart_txtNetAmount'));

                document.getElementById('billPart_hdnNetAmount').value = (parseFloat(netvalue).toFixed(2));
                ToTargetFormat($('#billPart_hdnNetAmount'));
            }
            var IsCashClient = document.getElementById('billPart_hdnIsCashClient').value;
            var ClientType = document.getElementById('billPart_hdnClientType').value
            if (IsCashClient == '') {
                IsCashClient = 'Y';
            }
            var IsCopayClient = 'N';
            if (document.getElementById('HdnCoPay') != null) {
                IsCopayClient = document.getElementById('HdnCoPay').value;
            }
            SetOtherCurrValues();
            if ((document.getElementById('txtClient').value == '' || IsCashClient == 'Y' || ClientType == 'WAK') && obj == "ADD" && IsCopayClient != 'Y') {
                $("#billPart_PaymentType_txtAmount").removeAttr("disabled");
                
                var amount = document.getElementById("billPart_OtherCurrencyDisplay1_lblOtherCurrPaybleAmount").innerHTML;
                if (amount != null) {
                    document.getElementById('billPart_PaymentType_txtAmount').value = amount;
                    ToTargetFormat($('#billPart_PaymentType_txtAmount'));

                    document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = amount;
                    ToTargetFormat($('#billPart_PaymentType_txtTotalAmount'));
                }
                else {
                    document.getElementById('billPart_PaymentType_txtAmount').value = parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2);
                    ToTargetFormat($('#billPart_PaymentType_txtAmount'));

                    document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2);
                    ToTargetFormat($('#billPart_PaymentType_txtTotalAmount'));
                }

            }
            else {

                $("#billPart_PaymentType_txtAmount").attr("enabled", "enabled");
            }
          //  SetOtherCurrValues();

        }
        else {
            if (obj != 'ED') {
                if (document.getElementById('billPart_hdnCpedit').value == 'Y') {
                    ClearPaymentControlEvents1();
                    SetNetValue('ADD');
                }
                //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
                else {
                   // if (confirm('Amount already received, delete the amount received... Do you want to Delete the amount received?')) {
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
                        //Multi Currency Concept
                        document.getElementById("billPart_OtherCurrencyDisplay1_lblOtherCurrRecdAmount").innerHTML = parseFloat(0.00).toFixed(2);
                        document.getElementById("billPart_OtherCurrencyDisplay1_hdnOterCurrReceived").value = parseFloat(0.00).toFixed(2);
                        

                        ClearPaymentControlEvents1();
                        SetNetValue('ADD');
                        if (($("#billPart_hdnHasClientHealthcoupon").val() == "Y") && $("#billPart_hdnHasMyCard").val() == "Y" && $("#billPart_hdnIsCashClient").val() == "Y" && $("#billPart_hdnOrgHealthCoupon").val() == "Y" && document.getElementById('billPart_ddDiscountPercent').value == 0 && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y") {
                            $('#hdnIsMycardChecked').val('Y');
                            $('#dvExistingCard').show();
                        }
                   // }
                 //   else {
                  //      document.getElementById('billPart_txtCeiling').value = document.getElementById('billPart_hdnDiscountAmt').value;
                        
                 //       document.getElementById('billPart_ddDiscountPercent').value = 0;
                  //      document.getElementById('billPart_ddlDiscountReason').value = 0;
                   //     document.getElementById('billPart_hdnDiscountPercentage').value = 0;
                   //     return false;
                  //  }
                }
            }
        }
    }
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  

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
    if (document.getElementById('HdnCoPay') != null && (document.getElementById('HdnCoPay').value == '' ||  document.getElementById('HdnCoPay').value == 'N') ){

        if (document.getElementById('billPart_hdnAmountReceived').value == 0) {
            document.getElementById('billPart_txtDue').value = 0;
        }
        else {
            document.getElementById('billPart_txtDue').value = parseFloat(Number(document.getElementById('billPart_hdnNetAmount').value) - Number(document.getElementById('billPart_hdnAmountReceived').value)).toFixed(2);
        }
        ToTargetFormat($('#billPart_txtDue'));
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
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    //        var OtherCurrency = document.getElementById('billPart_PaymentType_hdnOtherCurrency').value;
    //        var BaseCurrencyID = document.getElementById('billPart_PaymentType_hdnBaseCurrencyID').value;
    //        var OtherCurrencyID = document.getElementById('billPart_PaymentType_hdnOtherCurrencyID').value;
    var BaseCurrencyID = document.getElementById('billPart_PaymentType_hdnSelectedClientCurrency').value.split('~')[0];
    var OtherCurrencyID = document.getElementById('billPart_PaymentType_ddCurrency').value.split('~')[0];

    if (Number(BaseCurrencyID) != Number(OtherCurrencyID)) {
        sNetValue = Number(format_number(Number(document.getElementById('billPart_PaymentType_hdnConvertedAmount').value) + Number(ServiceCharge), 4)).toFixed(2);
    }
    else {
        sNetValue = Number(format_number(Number(document.getElementById('billPart_hdnNetAmount').value) + Number(ServiceCharge), 4)).toFixed(2);
    }
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency
    sVal = Number(format_number(Number(sVal) + Number(TotalAmount), 4)).toFixed(2);
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  

    if (PaymentAmount > 0) {

        var PayableAmt = document.getElementById("billPart_OtherCurrencyDisplay1_lblOtherCurrPaybleAmount").innerText;
//        if (Number(PayableAmt) < Number(sVal)) {
//            alert('Amount received is greater than net amount')
//            return false;
//        }

        //       if (((Number(sNetValue) - Number(sVal) < 0.99) && (Number(sNetValue) - Number(sVal) > 0.001)) || ((Number(sNetValue) - Number(sVal) > -0.99) && (Number(sNetValue) - Number(sVal) < -0.001))) {
        //  if (((Number(sNetValue) - Number(sVal) < 0.50) && (Number(sNetValue) - Number(sVal) > 0.0001)) || ((Number(sNetValue) - Number(sVal) > -0.50) && (Number(sNetValue) - Number(sVal) < -0.0001))) {
        if ((Number(sNetValue) - Number(sVal) < 0.50) && (Number(sNetValue) - Number(sVal) > -0.50)) {
            sNetValue = Number(sVal);
        }
        if (Number(sNetValue) >= Number(sVal)) {
            sVal = format_number(sVal, 4);
            SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 4), ConValue);
            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 4);
            //var pScrAmt = Number(pScr) * Number(CurrRate);
            //            var pAmt = Number(sVal) * Number(CurrRate);
            //            To show the paid amount in AmountReceivedDetails field.
            var pScrAmt = Number(pScr) / format_number(Number(CurrRate), 4);
           // pScrAmt = Math.round(pScrAmt);
            var pAmt = Number(sVal) / format_number(Number(CurrRate), 4);
          //  pAmt = Math.round(pAmt).toFixed(2);
            
            //var pAmt = Number(sVal);
            var NetAmt = document.getElementById('billPart_txtNetAmount').value;
            //if (((Number(NetAmt) - Number(pAmt) < 0.99) && (Number(NetAmt) - Number(pAmt) > 0.001)) || ((Number(NetAmt) - Number(pAmt) > -0.99) && (Number(NetAmt) - Number(pAmt) < -0.001))) {
            Number(PayableAmt) - Number(sVal)
            //if (((Number(PayableAmt) - Number(sVal) < 0.50) && (Number(PayableAmt) - Number(sVal) >= 0.001)) || ((Number(PayableAmt) - Number(sVal) > -0.50) && (Number(PayableAmt) - Number(sVal) <= -0.001))) {
            if ((Number(PayableAmt) - Number(sVal) < 0.50) && (Number(PayableAmt) - Number(sVal) > -0.50)) {
                //if (((Number(NetAmt) - Number(pAmt) < 0.50) && (Number(NetAmt) - Number(pAmt) > 0.001)) || ((Number(NetAmt) - Number(pAmt) > -0.50) && (Number(NetAmt) - Number(pAmt) < -0.001))) {
                if (format_number(Number(CurrRate), 4) >= 0.50) {
                    if ((Number(NetAmt) - Number(pAmt) < 0.50) && (Number(NetAmt) - Number(pAmt) > -0.50)) {
                        pAmt = Number(NetAmt);
                    }
                }
                else {
                    if ((Number(NetAmt) - Number(pAmt) < 0.99) && (Number(NetAmt) - Number(pAmt) > -0.99)) {
                        pAmt = Number(NetAmt);
                    }
                }
            }
            //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
            document.getElementById('billPart_txtServiceCharge').value = parseFloat(pScrAmt).toFixed(2);
            ToTargetFormat($('#billPart_txtServiceCharge'));
            document.getElementById('billPart_hdnServiceCharge').value = format_number(pScrAmt, 2);
            ToTargetFormat($('#billPart_hdnServiceCharge'));
            document.getElementById('billPart_txtAmtReceived').value = parseFloat(pAmt).toFixed(2);
            ToTargetFormat($('#billPart_txtAmtReceived'));
            document.getElementById('billPart_hdnAmountReceived').value = parseFloat(pAmt).toFixed(2);
            ToTargetFormat($('#billPart_hdnAmountReceived'));
            //Commented by moorthy for multi currency test purpose
            var net = format_number(parseFloat(NetAmt) + parseFloat(format_number(pScrAmt, 2)), 2);
            document.getElementById('billPart_txtNetAmount').value = net;
            ToTargetFormat($('#billPart_txtNetAmount'));
            document.getElementById('billPart_hdnNetAmount').value = parseFloat(NetAmt) + parseFloat(format_number(pScrAmt, 2));
            ToTargetFormat($('#billPart_hdnNetAmount'));
            var pNetAmount = '';
            var pReceivedAmount = '';
            pNetAmount=net;
            pReceivedAmount = parseFloat(pAmt).toFixed(2);
            if ((Number(pNetAmount) - Number(pReceivedAmount) < 0.50) && (Number(pNetAmount) - Number(pReceivedAmount) > -0.50)) {
                pAmt = Number(pNetAmount);
                document.getElementById('billPart_txtAmtReceived').value = parseFloat(pAmt).toFixed(2);
                ToTargetFormat($('#billPart_txtAmtReceived'));
                document.getElementById('billPart_hdnAmountReceived').value = parseFloat(pAmt).toFixed(2);
                ToTargetFormat($('#billPart_hdnAmountReceived'));
            }
            if (sNetValue == '0.00') {
                document.getElementById('billPart_txtDue').value = sNetValue;
                ToTargetFormat($('#billPart_txtDue'));
                document.getElementById('billPart_hdnDue').value = sNetValue;
                ToTargetFormat($('#billPart_hdnDue'));
            }

            //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
            // var pTotal = Number(Number(sNetValue)) * Number(CurrRate);
            var pTotal = document.getElementById('billPart_hdnNetAmount').value;
            //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
            document.getElementById('billPart_hdnPaymentControlReceivedtemp').value = format_number(Number(pAmt), 2);
            ToTargetFormat($('#billPart_hdnPaymentControlReceivedtemp'));
            SetNetValue("ED");
            return true;

        }
        else {
            alert('Amount received is greater than net amount')
            return false;
        }
    }

}
function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    //Multi Currency
    var alertnotCurrencyselect = true;
    alertnotCurrencyselect = GetCurrencyValues(); //To Set the Currency details...
    if (alertnotCurrencyselect == false) {
        return false;
    }
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
    var ConValue = "OtherCurrencyDisplay1";
    var sVal = getOtherCurrAmtValues("REC", ConValue);
    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
    var tempService = getOtherCurrAmtValues("SER", ConValue);
    var CurrRate = GetOtherCurrency("OtherCurrRate");
    sVal = Number(Number(sVal) - Number(TotalAmount));
    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
    var pScrAmt = Number(pScr) * Number(CurrRate);
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    //var pAmt = Number(sVal) * Number(CurrRate);
    var pAmt = Number(sVal) / Number(CurrRate);
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  

    document.getElementById('billPart_hdnServiceCharge').value = format_number(pScrAmt, 2);
    ToTargetFormat($('#billPart_hdnServiceCharge'));
    document.getElementById('billPart_txtServiceCharge').value = parseFloat(pScrAmt).toFixed(2);
    ToTargetFormat($('#billPart_txtServiceCharge'));

    document.getElementById('billPart_txtNetAmount').value = (Number(document.getElementById('billPart_txtNetAmount').value) - Number(ServiceCharge)).toFixed(2);
    ToTargetFormat($('#billPart_txtNetAmount'));
    document.getElementById('billPart_hdnNetAmount').value = document.getElementById('billPart_txtNetAmount').value;
    ToTargetFormat($('#billPart_hdnNetAmount'));
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    var amtRec = 0;
    //document.getElementById('billPart_hdnAmountReceived').value = format_number(Number(sVal) + Number(amtRec), 2);
    document.getElementById('billPart_hdnAmountReceived').value = format_number(Number(pAmt) + Number(amtRec), 2);
    ToTargetFormat($('#billPart_hdnAmountReceived'));
    //document.getElementById('billPart_txtAmtReceived').value = parseFloat(Number(sVal) + Number(amtRec)).toFixed(2);
    document.getElementById('billPart_txtAmtReceived').value = parseFloat(Number(pAmt) + Number(amtRec)).toFixed(2);
    ToTargetFormat($('#billPart_txtAmtReceived'));
    SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);
    SetNetValue("ED");

    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  





}
function ClearPaymentControlEvents1() {
    document.getElementById('billPart_PaymentType_hdfPaymentType').value = "";
    PaymentControlclear1();
    CreatePaymentTables();
    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrPayble').value = "0";
    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrReceived').value = "0";
    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrServiceCharge').value = "0";
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    document.getElementById("billPart_OtherCurrencyDisplay1_lblOtherCurrRecdAmount").value = "0";
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
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
    if (document.getElementById('billPart_hdfBillType1').value == '') {
        document.getElementById('txtSampleDate').disabled = false;
        if ($("#hdnPageType").val() != "B2C") {
            document.getElementById('txtSampleTime11').disabled = false;
            document.getElementById('txtSampleTime22').disabled = false;
            document.getElementById('ddlSampleTimeType1').disabled = false;
        }
    }
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
    //document.getElementById('billPart_btnAdd').disabled = true;
    if (document.getElementById('billPart_hdfBillType1').value == '')
        document.getElementById('billPart_spanAddItems').style.display = "block";
    if (document.getElementById('billPart_hdfBillType1').value != '')
        document.getElementById('billPart_spanAddItems').style.display = "none";

    document.getElementById('billPart_UcHistory_hdnHistoryIds').value = '';
}
/* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
function btnDeleteBillingItems_OnClick1(sEditedData) {
    /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
    $('#hdnIsDOBMandatoryconfig').val("N");
    /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
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
    document.getElementById('billPart_hdfBillType1').value = PaymenttempDatas;
    /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
    var a = 0, b = 0;
    var _Mainlistarr = new Array();
    var _subarr = new Array();
    var _parentarr = new Array();
    var _childarr = new Array();
    var configvalue = "N";
    _Mainlistarr = $('#billPart_hdfBillType1').val().split('|');
    if (_Mainlistarr.length > 0) {
        for (a = 0; a < _Mainlistarr.length - 1; a++) {
            _subarr = _Mainlistarr[a].split('~');
            if (_subarr.length > 0 && _subarr != "") {
                //37 is hot coded for IsDOBMandatory index
                for (b = 0; b < _subarr.length; b++) {
                    _parentarr = _subarr[b].split('^');
                    if (_parentarr.length > 0) {
                        if (_parentarr[0] == "IsDOBMandatory" && _parentarr[1] != "N") {
                            configvalue = _parentarr[1];
                        }
                    }
                }


            }

        }
    }
    $('#hdnIsDOBMandatoryconfig').val(configvalue);
    /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
    //$('[id$="hdfBillType1"]').val(PaymenttempDatas);
    CreateBillItemsTable(0);
    DeleteAmountValue(0, 0, 0);
    ClearPaymentControlEvents();
    if (document.getElementById('billPart_hdfBillType1').value == '') {
        document.getElementById('txtSampleDate').disabled = false;
        if ($("#hdnPageType").val() != "B2C") {
    document.getElementById('txtSampleTime11').disabled  = false;
    document.getElementById('txtSampleTime22').disabled  = false;
      document.getElementById('ddlSampleTimeType1').disabled  = false;
        }
    }
    var GrossAmt = document.getElementById('billPart_hdnGrossValue').value;
    if (GrossAmt < 0) {
        defaultbillflag = 0;
    }
    SetGrossValue(GrossAmt);
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

    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    // Payment mode currency disable based on config value //
    if (document.getElementById('billPart_PaymentType_hdnNeedCurrConv').value == "N") {
        document.getElementById('billPart_PaymentType_ddCurrency').disabled = true;
    }
    else {
        document.getElementById('billPart_PaymentType_ddCurrency').disabled = false;
    }
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
}
//sabari comments:Global flag IsDOBMandatoryconfig set after delete
/* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
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

    document.getElementById('hdnSelectedClientTempDetails').value = eventArgs.get_value();
    //    ShowClientDetails();
    //    TbClientlist();
    $find('AutoCompleteExtenderClientCorp')._onMethodComplete = function(result, context) {
        //var Perphysicianname = document.getElementById('txtperphy').value;
        $find('AutoCompleteExtenderClientCorp')._update(context, result, /* cacheResults */false);
        if (result == "") {
            alert('Please select client from the list');
            document.getElementById('txtClient').value = "";
            document.getElementById("hdnIsCashClient").value = 'N';
        }
    };

}
function GetTempReferingHospID(source, eventArgs) {
    $find('AutoCompleteExtenderReferringHospital')._onMethodComplete = function(result, context) {
        //var Perphysicianname = document.getElementById('txtperphy').value;
        $find('AutoCompleteExtenderReferringHospital')._update(context, result, /* cacheResults */false);
        if (result == "") {
            alert('Please select hospital from the list');
            $('[id$="txtReferringHospital"]').val("");
        }
    };

}


function ValidateValidPhysician(id) {
    var RphID = "";
    var RphText = 0;
    RphID = document.getElementById('hdnReferedPhyID').value;
    RphText = document.getElementById(id).value;
    var pConfigValue = document.getElementById('hdnRefDrConfig').value;
    if (pConfigValue != "Y") {
        if (parseInt(RphID) == 0 && RphText != "") {
            alert('Please select Refering physician from the list');
            $('[id$="txtInternalExternalPhysician"]').val("");
            $('[id$="txtInternalExternalPhysician"]').focus();
            $('[id$="DivRefDrDetails"]').hide();
            return false;
        }
    }

}

function PhysicianTempSelected(source, eventArgs) {
    var pConfigValue = document.getElementById('hdnRefDrConfig').value;
    $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
        //var Perphysicianname = document.getElementById('txtperphy').value;
        $find('AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
        if (result == "") {
            if (pConfigValue != "Y") {
                alert('Please select Refering physician from the list');
                $('[id$="txtInternalExternalPhysician"]').val("");
                $('[id$="DivRefDrDetails"]').hide();
            }
        }
    };
    var XAddressDetails = "";
    XAddressDetails = eventArgs.get_value().split('^');
    if (XAddressDetails != "") {
        SetDataintoPopUP(XAddressDetails);
        $('[id$="DivRefDrDetails"]').show();
    }
    else {
        $('[id$="DivRefDrDetails"]').hide();
    }
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
    if (($("#txtClient").val() == "" || $("#billPart_hdnHasClientHealthcoupon").val() == "Y") && $("#hdnPageType").val() == "B2C" && $("#billPart_hdnHasMyCard").val() == "Y") {
        document.getElementById("billPart_dvHealhcard").style.display = "block";
        $("#billPart_hdnIsCashClient").val("Y");
        $("#billPart_hdnHasClientHealthcoupon").val("Y");
        CheckMyCard();

    }
    else {
        document.getElementById("billPart_dvHealhcard").style.display = "none";
        CheckMyCard();
    }
    if (document.getElementById('txtClient').value == '') {
        /* BEGIN |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */
        var clientAlert = document.getElementById('hdnB2CClientAlert').value == undefined ? "N" : "Y";
        if (clientAlert == 'Y') {
          
            if (document.getElementById('hdnB2CClientAlert').value == "Y") {
            document.getElementById('hdnSelectedClientClientID').value = '';
            }
            else {
                document.getElementById('hdnSelectedClientClientID').value = 0;
            }
        }
        else {
            /* END |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */;
            document.getElementById('hdnSelectedClientClientID').value = 0;
            /* BEGIN |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */
        }
        /* END |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */
        var ddlobj = document.getElementById("ddlRate");
        ddlobj.options.length = 0;
        var opt1 = document.createElement("option");
        document.getElementById("ddlRate").options.add(opt1);
        opt1.text = "---Select---";
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
    DisplayCoPayMent();
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

    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    //     var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(4) / parseFloat(pCurrAmount).toFixed(2)).toFixed(4);
    //    var pTotalNetAmt = pNetAmount;
    var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(4) * parseFloat(pCurrAmount).toFixed(4)).toFixed(4);
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
    document.getElementById('billPart_PaymentType_hdnConvertedAmount').value = pTotalNetAmt;
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
        var iscashh = document.getElementById('hdnIsCashClient').value;
        if (iscashh != "N") {
        document.getElementById("billPart_" + "OtherCurrencyDisplay1_tbAmountPayble").style.display = "table-row";
        document.getElementById("billPart_" + "trOtherCurrency").style.display = "table-row";
        }
        else {
            document.getElementById("billPart_" + "OtherCurrencyDisplay1_tbAmountPayble").style.display = "none";
            document.getElementById("billPart_" + "trOtherCurrency").style.display = "none";
        }
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
    if (document.getElementById(msId).value == '6' || document.getElementById(msId).value == '7' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '19' || document.getElementById(msId).value == '20') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '2' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '11' || document.getElementById(msId).value == '15') {
        document.getElementById(sexId).value = 'F';
    }
    else if (document.getElementById(msId).value == '14') {
    }
    else {
        if (Type != 'ddlgender') {
            document.getElementById(sexId).value = '0'
        }
    }
    if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4') {
        document.getElementById(ddMaritalID).value = 'S';
    }
    else if (document.getElementById(msId).value == '3') {
        if (document.getElementById(ddMaritalID) != null) {
            document.getElementById(ddMaritalID).value = 'M';
        }
    }
    else if ((document.getElementById(msId).value == '7')) {
        document.getElementById(ddMaritalID).value = '0';
    }

    var Gender = document.getElementById(sexId).value;
    document.getElementById('hdnGender').value = Gender;

}
function setSalutationValueQBLab(sexId, msId, ddMaritalID, Type) {
    //    if (document.getElementById(sexId).value == 'M') {
    //        document.getElementById(msId).value = '7';
    //    }
    //    else if (document.getElementById(sexId).value == 'F') {
    //        document.getElementById(msId).value = '2';
    //    }
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
    if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12') {
        document.getElementById(sexId).value = 'M';
    }
    else if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') {
        document.getElementById(sexId).value = 'F';
    }

    var Gender = document.getElementById(sexId).value;
    document.getElementById('hdnGender').value = Gender;
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

    if (result == "") {
        document.getElementById('billPart_alert').innerHTML = 'This Services would not been available for this Client (or) it would be a Gender based test.';
    }
    else {
        document.getElementById('billPart_alert').innerHTML = "";
    }
}
function ClearDOB() {
    if (document.getElementById('billPart_hdnValidation') != null) {
        document.getElementById('billPart_hdnValidation').value = 'Y';
    }
    if (document.getElementById('txtDOBNos').value < 0) {
        document.getElementById('txtDOBNos').value = '';
    }
    if (document.getElementById('txtDOBNos').value >= 150) {
        alert('Provide a valid year');
        document.getElementById('tDOB').value = "dd//MM//yyyy";
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('txtDOBNos').focus();
        return false;
    }
    var valAge = 105;
    var valage1 = 95;
    var AGE = document.getElementById('txtDOBNos').value;
    if (AGE >= valAge) {
        alert('Age Should not be Greater than 105');
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('tDOB').value = "dd//MM//yyyy";
        return false;
    }
    else if (AGE >= valage1 && AGE <= valAge) {
        var Userval = confirm('Age is Greater than 95 Do You want to continue');
    }
}
function FindDuplicatesItemsdofrom(finddofrom) {
    //debugger;
    var dup = document.getElementById('billPart_hdnfinddofrom').value.split('^');
    var beforedup = finddofrom.split('^');
    if (dup.length > 1) {
        for (k = 0; k < dup.length; k++) {
            for (l = 0; l < beforedup.length; l++) {
                if (dup[k] != "") {
                    if (dup[k] != 'undefined') {
                        if (dup[k].split('~')[0] == beforedup[l].split('~')[0]) {
                            //var Userval = false;
                            if ((dup[k].split('~')[3] == 'INV' || beforedup[l].split('~')[3] == 'INV') || ((dup[k].split('~')[0] == beforedup[l].split('~')[0]) || (dup[k].split('~')[1] == beforedup[l].split('~')[1]) && (dup[k].split('~')[3] == 'GRP' && beforedup[l].split('~')[3] == 'GRP'))
                         || ((dup[k].split('~')[1] == beforedup[l].split('~')[1]) && (dup[k].split('~')[3] == 'PKG' && beforedup[l].split('~')[3] == 'PKG'))) {
                                alert("Selected test is already available as a part of ordered test. You can't order again");
                                //DeleteFindduplicatcatsItems(dup[k].split('~')[1]);
                                document.getElementById('billPart_hdnfinduplicate').value = "";
                                ClearSelectedData();
                                document.getElementById('billPart_spanAddItems').style.display = "none";
                                return false;
                            }
                            //                            else {
                            //                                var Userval = confirm('Selected test is already available as a part of ordered test.Do you want to proceed ?')
                            //                                if (Userval) { document.getElementById('billPart_hdnfinduplicate').value += finddofrom; }
                            //                                else { document.getElementById('billPart_hdnfinduplicate').value += finddofrom; DeleteFindduplicatcatsItems(dup[k].split('~')[1]); ClearSelectedData(); }
                            //                            }
                            //var Userval = confirm('This Test is already available as a part of Ordered Package / Group.Do you want to proceed ?')
                            //if (Userval) { document.getElementById('billPart_hdnfinduplicate').value += setvar; }
                            //else { document.getElementById('billPart_hdnfinduplicate').value += setvar; DeleteFindduplicatcatsItems(dup[i].split('~')[1]); ClearSelectedData(); }
                            //return Userval;
                        }
                    }
                }

            }
        }

    }
    return true;

}
var retVal = true;
function DuplicateInv(Id, Type) {
    var FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;
    var boolval = true;
    var flagdifsample = true;
    var FeeGotValue = new Array();
    var setvar = "";
    if (document.getElementById('billPart_hdnfinduplicate').value != '') {
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
    var Tatreferencedatetime = document.getElementById('billPart_hdnTATProcessDateTime').value;
    var Tatsamplereceiptdatetime = document.getElementById('billPart_hdnTATSampleReceiptDateTime').value;
    var Tatprocessstartdatetime = document.getElementById('billPart_hdnTATProcessStartDateTime').value;

    var Logistictimeinmins = document.getElementById('billPart_hdnTATLogisticTimeasmins').value;
    var Processingtimeinmins = document.getElementById('billPart_hdnTATProcessinghoursasmins').value;
    var Labendtime = document.getElementById('billPart_hdnTATLabendTime').value;
    var Earlyreporttime = document.getElementById('billPart_hdnTATEarlyReportTime').value;
    var Tatreferencedatebase = document.getElementById('billPart_hdnTatreferencedatebase').value;

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
    var MaxDiscount = document.getElementById('billPart_hdnMaxDiscount').value;
    var IsNormalRateCard = document.getElementById('billPart_hdnIsNormalRateCard').value;
    var IsRedeem = document.getElementById('billPart_hdnIsRedeem').value;
    var RedeemAmount = document.getElementById('billPart_hdnRedeemAmount').value;
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    var ItemCurrencyID = document.getElementById('billPart_hdnItemCurrencyID').value;
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency
    /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
    var IsDOBMandatory = $('#billPart_hdnIsDOBMandatory').val();
    /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
    var BillReceiptTagText = $('#billPart_hdnBillReceiptTagText').val();
    var LstTestAdded = {};
    var oTestAdded = [];
    var IsSampleContainerMatch = 0;
    if (document.getElementById('hdnDoFrmVisit').value != "") {
        if (document.getElementById('hdnSampleforPrevious').value != '') {
            var lstSampleContainer = JSON.parse($('input[id$="hdnSampleforPrevious"]').val());
        }
    }

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
            var lstContainerCount = [];
            var isExists = false;
            $.each(Items, function(index, Item) {
                isExists = false;
                document.getElementById('billPart_hdnfinduplicate').value += Item.InvestigationID + '~' + Item.InvestigationValueID + '~' +
		        Item.InvestigationName + '~' + Type + '^';
                $.each(lstContainerCount, function(i, obj) {
                    if (obj.SampleCode == Item.SampleCode && obj.SampleContainerID == Item.SampleContainerID) {
                        isExists = true;
                        return false;
                    }
                });
                if (!isExists) {
                    lstContainerCount.push({
                        SampleCode: Item.SampleCode,
                        SampleContainerID: Item.SampleContainerID
                    });
                }
            });
            if (document.getElementById('hdnDoFrmVisit').value != "") {
                if (document.getElementById('hdnSampleforPrevious').value != '') {
                    for (i = 0; i < SampleCount; i++) {
                        for (j = 0; j < lstContainerCount.length; j++) {
                            if (lstSampleContainer[i].SampleCode == lstContainerCount[j].SampleCode) {
                                if (lstSampleContainer[i].SampleContainerID == lstContainerCount[j].SampleContainerID) {
                                    IsSampleContainerMatch++;
                                }
                            }
                        }
                    }
                    if (lstContainerCount.length > IsSampleContainerMatch) {
                        alert("This Test's Sample & Container doesn't Match with Previous Items");
                        flagdifsample = false;
                        document.getElementById('billPart_txtTestName').value = '';
                        document.getElementById('billPart_txtTestName').focus();
                        document.getElementById('billPart_hdnfinduplicate').value = '';
                    }
                }
            }

            if (setvar != "") {
                retVal = FindDuplicatesItems(setvar);
            }
        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }

    });
    var retdofrom = true;
    if (document.getElementById('hdnDoFrmVisit').value > "0") {
        var FeeType = document.getElementById('billPart_hdnFeeTypeSelected').value;
        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetItemsFromDoVisit",
            data: "{ 'VisitID': '" + parseInt(document.getElementById('hdnDoFrmVisit').value) + "','OrgID': '" + document.getElementById('hdnOrgID').value + "','Type': '" + FeeType + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                var ArrayItems = data.d;
                var i = 0;
                document.getElementById('billPart_hdnfinddofrom').value = '';
                $.each(ArrayItems, function(index, Item) {

                    //  alert(Item.InvestigationID);
                    document.getElementById('billPart_hdnfinddofrom').value += Item.InvestigationID + '~' + Item.InvestigationValueID + '~' +
		            Item.InvestigationName + '~' + Item.Name + '^';


                });
                var finddofrom = document.getElementById('billPart_hdnfinduplicate').value;
                retdofrom = FindDuplicatesItemsdofrom(finddofrom);

            }
        });


    }
//    if (document.getElementById('hdnDoFrmVisit').value != "") {
//        if (document.getElementById('hdnSampleforPrevious').value != '') {
//            if (document.getElementById('hdnDOFromVisitFlag').value == "0" || document.getElementById('hdnDOFromVisitFlag').value == "1") {
//                if (IsSampleContainerMatch == '0') {
//                    alert("This Test's Sample & Container doesn't Match with Previous Items");
//                    return false;
//                }
//            }
//        }
//        
//    }
    if (Descrip != '' && retVal == true && retdofrom == true && flagdifsample == true) {
        if (Number(Amount) <= 0) {
            if (document.getElementById('billPart_ZeroAmount').value == 'Y') {
                alert("Item amount is zero.Kindly Mapped Rate for the Item...");
                return false;
            }
            else {
                var pBill = confirm("Item amount is zero.\n Do you want to add this item");
                pBill = false;
            }
            if (pBill) {
                //	   BEGIN | 459 | Arun M | 20160303 | A | Multicurrency
                /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
                CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsNormalRateCard, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID, DiscountCategoryCode, ReportDeliveryDate, MaxDiscount, IsRedeem, RedeemAmount, ItemCurrencyID, Tatreferencedatetime, Tatsamplereceiptdatetime, Tatprocessstartdatetime, Logistictimeinmins, Processingtimeinmins, Labendtime, Earlyreporttime, Tatreferencedatebase, IsDOBMandatory,BillReceiptTagText);
                /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
                //	   END | 459 | Arun M | 20160303 | A | Multicurrency  
                document.getElementById('billPart_lblInvType').innerHTML = "";
            } else {
                document.getElementById('billPart_txtTestName').value = '';
                document.getElementById('billPart_txtTestName').focus();
            }
        }
        else {
            //	   BEGIN | 459 | Arun M | 20160303 | A | Multicurrency
            /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
            CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsNormalRateCard, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID, DiscountCategoryCode, ReportDeliveryDate, MaxDiscount, IsRedeem, RedeemAmount, ItemCurrencyID, Tatreferencedatetime, Tatsamplereceiptdatetime, Tatprocessstartdatetime, Logistictimeinmins, Processingtimeinmins, Labendtime, Earlyreporttime, Tatreferencedatebase, IsDOBMandatory,BillReceiptTagText);
            /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
            //	   END | 459 | Arun M | 20160303 | A | Multicurrency  
            document.getElementById('billPart_lblInvType').innerHTML = "";
        }
    }
}
function FindDuplicatesItems(setvar) {
    var dup = document.getElementById('billPart_hdnfinduplicate').value.split('^');
    var beforedup = setvar.split('^');
    if (dup.length > 1) {
        for (i = 0; i < dup.length; i++) {
            for (j = 0; j < beforedup.length; j++) {
                if (dup[i] != "") {
                    if (dup[i].split('~')[0] == beforedup[j].split('~')[0]) {
                        var Userval = false;
                        if ((dup[i].split('~')[3] == 'INV' || beforedup[j].split('~')[3] == 'INV') || ((dup[i].split('~')[1] == beforedup[j].split('~')[1]) && (dup[i].split('~')[3] == 'GRP' && beforedup[j].split('~')[3] == 'GRP'))
                         || ((dup[i].split('~')[1] == beforedup[j].split('~')[1]) && (dup[i].split('~')[3] == 'PKG' && beforedup[j].split('~')[3] == 'PKG'))) {
                            alert("Selected test is already available as a part of ordered test. You can't order again");
                            DeleteFindduplicatcatsItems(dup[i].split('~')[1]);
                            ClearSelectedData();
                        }
                        else {
                            var Userval = confirm('Selected test is already available as a part of ordered test.Do you want to proceed ?')
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

}

function clearControls() {
    /* BEGIN |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */
    var clientAlert = document.getElementById('hdnB2CClientAlert').value == undefined ? "N" : "Y";
    if (clientAlert == 'Y') {
        if (document.getElementById('hdnB2CClientAlert').value == "Y") {
        document.getElementById('hdnBaseClientID').value = '';
        document.getElementById('hdnSelectedClientClientID').value = '';
        }
    }
    /* END |  | RAJKUMAR G | 20180717 | A | B2C Client Code Alert  */;
    document.getElementById('txtName').value = "";
    document.getElementById('txtDOBNos').value = "";
    document.getElementById('tDOB').value = "";
  document.getElementById('txtSampleDate').disabled  = false;
    document.getElementById('txtSampleTime11').disabled  = false;
    document.getElementById('txtSampleTime22').disabled  = false;
      document.getElementById('ddlSampleTimeType1').disabled  = false;
    document.getElementById('txtPhleboName').value = "";
    document.getElementById('txtLogistics').value = "";
    document.getElementById('txtRoundNo').value = "";
    document.getElementById('chkExcludeAutoathz').checked = false;
    document.getElementById('HdnPhleboName').value = "";
    document.getElementById('hdnLogisticsName').value = "";
    document.getElementById('hdnLogisticsID').value = "";
    document.getElementById('HdnPhleboID').value = "";
    document.getElementById('hdnEdtLogisticsID').value = "";
    document.getElementById('hdnEdtPhleboID').value = "";
    document.getElementById('txtSuburban').value = "";
    document.getElementById('txtAddress').value = "";
    document.getElementById('txtCity').value = "";
    document.getElementById('txtPincode').value = "";
    document.getElementById('txtURNo').value = "";
    document.getElementById('txtReferringHospital').value = "";
    document.getElementById('txtInternalExternalPhysician').value = "";
    document.getElementById('txtWardNo').value = "";
    document.getElementById('txtExternalPatientNumber').value = "";
    document.getElementById('txtSampleDate').value = "";
    document.getElementById('txtLocClient').value = "";

    //document.getElementById('chkboxPrintQuotation').checked = false;
    CheckAll();
    document.getElementById('hdnLogisticsName').value = "";
    document.getElementById('tDOB').value = "";
    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
    // The below lines commented by moorthy, bcoz hdnClientPortal hidden control has used in B2B page, but the control clearing here too.
//    if (document.getElementById('hdnClientPortal').value != 'Y') {
//        if (document.getElementById('hdnLocationclient').value != 'Y') {
//            document.getElementById('txtzone').value = "";
//            document.getElementById('hdnZoneID').value = 0;
//        }
    //    }
    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
    document.getElementById('txtDoFrmVisitNumber').value = "";
    document.getElementById('hdnDoFrmVisit').value = 0;
    document.getElementById('ShowBillingItems').style.display = "none";
    document.getElementById('txtMobileNumber').value = "";
    document.getElementById('txtPhone').value = "";
    document.getElementById('txtEmail').value = "";
}
function ClearReadOnlyPropertys() {
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
        $("[name='txtSampleDate']").prop("disabled", false);
        $("[name='txtSampleTime11']").prop("disabled", false);
        $("[name='txtSampleTime22']").prop("disabled", false);
        $("[name='ddlSampleTimeType1']").prop("disabled", false);



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
        if (document.getElementById('hdnClientPortal').value != 'Y') {
            if (document.getElementById('hdnLocationClient').value != 'Y') {
                $("[name='txtClient']").prop("disabled", false);
                $("[name='txtzone']").prop("disabled", false);
            }
        }
        $("[name='tDOB']").prop("disabled", false);

        $('[id$="chkDespatchMode"] input[type=checkbox]').each(function() {

            $('[id$="chkDespatchMode"]').prop('disabled', false);

        });
        var panelLegend = $('#PnlPatientDetail legend');
        panelLegend.html("Patient Details");
        $('[id$="chkDespatchMode"] input[type=checkbox]:checked').each(function() {
            $('[id$="chkDespatchMode"] input[type=checkbox]:checked').attr('checked', false);
        });
    });
}
function clearClientControls() {
  document.getElementById('txtSampleDate').disabled  = false;
    document.getElementById('txtSampleTime11').disabled  = false;
    document.getElementById('txtSampleTime22').disabled  = false;
      document.getElementById('ddlSampleTimeType1').disabled  = false;
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
   // document.getElementById('txtSampleDate').value = "";
    document.getElementById('trRollingAdvance').style.display = "none";
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
function CheckAll() {
    //var chkbx = document.getElementById("CheckBox2");
    var chkbxList = document.getElementById("chkDisPatchType");
    if (chkbxList != null) {
        var Count = chkbxList.document.getElementById("chkDisPatchType");
        var chkbxListCount = Count.getElementsByTagName('input');
        // var chkbxListCount = chkbxList.getElementsByTagName('input');
        if (chkbxList.checked == true) {

            for (var i = 0; i < chkbxListCount.length; i++) {
                chkbxListCount[i].checked = true;
            }
        }
        else {
            for (var i = 0; i < chkbxListCount.length; i++) {
                chkbxListCount[i].checked = false;
            }
        }
        var chkbxList1 = document.getElementById("chkDespatchMode");
        var Count1 = chkbxList1.document.getElementById("chkDespatchMode");
        var chkbxListCount1 = Count1.getElementsByTagName('input');
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
function PrintBillItemsTable(bookingid) {
    $('[id$="divItemTable"]').val("");
    var startHeaderTag, newPaymentTables, startPaymentTag, endPaymentTag, taxDetailsTag;
    var FeeViewStateValue = $('[id$="hdfBillType1"]').val();
    startHeaderTag = "<table width='100%' class='dataheaderInvCtrl'><tr><td colspan='3'>";
    startHeaderTag = startHeaderTag + "<h3 align='center'><u>Service Quotation</u></h3>";
    startHeaderTag = startHeaderTag + "</td></tr><tr><td colspan='3'> </td></tr><tr><td colspan='3'></td></tr><tr><td colspan='3'>"
    startHeaderTag = startHeaderTag + "</td></tr><tr><td>"
    startHeaderTag = startHeaderTag + "Service Quotation Number:<b>" + bookingid + "</b></td></tr><tr><td>"
    startHeaderTag = startHeaderTag + "Patient Name: " + $('[id$="txtName"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + "Sex: " + $('[id$="ddlSex"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + "Age: " + $('[id$="txtDOBNos"]').val() + ' ' + $('[id$="ddlDOBDWMY"]').val();
    startHeaderTag = startHeaderTag + "</td></tr><tr><td>"
    startHeaderTag = startHeaderTag + "Mobile Number: " + $('[id$="txtMobileNumber"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + "Telephone: " + $('[id$="txtPhone"]').val();
    startHeaderTag = startHeaderTag + "</td><td>"
    startHeaderTag = startHeaderTag + "Email: " + $('[id$="txtEmail"]').val();
    startHeaderTag = startHeaderTag + "</td></tr><tr><td colspan='3'> </td></tr><tr><td colspan='3'></td></tr><tr><td colspan='3'>"
    startHeaderTag = startHeaderTag + "</td></tr><tr><td align='left' colspan='3'>"
    startHeaderTag = startHeaderTag + "<b>Client Name:</b> " + $('[id$="txtClient"]').val();
    startHeaderTag = startHeaderTag + "</td></tr><tr><td colspan='3'> </td></tr><tr><td colspan='3'></td></tr><tr><td colspan='3'>"
    startPaymentTag = "<TABLE nowrap='nowrap' ID='tabDrg1' Cellpadding='0' Cellspacing='0' border='1' width='100%' class='dataheaderInvCtrl' style='font-size: 12px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> FeeID </th><th scope='col'  style='width:5%;display:none;'> FeeType </th> <th scope='col' style='width:7%;'> S.No </th><th scope='col' align='left' style='width:65%;padding-left:2px;'> Description </th>  <th scope='col' align='right' style='display:none;width:5%;'>  Quantity </th><th scope='col' align='right' style='width:8%;'> Amount </th> <th scope='col' style='width:20%;padding-left:2px;display:none;'>Remarks </th> <th scope='col' style='align:right;width:27%;display:none;'> Report Date </th> <th scope='col' style='display:none;'> IsReimbursable </th><th scope='col' style='display:none;'> ActualAmount </th><th scope='col' style='display:none;'> IsDiscountable </th><th scope='col' style='display:none;'> IsTaxable </th><th scope='col' style='display:none;'> IsRepeatable </th><th scope='col' style='display:none;'> IsSTAT </th><th scope='col' style='display:none;'> IsSMS </th><th scope='col' style='display:none;'> IsOutSource </th><th scope='col' style='display:none;'> IsNABL </th><th scope='col' style='display:none;'> BillingItemRateID </th><th scope='col' style='display:none;'> HasHistory </th>"; // <th scope='col' align='center'>Delete</th></tr>";
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
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblRoundOffAmt').innerHTML + " </b></td><td>" + $('#billPart_hdnRoundOff').val() + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td> </td><td>---------</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblNetValue').innerHTML + " </b></td><td>" + document.getElementById('billPart_hdnNetAmount').value + "</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td> </td><td>---------</td></tr>";
    newPaymentTables = newPaymentTables + "<tr><td colspan='3' align='right'>";
    newPaymentTables = newPaymentTables + "Quote Given By: " + $('[id$="hdnQuotesGivenBy"]').val();
    newPaymentTables = newPaymentTables + "</td></tr><tr><td colspan='3' align='right'>"
    newPaymentTables = newPaymentTables + "Quote Date: " + $('[id$="hdnQuotesDate"]').val();
    newPaymentTables = newPaymentTables + "</table></td></tr></table>"
    document.getElementById('lblPrintCCBillDetail').innerHTML += startHeaderTag + newPaymentTables;
    //    $('[id$="hdnDiscountableTestTotal"]').val(DiscountableTestAmount);
    //    $('[id$="hdnTaxableTestToal"]').val(TaxableTestAmount);
    ClearSelectedData();


    SetGrossValue(GrossAmt)
    SetOtherCurrValues();

}


function AddHistory() {
    var arrGotValue = new Array();
    var invList = document.getElementById('billPart_hdnInvHistory').value == '' ? 0 : document.getElementById('billPart_hdnInvHistory').value;

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
                        alert(arrGotValue);
                        //                        ID = arrGotValue[0];
                        //                        name = arrGotValue[1].trim();
                        //                        feeType = arrGotValue[2];

                    }
                }
            }
            else {
                alert(' you cannot add History  for this item');

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
    alert(id);
    alert(id);


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
    document.getElementById('billPart_UcHistory_tblAtt').style.display = "block";
    document.getElementById('billPart_UcHistory_tblBtnAtt').style.display = "block";
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
                document.getElementById('billPart_Butsave').style.display = "block";
                document.getElementById('billPart_UcHistory_tblMain').style.display = "block";
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
                        //	   BEGIN | 8291 | Malathi.P | 20171110 | A | Capture Histroy 
                        cell1.innerHTML = "<input type='checkbox' id='" + ChkID + "' runat='server'  onclick='javascript:SetCheckboxIndex(this.id);' />";
                        cell2.innerHTML = "<b>" + arrayHistoryData[iMain].split('~')[2] + "</b>";

                        var arrayHistryDataType = arrayHistoryData[iMain].split('~')[11];
                        var validationField = new Array();
                        if (arrayHistryDataType.indexOf(":") !== -1) {

                            validationField = arrayHistryDataType.split(':');
                        }

                        if (validationField[0] == "DATE") {
                            var ddmmyyyy = "ddmmyyyy";
                            var arrow = "DROPDOWN";
                            var tru = false;
                            var twele = "12";
                            var Yes = "N";

                            var cell3 = row.insertCell(2);
                            var cell4 = row.insertCell(3);
                            var cell5 = row.insertCell(4);
                            var cell6 = row.insertCell(5);

                            if (validationField[1] == "PAST") {
                                cell3.innerHTML = '<input   id="' + TxtID + '" type="text" maxlength="25" title="DataType : dd-MM-yyyy" ToolTip="dd-MM-yyyy" onkeypress="return validateDate(event,this.id)" onblur="javascript:CheckValidateDate(this.id);SetCheckingCheckBox(this.id);chkdate(this.id);" onfocus ="javascript:SetCheckingCheckBox(this.id);" onchange="javascript:chkdate(this.id);CheckValidateDate(this.id);"/>';
                                cell4.innerHTML = '<a  href="javascript:SetCheckingCheckBoxForDatetextBox(' + "'" + TxtID + "'" + ');NewCssCal(' + "'" + TxtID + "'" + ',' + "'" + ddmmyyyy + "'" + ',' + "'" + arrow + "'" + ',' + tru + ',' + "'" + twele + "'" + ',' + "'" + Yes + "'" + ',' + "'" + Yes + "'" + ',' + "'" + 2 + "'" + ');"  tabindex="-1"> <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date" />';
                                cell5.innerHTML = "<input type='hidden' runat='server' id='" + HdnID1 + "'  value='" + HdnID + "' />"
                                cell6.innerHTML = "<input type='hidden' runat='server' id='" + HdnID2 + "'  value='" + HdnID + "' />"
                            }


                        }
                        else if (arrayHistoryData[iMain].split('~')[11] == "NUMERIC") {
                            var cell3 = row.insertCell(2);
                            var cell4 = row.insertCell(3);
                            var cell5 = row.insertCell(4);

                            cell3.innerHTML = '<input   id="' + TxtID + '" type="text" title="DataType : Number"  onkeypress="return validateNum(event,this.id)" onblur="javascript:SetCheckingCheckBox(this.id);CheckNumeric(this.id);" onchange="javascript:CheckNumeric(this.id);"  />';
                            cell4.innerHTML = "<input type='hidden' runat='server' id='" + HdnID1 + "'  value='" + HdnID + "' />"
                            cell5.innerHTML = "<input type='hidden' runat='server' id='" + HdnID2 + "'  value='" + HdnID + "' />"
                        }
                        else {
                            var cell3 = row.insertCell(2);
                            var cell4 = row.insertCell(3);
                            var cell5 = row.insertCell(4);

                            cell3.innerHTML = "<input type='text' id='" + TxtID + "'  runat='server' onblur='javascript:SetCheckingCheckBox(this.id);'  title='DataType : Alphanumeric' />";
                            cell4.innerHTML = "<input type='hidden' runat='server' id='" + HdnID1 + "'  value='" + HdnID + "' />"
                            cell5.innerHTML = "<input type='hidden' runat='server' id='" + HdnID2 + "'  value='" + HdnID + "' />"
                        }

                        //	   End | 8291 | Malathi.P | 20171110 | A | Capture Histroy

                        document.getElementById('billPart_UcHistory_hdnHistoryIds').value += arrayHistoryData[iMain].split('~')[1] + "^";

                    }
                    document.getElementById('billPart_UcHistory_tblDynamicControls').style.display = 'block';
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
    document.getElementById('billPart_Butsave').style.display = "block";
    GetConfig();
}

//	   BEGIN | 8291 | Malathi.P | 20171110 | A | Capture Histroy
function CheckValidateDate(id) {
    dateValue = document.getElementById(id).value;
    if (dateValue !== "" || dateValue !== "undefined") {
        var fieldValue = document.getElementById(id).value;
        var SplitingChar;
        if (fieldValue.indexOf("-") !== -1) {
            SplitingChar = '-';
        }
        else if (fieldValue.indexOf("/") !== -1) {
            SplitingChar = '/';
        }
        
        
        var date = document.getElementById(id).value.split(SplitingChar);
        
        
   // var date = document.getElementById(id).value;
    //if (date != '') {
       // var dateSplit = date.split('-');
        var calday = date[0];
        var calmon = date[1];
        var calyear = date[2];
//        
//        var today = new Date();
//        alert(new Date(calyear, calmon + 1, 0));

        var lastday = new Date(calyear, calmon, 0).getDate();

        if (calday > lastday) {
            alert("Selected month last day is" + lastday);
            document.getElementById(id).value = "";
            var TextID;
            TextID = id.replace('_txt', '_chk');
            document.getElementById(TextID).checked = false;
            return false;
        }
        if (calmon > 12) {
            alert("Enter  valid month");
            document.getElementById(id).value = "";
            var TextID;
            TextID = id.replace('_txt', '_chk');
            document.getElementById(TextID).checked = false;
            return false;
        }
    }
}

function CheckNumeric(id) {
    var value = document.getElementById(id).value.trim();
    if (value != null && value != "") {
        var matchedPosition = value.search(/[a-z]/i);
        if (matchedPosition != -1) {
            alert('Value not numeric');
            document.getElementById(id).value = "";
            var TextID;
            TextID = id.replace('_txt', '_chk');
            document.getElementById(TextID).checked = false;
        }
    }
}

function chkdate(id) {
    var Date = document.getElementById(id).value.trim();
    if (Date != null && Date != "") {
        var matches = /^(\d{2})[-\/](\d{2})[-\/](\d{4})$/.exec(Date);
        if (matches == null) {
            alert("Date Format wrong");
            document.getElementById(id).value = "";
            var TextID;
            TextID = id.replace('_txt', '_chk');
            document.getElementById(TextID).checked = false;
            return false;
        }
    }
    CheckCurrentYear(id);
    return true;
}

function CheckCurrentYear(id) {
    if (document.getElementById(id).value !== '') {
        var fieldValue = document.getElementById(id).value;
        var SplitingChar;
        if (fieldValue.indexOf("-") !== -1) {
            SplitingChar = '-';
        }
        else if (fieldValue.indexOf("/") !== -1) {
            SplitingChar = '/';
        }
        var StartYear = 1900;
        
        var DOB = document.getElementById(id).value.split(SplitingChar);
        var calday = DOB[0];
        var calmon = DOB[1];
        var calyear = DOB[2];

        var dateObj = new Date();
        var curday = dateObj.getDate();
        var curmon = dateObj.getMonth() + 1;
        var curyear = dateObj.getFullYear();

        if (parseFloat(calyear) > parseFloat(curyear) || parseFloat(calyear) < StartYear) {
            alert("Enter year less than current year");
            document.getElementById(id).value = "";
        }
        else if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) > parseFloat(curmon)) {
            alert("Enter month less than current month");
            document.getElementById(id).value = "";
        }
        else if (parseFloat(calyear) == parseFloat(curyear) && parseFloat(calmon) == parseFloat(curmon) && parseFloat(calday) > parseFloat(curday)) {
            alert("Enter date less than current date");
            document.getElementById(id).value = "";
        }
    }
}

function validateDate(key, id) {
    //debugger;
    //getting key code of pressed key
    var keycode = (key.which) ? key.which : key.keyCode;
    var phn = document.getElementById(id);
    //comparing pressed keycodes
    if (!(keycode == 8 || keycode == 47 || keycode == 45 || keycode == 46) && (keycode < 48 || keycode > 57)) {
        return false;
    }
}

function validateNum(key, id) {
    //debugger;
    //getting key code of pressed key
    var keycode = (key.which) ? key.which : key.keyCode;
    var phn = document.getElementById(id);
    //comparing pressed keycodes
    if (!(keycode == 8 || keycode == 46) && (keycode < 48 || keycode > 57)) {
        return false;
    }
}


function SetCheckingCheckBoxForDatetextBox(id) {
    // if (document.getElementById(id).value != "") {
    var TextID;
    TextID = id.replace('_txt', '_chk');
    document.getElementById(TextID).checked = true;
    // }

}

//	   END | 8291 | Malathi.P | 20171110 | A | Capture Histroy 

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

                document.getElementById('billPart_UcHistory_tblMain').style.display = "block";

                if (arrayHistoryData[iMain].split('~')[1] == 1097) {
                    if (document.getElementById('billPart_UcHistory_chkLMP').checked == true) {
                        if (document.getElementById('billPart_UcHistory_txtLMP').value == "__/__/____" || document.getElementById('billPart_UcHistory_txtLMP').value == "") {
                            alert('Please Select LMP Date !!!');
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
        startHeaderTag += "<TR class='dataheader1'><th  scope='col' style='width:5%;display:none;'>HistoryID </th><th  scope='col' style='width:2%;'>S.No </th><th scope='col' style='width:5%;'> History Name </th> <th style='width:5%;'> Values </th></TR>"

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
        startHeaderTag += "<TR class='dataheader1'><th  scope='col' style='width:5%;display:none;'>Slno </th><th  scope='col' style='width:1%;'>S.No </th><th scope='col' style='width:5%;'> Patient Preference </th></TR>"

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
               // newPaymentTables += "<TD style='padding-left:5px' align='left'>" + AttributeValueName + "</TD>"
                newPaymentTables += "<TD style='padding-left:5px' align='left'><div style='display:block;width:670px;word-wrap:break-word;'>" + AttributeValueName + "</div></TD>"
                newPaymentTables += "</TR>";
            }

        }
        newPaymentTables += endTag;
        document.getElementById('billPart_UcHistory_tblpatientPreferenceview').innerHTML = newPaymentTables;



    }
    if (document.getElementById('billPart_hdnHistoryTableLists').value != '') {
        startHeaderTag = "<table width='50%'  border='1px;' cellpadding='0' cellspacing='0'>";
        startHeaderTag += "<TR class='dataheader1'><th  scope='col' style='width:5%;display:none;'>Slno </th><th  scope='col' style='width:1%;'>S.No </th><th scope='col' style='width:5%;'>Background Problem </th><th style='width:3%;'> Values </th></TR>"

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
    return true;

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
    document.getElementById('billPart_UcHistory_tblMain').style.display = "block";
    document.getElementById('billPart_Butsave').style.display = "block";
    document.getElementById('billPart_ButPrint').style.display = "none";
    document.getElementById('billPart_ButEdit').style.display = "none";
    document.getElementById('billPart_UcHistory_tblhistoryview').innerHTML = "";



}
function getQueryStrings() {
    //Holds key:value pairs
    var queryStringColl = null;

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
    document.getElementById('billPart_UcHistory_tblMain').style.display = "block";
    document.getElementById('billPart_Butsave').style.display = "block";
    document.getElementById('billPart_ButPrint').style.display = "none";
    document.getElementById('billPart_ButEdit').style.display = "none";
    document.getElementById('billPart_UcHistory_tblhistoryview').innerHTML = "";
    document.getElementById('billPart_UcHistory_tblbackgroundProbview').innerHTML = "";
    document.getElementById('billPart_UcHistory_tblpatientPreferenceview').innerHTML = "";
    if ((document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML != "")
    || (document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').innerHTML != "")) {
        if (document.getElementById('trBackground_Problem_Patient_Preference') != null) {
            document.getElementById('trBackground_Problem_Patient_Preference').style.display = "block";
        }
    }
    else {
        if (document.getElementById('trBackground_Problem_Patient_Preference') != null) {
            document.getElementById('trBackground_Problem_Patient_Preference').style.display = "none";
        }
    }


}


function SelectedClientPatient(source, eventArgs) {

    var isPatientDetails = "";
    isPatientDetails = eventArgs.get_value().split('|')[0];

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
    //SABARI ADDED: B2B MOBILE VALIDATION ALERT PURPOSE IN TEST ADD TIME
    if (PatientMobile == 0) {

        PatientMobile = "";
    }
    //
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
    var AdvanceClient = isPatientDetails.split('~')[49];
    var AssignedDoctorid = isPatientDetails.split('~')[50];
    var AssignedDoctor = isPatientDetails.split('~')[51];
    /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
    var _IsAutoDOB = isPatientDetails.split('~')[52] == 1 ? "Y" : "N";
    /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
   

    document.getElementById('txtLogistics').value = LogisticsName;
    document.getElementById('hdnLogisticsName').value = LogisticsName;
    document.getElementById('txtRoundNo').value = RoundNo;
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

    //arjun assigned doctor VIP
    document.getElementById('ddlPatientStatus').value = PatientStatus;
    document.getElementById('txtAssignDoctor').value = AssignedDoctor;
    document.getElementById('hdnAssignDrid').value = AssignedDoctorid;
    if (document.getElementById('ddlPatientStatus').value == 'VIP') {
        document.getElementById('tdAssignDoctor').style.display = "block";
        document.getElementById('tdlblAssignDoctor').style.display = "block";
    }
    else {
        document.getElementById('tdAssignDoctor').style.display = "none";
        document.getElementById('tdlblAssignDoctor').style.display = "none";
        document.getElementById('txtAssignDoctor').value = "";
        document.getElementById('hdnAssignDrid').value = 0;
    }
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

    document.getElementById('ddSalutation').value = PatientTITLECode
    document.getElementById('txtName').value = PatientName;
    document.getElementById('hdnPatientNumber').value = PatientNumber
    document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
    document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
    document.getElementById('ddlSex').value = PatientSex;
    $("#chkIncomplete").attr("disabled", true);
    $("#ddlUnknownFlag").attr("disabled", true);
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
    if (document.getElementById('hdnClientPortal').value != 'Y') {
        if (document.getElementById('txtClient') != null) {
            document.getElementById('txtClient').focus();
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
    panelLegend.html("Patient Details ").append('<b>(Patient No: ' + PatientNumber + ' )</b>');
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

    if (AdvanceClient == 1) {
        CheckIsAdvanceClient(ClientID);
    }

    /* Malathi | Terminated Clients can be bill in Do From */ 
    B2BDoFromClientSelected(ClientID)
    /* Malathi | Terminated Clients can be bill in Do From  */

    EnabledFalse();
    /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
    $('#hdnIsDOBMandatoryDOBFlag').val("");
    $('#hdnIsDOBMandatoryAgeFlag').val("");
    if (_IsAutoDOB == "Y") {
        $('#hdnIsDOBMandatoryDOBFlag').val("Y");
        $('#hdnIsDOBMandatoryAgeFlag').val("N");

    }
    else {
        $('#hdnIsDOBMandatoryDOBFlag').val("N");
        $('#hdnIsDOBMandatoryAgeFlag').val("Y");
    }
    /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
    
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
                        document.getElementById('hdnSampleforPrevious').value += Item.SampleCode + '$' + Item.SampleContainerID + '^';
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
                    document.getElementById('tdVisitType1').style.display = "table-cell";
                    document.getElementById('tdVisitType2').style.display = "table-cell";
                    var NewOrgID = document.getElementById('hdnNewOrgID').value;
                    //                    document.getElementById('tdSex1').style.width = '10%';
                    //                    document.getElementById('tdSex2').style.width = '18%';
                }
                /* BEGIN | NA | Vijay | 20171114 | Created | VIP Workflow  */
                document.getElementById('tdVisitType1').style.display = "none";
                document.getElementById('tdVisitType2').style.display = "none";
                /* END | NA | Vijay | 20171114 | Created | VIP Workflow  */
            }

        }
        tblTotal += "<tr><td colspan='5' style='display:table-cell;' align='center'><input id='adds' type='button' value='Add' class='btn' onclick='javascript:AddPreviousVisitItemsToBilling();' ></td></tr>";
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
    document.getElementById('tDOB').value = "dd//MM//yyyy";
}
function GetSelectedValue() {
    var ddlDiscountReason = document.getElementById("billPart_ddlDiscountReason");
    var DiscountReasonValue = ddlDiscountReason.options[ddlDiscountReason.selectedIndex].value;
    var DiscountReasonText = ddlDiscountReason.options[ddlDiscountReason.selectedIndex].text;
    document.getElementById("billPart_hdnDiscountReason").value = DiscountReasonValue + '~' + DiscountReasonText;
}

function GetSlab(DiscountId) {

    document.getElementById("billPart_ddlDiscountType").options.length = 0;
    document.getElementById("billPart_ddlDiscountReason").options.length = "";
    document.getElementById("billPart_ddlSlab").options.length = 0;
    var ddlDiscountType = document.getElementById("billPart_ddlDiscountType");
    var ddlSlab = document.getElementById("billPart_ddlSlab");
    var optn = document.createElement("option");
    ddlSlab.options.add(optn);
    optn.text = "--Select--";
    optn.value = "0";
    var ddlDiscountReason = document.getElementById("billPart_ddlDiscountReason");
    var optn = document.createElement("option");
    ddlDiscountReason.options.add(optn);
    optn.text = "--Select--";
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
		    /* BEGIN | 549 |Arun.M | 28042016 */
                    if (lstSlab[0].DiscountAuthorityID != 0) {
                        document.getElementById('billPart_txtAuthorised').value = lstSlab[0].AuthorityName;
                        document.getElementById('billPart_hdnDiscountApprovedBy').value = lstSlab[0].DiscountAuthorityID;
                    }
                    else {
                        document.getElementById('billPart_txtAuthorised').value = '';
                        document.getElementById('billPart_hdnDiscountApprovedBy').value = '0';
                    }
		    /* END | 549 |Arun.M | 28042016 */
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
                        /*BEGIN | 73 | Thiyagu | 20160503 | M | The value come from db is either Foc or FOC */
                        if (DiscountType == 'Foc' || DiscountType == 'FOC') {
                            /*End | 73 | Thiyagu | 20160503 */
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
                                        opt.text = lstSlab[i].Slab + '%';
                                        opt.value = lstSlab[i].Slab + '~' + lstSlab[i].Code + '~' + lstSlab[i].Ceiling;
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
                                        document.getElementById('billPart_hdnCeilingValue').value = lstSlab[i].Ceiling + '~' + lstSlab[i].Code;
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
                    ItemLevelAmount = ((ItemAmount * ItemDiscountPercent) / 100).toFixed(2);
                    ItemLevelDiscount = ((ItemAmount * OtherOrgDisPer) / 100).toFixed(2);
                    FinalItemDisPercentage = OtherOrgDisPer;
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
                if (parseFloat(document.getElementById('billPart_txtGross').value) > parseFloat(Math.round(TotalDiscountAmount).toFixed(2)))
                    document.getElementById('billPart_txtDiscount').value = Math.round(TotalDiscountAmount).toFixed(2);
                else
                    document.getElementById('billPart_txtDiscount').value = document.getElementById('billPart_txtGross').value;
 /*BEGIN | 73 | Thiyagu | 20160503 | A | When we Change the discount Type as Value then the value of discount by default should be zero, when the value is filled then only the discount will be change*/
                if (document.getElementById('billPart_ddDiscountPercent').value == 0) {
                    $('#billPart_txtDiscount').val(0);               
                 }
/*End |73|Thiyagu|20160903*/
            }
        }
    }
}
var Type;
var CardType;
function GetMemberDetails(Type, CardType) {
   
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
        success: function(data) {

            if (data.d.length > 0) {
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
            alert("Health coupon card Amount is zero.");
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
        alert('Please provide the card number');
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

    $('#billPart_lblOtpStatus').text('');
    var UserEnterOtp = $('#billPart_txtOTP').val().trim();
    var GeneratedOtp = $('#billPart_hdnOtpExist').val().trim();
    if (GeneratedOtp != "" && UserEnterOtp != "") {
        if (UserEnterOtp == GeneratedOtp) {
            $('#trOtpVerifyStatus').css("display", "");
            GetMemberDetails('OTP', '');
            $('#billPart_lblOtpStatus').text('Your OTP is verified,You can continue billing');
            $('#billPart_lblOtpStatus').css("color", "Green");

        }
        else {
            $('#trOtpVerifyStatus').css("display", "")
            $('#billPart_lblOtpStatus').text('Your OTP is InValid');
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
                alert('You are not eligible to redeem points');

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
   // document.getElementById('billPart_txtAuthorised').value = '';
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


/***New Function for Calculating Age using DOB***/
/***Added By : Sathish.E ***/
/***Date : 14 July 2015 ***/

function NewCalculateAge(birthday, PageType) {
    //debugger; 

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
                var diff = Date.UTC(curyear, curmon - 1, curday, 0, 0, 0) - Date.UTC(calyear, calmon - 1, calday, 0, 0, 0);
                var dife = datediff(cald, curd);
                var splitAge = dife.split(':');
                var lAge = splitAge[0];
                var drpAge = splitAge[1];

                document.getElementById('txtDOBNos').value = lAge;
                document.getElementById('ddlDOBDWMY').value = drpAge;
                /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
                $('#hdnIsDOBMandatoryDOBFlag').val("Y");
                $('#hdnIsDOBMandatoryAgeFlag').val("N");
                /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
            }
        }
    }
    var valAge = 105;
    var valage1 = 95;
    var AGE = document.getElementById('txtDOBNos').value;
    if (AGE >= valAge) {
        alert('Age Should not be Greater than 105');
        result_empty();
    }
    else if (AGE >= valage1 && AGE <= valAge) {
        var Userval = confirm('Age is Greater than 95 Do You want to continue');
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

function AddBillingTestItemsDetails() {
 
    var FeeID1 = document.getElementById('billPart_hdnID').value;
    var FeeType1 = document.getElementById('billPart_hdnFeeTypeSelected').value;
    var arrGotValue = new Array();
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
        url: "../OPIPBilling.asmx/GetBillingTestItemsDetails",
        data: JSON.stringify({ OrgID: document.getElementById('billPart_hdnOrgIDC').value, FeeID: document.getElementById('billPart_hdnID').value, FeeType: document.getElementById('billPart_hdnFeeTypeSelected').value, Description: document.getElementById('billPart_txtTestName').value, ClientID: $('[id$="hdnSelectedClientClientID"]').val(), VisitID: 0, Remarks: '', IsCollected: document.getElementById('billPart_hdnIsCollected').value, CollectedDatetime: document.getElementById('billPart_hdnCollectedDateTime').value, locationName: document.getElementById('billPart_hdnLocName').value }),
        dataType: "json",
        success: function(data) {
            if (data.d.length > 0) {
                for (var i = 0; i < data.d.length; i++) {
                    //  arrGotValue = data.d[0].ProcedureName.split('^');
                    //  if (arrGotValue.length > 0) {
                    ID = data.d[i].ID;
                    name = data.d[i].Descrip.trim();
                    feeType = data.d[i].FeeType;
                    if (document.getElementById('billPart_txtVariableRate').value == "") {
                        amount = data.d[i].Amount;
                    } else {
                        amount = document.getElementById('billPart_txtVariableRate').value;
                    }
                    Remarks = data.d[i].Remarks;
                    isReimursable = data.d[i].IsReimursable;
                    ReportDate = data.d[i].ReportDate;
                    ActualAmount = data.d[i].ActualAmount;
                    IsDiscountable = data.d[i].IsDiscountable;
                    IsTaxable = data.d[i].IsTaxable;
                    IsRepeatable = data.d[i].IsRepeatable;
                    IsSTAT = data.d[i].IsSTAT;
                    IsSMS = data.d[i].IsSMS;
                    IsNABL = data.d[i].IsNABL;
                    RateID = data.d[i].RateID;
                    HasHistory = data.d[i].HasHistory;
                    ProcessingLoc = data.d[i].ProcessingLoc;
                    BaseRateID = data.d[i].BaseRateID;
                    DiscountPolicyID = data.d[i].DiscountPolicyID;
                    DiscountCategoryCode = data.d[i].DiscountCategoryCode;
                    ReportDeliveryDate = data.d[i].ReportDeliveryDate;
                    MaxDiscount = data.d[i].MaxDiscount;
                    IsNormalRateCard = data.d[i].IsNormalRateCard;
                    IsRedeem = data.d[i].IsRedeem;
                    RedeemAmount = data.d[i].RedeemAmount;
                    IsHistoryMandatory = data.d[i].IsHistoryMandatory;
                    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
                    ItemCurrencyID = data.d[i].CurrencyID;

	//	   END | 459 | Arun M | 20160303 | A | Multicurrency  
 TATProcessDateType = data.d[i].TATProcessDateType;

                    Tatreferencedatetime = data.d[i].Tatreferencedatetime;
                    Tatsamplereceiptdatetime = data.d[i].Tatsamplereceiptdatetime;
                    Tatprocessstartdatetime = data.d[i].Tatprocessstartdatetime;
                    //Added by Thiyagu For additional TAT Columns
                    Logistictimeinmins = data.d[i].Logistictimeinmins;
                    Processingtimeinmins = data.d[i].Processingtimeinmins;
                    Labendtime = data.d[i].Labendtime;
                    Earlyreporttime = data.d[i].Earlyreporttime;
                    Tatreferencedatebase = data.d[i].Tatreferencedatebase;
                    //End by Thiyagu
                    /* BEGIN | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW Add  */
                    IsDOBMandatory = data.d[i].IsDOBMandatory;
                    FlagIsDOBMandatory = data.d[i].IsDOBMandatory == 1 ? "Y" : "N";
                    //$('#hdnIsDOBMandatoryconfig').val(FlagIsDOBMandatory);
                    if (FlagIsDOBMandatory == "Y") {
                        if (FlagIsDOBMandatory == "Y" && $('#hdnIsDOBMandatoryDOBFlag').val() == "N" && $('#hdnIsDOBMandatoryAgeFlag').val() == "Y") {
                            alert("Date of Birth is mandatory to proceed");
                            return false;
                        }
                        //FOR INCOMPLETE REGIDTRATION:NOT CHOOSE AGE AND DOB DOB ALAERT NEEDED FOR DOB MAPPED TEST
                        if ($("#chkIncomplete").is(":checked") != undefined && $("#chkIncomplete").is(":checked") != null && $("#chkIncomplete").is(":checked") != false) {
                            if (document.getElementById('chkIncomplete').checked == true && FlagIsDOBMandatory == "Y") {
                                if (FlagIsDOBMandatory == "Y" && $('#hdnIsDOBMandatoryDOBFlag').val() == "N" && $('#hdnIsDOBMandatoryAgeFlag').val() == "N") {
                                    alert("Date of Birth is mandatory to proceed");
                                    return false;
                                }
                            }
                        }

                    }
                    $('#billPart_hdnIsDOBMandatory').val(FlagIsDOBMandatory);  //used for local varibal to build table
                    /* END | NA | Sabari | 20171010 | Created | IsDOBMandatory WORKFLOW END  */
                    document.getElementById('hdnTatprocess').value = TATProcessDateType;
                    if (document.getElementById('hdnTatprocess').value == "3" && (document.getElementById('billPart_hdnCollectedDateTime').value == "01/01/1900" || document.getElementById('billPart_hdnCollectedDateTime').value == "01-01-1900 07:00AM")) {
                        alert("Kindly Select Sample Pickup Date");
                        return false;
                    }
                    BillReceiptTagText = data.d[i].BillReceiptTagText;
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
                    //document.getElementById('billPart_btnAdd').disabled = false;

                    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency
                    document.getElementById('billPart_hdnTATProcessDateTime').value = Tatreferencedatetime;
                    document.getElementById('billPart_hdnTATSampleReceiptDateTime').value = Tatsamplereceiptdatetime;
                    document.getElementById('billPart_hdnTATProcessStartDateTime').value = Tatprocessstartdatetime;
                    document.getElementById('billPart_hdnBillPaymentCurrency').value = ItemCurrencyID;
                    document.getElementById('billPart_hdnItemCurrencyID').value = ItemCurrencyID.split('~')[0];
                    document.getElementById('hdnIsRoundOffClient').value = ItemCurrencyID.split('~')[2];

                    //	   END | 459 | Arun M | 20160806 | A | Multicurrency

                    //Added by Thiyagu For additional TAT Columns
                    document.getElementById('billPart_hdnTATLogisticTimeasmins').value = Logistictimeinmins;
                    document.getElementById('billPart_hdnTATProcessinghoursasmins').value = Processingtimeinmins;
                    document.getElementById('billPart_hdnTATLabendTime').value = Labendtime;
                    document.getElementById('billPart_hdnTATEarlyReportTime').value = Earlyreporttime;
                    document.getElementById('billPart_hdnTatreferencedatebase').value = Tatreferencedatebase;
                    document.getElementById('billPart_hdnBillReceiptTagText').value = BillReceiptTagText;
                    //End by Thiyagu

                    var FeeID = document.getElementById('billPart_hdnID').value;
                    var FeeType = document.getElementById('billPart_hdnFeeTypeSelected').value;

                    DuplicateInv(FeeID, FeeType);
                    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
                    PaymentCurrencyLoad();
                    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
                    // }
                }
            }
            else {
                DuplicateInv(FeeID, FeeType);
                //alert('Item Amount is Zero, you cannot add this item for billing');
                document.getElementById('billPart_txtTestName').value = '';
                document.getElementById('billPart_txtTestName').focus();
            }
        },
        error: function(result) {
            alert("Select the ClientName From List");
        }
    });
}

function AddTestItems() {
    // For Co-Payment //
    
var UPageName = document.getElementById('billPart_hdnBPartPageName').value;
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
        var ddlCopaymentType = document.getElementById('uctlClientTpa_ddlCopaymentType').value;
        var txtCoperent = parseFloat(document.getElementById('uctlClientTpa_txtCoperent').value);
        //if (document.getElementById('HdnCoPay').value == 'Y') {
        if (ddlCopaymentType == 0) {
            alert('Select Co-Payment type');
            document.getElementById('uctlClientTpa_ddlCopaymentType').focus();
            return false;
        }
        if (txtCoperent < 0.00) {
            alert('Enter Co-Payment Value');
            document.getElementById('uctlClientTpa_txtCoperent').focus();
            return false;
        }
        //}
    }
    // For Co-Payment  end//
    //praba changes
    if (($('#txtName').val() != undefined && $.trim($('#txtName').val()) == '') && UPageName!='Service') {
        alert('Provide patient name');
        $('#txtName').focus();
        return false;
    }
    if ($('#txtExternalVisitID').val() != undefined && $.trim($('#txtExternalVisitID').val()) == '') {
        alert('Provide External VisitID');
        $('#txtExternalVisitID').focus();
        return false;
    }

    if (document.getElementById('txtPhleboName') != null && document.getElementById('HdnPhleboID') != null) {
        if ($('#txtPhleboName').val() != "" && document.getElementById('HdnPhleboID').value == "") {
            alert('Please select Phlebotomist Name from list');
            $('#txtPhleboName').val("");
            document.getElementById('txtPhleboName').focus();
            return false;
        }
    }
    if (document.getElementById('HdnPhleboID') != null && document.getElementById('hdnPageType') != null) {
        if (document.getElementById('HdnPhleboID').value == "" && $("#hdnPageType").val() == "B2C") {
            alert('Please select Phlebotomist Name');
            $('#txtPhleboName').val("");
            document.getElementById('txtPhleboName').focus();
            return false;
        }
    }
    var mobileNo_val = document.getElementById('txtMobileNumber').value;
    var Mob_Length = mobileNo_val.length;
    if (mobileNo_val != '' && mobileNo_val.length < 7) {
        alert('Please Enter Valid Mobile Number.');
        document.getElementById('txtMobileNumber').focus();
        return false;
    }
    if (mobileNo_val != '') {
        var _Repeatingcount = fn_RepeatingSequence(mobileNo_val, Mob_Length);
        if (_Repeatingcount == 1) {
            alert('Please Enter Valid Mobile Number.');
            document.getElementById('txtMobileNumber').focus();
            return false;
        }


    }
    if (document.getElementById('hdnDoFrmVisit').value != "") {
        if (document.getElementById('hdnDOFromVisitFlag').value == "0") {
            if (document.getElementById('chkIncomplete').checked != true) {
	    //sabari added
                if ((document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy')) || (document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy')) {
                    alert('Provide patient age or date of birth');
                    document.getElementById('txtDOBNos').focus();
                    return false;
                }
                if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
                    if (document.getElementById('ddlSex').disabled != true) {
                        alert('Select patient sex');
                        document.getElementById('ddlSex').focus();
                        return false;
                    }
                }
            }
        }
    }
    else {
    //praba changes
    //sabari added
        if ((document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy')) && UPageName != 'Service' || (document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy')) {
            alert('Provide patient age or date of birth');
            document.getElementById('txtDOBNos').focus();
            return false;
        }
        if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
            if (document.getElementById('ddlSex').disabled != true) {
                alert('Select patient sex');
                document.getElementById('ddlSex').focus();
                return false;
            }
        }
    }
    //if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '') {
    //  alert('Provide contact mobile or telephone number');
    // $('#txtMobileNumber').focus();
    // return false;
    // }

    if (document.getElementById('hdnDoFrmVisit').value == "") {
        if (document.getElementById('txtPhleboName') != null) {
            if (document.getElementById('txtPhleboName').value.trim() == "") {
                alert('Select Phlebetomist Name');
                document.getElementById('txtPhleboName').focus();
                return false;
            }
        }
    }

    if (document.getElementById('txtClient').value == '') {
        if (document.getElementById('billPart_hdnIsClientBilling').value == 'Y') {
            alert('Provide Client Name');
            document.getElementById('txtClient').focus();
            return false;
        }
    }
    else {
    }

    var IsCopayClient = 'N';
    if (document.getElementById('HdnCoPay') != null) {
        IsCopayClient = document.getElementById('HdnCoPay').value;
    }
    if (document.getElementById('hdnIsCashClient') != null) {
        if ((document.getElementById('hdnIsCashClient').value == "N" && IsCopayClient == "N") || $('#hdnAdvanceClient').val() == "1") {
            document.getElementById('billPart_PaymentType_txtAmount').disabled = true;
        }
        else {
            document.getElementById('billPart_PaymentType_txtAmount').disabled = false;
        }
    }

    if (document.getElementById('hdnvalidatepickupdate').value == "1") {
        alert(" sample pick update is should be less than 48 hours and not be a future date.");
        return false;
    }
    if (document.getElementById('billPart_txtTestName').value.trim() == "") {
        alert('Search test names')
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
        AddBillingTestItemsDetails();
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
    //Mulitple Currency Cocncept
    isOtherCurrDisplay1("N");
    document.getElementById('billPart_PaymentType_hdnOtherCurrencyRate').value = "1.0000";
    document.getElementById("billPart_OtherCurrencyDisplay1_lblOtherCurrRecdAmount").innerHTML = parseFloat(0.00).toFixed(2);
    document.getElementById("billPart_OtherCurrencyDisplay1_hdnOterCurrReceived").value = parseFloat(0.00).toFixed(2);


}


function PaymentCurrencyLoad() {
    //    if (document.getElementById('txtClient').value == "") {
    var IsCashClient = document.getElementById('hdnIsCashClient').value;
    var ItemCurrencyID = document.getElementById('billPart_hdnBillPaymentCurrency').value;
    document.getElementById('billPart_PaymentType_hdnOtherCurrencyRate').value = "1.0000";
    document.getElementById('billPart_PaymentType_hdnSelectedClientCurrency').value = ItemCurrencyID;
    $('#billPart_PaymentType_ddCurrency').val(ItemCurrencyID.split('~')[0]+'~'+ItemCurrencyID.split('~')[1]);
    var ClientCurrencyID = document.getElementById('billPart_PaymentType_hdnSelectedClientCurrency').value.split('~')[0];
    if ((ClientCurrencyID != undefined) && (ClientCurrencyID != "0")) {
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/GetCurrencyConvertedAmount",
            data: "{ 'baseCurrencyID': '" + ClientCurrencyID + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                //debugger;
                var Items = [];
                Items = data.d;
                if (Items != undefined) {
                    _Validation = 1;

                    document.getElementById('billPart_PaymentType_hdnCurrencyExchangeValue').value = JSON.stringify(Items);

                }
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }
        });
    }
    var NeedCurrConv = document.getElementById('billPart_PaymentType_hdnNeedCurrConv').value;
    if ((NeedCurrConv == "N") || (IsCashClient == "N")) {
        document.getElementById("billPart_PaymentType_ddCurrency").disabled = true;
    }
    else {
        document.getElementById("billPart_PaymentType_ddCurrency").disabled = false;
    }
    //    }
}

function CheckIsAdvanceClient(clientid) {
    var ClientID = clientid;
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/GetB2BClientDetailsForBilling",
        contentType: "application/json; charset=utf-8",
        data: "{ ClientID: '" + ClientID + "'}",
        dataType: "json",
        async: true,
        success: CheckIsAdvanceClientSucceeded,
        error: function(xhr, ajaxOptions, thrownError) {
            alert("Error while Fetching the client details");
            return false;
        }
    });

}
function CheckIsAdvanceClientSucceeded(result) {

    var CollectionID = 0;
    var tabledata = result.d;
    if (tabledata.length > 0) {

        var list = tabledata[0].Value.split('^');
        var slist = tabledata[0].Value.split('###');

        var hdnAdvanceClient = 0;
        if (slist.length > 0) {
            for (j = 0; j < slist.length - 1; j++) {
                flist = slist[j].split('^');
                var rat = flist[4].split('~');
                if (j == 0) {
                    TotalDepositAmount = flist[25];
                    TotalDepositUsed = flist[26];
                    AmtRefund = flist[27];
                    CollectionID = flist[24];                    
                    hdnAdvanceClient = flist[34];
                    //Begin|  20180703 | Malathi.P | Rolling Advance Issue
                    IsCashClient = flist[17];
                    document.getElementById('hdnIsCashClient').value = IsCashClient;
                    document.getElementById('billPart_txtDiscountReason').value = '0.00';
                    ToTargetFormat($("#billPart_txtDiscountReason"));
                    //End| 20180703 | Malathi.P | Rolling Advance Issue
                }
            }
        }
        if (hdnAdvanceClient == "1") {
            document.getElementById('trRollingAdvance').style.display = "table-row";
            var deduction = parseInt(TotalDepositUsed) + parseInt(AmtRefund);

            $('#billPart_lblRollingBalAmt').html(TotalDepositAmount - deduction);

            /*AB Code*/
            $('[id$="hdnAdvanceClient"]').val(hdnAdvanceClient);
            document.getElementById('hdnCollectionID').value = CollectionID;
            var amount = $('#billPart_lblRollingBalAmt').text();

            if (amount <= 0) {
                alert('Client deposit balance amount is Zero');
                document.getElementById('txtClient').value = '';
                document.getElementById('txtClient').focus();
                document.getElementById('trRollingAdvance').style.display = "none";
                return false;
            }

        }
        else {
            document.getElementById('trRollingAdvance').style.display = "none";
        }
    }
}
function B2BClientSelectedByDefault(Clientidd) {

    var ClientID = Clientidd;

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/GetB2BClientDetailsForBilling",
        contentType: "application/json; charset=utf-8",
        data: "{ ClientID: '" + ClientID + "'}",
        dataType: "json",
        async: true,
        success: ClientDetailsGetFieldDataSucceeded,
        error: function(xhr, ajaxOptions, thrownError) {
            alert("Error while Fetching the client details");
            return false;
        }
    });
}

/* Malathi | Terminated Clients can be bill in Do From */ 
function B2BDoFromClientSelected(Clientiddd) {

    var ClientID = Clientiddd;

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/GetB2BClientDetailsForBilling",
        contentType: "application/json; charset=utf-8",
        data: "{ ClientID: '" + ClientID + "'}",
        dataType: "json",
        async: true,
        success: ClientDetailsGetFieldDataSucceeded,
        error: function(xhr, ajaxOptions, thrownError) {
            alert("Error while Fetching the client details");
            return false;
        }
    });
}
/* Malathi | Terminated Clients can be bill in Do From */ 

function B2BClientSelected(source, eventArgs) {
   
    var ClientID = eventArgs.get_value();
    
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/GetB2BClientDetailsForBilling",
        contentType: "application/json; charset=utf-8",
        data: "{ ClientID: '" + ClientID + "'}",
        dataType: "json",
        async: true,
        success: ClientDetailsGetFieldDataSucceeded,
        error: function(xhr, ajaxOptions, thrownError) {
            alert("Error while Fetching the client details");
            return false;
        }
    });
}
function ClientDetailsGetFieldDataSucceeded(result) {


    var tabledata = result.d;
    if (tabledata.length > 0) {

        var list = tabledata[0].Value.split('^');
        var slist = tabledata[0].Value.split('###');
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
        var VirtualCreditType = "";
        var VirtualCreditValue = 0;
        var MinimumAdvanceAmt = 0;
        var MaximumAdvanceAmt = 0;
        var hdnAdvanceClient = 0;
        var SAPLogicFlag = "";
        var SAPLogic = 0
        var ClientTaskStatus = "";
        //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
        var ItemCurrencyID = "";
        //	   END | 459 | Arun M | 20160806 | A | Multicurrency 
        if (slist.length > 0) {
            for (j = 0; j < slist.length - 1; j++) {
                flist = slist[j].split('^');
                var rat = flist[4].split('~');
                if (j == 0) {
                    var ClientID = flist[5];
                    var Amount = 0.00;
                    var flag = 0;
                    ClientStatus = flist[13].trim();
                    //Begin |shabiya|SAP
                    ClientTaskStatus = flist[39];
                    if (ClientTaskStatus == 'N') {
                        document.getElementById('txtClient').value = '';
                        document.getElementById('txtClient').focus();
                        alert("This Client is Ammended, Please contact Admin");
                        flag = 1;
                    }
                    if (ClientID != "0") {
                        $.ajax({
                            type: "POST",
                            url: "../WebService.asmx/GetClientCreditValue",
                            data: "{ 'ClientID': '" + ClientID + "','Amount': '" + Amount + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                
                               //debugger;

                                var Items = [];
                                Items = data.d;
                                if (Items != '') {
                                    var Status = Items[0].Status;
                                    var SAPLogicFlag = Items[0].SAPLogicFlag;
                                    var SAPLogic = Items[0].SAPLogic;
                                    if (SAPLogicFlag == 'CreditLimitExist' && Status == 'A' && SAPLogic == 1) {
                                        document.getElementById('txtClient').value = '';
                                        document.getElementById('txtClient').focus();
                                        alert("This Client Regitration Stopped");

                                        flag = 1;
                                    }
                                    else if (SAPLogicFlag == 'CreditLimitExist' && Status == 'A' && SAPLogic == 3) {
                                        document.getElementById('txtClient').value = '';
                                        document.getElementById('txtClient').focus();
                                        alert("This Client Regitration Stopped and Report Regitration also Stopped");
                                        flag = 1;

                                    }

                                }

                            },
                            failure: function (msg) {
                                ShowErrorMessage(msg);
                            }
                        });
                    }
                    //End |shabiya|SAP
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
                    VirtualCreditType = flist[30];
                    VirtualCreditValue = flist[31];
                    MinimumAdvanceAmt = flist[32];
                    MaximumAdvanceAmt = flist[33];
                    hdnAdvanceClient = flist[34];
                    //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
                    ItemCurrencyID = flist[36];
                    //	   END | 459 | Arun M | 20160806 | A | Multicurrency  
                    //BEGIN | 459 | Thiyagu S | 20162206 | A | Multicurrency
                   // document.getElementById('hdnIsRoundOffClient').value = flist[36];
                  //  document.getElementById('hdnRoundOffValue').value = flist[37];
                    //	   END | 459 | Thiyagu S | 20162206 | A | Multicurrency
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
      
        if (flag == 1) {
            return false;
	    }
        }
        if (hdnAdvanceClient == "1") {
            document.getElementById('trRollingAdvance').style.display = "table-row";
            var deduction = parseInt(TotalDepositUsed) + parseInt(AmtRefund);

            $('#billPart_lblRollingBalAmt').html(TotalDepositAmount - deduction);

            /*AB Code*/

            var amount = $('#billPart_lblRollingBalAmt').text();

            if (amount <= 0) {
                alert('Client deposit balance amount is Zero');
                document.getElementById('txtClient').value = '';
                document.getElementById('txtClient').focus();
                document.getElementById('trRollingAdvance').style.display = "none";
                return false;
            }

        }
        else {
            document.getElementById('trRollingAdvance').style.display = "none";
        }


        //Co payment//
        if (document.getElementById('HdnCoPay') != null) {
            document.getElementById('HdnCoPay').value = CoPayment;
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
        //if (document.getElementById('hdnSampleforPrevious').value != '') {
        //  document.getElementById('hdnValidateclient').value = ClientCorpClientID;
        //}

        //	   BEGIN | 459 | Arun M | 20160806 | A | Multicurrency  
        //The below lines added for multi currency concept.
        var NeedCurrConv = document.getElementById('billPart_PaymentType_hdnNeedCurrConv').value;
        if ((IsCashClient.trim() == "N") || (NeedCurrConv == "N")) {
            document.getElementById("billPart_PaymentType_ddCurrency").disabled = true;
        }
        else {
            document.getElementById("billPart_PaymentType_ddCurrency").disabled = false;
        }
        document.getElementById('billPart_PaymentType_hdnSelectedClientCurrency').value = ItemCurrencyID;
        $('#billPart_PaymentType_ddCurrency').val(ItemCurrencyID);
        var ClientCurrencyID = document.getElementById('billPart_PaymentType_hdnSelectedClientCurrency').value.split('~')[0];
        if ((ClientCurrencyID != undefined) && (ClientCurrencyID != "0")) {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetCurrencyConvertedAmount",
                data: "{ 'baseCurrencyID': '" + ClientCurrencyID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    //debugger;
                    var Items = [];
                    Items = data.d;
                    if (Items != undefined) {
                        _Validation = 1;

                        document.getElementById('billPart_PaymentType_hdnCurrencyExchangeValue').value = JSON.stringify(Items);

                    }
                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });
        }
        //	   END | 459 | Arun M | 20160806 | A | Multicurrency  


        $('[id$="hdnAdvanceClient"]').val(hdnAdvanceClient);
        document.getElementById('hdnSelectedClientMappingID').value = ClientCorpMappingID;
        document.getElementById('hdnIsCashClient').value = IsCashClient;
        document.getElementById('billPart_hdnIsCashClient').value = IsCashClient.trim();
        document.getElementById('billPart_hdnClientType').value = ClientType.trim();
        if (IsCashClient == "Y" && $('#hdnDemographicPhleboIDB2B').val() == -1) {
            document.getElementById('hdnDemographicPhleboIDB2B').value = "";
            document.getElementById('trSampleTRFPart').style.display = "table-row";
            $("#txtSampleDate").attr("disabled", true);
            $("#txtLogistics").attr("disabled", true);
            $("#txtRoundNo").attr("disabled", true);
            document.getElementById('imgCalc').parentElement = "";
            //  document.getElementById('HdnPhleboID').value = "";
        }
        else if (document.getElementById('HdnPhleboID') != null) {
        if (document.getElementById('HdnPhleboID').value == "-1") {
            /* Malathi | Terminated Clients can be bill in Do From */ 
              //document.getElementById('trSampleTRFPart').style.display = "none";
                if (document.getElementById('trSampleTRFPart') != undefined) {
                    document.getElementById('trSampleTRFPart').style.display = "none";
                }
             /* Malathi | Terminated Clients can be bill in Do From */ 
                $('#hdnDemographicPhleboIDB2B').val(document.getElementById('HdnPhleboID').value);
                $("#txtSampleDate").attr("enabled", true);
                $("#txtLogistics").attr("enabled", true);
                $("#txtRoundNo").attr("enabled", true);
            }
        }
        document.getElementById('billPart_hdnIsCashClient').value = IsCashClient.trim();
        document.getElementById('billPart_hdnClientType').value = ClientType.trim();
    
        var hdnClientValue = document.getElementById('hdnBillingPageType').value;
        if (hdnClientValue == "Client") {
            if (IsCashClient == "Y") {
                document.getElementById("billPart_" + "divPaymentType").style.display = "table-row";
                document.getElementById("billPart_" + "trAmountReceived").style.display = "table-row";
                document.getElementById("billPart_" + "tdPreviousDue").style.display = "table-cell";
            }
            else if (IsCashClient) {
                document.getElementById("billPart_" + "divPaymentType").style.display = "none";
                document.getElementById("billPart_" + "trAmountReceived").style.display = "none";
                document.getElementById("billPart_" + "tdPreviousDue").style.display = "none";
            }
        }


        document.getElementById('hdnCollectionID').value = CollectionID;
        document.getElementById('hdnTotalDepositAmount').value = TotalDepositAmount;
        document.getElementById('hdnTotalDepositUsed').value = TotalDepositUsed;
        if (document.getElementById('hdnAmtRefund') != null) {
            document.getElementById('hdnAmtRefund').value = AmtRefund;
        }
        document.getElementById('hdnThresholdType').value = ThresholdType;

        document.getElementById('hdnThresholdValue').value = ThresholdValue;
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
        // MultiCurrency Start
        var showalert = slist[1];
        if (showalert == "Y") {
            document.getElementById('txtClient').value = '';
            document.getElementById('txtClient').focus();
            alert("Please Contact Admin ratecard is not mapped for this Currency Type");

        }

        //Multicurrency End
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
}
function fn_RepeatingSequence(mobileNo_val, mobileNolength) {
    var _pStatus = 0;
    var _NumberCount = 0;
    var _NumValue = 0;
    var _PriviousNumValue = 0;
    var _SequenceCount = 1;
    var _i = 0;

    _NumberCount = mobileNolength;


    while (_i <= _NumberCount) {

        _NumValue = mobileNo_val.charAt(_i);


        if (_NumValue == _PriviousNumValue) {
            _SequenceCount = _SequenceCount + 1;
        }
        else {
            _SequenceCount = 0;
        }

        if (_SequenceCount == 4) {
            _pStatus = 1;
            break;


        }

        _PriviousNumValue = _NumValue;


        _i = _i + 1;

    }
    return _pStatus;
}