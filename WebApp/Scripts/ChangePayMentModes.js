function ChangePaymentModes(BillID, PatientID, PatientVisitId, PatientNumber, BillNumber, OrgID, ClientID, Name, AmtReceived) {

    document.getElementById('uctrlBillSearch_hdnFinalBillId').value = BillID;
    document.getElementById('uctrlBillSearch_lblPName').innerText = Name;
    document.getElementById('uctrlBillSearch_lblTotalAmtreceived').innerText = AmtReceived;
    document.getElementById('uctrlBillSearch_lblBillNo').innerText = BillNumber;


    var arrGotValue = new Array();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../OPIPBilling.asmx/GetBillingItemsDetailsForEdit",
        data: JSON.stringify({ OrgID: OrgID, BillNo: BillNumber, VisitID: PatientVisitId, PatientID: PatientID, ClientID: ClientID }),
        dataType: "json",
        success: function(data) {
            if (data.d.length > 0) {

                var list = data.d;
                var list1 = list[0];
                var list2 = list[1];
                var gotValue = list2[0].ProcedureName;

                PaymentMdodes(gotValue);

            }
        },
        error: function(result) {
            alert("Error");
        }
    });
}

function PaymentMdodes(gotValue) {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_ChangePayMentModes_js_01") != null ? SListForAppMsg.Get("Scripts_ChangePayMentModes_js_01") : "Alert";
    var UsrAlrtMsg = SListForAppMsg.Get("Scripts_ChangePayMentModes_js_02") != null ? SListForAppMsg.Get("Scripts_ChangePayMentModes_js_02") : "Can not edit the Payment Mode for this bill";
    if (gotValue == null || gotValue == '') {
        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
        //alert("Can not edit the Payment Mode for this bill");
        return false;
    }
    $find('uctrlBillSearch_programmaticModalPopup').show();
    var PaymentarrayGotValue = new Array();

    var BilledAmtList = gotValue.split('#');

    for (var j = 0; j < BilledAmtList.length - 1; j++) {
        if (BilledAmtList[j] != '' && BilledAmtList[j].length > 0) {
            PaymentarrayGotValue = '';
            PaymentarrayGotValue = BilledAmtList[j].split('~');
            PaymentName = PaymentarrayGotValue[0];
            PaymentAmount = PaymentarrayGotValue[1];
            PaymentMethodNumber = PaymentarrayGotValue[2];
            PaymentBankType = PaymentarrayGotValue[3];
            PaymentRemarks = PaymentarrayGotValue[4];
            PaymentTypeID = PaymentarrayGotValue[5];
            ChequeValidDate = PaymentarrayGotValue[6];
            ServiceCharge = PaymentarrayGotValue[7];
            TotalAmount = PaymentarrayGotValue[8];
            OtherCurrAmt = PaymentarrayGotValue[9];
            EMIROI = PaymentarrayGotValue[10];
            EMITenor = PaymentarrayGotValue[11];
            EMIValue = PaymentarrayGotValue[12];
            Units = PaymentarrayGotValue[13];
            ReferenceID = PaymentarrayGotValue[14];
            ReferenceType = PaymentarrayGotValue[15];
            CardHolderName = PaymentarrayGotValue[16];
            AmtReceivedID = PaymentarrayGotValue[17];
        }
        var PaymentAAlreadyPresent = new Array();
        var iPaymentAlreadyPresent = 0;
        var iPaymentCount = 0;

        document.getElementById('uctrlBillSearch_hdnAmtReceivedID').value = AmtReceivedID;
        var PaymentViewStateValue = document.getElementById('uctrlBillSearch_PaymentTypeDetails1_hdfPaymentType').value;
        if (iPaymentAlreadyPresent == 0) {
            PaymentViewStateValue += "RID^" + 0
            + "~PaymentNAME^" + PaymentName
            + "~EMIROI^" + EMIROI
            + "~EMITenor^" + EMITenor
            + "~EMIValue^" + EMIValue
            + "~PaymentAmount^" + PaymentAmount
            + "~PaymenMNumber^" + PaymentMethodNumber
            + "~PaymentBank^" + PaymentBankType
            + "~PaymentRemarks^" + PaymentRemarks
            + "~PaymentTypeID^" + PaymentTypeID
            + "~ChequeValidDate^" + ChequeValidDate
            + "~ServiceCharge^" + ServiceCharge
            + "~TotalAmount^" + TotalAmount
            + "~OtherCurrAmt^" + OtherCurrAmt
            + "~Units^" + Units
            + "~ReferenceID^" + ReferenceID
            + "~ReferenceType^" + ReferenceType
            + "~CardHolderName^" + CardHolderName
            + "~AmtReceivedID^" + AmtReceivedID + "|";
            document.getElementById('uctrlBillSearch_PaymentTypeDetails1_hdfPaymentType').value = PaymentViewStateValue;
            CreatePaymentTables(AmtReceivedID);
            document.getElementById('uctrlBillSearch_PaymentTypeDetails1_addNewPayment').style.display = 'none';
        }
    }
}
function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

    GetCurrencyValues();
    var ConValue = "OtherCurrencyDisplay1";
    sVal = Number(Number(PaymentAmount) - Number(TotalAmount));
    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    document.getElementById('uctrlBillSearch_PaymentTypeDetails1_hdfPaymentType').value = '';

    var amtRec = 0;

}
function SetOtherCurrValues() {
    var pnetAmt = 100;
    var ConValue = "OtherCurrencyDisplay1";
    SetPaybleOtherCurr(pnetAmt, ConValue, true);

}
function SetPaybleOtherCurr(pnetAmt, ConValue, IsDisplay) {
    var OtherCurrencyRate = ToInternalFormat($('#uctrlBillSearch_PaymentTypeDetails1_hdnOtherCurrencyRate')); // document.getElementById('uctrlBillSearch_PaymentTypeDetails1_hdnOtherCurrencyRate').value;
    var OtherCurrency = document.getElementById('uctrlBillSearch_PaymentTypeDetails1_hdnOtherCurrency').value;
    SetOtherCurrPayble(OtherCurrency, OtherCurrencyRate, pnetAmt, ConValue, IsDisplay);
    var pTotalNetAmt = Number(pnetAmt) / Number(OtherCurrencyRate);
    var pTempAmt = Number(pTotalNetAmt) * Number(OtherCurrencyRate);
    document.getElementById('uctrlBillSearch_PaymentTypeDetails1_hdnPayVariableAmount').value = Number(pnetAmt) - Number(pTempAmt);
    ToTargetFormat($('#uctrlBillSearch_PaymentTypeDetails1_hdnPayVariableAmount'));

}
function SetOtherCurrPayble(pCurrName, pCurrAmount, pNetAmount, ConValue, IsDisplay) {

    var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(4) / parseFloat(pCurrAmount).toFixed(2)).toFixed(4);

}
function isOtherCurrDisplay(pType) {
    if (pType == "B") {
        //        document.getElementById("OtherCurrencyDisplay1_tbOtherCurr").style.display = "block";
    }
}

function isOtherCurrDisplay1(pType) {


}
function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_ChangePayMentModes_js_01") != null ? SListForAppMsg.Get("Scripts_ChangePayMentModes_js_01") : "Alert";
    var UsrAlrtMsg = SListForAppMsg.Get("Scripts_ChangePayMentModes_js_03") != null ? SListForAppMsg.Get("Scripts_ChangePayMentModes_js_03") : "Amount received is greater than net amount";
    var sVal = 0;
    var ConValue = "OtherCurrencyDisplay1";
    var sNetValue = 0;

    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
    sVal = format_number(Number(sVal) + Number(TotalAmount), 2);
    sNetValue = document.getElementById('uctrlBillSearch_lblTotalAmtreceived').innerText;

    if (PaymentAmount > 0) {
///**********************Changed by arivalagan.k*********************///
        var Receivedamt = 0;
        if (Number(sNetValue) >= Number(sVal)) {
            if (document.getElementById('uctrlBillSearch_HdnEditPaymentAmt') != null) {
                var Editpaymentamt = 0;
                document.getElementById('uctrlBillSearch_HdnEditPaymentAmt').value = '';
                Receivedamt = Number(document.getElementById('uctrlBillSearch_HdnEditPaymentAmt').value) + Number(sVal);
                Editpaymentamt = document.getElementById('uctrlBillSearch_HdnEditPaymentAmt').value = Number(Receivedamt);
                if (Number(sNetValue) >= Number(Editpaymentamt)) {
                    sVal = format_number(sVal, 2);
                    SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge), 2), ConValue);
                    var pScr = format_number(Number(ServiceCharge), 2);
                    return true;
                }
                else {
                    Receivedamt = Number(document.getElementById('uctrlBillSearch_HdnEditPaymentAmt').value) - Number(sVal);
                    document.getElementById('uctrlBillSearch_HdnEditPaymentAmt').value = Number(Receivedamt);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    //alert('Amount received is greater than net amount');
                    return false;
                }
            }
            else {
                sVal = format_number(sVal, 2);
                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge), 2);
                return true;
            }
           
        }
        else {
            ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            //alert('Amount received is greater than net amount');
            return false;
        }
    }
    ///**********************End Changed by arivalagan.k*********************///

}

function SetOtherCurrReceived(pCurrAmount, pNetAmount, pServiceCharge, ConValue) {
    var pTotalNetAmt = Number(pNetAmount);

}

function CancelPopup() {

    document.getElementById('uctrlBillSearch_PaymentTypeDetails1_hdfPaymentType').value = '';
    document.getElementById('uctrlBillSearch_HdnEditPaymentAmt').value = '';
    document.getElementById('uctrlBillSearch_HdnTotalAmtreceived').value = '';
    PaymentControlclear();
}
function CheckAmount() {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_ChangePayMentModes_js_01") != null ? SListForAppMsg.Get("Scripts_ChangePayMentModes_js_01") : "Alert";
    var UsrAlrtMsg = SListForAppMsg.Get("Scripts_ChangePayMentModes_js_05") != null ? SListForAppMsg.Get("Scripts_ChangePayMentModes_js_05") : "Collected amount is less then total amount received";
   var EditPaymentAmt=  document.getElementById('uctrlBillSearch_HdnEditPaymentAmt').value;
   var ToalRecived = document.getElementById('uctrlBillSearch_lblTotalAmtreceived').innerText;
   document.getElementById('uctrlBillSearch_HdnTotalAmtreceived').value = Number(ToalRecived);
   if ((Number(EditPaymentAmt)) > 0 && (Number(EditPaymentAmt) != Number(ToalRecived))) {
       ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
      // alert('Collected amount is less then total amount received');
       CancelPopup();
       return false;
   }
}