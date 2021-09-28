<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditIPFinalBill.aspx.cs" Inherits="InPatient_EditIPFinalBill" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc13" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>In-Patient Bill Settlement</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />    

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script src="../Scripts/IPBillSettlement.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        //        function ValidateOTH() {
        //            if (document.form1.txtDesc.value == '') {
        //                alert("Enter Miscellaneous Description");
        //                document.form1.txtDesc.focus();
        //                return false;
        //            }
        //            if (document.form1.txtAmt.value == '') {
        //                alert("Enter Miscellaneous Amount");
        //                document.form1.txtAmt.focus();
        //                return false;
        //            }
        //            return true;
        //        }
        function CheckDischarge() {
            if (document.getElementById('chkDischarge').checked == true) {
                NewCal('<%=txtDischargeDate.ClientID %>', 'ddmmyyyy', true, 12)
                return true;
            }
            if (document.getElementById('chkDischarge').checked == false) {
                alert("Click Discharge patient");
                return false;
            }
        }
//        function ShowHideButton() {
//            if (document.getElementById('chkDischarge').checked == true) {
//                document.getElementById('trPaymentControl').style.display = "block";
//                document.getElementById('btnSave').style.display = "block";
//                document.getElementById('btnSaveTemp').style.display = "none";

//            }
//            if (document.getElementById('chkDischarge').checked == false) {
//                document.getElementById('trPaymentControl').style.display = "none";
//                document.getElementById('btnSave').style.display = "none";
//                document.getElementById('btnSaveTemp').style.display = "block";
//            }

//        }
////        
    </script>

    <script type="text/javascript">
        $(function() {
            var $img = $(':img[id$=imgdischarge]');
            var $txt = $(':input[id$=txtDischargeDate]');
            var $chk = $('input:checkbox[id$=chkDischarge]');

            // check on page load
            checkChecked($chk);

            $chk.click(function() {
                checkChecked($chk);
            });

            function checkChecked(chkBox) {
                if (chkBox.is(":checked")) {
                    $img.removeAttr('disabled');
                    $txt.removeAttr('disabled');
                    //NewCal('<%=txtDischargeDate.ClientID %>', 'ddmmyyyy', true, 12);
                } else {
                    //  $img.attr('disabled', 'disabled');
                    $txt.attr('disabled', 'disabled');
                }
            }
        });
    </script>

    <script language="javascript" type="text/javascript">

        function SetOtherCurrValues() {
            var pnetAmt = 0;
            pnetAmt = document.getElementById('txtGrandTotal').value == "" ? "0" : document.getElementById('txtGrandTotal').value;
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }
       
    
    </script>

    <style type="text/css">
        .style1
        {
            height: 34px;
        }
        .style2
        {
            height: 61px;
        }
        .style3
        {
            height: 22px;
        }
    </style>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <input type="hidden" id="hdnRecievedAmount" runat="server" />
    <input type="hidden" id="hdnCurrentDue" runat="server" />
    <input type="hidden" id="hdnGrandTotal" runat="server" />
    <input type="hidden" id="hdnDeduction" runat="server" />

    <script type="text/javascript">
        animatedcollapse.addDiv('Due', 'fade=1,height=1%');
        animatedcollapse.init();

        function CheckBilling(id) {

            if (checkAdmitDischargeDate()) {
                if (checkBillMaxDischargeDate()) {

                    var returndatavalue = SaveValidation();

                    //                    doCalcReimburse();
                    if (document.getElementById(id).value == "Generate Bill") {
                        if (document.getElementById('ddlPayMode').value == "2") {
                            if (document.getElementById('txtBankName').value == "") {
                                alert("Enter the Bank Name");
                                return false;
                            }
                            if (document.getElementById('txtCardNo').value == "") {
                                alert("Enter the Cheque Number");
                                return false;
                            }
                        }

                        if (document.getElementById('txtDiscount').value > 0) {
                            if (document.getElementById('txtDiscountReason').value == "") {
                                alert('Enter Reason for Discount.');
                                document.getElementById('txtDiscountReason').focus();
                                return false;
                            }
                        }
                        var GenerateBill = confirm("Do you want to continue");
                        if (GenerateBill == true) {

                            return true;

                        }
                        else {
                            return false;
                        }
                    }


                    if (returndatavalue == true) {
                        if (Number(document.getElementById('txtGrandTotal').value) < Number(document.getElementById('txtAmountRecieved').value)) {

                            alert('Amount recieved greater than current total. \n Please check recieved amount.');
                            document.getElementById('txtAmountRecieved').value = '';
                            document.getElementById('hdnAmountReceived').value = '0';
                            return false;
                        }
                        if ((document.getElementById('chkisCreditTransaction').checked == false) && (document.getElementById('ChkRefund').checked == false)) {

                            if ((Number(document.getElementById('txtAmountRecieved').value) < 0) && (Number(document.getElementById('txtGrandTotal').value) != 0)) {
                                alert('Please enter recieved amount');
                                return false;
                            }
                        }

                        if (document.getElementById('ChkRefund').checked == true) {

                            if (document.getElementById('txtReasonForRefund').value == "") {

                                alert('Please enter Reason for refund');
                                return false;
                            }
                        }
                        if (document.getElementById('txtDiscount').value > 0) {
                            if (document.getElementById('txtDiscountReason').value == "") {
                                alert('Enter Reason for Discount.');
                                document.getElementById('txtDiscountReason').focus();
                                return false;
                            }
                            else {
                                return true;


                            }
                        }
                        else {
                            return true;
                        }
                        //document.getElementById('btnSave').style.display = 'none';

                        return true;
                    }

                    else {
                        return false;
                    }

                    //checkbillMaxDischargeDate if ends here
                } else {
                    return false;
                }
                //checkAdmitDischargeDate if ends here
            } else {
                return false;
            }
            if (Number(document.getElementById('txtAmountRecieved').value) < Number(document.getElementById('txtGrandTotal').value)) {


            }
            $get('btnSave').disabled = true;
            javascript: __doPostBack('btnSave', '');
        }
        function funcRefundChk() {
            var ddlPayMode = document.getElementById('ddlPayMode');

            if (document.getElementById('ChkRefund').checked == false) {
                document.getElementById('dvRefund').style.display = 'none';
                document.getElementById('reasonforRefund').style.display = 'none';
                document.getElementById('refundmode').style.display = 'none';
                document.getElementById('PayMode').style.display = 'none';
                document.getElementById('banknametxt').style.display = 'none';
                document.getElementById('bankname').style.display = 'none';
                document.getElementById('CardNo').style.display = 'none';
                document.getElementById('CardNotxt').style.display = 'none';

            }
            else {
                document.getElementById('reasonforRefund').style.display = 'block';
                document.getElementById('dvRefund').style.display = 'block';
                document.getElementById('refundmode').style.display = 'block';
                document.getElementById('PayMode').style.display = 'block';

                if (ddlPayMode.options[ddlPayMode.selectedIndex].value == 2) {
                    document.getElementById('banknametxt').style.display = 'block';
                    document.getElementById('bankname').style.display = 'block';
                    document.getElementById('CardNo').style.display = 'block';
                    document.getElementById('CardNotxt').style.display = 'block';
                }
            }
        }
        function DefaultText(id) {

            document.getElementById(id).value = "";

        }

        function doAssignUnBilledReceivable() {
            if (document.getElementById("chkShowUnbilled").checked) {
                // document.getElementById('hdnUnBilledAdvanceReceived').value = document.getElementById('txtRefundAmount').value == "" ? parseFloat(0).toFixed(2) : parseFloat(document.getElementById('txtRefundAmount').value).toFixed(2);
                document.getElementById('<%= txtRecievedAdvance.ClientID %>').value = document.getElementById('hdnUnBilledAdvanceReceived').value;
            }
        }

        function totalCalculate() {
            // doAssignUnBilledReceivable();
            if ((document.getElementById('ddDiscountPercent').value) != 'select') {
                document.getElementById('txtDiscount').value = parseFloat((parseFloat(document.getElementById('hdnGross').value) / 100) * (document.getElementById('ddDiscountPercent').value)).toFixed(2);
                document.getElementById('txtDiscount').readOnly = true;
            }
            else {
                document.getElementById('txtDiscount').readOnly = false;
            }

            var GrossAmount = document.getElementById('<%= hdnGross.ClientID %>').value;
            var DiscountAmount = document.getElementById('<%= txtDiscount.ClientID  %>').value;
            var GrandTotal = document.getElementById('<%= txtGrandTotal.ClientID  %>');
            var PreviousReceived = document.getElementById('<%= txtPreviousAmountPaid.ClientID %>').value;
            var PreviousDue = document.getElementById('<%= txtPreviousDue.ClientID %>').value;
            var ptempServiceCharge = document.getElementById('<%= hdnPrevServiceCharge.ClientID %>');
            var pTempAmtfromTPA = document.getElementById('<%= txtThirdParty.ClientID %>').value;

            var AdvanceReceivd = document.getElementById('<%= txtRecievedAdvance.ClientID %>').value;

            var RefundAmount = document.getElementById('<%= txtRefundAmount.ClientID %>');
            var TaxAMount = Number(document.getElementById('txtTax').value, 2);
            var RoundOFF = document.getElementById('<%= txtRoundOff.ClientID %>');
            var hdnRoundOff = document.getElementById('<%= hdnRoundOff.ClientID %>');
            var defRoundOff = document.getElementById('<%= hdnDefaultRoundoff.ClientID %>').value;
            var RoundOffType = document.getElementById('<%= hdnRoundOffType.ClientID %>').value;
            var txtPreviousRefund = document.getElementById('<%= txtPreviousRefund.ClientID %>');

            txtPreviousRefund.value = txtPreviousRefund.value == "" ? parseFloat(0).toFixed(2) : parseFloat(txtPreviousRefund.value).toFixed(2);



            PreviousReceived = chkIsnumber(PreviousReceived);
            GrossAmount = chkIsnumber(GrossAmount);
            DiscountAmount = chkIsnumber(DiscountAmount);
            PreviousDue = chkIsnumber(PreviousDue);
            AdvanceReceivd = chkIsnumber(AdvanceReceivd);
            TaxAMount = chkIsnumber(TaxAMount);
            pTempAmtfromTPA = Number(chkIsnumber(pTempAmtfromTPA), 2);


            if ((Number(GrossAmount) - Number(DiscountAmount)) < 0) {
                alert('Discount Cannot be Greater than Gross Amount');
                document.getElementById('<%= txtDiscount.ClientID  %>').value = GrossAmount;
                CorrectTotal();
                totalCalculate();
                doCalcReimburse();
                SetOtherCurrValues();
            }
            else {
                var totGrossAmount = 0;
                var PreviousBillPaid = Number(document.getElementById('hdnUnBilledAdvanceReceived').value);
                //PreviousBillPaid = Number(PreviousBillPaid) < 0 ? 0 : Number(PreviousBillPaid);
                //                if (document.getElementById("chkShowUnbilled").checked && document.getElementById("hdnIsBilledBefore").value=="Y") {
                //                    totGrossAmount = format_number((Number(GrossAmount)
                //                                    + Number(TaxAMount) + Number(PreviousDue) + Number(ptempServiceCharge.value)
                //                                        - (Number(document.getElementById('hdnUnBilledPreviousReceived').value)
                //                                        + Number(DiscountAmount)
                //                                        + (Number(AdvanceReceivd) - Number(txtPreviousRefund.value) - Number(PreviousBillPaid)) + Number(pTempAmtfromTPA))
                //                                       ), 2);
                //                }
                //                else {

                totGrossAmount = format_number((Number(GrossAmount)
                                    + Number(TaxAMount) + Number(PreviousDue) + Number(ptempServiceCharge.value)
                                    - (Number(PreviousReceived)
                                        + Number(DiscountAmount)
                                        + Number(AdvanceReceivd) + Number(pTempAmtfromTPA) - Number(txtPreviousRefund.value))
                                       ), 2);
                //                }
                RoundOFF.value = getCustomRoundoff(totGrossAmount, Number(defRoundOff), RoundOffType);
                hdnRoundOff.value = RoundOFF.value;
                totGrossAmount = format_number((Number(hdnRoundOff.value) + Number(totGrossAmount)), 2);

                if (Number(totGrossAmount) > 0) {
                    GrandTotal.value = format_number(totGrossAmount, 2);
                    RefundAmount.value = 0;
                }
                else {
                    GrandTotal.value = 0;
                    //                    if (document.getElementById("chkShowUnbilled").checked && document.getElementById("hdnIsBilledBefore").value == "Y") {
                    //                        RefundAmount.value = format_number((Number(document.getElementById('hdnUnBilledPreviousReceived').value) + Number(DiscountAmount) + Number(AdvanceReceivd) - Number(txtPreviousRefund.value) - Number(PreviousBillPaid)) - (Number(GrossAmount) + Number(RoundOFF.value) + Number(ptempServiceCharge.value) + Number(TaxAMount) + Number(PreviousDue) + Number(pTempAmtfromTPA)), 2);
                    //                    }
                    //                    else {
                    RefundAmount.value = format_number((Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd) - Number(txtPreviousRefund.value)) - (Number(GrossAmount) + Number(RoundOFF.value) + Number(ptempServiceCharge.value) + Number(TaxAMount) + Number(PreviousDue) + Number(pTempAmtfromTPA)), 2);
                    //                    }
                }
                //RefundAmount
            }
            GetCurrencyValues();
        }
        function AmountRefundCheck() {
            var PreviousReceived = document.getElementById('<%= txtPreviousAmountPaid.ClientID %>').value;
            var AdvanceReceivd = document.getElementById('<%= txtRecievedAdvance.ClientID %>').value;
            var RefundAmount = document.getElementById('<%= txtRefundAmount.ClientID %>').value;
            var txtPreviousRefund = document.getElementById('<%= txtPreviousRefund.ClientID %>');

            txtPreviousRefund.value = txtPreviousRefund.value == "" ? parseFloat(0).toFixed(2) : parseFloat(txtPreviousRefund.value).toFixed(2);

            var totAmount = Number(PreviousReceived) + Number(AdvanceReceivd) - Number(txtPreviousRefund.value);
            if (Number(totAmount) < Number(RefundAmount)) {
                document.getElementById('<%= txtRefundAmount.ClientID %>').value = 0;
                CorrectTotal();
                totalCalculate();
                doCalcReimburse();
                SetOtherCurrValues();
            }
        }

        function AmountRecieved() {
            var grandTotal = document.getElementById('txtGrandTotal').value;
            var amountRecieved = document.getElementById('txtAmountRecieved').value;
        }

        function ChangeFormat() {
            document.getElementById('txtDiscount').value = format_number(document.getElementById('txtDiscount').value, 2);
            document.getElementById('txtAmountRecieved').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            document.getElementById('hdnAmountReceived').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            document.getElementById('txtTax').value = format_number(document.getElementById('txtTax').value, 2);
            var gross = document.getElementById('txtGross').value;
            var discount = document.getElementById('txtDiscount').value;
            if ((Number(gross)) < (Number(discount))) {
                document.getElementById('txtDiscount').value = "0.0";
                totalCalculate();
                doCalcReimburse();
                SetOtherCurrValues();
                // document.getElementById('txtGrandTotal').value = document.getElementById('txtGross').value - document.getElementById('txtRecievedAdvance').value;
                alert('Discount Amount is greater than Gross value');
            }
        }
        function checkIsCredit() {

            if (document.getElementById('chkisCreditTransaction').checked == true) {
                if (!document.getElementById('txtAmountRecieved').value > 0) {
                    document.getElementById('txtAmountRecieved').value = '0.00';
                    document.getElementById('hdnAmountReceived').value = '0.00';
                }
                document.getElementById('txtAmountRecieved').disabled = true;

            }
        }

        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
        
        
            //            var sVal = document.getElementById('txtAmountRecieved').value;
            //            var sNetValue = document.getElementById('txtGrandTotal').value;
            //            var tempService = document.getElementById('txtServiceCharge').value;

            //            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);

            //            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 2);
            //            sVal = format_number(Number(sVal) + Number(TotalAmount), 2);


            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 4);


            if (Number(sVal) < Number(sNetValue)) {
                alert('Amount recieved is lesser than current total. Remaining Amount will be calculate as Due');

            }

            if (Number(sNetValue) >= Number(sVal)) {
                //                sVal = format_number(sVal, 2);

                sVal = format_number(sVal, 2);
                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                var pScrAmt = Number(pScr) * Number(CurrRate);
                var pAmt = Number(sVal) * Number(CurrRate);

                document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
                //alert(hdnSer<a href="PrintDischargeChkList.aspx">PrintDischargeChkList.aspx</a>viceCharge);
                document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2)
                document.getElementById('txtAmountRecieved').value = pAmt;
                document.getElementById('hdnAmountReceived').value = pAmt;
                var pTotal = Number(Number(sNetValue)) * Number(CurrRate);
                document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);

//                if (document.getElementById('chkisCreditTransaction').checked == true) {
//               
//                doCalcReimburse();
//                }

                return true;
            }
            else {
                alert("Amount Entered is greater than Net Amount");
                return false;

            }
        }


        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            //            var sVal = document.getElementById('txtAmountRecieved').value;
            //            sVal = format_number(Number(sVal) - Number(TotalAmount), 2);
            //            var tempService = document.getElementById('txtServiceCharge').value;
            //            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);


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
            document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2);

            document.getElementById('txtAmountRecieved').value = format_number(sVal, 2);
            document.getElementById('hdnAmountReceived').value = format_number(sVal, 2);

            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);



            //            var sNetValue = document.getElementById('txtGrandTotal').value;

            //document.getElementById('txtGrandTotal').value = format_number(Number(sNetValue) - Number(ServiceCharge), 2);
            document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);


             if (document.getElementById('chkisCreditTransaction').checked == true) {
            doCalcReimburse();
                   }
        }

        function chkCreditPament() {
            document.getElementById('chkisCreditTransaction').checked = false;
        }
        function calcDays(lblFrom, txtTo, txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                            hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                            txtRecievedAdvance, txtGrandTotal, hdnGross, isVariable, txtIndvDiscount, hdnDiscountArray, roomtype,
                             hdnNonMedical
                                                  , lblNonReimbuse
                                                  , hdnMedical
                                                  , lblReimburse
                                                  , chkIsReImbursableItem, Flag) {
            var date;
            var hdn = document.getElementById('hdnfrm').value.replace(" ", "-");
            var Date1 = document.getElementById(lblFrom).value.replace(" ", "-");
            var Date2 = document.getElementById(txtTo).value.replace("-", "/").replace("-", "/").replace(" ", "-");
            document.getElementById(txtTo).value = document.getElementById(txtTo).value.replace("-", "/").replace("-", "/");

            var datediff = 0;
            var count = 0;
            count = dateDiff3(Date1, hdn);

            //            if (count > 1) {
            //                Date1 = hdn;
            //                document.getElementById(lblFrom).value = hdn;
            //            }
            if (isVariable == "Y") {
                datediff = dateDiff2(Date1, Date2);
            }
            else {
                datediff = dateDiff3(Date1, Date2);
            }

            if (datediff > 0) {
                document.getElementById(txtQuantity).value = datediff;
            }
            else {
                //document.getElementById(txtQuantity).value = 1;
                document.getElementById(txtTo).value = document.getElementById(lblFrom).value;
                //var date = Date(document.getElementById(txtTo)).getDate();
                //                var date = new Date();
                //                date = Date(document.getElementById(txtTo).value);
                //                document.getElementById(lblFrom).value =
                //                //date.setDate(date.getdate()+1);
                //                var getdat = date.getDate();
                //                alert(getdat);
            }

            CalcItemCost(txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                                hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                                txtRecievedAdvance, txtGrandTotal, hdnGross, txtIndvDiscount, hdnDiscountArray,
                                hdnNonMedical
                                , lblNonReimbuse
                                , hdnMedical
                                , lblReimburse
                                , chkIsReImbursableItem, Flag);
            changefrmdate(document.getElementById(lblFrom).value, document.getElementById(txtQuantity).value, document.getElementById(txtTo).value, roomtype);

        }
        function checkOptional(lblFrom, txtTo, txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                            hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                            txtRecievedAdvance, txtGrandTotal, hdnGross, isVariable, chkboxID, txtIndvDiscount, hdnDiscountArray,
                            hdnNonMedical
                                , lblNonReimbuse
                                , hdnMedical
                                , lblReimburse
                                , chkIsReImbursableItem, Flag) {

            var chkbox = document.getElementById(chkboxID);
            if (chkbox.checked) {
                calcDays(lblFrom, txtTo, txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                                             hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                                          txtRecievedAdvance, txtGrandTotal, hdnGross, isVariable);
            }
            else {
                document.getElementById(txtQuantity).value = 0;
            }
            CalcItemCost(txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                            hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                            txtRecievedAdvance, txtGrandTotal, hdnGross, txtIndvDiscount, hdnDiscountArray,
                            hdnNonMedical
                                , lblNonReimbuse
                                , hdnMedical
                                , lblReimburse
                                , chkIsReImbursableItem, Flag);
        }

        function dateDiff2(startDate, endDate) {
            var sstartdate = new Date(startDate.split('/')[1] + '/' + startDate.split('/')[0] + '/' + startDate.split('/')[2].split('-')[0] + ' ' + startDate.split('-')[1]);
            var sEndDate = new Date(endDate.split('/')[1] + '/' + endDate.split('/')[0] + '/' + endDate.split('/')[2].split('-')[0] + ' ' + endDate.split('/')[2].split('-')[1]);
            var one_day = 1000 * 60 * 60 * 24;

            var obtainedVal = ((sEndDate.getTime() - sstartdate.getTime()) / (one_day));
            var result = (Math.ceil(Number(obtainedVal) / 0.5)) * 0.5;
            return result;
        }

        function dateDiff3(startDate, endDate) {
            var sstartdate = new Date(startDate.split('/')[1] + '/' + startDate.split('/')[0] + '/' + startDate.split('/')[2].split('-')[0] + ' ' + startDate.split('-')[1]);
            var sEndDate = new Date(endDate.split('/')[1] + '/' + endDate.split('/')[0] + '/' + endDate.split('/')[2].split('-')[0] + ' ' + endDate.split('/')[2].split('-')[1]);
            var one_day = 1000 * 60 * 60 * 24;
            return Math.ceil((sEndDate.getTime() - sstartdate.getTime()) / (one_day));
        }
        var count = 0;
        function CalcTax() {
            count = 1;
            var sVal = Number(document.getElementById('txtTax').value);
            var sGrand = format_number(Number(document.getElementById('txtGross').value) -
                                                    (Number(document.getElementById('txtDiscount').value)), 2);
            document.getElementById('txtTax').value = format_number(sVal, 2);
            document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);
            var manualTaxPer = format_number(Number(document.getElementById('txtTax').value) / sGrand * 100, 2);
            document.getElementById('hdnManualTaxPercentage').value = format_number(manualTaxPer, 2);
            totalCalculate();
            SetOtherCurrValues();
        }

        function chkTaxPayment(idval, dPercent) {
            if (count == 1) {
                document.getElementById('txtTax').value = 0;
                document.getElementById('hdnManualTaxPercentage').value = 0;
            }

            var sVal = Number(document.getElementById('txtTax').value);
            var sGrand = format_number(Number(document.getElementById('txtGross').value) -
                                                    (Number(document.getElementById('txtDiscount').value)), 2);

            var sControl = document.getElementById(idval);
            var arrayAlready = new Array();
            var iCount = 0;
            var tSelectedData = "";

            if (sControl.checked == true) {
                sVal = sVal + (Number(sGrand) * Number(dPercent) / 100);

                document.getElementById('hdfTax').value += ">" + idval + "~" + dPercent;
                document.getElementById('txtTax').value = format_number(sVal, 2);
                document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);

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
            }
            document.getElementById('txtTax').value = format_number(sVal, 2);
            document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);

            totalCalculate();
            SetOtherCurrValues();

            count = 0;
        }

        function CorrectTotal() {
            var SelectedVal = document.getElementById('hdfTax').value;
            document.getElementById('hdfTax').value = "";
            //           document.getElementById('txtTax').value = "0.00";
            var iDC = 0;
            var tpData = "";
            var spData = "";
            var arrayPresent = new Array();
            if (SelectedVal != "") {
                arrayPresent = SelectedVal.split('>');
                for (iDC = 0; iDC < arrayPresent.length; iDC++) {
                    tpData = arrayPresent[iDC];
                    if (tpData != "") {
                        chkTaxPayment(tpData.split('~')[0], tpData.split('~')[1]);
                    }
                }
            }
        }
        function changefrmdate(obj, value, Todate, roomtype) {
            var hdn = document.getElementById('hdn').value;
            if (hdn != "") {
                var list = hdn.split('^');
                //alert(list);
                for (var i = 0; i <= list.length - 1; i++) {
                    if (list[i] != "") {
                        //alert(list[i]);
                        var val = list[i].split('~');
                        if (roomtype == val[5]) {
                            document.getElementById(val[0]).value = obj;
                            document.getElementById(val[1]).value = value;
                            document.getElementById(val[4]).value = Todate;
                            document.getElementById(val[3]).value = (Number(document.getElementById(val[2]).value) * Number(value));
                        }
                    }
                }
            }
        }
        function ValidateDiscountReason() {
            if (document.getElementById('txtDiscount').value > 0) {
                document.getElementById('trDiscountReason').style.display = "block";
                //                document.getElementById('txtDiscountReason').focus();
            }
            else {
                document.getElementById('trDiscountReason').style.display = "none";
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
            }
            return false;
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
    </script>

    <script language="javascript" type="text/javascript">

        function doCalcNonReimbursable(txtAmount, hdnAmount, hdnNonMedicalItem, lblNonReimbuse, hdnMedical, lblReimburse, nonReimburseChkBoxID) {
            //            if (document.getElementById('chkisCreditTransaction').checked == true) {
            var txtGridAmount = document.getElementById(txtAmount);
            var gridChkBox = document.getElementById(nonReimburseChkBoxID);
            var hdnNonMedical = document.getElementById(hdnNonMedicalItem);
            var lblNonMedical = document.getElementById(lblNonReimbuse);

            var hdnMedical = document.getElementById(hdnMedical);
            var lblMedical = document.getElementById(lblReimburse);

            var NonMedical = Number(hdnNonMedical.value);
            var Medical = Number(hdnMedical.value);

            var txtNonMedical = document.getElementById('<%= txtNonMedical.ClientID %>');
            var txtAmountRecieved = document.getElementById('<%= txtAmountRecieved.ClientID %>');
            var txtPreviousDue = document.getElementById('<%= txtPreviousDue.ClientID %>');
            var txtServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>');

            //var Additional = Number(txtPreviousDue.value) + Number(txtServiceCharge.value);
            //NonMedical += Number(txtServiceCharge.value);

            if (gridChkBox.checked) {

                NonMedical -= Number(txtGridAmount.value);
                hdnNonMedical.value = NonMedical;
                lblNonMedical.innerHTML = parseFloat(Number(lblNonMedical.innerHTML) - Number(txtGridAmount.value)).toFixed(2);
                hdnNonMedical.value = parseFloat(lblNonMedical.innerHTML).toFixed(2);
                if (Number(txtGridAmount.value) < Number(txtNonMedical.value)) {
                    if (Number(txtAmountRecieved.value) < NonMedical) {
                        txtNonMedical.value = Number(txtNonMedical.value) - Number(txtGridAmount.value);
                    }
                    else {
                        txtNonMedical.value = Number(NonMedical).toFixed(2);
                    }
                } else {
                    txtNonMedical.value = Number(0).toFixed(2);
                }
                Medical += Number(txtGridAmount.value);
                hdnMedical.value = Medical;
                lblMedical.innerHTML = parseFloat(Number(lblMedical.innerHTML) + Number(txtGridAmount.value)).toFixed(2);
                hdnMedical.value = parseFloat(lblMedical.innerHTML).toFixed(2);

            } else {

                NonMedical += Number(txtGridAmount.value);
                hdnNonMedical.value = NonMedical;
                lblNonMedical.innerHTML = parseFloat(Number(lblNonMedical.innerHTML) + Number(txtGridAmount.value)).toFixed(2);
                hdnNonMedical.value = parseFloat(lblNonMedical.innerHTML).toFixed(2);

                if (Number(txtAmountRecieved.value) > (Number(txtNonMedical.value) + Number(txtGridAmount.value))) {

                    txtNonMedical.value = Number(txtNonMedical.value) + Number(txtGridAmount.value);

                }
                else {
                    txtNonMedical.value = Number(txtAmountRecieved.value).toFixed(2);
                }

                Medical -= Number(txtGridAmount.value);
                hdnMedical.value = Medical;
                lblMedical.innerHTML = parseFloat(Number(lblMedical.innerHTML) - Number(txtGridAmount.value)).toFixed(2);
                hdnMedical.value = parseFloat(lblMedical.innerHTML).toFixed(2);
            }
            //            }
            doCalcReimburse();
        }

        function calcCopercent() {
            var txtCopercent = document.getElementById('txtCopercent');
            //            var lblPreAuthAmount = document.getElementById('lblPreAuthAmount').innerHTML;
            var hdnMedical = document.getElementById('<%= hdnMedical.ClientID %>');
            var lblPreAuthAmount = hdnMedical.value;
            var hdnCoPayment = document.getElementById("hdnCoPayment");
            var txtExcess = document.getElementById("txtExcess");
            var txtCoPayment = document.getElementById("txtCoPayment");
            if (!isNaN(txtCopercent.value) && txtCopercent.value.trim() != "" && Number(txtCopercent.value) > 0 && (Number(txtCoPayment.value) + Number(txtExcess.value)) > 0 && lblPreAuthAmount.trim() != "" && Number(lblPreAuthAmount) > 0) {

                var sum = Number(txtExcess.value) + Number(txtCoPayment.value);
                var coPercentAmt = (Number(lblPreAuthAmount) * Number(txtCopercent.value)) / 100;
                if (Number(coPercentAmt) >= Number(sum)) {
                    hdnCoPayment.value = txtCoPayment.value = parseFloat(sum).toFixed(2);
                    txtExcess.value = parseFloat(0).toFixed(2);
                } else {
                    hdnCoPayment.value = txtCoPayment.value = parseFloat(coPercentAmt).toFixed(2);
                    txtExcess.value = parseFloat(Number(sum) - Number(coPercentAmt)).toFixed(2);
                }
            }
        }

        function doCalcReimburse() {

            var hdnNonMedical = document.getElementById('<%= hdnNonMedical.ClientID %>');
            var txtPreviousDue = document.getElementById('<%= txtPreviousDue.ClientID %>');
            var txtServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>');
            var txtGrandTotal = document.getElementById('<%= txtGrandTotal.ClientID%>');

            var txtAmountRecieved = document.getElementById('<%= txtAmountRecieved.ClientID %>');
            var txtPreviousAmountPaid = document.getElementById('<%= txtPreviousAmountPaid.ClientID%>');
            var txtRecievedAdvance = document.getElementById('<%= txtRecievedAdvance.ClientID%>');
            var txtRefundAmount = document.getElementById('<%= txtRefundAmount.ClientID %>');
            var txtThirdParty = document.getElementById('<%= txtThirdParty.ClientID %>');
            var txtPreviousRefund = document.getElementById('<%= txtPreviousRefund.ClientID %>');

            var txtNonMedical = document.getElementById('<%= txtNonMedical.ClientID %>');
            var txtCoPayment = document.getElementById('<%= txtCoPayment.ClientID %>');
            var txtExcess = document.getElementById('<%= txtExcess.ClientID %>');

            var lblPreAuthAmount = document.getElementById('<%= lblPreAuthAmount.ClientID%>');
            //            var pPreAuthAmount = lblPreAuthAmount.innerHTML;
            var hdnMedical = document.getElementById('<%= hdnMedical.ClientID %>');


            hdnNonMedical.value = Number(document.getElementById('<%= lblNonReimbuse.ClientID%>').innerHTML);


            var prevServiceChg = document.getElementById('<%= hdnPrevServiceCharge.ClientID %>');

            var pPreAuthAmount = Number(hdnMedical.value) + Number(txtServiceCharge.value) + Number(prevServiceChg.value);

            var NonReimburseAmt = Number(hdnNonMedical.value) + Number(txtPreviousDue.value);

            var AmtRecd = Number(txtAmountRecieved.value) + (Number(txtPreviousAmountPaid.value) + Number(txtRecievedAdvance.value)) - Number(txtPreviousRefund.value) - Number(txtRefundAmount.value);

            var TpaPaidAmt = Number(txtThirdParty.value);

            pPreAuthAmount = TpaPaidAmt > 0 ? pPreAuthAmount - TpaPaidAmt : pPreAuthAmount;

            if (NonReimburseAmt > 0 && NonReimburseAmt < AmtRecd) {
                txtNonMedical.value = parseFloat(NonReimburseAmt).toFixed(2);
                txtCoPayment.value = parseFloat(AmtRecd - NonReimburseAmt).toFixed(2);

                if (Number(txtCoPayment.value) > Number(pPreAuthAmount)) {
                    txtExcess.value = parseFloat(Number(txtCoPayment.value) - Number(pPreAuthAmount)).toFixed(2);
                    txtCoPayment.value = Number(pPreAuthAmount).toFixed(2);
                } else {
                    txtExcess.value = (0).toFixed(2);
                }

            } else if (NonReimburseAmt > 0 && NonReimburseAmt > AmtRecd) {

                txtNonMedical.value = parseFloat(AmtRecd).toFixed(2);
                txtCoPayment.value = (0).toFixed(2);
                txtExcess.value = (0).toFixed(2);

            } else if (NonReimburseAmt == 0) {

                txtCoPayment.value = parseFloat(AmtRecd).toFixed(2);

                if (Number(txtCoPayment.value) > Number(pPreAuthAmount)) {
                    txtExcess.value = parseFloat(Number(txtCoPayment.value) - Number(pPreAuthAmount)).toFixed(2);
                    txtCoPayment.value = Number(pPreAuthAmount).toFixed(2);
                } else {
                    txtExcess.value = (0).toFixed(2);
                }
            }

            var CoPay = Number(txtCoPayment.value);
            var Excess = Number(txtExcess.value);
            var NonMedical = Number(txtNonMedical.value);
            var NetBill = Number(txtGrandTotal.value);

            calcCopercent();
            // hdnNonMedical.value = NonMedical;
            document.getElementById('<%= hdnCoPaymentFinal.ClientID %>').value = Number(txtCoPayment.value);
            document.getElementById('<%= hdnExcess.ClientID %>').value = Number(txtExcess.value);
            //(CoPay + Excess) shud not exceed "AmtRecd"
            //            pPreAuthAmount -= TpaPaidAmt;
            //            var diff = (CoPay + Excess + TpaPaidAmt) > pPreAuthAmount ? (CoPay + Excess + TpaPaidAmt) - pPreAuthAmount : 0;
            //            if ((CoPay + Excess + TpaPaidAmt) < Number(pPreAuthAmount)) {

            //                txtCoPayment.value = parseFloat(CoPay + Excess).toFixed(2);
            //                txtExcess.value = (0).toFixed(2);
            //                    
            //            } else {
            //                txtExcess.value = parseFloat((CoPay + Excess) - Number(pPreAuthAmount)).toFixed(2);
            //                txtCoPayment.value = parseFloat(pPreAuthAmount).toFixed(2);
            //            }

        }


    </script>

    <asp:ScriptManager ID="scrpt" runat="server">
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
                <td width="15%" valign="top" id="menu" style="display: None;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                            </li>
                        </ul>
                        <%--<asp:UpdatePanel ID="upBillItems" runat="server">
                            <ContentTemplate>--%>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <%-- <td colspan="3">
                                    <asp:Panel ID="trABI" runat="server" CssClass="defaultfontcolor">
                                        <table border="0" cellpadding="0" cellspacing="0" width="40%">
                                            <tr>
                                                <td colspan="2" class="colorforcontent" height="25px" align="left">
                                                    <div style="display: block;" id="ACX2plusMVitals">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);">
                                                            More Payments</span>
                                                    </div>
                                                    <div style="display: none; height: 18px;" id="ACX2minusMVitals">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);">
                                                            More Payments</span>
                                                    </div>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr id="ACX2responsesMVitals" style="display: none;" class="tablerow">
                                                <td colspan="3" style="width: 50%; padding: 0px;">
                                                    <div>
                                                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="90%">
                                                            <tr>
                                                                <td>
                                                                    Description
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtDesc" runat="server" MaxLength="45" TabIndex="11"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    Amount
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAmt" runat="server" MaxLength="10"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                        TabIndex="12" Width="100px"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnAddAmt" runat="server" CssClass="btn" OnClientClick="return ValidateOTH();"
                                                                        OnClick="btnAddAmt_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                        TabIndex="13" Text="Add" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>--%>
                                <td class="dataheaderInvCtrl" width="100%">
                                    <table>
                                        <tr>
                                            <td align="center" width="40%" class="style1">
                                                <label>
                                                   <asp:Label ID="Rs_Miscellaneous" Text="Miscellaneous"   runat="server" 
                                                    meta:resourcekey="Rs_MiscellaneousResource1"></asp:Label>&nbsp;<asp:Label 
                                                    ID="Rs_Amount" Text="Amount" runat="server" 
                                                    meta:resourcekey="Rs_AmountResource1"></asp:Label></label>
                                            </td>
                                            <td align="right" width="30%" class="style1">
                                                <input id="btnAdd" type="button" class="dataheader1" style="width: 100px;" value="Add"
                                                    onclick="showModalPopup(event);" />
                                            </td>
                                            <td width="30%" align="right" class="style1">
                                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                    OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"><asp:Label 
                                                    ID="Rs_Back" Text="Back" runat="server" meta:resourcekey="Rs_BackResource1"></asp:Label>


&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="right">
                                    <asp:CheckBox ID="chkShowUnbilled" Text="Show Only unbilled items" AutoPostBack="True"
                                        runat="server" OnCheckedChanged="chkShowUnbilled_CheckedChanged" 
                                        meta:resourcekey="chkShowUnbilledResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trRoomCharges" runat="server" style="display: none;">
                                <td colspan="3" align="left" style="height: 20px;">
                                    <b><asp:Label ID="Rs_Miscellaneous1" Text="Miscellaneous" runat="server" 
                                        meta:resourcekey="Rs_Miscellaneous1Resource1"></asp:Label></b>
                                    <asp:HiddenField ID="hdn" runat="server" />
                                    <asp:HiddenField ID="hdnfrm" runat="server" />
                                    <asp:HiddenField ID="hdnroomtype" runat="server" />
                                </td>
                            </tr>
                            <tr class="dataheaderInvCtrl">
                                <td colspan="3" align="center">
                                    <asp:GridView ID="gvIndentRoomType" runat="server" GridLines="None" AutoGenerateColumns="False"
                                        OnRowDataBound="gvIndentRoomType_RowDataBound" Width="100%" 
                                        OnRowCommand="gvIndentRoomType_RowCommand" 
                                        meta:resourcekey="gvIndentRoomTypeResource1">
                                        <Columns>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource9">
                                                <ItemTemplate>
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td align="left" style="height: 25px;">
                                                                <b>
                                                                    <%# DataBinder.Eval(Container.DataItem, "RoomTypeName")%></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvIndentRoomDetails" runat="server" AutoGenerateColumns="False"
                                                                    OnRowDataBound="gvIndents_RowDataBound" Width="100%" 
                                                                    meta:resourcekey="gvIndentRoomDetailsResource1">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerStyle CssClass="dataheader1" />
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="ID" DataField="DetailsID" 
                                                                            meta:resourcekey="BoundFieldResource1" />
                                                                        <asp:BoundField HeaderText="FeeType" DataField="FeeType" 
                                                                            meta:resourcekey="BoundFieldResource2" />
                                                                        <asp:BoundField HeaderText="FeeID" DataField="FeeID" 
                                                                            meta:resourcekey="BoundFieldResource3" />
                                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkID" runat="server" Checked="True" Enabled="False" 
                                                                                    meta:resourcekey="chkIDResource1" />
                                                                                <asp:Label ID="lblDescrip" runat="server" Text='<%# Eval("Description") %>' 
                                                                                    meta:resourcekey="lblDescripResource1"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="From" meta:resourcekey="TemplateFieldResource2">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblFrom" runat="server" Text='<%# Eval("FromDate","{0:dd/MM/yyyy hh:mm tt}") %>'
                                                                                    Visible="False" meta:resourcekey="lblFromResource1" />
                                                                                <asp:TextBox ID="txtFrom" runat="server" Text='<%# Eval("FromDate","{0:dd/MM/yyyy hh:mm tt}") %>'
                                                                                    Width="130px" meta:resourcekey="txtFromResource1" />
                                                                                <a runat="server" id="ahrImgBtnfrm">
                                                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                                <asp:ImageButton ID="ImgBntCalcFrm" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                    CausesValidation="False" Style="display: none;" 
                                                                                    meta:resourcekey="ImgBntCalcFrmResource1" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="To" meta:resourcekey="TemplateFieldResource3">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblTo" runat="server" Text='<%# Eval("ToDate","{0:dd/MM/yyyy hh:mm tt}") %>'
                                                                                    Visible="False" meta:resourcekey="lblToResource1" />
                                                                                <asp:Label ID="Comments" runat="server" Text='<%# Eval("Comments") %>' 
                                                                                    Visible="False" meta:resourcekey="CommentsResource1"></asp:Label>
                                                                                <asp:TextBox ID="txtTo" runat="server" Text='<%# Eval("ToDate","{0:dd/MM/yyyy hh:mm tt}") %>'
                                                                                    Width="130px" meta:resourcekey="txtToResource1" />
                                                                                <a runat="server" id="ahrImgBtn">
                                                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                                <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                    CausesValidation="False" Style="display: none;" 
                                                                                    meta:resourcekey="ImgBntCalcResource1" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="UnitPrice" 
                                                                            meta:resourcekey="TemplateFieldResource4">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblComments" runat="server" Text='~' Style="display: none;" 
                                                                                    meta:resourcekey="lblCommentsResource1" />
                                                                                <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                                    Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                    Width="60px" meta:resourcekey="txtUnitPriceResource1"></asp:TextBox>
                                                                                <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' 
                                                                                    runat="server" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Quantity" 
                                                                            meta:resourcekey="TemplateFieldResource5">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                                    Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                    Width="30px" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                                                <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' 
                                                                                    runat="server" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Amount" 
                                                                            meta:resourcekey="TemplateFieldResource6">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                                                    Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" 
                                                                                    meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                                                <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Status" HeaderText="Status" 
                                                                            meta:resourcekey="BoundFieldResource4" />
                                                                        <asp:BoundField DataField="FromTable" HeaderText="From Table" 
                                                                            meta:resourcekey="BoundFieldResource5" />
                                                                        <asp:TemplateField HeaderText="Discount" 
                                                                            meta:resourcekey="TemplateFieldResource7">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtDiscount" runat="server" Style="text-align: right;" Text='<%# Eval("DiscountAmount") %>'
                                                                                      onkeypress="return ValidateOnlyNumeric(this);"   Width="60px" 
                                                                                    meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Is ReImbursable" 
                                                                            meta:resourcekey="TemplateFieldResource8">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" 
                                                                                    meta:resourcekey="chkIsReImbursableItemResource1" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="left" style="height: 35px;">
                                    <div id="dvTreatmentCharges" runat="server">
                                        <b><asp:Label ID="Rs_TreatmentCharges" Text="Treatment Charges" runat="server" 
                                            meta:resourcekey="Rs_TreatmentChargesResource1"></asp:Label></b>
                                    </div>
                                </td>
                            </tr>
                            <tr class="dataheaderInvCtrl">
                                <td colspan="3" align="center">
                                    <asp:GridView ID="gvIndents" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvIndents1_RowDataBound"
                                        Width="100%" meta:resourcekey="gvIndentsResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <PagerStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" 
                                                meta:resourcekey="BoundFieldResource6" />
                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" 
                                                meta:resourcekey="BoundFieldResource7" />
                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" 
                                                meta:resourcekey="BoundFieldResource8" />
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource10">
                                                <ItemTemplate>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField HeaderText="Description" DataField="Description" >
                                           
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="Description" 
                                                meta:resourcekey="TemplateFieldResource11">
                                                <ItemTemplate>
                                                    <asp:Label ID="chkID" runat="server" Style="text-align: left;" 
                                                        Text='<%# Eval("Description") %>' meta:resourcekey="chkIDResource2" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Service Code" 
                                                meta:resourcekey="TemplateFieldResource12">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtServiceCode" runat="server" Style="text-align: right;" Text='<%# Eval("ServiceCode") %>'
                                                        Width="60px" meta:resourcekey="txtServiceCodeResource1"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Comments" 
                                                meta:resourcekey="TemplateFieldResource13">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblComments" runat="server" Text='<%# Eval("Comments") %>' 
                                                        meta:resourcekey="lblCommentsResource2" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField HeaderText="Comments" DataField="Comments" />--%>
                                            <asp:BoundField HeaderText="From Date" DataField="FromDate" 
                                                DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                meta:resourcekey="BoundFieldResource9">
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField HeaderText="To" DataField="ToDate" 
                                                DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                meta:resourcekey="BoundFieldResource10">
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Unit Price" 
                                                meta:resourcekey="TemplateFieldResource14">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                        Text='<%# Eval("AMOUNT") %>'    onkeypress="return ValidateOnlyNumeric(this);"  
                                                        Width="60px" meta:resourcekey="txtUnitPriceResource2"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' 
                                                        runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Quantity" 
                                                meta:resourcekey="TemplateFieldResource15">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                        Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   
                                                        Width="40px" meta:resourcekey="txtQuantityResource2"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' 
                                                        runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" 
                                                meta:resourcekey="TemplateFieldResource16">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                        Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" 
                                                        meta:resourcekey="txtAmountResource2"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                </ItemTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Status" HeaderText="Status" 
                                                meta:resourcekey="BoundFieldResource11" />
                                            <asp:BoundField DataField="FromTable" HeaderText="From Table" 
                                                meta:resourcekey="BoundFieldResource12" />
                                            <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Right" 
                                                meta:resourcekey="TemplateFieldResource17">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDiscount" runat="server" Style="text-align: right;" Text='<%# Eval("DiscountAmount") %>'
                                                           onkeypress="return ValidateOnlyNumeric(this);"    Width="60px" 
                                                        meta:resourcekey="txtDiscountResource2"></asp:TextBox>
                                                </ItemTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="true" Visible="true" 
                                                HeaderText="Is ReImbursable" meta:resourcekey="TemplateFieldResource18">
                                                <ItemTemplate>
                                                    <asp:CheckBox  ID="chkIsReImbursableItem" runat="server" Checked="True" 
                                                        meta:resourcekey="chkIsReImbursableItemResource2"  />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Comments" Visible="false" 
                                                meta:resourcekey="TemplateFieldResource19">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCommentsgvI" runat="server" Text='<%# Eval("Status") %>' 
                                                        meta:resourcekey="lblCommentsgvIResource1" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="left" style="height: 35px;">
                                    <div id="dvpharmacy" runat="server">
                                        <asp:Label ID="Rs_Pharmacy" Text="Pharmacy" runat="server" 
                                            meta:resourcekey="Rs_PharmacyResource1"></asp:Label></div>
                                </td>
                            </tr>
                            <tr class="dataheaderInvCtrl">
                                <td colspan="3" align="center">
                                    <asp:GridView ID="gvMedicalItems" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvPharmacy_RowDataBound"
                                        Width="100%" meta:resourcekey="gvMedicalItemsResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <PagerStyle CssClass="dataheader1" />
                                        <RowStyle HorizontalAlign="Left" />
                                        <Columns>
                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" 
                                                meta:resourcekey="BoundFieldResource13" />
                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" 
                                                meta:resourcekey="BoundFieldResource14" />
                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" 
                                                meta:resourcekey="BoundFieldResource15" />
                                            <asp:BoundField HeaderText="Description" DataField="Description" 
                                                meta:resourcekey="BoundFieldResource16" />
                                            <asp:BoundField HeaderText="Batch No" DataField="BatchNo" 
                                                meta:resourcekey="BoundFieldResource17" />
                                            <asp:BoundField HeaderText="Expiry Date" DataFormatString="{0:MMM/yyyy }" 
                                                DataField="ExpiryDate" meta:resourcekey="BoundFieldResource18" />
                                            <asp:BoundField HeaderText="Date" DataField="FromDate" 
                                                meta:resourcekey="BoundFieldResource19" />
                                            <asp:TemplateField HeaderText="Unit Price" 
                                                meta:resourcekey="TemplateFieldResource20">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblComments" Visible="False" runat="server" 
                                                        meta:resourcekey="lblCommentsResource3" />
                                                    <asp:HiddenField runat="server" ID="hdnphyDate" 
                                                        Value='<%# bind("FromDate") %>' />
                                                    <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                        Text='<%# Eval("AMOUNT") %>'    onkeypress="return ValidateOnlyNumeric(this);"  
                                                        Width="60px" meta:resourcekey="txtUnitPriceResource3"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' 
                                                        runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Quantity" 
                                                meta:resourcekey="TemplateFieldResource21">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                        Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                        Width="40px" meta:resourcekey="txtQuantityResource3"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' 
                                                        runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" 
                                                meta:resourcekey="TemplateFieldResource22">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                        Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" 
                                                        meta:resourcekey="txtAmountResource3"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                </ItemTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Status" HeaderText="Status" 
                                                meta:resourcekey="BoundFieldResource20" />
                                            <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Right" 
                                                meta:resourcekey="TemplateFieldResource23">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDiscount" runat="server" Style="text-align: right;" Text='<%# Eval("DiscountAmount") %>'
                                                          onkeypress="return ValidateOnlyNumeric(this);"   Width="60px" 
                                                        meta:resourcekey="txtDiscountResource3"></asp:TextBox>
                                                </ItemTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="IsReImbursable" 
                                                meta:resourcekey="TemplateFieldResource24">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" 
                                                        meta:resourcekey="chkIsReImbursableItemResource3" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Comments" Visible="false" 
                                                meta:resourcekey="TemplateFieldResource25">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCommentsgvMI" runat="server" Text='<%# Eval("Status") %>' 
                                                        meta:resourcekey="lblCommentsgvMIResource1" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="FromTable" HeaderText="From Table" 
                                                meta:resourcekey="BoundFieldResource21" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top: 10px;">
                                    <table cellpadding="3" cellspacing="0" border="0" class="dataheaderInvCtrl" width="100%">
                                        <tr>
                                            <td class="style2">
                                                <b><asp:Label ID="Rs_NonReImbursableItems" Text="Non-ReImbursable Items" 
                                                    runat="server" meta:resourcekey="Rs_NonReImbursableItemsResource1"></asp:Label></b>
                                            </td>
                                            <td class="style2">
                                                <b>
                                                    <asp:Label ID="lblNonReimbuse" runat="server" Text="0.00" 
                                                    meta:resourcekey="lblNonReimbuseResource1"></asp:Label></b>
                                            </td>
                                            <%-- <td width="22%">
                                                &nbsp;
                                            </td>--%>
                                            <td width="50%" align="right" class="style2">
                                                <asp:Label ID="lblGross" runat="server" Text="Gross Bill Amount" 
                                                    class="defaultfontcolor" meta:resourcekey="lblGrossResource1" />&nbsp;<span
                                                    style="color: Red;"><asp:Label ID="Rs_X" Text="(X)" runat="server" 
                                                    meta:resourcekey="Rs_XResource1"></asp:Label></span>
                                            </td>
                                            <td width="20%" align="right" class="style2">
                                                <asp:HiddenField ID="hdnGross" runat="server" />
                                                <asp:TextBox ID="txtGross" runat="server" Text="0.00" TabIndex="1" CssClass="Txtboxsmall"
                                                    Enabled="False" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                                <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <b><asp:Label ID="Rs_MedicalItems" Text="MedicalItems" runat="server" 
                                                    meta:resourcekey="Rs_MedicalItemsResource1"></asp:Label></b>
                                            </td>
                                            <td>
                                                <b>
                                                    <asp:Label ID="lblReimburse" runat="server" Text="0.00" 
                                                    meta:resourcekey="lblReimburseResource1"></asp:Label></b>
                                            </td>
                                            <td align="right">
                                                <%--<asp:DropDownList ID="ddlCorporate" onchange="javascript:calculateDiscountForCorporate();" runat="server">
                                                                </asp:DropDownList>--%>
                                                <table>
                                                    <tr>
                                                        <td align="right" valign="top" class="style3">
                                                            &nbsp;
                                                            <label id="tdDiscountLabel" runat="server">
                                                                <asp:Label ID="Rs_SelecttheDiscount" Text="Select the Discount" 
                                                                runat="server" meta:resourcekey="Rs_SelecttheDiscountResource1"></asp:Label></label>
                                                        </td>
                                                        <td align="left" valign="top" class="style3">
                                                            &nbsp;<asp:DropDownList ID="ddDiscountPercent" ToolTip="Select the Discount" onChange="javascript:setDiscount();"
                                                                runat="server" meta:resourcekey="ddDiscountPercentResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="right" class="style3">
                                                            <asp:Label ID="lblDiscount" runat="server" Text="Discount" 
                                                                class="defaultfontcolor" meta:resourcekey="lblDiscountResource1" />&nbsp;<span
                                                                style="color: Red;"><asp:Label ID="Rs_A" Text="(A)" runat="server" 
                                                                meta:resourcekey="Rs_AResource1"></asp:Label></span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtDiscount" runat="server" TabIndex="4" onkeyup="javascript:CorrectTotal();totalCalculate();"
                                                    Text="0.00" CssClass="Txtboxsmall" onblur="AddDiscountsCheck();ChangeFormat();totalCalculate(); ValidateDiscountReason();doCalcReimburse();"
                                                      onkeypress="return ValidateOnlyNumeric(this);"   
                                                    meta:resourcekey="txtDiscountResource4" />
                                            </td>
                                        </tr>
                                        <tr id="trDiscountReason">
                                            <td>
                                            </td>
                                            <td align="right">
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="Label1" runat="server" Text="Reason for Discount" 
                                                    class="defaultfontcolor" meta:resourcekey="Label1Resource1" />
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtDiscountReason" runat="server" TabIndex="5" 
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtDiscountReasonResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td align="right">
                                            
                                            </td>
                                            <td align="right" valign="top">
                                                <asp:Label ID="Rs_Tax"  Text="Tax" runat="server" 
                                                    meta:resourcekey="Rs_TaxResource1"></asp:Label><span style="color: Red;">
                                                <asp:Label ID="Rs_B" Text="(B)" runat="server" meta:resourcekey="Rs_BResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtTax" runat="server" CssClass="Txtboxsmall" 
                                                    Onchange="return CalcTax();" meta:resourcekey="txtTaxResource1"></asp:TextBox>
                                                <asp:HiddenField ID="hdfTax" runat="server" />
                                                <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnManualTaxPercentage" runat="server" Value="0" />
                                                <div id="dvTaxDetails" align="left" runat="server" class="dataheaderInvCtrl">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="Rs_PreviousDue" Text="Previous Due" runat="server" 
                                                    meta:resourcekey="Rs_PreviousDueResource1"></asp:Label>&nbsp;<span style="color: Red;"><asp:Label 
                                                    ID="Rs_C" Text="(C)" runat="server" meta:resourcekey="Rs_CResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtPreviousDue" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtPreviousDueResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td colspan="2" align="right">
                                                <img alt="" onclick="ChangeImage();" src="../Images/collapse.jpg" style="display: none;"
                                                    id="imgDue" />
                                                <a id="A1" href="javascript:animatedcollapse.toggle('Due');" runat="server" style="color: Black;
                                                    font-size: 11; text-decoration: underline;">
                                                <asp:Label ID="Rs_ShowHideDueDetails" Text="Show/Hide Due Details" 
                                                    runat="server" meta:resourcekey="Rs_ShowHideDueDetailsResource1"></asp:Label> </a>
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
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="Rs_ServiceChargePaid" Text="Service Charge Paid" runat="server" 
                                                    meta:resourcekey="Rs_ServiceChargePaidResource1"></asp:Label>&nbsp;<span style="color: Red;"><asp:Label 
                                                    ID="Rs_D" Text="(D)" runat="server" meta:resourcekey="Rs_DResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtPrevServiceCharge" runat="server" Text="0.00" Enabled="False"
                                                    TabIndex="6" CssClass="Txtboxsmall" 
                                                    meta:resourcekey="txtPrevServiceChargeResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <b><asp:Label ID="Rs_AmountPaid" Text="Amount Paid" runat="server" 
                                                    meta:resourcekey="Rs_AmountPaidResource1"></asp:Label> </b>
                                                <asp:Label ID="Rs_IncludesServiceCharges" Text="(Includes Service Charges)" 
                                                    runat="server" meta:resourcekey="Rs_IncludesServiceChargesResource1"></asp:Label>&nbsp;<span style="color: Red;"><asp:Label 
                                                    ID="Rs_E" Text="(E)" runat="server" meta:resourcekey="Rs_EResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtPreviousAmountPaid" runat="server" Text="0.00" Enabled="False"
                                                    TabIndex="6" CssClass="Txtboxsmall" 
                                                    meta:resourcekey="txtPreviousAmountPaidResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="tpaDetails" Text="Amount Paid by TPA(Includes Service Charges)" 
                                                    runat="server" meta:resourcekey="tpaDetailsResource1"></asp:Label>
                                                &nbsp;<span style="color: Red;"><asp:Label ID="Rs_F" Text="(F)" runat="server" 
                                                    meta:resourcekey="Rs_FResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtThirdParty" runat="server" Text="0.00" Style="display: none;"
                                                    TabIndex="6" CssClass="textBoxRightAlign" 
                                                    meta:resourcekey="txtThirdPartyResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <b><asp:Label ID="Rs_AdvanceReceived" Text="Advance Received" runat="server" 
                                                    meta:resourcekey="Rs_AdvanceReceivedResource1"></asp:Label>
                                                 </b><asp:Label ID="Rs_IncludesSurgerypaymentsandServiceCharges" 
                                                    Text="(Includes Surgery payments and Service Charges)" runat="server" 
                                                    meta:resourcekey="Rs_IncludesSurgerypaymentsandServiceChargesResource1"></asp:Label><span
                                                    style="color: Red;"><asp:Label ID="Rs_G" Text="(G)" runat="server" 
                                                    meta:resourcekey="Rs_GResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtRecievedAdvance" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                                    CssClass="Txtboxsmall" 
                                                    meta:resourcekey="txtRecievedAdvanceResource1"/>
                                                   
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" 
                                                    meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label><span style="color: Red;">
                                                <asp:Label ID="Rs_Info" Text="(H)" runat="server" 
                                                    meta:resourcekey="Rs_InfoResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtServiceCharge" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                                    CssClass="Txtboxsmall" 
                                                    meta:resourcekey="txtServiceChargeResource1" />
                                                <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnPrevServiceCharge" runat="server" Value="0" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="Rs_RoundOffAmount" Text="Round Off Amount" runat="server" 
                                                    meta:resourcekey="Rs_RoundOffAmountResource1"></asp:Label><span style="color: Red;">
                                                <asp:Label ID="Rs_Info1" Text="(I)" runat="server" 
                                                    meta:resourcekey="Rs_Info1Resource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtRoundOff" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtRoundOffResource1" />
                                                <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblGrandTotal" runat="server" Text="Net Payable Amount" 
                                                    class="defaultfontcolor" meta:resourcekey="lblGrandTotalResource1" />
                                                &nbsp;<span style="color: Red;"><asp:Label ID="Rs_Info2" 
                                                    Text="(X+B+D+H+I)-(A+E+F+G)" runat="server" 
                                                    meta:resourcekey="Rs_Info2Resource1"></asp:Label>
                                                </span>
                                            </td> 
                                            <td align="right">
                                                <asp:TextBox ID="txtGrandTotal" Text="0" Style="border-style: dashed; border-width: 1px;
                                                    border-color: Red;" Enabled="False" runat="server" TabIndex="8" 
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtGrandTotalResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="Rs_AmountRefunded"   Text="Amount Refunded" runat="server" 
                                                    meta:resourcekey="Rs_AmountRefundedResource1"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtPreviousRefund" runat="server" TabIndex="8" Enabled="False" 
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtPreviousRefundResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            
                                            <td align="right" colspan="3">
                                                <asp:Label ID="Rs_AmounttoRefund" Text="Amount to Refund" runat="server" 
                                                    meta:resourcekey="Rs_AmounttoRefundResource1"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:CheckBox ID="ChkRefund" runat="server" Text="Yes" 
                                                    onClick="javascript:funcRefundChk();RefundExcess();" 
                                                    meta:resourcekey="ChkRefundResource1" />
                                                <asp:TextBox ID="txtRefundAmount" runat="server" TabIndex="8" onkeyup="javascript:AmountRefundCheck();"
                                                    Text="0.00" CssClass="Txtboxsmall" onblur="AmountRefundCheck();" 
                                                      onkeypress="return ValidateOnlyNumeric(this);"  
                                                    meta:resourcekey="txtRefundAmountResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            
                                            <td align="right" colspan="3">
                                                <div id="dvRefund" style="display: none">
                                                    <asp:Label ID="Rs_ReasonforRefund" Text="Reason for Refund" runat="server" 
                                                        meta:resourcekey="Rs_ReasonforRefundResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="reasonforRefund" style="display: none">
                                                    <asp:TextBox ID="txtReasonForRefund" runat="server" TabIndex="8" MaxLength="150"
                                                         CssClass="textBoxRightAlign" 
                                                        meta:resourcekey="txtReasonForRefundResource1" /></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            
                                           
                                            <td align="right" colspan="3">
                                            <div id="refundmode" style="display: none";>
                                                <asp:Label ID="Rs_RefundMode" Text="Refund Mode" runat="server" 
                                                    meta:resourcekey="Rs_RefundModeResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td align="right">
                                            <div id="PayMode" style="display:none";>
                                                <asp:DropDownList ID="ddlPayMode" runat="server" 
                                                    onchange="javascript:showHide(this.value);" 
                                                    meta:resourcekey="ddlPayModeResource1">
                                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>
                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource2">Cash</asp:ListItem>
                                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource3">Cheque</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                           
                                            <td id="tdBankName" align="right" colspan="3">
                                            <div id="banknametxt" style="display:none";>
                                                <asp:Label Text="Bank Name" runat="server" ID="lblBankName" 
                                                    meta:resourcekey="lblBankNameResource1"></asp:Label>
                                                </div>
                                                </td>
                                            <td align="right">
                                            <div id="bankname" style="display:none"; >
                                            <asp:TextBox ID="txtBankName" runat="server"  MaxLength="150" 
                                                    CssClass="textBoxRightAlign" meta:resourcekey="txtBankNameResource1"></asp:TextBox>
                                            </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            
                                            <td id="tdCheque"  align="right" colspan="3">
                                                <div id="CardNo" style="display:none";><asp:Label ID="lblCardNo" runat="server" 
                                                        Text="Cheque Number" meta:resourcekey="lblCardNoResource1"></asp:Label>
                                                </div>
                                                </td>
                                               <td align="right"><div id="CardNotxt" style="display:none";> 
                                                   <asp:TextBox ID="txtCardNo" runat="server" MaxLength="150" 
                                                       CssClass="textBoxRightAlign" meta:resourcekey="txtCardNoResource1"></asp:TextBox>
                                             </div>
                                            </td>
                                        </tr>
                                        <tr runat="server" id="trNonReimburse">
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <div id="Div1" style="display: block">
                                                    <asp:Label ID="Rs_PaidAgainstNonMedicalItems" 
                                                        Text="Paid Against Non-MedicalItems" runat="server" 
                                                        meta:resourcekey="Rs_PaidAgainstNonMedicalItemsResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="Div2" style="display: block">
                                                    <asp:TextBox ID="txtNonMedical" Enabled="False" runat="server" TabIndex="8" MaxLength="150"
                                                        Text="0.00" CssClass="Txtboxsmall" onblur="javascript:getPrecision(this);"
                                                          onkeypress="return ValidateOnlyNumeric(this);"  
                                                        meta:resourcekey="txtNonMedicalResource1" /></div>
                                            </td>
                                        </tr>
                                        <tr runat="server" id="trCoPayment" enabled="false">
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <table>
                                                    <tr>
                                                        <td align="right">
                                                            &nbsp;
                                                            <label id="lblCopercent" runat="server">
                                                               <asp:Label ID="Rs_CoPayment" Text="Co-Payment %" runat="server" 
                                                                meta:resourcekey="Rs_CoPaymentResource1"></asp:Label></label>
                                                        </td>
                                                        <td align="left" valign="top">
                                                            <asp:TextBox ID="txtCopercent" runat="server" Width="50px" ReadOnly="True" 
                                                                Text="0.00" Enabled="False"
                                                                CssClass="Txtboxsmall" meta:resourcekey="txtCopercentResource1"></asp:TextBox>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblCopayment" runat="server" Text="Co-Payment"  Enabled="False" 
                                                                meta:resourcekey="lblCopaymentResource1"/>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="right">
                                                <div id="Div4" >
                                                    <asp:TextBox ID="txtCoPayment" runat="server" TabIndex="8" MaxLength="150" 
                                                        Text="0.00" Enabled="False"
                                                        CssClass="Txtboxsmall" onblur="javascript:getPrecision(this);customCoPayment();"
                                                        onfocus="javascript:prepareCopayment();" 
                                                          onkeypress="return ValidateOnlyNumeric(this);"   
                                                        meta:resourcekey="txtCoPaymentResource1" />
                                                    <input type="hidden" value="0.00" id="hdnCoPayment" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr runat="server" id="trExcess">
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <div id="Div5" style="display: block">
                                                   <asp:Label ID="Rs_ExcessAmountReceived" Text="Excess Amount Received" 
                                                        runat="server" meta:resourcekey="Rs_ExcessAmountReceivedResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="Div6" style="display: block">
                                                    <asp:TextBox ID="txtExcess" Enabled="False" runat="server" TabIndex="8" MaxLength="150"
                                                        Text="0.00" CssClass="Txtboxsmall" 
                                                          onkeypress="return ValidateOnlyNumeric(this);"   
                                                        meta:resourcekey="txtExcessResource1" />
                                                </div>
                                            </td>
                                        </tr>
                                        <%--<tr>
                                        <td></td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <div id="Div9" style="display: block">
                                                    TPA Due
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="Div10" style="display: block">
                                                    <asp:TextBox ID="txtTpaDue" runat="server" TabIndex="8" MaxLength="150" Text="0.00"
                                                        CssClass="textBoxRightAlign"   onkeypress="return ValidateOnlyNumeric(this);"   />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                        <td></td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <div id="Div7" style="display: block">
                                                    Patient Due
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="Div8" style="display: block">
                                                    <asp:TextBox ID="txtDue" runat="server" TabIndex="8" MaxLength="150" Text="0.00"
                                                        CssClass="textBoxRightAlign"   onkeypress="return ValidateOnlyNumeric(this);"   />
                                                </div>
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Received" 
                                                    class="defaultfontcolor" meta:resourcekey="lblAmountRecievedResource1" />
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtAmountRecieved" runat="server" TabIndex="9" ReadOnly="True" 
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtAmountRecievedResource1" />
                                                <asp:HiddenField ID="hdnAmountReceived" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="Preauth" runat="server" style="display: none">
                                            <td>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="Label2" runat="server" Text="Pre Authorization Amount :" 
                                                    Font-Bold="True" meta:resourcekey="Label2Resource1"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblPreAuthAmount" Text="0.00" runat="server" Font-Bold="True" 
                                                    meta:resourcekey="lblPreAuthAmountResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" valign="bottom">
                                                <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                            </td>
                                            <td align="right" colspan="1">
                                                <div style="position: relative">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:CheckBox onclick="javascript:ShowHideButton()" runat="server" ID="chkDischarge"
                                                                    Text="Discharge Patient" Font-Bold="True" Checked="True" Enabled="False" 
                                                                    meta:resourcekey="chkDischargeResource1"/>
                                                            </td>
                                                            <td>
                                                                &nbsp;<asp:TextBox ID="txtDischargeDate" CssClass="Txtboxsmall" runat="server" Width="120px" 
                                                                    ToolTip="Discharge Date" meta:resourcekey="txtDischargeDateResource1"></asp:TextBox>
                                                                <img onclick="return CheckDischarge()" style="cursor: hand;" id="imgdischarge" src="../Images/Calendar_scheduleHS.png"
                                                                    width="16" height="16" border="0" alt="Pick a date" />
                                                                <%--<ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgToDate"
                                                                TargetControlID="txtDischargeDate" />
                                <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtDischargeDate"
                                                    Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                    OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                    ErrorTooltipEnabled="True" />--%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <asp:CheckBox ID="chkisCreditTransaction" Text="Credit Transaction" runat="server"
                                                    class="defaultfontcolor" onclick="checkIsCredit();" 
                                                    meta:resourcekey="chkisCreditTransactionResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trPaymentControl" style="display:none"  runat="server">
                                <td colspan="3">
                                    <uc13:paymentType ID="PaymentType" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center" wrap="nowrap">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server"  Text="Generate Bill"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    OnClientClick="return CheckBilling(this.id);" OnClick="btnSave_Click" 
                                                    meta:resourcekey="btnSaveResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnSaveTemp" runat="server" Style="display: none;" 
                                                    Text="Save Bill" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClientClick="return CheckBilling(this.id);"
                                                    OnClick="btnSaveBill_Click" meta:resourcekey="btnSaveTempResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnClose" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" Text="Close" OnClick="btnClose_Click" 
                                                    meta:resourcekey="btnCloseResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlOthers" runat="server" Style="display: none;" 
                            CssClass="modalPopup dataheaderPopup" meta:resourcekey="pnlOthersResource1">
                            <center>
                                <div id="divOthers" style="width: 350px; height: 200px; padding-top: 50px; padding-left: 15px">
                                    <table width="90%" align="center">
                                        <tr align="left">
                                            <td>
                                                <label id="lblFeeDesc" style="width: 155px;">
                                                   <asp:Label ID="Rs_FeeDescription" Text="Fee Description" runat="server" 
                                                    meta:resourcekey="Rs_FeeDescriptionResource1"></asp:Label></label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFeeDesc" runat="server" 
                                                    meta:resourcekey="txtFeeDescResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td>
                                                <label id="lblFeeType" style="width: 155px;">
                                                    <asp:Label ID="Rs_TagTo" Text="Tag To" runat="server" 
                                                    meta:resourcekey="Rs_TagToResource1"></asp:Label></label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFeeType" Width="155px" runat="server" 
                                                    onchange="javascript:showPhysician(this,getElementById('trPhysician'));" 
                                                    meta:resourcekey="ddlFeeTypeResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="trPhysician" style="display: none" align="left">
                                            <td>
                                                <label id="lblPhysician" style="width: 155px;">
                                                    <asp:Label ID="Label3" Text="Tag To Physician" runat="server" 
                                                    meta:resourcekey="Label3Resource1"></asp:Label>
                                                    <asp:Label ID="Rs_TagToPhysician" Text="Tag To Physician" runat="server" 
                                                    meta:resourcekey="Rs_TagToPhysicianResource1"></asp:Label>
                                                </label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtConsultant" onclick="javascript:doResetConsultant(this);" onblur="this.readOnly=true;"
                                                    runat="server" meta:resourcekey="txtConsultantResource1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteConsultant" runat="server" CompletionInterval="1"
                                                    CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                    CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                                                    UseContextKey="True" MinimumPrefixLength="2" OnClientItemSelected="doOnSelectPhysician"
                                                    ServiceMethod="GetConsultantName" ServicePath="~/WebService.asmx" 
                                                    TargetControlID="txtConsultant" DelimiterCharacters="" Enabled="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td>
                                                <label id="lblAmount" style="width: 155px;">
                                                    <asp:Label ID="Rs_FeeAmount" Text="Fee Amount" runat="server" 
                                                    meta:resourcekey="Rs_FeeAmountResource1"></asp:Label></label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAmnt" runat="server"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                    onblur="if(this.value!='')this.value=parseFloat(this.value).toFixed(2);" 
                                                    meta:resourcekey="txtAmntResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td colspan="2">
                                                <asp:CheckBox ID="chkNonReimburse" runat="server" Checked="True" 
                                                    Text="Is This Reimbursable Item." meta:resourcekey="chkNonReimburseResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Button ID="btnOK" CssClass="btn" runat="server" Text="OK" OnClientClick="javascript:return doValidation();"
                                                    OnClick="btnAddAmt_Click" meta:resourcekey="btnOKResource1" />
                                            </td>
                                            <td align="left">
                                                <input type="button" id="btnCancel" class="btn" onclick="javascript:doClear();" runat="server"
                                                    value="Cancel" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </center>
                        </asp:Panel>
                        <%--<asp:Button ID="hiddenTargetControlFormpeOthers" runat="server" Style="display: none" />--%>
                        <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
                        <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
                            PopupControlID="pnlOthers" CancelControlID="btnCancel" 
                            TargetControlID="hiddenTargetControlFormpeOthers" DynamicServicePath="" 
                            Enabled="True">
                        </ajc:ModalPopupExtender>
                        <asp:HiddenField ID="hdnFilterPhysicianID" runat="server" Value="0" />
                        <%--</ContentTemplate>
                        </asp:UpdatePanel>--%>
                        <asp:HiddenField ID="hdnDefaultRoundoff" runat="server" />
                        <asp:HiddenField ID="hdnRoundOffType" runat="server" />
                        <asp:HiddenField ID="hdnDiscountArray" runat="server" />
                        <asp:HiddenField ID="hdnNonMedical" runat="server" Value="0.00" />
                        <asp:HiddenField ID="hdnMedical" runat="server" Value="0.00" />
                        <asp:HiddenField ID="hdnCoPaymentFinal" runat="server" Value="0.00" />
                        <asp:HiddenField ID="hdnExcess" runat="server" Value="0.00" />
                        <%--<input id="btnTest" value="test" onclick="checkAdmitDischargeDate();" type="button" />--%>
                        <asp:HiddenField ID="hdnAdmissionDate" runat="server" />
                        <asp:HiddenField ID="hdnMaxBillDate" runat="server" />
                        <br />
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <uc5:Footer ID="Footer1" runat="server" />
    <input type="hidden" id="hdnCorporateDiscount" runat="server" />
    <asp:HiddenField ID="hdnUnBilledAdvanceReceived" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnUnBilledPreviousReceived" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnIsBilledBefore" runat="server" Value="N" />
    <asp:HiddenField ID="hdnNonReimburseFields" runat="server" />
    <asp:HiddenField ID="hdnDiscountDetails" runat="server" />
    <asp:HiddenField ID="hdnEditIPBill" runat="server" />

    <script language="javascript" type="text/javascript">
        calculateDiscountForCorporate();

        function calculateDiscountForCorporate() {
            var x, j, i, k, l;

            x = document.getElementById('hdnCorporateDiscount').value.split("^");

            i = x.length;
            for (j = 0; j < i; j++) {
                if (x[j] != "") {
                    k = x[j].split("~");

                    if (k[1] == "Percentage") {
                        document.getElementById('txtDiscount').value = parseFloat(parseFloat(parseFloat(document.getElementById('txtGross').value) / 100) * parseFloat(k[0])).toFixed(2);
                        document.getElementById('lblDiscount').innerText = " Discount %";
                    }
                    else {

                        if ((l == 0) && (document.getElementById('txtDiscount').value != "" || document.getElementById('txtDiscount').value != "0.00")) {
                            l++;
                            document.getElementById('txtDiscount').value = parseFloat(k[0]).toFixed(2);
                            document.getElementById('trDiscountReason').style.display = "block";
                        }
                        document.getElementById('lblDiscount').innerText = " Discount";
                    }
                }
            }
            CorrectTotal();
            totalCalculate();
            doCalcReimburse();
            SetOtherCurrValues();
        }
    </script>

    <script language="javascript" type="text/javascript">

        function CheckFees() {


        }
        function showModalPopup(evt, footDescID, footAmtID) {
            //evt.preventDefault();
            //document.getElementById('<%= txtFeeDesc.ClientID %>').value = document.getElementById("footDescID").value;
            //document.getElementById('<%= txtAmnt.ClientID %>').value = document.getElementById("footAmtID").value;
            document.getElementById('<%= pnlOthers.ClientID %>').style.display = "none";
            var modalPopupBehavior = $find('mpeOthersBehavior');
            modalPopupBehavior.show();
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
            //            if (document.getElementById("hdnEditIPBill").value == "Edit") {
            //                document.getElementById("chkNonReimburse").Enabled = false;
            //            }
            if (document.getElementById("txtFeeDesc").value.trim() == "") {

                alert("Please Enter Fee Description");
                document.getElementById("txtFeeDesc").focus();
                return false;
            }

            if (document.getElementById("txtAmnt").value.trim() == "" || Number(document.getElementById("txtAmnt").value) == 0) {
                alert("Please Enter Fee Amount");
                document.getElementById("txtAmnt").focus();
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

        function getPrecision(obj) {
            obj.value = obj.value == "" ? parseFloat(0).toFixed(2) : parseFloat(obj.value).toFixed(2);
        }

        function customCoPayment() {
            var txtCoPayment = document.getElementById("txtCoPayment");
            var txtExcess = document.getElementById("txtExcess");
            var hdnCoPayment = document.getElementById("hdnCoPayment");

            var excess = Number(txtExcess.value);
            var diffAmt = Number(txtCoPayment.value) - Number(hdnCoPayment.value);

            if (diffAmt > 0) {
                if (diffAmt > excess) {
                    txtCoPayment.value = parseFloat(Number(hdnCoPayment.value) + excess).toFixed(2);
                    txtExcess.value = parseFloat(0).toFixed(2);
                } else {
                    txtCoPayment.value = parseFloat(Number(hdnCoPayment.value) + diffAmt).toFixed(2);
                    txtExcess.value = parseFloat(excess - diffAmt).toFixed(2);
                }
            } else {
                diffAmt = (-1) * diffAmt;
                txtCoPayment.value = parseFloat(Number(hdnCoPayment.value) - diffAmt).toFixed(2);
                txtExcess.value = parseFloat(Number(txtExcess.value) + diffAmt).toFixed(2);
            }
            document.getElementById('<%= hdnCoPaymentFinal.ClientID %>').value = Number(txtCoPayment.value);
            document.getElementById('<%= hdnExcess.ClientID %>').value = Number(txtExcess.value);
        }

        function prepareCopayment() {
            var hdnCoPayment = document.getElementById("hdnCoPayment");
            var txtCoPayment = document.getElementById("txtCoPayment");
            getPrecision(txtCoPayment);
            hdnCoPayment.value = txtCoPayment.value;
        }

        function RefundExcess() {
            if (document.getElementById("ChkRefund").checked && Number(document.getElementById("txtExcess").value) > 0 && document.getElementById("chkisCreditTransaction").checked) {
                if (confirm("Do you want refund the Excess Amount Now")) {
                    document.getElementById("txtRefundAmount").value = parseFloat(Number(document.getElementById("txtRefundAmount").value) + Number(document.getElementById("txtExcess").value)).toFixed(2);
                    document.getElementById("txtExcess").value = parseFloat(0).toFixed(2);
                }
            }
        }

        function setDiscount() {
            if ((document.getElementById('ddDiscountPercent').value) == 'select') {
                document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
                document.getElementById('txtDiscount').readOnly = false;
            }

            AddDiscountsCheck();
            ChangeFormat();
            totalCalculate();
            ValidateDiscountReason();
            doCalcReimburse();
            //            CheckTotal();
        }

        function showHide() {

            if (document.getElementById('ddlPayMode').value == "1") {
                document.getElementById('banknametxt').style.display = "none";
                document.getElementById('bankname').style.display = "none";
                document.getElementById('CardNo').style.display = "none";
                document.getElementById('CardNotxt').style.display = "none";
                // document.getElementById('btnConsumable').disabled = false;
            }
            if (document.getElementById('ddlPayMode').value == "2") {
                document.getElementById('banknametxt').style.display = "block";
                document.getElementById('bankname').style.display = "block";
                document.getElementById('CardNo').style.display = "block";
                document.getElementById('CardNotxt').style.display = "block";
                // document.getElementById('btnConsumable').disabled = false;
            }
            if (document.getElementById('ddlPayMode').value == "0") {
                document.getElementById('banknametxt').style.display = "none";
                document.getElementById('bankname').style.display = "none";
                document.getElementById('CardNo').style.display = "none";
                document.getElementById('CardNotxt').style.display = "none";
                //  document.getElementById('btnConsumable').disabled = true;
            }
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
        }
        GetCurrencyValues();

    </script>
    <script language="javascript" type="text/javascript">
        var dateFlag = true;
        var dateBillMaxFlag = true;

        function checkBillMaxDischargeDate() {
            dateBillMaxFlag = true;
            var DischargeDate = document.getElementById("txtDischargeDate").value;
            var BillMax = document.getElementById("hdnMaxBillDate").value;
            var dtBillMax = BillMax.split(' ');
            var dtDischarge = DischargeDate.split(' ');
            // alert(dt[0]+"\n " +dt[1]);

            //Assign From And To Date from Controls
            DateBillMax = dtBillMax[0].split('/');
            DateDischarge = dtDischarge[0].split('/');


            //Argument Value 0 for validating Current Date And To Date 
            //Argument Value 1 for validating Current From And To Date
            if (doDateValidation(DateBillMax, DateDischarge, 1)) {
                //                alert("Date Success");
                if (dateBillMaxFlag) {
                    return true;
                }
                timeBillMax = dtBillMax[1].split(':');
                timeDischarge = dtDischarge[1].split(':');
                if (dtDischarge.length > 2 && (dtDischarge[2] != null || dtDischarge[2] != "")) {
                    timeDischarge[0] = dtDischarge[2].trim() == "AM" ? Number(timeDischarge[0]) == 12 ? "00" : timeDischarge[0] : Number(timeDischarge[0]) == 12 ? timeDischarge[0] : Number(timeDischarge[0]) + 12;
                }
                if (doTimeValidation(timeBillMax, timeDischarge, 1)) {
                    //                    alert("Time Success");
                    return true;
                }
                else {
                    //                    alert("Time Failed");
                    return false;
                }
            }
            else {
                //                alert("Date Failed");
                return false;
            }

        }

        function checkAdmitDischargeDate() {
            dateFlag = true;
            var DischargeDate = document.getElementById("txtDischargeDate").value;
            var AdmitDate = document.getElementById("hdnAdmissionDate").value;
            var dtAdmit = AdmitDate.split(' ');
            var dtDischarge = DischargeDate.split(' ');
            // alert(dt[0]+"\n " +dt[1]);

            //Assign From And To Date from Controls
            DateAdmit = dtAdmit[0].split('/');
            DateDischarge = dtDischarge[0].split('/');


            //Argument Value 0 for validating Current Date And To Date 
            //Argument Value 1 for validating Current From And To Date
            if (doDateValidation(DateAdmit, DateDischarge, 0)) {
                //                alert("Date Success");
                if (dateFlag) {
                    return true;
                }
                timeAdmit = dtAdmit[1].split(':');
                timeDischarge = dtDischarge[1].split(':');
                if (dtDischarge.length > 2 && (dtDischarge[2] != null || dtDischarge[2] != "")) {
                    timeDischarge[0] = dtDischarge[2].trim() == "AM" ? Number(timeDischarge[0]) == 12 ? "00" : timeDischarge[0] : Number(timeDischarge[0]) == 12 ? timeDischarge[0] : Number(timeDischarge[0]) + 12;
                }
                if (doTimeValidation(timeAdmit, timeDischarge, 0)) {
                    //                    alert("Time Success");
                    return true;
                }
                else {
                    //                    alert("Time Failed");
                    return false;
                }
            }
            else {
                //                alert("Date Failed");
                return false;
            }

        }

        function doDateValidation(from, to, bit) {
            var dayFlag = true;
            var monthFlag = true;
            var i = from.length - 1;
            if (Number(to[i]) >= Number(from[i])) {
                if (Number(to[i]) == Number(from[i])) {
                    monthFlag = false;
                }
                i--;
                if (Number(to[i]) >= Number(from[i])) {
                    if (Number(to[i]) == Number(from[i])) {
                        dayFlag = false;
                    }
                    i--;
                    if (Number(to[i]) >= Number(from[i])) {
                        if (Number(to[i]) == Number(from[i])) {
                            if (bit == 0) {
                                dateFlag = false;
                            } else {
                                dateBillMaxFlag = false;
                            }
                        }
                        i--;
                        return true;
                    }
                    else {
                        if (dayFlag) {
                            return true;
                        }
                        else {
                            if (bit == 0) {
                                alert('Mismatch Day Between Admission & Discharge Date');
                            }
                            else {
                                alert('Mismatch Day Between Billed & Discharge Date');
                            }
                            return false;
                        }
                    }
                }
                else if (monthFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {
                        alert('Mismatch Month Between Admission & Discharge Date');
                    }
                    else {
                        alert('Mismatch Month Between Billed & Discharge Date');
                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {
                    alert('Mismatch Year Between Admission & Discharge Date');
                }
                else {
                    alert('Mismatch Year Between Billed & Discharge Date');
                }
                return false;
            }
        }

        function doTimeValidation(from, to, bit) {
            var secFlag = true;
            var minFlag = true;
            var i = 0;
            if (Number(to[i]) >= Number(from[i])) {
                if (Number(to[i]) == Number(from[i])) {
                    minFlag = false;
                }
                i++;
                if (Number(to[i]) >= Number(from[i])) {
                    if (Number(to[i]) == Number(from[i])) {
                        secFlag = false;
                    }
                    i++;
                    if (Number(to[i]) >= Number(from[i])) {
                        i++;
                        return true;
                    }
                    else {
                        if (secFlag) {
                            return true;
                        }
                        else {
                            if (bit == 0) {
                                alert('Mismatch Second(s) Between Admission & Discharge Time');
                            }
                            else {
                                alert('Mismatch Second(s) Between Billed & Discharge Date');
                            }
                            return false;
                        }
                    }
                }
                else if (minFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {
                        alert('Mismatch Minute(s) Between Admission & Discharge Time');
                    }
                    else {
                        alert('Mismatch Minute(s) Between Billed & Discharge Time');
                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {
                    alert('Mismatch Hour(s) Between Admission & Discharge Time');
                }
                else {
                    alert('Mismatch Hour(s) Between Billed & Discharge Time');
                }
                return false;
            }
        }
    </script>
    <script language="javascript" type="text/javascript">
        function chkCustomTax(idval, dAmount) {

            var sVal = Number(document.getElementById('txtTax').value);
            var sGrand = format_number(Number(document.getElementById('txtGross').value) - (Number(document.getElementById('txtDiscount').value)), 2);
            var divTax = document.getElementById("dvTaxDetails");
            //            for (int i=0; i < divTax.getElementsByTagName('input').length;i++)
            //            {
            //              if(divTax.getElementsByTagName('input')[i].nextSibling.nodeValue.trim()=="Custom")
            //              {
            //             divTax.getElementsByTagName('input')[i].checked=true;
            //              }else{
            //             divTax.getElementsByTagName('input')[i].checked=false; 
            //              }
            //            }
            var sControl = document.getElementById(idval);
            var arrayAlready = new Array();
            var iCount = 0;
            var tSelectedData = "";

            if (sControl.checked == true) {
                sVal = sVal + Number(dAmount);

                document.getElementById('hdfTax').value += ">" + idval + "~" + dAmount;
                document.getElementById('txtTax').value = format_number(sVal, 2);
                document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);

            }
            else {
                sVal = sVal - dAmount;
                var tempval = document.getElementById('hdfTax').value;

                arrayAlready = tempval.split('>');
                if (arrayAlready.length > 0) {
                    for (iCount = 0; iCount < arrayAlready.length; iCount++) {
                        if (arrayAlready[iCount].toLowerCase() == (idval.toLowerCase() + "~" + dAmount.toLowerCase())) {
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
            }
            document.getElementById('txtTax').value = format_number(sVal, 2);
            document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);

            totalCalculate();
            SetOtherCurrValues();
        }
    </script>
    </form>
</body></html>
