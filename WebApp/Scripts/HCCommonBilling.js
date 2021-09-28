//By Dhanaselvam to check Selected From Test Name Autocomplete

var AutoCompSelected = false;
var objAlert = "";
//
function clearBillPartValues() {
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
    document.getElementById('billPart_ddlTaxPercent').disabled = true
    document.getElementById('billPart_ddDiscountPercent').disabled = true
    document.getElementById('billPart_btnDiscountPercent').disabled = true
    document.getElementById('billPart_trOrderedItemsCount').style.display = "none";
    document.getElementById('billPart_chkEDCess').checked = false;
    document.getElementById('billPart_chkSHEDCess').checked = false;
    document.getElementById('billPart_txtRemarks').value = '';
    document.getElementById('billPart_hdnIsInvestigationAdded').value = '0';
    ClearPaymentControlEvents1();
    ClearControlValues();
    GetCurrencyValues();
    document.getElementById('billPart_divItemTable').innerHTML = "";
    defaultbillflag = 0
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

}


function SetDiscountAmt() {
    var DiscountType = "";
    var pDiscountPercent = document.getElementById('billPart_ddDiscountPercent');
    var DiscountPercent = pDiscountPercent.options[pDiscountPercent.selectedIndex].value;
    var DiscountPercentName = pDiscountPercent.options[pDiscountPercent.selectedIndex].Text;
    var SDiscountId = DiscountPercent.split('~');
    var DiscountId = SDiscountId[1];
    if (SDiscountId[3] != "") {
        DiscountType = SDiscountId[3];
    }

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

    if ($('#billPart_ddDiscountPercent option:selected').val() != 0) {
        document.getElementById('billPart_ddlDiscountType').disabled = false;
    }
    else if ($('#billPart_txtDiscount').val() > 0) {
    
        document.getElementById('billPart_ddlDiscountType').disabled = false;
    }
    else {
        document.getElementById('billPart_ddlDiscountType').disabled = true;
    }

    SetNetValue('ADD');
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
    if (document.getElementById('hdnAllowSplChar') != null) {
        if (document.getElementById('hdnAllowSplChar').value == 'Y') {
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || k == 44 || k == 40 || k == 64 || k == 41 || k == 47 || (k >= 48 && k <= 57));
        }


        else {
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || k == 44 || (k >= 48 && k <= 57));

        }
    }
}
function alphaSpl(e) {
 /** Including ", /" **/
    var k;
    document.all ? k = e.keyCode : k = e.which;
    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57) || k == 44 || k == 47);
}
function CheckBillItems() {
    if (Number(document.getElementById('billPart_hdnDiscountAmt').value) <= 0) {
        //alert('Provide discount for bill, then give approved by and reason');
        document.getElementById('billPart_txtAuthorised').disabled = true;
        //return false;
    }
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
            var pBill = confirm("Delete the Ordered Items then only you can Change.\n Do you want to delete the items, Press OK Else Cancel");
            if (pBill != true) {
                document.getElementById('billPart_txtTestName').focus();
                return false;
            }
            else {
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
            }
        }
    }
    else {
        return true;
    }
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

    document.getElementById('hdnSelectedClientMappingID').value = ClientCorpMappingID;
    document.getElementById('hdnIsCashClient').value = IsCashClient;
    document.getElementById('billPart_hdnIsCashClient').value = IsCashClient.trim();
    document.getElementById('billPart_hdnClientType').value = ClientType.trim();
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
    document.getElementById('billPart_hdnID').value = hdnID;
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
    }
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetBillingItemsDetails",
        data: JSON.stringify({ OrgID: document.getElementById('billPart_hdnOrgIDC').value, FeeID: document.getElementById('billPart_hdnID').value, FeeType: document.getElementById('billPart_hdnFeeTypeSelected').value,
        Description: document.getElementById('billPart_txtTestName').value, ClientID: $('[id$="hdnSelectedClientClientID"]').val(), VisitID: 0, Remarks: '', IsCollected: document.getElementById('billPart_hdnIsCollected').value, CollectedDatetime: document.getElementById('billPart_hdnCollectedDateTime').value, locationName: document.getElementById('billPart_hdnLocName').value, BookingID: 0   }),
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

                        IsHistoryMandatory = data.d[0].IsHistoryMandatory;

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
                        //document.getElementById('billPart_hdnIsHistoryMandatory').value = IsHistoryMandatory;
                        document.getElementById('billPart_hdnProcessingLoc').value = ProcessingLoc;
                        document.getElementById('billPart_hdnBaseRateID').value = BaseRateID;
                        document.getElementById('billPart_hdnDiscountPolicyID').value = DiscountPolicyID;
                        document.getElementById('billPart_hdnDiscountCategoryCode').value = DiscountCategoryCode;
                        document.getElementById('billPart_hdnDeliveryDate').value = ReportDeliveryDate;
                        //document.getElementById('billPart_btnAdd').disabled = false;
                        var FeeID = document.getElementById('billPart_hdnID').value;
                        var FeeType = document.getElementById('billPart_hdnFeeTypeSelected').value;
                        document.getElementById('hdnClientRateID').value = document.getElementById('billPart_hdnBillingItemRateID').value;

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
    } }
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
            if (!window.confirm('Patient with Same Name,age.Client with Same Tests are Already entered  Do You Want to continue ?')) {
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
    if ($('#txtName').val() != undefined && $.trim($('#txtName').val()) == '') {
        ValidationWindow('Provide patient name', 'Alert');
        $('#txtName').focus();
        return false;
    }
    if ($('#txtExternalVisitID').val() != undefined && $.trim($('#txtExternalVisitID').val()) == '') {
        ValidationWindow('Provide External VisitID', 'Alert');
        $('#txtExternalVisitID').focus();
        return false;
    }
    if (document.getElementById('hdnDoFrmVisit').value != "") {
        if (document.getElementById('hdnDOFromVisitFlag').value == "0") {
            if (document.getElementById('chkIncomplete').checked != true) {
                if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy')) {
                    ValidationWindow('Provide patient age or date of birth', 'Alert');
                    document.getElementById('txtDOBNos').focus();
                    return false;
                }
                if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
                    if (document.getElementById('ddlSex').disabled != true) {
                        ValidationWindow('Select Gender', 'Alert');
                        document.getElementById('ddlSex').focus();
                        return false;
                    }
                }
            }
        }
    }
    else {
        if (document.getElementById('txtDOBNos').value.trim() == '' && (document.getElementById('tDOB').value.trim() == '' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd/mm/yyyy' || document.getElementById('tDOB').value.trim().toLowerCase() == 'dd//mm//yyyy')) {
            ValidationWindow('Provide Age or Date of Birth', 'Alert');
            document.getElementById('txtDOBNos').focus();
            return false;
        }
        if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
            if (document.getElementById('ddlSex').disabled != true) {
                ValidationWindow('Select Gender', 'Alert');
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

    if (document.getElementById('txtClient').value == '') {
//        if (document.getElementById('billPart_hdnIsClientBilling').value == 'Y') {
            ValidationWindow('Provide Client Name', 'Alert');
            document.getElementById('txtClient').focus();
            return false;
       // }
    }
    else {
    }
    
    
    if (document.getElementById('billPart_txtTestName').value.trim() == "") {
        ValidationWindow('Search Test Names', 'Alert');
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
    DispatchChecked();
}
var defaultbillflag = 0;


function CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsDiscountable,
       IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation,
       BaseRateID, DiscountPolicyID, DiscountCategoryCode, ReportDeliveryDate) {

    if (document.getElementById('txtClient').value.trim() == '' && document.getElementById('hdnDefaultOrgBillingItems').value != '' && defaultbillflag == 0) {
        defaultbillflag = 1;
        var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
        FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^" + defalutdata[3]
                + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] 
//                + "~ActualAmount^" + defalutdata[8] 
                + "~IsDiscountable^" + defalutdata[9]
                + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13]
                + "~IsOutSource^" + defalutdata[14] + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + document.getElementById('hdnRateID').value
                + "~Code^" + defalutdata[16] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + "N" + "~BaseRateID^" + 0
                + "~DiscountPolicyID^" + 0 + "~DiscountCategoryCode^" + '' + "~ReportDeliveryDate^" + ''
                + "|";
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
                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsRI
//                + "~ActualAmount^" + ActualAmount 
                + "~IsDiscountable^" + IsDiscountable
                + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource
                + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory
                + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID
                + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate
                + "|" + FeeViewStateValue;

        document.getElementById('billPart_hdfBillType1').value = FeeViewStateValue;
        CreateBillItemsTable(0);

    }
    else if (queryStringColl != null) {

    FeeViewStateValue = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount 
                + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsRI
//                + "~ActualAmount^" + ActualAmount 
                + "~IsDiscountable^" + IsDiscountable
                + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS
                + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code
                + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation 
                + "|" + FeeViewStateValue;

        document.getElementById('billPart_hdfBillType1').value = FeeViewStateValue;
        CreateBillItemsTable(0);

    }
    else {
        ValidationWindow("Item already added", "Information");
        ClearSelectedData(0);
        return false;
    }

}
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
    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID,DiscountPolicyID, DiscountCategoryCode,ReportDeliveryDate;
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
            if (arrayChildData[0] = "ReportDeliveryDate") {
                ReportDeliveryDate = arrayChildData[1];
            }
        }



    }


    viewsstatevalie = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^"
                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable
                + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "|" + FeeViewStateValue;
    document.getElementById('billPart_hdfBillType1').value = viewsstatevalie
    CreateBillItemsTable(1)




}
function CreateBillItemsTable(id) {
    var HasHistoryflag = 0;
    document.getElementById('billPart_hdnCapture').value = 0;
    document.getElementById('billPart_divItemTable').innerHTML = "";
    var newPaymentTables, startPaymentTag, endPaymentTag;
    var FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;
    var TempString = document.getElementById('billPart_hdnCpedit').value;
    var Tempdisplay = 'display:block';
    if (TempString == "Y") {
        Tempdisplay = 'display:none';
    }
    var RedeemDisplay = 'display :table-cell';
    if ($("#billPart_hdnIsCashClient").val() == "N") {
        RedeemDisplay = 'display :none';
    }
    startPaymentTag = "<TABLE nowrap='nowrap' ID='tabDrg1' Cellpadding='0' Cellspacing='0' width='100%' class='dataheaderInvCtrl w-100p bg-row b-grey' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> FeeID </th><th scope='col'  style='width:5%;display:none;'> FeeType </th> "
    + "<th scope='col' style='width:5%;'> S.No </th> <th scope='col' style='width:6%;'> Code </th> <th scope='col' align='left' style='width:40%;padding-left:2px;'> Description </th> <th scope='col' align='center' style='width:8%;'>IsSTAT</th><th scope='col' align='center' style='width:12%; '>PL/OutSource</th> <th scope='col' align='right' style='display:none;width:5%;'>  Quantity </th><th scope='col' align='right' style='width:8%;'> Amount </th> "
    + "<th scope='col' style='width:20%;padding-left:2px;display:none;'>Remarks </th> <th scope='col' style='align:right;width:15%;display:table-cell;'> Report Date </th> <th scope='col' style='display:none;'> IsReimbursable </th><th scope='col' style='display:none;'> ActualAmount </th><th scope='col' style='display:none;'> IsDiscountable </th><th scope='col' style='display:none;'> BaseRateID </th> <th scope='col' style='display:none;'> DPID </th><th scope='col' style='display:none;'> DCC </th> <th scope='col' style='display:none;'> DeliveryDate </th>"
    + "<th scope='col' style='display:none;'> IsTaxable </th><th scope='col' style='display:none;'> IsRepeatable </th><th scope='col' style='display:none;'> IsSTAT </th><th scope='col' style='display:none;'> IsSMS </th><th scope='col' style='display:none;'> IsOutSource </th><th scope='col' style='display:none;'> IsNABL </th>"
    + "<th scope='col' style='display:none;'> BillingItemRateID </th><th scope='col' style='display:none;'> HasHistory </th> <th scope='col' style='" + Tempdisplay + "'> Delete </th> </tr>";
    endPaymentTag = "</TBODY></TABLE>";
    newPaymentTables = startPaymentTag;
    document.getElementById('billPart_hdnDiscountableTestTotal').value = 0;
    document.getElementById('billPart_hdnTaxableTestToal').value = 0;
    // document.getElementById('billPart_trSTATOutSource').style.display = "none";
    var arrayMainData = new Array();
    var arraySubData = new Array();
    var arrayChildData = new Array();
    var iMain = 0;
    var iChild = 0;
    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, BaseRateID, DiscountPolicyID,
    DiscountCategoryCode,ReportDeliveryDate;
    var GrossAmt = 0;
    var DiscountableTestAmount = 0;
    var TaxableTestAmount = 0;
    var sno = 1;
    var IsInvestigationAdded = 0;
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
                    if (arrayChildData[0] = "ReportDeliveryDate") {
                        ReportDeliveryDate = arrayChildData[1];
                    }
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
                newPaymentTables += "<TD ><input value ='" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "' onclick='GetGroupName(name);'type='button' style='color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"

            }
            else if (FeeType == 'PKG') {
                newPaymentTables += "<TD ><input value ='" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "' onclick='GetGroupName(name);'type='button' style='color:#6699FF;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"

            }
            else if (FeeType != "INV") {
                newPaymentTables += "<TD ><input value ='" + Descrip + "'  name='" + FeeID + "," + FeeType + "," + Descrip + "' onclick='GetGroupName(name);'type='button' style='background-color:Transparent;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>"
            }
            else {
                // newPaymentTables += "<TD  style='align:left;'>" + Descrip + "</TD>"
                newPaymentTables += "<TD ><input value ='" + Descrip + "' type='button' style='background-color:Transparent;font-size:10px;border-style:none;text-align:left;' /></TD>"

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
                    newPaymentTables += "<TD style='display:block;' align='Center'><input  style='display:none;'  id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true'   type='checkbox'  /></TD>";
                } else {
                newPaymentTables += "<TD style='display:block;' align='Center'><input   style='display:none;' id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "' onclick='chkChange(value,this.id);'  name='chkAlls'   type='checkbox'  /></TD>";
                }
            }
            else {
                if (IsSTAT == 'Y') {
                    newPaymentTables += "<TD style='display:block;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "' onclick='chkChange(value,this.id);'  name='chkAlls' checked='true'   type='checkbox'  /></TD>";
                } else {
                newPaymentTables += "<TD style='display:block;' align='Center'><input   id='" + str + "' value='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "' onclick='chkChange(value,this.id);'  name='chkAlls'   type='checkbox'  /></TD>";
                }
            }
            var RedeemabelAmt = '';
            newPaymentTables += "<TD style='display:table-cell;'>" + outRInSourceLocation + "</TD>";
            newPaymentTables += "<TD  align='right'>" + Amount + "</TD>";
            newPaymentTables += "<TD  align='right' style='" + RedeemDisplay + "'>" + RedeemabelAmt + "</TD>";
            newPaymentTables += "<TD  style='display:none;'>" + Remarks + "</TD>";
            newPaymentTables += "<TD style='display:block;' align='center'>" + ReportDate + "</TD>";
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
            newPaymentTables += "<TD style='display:block;'>" + ReportDeliveryDate + "</TD>";

            //newPaymentTables += "<TD align='center' style='" + Tempdisplay + "'><input name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "' onclick='btnDeleteBillingItems_OnClick1(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";
            newPaymentTables += "<TD align='right' style='" + Tempdisplay + "'><input name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "~HasHistory^" + HasHistory + "~outRInSourceLocation^" + outRInSourceLocation + "~BaseRateID^" + BaseRateID + "~DiscountPolicyID^" + DiscountPolicyID + "~DiscountCategoryCode^" + DiscountCategoryCode + "~ReportDeliveryDate^" + ReportDeliveryDate + "' onclick='btnDeleteBillingItems_OnClick1(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";

            sno++;
        }
        if (iMain > 0) {
            //document.getElementById('billPart_lblOrderedItemsCount"]').val(iMain);
            //$('[id$="lblOrderedItemsCount"]').html(Number(iMain));
            document.getElementById('billPart_lblOrderedItemsCount').innerHTML = Number(iMain);
            document.getElementById('billPart_trOrderedItemsCount').style.display = "block";
        }
        else 
        {
            document.getElementById('billPart_trOrderedItemsCount').style.display = "none";
        }
    }

    newPaymentTables += endPaymentTag;
    document.getElementById('billPart_divItemTable').innerHTML += newPaymentTables;
    document.getElementById('billPart_hdnDiscountableTestTotal').value = DiscountableTestAmount;
    ToTargetFormat($("#billPart_hdnDiscountableTestTotal"));
    document.getElementById('billPart_hdnTaxableTestToal').value = TaxableTestAmount;
    ToTargetFormat($("#billPart_hdnTaxableTestToal"));
    //    $('[id$="hdnDiscountableTestTotal"]').val(DiscountableTestAmount);
    //    $('[id$="hdnTaxableTestToal"]').val(TaxableTestAmount);

    ClearSelectedData();
    SetGrossValue(GrossAmt)
    SetOtherCurrValues();
    // if (HasHistoryflag == 1) {
    //document.getElementById('billPart_tdHistory').style.display = "block";
    if (HasHistoryflag == 1) {
        if (document.getElementById('billPart_hdnIsHistoryMandatory').value == "Y") {
            document.getElementById('billPart_hdnCapture').value = 1;
        }
        AddHistoryDetail();
    }
    else {
        document.getElementById('billPart_hdnCapture').value = 0;
    }
    //document.getElementById('billPart_tdHistory').style.display = "block";

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
function GetGroupName(FeeId, FeeType) {

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
        var SNo = result.length - n;

        cell1.innerHTML = "<b>" + SNo + "</b>";
        cell2.innerHTML = "<b>" + result[n].InvestigationName + "</b>";
        cell3.innerHTML = "<b>" + result[n].Status + "</b> ";

        document.getElementById('tblGroupHistory').style.display = 'table';

    }

}

function SetGrossValue(Amount) {
    document.getElementById('billPart_txtGross').value = parseFloat(Number(Amount)).toFixed(2);
    ToTargetFormat($("#billPart_txtGross"));
    document.getElementById('billPart_hdnGrossValue').value = document.getElementById('billPart_txtGross').value;
    ToTargetFormat($("#billPart_hdnGrossValue"));
    SetNetValue("ADD");
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
    document.getElementById('billPart_txtDiscount').value = "0.00";
    ToTargetFormat($("#billPart_txtDiscount"));
    document.getElementById('billPart_txtAuthorised').value = "";
    document.getElementById('billPart_txtDiscountReason').value = "";
    document.getElementById('billPart_hdnDiscountAmt').value = "0.00";
    ToTargetFormat($("#billPart_hdnDiscountAmt"));
    document.getElementById('billPart_ddlDiscountReason').value = "0";
    ToTargetFormat($("#billPart_ddlDiscountReason"));
    document.getElementById('billPart_ddlDiscountReason').disabled = true;

}

function SetNetValue(obj) {

    var roundOffAmt = 0;
    var gross = 0;
    var discount = 0;
    var TaxAMount = 0;
    var EDCess = 0;
    var SHEDCess = 0;
    var ServiceCharge = 0;
    if (Number(document.getElementById('billPart_txtGross').value) > 0) {
        if (Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) > 0) {
            document.getElementById('billPart_ddDiscountPercent').disabled = false;
            document.getElementById('billPart_btnDiscountPercent').disabled = false;
            document.getElementById('billPart_txtDiscount').readOnly = false;
            document.getElementById('billPart_txtAuthorised').disabled = false;
            document.getElementById('billPart_txtAuthorised').readOnly = false;
            document.getElementById('billPart_txtDiscountReason').readOnly = false;
            document.getElementById('billPart_ddlDiscountReason').disabled = false;
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
            gross = Number(ToTargetFormat($('#billPart_hdnGrossValue')));



            if (Number(document.getElementById('billPart_ddlTaxPercent').value) > 0) {
                document.getElementById('billPart_txtTax').value = parseFloat((parseFloat(Number(document.getElementById('billPart_hdnTaxableTestToal').value)) / 100) * (Number(document.getElementById('billPart_ddlTaxPercent').value))).toFixed(2);
                ToTargetFormat($('#billPart_txtTax'));
            }

            TaxAMount = Number(document.getElementById('billPart_txtTax').value).toFixed(2);
            document.getElementById('billPart_hdnTaxAmount').value = TaxAMount;
            ToTargetFormat($('#billPart_hdnTaxAmount'));


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

                if (DisDetails[1] != "" && DisDetails[1] != 0) {
                    $("#billPart_hdnDiscountID").val(DisDetails[1]);
                }
                

                //$("#billPart_hdnDiscountCode").val(DisDetails[2]);
                
//                if (document.getElementById('billPart_ddDiscountPercent').value > 0) {
//                    document.getElementById('billPart_txtDiscount').value = (parseFloat((parseFloat(Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) / 100) * (Number(document.getElementById('billPart_ddDiscountPercent').value)))).toFixed(2));
//                    ToTargetFormat($('#billPart_txtDiscount'));
                //                }

                if (dispercent > 0) {
                    document.getElementById('billPart_txtDiscount').value = (parseFloat((parseFloat(Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) / 100) * (Number(dispercent)))).toFixed(2));
                    ToTargetFormat($('#billPart_txtDiscount'));
                }
            }

            document.getElementById('billPart_hdnDiscountAmt').value = document.getElementById('billPart_txtDiscount').value;
            discount = document.getElementById('billPart_hdnDiscountAmt').value;

            if (Number(document.getElementById('billPart_hdnDiscountableTestTotal').value) < Number(document.getElementById('billPart_txtDiscount').value)) {
                ValidationWindow('Ordered test net amount, less then discount amount', 'Alert');
                discount = 0;
                document.getElementById('billPart_txtDiscount').value = "0.00";
                ToTargetFormat($('#billPart_txtDiscount'));
                document.getElementById('billPart_hdnDiscountAmt').value = "0.00";
                ToTargetFormat($('#billPart_hdnDiscountAmt'));
                document.getElementById('billPart_txtAuthorised').value = "";
                document.getElementById('billPart_txtDiscountReason').value = "";
                document.getElementById('billPart_txtDiscount').focus();
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
            //            if (Number(netvalue) - Number(getOPCustomRoundoff(netvalue.toFixed(2))) > 0)
            //                roundOffAmt = Number(netvalue) - Number(getOPCustomRoundoff(netvalue));
            //            else
            //                roundOffAmt = Number(getOPCustomRoundoff(netvalue)) - Number(netvalue);
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
            var IsCashClient = document.getElementById('billPart_hdnIsCashClient').value;
            var ClientType=document.getElementById('billPart_hdnClientType').value 
            if (IsCashClient == '') {
                IsCashClient = 'Y';
            }
            if ((document.getElementById('txtClient').value == '' || IsCashClient == 'Y' || ClientType=='WAK') && obj == "ADD") {
                $("#billPart_PaymentType_txtAmount").removeAttr("disabled");
                document.getElementById('billPart_PaymentType_txtAmount').value = parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2);
                ToTargetFormat($('#billPart_PaymentType_txtAmount'));

                document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2);
                ToTargetFormat($('#billPart_PaymentType_txtTotalAmount'));

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
                    if (confirm('Amount already received, delete the amount received... Do you want to Delete the amount received?')) {
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
                    }
                    else {
                        document.getElementById('billPart_ddDiscountPercent').value = 0;
                        document.getElementById('billPart_ddlDiscountReason').value = 0;
                        document.getElementById('billPart_hdnDiscountPercentage').value = 0;
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
    document.getElementById('billPart_txtDue').value = parseFloat(Number(document.getElementById('billPart_hdnNetAmount').value) - Number(document.getElementById('billPart_hdnAmountReceived').value)).toFixed(2);
    ToTargetFormat($('#billPart_txtDue'));
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
    sNetValue = format_number(Number(document.getElementById('billPart_hdnNetAmount').value) + Number(ServiceCharge), 4);

    sVal = format_number(Number(sVal) + Number(TotalAmount), 4);

    if (PaymentAmount > 0) {

        if (Number(sNetValue) >= Number(sVal)) {
            sVal = format_number(sVal, 4);
            SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 4), ConValue);
            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 4);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);

            document.getElementById('billPart_txtServiceCharge').value = parseFloat(pScrAmt).toFixed(2);
            ToTargetFormat($('#billPart_txtServiceCharge'));
            document.getElementById('billPart_hdnServiceCharge').value = format_number(pScrAmt, 2);
            ToTargetFormat($('#billPart_hdnServiceCharge'));
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
            ValidationWindow('Amount received is greater than net amount', 'Alert');
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
    //document.getElementById('billPart_btnAdd').disabled = true;
    if (document.getElementById('billPart_hdfBillType1').value == '')
        document.getElementById('billPart_spanAddItems').style.display = "block";
    if (document.getElementById('billPart_hdfBillType1').value != '')
        document.getElementById('billPart_spanAddItems').style.display = "none";

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

    FeeGotValue = sEditedData.split('~');
    var FeeID;

    if (FeeGotValue.length > 0) {
        FeeID = FeeGotValue[2];

        arrayAmount = FeeID.split('^');
    }
    document.getElementById('billPart_hdfBillType1').value = PaymenttempDatas;
    //$('[id$="hdfBillType1"]').val(PaymenttempDatas);
    CreateBillItemsTable(0);
    DeleteAmountValue(0, 0, 0);
    ClearPaymentControlEvents();
    var GrossAmt = document.getElementById('billPart_hdnGrossValue').value;
    if (GrossAmt < 0) {
        defaultbillflag = 0;
    }
    SetGrossValue(GrossAmt);
    SetOtherCurrValues();

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


//function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
//    var key;
//    var isCtrl = false;
//    var keychar;
//    var reg;

//    if (window.event) {
//        key = e.keyCode;
//        isCtrl = window.event.ctrlKey
//    }
//    else if (e.which) {
//        key = e.which;
//        isCtrl = e.ctrlKey;
//    }

//    if (isNaN(key)) return true;

//    keychar = String.fromCharCode(key);

//    // check for backspace or delete, or if Ctrl was pressed
//    if (key == 8 || isCtrl) {
//        return true;
//    }

//    reg = /\d/;
//    var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
//    var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

//    return isFirstN || isFirstD || reg.test(keychar);
//}

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
            ValidationWindow('Please select client from the list', 'Alert');
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
            ValidationWindow('Please select hospital from the list', 'Alert');
            $('[id$="txtReferringHospital"]').val("");
        }
    };

}
function PhysicianTempSelected(source, eventArgs) {
    $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
        //var Perphysicianname = document.getElementById('txtperphy').value;
        $find('AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
        if (result == "") {
            //alert('Please select Refering physician from the list');
            // $('[id$="txtInternalExternalPhysician"]').val("");
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

    if (document.getElementById('txtClient').value == '') {
        document.getElementById('hdnSelectedClientClientID').value = 0;
        var ddlobj = document.getElementById("ddlRate");
      //  ddlobj.options.length = 0;
//        var opt1 = document.createElement("option");
//        document.getElementById("ddlRate").options.add(opt1);
//        opt1.text = "---Select---";
//        opt1.value = "0";
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
        document.getElementById("billPart_" + "OtherCurrencyDisplay1_tbAmountPayble").style.display = "block";
        document.getElementById("billPart_" + "trOtherCurrency").style.display = "block";
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
    else if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '2' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '11' || document.getElementById(msId).value == '15' || document.getElementById(msId).value == '5' || document.getElementById(msId).value == '22') {
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
    document.getElementById('billPart_hdnValidation').value = 'Y';
    if (document.getElementById('txtDOBNos').value < 0) {
        document.getElementById('txtDOBNos').value = '';
    }
    if (document.getElementById('txtDOBNos').value >= 150) {

        ValidationWindow('Provide a valid year', 'Information');        
        document.getElementById('tDOB').value = "dd//MM//yyyy";
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('txtDOBNos').focus();
        return false;
    }
    var valAge = 105;
    var valage1 = 95;
    var AGE = document.getElementById('txtDOBNos').value;
    if (AGE >= valAge) {
        ValidationWindow('Age Should not be Greater than 105', 'Alert');
        document.getElementById('txtDOBNos').value = '';
        return false;
    }
    else if (AGE >= valage1 && AGE <= valAge) {
        var Userval = confirm('Age is Greater than 95 Do You want to continue');
    }
}
var retVal = true;
function DuplicateInv(Id, Type) {
    var FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;
    var boolval = true;
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
            $.each(Items, function(index, Item) {
                //  alert(Item.InvestigationID);
                document.getElementById('billPart_hdnfinduplicate').value += Item.InvestigationID + '~' + Item.InvestigationValueID + '~' +
		Item.InvestigationName + '^';
                //                document.getElementById('hdnsampleforcurrent').value += Item.SampleCode + '~' + Item.SampleContainerID;
                if (document.getElementById('hdnDoFrmVisit').value != "") {
                    if (document.getElementById('hdnSampleforPrevious').value != '') {
                        for (i = 0; i < SampleCount; i++) {
                            if (lstSampleContainer[0].SampleCode == Item.SampleCode) {
                                if (lstSampleContainer[0].SampleContainerID == Item.SampleContainerID) {
                                    IsSampleContainerMatch = 1;
                                }
                            }
                        }
                    }
                }
                //FindDuplicate(Item.InvestigationID, Type)

            });

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
    if (document.getElementById('hdnDoFrmVisit').value != "") {
        if (document.getElementById('hdnSampleforPrevious').value != '') {
            if (document.getElementById('hdnDOFromVisitFlag').value == "0" || document.getElementById('hdnDOFromVisitFlag').value == "1") {
            if (IsSampleContainerMatch == '0') {
                ValidationWindow("This Test's Sample & Container doesn't Match with Previous Items", "Alert");
                return false;
               }
            }
        }
    }
    if (Descrip != '' && retVal == true) {
        if (Number(Amount) <= 0) {
            if (document.getElementById('billPart_ZeroAmount').value == 'Y') {
                ValidationWindow("Item amount is zero.Kindly Map Rate for the Item...", "Alert");
                return false;
            }
            else {
                var pBill = confirm("Item amount is zero.\n Do you want to add this item");
            }
            if (pBill) {
                CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsDiscountable, IsTaxable, 
                                            IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, 
                                            BaseRateID,DiscountPolicyID,DiscountCategoryCode,ReportDeliveryDate);
                document.getElementById('billPart_lblInvType').innerHTML = "";
            }
        }
        else {
            CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsDiscountable, IsTaxable, 
                                        IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code, HasHistory, outRInSourceLocation, 
                                        BaseRateID,DiscountPolicyID,DiscountCategoryCode,ReportDeliveryDate);
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
                        var Userval = confirm('This Test is already available as a part of Ordered Package / Group.Do you want to proceed ?')
                        if (Userval) { document.getElementById('billPart_hdnfinduplicate').value += setvar; }
                        else { document.getElementById('billPart_hdnfinduplicate').value += setvar; DeleteFindduplicatcatsItems(dup[i].split('~')[1]); ClearSelectedData(); }
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

    document.getElementById('txtName').value = "";
    document.getElementById('txtDOBNos').value = "";
    document.getElementById('tDOB').value = "";

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

    //document.getElementById('chkboxPrintQuotation').checked = false;
    CheckAll();
    document.getElementById('hdnLogisticsName').value = "";
    document.getElementById('tDOB').value = "";
    document.getElementById('txtzone').value = "";
    document.getElementById('txtzone').value = "";
    document.getElementById('hdnZoneID').value = 0;
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



        $("[name='txtEmail']").prop("readonly", false);
        $("[name='chkMobileNotify']").prop("disabled", false);
        $("[name='txtMobileNumber']").prop("readonly", false);
        $("[name='txtRoundNo']").prop("readonly", false);
        $("[name='txtPhleboName']").prop("readonly", false);
        $("[name='txtLogistics']").prop("disabled", false);
        $("[name='txtzone']").prop("disabled", false);
        $("[name='chkExcludeAutoathz']").prop("disabled", false);
        $("[name='ddlNationality']").prop("disabled", false);
        $("[name='ddCountry']").prop("readOnly", false);

        $("[name='ddState']").prop("readOnly", false);
        $("[name='txtClient']").prop("disabled", false);
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
    document.getElementById('txtSampleDate').value = "";

    //document.getElementById('chkboxPrintQuotation').checked = false;
    CheckAll();
    document.getElementById('hdnLogisticsName').value = "";
    document.getElementById('tDOB').value = "";
    document.getElementById('txtzone').value = "";
    document.getElementById('txtzone').value = "";
    document.getElementById('hdnZoneID').value = 0;
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
function PrintBillItemsTable() {
    $('[id$="divItemTable"]').val("");
    var startHeaderTag, newPaymentTables, startPaymentTag, endPaymentTag, taxDetailsTag;
    var FeeViewStateValue = $('[id$="hdfBillType1"]').val();
    startHeaderTag = "<table width='100%' class='dataheaderInvCtrl'><tr><td colspan='3'>";
    startHeaderTag = startHeaderTag + "<h3 align='center'><u>Service Quotation</u></h3>";
    startHeaderTag = startHeaderTag + "</td></tr><tr><td colspan='3'> </td></tr><tr><td colspan='3'></td></tr><tr><td colspan='3'>"
    startHeaderTag = startHeaderTag + "</td></tr><tr><td>"
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
    startPaymentTag = "<TABLE nowrap='nowrap' ID='tabDrg1' Cellpadding='0' Cellspacing='0' border='1' width='100%' class='dataheaderInvCtrl' style='font-size: 12px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> FeeID </th><th scope='col'  style='width:5%;display:none;'> FeeType </th> <th scope='col' style='width:7%;'> S.No </th><th scope='col' align='left' style='width:65%;padding-left:2px;'> Description </th>  <th scope='col' align='right' style='display:none;width:5%;'>  Quantity </th><th scope='col' align='right' style='width:8%;'> Amount </th> <th scope='col' style='width:20%;padding-left:2px;display:none;'>Remarks </th> <th scope='col' style='align:right;width:15%;display:none;'> Report Date </th> <th scope='col' style='display:none;'> IsReimbursable </th><th scope='col' style='display:none;'> ActualAmount </th><th scope='col' style='display:none;'> IsDiscountable </th><th scope='col' style='display:none;'> IsTaxable </th><th scope='col' style='display:none;'> IsRepeatable </th><th scope='col' style='display:none;'> IsSTAT </th><th scope='col' style='display:none;'> IsSMS </th><th scope='col' style='display:none;'> IsOutSource </th><th scope='col' style='display:none;'> IsNABL </th><th scope='col' style='display:none;'> BillingItemRateID </th><th scope='col' style='display:none;'> HasHistory </th>"; // <th scope='col' align='center'>Delete</th></tr>";
    endPaymentTag = "</TBODY></TABLE>";
    newPaymentTables = startPaymentTag;
    //    $('[id$="hdnDiscountableTestTotal"]').val(0);
    //    $('[id$="hdnTaxableTestToal"]').val(0);
    var arrayMainData = new Array();
    var arraySubData = new Array();
    var arrayChildData = new Array();
    var iMain = 0;
    var iChild = 0;
    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code;
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
    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblRoundOffAmt').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtRoundoffAmt').value + "</td></tr>";
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
                    document.getElementById('billPart_UcHistory_tr1PatientHistory_LMP_1097').style.display = "block";
                    document.getElementById('billPart_UcHistory_divchkLMP').style.display = "block";

                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1098) {
                    //                            trFasting_Duration_1098.Style.Add("display", "block");
                    //                            divFasting_Duration.Style.Add("display", "block");  
                    document.getElementById('billPart_UcHistory_trFasting_Duration_1098').style.display = "block";
                    document.getElementById('billPart_UcHistory_divFasting_Duration').style.display = "block";
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1099) {
                    //                            trLastMealTime_1099.Style.Add("display", "block");
                    //                            divLastMealTime.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trLastMealTime_1099').style.display = "block";
                    document.getElementById('billPart_UcHistory_divLastMealTime').style.display = "block";
                    document.getElementById('billPart_UcHistory_ChkLastMealTime').checked = true;
                    document.getElementById('billPart_UcHistory_txtDateTime').value = '';
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1100) {
                    //                            trRecent_Sonography_Report_1100.Style.Add("display", "block");
                    //                            divRecent_Sonography_Report.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trRecent_Sonography_Report_1100').style.display = "block";
                    document.getElementById('billPart_UcHistory_divRecent_Sonography_Report').style.display = "block";

                }

                else if (arrayHistoryData[iMain].split('~')[1] == 1101) {
                    //                            trurine_volume_Collected_1101.Style.Add("display", "block");
                    //                            divurine_volume_Collected.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trurine_volume_Collected_1101').style.display = "block";
                    document.getElementById('billPart_UcHistory_divurine_volume_Collected').style.display = "block";
                }

                else if (arrayHistoryData[iMain].split('~')[1] == 1102) {
                    //                            trAbstinence_days_1102.Style.Add("display", "block");
                    //                            divAbstinence_days.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trAbstinence_days_1102').style.display = "block";
                    document.getElementById('billPart_UcHistory_divAbstinence_days').style.display = "block";
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1103) {
                    //                            trOn_anti_thyroid_disease_drugs_1103.Style.Add("display", "block");
                    //                            divOn_anti_thyroid_disease_drugs.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trOn_anti_thyroid_disease_drugs_1103').style.display = "block";
                    document.getElementById('billPart_UcHistory_divOn_anti_thyroid_disease_drugs').style.display = "block";
                }
                else if (arrayHistoryData[iMain].split('~')[1] == 1104) {
                    //                            trReading_taken_between_48_72_hrs_1104.Style.Add("display", "block");
                    //                            divReading_taken_between_48_72_hrs.Style.Add("display", "block");
                    document.getElementById('billPart_UcHistory_trReading_taken_between_48_72_hrs_1104').style.display = "block";
                    document.getElementById('billPart_UcHistory_divReading_taken_between_48_72_hrs').style.display = "block";
                }
                else if (arrayHistoryData[iMain].split('~')[1] != "" && arrayHistoryData[iMain].split('~')[1] != "0") {


                    document.getElementById('billPart_UcHistory_trDynamicControlsTable').style.display = "block";
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
                        cell3.innerHTML = "<input type='text' id='" + TxtID + "' runat='server' />";
                        cell4.innerHTML = "<input type='hidden' runat='server' id='" + HdnID1 + "'  value='" + HdnID + "' />"
                        cell5.innerHTML = "<input type='hidden' runat='server' id='" + HdnID2 + "'  value='" + HdnID + "' />"

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
function SetCheckboxIndex(id) {
    //  alert(id);
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

                    document.getElementById('billPart_UcHistory_trDynamicControlsTable').style.display = 'block';
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
                    
                     var y =  AttributeValueName.split('-')[0] ;
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
                newPaymentTables += "<TD style='padding-left:5px' align='left'>" + AttributeValueName + "</TD>"
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
    //debugger;
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

    EnabledFalse();
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
                + "<tr class = 'dataheader1' style='font-weight:bold;'><td style='width:30px;'>S.No</td><td  style='width:330px;'>Test Name</td><td  style='display:none;width:30px;'>ID</td><td style='display:block;width:30px;'>Type</td>"
                + "<td style='display:block;width:30px;'></td><td  style='display:none;'>IsAddToday</td><td  style='display:none;'>IsOutSource</td><td  style='display:none;'>TestCode</td></tr>";

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
                                "</td><td style='display:block;'></td><td style='display:none;'>" + res[5] + "</td><td style='display:none;'>" + res[6] + "</td><td style='display:none;'>" + res[7] + "</td>";

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
                    document.getElementById('tdVisitType1').style.display = "block";
                    document.getElementById('tdVisitType2').style.display = "block";
                    var NewOrgID = document.getElementById('hdnNewOrgID').value;
                    //                    document.getElementById('tdSex1').style.width = '10%';
                    //                    document.getElementById('tdSex2').style.width = '18%';
                }
            }

        }
        tblTotal += "<tr><td colspan='5' style='display:block;' align='center'></td></tr>";
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

/////////////////////////////// Jquery Part /////////////////////////////////
////function clearBillPartValues() {
////    $('[id$="txtTestName"]').val("");
////    $('[id$="divItemTable"]').val("");
////    $('[id$="txtAuthorised"]').val("");
////    $('[id$="txtPatientHistory"]').val("");
////    $('[id$="txtGross"]').val("0.00");
////    $('[id$="hdnGrossValue"]').val("0.00");
////    $('[id$="txtDiscount"]').val("0.00");
////    $('[id$="txtDiscountReason"]').val("0.00");
////    $('[id$="hdnDiscountAmt"]').val("0.00");
////    $('[id$="txtTax"]').val("0.00");
////    $('[id$="hdnTaxAmount"]').val("0.00");
////    $('[id$="hdfTax"]').val("0.00");
////    $('[id$="txtServiceCharge"]').val("0.00");
////    $('[id$="hdnServiceCharge"]').val("0.00");
////    $('[id$="txtRoundoffAmt"]').val("0.00");
////    $('[id$="hdnRoundOff"]').val("0.00");
////    $('[id$="txtNetAmount"]').val("0.00");
////    $('[id$="hdnNetAmount"]').val("0.00");
////    $('[id$="txtAmtReceived"]').val("0.00");
////    $('[id$="hdnDiscountableTestTotal"]').val(0);
////    $('[id$="hdnAmountReceived"]').val("0.00");
////    $('[id$="txtDue"]').val("0.00");
////    $('[id$="hdnDue"]').val("0.00");
////    $('[id$="hdfBillType1"]').val("");
////    $('[id$="hdnName"]').val("");
////    $('[id$="hdnID"]').val("");
////    $('[id$="hdnReportDate"]').val("");
////    $('[id$="hdnRemarks"]').val("");
////    $('[id$="hdnIsRemimbursable"]').val("");
////    $('[id$="hdnPaymentControlReceivedtemp"]').val("");
////    $('[id$="hdnAmt"]').val("0.00");
////    $('[id$="ddDiscountPercent"]').val("0");
////    $('[id$="hdnActualAmount"]').val("0.00");
////    $('[id$="ddlDiscountReason"]').val(0);
////    $('[id$="hdnIsDiscount"]').val("N");
////    $('[id$="hdnFeeTypeSelected"]').val("COM");
////    $('[id$="hdnIsDiscountableTest"]').val("Y");
////    $('[id$="hdnIsRepeatable"]').val("N");
////    $('[id$="lblPreviousDueText"]').val("0.00");
////    $('[id$="ddlTaxPercent"]').val("0");
////    $('[id$="txtEDCess"]').val("0.00");
////    $('[id$="hdnEDCess"]').val("0.00");
////    $('[id$="txtSHEDCess"]').val("0.00");
////    $('[id$="hdnSHEDCess"]').val("0.00");
////    $('[id$="hdnfinduplicate"]').val("");
////    $('[id$="ddlDiscountReason"]').attr("disabled", true);
////    $('[id$="ddlTaxPercent"]').attr("disabled", true);
////    $('[id$="ddDiscountPercent"]').attr("disabled", true);
////    $('[id$="trOrderedItemsCount"]').attr("display", "none");
////    $('[id$="chkEDCess"]').removeAttr('checked');
////    $('[id$="chkSHEDCess"]').removeAttr('checked');
////    ClearPaymentControlEvents1();
////    ClearControlValues();
////    GetCurrencyValues();
////    $('[id$="divItemTable"]').html("");
////    defaultbillflag = 0
////}

////function clearbuttonClick() {
////    if (window.confirm("Are you sure you want to clear?")) {
////        clearPageControlsValue('N');
////        return true;
////    }
////    else {
////        return false;
////    }
////}
////function SetDiscountAmt() {
////    if ($('[id$="ddDiscountPercent"]').val() == '0') {
////        $('[id$="txtDiscount"]').val("0.00");
////        $('[id$="hdnDiscountAmt"]').val("0.00");
////    }
////}
////function SetTaxAmt() {
////    if ($('[id$="ddlTaxPercent"]').val() == '0') {
////        $('[id$="ddlTaxPercent"]').val("0.00");
////        $('[id$="hdnTaxAmount"]').val("0.00");
////    }
////}

////function getOPCustomRoundoff(netRound) {
////    var DefaultRound = $('[id$="hdnDefaultRoundoff"]').val();
////    var RoundType = $('[id$="hdnRoundOffType"]').val();
////    if (RoundType.toLowerCase() == "lower value") {
////        result = (Math.floor(Number(netRound) / Number(DefaultRound))) * (Number(DefaultRound));
////    }
////    else if (RoundType.toLowerCase() == "upper value") {
////        result = (Math.ceil(Number(netRound) / Number(DefaultRound))) * (Number(DefaultRound));
////    }
////    else if (RoundType.toLowerCase() == "none") {
////        result = format_number_withSignNone(netRound, 2);
////    }
////    else {
////        result = parseFloat(netRound).toFixed(2);
////    }
////    result = parseFloat(result).toFixed(2);
////    return result;
////}


////function GetReferingHospID(source, eventArgs) {
////    $('[id$="txtReferringHospital"]').val(eventArgs.get_text());
////    $('[id$="hdfReferalHospitalID"]').val(eventArgs.get_value());
////}

////function SelectedTest(source, eventArgs) {
////    var list = eventArgs.get_value().split('^');
////    if (list.length > 0) {
////        for (i = 0; i < list.length; i++) {
////            if (list[i] != "") {
////                //document.getElementById('lblInvType').innerHTML = list[2];
////            }
////        }
////    }
////}



////function loadState(obj) {
////    if ($('#ddState').val() != $('#hdnDefaultStateID').val()) {
////        $("select[id$=ddState] > option").remove();
////        $.ajax({
////            type: "POST",
////            url: "../OPIPBilling.asmx/GetStateByCountry",
////            data: "{ 'CountryID': '" + parseInt($('#ddCountry').val()) + "'}",
////            contentType: "application/json; charset=utf-8",
////            dataType: "json",
////            async: true,
////            success: function(data) {
////                var Items = data.d;

////                $('#ddState').attr("disabled", false);
////                $('#ddState').append('<option value="-1">--Select--</option>');
////                $.each(Items, function(index, Item) {
////                    $('#ddState').append('<option value="' + Item.StateID + '">' + Item.StateName + '</option>');
////                    $('#lblCountryCode').html("+" + Item.ISDCode);
////                    // document.getElementById('lblCountryCode').innerHTML = "+" + Item.ISDCode;
////                });
////                if (obj == "1") {
////                    if (Number($('#hdnPatientID').val()) > 0 && Number($('#hdnPatientStateID').val()) > 0) {
////                        $('#ddState').val($('#hdnPatientStateID').val());
////                    }
////                    else {
////                        onchangeState();
////                    }
////                }
////                else {
////                    $('#ddState').val($('#hdnDefaultStateID').val());
////                }

////            },
////            failure: function(msg) {
////                ShowErrorMessage(msg);
////            }
////        });
////    }
////}


////function onchangeState() {
////    $('#hdnPatientStateID').val($('#ddState').val());
////}

////function alpha(e) {
////    var k;
////    document.all ? k = e.keyCode : k = e.which;
////    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
////}
////function CheckBillItems() {
////    if (Number($('#hdnDiscountAmt').val()) <= 0) {
////        alert('Provide discount for bill, then give approved by and reason');
////        return false;
////    }
////}

////function SetRateCard() {
////    var CreditFlag = 0;
////    if (Number($('[id$="hdnSelectedClientRateID"]').val()) > 0 && $.trim($('[id$="txtClient"]').val()) != '')
////        CreditFlag = 1;

////    if (Number(CreditFlag) > 0) {
////        $('[id$="hdnRateID"]').val(Number($('[id$="hdnSelectedClientRateID"]').val()));
////        $('[id$="hdnClientID"]').val(Number($('[id$="hdnSelectedClientClientID"]').val()));
////        $('[id$="hdnMappingClientID"]').val(Number($('[id$="hdnSelectedClientMappingID"]').val()));
////    }
////    else {
////        $('[id$="hdnRateID"]').val(Number($('[id$="hdnBaseRateID"]').val()));
////        $('[id$="hdnClientID"]').val(Number($('[id$="hdnBaseClientID"]').val()));
////        $('[id$="hdnMappingClientID"]').val(-1);
////    }

////    $('#txtDiscount').attr("disabled", true);
////    $('#txtAuthorised').attr("disabled", true);
////    $('#txtDiscountReason').attr("readOnly", true);

////    if ($('[id$="hdnIsDiscount"]').val() == "Y") {
////        $('#txtDiscount').attr("disabled", false);
////        $('#txtAuthorised').attr("disabled", false);
////        $('#txtDiscountReason').attr("readOnly", false);
////    }
////}
////function CheckOrderedItems() {
////    if ($.trim($('[id$="hdfBillType1"]').val()) != '') {
////        var pBill = confirm("Delete the Ordered Items then only you can Change.\n Do you want to delete the items, Press OK Else Cancel");
////        if (pBill != true) {
////            $('[id$="txtTestName"]').focus();
////            return false;
////        }
////        else {
////            $('[id$="txtClient"]').val('');
////            $('[id$="hdfBillType1"]').val("");
////            $('[id$="hdnfinduplicate"]').val("");
////            $('[id$="hdnRateID"]').val(Number($('[id$="hdnBaseRateID"]').val()));
////            $('[id$="hdnClientID"]').val(Number($('[id$="hdnBaseClientID"]').val()));
////            $('[id$="hdnSelectedClientClientID"]').val(Number($('[id$="hdnBaseClientID"]').val()));
////            $('[id$="hdnIsCashClient"]').val('N');
////            var ddlobj = document.getElementById("ddlRate");
////            ddlobj.options.length = 0;
////            defaultbillflag = 0
////            CreateBillItemsTable(1);
////            ClearPaymentControlEvents1();
////            $('[id$="txtClient"]').focus();
////        }
////    }
////    else {
////        return true;
////    }
////}
////function ShowTRFUpload(obj, id) {
////    if (obj.checked) {
////        $('[id$="TRFimage"]').show();
////    }
////    else {
////        $('[id$="TRFimage"]').hide();
////    }
////}

////function CheckMRD() {

////    //    var obj = document.getElementById('ddlUrnType');

////    //    if (obj.options[obj.selectedIndex].value == 6) {
////    //        document.getElementById('txtURNo').disabled = true;
////    //        document.getElementById('ddlUrnoOf').disabled = true;

////    //    }
////    //    else {
////    //        document.getElementById('txtURNo').disabled = false;
////    //        document.getElementById('ddlUrnoOf').disabled = false;
////    //    }
////    //    return false;
////}


////function ConverttoUpperCase(id) {
////    var lowerCase = document.getElementById(id).value;
////    var upperCase = lowerCase.toUpperCase();
////    document.getElementById(id).value = upperCase;
////}
////function DiscountAuthSelectedOver(source, eventArgs) {
////    $find('billPart_AutoAuthorizer')._onMethodComplete = function(result, context) {
////        //var Perphysicianname = document.getElementById('txtperphy').value;
////        $find('billPart_AutoAuthorizer')._update(context, result, /* cacheResults */false);
////        if (result == "") {
////            alert('Please select discount authroise from the list');
////            $('[id$="txtAuthorised"]').val("");
////        }
////    };
////}

////function DiscountAuthSelected(source, eventArgs) {
////    $('[id$="hdnDiscountApprovedBy"]').val(eventArgs.get_value());
////}
////function PhysicianSelected(source, eventArgs) {

////    var PhysicianID;
////    var PhysicianName;
////    var PhysicianCode;
////    var PhysicianType;
////    $('[id$="txtInternalExternalPhysician"]').val(eventArgs.get_text());
////    var list = eventArgs.get_value().split('^');
////    if (list.length > 0) {
////        for (i = 0; i < list.length; i++) {
////            if (list[i] != "") {
////                PhysicianID = list[0];
////                PhysicianName = list[1];
////                PhysicianCode = list[2];
////                PhysicianType = list[3].trim();
////            }
////        }
////    }
////    $('[id$="hdnReferedPhyID"]').val(PhysicianID);
////    $('[id$="hdnReferedPhyName"]').val(PhysicianName);
////    $('[id$="hdnReferedPhysicianCode"]').val(PhysicianCode);
////    $('[id$="hdnReferedPhyType"]').val(PhysicianType);
////}
////function CollectionCenterSelected(source, eventArgs) {

////    var CollectionCenterID;
////    var CollectionCenterName;
////    var CollectionCenterCode;
////    var CollectionCenterRateID;
////    var CollectionCenterClientID;
////    var CollectionCenterMappingID;

////    var list = eventArgs.get_value().split('^');
////    if (list.length > 0) {
////        for (i = 0; i < list.length; i++) {
////            if (list[i] != "") {
////                CollectionCenterID = list[0];
////                CollectionCenterName = list[2];
////                CollectionCenterCode = list[3];
////                CollectionCenterRateID = list[4];
////                CollectionCenterClientID = list[5];
////                CollectionCenterMappingID = list[6];
////            }
////        }
////    }
////    $('[id$="hdnCollectionCenterID"]').val(CollectionCenterID);
////    $('[id$="hdnCollectionCenterName"]').val(CollectionCenterName);
////    $('[id$="hdnCollectionCenterCode"]').val(CollectionCenterCode);
////    $('[id$="hdnCollectionCenterRateID"]').val(CollectionCenterRateID);
////    $('[id$="hdnCollectionCenterClientID"]').val(CollectionCenterClientID);
////    $('[id$="hdnCollectionCenterMappingID"]').val(CollectionCenterMappingID);
////}
////function ClientSelected(source, eventArgs) {

////    var ClientCorpID;
////    var ClientCorpName;
////    var ClientCorpCode;
////    var ClientCorpRateID;
////    var ClientCorpClientID;
////    var ClientCorpMappingID;
////    var Ismappeditem = "N";
////    var IsDiscount = "N";
////    var ClientType;
////    var ReferingID;
////    var list = eventArgs.get_value().split('^');
////    var slist = eventArgs.get_value().split('###');
////    var flist;
////    var temp = 0;
////    var ClientStatus = '';
////    var BoolValue = true;
////    var IsCashClient = "N";
////    if (slist.length > 0) {
////        for (j = 0; j < slist.length - 1; j++) {
////            flist = slist[j].split('^');
////            var rat = flist[4].split('~');
////            if (j == 0) {
////                ClientStatus = flist[13].trim();
////                if (ClientStatus == 'S' || ClientStatus == 'T') {
////                    BoolValue = CheckClientStatus(ClientStatus, flist[15], flist[16]);
////                    return BoolValue;
////                }
////                ClientCorpID = flist[0];
////                ClientCorpName = flist[2];
////                ClientCorpCode = flist[3];
////                ClientCorpRateID = rat[0];
////                ClientCorpClientID = flist[5];
////                ClientCorpMappingID = flist[6];
////                temp = flist[8];
////                Ismappeditem = flist[9];
////                IsDiscount = flist[10];
////                ClientType = flist[7];
////                ReferingID = flist[12];
////                IsCashClient = flist[17];
////            }
////            if (temp > flist[8]) {
////                ClientStatus = flist[13].trim();
////                if (ClientStatus == 'S' || ClientStatus == 'T') {
////                    BoolValue = CheckClientStatus(ClientStatus, flist[15], flist[16]);
////                    return BoolValue;
////                }
////                ClientCorpID = flist[0];
////                ClientCorpName = flist[2];
////                ClientCorpCode = flist[3];
////                ClientCorpRateID = rat[0];
////                ClientCorpClientID = flist[5];
////                ClientCorpMappingID = flist[6];
////                temp = flist[8];
////                Ismappeditem = flist[9];
////                IsDiscount = flist[10];
////                ClientType = flist[7];
////                ReferingID = flist[12];
////                IsCashClient = flist[17];
////            }
////        }
////    }
////    $('[id$="hdnIsMappedItem"]').val(Ismappeditem);
////    $('[id$="hdnIsDiscount"]').val(IsDiscount);
////    $('[id$="hdnSelectedClientID"]').val(ClientCorpID);
////    $('[id$="hdnSelectedClientName"]').val(ClientCorpName);
////    $('[id$="hdnSelectedClientCode"]').val(ClientCorpCode);
////    $('[id$="hdnSelectedClientRateID"]').val(ClientCorpRateID);
////    $('[id$="hdnSelectedClientClientID"]').val(ClientCorpClientID);
////    $('[id$="hdnSelectedClientMappingID"]').val(ClientCorpMappingID);
////    $('[id$="hdnIsCashClient"]').val(IsCashClient);
////    $('#txtClient').val(ClientCorpName);
////    ValidateCreditLimit(ClientCorpClientID);
////    SetRateCard();
////    $('#lblClientDetails').html("");
////    $('#divShowClientDetails').hide();

////    if (ClientType.trim() == 'RPH') {
////        $('[id$="txtInternalExternalPhysician"]').val(ClientCorpName);
////        $('[id$="hdnReferedPhyID"]').val(ReferingID);
////    }
////    if (ClientType.trim() == 'HOS') {
////        $('[id$="txtReferringHospital"]').val(ClientCorpName);
////        $('[id$="hdfReferalHospitalID"]').val(ReferingID);
////    }
////}

////function CheckClientStatus(ClientStatus, BlockFrom, BlockTo) {
////    if (ClientStatus == 'S' || ClientStatus == 'T') {
////        var displayTxt = '';
////        if (ClientStatus == 'S') {
////            displayTxt = 'This Client was suspended. Suspended from ' + BlockFrom + ' to ' + BlockTo;
////        }
////        else if (ClientStatus == 'T') {
////            displayTxt = 'This Client was Terminated. Terminated from ' + BlockFrom + ' to ' + BlockTo;
////        }
////        if (displayTxt != '') {
////            alert(displayTxt);
////            $('[id$="txtClient"]').val('');
////            $('[id$="txtClient"]').focus();
////            return false;
////        }
////    }
////}

////function ValidateCreditLimit(ClientID) {
////    if (ClientID != '') {
////        OPIPBilling.CheckClientCreditLimit(ClientID, GetResult);
////    }
////}
////function GetResult(StatusAndAmount) {
////    if (StatusAndAmount != '') {
////        var CreditStatus = StatusAndAmount.split('~')[0];
////        var BalanceAmount = StatusAndAmount.split('~')[1];
////        if (CreditStatus == 'Y') {
////            alert('Warning: Credit Limit have exceeded for this Client..!')
////            $('[id$="hdnIsMappedItem"]').val("N");
////            $('[id$="txtClient"]').val("");
////            $('[id$="hdnSelectedClientClientID"]').val($('[id$="hdnBaseClientID"]').val());
////            $('[id$="hdnRateID"]').val($('[id$="hdnBaseRateID"]').val());
////            $('[id$="hdnMappingClientID"]').val("-1");
////            $('[id$="hdnIsCashClient"]').val("N");
////            return false;
////        }
////        else {
////            $('[id$="hdnCashClient"]').val(CreditStatus);
////        }
////        $('[id$="hdnClientBalanceAmount"]').val(BalanceAmount);
////    }
////}


////function countQuickAge(id) {
////    //alert(document.getElementById(id).value);
////    if (document.getElementById(id).value != '') {
////        bD = document.getElementById(id).value.split('/');
////        var agetemp = 0;
////        dd = bD[0];
////        mm = bD[1];
////        yy = bD[2];
////        main = "valid";
////        if ((dd == "__") || (mm == "__") || (yy == "____")) {
////            //document.getElementById('txtAge').value = '';
////            return false;
////        }
////        if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1) || (mm == "") || (dd == "") || (yy == ""))
////            main = "Invalid";
////        else
////            if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
////            main = "Invalid";
////        else
////            if (mm == 2) {
////            if (dd > 29)
////                main = "Invalid";
////            else if ((dd > 28) && (!lyear(yy)))
////                main = "Invalid";
////        }
////        else
////            if ((yy > 9999) || (yy < 0))
////            main = "Invalid";
////        else
////            main = main;
////        if (main == "valid") {
////            function leapyear(a) {
////                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
////                    return true;
////                else
////                    return false;
////            }
////            var days = new Date();

////            var gdate = days.getDate();
////            var gmonth = days.getMonth();
////            var gyear = days.getFullYear();
////            age = gyear - yy;
////            if ((mm == (gmonth + 1)) && (dd <= parseInt(gdate))) {
////                age = age;
////            }
////            else {
////                if (mm <= (gmonth)) {
////                    age = age;
////                }
////                else {
////                    age = age - 1;
////                }
////            }
////            if (age == 0)
////                age = age;
////            agetemp = age;
////            if (mm <= (gmonth + 1))
////                age = age - 1;
////            if ((mm == (gmonth + 1)) && (dd > parseInt(gdate)))
////                age = age + 1;
////            var m;
////            var n;
////            if (mm == 12) { n = 31 - dd; }
////            if (mm == 11) { n = 61 - dd; }
////            if (mm == 10) { n = 92 - dd; }
////            if (mm == 9) { n = 122 - dd; }
////            if (mm == 8) { n = 153 - dd; }
////            if (mm == 7) { n = 184 - dd; }
////            if (mm == 6) { n = 214 - dd; }
////            if (mm == 5) { n = 245 - dd; }
////            if (mm == 4) { n = 275 - dd; }
////            if (mm == 3) { n = 306 - dd; }
////            if (mm == 2) { n = 334 - dd; if (leapyear(yy)) n = n + 1; }
////            if (mm == 1) { n = 365 - dd; if (leapyear(yy)) n = n + 1; }
////            if (gmonth == 1) m = 31;
////            if (gmonth == 2) { m = 59; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 3) { m = 90; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 4) { m = 120; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 5) { m = 151; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 6) { m = 181; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 7) { m = 212; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 8) { m = 243; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 9) { m = 273; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 10) { m = 304; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 11) { m = 334; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 12) { m = 365; if (leapyear(gyear)) m = m + 1; }
////            totdays = (parseInt(age) * 365);
////            totdays += age / 4;
////            totdays = parseInt(totdays) + gdate + m + n;
////            months = age * 12;
////            var t = parseInt(mm);
////            months += 12 - mm;
////            months += gmonth + 1;
////            if (gmonth == 1) p = 31 + gdate;
////            if (gmonth == 2) { p = 59 + gdate; if (leapyear(gyear)) m = m + 1; }
////            if (gmonth == 3) { p = 90 + gdate; if (leapyear(gyear)) p = p + 1; }
////            if (gmonth == 4) { p = 120 + gdate; if (leapyear(gyear)) p = p + 1; }
////            if (gmonth == 5) { p = 151 + gdate; if (leapyear(gyear)) p = p + 1; }
////            if (gmonth == 6) { p = 181 + gdate; if (leapyear(gyear)) p = p + 1; }
////            if (gmonth == 7) { p = 212 + gdate; if (leapyear(gyear)) p = p + 1; }
////            if (gmonth == 8) { p = 243 + gdate; if (leapyear(gyear)) p = p + 1; }
////            if (gmonth == 9) { p = 273 + gdate; if (leapyear(gyear)) p = p + 1; }
////            if (gmonth == 10) { p = 304 + gdate; if (leapyear(gyear)) p = p + 1; }
////            if (gmonth == 11) { p = 334 + gdate; if (leapyear(gyear)) p = p + 1; }
////            if (gmonth == 12) { p = 365 + gdate; if (leapyear(gyear)) p = p + 1; }
////            weeks = totdays / 7;
////            weeks += " weeks";
////            weeks = parseInt(weeks);
////            if (agetemp <= 0) {
////                if (months <= 0) {
////                    if (weeks <= 0) {
////                        if (totdays >= 0) {
////                            if (totdays == 1) {
////                                $('[id$="txtDOBNos"]').val(totdays);
////                                $('[id$="ddlDOBDWMY"]').val('Day(s)');
////                            }
////                            else {
////                                $('[id$="txtDOBNos"]').val(totdays);
////                                $('[id$="ddlDOBDWMY"]').val('Day(s)');
////                            }
////                        }
////                    }
////                    else {
////                        if (weeks == 1) {
////                            $('[id$="txtDOBNos"]').val(weeks);
////                            $('[id$="ddlDOBDWMY"]').val('Week(s)');
////                        }
////                        else {
////                            $('[id$="txtDOBNos"]').val(weeks);
////                            $('[id$="ddlDOBDWMY"]').val('Week(s)');
////                        }
////                    }
////                }
////                else {
////                    if (months == 1) {
////                        $('[id$="txtDOBNos"]').val(months);
////                        $('[id$="ddlDOBDWMY"]').val('Month(s)');
////                    }
////                    else {
////                        $('[id$="txtDOBNos"]').val(months);
////                        $('[id$="ddlDOBDWMY"]').val('Month(s)');
////                    }
////                }
////            }
////            else {
////                if (agetemp == 1) {
////                    $('[id$="txtDOBNos"]').val(agetemp);
////                    $('[id$="ddlDOBDWMY"]').val('Year(s)');
////                }
////                else {
////                    $('[id$="txtDOBNos"]').val(agetemp);
////                    $('[id$="ddlDOBDWMY"]').val('Year(s)');
////                }
////            }

////            function lyear(a) {
////                if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
////                else return false;
////            }
////            $('[id$="ddlSex"]').focus();
////        }
////        else {
////            alert(main + ' Date');
////            $('[id$="txtDOBNos"]').val('');
////            $('[id$="tDOB"]').val('dd//MM//yyyy');
////            $('[id$="tDOB"]').focus();
////        }
////    }
////}

////function getDOB() {
////    if ($.trim($('[id$="txtDOBNos"]').val()) == '') {
////        alert('Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
////        $('[id$="txtDOBNos"]').focus();
////        return false;
////    }
////    return true;
////}


////function resetpreviousradiodetails() {
////    $('[id$="txtTestName"]').val("");
////}
////function boxExpand(me) {
////    // alert(me);
////    boxValue = me.value.length;
////    // alert(boxValue);
////    boxSize = me.size;
////    minNum = 30;
////    maxNum = 500;


////    if (boxValue > minNum) {
////        me.size = boxValue
////    }
////    else
////        if (boxValue < minNum || boxValue != minNnum) {
////        me.size = minNum
////    }
////}
////function AddBillingItemsDetails() {
////    var arrGotValue = new Array();
////    $.ajax({
////        type: "POST",
////        contentType: "application/json; charset=utf-8",
////        url: "../OPIPBilling.asmx/GetBillingItemsDetails",
////        data: JSON.stringify({ OrgID: $('[id$="hdnOrgIDC"]').val(), FeeID: $('[id$="hdnID"]').val(), FeeType: $('[id$="hdnFeeTypeSelected"]').val(), Description: $('[id$="txtTestName"]').val(), ClientID: $('[id$="hdnSelectedClientClientID"]').val(), VisitID: 0, Remarks: '' }),
////        dataType: "json",
////        success: function(data) {
////            for (var i = 0; i < data.d.length; i++) {
////                arrGotValue = data.d[0].ProcedureName.split('^');
////                if (arrGotValue.length > 0) {
////                    ID = arrGotValue[0];
////                    name = arrGotValue[1].trim();
////                    feeType = arrGotValue[2];
////                    amount = arrGotValue[3];
////                    Remarks = arrGotValue[5];
////                    isReimursable = arrGotValue[6];
////                    ReportDate = arrGotValue[7];
////                    ActualAmount = arrGotValue[8];
////                    IsDiscountable = arrGotValue[9];
////                    IsTaxable = arrGotValue[10];
////                    IsRepeatable = arrGotValue[11];
////                    IsSTAT = arrGotValue[12];
////                    IsSMS = arrGotValue[13];
////                    IsNABL = arrGotValue[14];
////                    RateID = arrGotValue[15];
////                    IsOutSource = $('[id$="hdnIsOutSource"]').val();
////                    $('[id$="hdnID"]').val(ID);
////                    $('[id$="hdnName"]').val(name);
////                    $('[id$="hdnFeeTypeSelected"]').val(feeType);
////                    $('[id$="hdnAmt"]').val(amount);
////                    $('[id$="hdnRemarks"]').val(Remarks);
////                    $('[id$="hdnIsRemimbursable"]').val(isReimursable);
////                    $('[id$="hdnReportDate"]').val(ReportDate);
////                    $('[id$="hdnActualAmount"]').val(ActualAmount);
////                    $('[id$="hdnIsDiscountableTest"]').val(IsDiscountable);
////                    $('[id$="hdnIsTaxable"]').val(IsTaxable);
////                    $('[id$="hdnIsRepeatable"]').val(IsRepeatable);
////                    $('[id$="hdnIsSTAT"]').val(IsSTAT);
////                    $('[id$="hdnIsSMS"]').val(IsSMS);
////                    $('[id$="hdnIsNABL"]').val(IsNABL);
////                    $('[id$="hdnBillingItemRateID"]').val(RateID);
////                }
////            }
////        },
////        error: function(result) {
////            alert("Error");
////        }
////    });
////}
////function CallBillItems(OrgID) {
////    if (!validateEvents('Before')) {
////        var FeeType = $('[id$="hdnFeeType1"]').val();
////        var ClientID = $('[id$="hdnSelectedClientClientID"]').val();
////        var pVisitID = -1;
////        var IsMapped = "N";
////        IsMapped = $.trim($('[id$="hdnIsMappedItem"]').val()) == "" || $.trim($('[id$="hdnIsMappedItem"]').val()) == undefined ? "N" : $('[id$="hdnIsMappedItem"]').val();
////        var Remarks = "";
////        sval = FeeType + '~' + ClientID + '~' + IsMapped + '~' + Remarks;
////        $find('billPart_AutoCompleteExtender3').set_contextKey(sval);
////    }
////}
////function clearfn() {
////    if ($('[id$="txtTestName"]').val().length <= 0) {
////        $('[id$="lblInvType"]').html("");
////        $('[id$="hdnIsDiscountableTest"]').val("Y");
////        $('[id$="hdnIsNABL"]').val("Y");
////        $('[id$="hdnIsTaxable"]').val("Y");
////        $('[id$="hdnIsRepeatable"]').val("N");
////        $('[id$="hdnIsSTAT"]').val("N");
////        $('[id$="hdnIsSMS"]').val("N");
////        $('[id$="hdnIsOutSource"]').val("N");
////        $('[id$="hdnBillingItemRateID"]').val("0");
////    }
////}

////function BillingItemSelected(source, eventArgs) {

////    var varGetVal = eventArgs.get_value();
////    var arrGetVal = new Array();
////    arrGetVal = varGetVal.split("^");
////    $('[id$="txtTestName"]').val(arrGetVal[1]);

////    //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
////    var ID;
////    var name;
////    var feeType;
////    var amount;
////    var IsDicountableTest;
////    var IsRepeatable;
////    var Code;
////    var IsOutSource;
////    var list = eventArgs.get_value().split('^');
////    if (list.length > 0) {
////        for (i = 0; i < list.length; i++) {
////            if (list[i] != "") {
////                ID = list[0];
////                name = list[1].trim();
////                feeType = list[2];
////                Code = list[3];
////                IsOutSource = list[4];
////                $('[id$="hdnID"]').val(ID);
////                $('[id$="hdnName"]').val(name);
////                $('[id$="hdnFeeTypeSelected"]').val(feeType);
////                $('[id$="hdnInvCode"]').val(Code);
////                $('[id$="hdnIsOutSource"]').val(IsOutSource);
////            }
////        }

////    }
////    else {
////        $('[id$="hdnID"]').val(-1);
////        $('[id$="hdnFeeTypeSelected"]').val("OTH");
////    }
////    pageLoad();

////    $find('billPart_AutoCompleteExtender3')._onMethodComplete = function(result, context) {

////        $find('billPart_AutoCompleteExtender3')._update(context, result, /* cacheResults */false);

////        webservice_callback(result, context);



////    };
////    var FeeItemArray = new Array();
////    var listLen = document.getElementById('hdnPreviousVisitDetails').value.split('^').length;
////    var flag = 0;
////    if (Number(listLen) > 0) {
////        var ItemArray = new Array();
////        var res = new Array();
////        ItemArray = document.getElementById('hdnPreviousVisitDetails').value.split('^');
////        for (i = 0; i < ItemArray.length; i++) {
////            res = ItemArray[i].split('$');
////            if (Number($('[id$="hdnID"]').val()) == res[1] && 'Y' == res[5] && $('[id$="hdnFeeTypeSelected"]').val() == res[2]) {
////                flag = 1;
////                break;
////            }
////        }

////    }
////    if (flag == 1) {
////        if (window.confirm('Warning: This test already ordered today...! Do you want to continue?')) {
////            flag = 0;
////        }
////        else {
////            $('[id$="txtTestName"]').val("");
////            $('[id$="hdnID"]').val("");
////            $('[id$="hdnName"]').val("");
////            $('[id$="hdnFeeTypeSelected"]').val("");
////            $('[id$="hdnInvCode"]').val("");
////            $('[id$="hdnIsOutSource"]').val("N");
////            $('[id$="txtTestName"]').focus();
////        }

////    }
////    if (flag == 0) {
////        AddBillingItemsDetails();
////    }
////}


////function InvPopulated(sender, e) {

////    var behavior = $find('billPart_AutoCompleteExtender3');
////    var target = behavior.get_completionList();
////    for (i = 0; i < target.childNodes.length; i++) {
////        var text = target.childNodes[i]._value;
////        var ItemArray;
////        ItemArray = text.split('^');
////        if (ItemArray[4].trim().toLowerCase() == 'y') {
////            // target.childNodes[i].className = "focus"
////        }
////    }


////}

////function InvPopulated_old(source, eventArgs) {

////    var behavior = $find('AutoCompleteExtender3');

////    var target = behavior.get_completionList();

////    var i;
////    for (i = 0; i < target.childNodes.length; i++) {

////        var arrOutSourceInvestigaions = new Array();
////        arrOutSourceInvestigaions = document.getElementById('hdnOutSourceInvestigations').value.split('~');

////        for (var j = 0; j < arrOutSourceInvestigaions.length; j++) {
////            var strInv = arrOutSourceInvestigaions[j];
////            if (strInv.trim().toLowerCase() == target.childNodes[i].innerHTML.trim().toLowerCase()) {
////                //target.childNodes[i].innerHTML = "<div style='background-color:Orange; color:Black;'>" + target.childNodes[i].innerHTML + "</div>";
////                target.childNodes[i].className = "OutSource .boxOutSource"
////            }
////        }
////    }
////}
////function expandTextBox(id) {
////    // //debugger;
////    document.getElementById(id).rows = "8";
////    document.getElementById(id).cols = "20";
////    ConverttoUpperCase(id);
////}
////function collapseTextBox(id) {

////    document.getElementById(id).rows = "1";
////    document.getElementById(id).cols = "20";
////    ConverttoUpperCase(id);

////}
////function setDiscount() {

////}
////function AddItems() {


////    if ($.trim($('[id$="txtTestName"]').val()) == "") {
////        alert('Search test names')
////        $('[id$="txtTestName"]').focus();
////        return false;
////    }

////    else {
////        var FeeID = $('[id$="hdnID"]').val();
////        var FeeType = $('[id$="hdnFeeTypeSelected"]').val();
////        DuplicateInv(FeeID, FeeType);
////    }

////}
////var defaultbillflag = 0;
////function CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code) {
////    if ($.trim($('[id$="txtClient"]').val()) == '' && $.trim($('[id$="hdnDefaultOrgBillingItems"]').val()) != '' && defaultbillflag == 0) {
////        defaultbillflag = 1;
////        var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
////        FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
////                + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8] + "~IsDiscountable^" + defalutdata[9]
////                + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + defalutdata[14] + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + document.getElementById('hdnRateID').value + "~Code^" + defalutdata[16] + "|";
////        document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;

////    }

////    var FeeViewStateValue = $('[id$="hdfBillType1"]').val();

////    var FeeGotValue = new Array();
////    FeeGotValue = FeeViewStateValue.split('|');
////    var feeIDALready = new Array();
////    var tempFeeID, tempFeeType, tempOtherID, tempDateTime, tempDescrip, tempPerphyname, tempPerphyID, Quantity = 1;


////    var PaymentAAlreadyPresent = new Array();
////    var iPaymentAlreadyPresent = 0;
////    var iPaymentCount = 0;
////    var arrayMainData = new Array();
////    var arrayChildData = new Array();

////    for (iMain = 0; iMain < FeeGotValue.length - 1; iMain++) {

////        arraySubData = FeeGotValue[iMain].split('~');
////        for (iChild = 0; iChild < arraySubData.length; iChild++) {
////            arrayChildData = arraySubData[iChild].split('^');
////            if (arrayChildData.length > 0) {

////                if (arrayChildData[0] == "FeeID") {
////                    tempFeeID = arrayChildData[1];
////                }
////                if (arrayChildData[0] == "FeeType") {
////                    tempFeeType = arrayChildData[1];
////                }
////                if (arrayChildData[0] == "Descrip") {
////                    tempDescrip = arrayChildData[1];
////                }
////                if (FeeID == tempFeeID && FeeType == tempFeeType && Descrip == tempDescrip) {
////                    iPaymentAlreadyPresent = 1;
////                }
////            }
////        }

////    }


////    if (iPaymentAlreadyPresent == 0) {
////        FeeViewStateValue = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^"
////                + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsRI + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable
////                + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "|" + FeeViewStateValue;

////        $('[id$="hdfBillType1"]').val(FeeViewStateValue);
////        CreateBillItemsTable(0);



////    }
////    else {
////        alert("Item already added");
////        ClearSelectedData(0);
////    }

////}
////function CreateBillItemsTable(id) {

////    $('[id$="divItemTable"]').html("");
////    var newPaymentTables, startPaymentTag, endPaymentTag;
////    var FeeViewStateValue = $('[id$="hdfBillType1"]').val();
////    startPaymentTag = "<TABLE nowrap='nowrap' ID='tabDrg1' Cellpadding='0' Cellspacing='0' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> FeeID </th><th scope='col'  style='width:5%;display:none;'> FeeType </th> <th scope='col' style='width:5%;'> S.No </th> <th scope='col' style='width:6%;'> Code </th> <th scope='col' align='left' style='width:65%;padding-left:2px;'> Description </th>  <th scope='col' align='right' style='display:none;width:5%;'>  Quantity </th><th scope='col' align='right' style='width:8%;'> Amount </th> <th scope='col' style='width:20%;padding-left:2px;display:none;'>Remarks </th> <th scope='col' style='align:right;width:15%;display:block;'> Report Date </th> <th scope='col' style='display:none;'> IsReimbursable </th><th scope='col' style='display:none;'> ActualAmount </th><th scope='col' style='display:none;'> IsDiscountable </th><th scope='col' style='display:none;'> IsTaxable </th><th scope='col' style='display:none;'> IsRepeatable </th><th scope='col' style='display:none;'> IsSTAT </th><th scope='col' style='display:none;'> IsSMS </th><th scope='col' style='display:none;'> IsOutSource </th><th scope='col' style='display:none;'> IsNABL </th><th scope='col' style='display:none;'> BillingItemRateID </th> <th scope='col' align='center'>Delete</th></tr>";
////    endPaymentTag = "</TBODY></TABLE>";
////    newPaymentTables = startPaymentTag;
////    $('[id$="hdnDiscountableTestTotal"]').val(0);
////    $('[id$="hdnTaxableTestToal"]').val(0);
////    var arrayMainData = new Array();
////    var arraySubData = new Array();
////    var arrayChildData = new Array();
////    var iMain = 0;
////    var iChild = 0;
////    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code;
////    var GrossAmt = 0;
////    var DiscountableTestAmount = 0;
////    var TaxableTestAmount = 0;
////    var sno = 1;
////    var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
////    if (id == 0) {
////        if ($.trim($('[id$="txtClient"]').val()) == '' && $.trim($('[id$="hdnDefaultOrgBillingItems"]').val()) != '' && defaultbillflag == 0) {
////            defaultbillflag = 1;
////            // defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
////            FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
////                        + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8]
////                        + "~IsDiscountable^" + defalutdata[9] + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + defalutdata[14] + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + defalutdata[16] + "~Code^" + defalutdata[17] + "|";
////            document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;

////        }
////    }
////    FeeViewStateValue = $('[id$="hdfBillType1"]').val();
////    arrayMainData = FeeViewStateValue.split('|');
////    if (arrayMainData.length > 0) {
////        for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {

////            arraySubData = arrayMainData[iMain].split('~');
////            for (iChild = 0; iChild < arraySubData.length; iChild++) {
////                arrayChildData = arraySubData[iChild].split('^');
////                if (arrayChildData.length > 0) {
////                    if (arrayChildData[0] == "FeeID") {
////                        FeeID = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "FeeType") {
////                        FeeType = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "Descrip") {
////                        Descrip = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "Quantity") {
////                        Quantity = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "Amount") {
////                        Amount = arrayChildData[1];
////                        GrossAmt = Number(GrossAmt) + Number(Amount);
////                    }
////                    if (arrayChildData[0] == "Remarks") {
////                        Remarks = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "ReportDate") {
////                        ReportDate = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsReimbursable") {
////                        IsReimbursable = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "ActualAmount") {
////                        ActualAmount = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsDiscountable") {
////                        IsDiscountable = arrayChildData[1];
////                        if (IsDiscountable == "Y")
////                            DiscountableTestAmount = Number(DiscountableTestAmount) + Number(Amount);
////                    }
////                    if (arrayChildData[0] == "IsTaxable") {
////                        IsTaxable = arrayChildData[1];
////                        if (IsTaxable == "Y")
////                            TaxableTestAmount = Number(TaxableTestAmount) + Number(Amount);
////                    }
////                    if (arrayChildData[0] == "IsRepeatable") {
////                        IsRepeatable = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsSTAT") {
////                        IsSTAT = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsSMS") {
////                        IsSMS = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsOutSource") {
////                        IsOutSource = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsNABL") {
////                        IsNABL = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "BillingItemRateID") {
////                        BillingItemRateID = arrayChildData[1];
////                        //BillingItemRateID = document.getElementById('hdnRateID').value;
////                    }
////                    if (arrayChildData[0] == "Code") {
////                        Code = arrayChildData[1];
////                    }
////                }

////            }
////            $('[id$="divItemTable"]').height('auto'); // document.getElementById('billPart_divItemTable').style.height = "auto";
////            if (iMain >= 4) {
////                //document.getElementById('billPart_divItemTable').style.height = "100px";
////                $('[id$="divItemTable"]').height("100px");
////            }
////            if (IsSTAT == 'Y') {
////                newPaymentTables += "<TR Tooltip='STAT Test' style='background-color:#F7D358;'>";
////            }
////            else if (IsOutSource == 'Y') {
////                newPaymentTables += "<TR Tooltip='Out Source Test' style='background-color:#D0FA58;'>";
////            }
////            else {
////                newPaymentTables += "<TR>";
////            }

////            newPaymentTables += "<TD style='display:none;'>" + FeeID + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + FeeType + "</TD>";
////            newPaymentTables += "<TD>" + sno + "</TD>";
////            newPaymentTables += "<TD>" + Code + "</TD>";
////            newPaymentTables += "<TD style='padding-left:5px' align='left'>" + Descrip + "</TD>"
////            newPaymentTables += "<TD  style='display:none;' align='right'>" + Quantity + "</TD>";
////            newPaymentTables += "<TD  align='right'>" + Amount + "</TD>";
////            newPaymentTables += "<TD  style='display:none;'>" + Remarks + "</TD>";
////            newPaymentTables += "<TD style='display:block;' align='center'>" + ReportDate + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsReimbursable + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + ActualAmount + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsDiscountable + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsTaxable + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsRepeatable + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsSTAT + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsSMS + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsOutSource + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsNABL + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + BillingItemRateID + "</TD>";
////            newPaymentTables += "<TD align='center'><input name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "' onclick='btnDeleteBillingItems_OnClick1(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";

////            sno++;
////        }
////        if (iMain > 0) {
////            $('[id$="lblOrderedItemsCount"]').val(iMain);
////            $('[id$="lblOrderedItemsCount"]').html(Number(iMain));
////            //document.getElementById('billPart_lblOrderedItemsCount').innerHTML = Number(iMain);
////            $('[id$="trOrderedItemsCount"]').show();
////        }
////        else {
////            $('[id$="trOrderedItemsCount"]').hide();
////        }
////    }

////    newPaymentTables += endPaymentTag;
////    document.getElementById('billPart_divItemTable').innerHTML += newPaymentTables;
////    $('[id$="hdnDiscountableTestTotal"]').val(DiscountableTestAmount);
////    $('[id$="hdnTaxableTestToal"]').val(TaxableTestAmount);
////    ClearSelectedData();
////    SetNetValue("ADD");
////    SetGrossValue(GrossAmt)
////    SetOtherCurrValues();

////}

////function SetGrossValue(Amount) {
////    $('[id$="txtGross"]').val(parseFloat(Number(Amount)).toFixed(2));
////    $('[id$="hdnGrossValue"]').val($('[id$="txtGross"]').val());
////    SetNetValue("ADD");
////}

////function ClearPaymentValues() {
////    $('[id$="txtGross"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnGrossValue"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnDiscountAmt"]').val(parseFloat(0).toFixed(2));
////    $('[id$="txtDiscount"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnTaxAmount"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdfTax"]').val(parseFloat(0).toFixed(2));
////    $('[id$="txtTax"]').val(parseFloat(0).toFixed(2));
////    $('[id$="txtServiceCharge"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnServiceCharge"]').val(parseFloat(0).toFixed(2));
////    $('[id$="txtRoundoffAmt"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnRoundOff"]').val(parseFloat(0).toFixed(2));
////    $('[id$="txtNetAmount"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnNetAmount"]').val(parseFloat(0).toFixed(2));
////    $('[id$="txtAmtReceived"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnAmountReceived"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnAmountReceived"]').val("0");
////    $('[id$="ddDiscountPercent"]').attr('disabled', true);
////    $('[id$="ddlDiscountReason"]').val("0");
////    $('[id$="ddlDiscountReason"]').attr('disabled', true);
////    $('[id$="txtEDCess"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnEDCess"]').val(parseFloat(0).toFixed(2));
////    $('[id$="txtSHEDCess"]').val(parseFloat(0).toFixed(2));
////    $('[id$="hdnSHEDCess"]').val(parseFloat(0).toFixed(2));
////    $('[id$="ddlTaxPercent"]').attr('disabled', true);
////    $('[id$="txtAuthorised"]').val("");
////}
////function setDiscountValuesDisable() {
////    $('[id$="ddDiscountPercent"]').attr('disabled', true);
////    $('[id$="txtDiscount"]').attr('readOnly', true);
////    $('[id$="txtAuthorised"]').attr('readOnly', true);
////    $('[id$="txtDiscountReason"]').attr('readOnly', true);
////    $('[id$="ddDiscountPercent"]').val("0")
////    $('[id$="txtDiscount"]').val(parseFloat(0).toFixed(2));
////    $('[id$="txtAuthorised"]').val("");
////    $('[id$="txtDiscountReason"]').val("");
////    $('[id$="hdnDiscountAmt"]').val(parseFloat(0).toFixed(2));
////    $('[id$="ddlDiscountReason"]').val("0")
////    $('[id$="ddlDiscountReason"]').attr('disabled', true);
////}
////function SetNetValue(obj) {

////    var roundOffAmt = 0;
////    var gross = 0;
////    var discount = 0;
////    var TaxAMount = 0;
////    var EDCess = 0;
////    var SHEDCess = 0;
////    var ServiceCharge = 0;
////    if (Number($('[id$="txtGross"]').val()) > 0) {
////        if (Number($('[id$="hdnDiscountableTestTotal"]').val()) > 0) {
////            $('[id$="ddDiscountPercent"]').attr('disabled', false);
////            $('[id$="txtDiscount"]').attr('disabled', false);
////            $('[id$="txtAuthorised"]').attr('readOnly', false);
////            $('[id$="txtDiscountReason"]').attr('readOnly', false);
////            $('[id$="ddlDiscountReason"]').attr('disabled', false);
////            $('[id$="ddlTaxPercent"]').attr('disabled', false);
////        }

////        else if (Number($('[id$="hdnDiscountableTestTotal"]').val()) <= 0 || $.trim($('[id$="txtClient"]').val()) != '') {
////            setDiscountValuesDisable();
////        }
////        if (Number($('[id$="hdnTaxableTestToal"]').val()) > 0) {
////            $('[id$="ddlTaxPercent"]').attr('disabled', false);
////            $('[id$="txtTax"]').attr('readOnly', false);
////        }
////        else if (Number($('[id$="hdnTaxableTestToal"]').val()) <= 0) {
////            $('[id$="ddlTaxPercent"]').attr('disabled', false);
////            $('[id$="txtTax"]').attr('readOnly', false);
////            $('[id$="txtTax"]').val("0.00");
////            $('[id$="hdnTaxAmount"]').val("0");
////        }

////        if (Number($('[id$="hdnAmountReceived"]').val()) <= 0) {
////            gross = Number($('[id$="hdnGrossValue"]').val());

////            if (Number($('[id$="ddlTaxPercent"]').val()) > 0) {
////                $('[id$="txtTax"]').val(parseFloat((parseFloat(Number($('[id$="hdnTaxableTestToal"]').val())) / 100) * (Number($('[id$="ddlTaxPercent"]').val()))).toFixed(2));
////            }
////            TaxAMount = Number($('[id$="txtTax"]').val()).toFixed(2);
////            $('[id$="hdnTaxAmount"]').val(TaxAMount);

////            if ($('[id$="ddDiscountPercent"] option:selected').val() > 0) {
////                $('[id$="txtDiscount"]').val(parseFloat((parseFloat(Number($('[id$="hdnDiscountableTestTotal"]').val())) / 100) * (Number($('[id$="ddDiscountPercent"]').val()))).toFixed(2));
////            }
////            $('[id$="hdnDiscountAmt"]').val($('[id$="txtDiscount"]').val());
////            discount = $('[id$="hdnDiscountAmt"]').val();

////            if (Number($('[id$="hdnDiscountableTestTotal"]').val()) < Number($('[id$="txtDiscount"]').val())) {
////                alert('Ordered test net amount, less then discount amount');
////                discount = 0;
////                $('[id$="txtDiscount"]').val("0.00");
////                $('[id$="hdnDiscountAmt"]').val("0.00");
////                $('[id$="txtAuthorised"]').val("");
////                $('[id$="txtDiscountReason"]').val("");
////                $('[id$="txtDiscount"]').focus();
////            }
////            if ($('[id$="chkEDCess"]').is(':checked')) {
////                EDCess = Number($('[id$="txtGross"]').val()) * 2 / 100;
////                $('[id$="txtEDCess"]').val(parseFloat(EDCess).toFixed(2));
////                $('[id$="hdnEDCess"]').val(EDCess);
////            }
////            else {
////                EDCess = 0;
////                $('[id$="txtEDCess"]').val("0.00");
////                $('[id$="hdnEDCess"]').val(0);
////            }
////            if ($('[id$="chkSHEDCess"]').is(':checked')) {
////                SHEDCess = Number($('[id$="txtGross"]').val()) * 1 / 100;
////                $('[id$="txtSHEDCess"]').val(parseFloat(SHEDCess).toFixed(2));
////                $('[id$="hdnSHEDCess"]').val(SHEDCess);
////            }
////            else {
////                SHEDCess = 0;
////                $('[id$="txtSHEDCess"]').val("0.00");
////                $('[id$="hdnSHEDCess"]').val(0);
////            }
////            ServiceCharge = Number($('[id$="txtServiceCharge"]').val());
////            var netvalue = Number(gross) + Number(TaxAMount) + Number(EDCess) + Number(SHEDCess) + Number(ServiceCharge) - Number(discount);
////            if (Number(netvalue) - Number(getOPCustomRoundoff(netvalue.toFixed(2))) > 0)
////                roundOffAmt = Number(netvalue) - Number(getOPCustomRoundoff(netvalue));
////            else
////                roundOffAmt = Number(getOPCustomRoundoff(netvalue)) - Number(netvalue);

////            $('[id$="txtRoundoffAmt"]').val(parseFloat(roundOffAmt).toFixed(2));
////            $('[id$="hdnRoundOff"]').val(parseFloat(roundOffAmt).toFixed(2));

////            $('[id$="txtNetAmount"]').val(parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2));
////            $('[id$="hdnNetAmount"]').val(parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2));

////            if ($.trim($('[id$="txtClient"]').val()) == '' && obj == "ADD") {
////                document.getElementById('billPart_PaymentType_txtAmount').value = parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2);
////                document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = parseFloat(getOPCustomRoundoff(netvalue)).toFixed(2);
////            }
////            SetOtherCurrValues();
////        }
////        else {
////            if (obj != 'ED') {
////                if (confirm('Amount already received, delete the amount received... Do you want to Delete the amount received?')) {
////                    $('[id$="ddDiscountPercent"]').val(0);
////                    Number($('[id$="txtDiscount"]').val("0.00"));
////                    $('[id$="txtAuthorised"]').val("");
////                    $('[id$="txtDiscountReason"]').val("");
////                    Number($('[id$="hdnDiscountAmt"]').val(0)).toFixed(2);
////                    $('[id$="ddlDiscountReason"]').val(0);
////                    ClearPaymentControlEvents1();
////                    SetNetValue('ADD');
////                }
////                else {
////                    $('[id$="ddDiscountPercent"]').val(0);
////                    $('[id$="ddlDiscountReason"]').val(0);
////                    return false;
////                }
////            }
////        }
////    }
////    else {
////        SetOtherCurrValues();
////        ClearPaymentValues();
////        return false;
////    }
////    if ($.trim($('[id$="txtClient"]').val()) != '') {
////        if ($.trim($('[id$="hdnIsCashClient"]').val()) == "N") {
////            setDiscountValuesDisable();
////        }
////    }

////}

////function getOtherCurrAmtValues(pType, ConValue) {
////    if (pType == "REC") {
////        var pAMt = document.getElementById("billPart_" + ConValue + "_hdnOterCurrReceived").value == "" ? "0" : document.getElementById("billPart_" + ConValue + "_hdnOterCurrReceived").value;
////        return parseFloat(pAMt).toFixed(2);
////    }
////    if (pType == "PAY") {
////        var pAMt = document.getElementById("billPart_" + ConValue + "_hdnOterCurrPayble").value == "" ? "0" : document.getElementById("billPart_" + ConValue + "_hdnOterCurrPayble").value;
////        return parseFloat(pAMt).toFixed(2);
////    }
////    if (pType == "SER") {
////        var pAMt = document.getElementById("billPart_" + ConValue + "_hdnOterCurrServiceCharge").value == "" ? "0" : document.getElementById("billPart_" + ConValue + "_hdnOterCurrServiceCharge").value;
////        return parseFloat(pAMt).toFixed(2);
////    }
////}
////function SetOtherCurrReceived(pCurrAmount, pNetAmount, pServiceCharge, ConValue) {
////    var pTotalNetAmt = Number(pNetAmount);
////    document.getElementById("billPart_" + ConValue + "_lblOtherCurrRecdAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
////    document.getElementById("billPart_" + ConValue + "_hdnOterCurrReceived").value = parseFloat(pTotalNetAmt).toFixed(2);
////    document.getElementById("billPart_" + ConValue + "_hdnOterCurrServiceCharge").value = parseFloat(pServiceCharge).toFixed(2);

////}
////function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

////    var sVal = 0;
////    var ConValue = "OtherCurrencyDisplay1";

////    var sVal = getOtherCurrAmtValues("REC", ConValue);
////    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
////    var tempService = getOtherCurrAmtValues("SER", ConValue);
////    var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

////    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
////    sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
////    sVal = format_number(Number(sVal) + Number(TotalAmount), 4);

////    if (PaymentAmount > 0) {

////        if (Number(sNetValue) >= Number(sVal)) {
////            sVal = format_number(sVal, 4);
////            SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 4), ConValue);
////            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 4);
////            var pScrAmt = Number(pScr) * Number(CurrRate);
////            var pAmt = Number(sVal) * Number(CurrRate);

////            $('[id$="txtServiceCharge"]').val(parseFloat(pScrAmt).toFixed(2));
////            $('[id$="hdnServiceCharge"]').val(format_number(pScrAmt, 2));
////            $('[id$="txtAmtReceived"]').val(parseFloat(pAmt).toFixed(2));
////            $('[id$="hdnAmountReceived"]').val(parseFloat(pAmt).toFixed(2));

////            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);
////            $('[id$="hdnPaymentControlReceivedtemp"]').val(format_number(Number(pAmt), 2));
////            SetNetValue("ED");
////            return true;

////        }
////        else {
////            alert('Amount received is greater than net amount')
////            return false;
////        }
////    }

////}
////function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
////    GetCurrencyValues();
////    var ConValue = "OtherCurrencyDisplay1";
////    var sVal = getOtherCurrAmtValues("REC", ConValue);
////    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
////    var tempService = getOtherCurrAmtValues("SER", ConValue);
////    var CurrRate = GetOtherCurrency("OtherCurrRate");
////    sVal = Number(Number(sVal) - Number(TotalAmount));
////    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
////    var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
////    var pScrAmt = Number(pScr) * Number(CurrRate);
////    var pAmt = Number(sVal) * Number(CurrRate);
////    $('[id$="hdnServiceCharge"]').val(format_number(pScrAmt, 2));
////    $('[id$="txtServiceCharge"]').val(parseFloat(pScrAmt).toFixed(2));
////    var amtRec = 0;
////    $('[id$="hdnAmountReceived"]').val(format_number(Number(sVal) + Number(amtRec), 2));
////    $('[id$="txtAmtReceived"]').val(parseFloat(Number(sVal) + Number(amtRec)).toFixed(2));
////    SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);
////    SetNetValue("ED");



////}
////function ClearPaymentControlEvents1() {
////    document.getElementById('billPart_PaymentType_hdfPaymentType').value = "";
////    PaymentControlclear1();
////    CreatePaymentTables();
////    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrPayble').value = "0";
////    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrReceived').value = "0";
////    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrServiceCharge').value = "0";

////}
////function PaymentControlclear1() {
////    document.getElementById('billPart_PaymentType_txtAmount').value = document.getElementById('billPart_PaymentType_hdfDefaultPaymentMode').value;
////    document.getElementById('billPart_PaymentType_txtAmount').value = "";
////    document.getElementById('billPart_PaymentType_txtNumber').value = "";
////    document.getElementById('billPart_PaymentType_txtBankType').value = "";
////    document.getElementById('billPart_PaymentType_txtRemarks').value = "";
////    document.getElementById('billPart_PaymentType_txtServiceCharge').value = "0";
////    document.getElementById('billPart_PaymentType_txtTotalAmount').innerHTML = "";
////    document.getElementById('billPart_txtAmtReceived').value = "0.00";
////    document.getElementById('billPart_hdnAmountReceived').value = (0).toFixed(2);
////}

////function ClearSelectedData() {
////    $('[id$="txtTestName"]').val("");
////    $('[id$="hdnID"]').val(0);
////    $('[id$="hdnName"]').val("");
////    $('[id$="hdnInvCode"]').val("");
////    $('[id$="hdnFeeTypeSelected"]').val("COM");
////    $('[id$="hdnAmt"]').val(0);
////    $('[id$="hdnRemarks"]').val("");
////    $('[id$="hdnIsRemimbursable"]').val("");
////    $('[id$="hdnReportDate"]').val("");
////    $('[id$="hdnActualAmount"]').val("");
////    $('[id$="hdnIsDiscountableTest"]').val("Y");
////    $('[id$="hdnIsRepeatable"]').val("N");
////    $('[id$="hdnIsSTAT"]').val("N");
////    $('[id$="hdnIsSMS"]').val("N");
////    $('[id$="hdnIsOutSource"]').val("N");
////    $('[id$="hdnIsTaxable"]').val("Y");
////    $('[id$="hdnIsNABL"]').val("Y");
////    $('[id$="hdnBillingItemRateID"]').val("0");
////    $('[id$="txtTestName"]').focus();

////    if ($('[id$="hdfBillType1"]').val() == '')
////        $('[id$="spanAddItems"]').show();
////    if ($('[id$="hdfBillType1"]').val() != '')
////        $('[id$="spanAddItems"]').hide();

////}
////function btnDeleteBillingItems_OnClick1(sEditedData) {
////    ClearPaymentControlEvents1();
////    var PaymentAAlreadyPresent = new Array();
////    var iPaymentAlreadyPresent = 0;
////    var iPaymentCount = 0;

////    var PaymenttempDatas = $('[id$="hdfBillType1"]').val();

////    PaymentAAlreadyPresent = PaymenttempDatas.split('|');
////    if (PaymentAAlreadyPresent.length > 0) {
////        for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
////            if (PaymentAAlreadyPresent[iPaymentCount].toLowerCase() == sEditedData.toLowerCase()) {

////                var tempFeeID, tempFeeType, tempOtherID, iChild, tempFeeDate, tempNRI;
////                var arrayChildData = new Array();

////                arraySubData = PaymentAAlreadyPresent[iPaymentCount].split('~');

////                DeleteFindduplicatcatsItems(arraySubData[0].split('^')[1], arraySubData[1].split('^')[1]);

////                for (iChild = 0; iChild < arraySubData.length; iChild++) {
////                    arrayChildData = arraySubData[iChild].split('^');
////                    if (arrayChildData.length > 0) {

////                        if (arrayChildData[0] == "FeeID") {
////                            tempFeeID = arrayChildData[1];
////                        }
////                        if (arrayChildData[0] == "FeeType") {
////                            tempFeeType = arrayChildData[1];
////                        }
////                        if (arrayChildData[0] == "DTime") {
////                            tempFeeDate = arrayChildData[1];
////                        }
////                        if (arrayChildData[0] == "IsReimbursable") {
////                            tempNRI = arrayChildData[1];
////                        }
////                        //                        DeleteFindduplicatcatsItems(tempFeeID);
////                    }
////                }

////                //                if ("PKG" == tempFeeType) {
////                //                    showorHidechkBox(tempFeeID);
////                //                }
////                PaymentAAlreadyPresent[iPaymentCount] = "";
////            }
////        }
////    }
////    PaymenttempDatas = "";
////    for (iPaymentCount = 0; iPaymentCount < PaymentAAlreadyPresent.length; iPaymentCount++) {
////        if (PaymentAAlreadyPresent[iPaymentCount] != "") {
////            PaymenttempDatas += PaymentAAlreadyPresent[iPaymentCount] + "|";
////        }
////    }

////    var FeeGotValue = new Array();
////    var arrayAmount = new Array();

////    FeeGotValue = sEditedData.split('~');
////    var FeeID;

////    if (FeeGotValue.length > 0) {
////        FeeID = FeeGotValue[2];

////        arrayAmount = FeeID.split('^');
////    }

////    $('[id$="hdfBillType1"]').val(PaymenttempDatas);
////    CreateBillItemsTable(0);
////    DeleteAmountValue(0, 0, 0);
////    ClearPaymentControlEvents();
////    var GrossAmt = $('[id$="hdnGrossValue"]').val();
////    if (GrossAmt < 0) {
////        defaultbillflag = 0;
////    }
////    SetGrossValue(GrossAmt);
////    SetOtherCurrValues();

////}

////function ClearControlValues() {
////    document.getElementById('billPart_PaymentType_hdfPaymentType').value = "";
////    document.getElementById('billPart_PaymentType_hdnPaymentsDeleted').value = "";
////    document.getElementById('billPart_PaymentType_hdnOtherCurrencyID').value = "0";
////    document.getElementById('billPart_PaymentType_hdnOtherCurrency').value = "0";
////    document.getElementById('billPart_PaymentType_hdnPayVariableAmount').value = "0";
////    document.getElementById('billPart_PaymentType_hdnRecdAmount').value = "0";
////    document.getElementById('billPart_PaymentType_hdnlastreceivedamt').value = "0";
////    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrPayble').value = "0";
////    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrReceived').value = "0";
////    document.getElementById('billPart_OtherCurrencyDisplay1_hdnOterCurrServiceCharge').value = "0";
////    document.getElementById('ddCountry').value = document.getElementById('hdnDefaultCountryID').value;
////    if ($('[id$="hdnBillingPageName"]').val() != 'CB') {
////        loadState("0");
////    }
////}


////function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
////    var key;
////    var isCtrl = false;
////    var keychar;
////    var reg;

////    if (window.event) {
////        key = e.keyCode;
////        isCtrl = window.event.ctrlKey
////    }
////    else if (e.which) {
////        key = e.which;
////        isCtrl = e.ctrlKey;
////    }

////    if (isNaN(key)) return true;

////    keychar = String.fromCharCode(key);

////    // check for backspace or delete, or if Ctrl was pressed
////    if (key == 8 || isCtrl) {
////        return true;
////    }

////    reg = /\d/;
////    var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
////    var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

////    return isFirstN || isFirstD || reg.test(keychar);
////}

////function SelectedTempClient(source, eventArgs) {
////    document.getElementById('hdnSelectedClientTempDetails').value = eventArgs.get_value();
////    //    ShowClientDetails();
////    //    TbClientlist();
////    $find('AutoCompleteExtenderClientCorp')._onMethodComplete = function(result, context) {
////        //var Perphysicianname = document.getElementById('txtperphy').value;
////        $find('AutoCompleteExtenderClientCorp')._update(context, result, /* cacheResults */false);
////        if (result == "") {
////            alert('Please select client from the list');
////            $('[id$="txtClient"]').val("");
////            document.getElementById("hdnIsCashClient").value = 'N';
////        }
////    };

////}
////function GetTempReferingHospID(source, eventArgs) {
////    $find('AutoCompleteExtenderReferringHospital')._onMethodComplete = function(result, context) {
////        //var Perphysicianname = document.getElementById('txtperphy').value;
////        $find('AutoCompleteExtenderReferringHospital')._update(context, result, /* cacheResults */false);
////        if (result == "") {
////            alert('Please select hospital from the list');
////            $('[id$="txtReferringHospital"]').val("");
////        }
////    };

////}
////function PhysicianTempSelected(source, eventArgs) {
////    $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
////        //var Perphysicianname = document.getElementById('txtperphy').value;
////        $find('AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
////        if (result == "") {
////            alert('Please select Refering physician from the list');
////            $('[id$="txtInternalExternalPhysician"]').val("");
////        }
////    };

////}
////function ShowClientDetails() {
////    $('[id$="divShowClientDetails"]').hide();
////    var table = '';
////    var tr = '';
////    var end = '</table>';
////    var y = '';
////    $('[id$="lblClientDetails"]').html("");
////    table = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
////                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
////                           + "<th style='width:80px;'>Client Name</th>"
////                           + "<th style='width:50px;'>Client Type</th> </thead>";
////    var SelectedClientList = document.getElementById('hdnSelectedClientTempDetails').value.split("###");
////    var SelectedClientListDetails = SelectedClientList[0].split('^');
////    tr = "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
////                        + SelectedClientListDetails[1] + "</td><td style='width:100px;'>"
////                        + SelectedClientListDetails[11] + "</td></tr>";



////    var tab = table + tr + end;
////    $('[id$="lblClientDetails"]').html(tab);

////}
////function TbClientlist() {
////    var y = '';
////    var x = document.getElementById('hdnSelectedClientTempDetails').value.split("###");
////    var ddlobj = document.getElementById("ddlRate");
////    ddlobj.options.length = 0;
////    for (i = 0; i < x.length - 1; i++) {
////        var y = x[i].split("^");
////        var client = y[4].split("~");
////        var opt = document.createElement("option");
////        document.getElementById("ddlRate").options.add(opt);
////        opt.text = client[1];
////        opt.value = client[0];
////    }

////}
////function ClearRate() {
////    if (document.getElementById('txtClient').value == '') {
////        var ddlobj = document.getElementById("ddlRate");
////        ddlobj.options.length = 0;
////        var opt1 = document.createElement("option");
////        document.getElementById("ddlRate").options.add(opt1);
////        opt1.text = "---Select---";
////        opt1.value = "0";
////    }
////    if ($('[id$="hdnBillingPageName"]').val() == 'LABB') {
////        if ($.trim($('[id$="txtClient"]').val()) != '') {
////            $('[id$="ddlDespatchMode"]').val("0");
////            $('[id$="ddlDespatchMode"]').attr("disabled", true);
////        }
////        else {
////            $('[id$="ddlDespatchMode"]').val("0");
////            $('[id$="ddlDespatchMode"]').attr("disabled", false);
////        }
////    }
////    $('[id$="txtDiscount"]').attr("readOnly", false);
////    $('[id$="txtAuthorised"]').attr("readOnly", false);
////    $('[id$="txtDiscountReason"]').attr("readOnly", false);
////}



//////

////var ns4 = document.layers
////var ie4 = document.all
////var ns6 = document.getElementById && !document.all


////var dragswitch = 0
////var nsx
////var nsy
////var nstemp

////function drag_dropns(name) {
////    if (!ns4)
////        return
////    temp = eval(name)
////    temp.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP)
////    temp.onmousedown = gons
////    temp.onmousemove = dragns
////    temp.onmouseup = stopns
////}

////function gons(e) {
////    temp.captureEvents(Event.MOUSEMOVE)
////    nsx = e.x
////    nsy = e.y
////}
////function dragns(e) {
////    if (dragswitch == 1) {
////        temp.moveBy(e.x - nsx, e.y - nsy)
////        return false
////    }
////}

////function stopns() {
////    temp.releaseEvents(Event.MOUSEMOVE)
////}

//////drag drop function for ie4+ and NS6////
/////////////////////////////////////


////function drag_drop(e) {
////    if (ie4 && dragapproved) {
////        crossobj.style.left = tempx + event.clientX - offsetx
////        crossobj.style.top = tempy + event.clientY - offsety
////        return false
////    }
////    else if (ns6 && dragapproved) {
////        crossobj.style.left = tempx + e.clientX - offsetx + "px"
////        crossobj.style.top = tempy + e.clientY - offsety + "px"
////        return false
////    }
////}

////function initializedrag(e) {
////    crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage
////    var firedobj = ns6 ? e.target : event.srcElement
////    var topelement = ns6 ? "html" : document.compatMode != "BackCompat" ? "documentElement" : "body"
////    while (firedobj.tagName != topelement.toUpperCase() && firedobj.id != "dragbar") {
////        firedobj = ns6 ? firedobj.parentNode : firedobj.parentElement
////    }

////    if (firedobj.id == "dragbar") {
////        offsetx = ie4 ? event.clientX : e.clientX
////        offsety = ie4 ? event.clientY : e.clientY

////        tempx = parseInt(crossobj.style.left)
////        tempy = parseInt(crossobj.style.top)

////        dragapproved = true
////        document.onmousemove = drag_drop
////    }
////}

////////drag drop functions end here//////

////function hidebox() {
////    crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage

////    crossobj.style.display = "none"

////}
////function Itemhidebox() {
////    crossobj = ns6 ? document.getElementById("ShowBillingItems") : document.all.ShowBillingItems
////    crossobj.style.display = "none"
////    document.getElementById("ShowPreviousData").style.display = "block";

////}

////function tbItemshow() {
////    document.onmouseup = new Function("dragapproved=false")
////    document.getElementById("ShowBillingItems").style.display = "block";
////}

////function tbshow() {
////    document.onmouseup = new Function("dragapproved=false")

////    document.getElementById("showimage").style.display = "block";
////}
////function Make_OnClick(sEditedData) {
////}

////function SetOtherCurrValues() {
////    var pnetAmt = document.getElementById('billPart_hdnNetAmount').value;
////    var ConValue = "OtherCurrencyDisplay1";
////    SetPaybleOtherCurr(pnetAmt, ConValue, true);

////}
////function SetOtherCurrPayble(pCurrName, pCurrAmount, pNetAmount, ConValue, IsDisplay) {

////    var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(4) / parseFloat(pCurrAmount).toFixed(2)).toFixed(4);
////    document.getElementById("billPart_" + ConValue + "_lblOtherCurrPaybleName").innerHTML = pCurrName;
////    document.getElementById("billPart_" + ConValue + "_lblOtherCurrRecdName").innerHTML = pCurrName;
////    document.getElementById("billPart_" + ConValue + "_lblOtherCurrPaybleAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
////    document.getElementById("billPart_" + ConValue + "_hdnOterCurrPayble").value = parseFloat(pTotalNetAmt).toFixed(4);

////}
////function isOtherCurrDisplay(pType) {
////    if (pType == "B") {
////        //        document.getElementById("OtherCurrencyDisplay1_tbOtherCurr").style.display = "block";
////    }
////}
////function isOtherCurrDisplay1(pType) {
////    if (pType == "B") {
////        document.getElementById("billPart_" + "OtherCurrencyDisplay1_tbAmountPayble").style.display = "block";
////        document.getElementById("billPart_" + "trOtherCurrency").style.display = "block";
////    }
////    if (pType == "N") {
////        document.getElementById("billPart_" + "OtherCurrencyDisplay1_tbAmountPayble").style.display = "none";
////        document.getElementById("billPart_" + "trOtherCurrency").style.display = "none";
////    }


////}
////function setSexValueQB(sexId, msId, ddMaritalID) {

////    //       alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
////    //        alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);
////    if (document.getElementById(msId).value == '6' || document.getElementById(msId).value == '7' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12' || document.getElementById(msId).value == '9') {
////        document.getElementById(sexId).value = 'M';
////    }
////    else if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '2' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '11') {
////        document.getElementById(sexId).value = 'F';
////    }
////    else {

////        document.getElementById(sexId).value = '0'

////    }
////    if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4') {
////        document.getElementById(ddMaritalID).value = 'S';
////    }
////    else {
////        document.getElementById(ddMaritalID).value = '0';
////    }
////}
////function setSexValueopt(sexId, msId) {
////    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].value);
////    //    alert(document.getElementById(msId).options[document.getElementById(msId).selectedIndex].text);

////    if (document.getElementById(msId).value == '1' || document.getElementById(msId).value == '3' || document.getElementById(msId).value == '8' || document.getElementById(msId).value == '12') {
////        document.getElementById(sexId).value = 'M';
////    }
////    else if (document.getElementById(msId).value == '2' || document.getElementById(msId).value == '4' || document.getElementById(msId).value == '9' || document.getElementById(msId).value == '10' || document.getElementById(msId).value == '11') {
////        document.getElementById(sexId).value = 'F';
////    }

////}
////function pageLoad() {
////    // //debugger;
////    if ($find('billPart_AutoCompleteExtender3')._onMethodComplete != undefined) {
////        $find('billPart_AutoCompleteExtender3')._onMethodComplete = function(result, context) {

////            $find('billPart_AutoCompleteExtender3')._update(context, result, /* cacheResults */false);

////            webservice_callback(result, context);
////        };

////    }
////}
////function webservice_callback(result, context) {

////    if (result == "") {
////        $('[id$="alert"]').html("One or more items does not seem to be selected from the predefined list. This may not get reflected in the reports.");
////    }
////    else {
////        $('[id$="alert"]').html("");
////    }
////}
////function ClearDOB() {

////    if ($('[id$="txtDOBNos"]').val() <= 0) {
////        $('[id$="txtDOBNos"]').val('');
////    }
////    if (Number($('[id$="txtDOBNos"]').val()) >= 150) {
////        alert('Provide a valid year');
////        $('[id$="tDOB"]').val("dd//MM//yyyy");
////        $('[id$="txtDOBNos"]').val("");
////        $('[id$="txtDOBNos"]').focus();
////        return false;
////    }
////}

////function DuplicateInv(Id, Type) {
////    var FeeViewStateValue = $('[id$="hdfBillType1"]').val();
////    var boolval = true;
////    var FeeGotValue = new Array();
////    var setvar = "";
////    if ($('[id$="hdnfinduplicate"]').val() != '') {
////        setvar = $('[id$="hdnfinduplicate"]').val();
////        $('[id$="hdnfinduplicate"]').val("");
////    }
////    var FeeID = $('[id$="hdnID"]').val();
////    var Descrip = $('[id$="hdnName"]').val();
////    var FeeType = $('[id$="hdnFeeTypeSelected"]').val();
////    var Amount = $('[id$="hdnAmt"]').val();
////    var Remarks = $('[id$="hdnRemarks"]').val();
////    var IsRI = $('[id$="hdnIsRemimbursable"]').val();
////    var ReportDate = $('[id$="hdnReportDate"]').val();
////    var ActualAmount = $('[id$="hdnActualAmount"]').val();
////    var IsDiscountable = $('[id$="hdnIsDiscountableTest"]').val();
////    var IsTaxable = $('[id$="hdnIsTaxable"]').val();
////    var IsRepeatable = $('[id$="hdnIsRepeatable"]').val();
////    var IsSTAT = $('[id$="hdnIsSTAT"]').val();
////    var IsSMS = $('[id$="hdnIsSMS"]').val();
////    var IsOutSource = $('[id$="hdnIsOutSource"]').val();
////    var IsNABL = $('[id$="hdnIsNABL"]').val();
////    var BillingItemRateID = $('[id$="hdnBillingItemRateID"]').val();
////    var Code = $('[id$="hdnInvCode"]').val();
////    $.ajax({
////        type: "POST",
////        url: "../OPIPBilling.asmx/GetInvestigationInfo",
////        data: "{ 'ID': '" + Id + "','Type': '" + Type + "' }",
////        contentType: "application/json; charset=utf-8",
////        dataType: "json",
////        async: true,
////        success: function(data) {
////            var Items = data.d;
////            $.each(Items, function(index, Item) {

////                document.getElementById('billPart_hdnfinduplicate').value += Item.InvestigationID + '~' + Item.InvestigationValueID + '~' + Item.Name + '^';


////            });


////            if (setvar != "") {
////                if (FindDuplicatesItems(setvar)) {
////                    boolval = true;
////                }
////                else {
////                    boolval = false;
////                }
////            }
////            else {
////                boolval = true;
////            }
////            if (boolval) {
////                if (Descrip != '') {
////                    if (Number(Amount) <= 0) {
////                        var pBill = confirm("Item amount is zero.\n Do you want to add this item");
////                        if (pBill) {
////                            CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code);
////                            $('[id$="lblInvType"]').html("");
////                        }
////                    }
////                    else {
////                        CmdAddBillItemsType_onclick(FeeID, FeeType, Descrip, Amount, Remarks, IsRI, ReportDate, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code);
////                        $('[id$="lblInvType"]').html("");
////                    }
////                }
////            }
////        },
////        failure: function(msg) {
////            ShowErrorMessage(msg);
////            boolval = false;
////        }

////    });
////    return boolval
////}
////function FindDuplicatesItems(setvar) {
////    var dup = document.getElementById('billPart_hdnfinduplicate').value.split('^');
////    var beforedup = setvar.split('^');
////    if (dup.length > 1) {
////        for (i = 0; i < dup.length; i++) {
////            if (dup[i] != "") {
////                for (j = 0; j < beforedup.length; j++) {
////                    if (beforedup[j].split('~')[0].trim() != "") {
////                        if (dup[i].split('~')[0] == beforedup[j].split('~')[0]) {
////                            if (confirm('This Test is alreay available as a part of Ordered Package / Group. Do You Want Continue')) {
////                                return true;
////                            }
////                            else {
////                                document.getElementById('billPart_hdnfinduplicate').value += setvar;
////                                DeleteFindduplicatcatsItems(dup[i].split('~')[1], dup[i].split('~')[2]);
////                                ClearSelectedData();
////                                return false;
////                            }
////                        }
////                    }

////                }
////            }


////        }
////    }
////    document.getElementById('billPart_hdnfinduplicate').value += setvar;
////    return true;
////}
////function DeleteFindduplicatcatsItems(ID, type) {
////    var temp = $('[id$="hdnfinduplicate"]').val();
////    var temp1 = temp.split('^');
////    $('[id$="hdnfinduplicate"]').val("");
////    if (temp != '') {
////        for (i = 0; i < temp1.length; i++) {
////            if (temp1[i].split('~')[1] != ID && temp1[i].split('~')[2] != type) {
////                document.getElementById('billPart_hdnfinduplicate').value += temp1[i] + '^';
////            }
////        }
////    }
////}

////function PrintBillClear() {
////    clearPageControlsValue('N');
////    //        return true;
////}

////function PrintBillItemsTable() {
////    $('[id$="divItemTable"]').val("");
////    var startHeaderTag, newPaymentTables, startPaymentTag, endPaymentTag, taxDetailsTag;
////    var FeeViewStateValue = $('[id$="hdfBillType1"]').val();
////    startHeaderTag = "<table width='100%' class='dataheaderInvCtrl'><tr><td>";
////    startHeaderTag = startHeaderTag + "<h3 align='center'><u>Service Quotation</u></h3>";
////    startHeaderTag = startHeaderTag + "</td></tr><tr><td align='center'>"
////    startHeaderTag = startHeaderTag + "<b>Client Name:</b> " + $('[id$="txtClient"]').val();
////    startHeaderTag = startHeaderTag + "</td></tr><tr><td> </td></tr><tr><td></td></tr><tr><td>"
////    startPaymentTag = "<TABLE nowrap='nowrap' ID='tabDrg1' Cellpadding='0' Cellspacing='0' border='1' width='100%' class='dataheaderInvCtrl' style='font-size: 12px;' ><TBODY><tr class='dataheader1'><th scope='col'  style='width:5%;display:none;'> FeeID </th><th scope='col'  style='width:5%;display:none;'> FeeType </th> <th scope='col' style='width:5%;'> S.No </th> <th scope='col' style='width:6%;'> Code </th> <th scope='col' align='left' style='width:65%;padding-left:2px;'> Description </th>  <th scope='col' align='right' style='display:none;width:5%;'>  Quantity </th><th scope='col' align='right' style='width:8%;'> Amount </th> <th scope='col' style='width:20%;padding-left:2px;display:none;'>Remarks </th> <th scope='col' style='align:right;width:15%;display:none;'> Report Date </th> <th scope='col' style='display:none;'> IsReimbursable </th><th scope='col' style='display:none;'> ActualAmount </th><th scope='col' style='display:none;'> IsDiscountable </th><th scope='col' style='display:none;'> IsTaxable </th><th scope='col' style='display:none;'> IsRepeatable </th><th scope='col' style='display:none;'> IsSTAT </th><th scope='col' style='display:none;'> IsSMS </th><th scope='col' style='display:none;'> IsOutSource </th><th scope='col' style='display:none;'> IsNABL </th><th scope='col' style='display:none;'> BillingItemRateID </th>"; // <th scope='col' align='center'>Delete</th></tr>";
////    endPaymentTag = "</TBODY></TABLE>";
////    newPaymentTables = startPaymentTag;
////    //    $('[id$="hdnDiscountableTestTotal"]').val(0);
////    //    $('[id$="hdnTaxableTestToal"]').val(0);
////    var arrayMainData = new Array();
////    var arraySubData = new Array();
////    var arrayChildData = new Array();
////    var iMain = 0;
////    var iChild = 0;
////    var FeeID, FeeType, Descrip, Quantity, Amount, Remarks, ReportDate, IsReimbursable, ActualAmount, IsDiscountable, IsTaxable, IsRepeatable, IsSTAT, IsSMS, IsOutSource, IsNABL, BillingItemRateID, Code;
////    var GrossAmt = 0;
////    var DiscountableTestAmount = 0;
////    var TaxableTestAmount = 0;
////    var sno = 1;
////    var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
////    //    if (id == 0) {
////    //        if (document.getElementById('txtClient').value.trim() == '' && document.getElementById('hdnDefaultOrgBillingItems').value.trim() != '' && defaultbillflag == 0) {
////    //            defaultbillflag = 1;
////    //            // defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
////    //            FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
////    //                        + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8]
////    //                        + "~IsDiscountable^" + defalutdata[9] + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] + "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + defalutdata[14] + "~IsNABL^" + defalutdata[15] + "~BillingItemRateID^" + defalutdata[16] + "~Code^" + defalutdata[17] + "|";
////    //            document.getElementById('hdfBillType1').value += FeeViewStateValue;

////    //        }
////    //    }
////    FeeViewStateValue = $('[id$="hdfBillType1"]').val();
////    arrayMainData = FeeViewStateValue.split('|');
////    if (arrayMainData.length > 0) {
////        for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {

////            arraySubData = arrayMainData[iMain].split('~');
////            for (iChild = 0; iChild < arraySubData.length; iChild++) {
////                arrayChildData = arraySubData[iChild].split('^');
////                if (arrayChildData.length > 0) {
////                    if (arrayChildData[0] == "FeeID") {
////                        FeeID = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "FeeType") {
////                        FeeType = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "Descrip") {
////                        Descrip = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "Quantity") {
////                        Quantity = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "Amount") {
////                        Amount = arrayChildData[1];
////                        GrossAmt = Number(GrossAmt) + Number(Amount);
////                    }
////                    if (arrayChildData[0] == "Remarks") {
////                        Remarks = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "ReportDate") {
////                        ReportDate = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsReimbursable") {
////                        IsReimbursable = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "ActualAmount") {
////                        ActualAmount = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsDiscountable") {
////                        IsDiscountable = arrayChildData[1];
////                        if (IsDiscountable == "Y")
////                            DiscountableTestAmount = Number(DiscountableTestAmount) + Number(Amount);
////                    }
////                    if (arrayChildData[0] == "IsTaxable") {
////                        IsTaxable = arrayChildData[1];
////                        if (IsTaxable == "Y")
////                            TaxableTestAmount = Number(TaxableTestAmount) + Number(Amount);
////                    }
////                    if (arrayChildData[0] == "IsRepeatable") {
////                        IsRepeatable = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsSTAT") {
////                        IsSTAT = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsSMS") {
////                        IsSMS = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsOutSource") {
////                        IsOutSource = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "IsNABL") {
////                        IsNABL = arrayChildData[1];
////                    }
////                    if (arrayChildData[0] == "BillingItemRateID") {
////                        BillingItemRateID = arrayChildData[1];
////                        //BillingItemRateID = document.getElementById('hdnRateID').value;
////                    }
////                    if (arrayChildData[0] == "Code") {
////                        Code = arrayChildData[1];
////                    }
////                }
////            }
////            document.getElementById('billPart_divItemTable').style.height = "auto";
////            if (iMain >= 4) {
////                document.getElementById('billPart_divItemTable').style.height = "300px";
////            }
////            newPaymentTables += "<TR><TD style='display:none;'>" + FeeID + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + FeeType + "</TD>";
////            newPaymentTables += "<TD>" + sno + "</TD>";
////            newPaymentTables += "<TD>" + Code + "</TD>";
////            newPaymentTables += "<TD style='padding-left:5px' align='left'>" + Descrip + "</TD>"
////            newPaymentTables += "<TD  style='display:none;' align='right'>" + Quantity + "</TD>";
////            newPaymentTables += "<TD  align='right'>" + Amount + "</TD>";
////            newPaymentTables += "<TD  style='display:none;'>" + Remarks + "</TD>";
////            newPaymentTables += "<TD style='display:none;' align='center'>" + ReportDate + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsReimbursable + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + ActualAmount + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsDiscountable + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsTaxable + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsRepeatable + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsSTAT + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsSMS + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsOutSource + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + IsNABL + "</TD>";
////            newPaymentTables += "<TD style='display:none;'>" + BillingItemRateID + "</TD>";
////            //            newPaymentTables += "<TD align='center'><input name='FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + Descrip + "~Amount^" + Amount + "~Quantity^" + Quantity + "~Remarks^" + Remarks + "~ReportDate^" + ReportDate + "~IsReimbursable^" + IsReimbursable + "~ActualAmount^" + ActualAmount + "~IsDiscountable^" + IsDiscountable + "~IsTaxable^" + IsTaxable + "~IsRepeatable^" + IsRepeatable + "~IsSTAT^" + IsSTAT + "~IsSMS^" + IsSMS + "~IsOutSource^" + IsOutSource + "~IsNABL^" + IsNABL + "~BillingItemRateID^" + BillingItemRateID + "~Code^" + Code + "' onclick='btnDeleteBillingItems_OnClick1(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";

////            sno++;
////            if (IsSMS == 'Y')
////                $(".divItemTable tr:first").css("background-color", "red")
////        }
////        if (iMain > 0) {
////            document.getElementById('billPart_lblOrderedItemsCount').innerHTML = Number(iMain);
////            $('[id$="trOrderedItemsCount"]').show();
////        }
////        else {
////            $('[id$="trOrderedItemsCount"]').hide();
////        }
////    }

////    newPaymentTables += endPaymentTag;
////    var vddDiscountID;
////    vddDiscountID = document.getElementById('billPart_ddDiscountPercent');
////    var vDiscount = vddDiscountID.options[vddDiscountID.selectedIndex].value;
////    var vDiscountText = '';
////    if (vDiscount == null || vDiscount == '0') {
////        vDiscountText = '';
////    }
////    else {
////        vDiscountText = " (" + vddDiscountID.options[vddDiscountID.selectedIndex].text + ")";
////    }
////    newPaymentTables = newPaymentTables + "</td></tr><tr><td> </td></tr><tr><td> </td></tr><tr><td><table align='center' cellpadding='2' cellspacing='2'>";
////    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblGross').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtGross').value + "</td></tr>";
////    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblDiscount').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtDiscount').value + vDiscountText + "</td></tr>";
////    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblTaxt').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtTax').value + "</td></tr>";
////    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_Rs_EDCess').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtEDCess').value + "</td></tr>";
////    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_Rs_SHEDCess').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtSHEDCess').value + "</td></tr>";
////    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblServiceCharge').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtServiceCharge').value + "</td></tr>";
////    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblRoundOffAmt').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtRoundoffAmt').value + "</td></tr>";
////    newPaymentTables = newPaymentTables + "<tr><td> </td><td>---------</td></tr>";
////    newPaymentTables = newPaymentTables + "<tr><td><b>" + document.getElementById('billPart_lblNetValue').innerHTML + " </b></td><td>" + document.getElementById('billPart_txtNetAmount').value + "</td></tr>";
////    newPaymentTables = newPaymentTables + "<tr><td> </td><td>---------</td></tr>";
////    newPaymentTables = newPaymentTables + "</table></td></tr></table>"
////    document.getElementById('lblPrintCCBillDetail').innerHTML += startHeaderTag + newPaymentTables;
////    //    $('[id$="hdnDiscountableTestTotal"]').val(DiscountableTestAmount);
////    //    $('[id$="hdnTaxableTestToal"]').val(TaxableTestAmount);
////    ClearSelectedData();
////    SetNetValue("ADD");
////    SetGrossValue(GrossAmt)
////    SetOtherCurrValues();

////}
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
                    ValidationWindowEmail('' + vCheck + ' "' + result[i] + '" ' + vEmailAddress  ,  AlertType  );

                    var elements = document.getElementById('chkDespatchMode');
                    if (document.getElementById('txtEmail').value != '') {

                        //elements.cells[0].childNodes[0].checked = false;
                        document.getElementById('chkDespatchMode_0').checked = false;
                        document.getElementById('txtEmail').value = "";
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
                jQuery('#okbtnid').css("width", "80px");
                jQuery('#okbtnid').css("height", "30px");
            }
        }).dialog("open");
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
            if ((Cmth == (gmonth))) {
                var dm = DaysInMonth(dobYear, gmonth);
                //gday = dm;
                if (((Cmth == (gmonth)) && (Cmth == (02)) && ((gmonth) == (02))) && (dm == 28 || dm == 29)) {
                    if (dm == 28) { gday = dm; }
                    if (dm == 29) { gday = dm; }
                }
            }

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


function CheckSMS() {
    // var elements = document.getElementById('chkDespatchMode');
    if (document.getElementById('txtMobile').value != '') {
        document.getElementById('chkDespatchMode_1').checked = true;
        //document.getElementById('chkDespatchMode_1').checked = true;
        //elements.cells[1].childNodes[0].checked = true;
    }
    else {
        document.getElementById('chkDespatchMode_1').checked = false;
        //elements.cells[1].childNodes[0].checked = false;
       // document.getElementById('chkDespatchMode_1').checked = false;
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

function ClearAutocomp() {
    if (AutoCompSelected == false) {

        document.getElementById('billPart_txtTestName').value = '';

        return false;
    }

}
function LoadPreviousBillingItems_HC() {
 if (document.getElementById('hdnPreviousVisitDetails') != null) {
        document.getElementById('hdnPreviousVisitDetails').value = ''; //$('[id$="hdnPreviousVisitDetails"]').val("");
        $.ajax({
            type: "POST",
            url: "../HCService.asmx/GetPreviousVisitBilling_HC",
            data: "{ 'ID': '" + parseInt(document.getElementById('hdnBookingID').value) + "','Type': '" + $('#hdnSelectTypeID').val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var ArrayItems = data.d;
                var Items = ArrayItems[0];

                $.each(Items, function(index, Item) {
                    document.getElementById('hdnPreviousVisitDetails').value += Item.BillDescription + '$' +
                    Item.GroupID + '$' + Item.FeeType + '$' + Item.Remarks + '$' +
                     Item.BookingID + '$' + Item.State + '$' + Item.PatientName + '$' + Item.PatientNumber + '^';

                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
                    setPreviousBillingItems();
                });
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }
}

function getDiscount(){
    var pBookingID = 0;
    pBookingID = parseInt(document.getElementById('hdnBookingID').value);

    $.ajax({
        type: "POST",
        url: "../OPIPBilling.asmx/GetHCPaymentDetails",
        data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, BookingID: pBookingID }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            var Items = data.d;
            $.each(Items, function(index, Item) {
                var DiscValue = 0;
                for (var k = 0; k < Items.length; k++) {
                    DiscValue = Items[k].ProcedureType;
                    $('#billPart_ddDiscountPercent option').map(function() {
                        if ($(this).val() == DiscValue) return this;
                    }).attr('selected', 'selected');
                }
                SetDiscountAmt(); SetNetValue('ADD');
            });
        },
        failure: function(msg) {
            ShowErrorMessage(msg);
        }
    });
}

function setPreviousBillingItems() {
    var TVisit = "N";
    var tblStatr = "";
    var tblBoody = "";
    objAlert = SListForAppMsg.Get("HomeCollection_homecollection_aspx_alrt") != null ? SListForAppMsg.Get("HomeCollection_homecollection_aspx_alrt") : "Alert";
    var UsrAdd = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") : "Add";
    var vVisitDate = SListForAppDisplay.Get("Billing_CommonBilling_js_65") == null ? "Visit Date" : SListForAppDisplay.Get("Billing_CommonBilling_js_65");
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
                + "<table border='1' id='tblItems' cellpadding='1' cellspacing='0' class='gridView' style='text-align: left; font-size: 11px;' width='100%'>"
                + "<tr class = 'gridHeader' style='font-weight:bold;color:#fff;'><td style='width:30px;color:#fff;'>S.No</td><td  style='width:330px;color:#fff;'>Test Name</td><td  style='display:none;width:30px;color:#fff;'>ID</td><td style='width:30px;color:#fff;'>Type</td>"
                + "<td style='width:30px;color:#fff;'><input id='chkAll' name='chkAll1'  onclick='chkSelectAll(document.form1.chkAll);' value='SelectAll' type='checkbox'>All</input></td><td  style='display:none;'>IsAddToday</td><td  style='display:none;'>IsOutSource</td><td  style='display:none;'>TestCode</td></tr>";

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

                

                if (predate == curdate) {
                    var str = "chkboxItem" + k;
                    var txt = "txtBillItems" + j;
                    if (defalutdata[0] != res[1] && defalutdata[1] != res[2]) {
                       // tblBoody += "<tr><td style='font-weight:bold' colspan='4' title=''>Visit Date : " + curdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>";
                        tblBoody += "<tr style='font-weight:bold;'><td>" + parseInt(j + 1) + "</td><td>" + res[0] + "</td><td style='display:none;'>" + res[1] + "</td><td >" + res[2] +
                                "</td><td ><input  id='" + str + "' name='chkAll'   value='" + '' + "' type='checkbox'  /></td><td style='display:none;'></td><td style='display:none;'>N</td><td style='display:none;'> </td></tr>";

                        j++;
                        k++;
                    }
                } else {
                    count++;
                    if (count == 6) {
                        break;
                    }
                    tblBoody += "<tr><td style='font-weight:bold' colspan='4' title='" + '' + "'>" + vVisitDate + " : " + curdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td></tr>";
                    predate = curdate;
                    j = 0;
                    i--;

                }
                
                
            }

        }
        tblTotal += "<tr><td colspan='4' align='center'><input id='adds' type='button' value=" + UsrAdd + " onclick='javascript:AddPreviousVisitItemsToBilling(); getDiscount();'  class='btn'/ ></td></tr>";
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
