<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Billing.aspx.cs" Inherits="Billing_Billing"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/BalanceCalc.ascx" TagName="BalanceCalc" TagPrefix="ctrlBalCalc" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/DepositUsage.ascx" TagName="DepositUsage" TagPrefix="ucDU" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Billing</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .Left
        {
            text-align: left;
        }
        .right
        {
            text-align: right;
        }
    </style>

    <script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <!-- Language converter -->

    <script type="text/javascript">

        function ToInternalFormat(pControl) {
            // //debugger;
            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                return pControl.asNumber({ region: "<%=LanguageCode%>" });
            }
        }

        function ToTargetFormat(pControl) {
            // //debugger;
            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                return pControl.formatCurrency({ region: "<%=LanguageCode%>" }).val();
            }
        }
        

    </script>

    <script type="text/javascript">


        //        animatedcollapse.addDiv('Due', 'fade=1,height=1%');
        //        animatedcollapse.init();

        function CheckBilling1() {

            var alte = PaymentSaveValidation();
            if (alte == true) {

                //document.getElementById('btnSave').style.display = 'none';


                var AmtRecieved = ToInternalFormat($('#<%= txtAmountRecieved.ClientID %>'))
                var AmtNet = ToInternalFormat($('#<%= txtGrandTotal.ClientID %>'));

                if (Number(AmtNet) > Number(AmtRecieved)) {
                    var pBill = confirm("This BillAmount will be added to due.\n Do you want to continue");
                    if (pBill != true) {
                        document.getElementById('btnSave').style.display = 'block';
                        return false;
                    }
                }
                document.getElementById('<%= btnSave.ClientID %>').disabled = false;
                $get('btnSave').disabled = true;
                javascript: __doPostBack('btnSave', '');
                return true;




            }
            else {

                return false;
            }

        }

        //========================================

        function CheckBilling11() {

            var AmtRecieved = ToInternalFormat($('#<%= txtAmountRecieved.ClientID %>'));
            var AmtNet = ToInternalFormat($('#<%= txtGrandTotal.ClientID %>'));

            if (Number(AmtNet) > Number(AmtRecieved)) {
                var pBill = confirm("This BillAmount will be added to due.\n Do you want to continue");
                if (pBill != true) {
                    document.getElementById('btnSave').style.display = 'block';
                    return false;
                }
            }
            document.getElementById('<%= btnSave.ClientID %>').disabled = false;
            return true;

            //                
        }




        function DefaultText(id) {

            document.getElementById(id).value = "";

        }

        function total() {


            document.getElementById('txtGrossAmount').value = format_number(Number(ToInternalFormat($('#txtGross'))) -
                                                    (Number(ToInternalFormat($('#txtSubDeduction'))) +
                                                    Number(ToInternalFormat($('#txtDiscount')))), 2);
            ToTargetFormat($('#txtGrossAmount'));
            // txtAmount auto values

//            document.getElementById('PaymentType_txtAmount').value = ($('#txtGrossAmount')).val();
//            document.getElementById('PaymentType_txtTotalAmount').innerHTML = ($('#txtGrossAmount')).val();

            document.getElementById('txtGrandTotal').value = format_number
                                        (Number(ToInternalFormat($('#txtGrossAmount'))) +
                                          Number(ToInternalFormat($('#txtTax'))), 2);
            ToTargetFormat($('#txtGrandTotal'));
            setNetToBalanceControl(ToInternalFormat($('#txtGrandTotal')));
            if (Number(ToInternalFormat($('#hdnRecievedAmount'))) > 0) {
                document.getElementById('txtGrandTotal').value = format_number(
                                                                Number(ToInternalFormat($('#txtGrandTotal'))) -
                                                                Number(ToInternalFormat($('#txtRecievedAmount'))), 2);
                ToTargetFormat($('#txtGrandTotal'));
                setNetToBalanceControl(ToInternalFormat($('#txtGrandTotal')));
            }
            //Number(document.getElementById('txtDue').value) +

            //document.getElementById('txtAmountRecieved').value = format_number(document.getElementById('txtGrandTotal').value, 2);
            document.getElementById('hdnGrossAmount').value = format_number
                                        (Number(ToInternalFormat($('#txtGrossAmount'))) +
                                         Number(ToInternalFormat($('#txtDue'))) + Number(ToInternalFormat($('#txtTax'))), 2);
            ToTargetFormat($('#hdnGrossAmount'));
        }
        function AmountRecieved() {
            var grandTotal = ToInternalFormat($('#txtGrandTotal'));
            var amountRecieved = ToInternalFormat($('#txtAmountRecieved'));
        }

        function ChangeFormat() {
            document.getElementById('txtSubDeduction').value = format_number(ToInternalFormat($('#txtSubDeduction')), 2);
            ToTargetFormat($('#txtSubDeduction'));
            document.getElementById('txtDiscount').value = format_number(ToInternalFormat($('#txtDiscount')), 2);
            ToTargetFormat($('#txtDiscount'));
            document.getElementById('txtAmountRecieved').value = format_number(ToInternalFormat($('#txtAmountRecieved')), 2);
            ToTargetFormat($('#txtAmountRecieved'));
            document.getElementById('hdnAmountReceived').value = format_number(ToInternalFormat($('#txtAmountRecieved')), 2);
            ToTargetFormat($('#hdnAmountReceived'));
            document.getElementById('txtTax').value = format_number(ToInternalFormat($('#txtTax')), 2);
            ToTargetFormat($('#txtTax'));
            document.getElementById('hdnTaxAmount').value = format_number(ToInternalFormat($('#txtTax')), 2);
            ToTargetFormat($('#hdnTaxAmount'));

            var gross = ToInternalFormat($('#txtGross'));
            var discount = ToInternalFormat($('#txtDiscount'));
            if ((Number(gross)) < (Number(discount))) {
                document.getElementById('txtDiscount').value = "0.0";
                ToTargetFormat($('#txtDiscount'));
                totalCalculate();
                alert('Discount amount is greater than gross value');
                clearDiscounts();

            }
        }

        function clearDiscounts() {
            var DiscountCntrls = new Array();
            var tempCtrl = document.getElementById('<%= hdnDiscountArray.ClientID %>').value;
            DiscountCntrls = tempCtrl.split('|');
            var iCnt = 0;
            var DiscountAmount = 0;

            for (iCnt = 0; iCnt < DiscountCntrls.length; iCnt++) {
                if (DiscountCntrls[iCnt] != '') {
                    document.getElementById(DiscountCntrls[iCnt]).value = 0;
                }

            }
        }

        function AddDiscountsCheck() {
            var DiscountCntrls = new Array();
            var tempCtrl = document.getElementById('<%= hdnDiscountArray.ClientID %>').value;
            var DiscountControl = document.getElementById('<%= txtDiscount.ClientID %>');
            DiscountCntrls = tempCtrl.split('|');
            var iCnt = 0;
            var DiscountAmount = 0;
            for (iCnt = 0; iCnt < DiscountCntrls.length; iCnt++) {
                if (DiscountCntrls[iCnt] != '') {
                    DiscountAmount = Number(chkIsnumber(document.getElementById(DiscountCntrls[iCnt]).value)) + Number(DiscountAmount);
                }
            }

            if (Number(DiscountControl.value) < Number(DiscountAmount)) {
                DiscountControl.value = Number(DiscountAmount);
                ToTargetFormat($('#' + DiscountControl));
            }
            return false;
        }

        function DeductionCalculation() {
            var value = document.getElementById('ddlSubDeduction').value.split("*");
            if (value[2] == 'V') {
                document.getElementById('txtSubDeduction').value = format_number(value[1], 2);
                ToTargetFormat($('#txtSubDeduction'));
                document.getElementById('hdnStdDedID').value = value[0];
                ToTargetFormat($('#hdnStdDedID'));
                CorrectTotal();
                total();
            }
            else if (value[2] == 'P') {

                var Grossalue = document.getElementById('txtGross').value;
                document.getElementById('txtSubDeduction').value = format_number((Number(Grossalue) * Number(value[1]) / 100), 2);
                ToTargetFormat($('#txtSubDeduction'));
                document.getElementById('hdnStdDedID').value = value[0];

                CorrectTotal();
                total();
            }
            else {

                document.getElementById('txtSubDeduction').value = "0.00";
                ToTargetFormat($('#txtSubDeduction'));
                CorrectTotal();
                total();
            }
        }
        function checkIsCredit() {

            if (document.getElementById('chkisCreditTransaction').checked == true) {
                document.getElementById('txtAmountRecieved').value = '0.00';
                ToTargetFormat($('#txtAmountRecieved'));
                document.getElementById('hdnAmountReceived').value = '0.00';
                ToTargetFormat($('#hdnAmountReceived'));
                document.getElementById('txtAmountRecieved').disabled = true;
                ClearPaymentControlEvents();
            }
        }
        function validation1() {
            if (document.form1.txtDesc.value == "") {
                alert('Provide description for miscellaneous ');
                document.form1.txtDesc.focus();
                return false;
            }
            if (document.form1.txtAmt.value == "") {
                alert('Provide miscellaneous amount');
                document.form1.txtAmt.focus();
                return false;
            }
            return true;
        }

        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);


            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 4);



            if (Number(sNetValue) >= Number(sVal)) {
                sVal = format_number(sVal, 2);
                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                var pScrAmt = Number(pScr) * Number(CurrRate);
                var pAmt = Number(sVal) * Number(CurrRate);

                document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
                ToTargetFormat($('#txtServiceCharge'));
                document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2)
                ToTargetFormat($('#hdnServiceCharge'));
                document.getElementById('txtAmountRecieved').value = format_number(pAmt, 2);
                ToTargetFormat($('#txtAmountRecieved'));
                document.getElementById('hdnAmountReceived').value = format_number(pAmt, 2);
                ToTargetFormat($('#hdnAmountReceived'));

                var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

                document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
                ToTargetFormat($('#txtGrandTotal'));
                SetOtherCurrValues();
                return true;
            }
            else {
                alert('Amount provided is greater than net amount');
                return false;
            }
        }


        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
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

            document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
            ToTargetFormat($('#txtServiceCharge'));
            document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2);
            ToTargetFormat($('#hdnServiceCharge'));

            document.getElementById('txtAmountRecieved').value = format_number(sVal, 2);
            ToTargetFormat($('#txtAmountRecieved'));
            document.getElementById('hdnAmountReceived').value = format_number(sVal, 2);
            ToTargetFormat($('#hdnAmountReceived'));

            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);
            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

            document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
            ToTargetFormat($('#txtGrandTotal'));
            SetOtherCurrValues();
        }
        function chkCreditPament() {
            document.getElementById('chkisCreditTransaction').checked = false;
        }

        function dateDiff2(startDate, endDate) {
            var sstartdate = new Date(startDate.split('/')[1] + '/' + startDate.split('/')[0] + '/' + startDate.split('/')[2]);
            var sEndDate = new Date(endDate.split('/')[1] + '/' + endDate.split('/')[0] + '/' + endDate.split('/')[2]);
            var one_day = 1000 * 60 * 60 * 24;

            return Math.ceil((sEndDate.getTime() - sstartdate.getTime()) / (one_day));
        }
        function totalCalculate() {
            var GrossAmount = ToInternalFormat($('#<%= hdnGross.ClientID %>'));
            var DiscountAmount = ToInternalFormat($('#<%= txtDiscount.ClientID  %>'));
            //var GrandTotal = document.getElementById('<%= txtGrandTotal.ClientID  %>');
            var PreviousReceived = ToInternalFormat($('#<%= txtPreviousAmountPaid.ClientID %>'));
            var PreviousDue = ToInternalFormat($('#<%= txtDue.ClientID %>'));

            var AdvanceReceivd = ToInternalFormat($('#<%= txtRecievedAdvance.ClientID %>'));

            //var RefundAmount = document.getElementById('<%= txtRefundAmount.ClientID %>');
            var TaxAMount = Number(ToInternalFormat($('#txtTax')), 2);
            var txtRateCardDiffAmount = ToInternalFormat($('#<%= txtRateCardDiffAmount.ClientID %>'));
            //var RoundOFF = document.getElementById('<%= txtRoundOff.ClientID %>');
            //var hdnRoundOff = document.getElementById('<%= hdnRoundOff.ClientID %>');
            var defRoundOff = ToInternalFormat($('#<%= hdnDefaultRoundoff.ClientID %>'));
            // var RoundOffType = ToInternalFormat($('#<%= hdnRoundOffType.ClientID %>'));
            var RoundOffType = document.getElementById('<%= hdnRoundOffType.ClientID %>').value;



            PreviousReceived = chkIsnumber(PreviousReceived);
            GrossAmount = chkIsnumber(GrossAmount);
            DiscountAmount = chkIsnumber(DiscountAmount);
            PreviousDue = chkIsnumber(PreviousDue);
            AdvanceReceivd = chkIsnumber(AdvanceReceivd);
            TaxAMount = chkIsnumber(TaxAMount);
            txtRateCardDiffAmount = chkIsnumber(txtRateCardDiffAmount);
            if ((Number(GrossAmount) - Number(DiscountAmount)) < 0) {
                alert('Discount cannot be greater than gross amount');
                document.getElementById('<%= txtDiscount.ClientID  %>').value = GrossAmount;
                ToTargetFormat($('#<%= txtDiscount.ClientID  %>'));
                CorrectTotal();
                totalCalculate();

                //GrandTotal.value = document.getElementById('<%= hdnGross.ClientID %>').value;
            }
            else {
                var totGrossAmount = format_number((Number(GrossAmount) + Number(TaxAMount) + Number(txtRateCardDiffAmount) - (Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd))), 2); //+ Number(PreviousDue)
                //RoundOFF
                document.getElementById('<%= txtRoundOff.ClientID %>').value = getCustomRoundoff(totGrossAmount, Number(defRoundOff), RoundOffType);
                ToTargetFormat($('#<%= txtRoundOff.ClientID %>'));
                //hdnRoundOff
                document.getElementById('<%= hdnRoundOff.ClientID %>').value = ToInternalFormat($('#<%= txtRoundOff.ClientID %>'));
                totGrossAmount = format_number((Number(ToInternalFormat($('#<%= hdnRoundOff.ClientID %>'))) + Number(totGrossAmount)), 2);
                // alert(GrossAmount);
                //                alert(PreviousDue);
                //                alert(PreviousReceived);
                //                alert(DiscountAmount);
                //                alert(AdvanceReceivd);

                if (Number(totGrossAmount) > 0) {
                    document.getElementById('<%= txtGrandTotal.ClientID  %>').value = totGrossAmount;
                    //GrandTotal.value = totGrossAmount
                    ToTargetFormat($('#<%= txtGrandTotal.ClientID  %>'));
                    setNetToBalanceControl(ToInternalFormat($('#txtGrandTotal')));
                    //RefundAmount.value = 0;
                    document.getElementById('<%= txtRefundAmount.ClientID %>').value = 0;

                }
                else {
                    //GrandTotal.value = 0;
                    document.getElementById('<%= txtGrandTotal.ClientID  %>').value = 0;
                    setNetToBalanceControl(ToInternalFormat($('#txtGrandTotal')));
                    //RefundAmount.value
                    document.getElementById('<%= txtRefundAmount.ClientID %>').value = format_number((Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd)) - (Number(GrossAmount) + Number(TaxAMount) + Number(PreviousDue)), 2);
                    ToTargetFormat($('#<%= txtRefundAmount.ClientID %>'));
                }
                SetOtherCurrValues();
                TotalMedial();
            }
//            document.getElementById('PaymentType_txtAmount').value = totGrossAmount;
//            document.getElementById('PaymentType_txtTotalAmount').innerHTML = totGrossAmount;
            ToTargetFormat($('#txtAmount'));
            ToTargetFormat($('#txtTotalAmount'));
        }
        function chkTaxPayment(idval, dPercent) {

            var sVal = Number(ToInternalFormat($('#txtTax')));
            var sGrand = format_number(Number(ToInternalFormat($('#txtGross'))) -
                                                    (Number(ToInternalFormat($('#txtSubDeduction'))) + Number(ToInternalFormat($('#txtDiscount')))), 2);

            var sControl = document.getElementById(idval);
            var arrayAlready = new Array();
            var iCount = 0;
            var tSelectedData = "";

            if (sControl.checked == true) {
                sVal = sVal + (Number(sGrand) * Number(dPercent) / 100);

                document.getElementById('hdfTax').value += ">" + idval + "~" + dPercent;
                document.getElementById('txtTax').value = format_number(sVal, 2);
                ToTargetFormat($('#txtTax'));
                document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);
                ToTargetFormat($('#hdnTaxAmount'));
            }
            else {
                sVal = sVal - (Number(sGrand) * Number(dPercent) / 100);
                var tempval = document.getElementById('hdfTax').value;

                arrayAlready = tempval.split('>');
                if (arrayAlready.length > 0) {
                    for (iCount = 0; iCount < arrayAlready.length; iCount++) {
                        if (arrayAlready[iCount].toLowerCase() == (idval.toLowerCase() + "~" + dPercent.toLowerCase())) {
                            arrayAlready[iCount] = "";
                        }
                    }
                    iCount = 0;
                    for (iCount = 0; iCount < arrayAlready.length; iCount++) {
                        if (arrayAlready[iCount].toLowerCase() != "") {
                            tSelectedData += ">" + arrayAlready[iCount];
                        }
                    }
                }
                document.getElementById('hdfTax').value = tSelectedData;
                ToTargetFormat($('#hdfTax'));
            }
            document.getElementById('txtTax').value = format_number(sVal, 2);
            ToTargetFormat($('#txtTax'));
            document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);
            ToTargetFormat($('#hdnTaxAmount'));
            total();
        }

        function CorrectTotal() {
            var SelectedVal = document.getElementById('hdfTax').value;
            document.getElementById('hdfTax').value = "";
            document.getElementById('txtTax').value = "0.00";
            ToTargetFormat($('#txtTax'));
            var iDC = 0;
            var tpData = "";
            var spData = "";
            var arrayPresent = new Array();
            arrayPresent = SelectedVal.split('>');
            for (iDC = 0; iDC < arrayPresent.length; iDC++) {
                tpData = arrayPresent[iDC];
                if (tpData != "") {
                    chkTaxPayment(tpData.split('~')[0], tpData.split('~')[1]);
                }
            }
        }

        function ValidateDiscountReason() {
            if (ToInternalFormat($('#txtDiscount')) > 0) {
                document.getElementById('trDiscountReason').style.display = "block";
                //                document.getElementById('txtDiscountReason').focus();
            }
            else {
                document.getElementById('trDiscountReason').style.display = "none";
            }
        }
        function getCustomRoundoff(roundoffVal, DefaultRound, RoundOffType) {
            var result = 0;
            if (RoundOffType.toLowerCase() == "lower value") {
                result = (Math.floor(Number(roundoffVal) / Number(DefaultRound))) * (Number(DefaultRound));
            }
            else if (RoundOffType.toLowerCase() == "upper value") {
                result = (Math.ceil(Number(roundoffVal) / Number(DefaultRound))) * (Number(DefaultRound));
            }
            else if (RoundOffType.toLowerCase() == "none") {
                result = format_number_withSignNone(roundoffVal, 2);
            }
            else {
                result = roundoffVal;
            }
            result = Number(result) - Number(roundoffVal);
            result = format_number_withSign(result, 2);
            return result;
        }
        function ClientSelected(source, eventArgs) {

            var list = eventArgs.get_value().split('^');
            var slist = eventArgs.get_value().split('###');
        }
        var pVID = '<%= Request.QueryString["vid"] %>';

        function showModalPopupForDifferenceAmount() {
            GetBillingDetailsByRateTypeForOP();
            document.getElementById('<%= pnlDifferenceCalc.ClientID %>').style.display = "none";
            var modalPopupBehavior = $find('mpeDifferenceBehavior');
            modalPopupBehavior.show();
            return false;
        }
        function GetBillingDetailsByRateTypeForOP() {
            var arrGotValue = new Array();
            var RateId = document.getElementById('<%= hdnRateCardID.ClientID %>').value;
            var RateCardAmount = ToInternalFormat($('#' + '<%= hdnGross.ClientID %>'));
            var ToRateID = document.getElementById('<%= ddlRateCard.ClientID %>').value;
            var liOrgID = "<%=OrgID%>";

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../OPIPBilling.asmx/GetBillingDetailsByRateTypeForOP",
                data: JSON.stringify({ VisitID: pVID, BilledRateID: RateId, BilledRateCardAmount: RateCardAmount, SelectedRateID: ToRateID, OrgID: liOrgID, Type: 'OP' }),
                dataType: "json",
                success: function(data) {
                    if (data != null) {
                        document.getElementById('lblRateDifferenceAmount').innerHTML = Number(data.d).toFixed(2);
                        ToTargetFormat($('#lblRateDifferenceAmount'));
                        if (Number(data.d) <= 0) {
                            $('#btnAddToItem').attr('disabled', true);
                        }
                        else {
                            $('#btnAddToItem').attr('disabled', false);
                        }
                    }
                },
                error: function(result) {
                    $('#btnAddToItem').attr('disabled', true);
                    alert("Error");
                }
            });
        }
        function clearRateCardDiffAmount() {
            document.getElementById('txtRateCardDiffAmount').value = 0.00;
            document.getElementById('hdnRateCardDiffAmount').value = 0.00;
            $('#trRateCardDiffAmt').hide();
            totalCalculate();
            return false;
        }
        function AddRow1() {
            document.getElementById('txtRateCardDiffAmount').value = ToInternalFormat($('#lblRateDifferenceAmount'));
            document.getElementById('hdnRateCardDiffAmount').value = ToInternalFormat($('#lblRateDifferenceAmount'));
            $('#trRateCardDiffAmt').show();
            var modalPopupBehavior = $find('mpeDifferenceBehavior');
            modalPopupBehavior.hide();
            totalCalculate();
            //            $('#ddlRateCard').attr('disabled', true);
            //            $('#btnDifferenceCalculation').attr('disabled', true);
            return false;
        }
        function AddRow() {
            var countlength = document.getElementById('gvBillingDetail').rows.length;
            var Headrow = document.getElementById('gvBillingDetail').insertRow(countlength);
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            var cell5 = Headrow.insertCell(4);
            var cell6 = Headrow.insertCell(5);

            cell4.className = "right";
            cell5.className = "right";
            cell6.className = "right";

            cell1.innerHTML = "Difference Amount";
            cell2.innerHTML = "<input type='text' readonly='true' Style='text-align: right;width:60px;' value='" + document.getElementById('lblRateDifferenceAmount').innerHTML + "' />";
            cell3.innerHTML = "<input type='text' readonly='true' Style='text-align: right;width:60px;' value='1.00'/>";
            cell4.innerHTML = "<input type='text' readonly='true' Style='text-align: right;width:60px;' value='" + document.getElementById('lblRateDifferenceAmount').innerHTML + "' />";
            cell5.innerHTML = "<input type='text' readonly='true' Style='text-align: right;width:60px;' value='0'/>";
            cell6.innerHTML = "<input type='Checkbox' name='chkIsReImbursableItem' id='chkIsReImbursableItem' readonly='true'/>";

            var modalPopupBehavior = $find('mpeDifferenceBehavior');
            modalPopupBehavior.hide();
            TotalMedial();
            $('#ddlRateCard').attr('disabled', true);
            $('#btnDifferenceCalculation').attr('disabled', true);
            return false;

        }
    </script>

    <style type="text/css">
        .style1
        {
            height: 25px;
        }
        .style2
        {
            height: 108px;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnSave">

    <script type="text/javascript" language="javascript">
        function FuncChangeAmount(txtUnitPrice, hdnOldPrice,
                                     txtGross, txtDiscount,
                                     txtGrandTotal, hdnGross) {

            var UnitPrice = document.getElementById(txtUnitPrice);
            var OldPrice = document.getElementById(hdnOldPrice);
            var Gross = document.getElementById(txtGross);
            var Discount = document.getElementById(txtDiscount);
            var GrandTotal = document.getElementById(txtGrandTotal);
            var OldPricetoDelete = chkIsnumber(OldPrice.value);

            var hdnGrossBillAmount = document.getElementById(hdnGross);

            var OldAmounttoDelete = format_number(Number(OldPricetoDelete), 2);

            UnitPrice.value = chkIsnumber(UnitPrice.value);

            UnitPrice.value = format_number(Number(UnitPrice.value), 2);

            Gross.value = format_number((Number(Gross.value) + Number(UnitPrice.value) - Number(OldAmounttoDelete)), 2);
            hdnGrossBillAmount.value = Gross.value;

            OldPrice.value = UnitPrice.value;
            total();
        }
    
    </script>

    <script language="javascript" type="text/javascript">


        function showModalPopup(evt, footDescID, footAmtID) {
            //evt.preventDefault();
            //document.getElementById('<%= txtFeeDesc.ClientID %>').value = document.getElementById("footDescID").value;
            //document.getElementById('<%= txtAmnt.ClientID %>').value = document.getElementById("footAmtID").value;
            document.getElementById('<%= pnlOthers.ClientID %>').style.display = "none";
            var modalPopupBehavior = $find('mpeOthersBehavior');
            modalPopupBehavior.show();
            return false;
        }

        function showPhysician(eltFeeType, trID) {
            if (eltFeeType.value == "CON")
                trID.style.display = "block";
            else
                trID.style.display = "none";

        }

        //    function doOnSelectPhysician(source, eventArgs) {
        //        //alert(eventArgs.get_text() + "=>" + eventArgs.get_value());
        //        document.getElementById('<%= hdnFilterPhysicianID.ClientID %>').value = eventArgs.get_value();
        //    }

        function doResetConsultant(sender) {
            sender.value = '';
            sender.readOnly = false;
            document.getElementById('<%= hdnFilterPhysicianID.ClientID %>').value = "0";
        }

        function doValidation() {
            if (document.getElementById("txtFeeDesc").value.trim() == "") {
                alert("Please Enter Fee Description");
                document.getElementById("txtFeeDesc").focus();
                return false;
            }

            if (document.getElementById("ddlFeeType").value == "--Select Type--") {
                alert("Please Choose Fee type");
                document.getElementById("ddlFeeType").focus();
                return false;
            } else if (document.getElementById("ddlFeeType").value == "CON") {
                if (document.getElementById("hdnFilterPhysicianID").value.trim() == "0") {
                    if (document.getElementById("txtConsultant").value.trim() == "")
                        alert("Please Select The Physician To Tag");
                    else
                        alert("Entered Physician Name Not Exists");
                    document.getElementById("txtConsultant").value = "";
                    document.getElementById("txtConsultant").readOnly = false;
                    document.getElementById("txtConsultant").focus();
                    return false;
                }
            }

            if (document.getElementById("txtAmnt").value.trim() == "" || Number(document.getElementById("txtAmnt").value) == 0) {
                alert("Please Enter Fee Amount");
                document.getElementById("txtAmnt").focus();
                return false;
            }

            return true;
        }

        function doClear() {
            document.getElementById("txtFeeDesc").value = "";
            document.getElementById("txtAmnt").value = "";
            document.getElementById("ddlFeeType").setAttribute("SelectedIndex", "0", "true");
            document.getElementById("hdnFilterPhysicianID").value = "0";
            document.getElementById("txtConsultant").value = "";
            document.getElementById("chkNonReimburse").checked = true;
        }
    
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                <asp:Label ID="lblError" runat="server" meta:resourcekey="lblErrorResource1"></asp:Label>
                            </li>
                        </ul>
                        <table id="tblBilling" width="100%" border="0" runat="server" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="3">
                                    &nbsp;
                                    <input type="hidden" id="hdnDeduction" runat="server" />
                                    <input type="hidden" id="hdnGrossAmount" runat="server" />
                                    <input type="hidden" id="hdnGrandTotal" runat="server" />
                                    <input type="hidden" id="hdnCurrentDue" runat="server" />
                                    <input type="hidden" id="hdnRecievedAmount" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="100%" class="dataheaderInvCtrl" colspan="3">
                                    <table style="width: 100%">
                                        <tr>
                                            <td align="left" colspan="2" nowspan="nowspan">
                                                <asp:Label ID="lblClientNameText" runat="server" Text="Client Name : " Style="font-weight: bold;">                                                
                                                </asp:Label>
                                                <asp:Label ID="lblClient" runat="server" Text="">                                                
                                                </asp:Label>
                                                <asp:HiddenField ID="hdnClientId" runat="server" Value="0" />
                                            </td>
                                            <td align="left" colspan="2">
                                                <asp:Label ID="lblRateCardName" runat="server" Text="RateCard Name : " Style="font-weight: bold;">                                                
                                                </asp:Label>
                                                <asp:Label ID="lblRateCard" runat="server" Text="" class="defaultfontcolor">                                                
                                                </asp:Label>
                                                <asp:HiddenField ID="hdnRateCardID" runat="server" Value="0" />
                                            </td>
                                            <td colspan="2">
                                                <asp:Label ID="lblChangeClientName" runat="server" Text="Change Client Name : " Style="font-weight: bold;"></asp:Label>
                                                <asp:TextBox ID="txtClient" Width="150px" runat="server" CssClass="biltextb"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                    ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True" OnClientItemSelected="ClientSelected">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td colspan="2">
                                                <asp:Label ID="Label8" runat="server" Text="Change RateCard Type : " Style="font-weight: bold;"></asp:Label>
                                                <asp:DropDownList ID="ddlRateCard" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnDifferenceCalculation" Text="Calculate Difference" runat="server"
                                                    OnClientClick="javascript:return showModalPopupForDifferenceAmount();" CssClass="dataheader1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="pnlDifferenceCalc" runat="server" Style="display: none;" CssClass="modalPopup dataheaderPopup">
                                                    <table width="100%" cellpadding="5" cellspacing="5">
                                                        <tr>
                                                            <td align="center">
                                                                <asp:Label ID="lblDifferencText" runat="server" Text="Difference Between Rate Card Amount"></asp:Label>
                                                                <asp:Label ID="lblRateDifferenceAmount" runat="server" Text="0.00"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <input type="button" id="btnAddToItem" class="btn" onclick="AddRow1();" value="Add To Bill" />
                                                                <input type="button" id="btnItemCancel" class="btn" value="Cancel" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <asp:HiddenField ID="hdnRateDifferencePop" runat="server" />
                                                <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BehaviorID="mpeDifferenceBehavior"
                                                    PopupControlID="pnlDifferenceCalc" CancelControlID="btnItemCancel" TargetControlID="hdnRateDifferencePop"
                                                    DropShadow="false" Drag="false" BackgroundCssClass="modalBackground">
                                                </ajc:ModalPopupExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                    <asp:Panel ID="trABI" runat="server" CssClass="defaultfontcolor" meta:resourcekey="trABIResource1">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td align="left" height="23" class="colorforcontent" width="25%">
                                                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                        <tr>
                                                            <td class="dataheaderInvCtrl">
                                                                <table>
                                                                    <tr>
                                                                        <td align="left" width="70%">
                                                                            <asp:Label ID="Rs_MiscellaneousAmount" Text="Miscellaneous Amount" runat="server"
                                                                                meta:resourcekey="Rs_MiscellaneousAmountResource1" />
                                                                        </td>
                                                                        <td align="right" width="30%">
                                                                            <%--<input id="btnAdd" type="button" class="dataheader1" style="width: 100px;" value="Add"
                                                                                onclick="showModalPopup(event);" />--%>
                                                                            <asp:Button ID="btnAdd" CssClass="dataheader1" Style="width: 100px;" Text="Add" OnClientClick="javascript:return showModalPopup(event);"
                                                                                runat="server" meta:resourcekey="btnAdd1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                    <asp:Panel ID="pnlOthers" runat="server" Style="display: none;" CssClass="modalPopup dataheaderPopup"
                                        meta:resourcekey="pnlOthersResource1">
                                        <center>
                                            <div id="divOthers" style="width: 350px; height: 200px; padding-top: 50px; padding-left: 15px">
                                                <table width="90%" align="center">
                                                    <tr align="left">
                                                        <td>
                                                            <label id="lblFeeDesc" style="width: 155px;">
                                                                <asp:Label ID="Rs_FeeDescription" Text="Fee Description" runat="server" meta:resourcekey="Rs_FeeDescriptionResource1"></asp:Label></label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtFeeDesc" runat="server" meta:resourcekey="txtFeeDescResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr align="left">
                                                        <td>
                                                            <label id="lblFeeType" style="width: 155px;">
                                                                <asp:Label ID="Rs_TagTo" Text="Tag To" runat="server" meta:resourcekey="Rs_TagToResource1"></asp:Label></label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlFeeType" Width="155px" runat="server" onchange="javascript:showPhysician(this,getElementById('trPhysician'));"
                                                                meta:resourcekey="ddlFeeTypeResource1">
                                                                <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr id="trPhysician" style="display: none" align="left">
                                                        <td>
                                                            <label id="lblPhysician" style="width: 155px;">
                                                                <asp:Label ID="Rs_TagToPhysician" Text="Tag To Physician" runat="server" meta:resourcekey="Rs_TagToPhysicianResource1"></asp:Label>
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtConsultant" onclick="javascript:doResetConsultant(this);" onblur="this.readOnly=true;"
                                                                runat="server" meta:resourcekey="txtConsultantResource1"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteConsultant" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                                UseContextKey="True" MinimumPrefixLength="2" OnClientItemSelected="doOnSelectPhysician"
                                                                ServiceMethod="GetConsultantName" ServicePath="~/WebService.asmx" TargetControlID="txtConsultant"
                                                                DelimiterCharacters="" Enabled="True">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                    </tr>
                                                    <tr align="left">
                                                        <td>
                                                            <label id="lblAmount" style="width: 155px;">
                                                                <asp:Label ID="Rs_FeeAmount" Text="Fee Amount" runat="server" meta:resourcekey="Rs_FeeAmountResource1"></asp:Label></label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAmnt" runat="server"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                onblur="return NumberALLFormat(this.id);" meta:resourcekey="txtAmntResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr align="left">
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="chkNonReimburse" runat="server" Checked="True" Text="Is This Reimbursable Item."
                                                                meta:resourcekey="chkNonReimburseResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Button ID="btnOK" CssClass="btn" runat="server" Text="OK" OnClientClick="javascript:return doValidation();"
                                                                OnClick="btnAddAmt_Click" meta:resourcekey="btnOKResource1" />
                                                        </td>
                                                        <td align="left">
                                                            <input type="button" id="btnPopCancel" class="btn" onclick="javascript:doClear();"
                                                                runat="server" value="Cancel" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </center>
                                    </asp:Panel>
                                    <%--<asp:Button ID="hiddenTargetControlFormpeOthers" runat="server" Style="display: none" />--%>
                                    <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
                                    <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
                                        PopupControlID="pnlOthers" CancelControlID="btnPopCancel" TargetControlID="hiddenTargetControlFormpeOthers"
                                        DynamicServicePath="" Enabled="True">
                                    </ajc:ModalPopupExtender>
                                    <asp:HiddenField ID="hdnFilterPhysicianID" runat="server" Value="0" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <div id="divItems">
                                        <asp:GridView ID="gvBillingDetail" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvBillingDetail_RowDataBound"
                                            Width="100%" meta:resourcekey="gvBillingDetailResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <PagerStyle CssClass="dataheader1" />
                                            <Columns>
                                                <asp:TemplateField ControlStyle-CssClass="gridControlStyle" FooterStyle-CssClass="gridFooterStyle"
                                                    HeaderStyle-CssClass="gridHeaderStyle" ItemStyle-CssClass="gridItemStyle" ShowHeader="false"
                                                    Visible="false" meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblBillNo" runat="server" Text='<%# Bind("FinalBillID") %>' meta:resourcekey="lblBillNoResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ControlStyle CssClass="gridControlStyle"></ControlStyle>
                                                    <FooterStyle CssClass="gridFooterStyle"></FooterStyle>
                                                    <HeaderStyle CssClass="gridHeaderStyle"></HeaderStyle>
                                                    <ItemStyle CssClass="gridItemStyle"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Sno" ControlStyle-CssClass="gridControlStyle" FooterStyle-CssClass="gridFooterStyle"
                                                    HeaderStyle-CssClass="gridHeaderStyle" ItemStyle-CssClass="gridItemStyle" Visible="false"
                                                    ShowHeader="false" meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSno" runat="server" meta:resourcekey="lblSnoResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <ControlStyle CssClass="gridControlStyle"></ControlStyle>
                                                    <FooterStyle CssClass="gridFooterStyle"></FooterStyle>
                                                    <HeaderStyle CssClass="gridHeaderStyle"></HeaderStyle>
                                                    <ItemStyle CssClass="gridItemStyle"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFeeID" runat='server' Text='<%# Bind("FeeID") %>' Visible="False"
                                                            meta:resourcekey="lblFeeIDResource1"></asp:Label>
                                                        <asp:Label ID="lblFeeType" runat='server' Text='<%# Bind("FeeType") %>' Visible="False"
                                                            meta:resourcekey="lblFeeTypeResource1"></asp:Label>
                                                        <asp:Label ID="lblDescription" runat='server' Text='<%# Bind("FeeDescription") %>'
                                                            meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="UnitPrice" meta:resourcekey="TemplateFieldResource4">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("Amount") %>' runat="server" />
                                                        <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                            Text='<%# Eval("Amount") %>'  onkeypress="return ValidateOnlyNumeric(this);"  Width="60px"
                                                            meta:resourcekey="txtUnitPriceResource1"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource5">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("Quantity") %>' runat="server" />
                                                        <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                            Text='<%# Eval("Quantity") %>'  onkeypress="return ValidateOnlyNumeric(this);"  Width="60px"
                                                            meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource6">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                            Text='<%# NumberConvert(Eval("Quantity"),Eval("Amount")) %>' Width="60px" meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnAmount" runat="server" />
                                                        <asp:Label ID="lblEditStats" runat="server" Visible="False" Text='<%# Eval("UseEdit") %>'
                                                            meta:resourcekey="lblEditStatsResource1"></asp:Label>
                                                        <asp:Label ID="BillingDetailsID" runat="server" Visible="False" Text='<%# Eval("BillingDetailsID") %>'
                                                            meta:resourcekey="BillingDetailsIDResource1" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource1" />
                                                <asp:TemplateField HeaderText="Discount" meta:resourcekey="TemplateFieldResource7">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtDiscount" runat="server" Style="text-align: right;" Text='0'
                                                             onkeypress="return ValidateOnlyNumeric(this);"  Width="60px" meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="IsReimbursable" meta:resourcekey="TemplateFieldResource8">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" meta:resourcekey="chkIsReImbursableItemResource1"
                                                            onclick="javascript:return TotalMedial();" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <table width="100%">
                                        <tr>
                                            <td valign="bottom">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <ctrlBalCalc:BalanceCalc ID="ctrlBalanceCalc" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <div id="trDepositUsage" runat="server">
                                                                <ucDU:DepositUsage ID="DepositUsageCtrl" runat="server" BaseControlID="txtGrandTotal"
                                                                    TargetControlID="hdnDepositUsed" OtherCurrencyControlID="OtherCurrencyDisplay1"
                                                                    DisplayControlID="txtAmountRecieved" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table style="display: none;" id="tdCopayment" border="0" width="100%">
                                                    <tr>
                                                        <td colspan="7">
                                                            <asp:Label ID="lblCopaymentLogin" Text="" runat="server" Style="font-weight: bold;"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr class="dataheader2" style="font-weight: bold;">
                                                        <td>
                                                            <asp:Label ID="Label7" runat="server" Text="Client Name" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label6" runat="server" Text="PreAuth Amount" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label2" runat="server" Text="Claim Amount " />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label5" runat="server" Text="Medical Amount" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label3" runat="server" Text="Non Medical Amount" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" runat="server" Text="Actual Copayment" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPreAuthAmt" Text="Towards Amount" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td>
                                                            <asp:Label ID="lblClientName" runat="server" Text=""></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPreAuthAmount" runat="server" Text="0.00"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblClaminAmount" runat="server" Text="0.00"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblMedical" runat="server" Text="Medical Amount" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblNonMedical" runat="server" Text="0.00" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblActualCopaymenttxt" runat="server" Text="0.00"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDifferenceAmount" runat="server" Text="0.00"></asp:Label>
                                                            <asp:HiddenField ID="hdnIsCreditBill" runat="server" Value="N" />
                                                            <asp:HiddenField ID="hdnClaimlogin" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnPaymentlogin" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnCoPercentage" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnPerAuthAmount" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnClaim" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnCopayment" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnTowardsAmount" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdnVisitClientMappingID" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                            </td>
                                            <td>
                                                <table width="100%">
                                                    <tr>
                                                        <td width="22%">
                                                            <asp:Label ID="lblDueAmount" CssClass="labletext" Text="Due" runat="server" meta:resourcekey="lblDueAmount1"></asp:Label>
                                                            &nbsp;
                                                            <asp:TextBox ID="txtDueAmount" CssClass="textBoxRightAlign" Width="40%" ReadOnly="true"
                                                                runat="server" Text="0.00"></asp:TextBox>
                                                        </td>
                                                        <td width="31%" align="right">
                                                            <asp:Label ID="lblGross" runat="server" Text="Gross" class="defaultfontcolor" meta:resourcekey="lblGrossResource1" />
                                                        </td>
                                                        <td width="20%" align="right" class="details_value">
                                                            <asp:TextBox ID="txtGross" runat="server" Text="0.00" TabIndex="1" CssClass="textBoxRightAlign"
                                                                Enabled="False" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                                            <asp:HiddenField ID="hdnGross" runat="server" Value="0" />
                                                            <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none;">
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblSubDeduction" runat="server" Text="Sub. Deduction" class="defaultfontcolor"
                                                                meta:resourcekey="lblSubDeductionResource1" />
                                                        </td>
                                                        <td align="right" class="details_value">
                                                            <asp:DropDownList ID="ddlSubDeduction" runat="server" TabIndex="2" OnSelectedIndexChanged="ddlSubDeduction_SelectedIndexChanged"
                                                                onChange="DeductionCalculation();" Width="125px" meta:resourcekey="ddlSubDeductionResource1">
                                                                <asp:ListItem Value="0" Text="=--Select--" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none;">
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtSubDeduction" runat="server" TabIndex="3" onkeyup="total();"
                                                                Height="22px" Text="0.00" CssClass="textBoxRightAlign" onblur="ChangeFormat();"
                                                                Enabled="False" meta:resourcekey="txtSubDeductionResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <%--Select Corporate &nbsp;
                                    <asp:DropDownList ID="ddlCorporate" onchange="javascript:calculateDiscountForCorporate();" runat="server">
                                                                </asp:DropDownList>--%>
                                                            <asp:Label ID="lblDiscount" runat="server" Text="Discount" class="defaultfontcolor"
                                                                meta:resourcekey="lblDiscountResource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtDiscount" runat="server" TabIndex="4" onkeyup="javascript:CorrectTotal();total();SetOtherCurrValues();"
                                                                Text="0.00" CssClass="textBoxRightAlign" onblur="javascript:ChangeFormat(); ValidateDiscountReason();AddDiscountsCheck();"
                                                                 onkeypress="return ValidateOnlyNumeric(this);"  meta:resourcekey="txtDiscountResource2" />
                                                            <%-- onfocus="DefaultText('txtDiscount');"--%>
                                                        </td>
                                                    </tr>
                                                    <tr id="trDiscountReason" style="display: none;">
                                                        <td align="right">
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblReasonforDiscount" runat="server" Text="Reason for Discount" class="defaultfontcolor"
                                                                meta:resourcekey="Label1Resource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtDiscountReason" runat="server" TabIndex="5" CssClass="textBoxRightAlign"
                                                                meta:resourcekey="txtDiscountReasonResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none;">
                                                        <td class="style1">
                                                            &nbsp;
                                                        </td>
                                                        <td align="right" class="style1">
                                                            <asp:Label ID="lblGrossAmount" runat="server" Text="Gross Amount" class="defaultfontcolor"
                                                                meta:resourcekey="lblGrossAmountResource1" />
                                                        </td>
                                                        <td align="right" class="style1">
                                                            <asp:TextBox ID="txtGrossAmount" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                                                CssClass="textBoxRightAlign" meta:resourcekey="txtGrossAmountResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none;">
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblRecievedAmount" runat="server" Text="Previous Received Amount"
                                                                class="defaultfontcolor" meta:resourcekey="lblRecievedAmountResource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtRecievedAmount" runat="server" Text="0.00" Enabled="False" TabIndex="7"
                                                                CssClass="textBoxRightAlign" meta:resourcekey="txtRecievedAmountResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none;">
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <img alt="" onclick="ChangeImage();" src="../Images/collapse.jpg" id="imgDue" />
                                                            <a id="A1" href="" onclick="ChangeImage();" runat="server" style="color: Black; font-size: 11">
                                                                <asp:Label ID="Rs_Due" Text="Due" runat="server" meta:resourcekey="Rs_DueResource1"></asp:Label>
                                                            </a>
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtDue" runat="server" Text="0" Enabled="False" TabIndex="8" CssClass="textBoxRightAlign"
                                                                meta:resourcekey="txtDueResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="color: Black">
                                                            <div id="Due" style="display: none; padding-left: 30px" title="Due Details">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td align="center">
                                                                            <uc6:DueDetail ID="dueDetail" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                        </td>
                                                        <td align="right" valign="top">
                                                            <asp:Label ID="Rs_Tax" Text="Tax" runat="server" meta:resourcekey="Rs_TaxResource1" />
                                                        </td>
                                                        <td align="right" valign="top">
                                                            <asp:TextBox ID="txtTax" runat="server" CssClass="textBoxRightAlign" meta:resourcekey="txtTaxResource1"></asp:TextBox>
                                                            <asp:HiddenField ID="hdfTax" runat="server" />
                                                            <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
                                                            <div id="dvTaxDetails" align="left" runat="server">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td align="right">
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs_ServiceChargeResource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtServiceCharge" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                                                CssClass="textBoxRightAlign" meta:resourcekey="txtServiceChargeResource1" />
                                                            <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr id="trRateCardDiffAmt" style="display:none;">
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblDifferenceAmountRateCardChange" runat="server" Text="Difference Amount"></asp:Label>
                                                            <asp:ImageButton ID="imgDee" ImageUrl="~/Images/Delete.jpg" OnClientClick="return clearRateCardDiffAmount();" runat="server" ToolTip="Cancel the Rate Card difference Amount" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtRateCardDiffAmount" Enabled="False" runat="server" Text="0.00"
                                                                TabIndex="9" CssClass="textBoxRightAlign" meta:resourcekey="txtRoundOffResource1" />
                                                            <asp:HiddenField ID="hdnRateCardDiffAmount" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="Rs_RoundOffAmount" Text="Round Off Amount" runat="server" meta:resourcekey="Rs_RoundOffAmountResource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtRoundOff" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                                                CssClass="textBoxRightAlign" meta:resourcekey="txtRoundOffResource1" />
                                                            <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblGrandTotal" runat="server" Text="Net Value" class="defaultfontcolor"
                                                                meta:resourcekey="lblGrandTotalResource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtGrandTotal" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                                                CssClass="textBoxRightAlign" meta:resourcekey="txtGrandTotalResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Recieved" class="defaultfontcolor"
                                                                meta:resourcekey="lblAmountRecievedResource1" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:TextBox ID="txtAmountRecieved" runat="server" TabIndex="10" Text="0" ReadOnly="True"
                                                                CssClass="textBoxRightAlign" meta:resourcekey="txtAmountRecievedResource1" />
                                                            <asp:HiddenField ID="hdnAmountReceived" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td align="right" colspan="2" style="display: none;">
                                                            <asp:CheckBox ID="chkisCreditTransaction" Text="Credit Transaction" runat="server"
                                                                class="defaultfontcolor" onclick="checkIsCredit();" meta:resourcekey="chkisCreditTransactionResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>

                        <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>

                        <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

                        <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <uc9:paymentType ID="PaymentType" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table border="0">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnSave" Enabled="False" Text="Save" runat="server" TabIndex="11"
                                                    OnClick="btnSave_Click" CssClass="btn" OnClientClick=" return CheckBilling1();"
                                                    onmouseout="this.className='btn'" meta:resourcekey="btnSaveResource1" />
                                                <%--     <asp:Button ID="btnPrintBill" Text="PrintBill" runat="server" TabIndex="10" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Visible="false"
                                        OnClick="btnPrintBill_Click" />--%>
                                            </td>
                                            <td align="left">
                                                <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" TabIndex="12"
                                                    onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <input type="hidden" id="hdnCorporateDiscount" runat="server" />
    <asp:TextBox ID="txtReceivedAdvance" Style="display: none;" runat="server" meta:resourcekey="txtReceivedAdvanceResource1"></asp:TextBox>
    <asp:TextBox ID="txtPreviousAmountPaid" runat="server" Text="0.00" Style="display: none;"
        meta:resourcekey="txtPreviousAmountPaidResource1" />
    <asp:TextBox ID="txtPreviousDue" runat="server" Text="0.00" Style="display: none;"
        meta:resourcekey="txtPreviousDueResource1" />
    <asp:TextBox ID="txtRecievedAdvance" runat="server" Text="0.00" Style="display: none;"
        meta:resourcekey="txtRecievedAdvanceResource1" />
    <asp:TextBox ID="txtRefundAmount" runat="server" Text="0.00" Style="display: none;"
        meta:resourcekey="txtRefundAmountResource1" />
    <asp:HiddenField ID="hdnDiscountArray" runat="server" />
    <asp:HiddenField ID="hdnDefaultRoundoff" runat="server" />
    <asp:HiddenField ID="hdnRoundOffType" runat="server" />
    <asp:HiddenField ID="hdntotalNonMedical" runat="server" />
    <asp:HiddenField ID="hdntotalMedial" runat="server" />
     <input id="hdnDepositUsed" runat="server" type="hidden" value="0.00"></input>
    </form>

    <script language="javascript" type="text/javascript">
        calculateDiscountForCorporate();
        function calculateDiscountForCorporate() {
            var x, j, i, k;
            document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
            ToTargetFormat($('#txtDiscount'));
            x = document.getElementById('hdnCorporateDiscount').value.split("^");
            //objVal = document.getElementById('ddlCorporate').value;
            i = x.length;
            for (j = 0; j < i; j++) {
                if (x[j] != "") {
                    k = x[j].split("~");

                    if (k[1] == "Percentage") {

                        document.getElementById('txtDiscount').value = parseFloat(parseFloat(parseFloat(document.getElementById('txtGross').value) / 100) * parseFloat(k[0])).toFixed(2);
                        ToTargetFormat($('#txtDiscount'));
                        //document.getElementById('lblDiscount').innerText = " Discount %";
                    }
                    else {
                        document.getElementById('txtDiscount').value = parseFloat(k[0]).toFixed(2);
                        ToTargetFormat($('#txtDiscount'));
                        //document.getElementById('lblDiscount').innerText = " Discount";
                    }
                    //document.getElementById('txtDiscount').readOnly = true;

                    //                    else if (objVal == 0) {
                    //                    document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
                    //                    document.getElementById('txtDiscount').readOnly = false;
                    //                    document.getElementById('lblDiscount').innerText = " Discount";
                    //                    }
                }
            }
            CorrectTotal();
            total();

        }
    </script>

    <script language="javascript" type="text/javascript">
        function doOnSelectPhysician(source, eventArgs) {
            // alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            // eventArgs.get_value()[0].PatientID;
            //            var list = eventArgs.get_value().split('^');
            //            if (list.length > 0) {
            //                for (i = 0; i < list.length; i++) {
            //                    if (list[i] != "") {
            //                        var phyFeeId = list[0];
            //                        var phyName = list[1];
            //                        var feeType = list[2];
            //                        var amount = list[3];
            //                        var physicianLID = list[4];
            //                        var specialityID = list[5];

            //                        document.getElementById('txtAmnt').value = amount;
            //                        document.getElementById('hdnFilterPhysicianID').value = phyFeeId;

            //                    }
            //                }
            //            }
            document.getElementById('hdnFilterPhysicianID').value = eventArgs.get_value();
            ToTargetFormat($('#hdnFilterPhysicianID'));
        }

    </script>

    <script language="javascript" type="text/javascript">


        function SetOtherCurrValues() {
            var pnetAmt = 0;
            document.getElementById('txtGrandTotal').value = document.getElementById('txtGrandTotal').value == "" ? "0" : document.getElementById('txtGrandTotal').value;
            pnetAmt = ToInternalFormat($('#txtGrandTotal'));
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }

        GetCurrencyValues();
    </script>

    <script type="text/javascript">
     
     
     function TotalMedial()
     {   
    
        var  totalMedial=0;    
        var totalNonMedical=0;
        
       $("#divItems table tr").each(function() {
          var Medtr = $(this).closest("tr");
        if ($(Medtr).find("input:text[id$=txtAmount]").val() != undefined) {
           var chk = $(Medtr).find("input:checkbox[id$=chkIsReImbursableItem]").attr('checked') ? true : false;
            var Amount=0;                            
              //Amount=$(Medtr).find("input:text[id$=txtAmount]")?$(Medtr).find("input:text[id$=txtAmount]").val():0;   
               Amount=$(Medtr).find("input:text[id$=txtAmount]")?ToInternalFormat($(Medtr).find("input:text[id$=txtAmount]")):0;                                                            
           
               if(chk==true){ 
                     totalMedial=parseFloat(totalMedial)+parseFloat(Amount);                            
                 }
                 else{
                       totalNonMedical =parseFloat(totalNonMedical)+parseFloat(Amount);   
                     }
                }
                
          });
               

         document.getElementById("hdntotalMedial").value= totalMedial; 
         document.getElementById("hdntotalNonMedical").value=totalNonMedical;
          document.getElementById("lblMedical").innerHTML=totalMedial;
         document.getElementById("lblNonMedical").innerHTML=totalNonMedical;
     
       Cal_Copayment();
     
    }
    
     function Cal_Copayment() {     
           
    if(document.getElementById('hdnIsCreditBill').value=="Y"){       
        //var totalNonMedical= document.getElementById('hdntotalNonMedical').value;//ToInternalFormat("$lblNonMedicalAmt");
        var totalNonMedical= ToInternalFormat($('#hdntotalNonMedical'));
        //var totalMedial=document.getElementById('hdntotalMedial').value; //Number(ToInternalFormat('$dspData_lblTotalAmt'))- Number(totalNonMedical) ; 
         var totalMedial=ToInternalFormat($('#hdntotalMedial'));     
        var CoPaymentlogic=document.getElementById('hdnPaymentlogin').value;
    //  var Copayment_Percentage=document.getElementById('hdnCoPercentage').value;
        var Copayment_Percentage=ToInternalFormat($('#hdnCoPercentage'));
        //var PrAutAmount=document.getElementById('hdnPerAuthAmount').value;       
        var PrAutAmount=ToInternalFormat($('#hdnPerAuthAmount'));
        var Claimlogin=document.getElementById('hdnClaimlogin').value;
        var _claimAmount=0;     
          
        if(Number(PrAutAmount)>0 ||  Number(Copayment_Percentage)>0){  
         document.getElementById('tdCopayment').style.display="block";  
        _actualCoPayment=Copayment_Login(CoPaymentlogic,Copayment_Percentage,PrAutAmount,totalMedial);                  
        _claimAmount=Copayment_Deducted_Login(Claimlogin,PrAutAmount,totalMedial,_actualCoPayment);                  
         var NetValue= ToInternalFormat($('#txtGrandTotal'));    
         document.getElementById("lblDifferenceAmount").innerHTML= (Number(NetValue)- Number(_claimAmount)).toFixed(2);   
         
         document.getElementById('lblActualCopaymenttxt').innerHTML = _actualCoPayment.toFixed(2);                   
         document.getElementById("lblClaminAmount").innerHTML=Number(_claimAmount).toFixed(2);
             
         document.getElementById('hdnCopayment').value=_actualCoPayment.toFixed(2);         
         document.getElementById('hdnClaim').value=Number(_claimAmount).toFixed(2);    
         document.getElementById('hdnTowardsAmount').value=(Number(NetValue)- Number(_claimAmount)).toFixed(2);         
                  
         ToTargetFormat($('#lblActualCopaymenttxt'));
         ToTargetFormat($('#lblClaminAmount'));   
         ToTargetFormat($('#lblDifferenceAmount'));  
          ToTargetFormat($('#hdnCopayment'));
         ToTargetFormat($('#hdnClaim'));   
         ToTargetFormat($('#hdnTowardsAmount'));  
        
        } 

       }  
       else
       {
        document.getElementById('tdCopayment').style.display="none";
       
       }  
     }

   TotalMedial();

   OPIPBilling.loadWebDueDetail('<%= OrgID %>', <%= Request.QueryString["pid"] %>, 0, DueList);
        
        function DueList(tmpVal) {
            var dueamt = 0;
            if (tmpVal.length > 0) {
                var listLen = tmpVal.length;
                for (var i = 0; i < listLen; i++) {
                    dueamt = Number(tmpVal[i].PatientDue, 2) + Number(dueamt, 2);
                }
                document.getElementById('<%= txtDueAmount.ClientID %>').value = parseFloat(dueamt).toFixed(2);
                ToTargetFormat($('#txtDueAmount'));
            }
            
        }
   function NumberALLFormat(ID) {
       document.getElementById(ID).value = Number(ToInternalFormat($('#' + ID))).toFixed(2);
       ToTargetFormat($('#' + ID));
       return false;
   }
totalCalculate();
    </script>

</body>
</html>
