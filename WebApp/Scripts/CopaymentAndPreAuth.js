function Calc_Copayment() {
    var totalMedial = ToInternalFormat($('#billPart_hdnGrossValue'));
    var totalNonMedical = 0.00;
    var CoPaymentlogic = parseFloat(getPaymentlogicID());
    var Copayment_Percentage = parseFloat(getCoPaymentperent()).toFixed(2);

    var PrAutAmount = parseFloat(getPreAuthamount()).toFixed(2);
    var Claimlogin = getClaimID();
    var CoPaymentType = GetCopaymentType();
    var _claimAmount = 0;
    var _actualCoPayment = 0;
    var NetValue = ToInternalFormat($('#billPart_hdnNetAmount'));
    var AmountRevd = ToInternalFormat($('#billPart_txtAmtReceived'));
    var TotalDiscount = ToInternalFormat($('#billPart_txtDiscount'));

    var DifferenceAmount = 0;
    var TotalAmount = 0;
    var PatientNetAmount = 0;

    $('#billPart_hdnCoPaymentType').val(CoPaymentType);
    $('#billPart_hdnClaimID').val(Claimlogin);
    $('#billPart_hdnCoPaymentlogicID').val(CoPaymentlogic);
    $('#billPart_hdnCoPaymentPerCentage').val(Copayment_Percentage);
    if (document.getElementById('HdnCoPay').value == 'Y') {
        document.getElementById('billPart_tdCopayment').style.display = "block";
    } else { document.getElementById('billPart_tdCopayment').style.display = "none"; }
    if (parseFloat(Copayment_Percentage) == 0) {
    
        _actualCoPayment = Copayment_Login(CoPaymentlogic, Copayment_Percentage, PrAutAmount, totalMedial, CoPaymentType);
        _claimAmount = Copayment_Deducted_Login(Claimlogin, PrAutAmount, totalMedial, _actualCoPayment);

        var _grossBill = parseFloat(totalNonMedical) + parseFloat(totalMedial);
        var _amountReceivable = 0;
        _amountReceivable = parseFloat(_grossBill) - parseFloat(_claimAmount);

        if (parseFloat(_amountReceivable) >= 0) {
            DifferenceAmount = 0;
        }
        else {
            DifferenceAmount = parseFloat(_claimAmount) > (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment)) ? (parseFloat(_claimAmount) - (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment))) : 0;
        }
        TotalAmount = (parseFloat(DifferenceAmount) + parseFloat(_actualCoPayment) + parseFloat(totalNonMedical)).toFixed(2);

        if (parseFloat(TotalAmount) > parseFloat(TotalDiscount)) {
            PatientNetAmount = (parseFloat(TotalAmount) - parseFloat(TotalDiscount)).toFixed(2);
        }
        else {
            PatientNetAmount = 0;
        }
        document.getElementById('billPart_lblActualCopaymenttxt').innerHTML = _actualCoPayment.toFixed(2);
        document.getElementById("billPart_lblClaminAmount").innerHTML = parseFloat(_claimAmount).toFixed(2);
        document.getElementById("billPart_lblMedical").innerHTML = parseFloat(totalMedial).toFixed(2);
        document.getElementById("billPart_lblNonMedical").innerHTML = parseFloat(totalNonMedical).toFixed(2);
        document.getElementById('billPart_hdnTotalCopayment').value = _actualCoPayment.toFixed(2);
        document.getElementById('billPart_hdnClaim').value = parseFloat(_claimAmount).toFixed(2);
        document.getElementById("billPart_lblDifferenceAmount").innerHTML = parseFloat(DifferenceAmount).toFixed(2);

        $('#billPart_lblTotal').html(PatientNetAmount);
        $('#billPart_hdnTowardsAmount').val(PatientNetAmount);

        ToTargetFormat($('#billPart_lblActualCopaymenttxt'));
        ToTargetFormat($('#billPart_lblClaminAmount'));
        ToTargetFormat($('#billPart_lblDifferenceAmount'));
        ToTargetFormat($('#billPart_hdnTowardsAmount'));
        ToTargetFormat($('#billPart_lblTotal'));
        if (document.getElementById('HdnCoPay').value == 'Y') {
            document.getElementById('billPart_divPaymentType').style.display = "none";
        }

    }
     if (parseFloat(Copayment_Percentage) > 0) {

        _actualCoPayment = Copayment_Login(CoPaymentlogic, Copayment_Percentage, PrAutAmount, totalMedial, CoPaymentType);
        _claimAmount = Copayment_Deducted_Login(Claimlogin, PrAutAmount, totalMedial, _actualCoPayment);

        var _grossBill = parseFloat(totalNonMedical) + parseFloat(totalMedial);
        var _amountReceivable = 0;
        _amountReceivable = parseFloat(_grossBill) - parseFloat(_claimAmount);

        if (parseFloat(_amountReceivable) >= 0) {
            DifferenceAmount = 0;
        }
        else {
            DifferenceAmount = parseFloat(_claimAmount) > (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment)) ? (parseFloat(_claimAmount) - (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment))) : 0;
        }

        TotalAmount = (parseFloat(DifferenceAmount) + parseFloat(_actualCoPayment) + parseFloat(totalNonMedical)).toFixed(2);
        if (parseFloat(TotalAmount) > parseFloat(TotalDiscount)) {
            PatientNetAmount = (parseFloat(TotalAmount) - parseFloat(TotalDiscount)).toFixed(2);
        }
        else {
            PatientNetAmount = 0;
        }
        document.getElementById('billPart_lblActualCopaymenttxt').innerHTML = _actualCoPayment.toFixed(2);
        document.getElementById("billPart_lblClaminAmount").innerHTML = parseFloat(_claimAmount).toFixed(2);
        document.getElementById("billPart_lblMedical").innerHTML = parseFloat(totalMedial).toFixed(2);
        document.getElementById("billPart_lblNonMedical").innerHTML = parseFloat(totalNonMedical).toFixed(2);
        document.getElementById('billPart_hdnTotalCopayment').value = _actualCoPayment.toFixed(2);
        document.getElementById('billPart_hdnClaim').value = parseFloat(_claimAmount).toFixed(2);
        document.getElementById("billPart_lblDifferenceAmount").innerHTML = parseFloat(DifferenceAmount).toFixed(2);

        $('#billPart_lblTotal').html(PatientNetAmount);
        $('#billPart_hdnTowardsAmount').val(PatientNetAmount);

        ToTargetFormat($('#billPart_lblActualCopaymenttxt'));
        ToTargetFormat($('#billPart_lblClaminAmount'));
        ToTargetFormat($('#billPart_lblDifferenceAmount'));
        ToTargetFormat($('#billPart_hdnTowardsAmount'));
        ToTargetFormat($('#billPart_lblTotal'));
        document.getElementById('billPart_divPaymentType').style.display = "table-row";
    }
   
    else {
        // DifferenceAmount = (parseFloat(totalMedial) - parseFloat(_claimAmount)).toFixed(2);
        
        var _grossBill = parseFloat(totalNonMedical) + parseFloat(totalMedial);
        var _amountReceivable = 0;
        _amountReceivable = parseFloat(_grossBill) - parseFloat(_claimAmount);

        if (parseFloat(_amountReceivable) >= 0) {
            DifferenceAmount = 0;
        }
        else {
            DifferenceAmount = parseFloat(_claimAmount) > (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment)) ? (parseFloat(_claimAmount) - (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment))) : 0;
        }
        TotalAmount = (parseFloat(DifferenceAmount) + parseFloat(_actualCoPayment) + parseFloat(totalNonMedical)).toFixed(2);

        if (parseFloat(TotalAmount) > parseFloat(TotalDiscount)) {
            PatientNetAmount = (parseFloat(TotalAmount) - parseFloat(TotalDiscount)).toFixed(2);
        }
        else {
            PatientNetAmount = 0;
        }
        document.getElementById('billPart_lblActualCopaymenttxt').innerHTML = _actualCoPayment.toFixed(2);
        document.getElementById("billPart_lblClaminAmount").innerHTML = parseFloat(_claimAmount).toFixed(2);
        document.getElementById("billPart_lblMedical").innerHTML = parseFloat(totalMedial).toFixed(2);
        document.getElementById("billPart_lblNonMedical").innerHTML = parseFloat(totalNonMedical).toFixed(2);
        document.getElementById('billPart_hdnTotalCopayment').value = _actualCoPayment.toFixed(2);
        document.getElementById('billPart_hdnClaim').value = parseFloat(_claimAmount).toFixed(2);
        document.getElementById("billPart_lblDifferenceAmount").innerHTML = parseFloat(DifferenceAmount).toFixed(2);

        $('#lblTotal').html(PatientNetAmount);
        $('#hdnTowardsAmount').val(PatientNetAmount);

        ToTargetFormat($('#lblActualCopaymenttxt'));
        ToTargetFormat($('#lblClaminAmount'));
        ToTargetFormat($('#lblDifferenceAmount'));
        ToTargetFormat($('#hdnTowardsAmount'));
        ToTargetFormat($('#lblTotal'));
    }

}

function Copayment_Login(CoPaymentlogic, Copayment_Percentage, PrAutAmount, totalMedial, CoPaymentType) {
    var _actualCoPayment = 0;

    if (parseFloat(Copayment_Percentage) > 0 && parseFloat(ToInternalFormat($('#billPart_txtGross'))) > 0) {
        if (CoPaymentlogic == 0) {
            if (parseFloat(totalMedial) < parseFloat(PrAutAmount)) {
                if (CoPaymentType == "Value") {
                    _actualCoPayment = parseFloat(Copayment_Percentage);
                }
                else {
                    _actualCoPayment = (parseFloat(totalMedial) * parseFloat(Copayment_Percentage)) / 100;
                }
            }
            else {
                if (CoPaymentType == "Value") {
                    _actualCoPayment = parseFloat(Copayment_Percentage);
                }
                else {
                    _actualCoPayment = (parseFloat(PrAutAmount) * parseFloat(Copayment_Percentage)) / 100;
                }
            }
        }
        else if (CoPaymentlogic == 1) {
            if (CoPaymentType == "Value") {
                _actualCoPayment = parseFloat(Copayment_Percentage);
            }
            else {
                _actualCoPayment = (parseFloat(totalMedial) * parseFloat(Copayment_Percentage)) / 100;
            }
        }
        else if (CoPaymentlogic == 2) {
            if (parseFloat(PrAutAmount) > 0) {
                if (CoPaymentType == "Value") {
                    _actualCoPayment = parseFloat(Copayment_Percentage);
                }
                else {
                    _actualCoPayment = (parseFloat(PrAutAmount) * parseFloat(Copayment_Percentage)) / 100;
                }
            }
            else {
                _actualCoPayment = 0;
            }
        }
        else {
            if (CoPaymentType == "Value") {
                _actualCoPayment = parseFloat(Copayment_Percentage);
            }
            else {
                _actualCoPayment = 0;
            }
        }
    }
    else {
        _actualCoPayment = 0;
    }

    return _actualCoPayment;
}
function Copayment_Deducted_Login(Claimlogin, PrAutAmount, totalMedical, _actualCoPayment) {
    var _claimAmount = 0;
    if (parseFloat(Claimlogin) == 1) {
        if (parseFloat(totalMedical) >= parseFloat(_actualCoPayment)) {
            _claimAmount = parseFloat(totalMedical) - parseFloat(_actualCoPayment);

            if (_claimAmount > PrAutAmount) {
                _claimAmount = _claimAmount;
            }
        }
        else {
            _claimAmount = 0;
        }
    }
    else if (parseFloat(Claimlogin) == 2) {
        if (parseFloat(PrAutAmount) >= parseFloat(_actualCoPayment)) {
            _claimAmount = parseFloat(PrAutAmount) - parseFloat(_actualCoPayment);

            if (_claimAmount > totalMedical) {
                _claimAmount = totalMedical;
            }
        }
        else {
            _claimAmount = 0;
        }
    }
    else {
        if (parseFloat(PrAutAmount) > parseFloat(totalMedical)) {
            _claimAmount = parseFloat(totalMedical);
        }
        else {
            _claimAmount = parseFloat(PrAutAmount);
        }
    }
    return _claimAmount;
}

function setPrAutAmount() {
    var PrAutAmount = 0;

    $('#hdnPreAuthType').val(GetPreAuthType());
    $('#hdnPreAuthPercentage').val(GetPreAuthPerent());
    ToTargetFormat($('#hdnPreAuthPercentage'));

    var Percentage = ToInternalFormat($('#hdnPreAuthPercentage'));
    var totalNonMedical = parseFloat(ToInternalFormat($('#lblNonMedicalAmt')));
    var totalMedial = parseFloat(parseFloat(ToInternalFormat($('#dspData_lblTotalAmt'))) - parseFloat(totalNonMedical)).toFixed(2);
    var NetValue = ToInternalFormat($('#txtGrandTotal'));

    if (GetPreAuthType() == "Percentage") {
        if (parseFloat(Percentage) > 0 && parseFloat(totalMedial) > 0) {
            PrAutAmount = (parseFloat(totalMedial) * parseFloat(Percentage)) / 100;
            $('#uctlClientTpa_txtAuthamount').val(PrAutAmount);
            ToTargetFormat($('#uctlClientTpa_txtAuthamount'));
        }
        else {
            PrAutAmount = parseFloat(totalMedial);
            $('#uctlClientTpa_txtAuthamount').val(PrAutAmount);
            ToTargetFormat($('#uctlClientTpa_txtAuthamount'));
        }
    }

    $('#hdnPreAuthAmount').val(ToInternalFormat($('#uctlClientTpa_txtAuthamount')));
    ToTargetFormat($('#hdnPreAuthAmount'));
}

function DisplayCoPayMent() {

    if (document.getElementById('txtClient').value != '' && document.getElementById('HdnCoPay').value == 'Y') {
        document.getElementById('CoPayMent').style.display = "block";
        if (document.getElementById('txtLocClient').disabled = true) {
            document.getElementById('txtLocClient').disabled = false;
        }
        else {
            document.getElementById('txtLocClient').disabled = false;
        }
    }
    else {
        document.getElementById('HdnCoPay').value = 'N';
        document.getElementById('txtLocClient').disabled = true;
        document.getElementById('hdnClienID').value = 0;
        document.getElementById('CoPayMent').style.display = "none";
        document.getElementById('billPart_divPaymentType').style.display = "table-row";
        document.getElementById('uctlClientTpa_ddlCopaymentType').value = 0;  //'--Select--';
        document.getElementById('uctlClientTpa_txtCoperent').value = '0.00';
    }
}


function ValidateCopay() {
    /* Added By Venkatesh S */
    var AlertType = SListForAppMsg.Get('Billing_Scripts_CopaymentAndPreAuth_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_CopaymentAndPreAuth_js_01');
    var vPatientDue = SListForAppMsg.Get('Billing_Scripts_CopaymentAndPreAuth_js_02') == null ? "Patient Due Not Allowed in Co-Payment. \r\n Enter patient net payable amount by selecting appropriate payment mode." : SListForAppMsg.Get('Billing_Scripts_CopaymentAndPreAuth_js_02');
    var vPatientNetPayableAmt = SListForAppMsg.Get('Billing_Scripts_CopaymentAndPreAuth_js_03') == null ? "The amount can not be greater then the patient net payable amount" : SListForAppMsg.Get('Billing_Scripts_CopaymentAndPreAuth_js_03');
   
    var patient_NetpayAmt = document.getElementById('billPart_lblTotal').innerHTML;
    var AmountRecived = document.getElementById('billPart_txtAmtReceived').value;
    //var AmountRecived = document.getElementById('billPart_hdnAmountReceived').value;
    if (document.getElementById('HdnCoPay').value == 'Y' && patient_NetpayAmt > 0) {

        var PaymentType_txtAmount = document.getElementById('billPart_PaymentType_txtAmount').value;

        if (parseFloat(patient_NetpayAmt) > 0) {

            if (parseFloat(AmountRecived) < parseFloat(patient_NetpayAmt)) {
                //alert('Patient Due Not Allowed in Co-Payment. \r\n Enter patient net payable amount by selecting appropriate payment mode.');
                ValidationWindow(vPatientDue, AlertType);
                return false;
            }

            else if (parseFloat(AmountRecived) > parseFloat(patient_NetpayAmt)) {
                // alert('The amount can not be greater then the patient net payable amount');
                ValidationWindow(vPatientNetPayableAmt, AlertType);
                return false;
            }
        }
        return true;
    }

}