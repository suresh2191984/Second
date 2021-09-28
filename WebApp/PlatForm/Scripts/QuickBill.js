function GetRefPhysicianDetails(pType) {
    var refType = "";
    var refID = 0
    var refName = "";
    var tRes = refType + "~" + refID + "~" + refName;
    var pVal = document.getElementById(pType + "_hdnPhysicianValue").value.split("~");

    if (pVal.length == 3) {
        refType = pVal[0];
        refID = pVal[1];
        refName = pVal[2];
        tRes = refType + "~" + refID + "~" + refName;
    }
    return tRes;
}
function DisableReferDoctor(pType, pValue) {
    if (pValue == "Y") {
        document.getElementById(pType + "_qrefphy").disabled = true;
    }
    else {
        document.getElementById(pType + "_qrefphy").disabled = false;
    }
}

function setReferringDetails(pType, RefphyId, ReferralType) {
    if (ReferralType == "I") {
        var ddl = document.getElementById(pType + "_ddlPhysician");
        var phName = '';
        document.getElementById(pType + "_rdoInternal").checked = true;
        showInternalRefPhy(pType + "_rdoInternal");
        ddl.value = RefphyId;
        if (ddl.selectedIndex > -1) {
            document.getElementById(pType + "_txtNew").value = ddl.options[ddl.selectedIndex].text;
            phName = ddl.options[ddl.selectedIndex].text;
        }
        document.getElementById(pType + "_hdnPhysicianValue").value = ReferralType + '~' + RefphyId + '~' + phName;

    }
    else if (ReferralType == "E") {
        var ddl = document.getElementById(pType + "_ddlRefPhysician");
        var phName = '';
        document.getElementById(pType + "_rdoExternal").checked = true;
        showExternalRefPhy(pType + "_rdoExternal");
        ddl.value = RefphyId;
        if (ddl.selectedIndex > -1) {
            document.getElementById(pType + "_txtNew").value = ddl.options[ddl.selectedIndex].text;
            phName = ddl.options[ddl.selectedIndex].text;
        }
        document.getElementById(pType + "_hdnPhysicianValue").value = ReferralType + '~' + RefphyId + '~' + phName;
    }
    else {
        DisableReferDoctor(pType, "N");
    }

    if (document.getElementById(pType + "_hdnPhysicianValue").value != '') {
        var ArrayValue = document.getElementById(pType + "_hdnPhysicianValue").value.split('~');
        $('#QPR_hdnPhysicianValue').val(document.getElementById(pType + "_hdnPhysicianValue").value + '~0');
        $('#QPR_hdnReferType').val(ArrayValue[0]);
        $('#QPR_txtReferringName').val(ArrayValue[2]);
        document.getElementById('QPR_txtReferringName').disabled = true;
    }


}
function setOldReferringdetails() {
    var ReferralType = document.getElementById('hdnRefferedPhyType').value;
    var RefphyId = document.getElementById('hdnRefferedPhyID').value;
    if (RefphyId <= 0) {
        DisableReferDoctor("ReferDoctor1", "N");
    }
    else {
        setReferringDetails("ReferDoctor1", RefphyId, ReferralType);
        DisableReferDoctor("ReferDoctor1", "Y");
    }
}
function clearOldReferringdetails() {
    document.getElementById('hdnRefferedPhyType').value = "";
    document.getElementById('hdnRefferedPhyID').value = 0;
}
function showInternalRefPhy(ID) {
    document.getElementById('dvH').style.display = "none";
    var pID = ID.split("_")[0];
    FilterItemsReset1(pID);
    if (document.getElementById(ID).checked == true) {
        document.getElementById(pID + "_divPhysicianName").style.display = 'block';
        document.getElementById(pID + "_divRefPhysicianName").style.display = 'none';
        document.getElementById(pID + "_divAddNewPhysician").style.display = 'none';
        document.getElementById(pID + "_txtNew").value = '';
        document.getElementById(pID + "_rdoExternal").checked = false
        document.getElementById(pID + "_trDDLPanel").style.display = "block";
        document.getElementById(pID + "_hdnReferralType").value = 'I';
    }
    else {
        document.getElementById(pID + "_trDDLPanel").style.display = "none";
        document.getElementById('dvH').style.display = "block";
        document.getElementById('ddlHospital').selectedIndex = 0;
    }

}

function showExternalRefPhy(ID) {

    document.getElementById('dvH').style.display = "block";
    var pID = ID.split("_")[0];
    FilterItemsReset2(pID);
    if (document.getElementById(ID).checked == true) {
        document.getElementById(pID + "_divPhysicianName").style.display = 'none';
        document.getElementById(pID + "_divRefPhysicianName").style.display = 'block';
        document.getElementById(pID + "_divAddNewPhysician").style.display = 'none';
        document.getElementById(pID + "_txtNew").value = '';
        document.getElementById(pID + "_rdoInternal").checked = false;
        document.getElementById(pID + "_trDDLPanel").style.display = "block";
        document.getElementById(pID + "_hdnReferralType").value = 'E';
    }
    else {
        document.getElementById(pID + "_divAddNewPhysician").style.display = 'none';
        document.getElementById(pID + "_trDDLPanel").style.display = "none";
    }
}

function resetRefPhyDetails(ID) {
    document.getElementById(ID + "_trDDLPanel").style.display = 'none';
    document.getElementById(ID + "_rdoInternal").checked = false;
    document.getElementById(ID + "_rdoExternal").checked = false
    document.getElementById('dvH').style.display = 'none';
    document.getElementById('QPR_txtReferringName').disabled = false;
}

function SetOtherCurrPayble(pCurrName, pCurrAmount, pNetAmount, ConValue, IsDisplay) {

    var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(2) / parseFloat(pCurrAmount).toFixed(2)).toFixed(2);
    document.getElementById(ConValue + "_lblOtherCurrPaybleName").innerHTML = pCurrName;

    document.getElementById(ConValue + "_lblOtherCurrRecdName").innerHTML = pCurrName;
    document.getElementById(ConValue + "_lblOtherCurrPaybleAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById(ConValue + "_hdnOterCurrPayble").value = parseFloat(pTotalNetAmt).toFixed(2);
    ToTargetFormat($("#" + ConValue + "_lblOtherCurrPaybleAmount"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrPayble"));

}
function SetOtherCurrReceived(pCurrAmount, pNetAmount, pServiceCharge, ConValue) {
    var pTotalNetAmt = Number(pNetAmount);
    document.getElementById(ConValue + "_lblOtherCurrRecdAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById(ConValue + "_hdnOterCurrReceived").value = parseFloat(pTotalNetAmt).toFixed(2);
    document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value = parseFloat(pServiceCharge).toFixed(2);
    ToTargetFormat($("#" + ConValue + "_lblOtherCurrRecdAmount"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrReceived"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrServiceCharge"));


}
function isOtherCurrDisplay(pType) {
    if (pType == "B") {
        //        document.getElementById("OtherCurrencyDisplay1_tbOtherCurr").style.display = "block";
    }
}
function isOtherCurrDisplay1(pType) {
    if (pType == "B") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "block";
    }
    if (pType == "N") {
        document.getElementById("OtherCurrencyDisplay1_tbAmountPayble").style.display = "none";
    }


}
function getOtherCurrAmtValues(pType, ConValue) {
    if (pType == "REC") {

        var pAMt = ToInternalFormat($("#" + ConValue + "_hdnOterCurrReceived")) == "" ? "0" : parseFloat(ToInternalFormat($("#" + ConValue + "_hdnOterCurrReceived"))).toFixed(2);
        return pAMt;
    }
    if (pType == "PAY") {
        var pAMt = ToInternalFormat($("#" + ConValue + "_hdnOterCurrPayble")) == "" ? "0" : parseFloat(ToInternalFormat($("#" + ConValue + "_hdnOterCurrPayble"))).toFixed(2);
        return parseFloat(pAMt).toFixed(2);
    }
    if (pType == "SER") {
        var pAMt = ToInternalFormat($("#" + ConValue + "_hdnOterCurrServiceCharge")) == "" ? "0" : parseFloat(ToInternalFormat($("#" + ConValue + "_hdnOterCurrServiceCharge"))).toFixed(2);
        return parseFloat(pAMt).toFixed(2);
    }
}
function ClearOtherCurrValues(ConValue) {
    document.getElementById(ConValue + "_lblOtherCurrRecdAmount").innerHTML = 0;
    document.getElementById(ConValue + "_hdnOterCurrReceived").value = 0;
    document.getElementById(ConValue + "_hdnOterCurrServiceCharge").value = 0;
    ToTargetFormat($("#" + ConValue + "_lblOtherCurrRecdAmount"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrServiceCharge"));
    ToTargetFormat($("#" + ConValue + "_hdnOterCurrReceived"));

}

function Calc_Copayment() {
    //    if (document.getElementById('QPR_rdoOP')!=null && document.getElementById('QPR_rdoOP').checked == true && getCreditBill() == true
    //          && document.getElementById('btnSave').style.display == "block")

    if (getCreditBill() == true) {
        var itemCopayAMT = parseFloat(ToInternalFormat($('#hdnItemCoPaymentTotal'))).toFixed(2);
        var totalNonMedical = parseFloat(ToInternalFormat($('#lblNonMedicalAmt'))).toFixed(2);
        if ($('#lblTotalAmt').length > 0) {
            var totalMedial = parseFloat(parseFloat(ToInternalFormat($('#lblTotalAmt'))) - parseFloat(totalNonMedical)).toFixed(2);
        }
        else {
            var totalMedial = parseFloat(parseFloat(ToInternalFormat($('#txtTotal'))) - parseFloat(totalNonMedical)).toFixed(2);
        }
        var CoPaymentlogic = parseFloat(getPaymentlogicID());
        var Copayment_Percentage = parseFloat(getCoPaymentperent()).toFixed(2);
        setPrAutAmount();
        var PrAutAmount = isNaN(parseFloat(getPreAuthamount()).toFixed(2)) ? 0 : parseFloat(getPreAuthamount()).toFixed(2);
        var Claimlogin = getClaimID();
        var CoPaymentType = GetCopaymentType();
        var _claimAmount = 0;
        var _actualCoPayment = 0;
        var NetValue = ToInternalFormat($('#txtGrandTotal'));
        var AmountRevd = ToInternalFormat($('#txtAmountRecieved'));
        if ($('#txtTotalDiscount').length > 0) {
            var TotalDiscount = ToInternalFormat($('#txtTotalDiscount'));
        }
        else {
            var TotalDiscount = ToInternalFormat($('#txtbillingleveldiscounts'));
        }

        var DifferenceAmount = 0;
        var TotalAmount = 0;
        var PatientNetAmount = 0;
        var TotalClaimAmount = 0;
        var _Discount = 0;
        var _AmountReceive = 0;
        $('#hdnCoPaymentType').val(CoPaymentType);
        $('#hdnClaimID').val(Claimlogin);
        $('#hdnCoPaymentlogicID').val(CoPaymentlogic);
        $('#hdnCoPaymentPerCentage').val(Copayment_Percentage);
        ToTargetFormat($('#hdnCoPaymentPerCentage'));

        $('#tdCopayment').css('display', 'block');
        if (parseFloat(PrAutAmount) > 0 || parseFloat(Copayment_Percentage) > 0) {

            _actualCoPayment = Copayment_Login(CoPaymentlogic, Copayment_Percentage, PrAutAmount, totalMedial, CoPaymentType);
            _claimAmount = Copayment_Deducted_Login(Claimlogin, PrAutAmount, totalMedial, _actualCoPayment);
            //added by pavithra starts

            if (CoPaymentlogic == -1) {
                if (parseFloat(PrAutAmount) < parseFloat(totalMedial)) {
                    _actualCoPayment = parseFloat(totalMedial) - parseFloat(PrAutAmount)

                }
            }
            /////ends
            // DifferenceAmount = (parseFloat(totalMedial) - parseFloat(_claimAmount)).toFixed(2);
            var _grossBill = parseFloat(totalNonMedical) + parseFloat(totalMedial);
            var _amountReceivable = 0;
            _amountReceivable = parseFloat(_grossBill) - parseFloat(_claimAmount);
            DifferenceAmount = parseFloat(totalMedial) - parseFloat(_claimAmount) - parseFloat(_actualCoPayment);
            //            if (parseFloat(_amountReceivable) >= 0) {
            //                DifferenceAmount = 0;
            //            }
            //            else {
            //                DifferenceAmount = parseFloat(_claimAmount) > (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment)) ? (parseFloat(_claimAmount) - (parseFloat(totalNonMedical) + parseFloat(_actualCoPayment))) : 0;
            //            } 

            TotalAmount = (parseFloat(DifferenceAmount) + parseFloat(_actualCoPayment) + parseFloat(totalNonMedical)).toFixed(2);
            TotalClaimAmount = parseFloat(_claimAmount);
            if (parseFloat(TotalAmount) > parseFloat(TotalDiscount)) {
                PatientNetAmount = parseFloat(parseFloat(TotalAmount) - parseFloat(TotalDiscount)).toFixed(2);
                _Discount = parseFloat(TotalAmount) - parseFloat(TotalDiscount);
            }
            else {
                PatientNetAmount = parseFloat(0).toFixed(2);
                _Discount = parseFloat(TotalDiscount) - parseFloat(TotalAmount);

            }
            if (parseFloat(PatientNetAmount) == 0 && parseFloat(_Discount) > 0) {
                if (parseFloat(TotalClaimAmount) > parseFloat(_Discount)) {
                    _claimAmount = (parseFloat(TotalClaimAmount) - parseFloat(_Discount)).toFixed(2);

                }
                else {
                    _claimAmount = parseFloat(0).toFixed(2);
                }
            }

            if (parseFloat(PatientNetAmount) >= parseFloat(AmountRevd)) {
                PatientNetAmount = parseFloat(parseFloat(PatientNetAmount) - parseFloat(AmountRevd)).toFixed(2);

            }
            else {

                _AmountReceive = parseFloat(parseFloat(AmountRevd) - parseFloat(PatientNetAmount)).toFixed(2);
                PatientNetAmount = parseFloat(0).toFixed(2);
                _claimAmount = parseFloat(parseFloat(_claimAmount) - parseFloat(_AmountReceive)).toFixed(2);
            }
            document.getElementById("lblpreauthAmount").innerHTML = parseFloat(PrAutAmount).toFixed(2);
            document.getElementById('lblActualCopaymenttxt').innerHTML = parseFloat(_actualCoPayment).toFixed(2);
            document.getElementById("lblClaminAmount").innerHTML = parseFloat(_claimAmount).toFixed(2);
            document.getElementById("lblMedical").innerHTML = parseFloat(totalMedial).toFixed(2);
            document.getElementById("lblNonMedical").innerHTML = parseFloat(totalNonMedical).toFixed(2);
            document.getElementById('hdnTotalCopayment').value = parseFloat(_actualCoPayment).toFixed(2);
            document.getElementById('hdnClaim').value = parseFloat(_claimAmount).toFixed(2);
            document.getElementById("lblDifferenceAmount").innerHTML = parseFloat(DifferenceAmount).toFixed(2);
            document.getElementById("lblTotal").innerHTML = parseFloat(PatientNetAmount).toFixed(2);
            document.getElementById("hdnTowardsAmount").value = parseFloat(PatientNetAmount).toFixed(2);
            //$('#lblTotal').html(PatientNetAmount);
            //$('#hdnTowardsAmount').val(PatientNetAmount);

            ToTargetFormat($('#lblActualCopaymenttxt'));
            ToTargetFormat($('#lblClaminAmount'));
            ToTargetFormat($('#lblDifferenceAmount'));
            ToTargetFormat($('#hdnTowardsAmount'));
            ToTargetFormat($('#lblTotal'));
            ToTargetFormat($('#lblpreauthAmount'));


        }
        else {
            // DifferenceAmount = (parseFloat(totalMedial) - parseFloat(_claimAmount)).toFixed(2);
            //added by pavithra
            if (parseFloat(PrAutAmount) == 0 && CoPaymentlogic == -1) {
                _claimAmount = parseFloat(totalMedial);
                TotalAmount = parseFloat(totalNonMedical);
            }

            ///ends
            var _grossBill = parseFloat(totalNonMedical) + parseFloat(totalMedial);
            var _amountReceivable = 0;
            _amountReceivable = parseFloat(_grossBill) - parseFloat(_claimAmount);
            DifferenceAmount = parseFloat(totalMedial) - parseFloat(_claimAmount) - parseFloat(_actualCoPayment);





            TotalAmount = (parseFloat(DifferenceAmount) + parseFloat(_actualCoPayment) + parseFloat(totalNonMedical)).toFixed(2);

            TotalClaimAmount = parseFloat(_claimAmount);
            if (parseFloat(TotalAmount) > parseFloat(TotalDiscount)) {
                PatientNetAmount = parseFloat(parseFloat(TotalAmount) - parseFloat(TotalDiscount)).toFixed(2);
                _Discount = parseFloat(TotalAmount) - parseFloat(TotalDiscount);
            }
            else {
                PatientNetAmount = parseFloat(0).toFixed(2);
                _Discount = parseFloat(TotalDiscount) - parseFloat(TotalAmount);

            }
            if (PatientNetAmount == 0 && parseFloat(_Discount) > 0) {
                if (parseFloat(TotalClaimAmount) > parseFloat(_Discount)) {
                    _claimAmount = parseFloat(parseFloat(TotalClaimAmount) - parseFloat(_Discount)).toFixed(2);

                }
                else {
                    _claimAmount = parseFloat(0).toFixed(2);
                }
            }
            if (parseFloat(PatientNetAmount) >= parseFloat(AmountRevd)) {
                PatientNetAmount = parseFloat(parseFloat(PatientNetAmount) - parseFloat(AmountRevd)).toFixed(2);
                PrAutAmount = parseFloat(_claimAmount).toFixed(2);

            }
            else {
                _AmountReceive = parseFloat(parseFloat(AmountRevd) - parseFloat(PatientNetAmount)).toFixed(2);
                _claimAmount = parseFloat(parseFloat(_claimAmount) - parseFloat(_AmountReceive)).toFixed(2);
                PrAutAmount = parseFloat(_claimAmount).toFixed(2);
            }
//item Copay Deduct
            PrAutAmount = parseFloat(PrAutAmount).toFixed(2) - parseFloat(itemCopayAMT).toFixed(2);
            _claimAmount = parseFloat(_claimAmount).toFixed(2) - parseFloat(itemCopayAMT).toFixed(2);
            _actualCoPayment = (parseFloat(_actualCoPayment) + parseFloat(itemCopayAMT)).toFixed(2);
            PatientNetAmount = (parseFloat(PatientNetAmount) + parseFloat(itemCopayAMT)).toFixed(2);
            $('#hdnPreAuthAmount').val(PrAutAmount);
            ToTargetFormat($('#hdnPreAuthAmount'));
//item Copay Deduct
            
            document.getElementById("lblpreauthAmount").innerHTML = parseFloat(PrAutAmount).toFixed(2);
            document.getElementById('lblActualCopaymenttxt').innerHTML = parseFloat(_actualCoPayment).toFixed(2);
            document.getElementById("lblClaminAmount").innerHTML = parseFloat(_claimAmount).toFixed(2);
            document.getElementById("lblMedical").innerHTML = parseFloat(totalMedial).toFixed(2);
            document.getElementById("lblNonMedical").innerHTML = parseFloat(totalNonMedical).toFixed(2);
            document.getElementById('hdnTotalCopayment').value = parseFloat(_actualCoPayment).toFixed(2);
            document.getElementById('hdnClaim').value = parseFloat(_claimAmount).toFixed(2);
            document.getElementById("lblDifferenceAmount").innerHTML = parseFloat(DifferenceAmount).toFixed(2);
            document.getElementById("lblTotal").innerHTML = parseFloat(PatientNetAmount).toFixed(2);
            document.getElementById("hdnTowardsAmount").value = parseFloat(PatientNetAmount).toFixed(2);

            //$('#lblTotal').html(PatientNetAmount);
            //$('#hdnTowardsAmount').val(PatientNetAmount);

            ToTargetFormat($('#lblActualCopaymenttxt'));
            ToTargetFormat($('#lblClaminAmount'));
            ToTargetFormat($('#lblDifferenceAmount'));
            ToTargetFormat($('#hdnTowardsAmount'));
            ToTargetFormat($('#lblTotal'));
            ToTargetFormat($('#lblpreauthAmount'));
        }
    }

}

function Copayment_Login(CoPaymentlogic, Copayment_Percentage, PrAutAmount, totalMedial, CoPaymentType) {
    var _actualCoPayment = 0;
    var strValue = SListForAppDisplay.Get("PlatForm_Scripts_QuickBill_js_01") == null ? "Value" : SListForAppDisplay.Get("PlatForm_Scripts_QuickBill_js_01");
    if (parseFloat(Copayment_Percentage) > 0 && parseFloat(ToInternalFormat($('#txtGrandTotal'))) > 0) {
        if (CoPaymentlogic == 0) {
            if (parseFloat(totalMedial) < parseFloat(PrAutAmount)) {
                if (CoPaymentType == strValue) {
                    _actualCoPayment = parseFloat(Copayment_Percentage);
                }
                else {
                    _actualCoPayment = (parseFloat(totalMedial) * parseFloat(Copayment_Percentage)) / 100;
                }
            }
            else {
                if (CoPaymentType == strValue) {
                    _actualCoPayment = parseFloat(Copayment_Percentage);
                }
                else {
                    _actualCoPayment = (parseFloat(PrAutAmount) * parseFloat(Copayment_Percentage)) / 100;
                }
            }
        }
        else if (CoPaymentlogic == 1) {
        if (CoPaymentType == strValue) {
                _actualCoPayment = parseFloat(Copayment_Percentage);
            }
            else {
                _actualCoPayment = (parseFloat(totalMedial) * parseFloat(Copayment_Percentage)) / 100;
            }
        }
        else if (CoPaymentlogic == 2) {
            if (parseFloat(PrAutAmount) > 0) {
                if (CoPaymentType == strValue) {
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
            if (CoPaymentType == strValue) {
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
                _claimAmount = PrAutAmount;
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
     var strPercentage = SListForAppDisplay.Get("PlatForm_Scripts_QuickBill_js_02") == null ? "Percentage" : SListForAppDisplay.Get("PlatForm_Scripts_QuickBill_js_02");
    $('#hdnPreAuthType').val(GetPreAuthType());
    $('#hdnPreAuthPercentage').val(GetPreAuthPerent());
    ToTargetFormat($('#hdnPreAuthPercentage'));

    var Percentage = ToInternalFormat($('#hdnPreAuthPercentage'));
    var totalNonMedical = parseFloat(ToInternalFormat($('#lblNonMedicalAmt'))).toFixed(2);
    var totalMedial = parseFloat(parseFloat(ToInternalFormat($('#lblTotalAmt'))) - parseFloat(totalNonMedical)).toFixed(2);
    var NetValue = ToInternalFormat($('#txtGrandTotal'));

    if (GetPreAuthType() == strPercentage) {
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
