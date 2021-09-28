

function CalcItemCost(txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                            hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                            txtRecievedAdvance, txtGrandTotal, hdnGross,
                            txtindDiscount, hdnDiscountArray, hdnNonMedicalItem,
                            lblNonReimbuse, hdnMedical, lblReimburse,
                            nonReimburseChkBoxID, flag, txtReimbursableAmount, txtNonReimbursableAmount, hdnOldNonReimbursableAmount, hdnOldReimbursableAmount, hdnEligibleRoomAmount, chkIsSelect) {

    var Quantity = document.getElementById(txtQuantity);
    var UnitPrice = document.getElementById(txtUnitPrice);
    var Amount = document.getElementById(txtAmount);
    var hdnAmount = document.getElementById(hdnTotalAmount);
    var ReimbursableAmount = document.getElementById(txtReimbursableAmount);
    var NonReimbursableAmount = document.getElementById(txtNonReimbursableAmount);
    var hdnEligibleRoomAmount = document.getElementById(hdnEligibleRoomAmount);
    var hdnOldNonReimbursableAmount = document.getElementById(hdnOldNonReimbursableAmount);
    var hdnOldReimbursableAmount = document.getElementById(hdnOldReimbursableAmount);

    var OldPrice = document.getElementById(hdnOldPrice);
    var OldQuantity = document.getElementById(hdnOldQuantity);

    //var oldAmt = Number(OldPrice.value) * Number(OldQuantity.value);$('#OldPrice.id')
    var oldAmt = Number(ToInternalFormat($('#'+OldPrice.id))) * Number(ToInternalFormat($('#'+OldQuantity.id)));

    var Gross = document.getElementById(txtGross);
    var Discount = document.getElementById(txtDiscount);
    var RecievedAdvance = document.getElementById(txtRecievedAdvance);
    var GrandTotal = document.getElementById(txtGrandTotal);

    //var OldPricetoDelete = chkIsnumber(OldPrice.value);
    //var OldQuantitytoDelete = chkIsnumber(OldQuantity.value);
    
    var OldPricetoDelete = chkIsnumber(ToInternalFormat($('#'+OldPrice.id)));
    var OldQuantitytoDelete = chkIsnumber(ToInternalFormat($('#'+OldQuantity.id)));       
    

    var hdnGrossBillAmount = document.getElementById(hdnGross);
    var OldAmounttoDelete = format_number((Number(OldPricetoDelete) * Number(OldQuantitytoDelete)), 2);


    var IndividualDiscount = document.getElementById(txtindDiscount);
    var chkIsSelect = document.getElementById(chkIsSelect);
    chkIsSelect.checked = true;
    
    if (IndividualDiscount == "" || IndividualDiscount == null) {
        IndividualDiscount = 0;
    }

    //var OldAmounttoDelete = 0;
    //format_number(Number(UnitPrice.value), 2);

   // Quantity.value = chkIsnumber(Quantity.value);
    //UnitPrice.value = chkIsnumber(UnitPrice.value);
    
    Quantity.value = chkIsnumber(ToInternalFormat($('#'+Quantity.id)));
    UnitPrice.value = chkIsnumber(ToInternalFormat($('#'+UnitPrice.id)));
            
    UnitPrice.value = format_number(Number(UnitPrice.value), 2);
    Amount.value = format_number((Number(Quantity.value) * Number(UnitPrice.value)), 2);
    
    ToTargetFormat($('#'+Quantity.id));
    ToTargetFormat($('#'+UnitPrice.id));
    ToTargetFormat($('#'+Amount.id));      
   

    if (ReimbursableAmount != null && NonReimbursableAmount != null && hdnOldNonReimbursableAmount != null && hdnOldReimbursableAmount != null) {

       // var oldRAmt = hdnOldReimbursableAmount.value
       var oldRAmt = ToInternalFormat($('#'+hdnOldReimbursableAmount.id));
        var NewRAmt = 0;
        
        var ReimbursableRoomRent = 0;
        //ReimbursableRoomRent = format_number((Number(Quantity.value) * Number(hdnEligibleRoomAmount.value)), 2);
        ReimbursableRoomRent = format_number((Number(ToInternalFormat($('#'+Quantity.id))) * Number(ToInternalFormat($('#'+hdnEligibleRoomAmount.id)))), 2);
        
        if (ReimbursableRoomRent == 0) {
            // ReimbursableAmount.value = Amount.value;
            ReimbursableAmount.value = ToInternalFormat($('#'+Amount.id));
            ToTargetFormat($('#'+ReimbursableAmount.id));  
            
            //NewRAmt = format_number(Number(Amount.value), 2);
            NewRAmt = format_number(Number(ToInternalFormat($('#'+Amount.id))), 2);
            
            NonReimbursableRoomRent = 0;
        }
        //else if (ReimbursableRoomRent != 0 && ReimbursableRoomRent > Number(Amount.value)) {
        else if (ReimbursableRoomRent != 0 && ReimbursableRoomRent > Number(ToInternalFormat($('#'+Amount.id)))) {        
            //ReimbursableAmount.value = Amount.value;
            ReimbursableAmount.value = ToInternalFormat($('#'+Amount.id));
            ToTargetFormat($('#'+ReimbursableAmount.id));  
            
            //NewRAmt = format_number(Number(Amount.value), 2);
             NewRAmt = format_number(Number(ToInternalFormat($('#'+Amount.id))), 2);
            NonReimbursableRoomRent = 0;
        }
        else {
            ReimbursableAmount.value = ReimbursableRoomRent;
           // NewRAmt = format_number((Number(Quantity.value) * Number(hdnEligibleRoomAmount.value)), 2);
           NewRAmt = format_number((Number(ToInternalFormat($('#'+Quantity.id))) * Number(ToInternalFormat($('#'+hdnEligibleRoomAmount.id)))), 2);
        }
        var NonReimbursableRoomRent = 0;
        //NonReimbursableRoomRent = format_number((Number(Amount.value) - Number(ReimbursableAmount.value)), 2);
        NonReimbursableRoomRent = format_number((Number(ToInternalFormat($('#'+Amount.id))) - Number(ToInternalFormat($('#'+ReimbursableAmount.id)))), 2);
      
        if (NonReimbursableRoomRent > 0) {
            NonReimbursableAmount.value = NonReimbursableRoomRent;
            
            ToTargetFormat($('#'+NonReimbursableAmount.id)); 
        }
        else {
            NonReimbursableAmount.value = "0.00";
            ToTargetFormat($('#'+NonReimbursableAmount.id)); 
        }

        //var oldNonRAmt = hdnOldNonReimbursableAmount.value
        var oldNonRAmt = ToInternalFormat($('#'+hdnOldNonReimbursableAmount.id));
        
       // if (Number(Amount.value) > Number(ReimbursableAmount.value)) {
        if (Number(ToInternalFormat($('#'+Amount.id))) > Number(ToInternalFormat($('#'+ReimbursableAmount.id)))) {
            //var NewNonRAmt = format_number((Number(Amount.value) - Number(ReimbursableAmount.value)), 2);
            var NewNonRAmt = format_number((Number(ToInternalFormat($('#'+Amount.id))) - Number(ToInternalFormat($('#'+ReimbursableAmount.id)))), 2);
            
        }
        else {
            var NewNonRAmt = 0.00;
        }

        

//        if (Number(NonReimbursableAmount.value) > 0) {
//            document.getElementById(nonReimburseChkBoxID).checked = false;
//        }
    }
    
    
   // hdnAmount.value = Amount.value;
   hdnAmount.value = ToInternalFormat($('#'+Amount.id));

    ToTargetFormat($('#'+hdnAmount.id)); 
   // var newAmt = Amount.value;
    var newAmt = ToInternalFormat($('#'+Amount.id));;

   // Gross.value = format_number((Number(Gross.value) + Number(Amount.value) - Number(OldAmounttoDelete)), 2);
    Gross.value = format_number((Number(ToInternalFormat($('#'+Gross.id))) + Number(ToInternalFormat($('#'+Amount.id))) - Number(OldAmounttoDelete)), 2);
    
     ToTargetFormat($('#'+Gross.id)); 
       
    //hdnGrossBillAmount.value = Gross.value;
    hdnGrossBillAmount.value = ToInternalFormat($('#'+Gross.id));
         
    ToTargetFormat($('#'+hdnGrossBillAmount.id)); 

    //if (Number(Amount.value) < Number(chkIsnumber(IndividualDiscount.value))) {
    if (Number(ToInternalFormat($('#'+Amount.id))) < Number(chkIsnumber(ToInternalFormat($('#'+IndividualDiscount.id))))) {
        alert('Discount cannot be greater than amount');
        //IndividualDiscount.value = Amount.value;
        IndividualDiscount.value = ToInternalFormat($('#'+Amount.id));
        ToTargetFormat($('#'+IndividualDiscount.id)); 
        
    }

    var DiscountCntrls = new Array();
    var tempCtrl;
    if (hdnDiscountArray == null || hdnDiscountArray == "" || hdnDiscountArray == undefined) {
        tempCtrl = "";
    }
    else {
        tempCtrl = document.getElementById(hdnDiscountArray).value;
    }
    DiscountCntrls = tempCtrl.split('|');
    var iCnt = 0;
    var DiscountAmount = 0;
    for (iCnt = 0; iCnt < DiscountCntrls.length; iCnt++) {
        if (DiscountCntrls[iCnt] != '') {
            //DiscountAmount = Number(chkIsnumber(document.getElementById(DiscountCntrls[iCnt]).value)) + Number(DiscountAmount);
            DiscountAmount = Number(chkIsnumber(ToInternalFormat($('#'+document.getElementById(DiscountCntrls[iCnt]).id)))) + Number(DiscountAmount);
        }
    }
    if (Number(DiscountAmount) != 0) {
        Discount.value = DiscountAmount;
         ToTargetFormat($('#'+Discount.id)); 
    }
    //OldPrice.value = UnitPrice.value;
    //OldQuantity.value = Quantity.value;
    
    OldPrice.value = ToInternalFormat($('#'+UnitPrice.id));
    OldQuantity.value = ToInternalFormat($('#'+Quantity.id));
    ToTargetFormat($('#'+OldPrice.id)); 
    ToTargetFormat($('#'+OldQuantity.id)); 
      
    
    totalCalculate();
    ValidateDiscountReason();
    //    if (document.getElementById('chkisCreditTransaction').checked == true) {
    if (flag != "ROOM") {
        var gridChkBox = document.getElementById(nonReimburseChkBoxID);
        var hdnNonMedical = document.getElementById(hdnNonMedicalItem);
        var lblNonReimbuse = document.getElementById(lblNonReimbuse);

        var hdnMedicalElt = document.getElementById(hdnMedical);
        var lblReimburseElt = document.getElementById(lblReimburse);

        if (gridChkBox != undefined) {
            if (gridChkBox.checked) {
               // lblReimburseElt.innerHTML = hdnMedicalElt.value = parseFloat(parseFloat(hdnMedicalElt.value) + (newAmt - oldAmt)).toFixed(2);
                lblReimburseElt.innerHTML = hdnMedicalElt.value = parseFloat(parseFloat(ToInternalFormat($('#'+hdnMedicalElt.id))) + (newAmt - oldAmt)).toFixed(2);
               
                   ToTargetFormat($('#'+lblReimburseElt.id)); 
                   ToTargetFormat($('#'+hdnMedicalElt.id)); 
     
            }
            else {
                //lblNonReimbuse.innerHTML = hdnNonMedical.value = parseFloat(parseFloat(hdnNonMedical.value) + (newAmt - oldAmt)).toFixed(2);
                lblNonReimbuse.innerHTML = hdnNonMedical.value = parseFloat(parseFloat(ToInternalFormat($('#'+hdnNonMedical.id))) + (newAmt - oldAmt)).toFixed(2);
                
                  ToTargetFormat($('#'+hdnNonMedical.id)); 
                  ToTargetFormat($('#'+lblNonReimbuse.id)); 
            }
            doCalcReimburse();
        }
    }
    else {
        var lblNonReimbuse = document.getElementById('lblNonReimbuse');
        var lblReimburseElt = document.getElementById('lblReimburse');
        var gridChkBox = document.getElementById(nonReimburseChkBoxID);

        var hdnNonMedical = document.getElementById(hdnNonMedicalItem);
        var hdnMedicalElt = document.getElementById(hdnMedical);
    var NonReimburseRoomRent=calNonReimburseRoomRent();
    var ReimburseRoomRent = calReimburseRoomRent();
    
    document.getElementById('hdnReimburseRoomRent').value = ReimburseRoomRent;
    document.getElementById('hdnNonReimburseRoomRent').value = NonReimburseRoomRent;
    
       ToTargetFormat($('#hdnReimburseRoomRent')); 
       ToTargetFormat($('#hdnNonReimburseRoomRent'));
    
    if (gridChkBox != undefined) {
        if (gridChkBox.checked) {
           // lblNonReimbuse.innerHTML = hdnNonMedical.value = parseFloat(parseFloat(hdnNonMedical.value) + (NewNonRAmt - oldNonRAmt)).toFixed(2);
             lblNonReimbuse.innerHTML = hdnNonMedical.value = parseFloat(parseFloat(ToInternalFormat($('#'+hdnNonMedical.id))) + (NewNonRAmt - oldNonRAmt)).toFixed(2);
           
            hdnOldNonReimbursableAmount.value = NewNonRAmt;

        //    lblReimburseElt.innerHTML = hdnMedicalElt.value = parseFloat(parseFloat(hdnMedicalElt.value) + (NewRAmt - oldRAmt)).toFixed(2);
         lblReimburseElt.innerHTML = hdnMedicalElt.value = parseFloat(parseFloat(ToInternalFormat($('#'+hdnMedicalElt.id))) + (NewRAmt - oldRAmt)).toFixed(2);
         
            hdnOldReimbursableAmount.value = NewRAmt;
            
              ToTargetFormat($('#'+lblNonReimbuse.id)); 
              ToTargetFormat($('#'+hdnNonMedical.id));
              ToTargetFormat($('#'+hdnOldNonReimbursableAmount.id)); 
              
              ToTargetFormat($('#'+lblReimburseElt.id)); 
              ToTargetFormat($('#'+hdnMedicalElt.id));
              ToTargetFormat($('#'+hdnOldReimbursableAmount.id)); 
            
        }
        
    }
//    var Totalpaid = parseFloat(parseFloat(document.getElementById('txtPreviousAmountPaid').value) + parseFloat(document.getElementById('txtThirdParty').value) + parseFloat(document.getElementById('txtRecievedAdvance').value) - parseFloat(document.getElementById('txtPreviousRefund').value)).toFixed(2);
//    var totalnonmedical = parseFloat(document.getElementById('lblNonReimbuse').innerHTML).toFixed(2);
//    var Totalmedical = parseFloat(document.getElementById('lblReimburse').innerHTML).toFixed(2);
//    var preauth = parseFloat(document.getElementById('lblPreAuthAmount').innerHTML).toFixed(2);
//    var Copaymentpercent = parseFloat(document.getElementById('txtCopercent').innerHTML).toFixed(2);
//    var Copaymentlogic = document.getElementById('hdnCopaymentlogic').value;
//    var ClaimDeductionLogic = document.getElementById('hdnDeductionLogic').value;
//    var DiscountAmt = parseFloat(document.getElementById('txtDiscount').value).toFixed(2);
    
    var Totalpaid = parseFloat(parseFloat(ToInternalFormat($("#txtPreviousAmountPaid"))) + parseFloat(ToInternalFormat($("#txtThirdParty"))) + parseFloat(ToInternalFormat($("#txtRecievedAdvance"))) - parseFloat(ToInternalFormat($("#txtPreviousRefund")))).toFixed(2);
    var totalnonmedical = parseFloat(ToInternalFormat($("#lblNonReimbuse"))).toFixed(2);
    var Totalmedical = parseFloat(ToInternalFormat($("#lblReimburse"))).toFixed(2);
    var preauth = parseFloat(ToInternalFormat($("#lblPreAuthAmount"))).toFixed(2);
    var Copaymentpercent = parseFloat(ToInternalFormat($("#txtCopercent"))).toFixed(2);
    var Copaymentlogic = ToInternalFormat($("#hdnCopaymentlogic"));
    var ClaimDeductionLogic = ToInternalFormat($("#hdnDeductionLogic"));
    var DiscountAmt = parseFloat(ToInternalFormat($("#txtDiscount"))).toFixed(2);


    ShowCollectableAmount(Totalpaid, totalnonmedical, Totalmedical, preauth, Copaymentpercent, Copaymentlogic, ClaimDeductionLogic, DiscountAmt);
    
    
    }


}
function calNonReimburseRoomRent() {
    var tempNonReimbuseRoomRent = 0;
    var ArrayNonReimburstxtids = document.getElementById('hdnNonReimburseTxtIds').value.split('~');
    for (i = 0; i < ArrayNonReimburstxtids.length - 1; i++) {
        //tempNonReimbuseRoomRent += Number(document.getElementById(ArrayNonReimburstxtids[i]).value);
        tempNonReimbuseRoomRent += Number(ToInternalFormat($('#'+document.getElementById(ArrayNonReimburstxtids[i]).id)));
        
    }
     return(tempNonReimbuseRoomRent)
}

function calReimburseRoomRent() {
    var tempReimbuseRoomRent = 0;
    var ArrayReimburstxtids = document.getElementById('hdnReimburseTxtIds').value.split('~');
    for (i = 0; i < ArrayReimburstxtids.length - 1; i++) {
        //tempReimbuseRoomRent += Number(document.getElementById(ArrayReimburstxtids[i]).value);
        tempReimbuseRoomRent += Number(ToInternalFormat($('#'+document.getElementById(ArrayReimburstxtids[i]).id)));
    }
    return(tempReimbuseRoomRent)
}
function ServiceCodeChangedItem(txtServiceCode, chkIsSelect) {
    var chkIsSelect = document.getElementById(chkIsSelect);
    chkIsSelect.checked = true;
}
var Totalpaid = 0;
function ClientWiseDisplayed(objTotalpaid, objDiscountAmt) {
    Totalpaid = objTotalpaid;
    var TowardsNonReimbursableItemTotal = 0;
    var TowardsCoPaymentTotal = 0;
    var TowardsMedicalandPreAuthTotal = 0;
    $("#divValues table tr").each(function() {
        var tr = $(this).closest("tr");
        var lblNonReimbuse = 0;
        var lblReimburse = 0;

        if ($(tr).find("input:text[id$=lblClientID]").val() != undefined) {
            var ClientID = $(tr).find("input:text[id$=lblClientID]").val();

            $("#divMedicalItems table tr").each(function() {
                var Medtr = $(this).closest("tr");
                if ($(Medtr).find("input:text[id$=txtAmount]").val() != undefined) {
                    var chk = $(Medtr).find("input:checkbox[id$=chkIsReImbursableItem]").attr('checked') ? true : false;
                    var MedClientID = $(Medtr).find("input:text[id$=lblClientID]") ? $(Medtr).find("input:text[id$=lblClientID]").val() : 0;
                    if (MedClientID == ClientID) {
                        if (chk == true) {
                            var Amount = 0;
                            Amount = $(Medtr).find("input:text[id$=txtAmount]") ? $(Medtr).find("input:text[id$=txtAmount]").val() : 0;
                            lblReimburse = parseFloat(lblReimburse) + parseFloat(Amount);

                        }
                        else {
                            var Amount = 0;
                            Amount = $(Medtr).find("input:text[id$=txtAmount]") ? $(Medtr).find("input:text[id$=txtAmount]").val() : 0;
                            lblNonReimbuse = parseFloat(lblNonReimbuse) + parseFloat(Amount);
                        }
                    }
                }
            });

            $("#divIndentsitems table tr").each(function() {
                var Medtr = $(this).closest("tr");
                if ($(Medtr).find("input:text[id$=txtAmount]").val() != undefined) {
                    var chk = $(Medtr).find("input:checkbox[id$=chkIsReImbursableItem]").attr('checked') ? true : false;
                    var MedClientID = $(Medtr).find("input:text[id$=lblClientID]") ? $(Medtr).find("input:text[id$=lblClientID]").val() : 0;

                    if (MedClientID == ClientID) {
                        if (chk == true) {
                            var Amount = 0;
                            Amount = $(Medtr).find("input:text[id$=txtAmount]") ? $(Medtr).find("input:text[id$=txtAmount]").val() : 0;
                            lblReimburse = parseFloat(lblReimburse) + parseFloat(Amount);

                        }
                        else {
                            var Amount = 0;
                            Amount = $(Medtr).find("input:text[id$=txtAmount]") ? $(Medtr).find("input:text[id$=txtAmount]").val() : 0;
                            lblNonReimbuse = parseFloat(lblNonReimbuse) + parseFloat(Amount);
                        }
                    }
                }
            });


            $("#divRoomDetails table tr").each(function() {
                var Medtr = $(this).closest("tr");
                if ($(Medtr).find("input:text[id$=txtAmount]").val() != undefined) {
                    var chk = $(Medtr).find("input:checkbox[id$=chkIsReImbursableItem]").attr('checked') ? true : false;
                    var MedClientID = $(Medtr).find("input:text[id$=lblClientID]") ? $(Medtr).find("input:text[id$=lblClientID]").val() : 0;

                    if (MedClientID == ClientID) {
                        if (chk == true) {
                            var Amount = 0;
                            Amount = $(Medtr).find("input:text[id$=txtAmount]") ? $(Medtr).find("input:text[id$=txtAmount]").val() : 0;
                            lblReimburse = parseFloat(lblReimburse) + parseFloat(Amount);

                        }
                        else {
                            var Amount = 0;
                            Amount = $(Medtr).find("input:text[id$=txtAmount]") ? $(Medtr).find("input:text[id$=txtAmount]").val() : 0;
                            lblNonReimbuse = parseFloat(lblNonReimbuse) + parseFloat(Amount);
                        }
                    }
                }
            });

            $(tr).find($('span[id$="lblNonMedicalAmount"]')).html(lblNonReimbuse.toFixed(2));
            $(tr).find($('span[id$="lblMedicalAmount"]')).html(lblReimburse.toFixed(2));

            var _actualCoPayment = 0;
            var Co_PaymentLogic = $(tr).find($('span[id$="lblCopaymentlogic"]')).html();
            var Co_PaymentPercentage = $(tr).find($('span[id$="lblCopPercent"]')).html();
            var Pre_AuthAmount = $(tr).find($('span[id$="lblPreAuthAmount"]')).html();
            var Claim_DeductionLogic = $(tr).find($('span[id$="lblClaimLogic"]')).html();
            var _claimAmount = 0;
            var _amountReceivable = 0;
            var _diffInBillledVsPreAuth = 0;
            var _grossBill = 0;

            _grossBill = Number(lblReimburse) + Number(lblNonReimbuse);

            if (Number(Co_PaymentLogic) == 0) {
                if (Number(lblReimburse) < Number(Pre_AuthAmount)) {
                    _actualCoPayment = Number(lblReimburse) * (Number(Co_PaymentPercentage) / 100);
                }
                else {
                    _actualCoPayment = Number(Pre_AuthAmount) * (Number(Co_PaymentPercentage) / 100);
                }
            }
            if (Number(Co_PaymentLogic) == 0) {
                if (Number(lblReimburse) < Number(Pre_AuthAmount)) {
                    _actualCoPayment = Number(lblReimburse) * (Number(Co_PaymentPercentage) / 100);
                }
                else {
                    _actualCoPayment = Number(Pre_AuthAmount) * (Number(Co_PaymentPercentage) / 100);
                }
            }
            else if (Number(Co_PaymentLogic) == 1) {
                _actualCoPayment = Number(lblReimburse) * (Number(Co_PaymentPercentage) / 100);
            }
            else if (Number(Co_PaymentLogic) == 2) {
                _actualCoPayment = Number(Pre_AuthAmount) * (Number(Co_PaymentPercentage) / 100);
            }
            $(tr).find($('span[id$="lblCoPaymentAmount"]')).html(_actualCoPayment.toFixed(2));



            if (Number(Totalpaid) > Number(lblNonReimbuse)) {
                _totNonMedicalAmt = 0;
            }
            else {
                _totNonMedicalAmt = (Number(lblNonReimbuse) - Number(Totalpaid));
            }

            $(tr).find($('span[id$="lblTowardsNonMedical"]')).html(_totNonMedicalAmt.toFixed(2));


            if ((Number(Totalpaid) - Number(lblNonReimbuse)) > 0) {
                _balAfterNonMedicalAmt = Number(Totalpaid) - Number(lblNonReimbuse);
            }
            else {
                _balAfterNonMedicalAmt = 0;
            }

            if (Number(_balAfterNonMedicalAmt) > Number(_actualCoPayment)) {
                _totCoPaymentToPay = 0;
            }
            else {
                _totCoPaymentToPay = Number(_actualCoPayment) - Number(_balAfterNonMedicalAmt);
            }

            $(tr).find($('span[id$="lblTowardsCoPay"]')).html(_totCoPaymentToPay.toFixed(2));



            if (Number(Claim_DeductionLogic) == 1) {

                _claimAmount = Number(lblReimburse) - Number(_actualCoPayment);

                if (Number(_claimAmount) > Number(Pre_AuthAmount)) {
                    _claimAmount = Number(Pre_AuthAmount);
                }

                _amountReceivable = Number(_grossBill) - Number(_claimAmount);

                if (Number(Totalpaid) - Number(_amountReceivable) > 0) {
                    _diffInBillledVsPreAuth = 0;
                }
                else {
                    _diffInBillledVsPreAuth = ((Number(_amountReceivable) - Number(Totalpaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                }
                _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay) + Number(_diffInBillledVsPreAuth);

            }

            //Pre Auth Amount
            else if (Number(Claim_DeductionLogic) == 2) {
                _claimAmount = Number(Pre_AuthAmount) - Number(_actualCoPayment);

                if (Number(_claimAmount) > Number(lblReimburse)) {
                    _claimAmount = Number(lblReimburse);
                }

                _amountReceivable = Number(_grossBill) - Number(_claimAmount);

                if (Number(totalPaid) - Number(_amountReceivable) > 0) {
                    _diffInBillledVsPreAuth = 0;
                    
                }
                else {
                    _diffInBillledVsPreAuth = ((Number(_amountReceivable) - Number(totalPaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                    document.getElementById('lblPreAuthAmttxt').innerHTML = parseFloat(_diffInBillledVsPreAuth).toFixed(2);
                }
                _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay) + Number(_diffInBillledVsPreAuth);
            }
            $(tr).find($('span[id$="lblPreandMedical"]')).html(_diffInBillledVsPreAuth.toFixed(2));

            Totalpaid = Totalpaid - (Number(lblNonReimbuse) + Number(_actualCoPayment) + Number(_diffInBillledVsPreAuth)) > 0 ? Number(Totalpaid) - Number(Number(lblNonReimbuse) + Number(_actualCoPayment) + Number(_diffInBillledVsPreAuth)) : 0;

            lblNonReimbuse = 0;
            lblReimburse = 0

            

            TowardsNonReimbursableItemTotal += Number($(tr).find($('span[id$="lblTowardsNonMedical"]')).html());
            TowardsCoPaymentTotal += Number($(tr).find($('span[id$="lblTowardsCoPay"]')).html());
            TowardsMedicalandPreAuthTotal += Number($(tr).find($('span[id$="lblPreandMedical"]')).html());
        }
    });
    document.getElementById('lblNonReimbAmttxt').innerHTML = TowardsNonReimbursableItemTotal.toFixed(2);
    document.getElementById('lblCopayamenttxt').innerHTML = TowardsCoPaymentTotal.toFixed(2);
    document.getElementById('lblPreAuthAmttxt').innerHTML = TowardsMedicalandPreAuthTotal.toFixed(2);
    document.getElementById('lblTotaltxt').innerHTML = Number(Number(TowardsNonReimbursableItemTotal) + Number(TowardsCoPaymentTotal) + Number(TowardsMedicalandPreAuthTotal)).toFixed(2);
     
    

}