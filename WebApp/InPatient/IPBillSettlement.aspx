<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPBillSettlement.aspx.cs"
    Inherits="InPatient_IPBillSettlement" meta:resourcekey="PageResource1" %>

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
<%@ Register Src="../CommonControls/PatientCreditLimt.ascx" TagName="CreditLimt"
    TagPrefix="uc16" %>
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

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script src="../Scripts/IPBillSettlement.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script type="text/javascript">

        function ToInternalFormat(pControl) {
            // debugger;
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
            // debugger;
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
        function chkbilldate() {
            if (document.getElementById('chkDischarge').checked == true) {
                NewCal('<%=txtBillDate.ClientID %>', 'ddmmyyyy', true, 12)
                return true;
            }
            if (document.getElementById('chkDischarge').checked == false) {
                alert("Click Discharge patient");
                return false;
            }
        }
        function datePick(objDate) {

            NewCal(objDate, 'ddmmyyyy', true, 12)

        }
        function ShowHideButton() {
            if (document.getElementById('chkDischarge').checked == true) {
                document.getElementById('trPaymentControl').style.display = "block";
                document.getElementById('btnSave').style.display = "block";
                document.getElementById('btnSaveTemp').style.display = "none";
            }
            if (document.getElementById('chkDischarge').checked == false) {
                document.getElementById('trPaymentControl').style.display = "none";
                document.getElementById('btnSave').style.display = "none";
                document.getElementById('btnSaveTemp').style.display = "block";
            }

        }
        
    </script>

    <script type="text/javascript">
        $(function() {
            var $img = $('#imgdischarge');

            var $txt = $('#txtDischargeDate');

            var $chk = $('#chkDischarge');

            var $imgbildate = $('#imgbildate');

            var $bilDate = $('#txtBillDate');

            // check on page load

            checkChecked($chk);



            $chk.click(function() {

                checkChecked($chk);

            });


            function checkChecked(chkBox) {
                if (chkBox.is(":checked")) {
                    $img.removeAttr('disabled');
                    $imgbildate.removeAttr('disabled');
                    $txt.removeAttr('disabled');
                    $bilDate.removeAttr('disabled');
                    //NewCal('<%=txtDischargeDate.ClientID %>', 'ddmmyyyy', true, 12);
                } else {
                    //  $img.attr('disabled', 'disabled');
                    $txt.attr('disabled', 'disabled');
                    $bilDate.attr('disabled', 'disabled');
                }
            }
        });
    </script>

    <script language="javascript" type="text/javascript">

        function SetOtherCurrValues() {
            var pnetAmt = 0;
            //            pnetAmt = document.getElementById('txtGrandTotal').value == "" ? "0" : document.getElementById('txtGrandTotal').value;
            pnetAmt = document.getElementById('txtGrandTotal').value == "" ? "0" : ToInternalFormat($("#txtGrandTotal"));
            ToTargetFormat($('#txtGrandTotal'));
            var ConValue = "OtherCurrencyDisplay1";

            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }
       
    
    </script>

    <script type="text/javascript">

        $('html,body').click(function(event) {
            if (document.getElementById("hdnRooomTypeID").value > 0) {
                var id = event.target.id;
                if (id == "btnSaveTemp" || id == "btnSave" || id == "btnOK" || id == "btnAdd" || id == "btnCancel") {
                    return true;
                }
                else if (id.substring(0, 9) == "gvIndents" || id.substring(0, 14) == "gvMedicalItems" || id.substring(0, 16) == "gvIndentRoomType") {
                    return true;
                }
                else {
                    alert('Please Save The Details...');
                    return false;
                }

            }
            else {
                return true;
            }

        });
    </script>

</head>
<body oncontextmenu="return true;" onkeydown="SuppressBrowserRefresh();">
    <form id="form1" runat="server">
    <input type="hidden" id="hdnRecievedAmount" runat="server" />
    <input type="hidden" id="hdnCurrentDue" runat="server" />
    <input type="hidden" id="hdnGrandTotal" runat="server" />
    <input type="hidden" id="hdnDeduction" runat="server" />
    <asp:HiddenField ID="hdnRooomTypeID" Value="0" runat="server" />

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

                        //if (document.getElementById('txtDiscount').value > 0) {
                        if (Number(ToInternalFormat($("#txtDiscount"))) > 0) {
                            if (document.getElementById('txtDiscountReason').value == "") {
                                alert('Enter Reason for Discount.');
                                document.getElementById('txtDiscountReason').focus();
                                return false;
                            }
                        }
                        var GenerateBill = confirm("Generated bill can not be edited again.\n Only items added in the future will be allowed to edit.\n Do you want to continue");
                        if (GenerateBill == true) {
                            $get('btnSave').disabled = true;
                            javascript: __doPostBack('btnSave', '');
                            return true;


                        }
                        else {
                            return false;
                        }
                    }


                    if (returndatavalue == true) {
                        //if (Number(document.getElementById('txtGrandTotal').value) < Number(document.getElementById('txtAmountRecieved').value)) {
                        if (Number(ToInternalFormat($("#txtGrandTotal"))) < Number(ToInternalFormat($("#txtAmountRecieved")))) {

                            alert('Amount recieved greater than current total. \n Please check recieved amount.');
                            document.getElementById('txtAmountRecieved').value = '0';
                            document.getElementById('hdnAmountReceived').value = '0';
                            ToTargetFormat($('#txtAmountRecieved'));
                            ToTargetFormat($('#hdnAmountReceived'));
                            return false;
                        }
                        if ((document.getElementById('chkisCreditTransaction').checked == false) && (document.getElementById('ChkRefund').checked == false)) {
                            //if ((Number(document.getElementById('txtAmountRecieved').value) < 0) && (Number(document.getElementById('txtGrandTotal').value) != 0)) {
                            if ((Number(ToInternalFormat($("#txtAmountRecieved"))) < 0) && (Number(ToInternalFormat($("#txtGrandTotal"))) != 0)) {
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

                        //if (document.getElementById('txtDiscount').value > 0) {
                        if (Number(ToInternalFormat($("#txtDiscount"))) > 0) {
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
                            $get('btnSaveTemp').disabled = true;
                            javascript: __doPostBack('btnSaveTemp', '');
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
            //     if (Number(document.getElementById('txtAmountRecieved').value) < Number(document.getElementById('txtGrandTotal').value)) {
            if (Number(ToInternalFormat($("#txtAmountRecieved"))) < Number(ToInternalFormat($("#txtAmountRecieved")))) {


            }

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
                //document.getElementById('<%= txtRecievedAdvance.ClientID %>').value = document.getElementById('hdnUnBilledAdvanceReceived').value;
                document.getElementById('<%= txtRecievedAdvance.ClientID %>').value = ToInternalFormat($("#hdnUnBilledAdvanceReceived"));
                ToTargetFormat($('#txtRecievedAdvance'));
            }
        }

        function totalCalculate() {
            // doAssignUnBilledReceivable();
            if ((document.getElementById('ddDiscountPercent').value) != 'select') {
                //document.getElementById('txtDiscount').value = parseFloat((parseFloat(document.getElementById('hdnGross').value) / 100) * (document.getElementById('ddDiscountPercent').value)).toFixed(2);
                document.getElementById('txtDiscount').value = parseFloat((parseFloat(ToInternalFormat($("#hdnGross"))) / 100) * (ToInternalFormat($("#ddDiscountPercent")))).toFixed(2);

                ToTargetFormat($('#txtDiscount'));

                document.getElementById('txtDiscount').readOnly = true;
            }
            else {
                document.getElementById('txtDiscount').readOnly = false;
            }

            // var GrossAmount = document.getElementById('<%= hdnGross.ClientID %>').value;
            var GrossAmount = ToInternalFormat($("#<%= hdnGross.ClientID %>"));
            //var DiscountAmount = document.getElementById('<%= txtDiscount.ClientID  %>').value;
            var DiscountAmount = ToInternalFormat($("#<%= txtDiscount.ClientID  %>"));
            var GrandTotal = document.getElementById('<%= txtGrandTotal.ClientID  %>');

            //var PreviousReceived = document.getElementById('<%= txtPreviousAmountPaid.ClientID %>').value;
            var PreviousReceived = ToInternalFormat($("#<%= txtPreviousAmountPaid.ClientID %>"));
            //var PreviousDue = document.getElementById('<%= txtPreviousDue.ClientID %>').value;
            var PreviousDue = ToInternalFormat($("#<%= txtPreviousDue.ClientID %>"));

            var ptempServiceCharge = document.getElementById('<%= hdnPrevServiceCharge.ClientID %>');
            //var pTempAmtfromTPA = document.getElementById('<%= txtThirdParty.ClientID %>').value;
            var pTempAmtfromTPA = ToInternalFormat($("#<%= txtThirdParty.ClientID %>"));

            //            var AdvanceReceivd = document.getElementById('<%= txtRecievedAdvance.ClientID %>').value;
            var AdvanceReceivd = ToInternalFormat($("#<%= txtRecievedAdvance.ClientID %>"));

            var RefundAmount = document.getElementById('<%= txtRefundAmount.ClientID %>');

            //var TaxAMount = Number(document.getElementById('txtTax').value, 2);
            var TaxAMount = Number(ToInternalFormat($("#txtTax")), 2);

            var RoundOFF = document.getElementById('<%= txtRoundOff.ClientID %>');
            var hdnRoundOff = document.getElementById('<%= hdnRoundOff.ClientID %>');

            var defRoundOff = document.getElementById('<%= hdnDefaultRoundoff.ClientID %>').value;
            //var defRoundOff = ToInternalFormat($("#<%= hdnDefaultRoundoff.ClientID %>"));
            var RoundOffType = document.getElementById('<%= hdnRoundOffType.ClientID %>').value;
            var txtPreviousRefund = document.getElementById('<%= txtPreviousRefund.ClientID %>');

            //txtPreviousRefund.value = txtPreviousRefund.value == "" ? parseFloat(0).toFixed(2) : parseFloat(txtPreviousRefund.value).toFixed(2);
            txtPreviousRefund.value = txtPreviousRefund.value == "" ? parseFloat(0).toFixed(2) : parseFloat(ToInternalFormat($("#" + txtPreviousRefund.id))).toFixed(2);

            ToTargetFormat($('#' + txtPreviousRefund.id));

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
                ToTargetFormat($('#<%= txtDiscount.ClientID  %>'));
                CorrectTotal();
                totalCalculate();
                doCalcReimburse();
                SetOtherCurrValues();
            }
            else {
                var totGrossAmount = 0;
                //var PreviousBillPaid = Number(document.getElementById('hdnUnBilledAdvanceReceived').value);
                var PreviousBillPaid = Number(ToInternalFormat($("#hdnUnBilledAdvanceReceived")));

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

                //                totGrossAmount = format_number((Number(GrossAmount)
                //                                    + Number(TaxAMount) + Number(ptempServiceCharge.value)
                //                                    - (Number(PreviousReceived)
                //                                        + Number(DiscountAmount)
                //                                        + Number(AdvanceReceivd) + Number(pTempAmtfromTPA) - Number(txtPreviousRefund.value))
                //                                       ), 2);


                totGrossAmount = format_number((Number(GrossAmount)
                                    + Number(TaxAMount) + Number(ToInternalFormat($("#" + ptempServiceCharge.id)))
                                    - (Number(PreviousReceived)
                                        + Number(DiscountAmount)
                                        + Number(AdvanceReceivd) + Number(pTempAmtfromTPA) - Number(ToInternalFormat($("#" + txtPreviousRefund.id))))
                                       ), 2);
                //                }
                RoundOFF.value = getCustomRoundoff(totGrossAmount, Number(defRoundOff), RoundOffType);
                ToTargetFormat($('#' + RoundOFF.id));

                if (RoundOFF.value == 'NaN') // If the result is NaN (due to Divide by Zero), set the value to Zero.
                    RoundOFF.value = 0;
                ToTargetFormat($('#' + RoundOFF.id));

                //hdnRoundOff.value = RoundOFF.value;
                hdnRoundOff.value = ToInternalFormat($("#" + RoundOFF.id));
                ToTargetFormat($('#' + hdnRoundOff.id));
                // totGrossAmount = format_number((Number(hdnRoundOff.value) + Number(totGrossAmount)), 2);
                totGrossAmount = format_number((Number(ToInternalFormat($("#" + hdnRoundOff.id))) + Number(totGrossAmount)), 2);

                if (Number(totGrossAmount) > 0) {
                    GrandTotal.value = format_number(totGrossAmount, 2);
                    RefundAmount.value = 0;
                    ToTargetFormat($('#' + GrandTotal.id));
                    ToTargetFormat($('#' + RefundAmount.id));
                }
                else {
                    GrandTotal.value = 0;
                    ToTargetFormat($('#' + GrandTotal.id));
                    //                    if (document.getElementById("chkShowUnbilled").checked && document.getElementById("hdnIsBilledBefore").value == "Y") {
                    //                        RefundAmount.value = format_number((Number(document.getElementById('hdnUnBilledPreviousReceived').value) + Number(DiscountAmount) + Number(AdvanceReceivd) - Number(txtPreviousRefund.value) - Number(PreviousBillPaid)) - (Number(GrossAmount) + Number(RoundOFF.value) + Number(ptempServiceCharge.value) + Number(TaxAMount) + Number(PreviousDue) + Number(pTempAmtfromTPA)), 2);
                    //                    }
                    //                    else {
                    // RefundAmount.value = format_number((Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd) - Number(txtPreviousRefund.value)) - (Number(GrossAmount) + Number(RoundOFF.value) + Number(ptempServiceCharge.value) + Number(TaxAMount) + Number(PreviousDue) + Number(pTempAmtfromTPA)), 2);
                    RefundAmount.value = format_number((Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd) - Number(ToInternalFormat($("#" + txtPreviousRefund.id)))) - (Number(GrossAmount) + Number(ToInternalFormat($("#" + RoundOFF.id))) + Number(ToInternalFormat($("#" + ptempServiceCharge.id))) + Number(TaxAMount) + Number(PreviousDue) + Number(pTempAmtfromTPA)), 2);
                    ToTargetFormat($('#' + RefundAmount.id));
                    //                    }
                }
                //RefundAmount        

            }
            GetCurrencyValues();
        }
        function AmountRefundCheck() {
            // var PreviousReceived = document.getElementById('<%= txtPreviousAmountPaid.ClientID %>').value;
            //var AdvanceReceivd = document.getElementById('<%= txtRecievedAdvance.ClientID %>').value;
            //var RefundAmount = document.getElementById('<%= txtRefundAmount.ClientID %>').value;
            var PreviousReceived = ToInternalFormat($("#<%= txtPreviousAmountPaid.ClientID %>"));
            var AdvanceReceivd = ToInternalFormat($("#<%= txtRecievedAdvance.ClientID %>"));
            var RefundAmount = ToInternalFormat($("#<%= txtRefundAmount.ClientID %>"));
            var txtPreviousRefund = document.getElementById('<%= txtPreviousRefund.ClientID %>');

            // txtPreviousRefund.value = txtPreviousRefund.value == "" ? parseFloat(0).toFixed(2) : parseFloat(txtPreviousRefund.value).toFixed(2);
            txtPreviousRefund.value = txtPreviousRefund.value == "" ? parseFloat(0).toFixed(2) : parseFloat(ToInternalFormat($("#" + txtPreviousRefund.id))).toFixed(2);
            ToTargetFormat($('#' + txtPreviousRefund.id));

            var totAmount = Number(PreviousReceived) + Number(AdvanceReceivd) - Number(txtPreviousRefund.value);
            if (Number(totAmount) < Number(RefundAmount)) {
                document.getElementById('<%= txtRefundAmount.ClientID %>').value = 0;
                ToTargetFormat($('#<%= txtRefundAmount.ClientID %>'));
                CorrectTotal();
                totalCalculate();
                doCalcReimburse();
                SetOtherCurrValues();
            }


        }

        function AmountRecieved() {
            //  var grandTotal = document.getElementById('txtGrandTotal').value;
            // var amountRecieved = document.getElementById('txtAmountRecieved').value;

            var grandTotal = ToInternalFormat($("#txtGrandTotal"));
            var amountRecieved = ToInternalFormat($("#txtAmountRecieved"));


        }

        function ChangeFormat() {
            //            document.getElementById('txtDiscount').value = format_number(document.getElementById('txtDiscount').value, 2);
            //            document.getElementById('txtAmountRecieved').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            //            document.getElementById('hdnAmountReceived').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            //            document.getElementById('txtTax').value = format_number(document.getElementById('txtTax').value, 2);
            //            
            document.getElementById('txtDiscount').value = format_number(ToInternalFormat($("#txtDiscount")), 2);
            document.getElementById('txtAmountRecieved').value = format_number(ToInternalFormat($("#txtAmountRecieved")), 2);
            document.getElementById('hdnAmountReceived').value = format_number(ToInternalFormat($("#txtAmountRecieved")), 2);
            document.getElementById('txtTax').value = format_number(ToInternalFormat($("#txtTax")), 2);

            ToTargetFormat($('#txtDiscount'));
            ToTargetFormat($('#txtAmountRecieved'));
            ToTargetFormat($('#hdnAmountReceived'));
            ToTargetFormat($('#txtTax'));


            //var gross = document.getElementById('txtGross').value;
            //var discount = document.getElementById('txtDiscount').value;

            var gross = ToInternalFormat($("#txtGross"));
            var discount = ToInternalFormat($("#txtDiscount"));

            if ((Number(gross)) < (Number(discount))) {
                document.getElementById('txtDiscount').value = "0.0";

                ToTargetFormat($('#txtDiscount'));

                totalCalculate();
                doCalcReimburse();
                SetOtherCurrValues();
                // document.getElementById('txtGrandTotal').value = document.getElementById('txtGross').value - document.getElementById('txtRecievedAdvance').value;
                alert('Discount Amount is greater than Gross value');
            }

        }
        function checkIsCredit() {

            if (document.getElementById('chkisCreditTransaction').checked == true) {
                // if (!document.getElementById('txtAmountRecieved').value > 0) {
                if (!ToInternalFormat($("#txtAmountRecieved")) > 0) {
                    document.getElementById('txtAmountRecieved').value = '0.00';
                    document.getElementById('hdnAmountReceived').value = '0.00';

                    ToTargetFormat($('#txtAmountRecieved'));
                    ToTargetFormat($('#hdnAmountReceived'));

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

                document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
                //alert(hdnSer<a href="PrintDischargeChkList.aspx">PrintDischargeChkList.aspx</a>viceCharge);
                document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2);
                document.getElementById('txtAmountRecieved').value = pAmt;
                document.getElementById('hdnAmountReceived').value = pAmt;
                var pTotal = Number(Number(sNetValue)) * Number(CurrRate);
                document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
                ToTargetFormat($('#txtServiceCharge'));
                ToTargetFormat($('#hdnServiceCharge'));
                ToTargetFormat($('#txtAmountRecieved'));
                ToTargetFormat($('#hdnAmountReceived'));
                ToTargetFormat($('#txtGrandTotal'));

                //                if (document.getElementById('chkisCreditTransaction').checked == true) {

                doCalcReimburse();
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

            ToTargetFormat($('#txtServiceCharge'));
            ToTargetFormat($('#hdnServiceCharge'));
            ToTargetFormat($('#txtAmountRecieved'));
            ToTargetFormat($('#hdnAmountReceived'));

            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

            //            var sNetValue = document.getElementById('txtGrandTotal').value;

            //document.getElementById('txtGrandTotal').value = format_number(Number(sNetValue) - Number(ServiceCharge), 2);
            document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
            ToTargetFormat($('#txtGrandTotal'));
            //            if (document.getElementById('chkisCreditTransaction').checked == true) {
            doCalcReimburse();
            //            }



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
                                                  , chkIsReImbursableItem, Flag, txtReimbursableAmount, txtNonReimbursableAmount, hdnOldNonReimbursableAmount, hdnOldReimbursableAmount, hdnEligibleRoomAmount, chkIsSelect) {
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
                                , chkIsReImbursableItem, Flag, txtReimbursableAmount, txtNonReimbursableAmount, hdnOldNonReimbursableAmount, hdnOldReimbursableAmount, hdnEligibleRoomAmount, chkIsSelect);
            changefrmdate(document.getElementById(lblFrom).value, document.getElementById(txtQuantity).value, document.getElementById(txtTo).value, roomtype);

        }
        function checkOptional(lblFrom, txtTo, txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                            hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                            txtRecievedAdvance, txtGrandTotal, hdnGross, isVariable, chkboxID, txtIndvDiscount, hdnDiscountArray,
                            hdnNonMedical
                                , lblNonReimbuse
                                , hdnMedical
                                , lblReimburse
                                , chkIsReImbursableItem, Flag, txtReimbursableAmount, txtNonReimbursableAmount, hdnOldNonReimbursableAmount, hdnOldReimbursableAmount, hdnEligibleRoomAmount, chkIsSelect) {

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
                                , chkIsReImbursableItem, Flag, txtReimbursableAmount, txtNonReimbursableAmount, hdnOldNonReimbursableAmount, hdnOldReimbursableAmount, hdnEligibleRoomAmount, chkIsSelect);
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
            // var sVal = Number(document.getElementById('txtTax').value);
            //var sGrand = format_number(Number(document.getElementById('txtGross').value) -
            //                                                    (Number(document.getElementById('txtDiscount').value)), 2);

            var sVal = Number(ToInternalFormat($("#txtTax")));
            var sGrand = format_number(Number(ToInternalFormat($("#txtGross"))) -
                                                    (Number(ToInternalFormat($("#txtDiscount")))), 2);

            document.getElementById('txtTax').value = format_number(sVal, 2);
            ToTargetFormat($('#txtTax'));

            //document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);
            document.getElementById('hdnTaxAmount').value = format_number(ToInternalFormat($("#txtTax")), 2);
            ToTargetFormat($('#hdnTaxAmount'));

            //var manualTaxPer = format_number(Number(document.getElementById('txtTax').value) / sGrand * 100, 2);
            var manualTaxPer = format_number(Number(ToInternalFormat($("#txtTax"))) / sGrand * 100, 2);

            document.getElementById('hdnManualTaxPercentage').value = format_number(manualTaxPer, 2);
            ToTargetFormat($('#hdnManualTaxPercentage'));
            totalCalculate();
            SetOtherCurrValues();
        }

        function chkTaxPayment(idval, dPercent) {
            if (count == 1) {
                document.getElementById('txtTax').value = 0;
                document.getElementById('hdnManualTaxPercentage').value = 0;

                ToTargetFormat($('#txtTax'));
                ToTargetFormat($('#hdnManualTaxPercentage'));
            }

            //var sVal = Number(document.getElementById('txtTax').value);
            //var sGrand = format_number(Number(document.getElementById('txtGross').value) -
            //                                                 (Number(document.getElementById('txtDiscount').value)), 2);

            var sVal = Number(ToInternalFormat($("#txtTax")));
            var sGrand = format_number(Number(ToInternalFormat($("#txtGross"))) -
                                                    (Number(ToInternalFormat($("#txtDiscount")))), 2);

            var sControl = document.getElementById(idval);
            var arrayAlready = new Array();
            var iCount = 0;
            var tSelectedData = "";

            if (sControl.checked == true) {
                sVal = sVal + (Number(sGrand) * Number(dPercent) / 100);

                document.getElementById('hdfTax').value += ">" + idval + "~" + dPercent;
                document.getElementById('txtTax').value = format_number(sVal, 2);
                ToTargetFormat($('#txtTax'));
                // document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);
                document.getElementById('hdnTaxAmount').value = format_number(ToInternalFormat($("#txtTax")), 2);
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
            }
            document.getElementById('txtTax').value = format_number(sVal, 2);
            ToTargetFormat($('#txtTax'));
            // document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);
            document.getElementById('hdnTaxAmount').value = format_number(ToInternalFormat($("#txtTax")), 2);
            ToTargetFormat($('#hdnTaxAmount'));

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
            //if (document.getElementById('txtDiscount').value > 0) {
            if (ToInternalFormat($("#txtDiscount")) > 0) {
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
            // var DiscountControl = document.getElementById('<%= txtDiscount.ClientID %>');
            var DiscountControl = ToInternalFormat($("#txtDiscount"));
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
        function doCalcExcessRent(txtReimbursableAmount, txtNonReimbursableAmount, hdnNonMedicalItem, lblNonReimbuse, hdnMedical, lblReimburse, chkSplitExcessRent) {
            var txtGridReimbursableAmount = document.getElementById(txtReimbursableAmount);
            var txtGridNonReimbursableAmount = document.getElementById(txtNonReimbursableAmount);

            var hdnNonMedical = document.getElementById(hdnNonMedicalItem);
            var lblNonMedical = document.getElementById(lblNonReimbuse);
            var hdnMedical = document.getElementById(hdnMedical);
            var lblMedical = document.getElementById(lblReimburse);

            var NonMedical = Number(hdnNonMedical.value);
            var Medical = Number(hdnMedical.value);

            var chkSplitExcessRentElt = document.getElementById(chkSplitExcessRent);
            if (chkSplitExcessRentElt.checked) {
                chkSplitExcessRentElt.checked = false;
                doCalcNonReimbursable(txtNonReimbursableAmount, hdnAmount, hdnNonMedicalItem, lblNonReimbuse, hdnMedical, lblReimburse, chkSplitExcessRent)
            }
        }

        function doCalcNonReimbursable(txtAmount, hdnAmount, hdnNonMedicalItem, lblNonReimbuse, hdnMedical, lblReimburse, nonReimburseChkBoxID, chkIsSelect) {
            //            if (document.getElementById('chkisCreditTransaction').checked == true) {
            // alert(document.getElementById(hdnNonMedicalItem).value);
            //alert(document.getElementById(hdnMedical).value);
            var txtGridAmount = document.getElementById(txtAmount);
            var gridChkBox = document.getElementById(nonReimburseChkBoxID);
            var hdnNonMedical = document.getElementById(hdnNonMedicalItem);
            var lblNonMedical = document.getElementById(lblNonReimbuse);

            var hdnMedical = document.getElementById(hdnMedical);
            var lblMedical = document.getElementById(lblReimburse);

            //var NonMedical = Number(hdnNonMedical.value);
            //var Medical = Number(hdnMedical.value);

            var NonMedical = Number(ToInternalFormat($('#' + hdnNonMedical.id)));
            var Medical = Number(ToInternalFormat($('#' + hdnMedical.id)));


            var txtNonMedical = document.getElementById('<%= txtNonMedical.ClientID %>');
            var txtAmountRecieved = document.getElementById('<%= txtAmountRecieved.ClientID %>');
            var txtPreviousDue = document.getElementById('<%= txtPreviousDue.ClientID %>');
            var txtServiceCharge = document.getElementById('<%= txtServiceCharge.ClientID %>');


            var chkIsSelect = document.getElementById(chkIsSelect);
            chkIsSelect.checked = true;
            //var Additional = Number(txtPreviousDue.value) + Number(txtServiceCharge.value);
            //NonMedical += Number(txtServiceCharge.value);
            var Additional = Number(ToInternalFormat($('#' + txtPreviousDue.id))) + Number(ToInternalFormat($('#' + txtServiceCharge.id)));
            NonMedical += Number(ToInternalFormat($('#' + txtServiceCharge.id)));

            if (gridChkBox.checked) {

                // NonMedical -= Number(txtGridAmount.value);
                NonMedical -= Number(ToInternalFormat($('#' + txtGridAmount.id)));
                hdnNonMedical.value = NonMedical;
                ToTargetFormat($('#' + hdnNonMedical.id));
                //lblNonMedical.innerHTML = parseFloat(Number(lblNonMedical.innerHTML) - Number(txtGridAmount.value)).toFixed(2);
                lblNonMedical.innerHTML = parseFloat(Number(ToInternalFormat($('#' + lblNonMedical.id))) - Number(ToInternalFormat($('#' + txtGridAmount.id)))).toFixed(2);
                ToTargetFormat($('#' + lblNonMedical.id));

                //hdnNonMedical.value = parseFloat(lblNonMedical.innerHTML).toFixed(2);
                hdnNonMedical.value = parseFloat(ToInternalFormat($('#' + lblNonMedical.id))).toFixed(2);
                ToTargetFormat($('#' + hdnNonMedical.id));
                // if (Number(txtGridAmount.value) < Number(txtNonMedical.value)) {
                //  if (Number(txtAmountRecieved.value) < NonMedical) {
                //      txtNonMedical.value = Number(txtNonMedical.value) - Number(txtGridAmount.value);
                if (Number(ToInternalFormat($('#' + txtGridAmount.id))) < Number(ToInternalFormat($('#' + txtNonMedical.id)))) {
                    if (Number(ToInternalFormat($('#' + txtAmountRecieved.id))) < NonMedical) {
                        txtNonMedical.value = Number(ToInternalFormat($('#' + txtNonMedical.id))) - Number(ToInternalFormat($('#' + txtGridAmount.id)));

                    }
                    else {
                        txtNonMedical.value = Number(NonMedical).toFixed(2);
                    }
                } else {
                    txtNonMedical.value = Number(0).toFixed(2);
                }
                ToTargetFormat($('#' + txtNonMedical.id));

                // Medical += Number(txtGridAmount.value);
                Medical += Number(ToInternalFormat($('#' + txtGridAmount.id)));
                hdnMedical.value = Medical;
                ToTargetFormat($('#' + hdnMedical.id));

                //lblMedical.innerHTML = parseFloat(Number(lblMedical.innerHTML) + Number(txtGridAmount.value)).toFixed(2);                
                lblMedical.innerHTML = parseFloat(Number(ToInternalFormat($('#' + lblMedical.id))) + Number(ToInternalFormat($('#' + txtGridAmount.id)))).toFixed(2);
                ToTargetFormat($('#' + lblMedical.id));

                //hdnMedical.value = parseFloat(lblMedical.innerHTML).toFixed(2);
                hdnMedical.value = parseFloat(ToInternalFormat($('#' + lblMedical.id))).toFixed(2);
                ToTargetFormat($('#' + hdnMedical.id));

            } else {

                // NonMedical += Number(txtGridAmount.value) ;
                NonMedical += Number(ToInternalFormat($('#' + txtGridAmount.id)));
                hdnNonMedical.value = NonMedical;
                ToTargetFormat($('#' + hdnNonMedical.id));

                // lblNonMedical.innerHTML = parseFloat(Number(lblNonMedical.innerHTML) + Number(txtGridAmount.value)).toFixed(2);
                lblNonMedical.innerHTML = parseFloat(Number(ToInternalFormat($('#' + lblNonMedical.id))) + Number(ToInternalFormat($('#' + txtGridAmount.id)))).toFixed(2);
                ToTargetFormat($('#' + lblNonMedical.id));

                //hdnNonMedical.value = parseFloat(lblNonMedical.innerHTML).toFixed(2);
                hdnNonMedical.value = parseFloat(ToInternalFormat($('#' + lblNonMedical.id))).toFixed(2);
                ToTargetFormat($('#' + hdnNonMedical.id));

                // if (Number(txtAmountRecieved.value) > (Number(txtNonMedical.value) + Number(txtGridAmount.value))) {
                if (Number(ToInternalFormat($('#' + txtAmountRecieved.id))) > (Number(ToInternalFormat($('#' + txtNonMedical.id))) + Number(ToInternalFormat($('#' + txtGridAmount.id))))) {
                    // txtNonMedical.value = Number(txtNonMedical.value) + Number(txtGridAmount.value);
                    txtNonMedical.value = Number(ToInternalFormat($('#' + txtNonMedical.id))) + Number(ToInternalFormat($('#' + txtGridAmount.id)));
                    ToTargetFormat($('#' + txtNonMedical.id));
                }
                else {
                    // txtNonMedical.value = Number(txtAmountRecieved.value).toFixed(2);
                    txtNonMedical.value = Number(ToInternalFormat($('#' + txtAmountRecieved.id))).toFixed(2);
                    ToTargetFormat($('#' + txtNonMedical.id));
                }

                //Medical -= Number(txtGridAmount.value);
                Medical -= Number(ToInternalFormat($('#' + txtGridAmount.id)));
                hdnMedical.value = Medical;
                ToTargetFormat($('#' + hdnMedical.id));

                // lblMedical.innerHTML = parseFloat(Number(lblMedical.innerHTML) - Number(txtGridAmount.value)).toFixed(2);
                lblMedical.innerHTML = parseFloat(Number(ToInternalFormat($('#' + lblMedical.id))) - Number(ToInternalFormat($('#' + txtGridAmount.id)))).toFixed(2);
                ToTargetFormat($('#' + lblMedical.id));

                //hdnMedical.value = parseFloat(lblMedical.innerHTML).toFixed(2);
                hdnMedical.value = parseFloat(ToInternalFormat($('#' + lblMedical.id))).toFixed(2);
                ToTargetFormat($('#' + hdnMedical.id));
            }
            //            }
            doCalcReimburse();
            //document.getElementById('lblNonReimbAmttxt').innerHTML = Math.floor(parseFloat(document.getElementById('lblNonReimbuse').innerHTML - document.getElementById('txtPreviousAmountPaid').value).toFixed(2));

            // var Totalpaid = parseFloat(parseFloat(document.getElementById('txtPreviousAmountPaid').value) + parseFloat(document.getElementById('txtThirdParty').value) + parseFloat(document.getElementById('txtRecievedAdvance').value) - parseFloat(document.getElementById('txtPreviousRefund').value)).toFixed(2);
            var Totalpaid = parseFloat(parseFloat(ToInternalFormat($("#txtPreviousAmountPaid"))) + parseFloat(ToInternalFormat($("#txtThirdParty"))) + parseFloat(ToInternalFormat($("#txtRecievedAdvance"))) - parseFloat(ToInternalFormat($("#txtPreviousRefund")))).toFixed(2);
            //var totalnonmedical = parseFloat(document.getElementById('lblNonReimbuse').innerHTML).toFixed(2);
            var totalnonmedical = parseFloat(ToInternalFormat($("#lblNonReimbuse"))).toFixed(2);
            //var Totalmedical = parseFloat(document.getElementById('lblReimburse').innerHTML).toFixed(2);
            var Totalmedical = parseFloat(ToInternalFormat($("#lblReimburse"))).toFixed(2);
            //var preauth = parseFloat(document.getElementById('lblPreAuthAmount').innerHTML).toFixed(2);
            var preauth = parseFloat(ToInternalFormat($("#lblPreAuthAmount"))).toFixed(2);
            //var Copaymentpercent = parseFloat(document.getElementById('txtCopercent').innerHTML).toFixed(2);
            var Copaymentpercent = parseFloat(ToInternalFormat($("#txtCopercent"))).toFixed(2);
            var Copaymentlogic = document.getElementById('hdnCopaymentlogic').value;
            // var Copaymentlogic = ToInternalFormat($("#hdnCopaymentlogic"));
            var ClaimDeductionLogic = document.getElementById('hdnDeductionLogic').value;
            // var ClaimDeductionLogic = ToInternalFormat($("#hdnDeductionLogic"));

            //var DiscountAmt = parseFloat(document.getElementById('txtDiscount').value).toFixed(2);
            var DiscountAmt = parseFloat(ToInternalFormat($("#txtDiscount"))).toFixed(2);

            //ShowCollectableAmount(Totalpaid, totalnonmedical, Totalmedical, preauth, Copaymentpercent, Copaymentlogic, ClaimDeductionLogic, DiscountAmt);
            ClientWiseDisplayed(Totalpaid, DiscountAmt);

        }
        function copayment() {
            // var txtCopercent = document.getElementById('txtCopercent').innerHTML;
            //var PreauthAMT = document.getElementById('lblPreAuthAmount').innerHTML;
            var txtCopercent = ToInternalFormat($("#txtCopercent"));
            var PreauthAMT = ToInternalFormat($("#lblPreAuthAmount"));
            var hdnMedical = document.getElementById('<%= hdnMedical.ClientID %>');
            //var lblPreAuthAmount = hdnMedical.value;
            var lblPreAuthAmount = ToInternalFormat($("#" + hdnMedical.id));
            var hdnCoPayment = document.getElementById("hdnCoPayment");
            var txtExcess = document.getElementById("txtExcess");
            var txtCoPayment = document.getElementById("txtCoPayment");

            var coPercentAmt;
            if (Number(txtCopercent) > 0) {
                if (PaymentLogic == 0) {
                    if (Number(PreauthAMT) < Number(lblPreAuthAmount)) {
                        coPercentAmt = (Number(PreauthAMT) * Number(txtCopercent)) / 100;
                    }
                    else {
                        coPercentAmt = (Number(lblPreAuthAmount) * Number(txtCopercent)) / 100;
                    }
                }
                else if (PaymentLogic == 1) {
                    coPercentAmt = (Number(lblPreAuthAmount) * Number(txtCopercent)) / 100;
                }
                else if (PaymentLogic == 2) {
                    coPercentAmt = (Number(PreauthAMT) * Number(txtCopercent)) / 100;
                }

                document.getElementById('lblCopayamenttxt').value = coPercentAmt;
            }
            else {
                document.getElementById('lblCopayamenttxt').value = "0.00";
            }

            ToTargetFormat($('#lblCopayamenttxt'));
        }

        function calcCopercent() {
            // var txtCopercent = document.getElementById('txtCopercent').innerHTML;
            // var PreauthAMT = document.getElementById('lblPreAuthAmount').innerHTML;
            var txtCopercent = ToInternalFormat($("#txtCopercent"));
            var PreauthAMT = ToInternalFormat($("#lblPreAuthAmount"));
            var hdnMedical = document.getElementById('<%= hdnMedical.ClientID %>');
            //var lblPreAuthAmount = hdnMedical.value;
            var lblPreAuthAmount = ToInternalFormat($("#" + hdnMedical.id));
            var hdnCoPayment = document.getElementById("hdnCoPayment");
            var txtExcess = document.getElementById("txtExcess");
            var txtCoPayment = document.getElementById("txtCoPayment");

            //if (!isNaN(txtCopercent) && txtCopercent != "" && Number(txtCopercent) > 0 && (Number(txtCoPayment.value) + Number(txtExcess.value)) > 0 && lblPreAuthAmount.trim() != "" && Number(lblPreAuthAmount) > 0) {
            if (!isNaN(txtCopercent) && txtCopercent != "" && Number(txtCopercent) > 0 && (Number(ToInternalFormat($("#" + txtCoPayment.id))) + Number(ToInternalFormat($("#" + txtExcess.id)))) > 0 && lblPreAuthAmount.trim() != "" && Number(lblPreAuthAmount) > 0) {

                //var sum = Number(txtExcess.value) + Number(txtCoPayment.value);
                var sum = Number(ToInternalFormat($("#" + txtExcess.id))) + Number(ToInternalFormat($("#" + txtCoPayment.id)));

                /* 
                Document for changes
                
                LogicID          LogicName
                -------          ----------
                0                Pre-Auth Amount (Preauthamt * Percentage)
                1                Billed Amount (BillAmt * Percentage)
                2                Pre-Auth Amount (Preauthamt * Percentage)
                 
                ADDED BY VENKAT 
                
                The Logic ID is in FinalBill table.
                Based on Above Login Copayment percentage amount will be calculated
                */

                var coPercentAmt;
                if (PaymentLogic == 0) {
                    if (Number(PreauthAMT) < Number(lblPreAuthAmount)) {
                        coPercentAmt = (Number(PreauthAMT) * Number(txtCopercent)) / 100;
                    }
                    else {
                        coPercentAmt = (Number(lblPreAuthAmount) * Number(txtCopercent)) / 100;
                    }
                }
                else if (PaymentLogic == 1) {
                    coPercentAmt = (Number(lblPreAuthAmount) * Number(txtCopercent)) / 100;
                }
                else if (PaymentLogic == 2) {
                    coPercentAmt = (Number(PreauthAMT) * Number(txtCopercent)) / 100;
                }

                if (Number(coPercentAmt) >= Number(sum)) {
                    hdnCoPayment.value = txtCoPayment.value = parseFloat(sum).toFixed(2);
                    txtExcess.value = parseFloat(0).toFixed(2);


                } else {
                    hdnCoPayment.value = txtCoPayment.value = parseFloat(coPercentAmt).toFixed(2);
                    txtExcess.value = parseFloat(Number(sum) - Number(coPercentAmt)).toFixed(2);
                }
                ToTargetFormat($('#' + hdnCoPayment.id));
                ToTargetFormat($('#' + txtCoPayment.id));
                ToTargetFormat($('#' + txtExcess.id));
            }
            else {
                document.getElementById('txtCoPayment').value = "0.00";
                ToTargetFormat($('#txtCoPayment'));
            }

            copayment();

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
            // hdnNonMedical.value = Number(document.getElementById('<%= lblNonReimbuse.ClientID%>').innerHTML);
            hdnNonMedical.value = Number(ToInternalFormat($('#<%= lblNonReimbuse.ClientID%>')));

            ToTargetFormat($('#' + hdnNonMedical.id));

            var prevServiceChg = document.getElementById('<%= hdnPrevServiceCharge.ClientID %>');

            //var pPreAuthAmount = Number(hdnMedical.value) + Number(txtServiceCharge.value) + Number(prevServiceChg.value);
            var pPreAuthAmount = Number(ToInternalFormat($('#' + hdnMedical.id))) + Number(ToInternalFormat($('#' + txtServiceCharge.id))) + Number(ToInternalFormat($('#' + prevServiceChg.id)));

            // var NonReimburseAmt = Number(hdnNonMedical.value) + Number(txtPreviousDue.value);
            var NonReimburseAmt = Number(ToInternalFormat($('#' + hdnNonMedical.id))) + Number(ToInternalFormat($('#' + txtPreviousDue.id)));

            //var AmtRecd = Number(txtAmountRecieved.value) + (Number(txtPreviousAmountPaid.value) + Number(txtRecievedAdvance.value)) - Number(txtPreviousRefund.value) - Number(txtRefundAmount.value);
            var AmtRecd = Number(ToInternalFormat($('#' + txtAmountRecieved.id))) + (Number(ToInternalFormat($('#' + txtPreviousAmountPaid.id))) + Number(ToInternalFormat($('#' + txtRecievedAdvance.id)))) - Number(ToInternalFormat($('#' + txtPreviousRefund.id))) - Number(ToInternalFormat($('#' + txtRefundAmount.id)));
            // var TpaPaidAmt = Number(txtThirdParty.value);
            var TpaPaidAmt = Number(ToInternalFormat($('#' + txtThirdParty.id)));

            pPreAuthAmount = TpaPaidAmt > 0 ? pPreAuthAmount - TpaPaidAmt : pPreAuthAmount;

            if (NonReimburseAmt > 0 && NonReimburseAmt < AmtRecd) {
                txtNonMedical.value = parseFloat(NonReimburseAmt).toFixed(2);
                txtCoPayment.value = parseFloat(AmtRecd - NonReimburseAmt).toFixed(2);

                ToTargetFormat($('#' + txtNonMedical.id));
                ToTargetFormat($('#' + txtCoPayment.id));


                //if (Number(txtCoPayment.value) > Number(pPreAuthAmount)) {
                if (Number(ToInternalFormat($('#' + txtCoPayment.id))) > Number(pPreAuthAmount)) {
                    //txtExcess.value = parseFloat(Number(txtCoPayment.value) - Number(pPreAuthAmount)).toFixed(2);
                    txtExcess.value = parseFloat(Number(ToInternalFormat($('#' + txtCoPayment.id))) - Number(pPreAuthAmount)).toFixed(2);
                    txtCoPayment.value = Number(pPreAuthAmount).toFixed(2);

                    ToTargetFormat($('#' + txtExcess.id));
                    ToTargetFormat($('#' + txtCoPayment.id));

                } else {
                    txtExcess.value = (0).toFixed(2);
                    ToTargetFormat($('#' + txtExcess.id));

                }

            } else if (NonReimburseAmt > 0 && NonReimburseAmt > AmtRecd) {

                txtNonMedical.value = parseFloat(AmtRecd).toFixed(2);
                txtCoPayment.value = (0).toFixed(2);
                txtExcess.value = (0).toFixed(2);

                ToTargetFormat($('#' + txtNonMedical.id));
                ToTargetFormat($('#' + txtCoPayment.id));
                ToTargetFormat($('#' + txtExcess.id));



            } else if (NonReimburseAmt == 0) {

                txtCoPayment.value = parseFloat(AmtRecd).toFixed(2);
                ToTargetFormat($('#' + txtCoPayment.id));

                //if (Number(txtCoPayment.value) > Number(pPreAuthAmount)) {
                if (Number(ToInternalFormat($('#' + txtCoPayment.id))) > Number(pPreAuthAmount)) {
                    //txtExcess.value = parseFloat(Number(txtCoPayment.value) - Number(pPreAuthAmount)).toFixed(2);
                    txtExcess.value = parseFloat(Number(ToInternalFormat($('#' + txtCoPayment.id))) - Number(pPreAuthAmount)).toFixed(2);
                    txtCoPayment.value = Number(pPreAuthAmount).toFixed(2);

                    ToTargetFormat($('#' + txtExcess.id));
                    ToTargetFormat($('#' + txtCoPayment.id));

                } else {
                    txtExcess.value = (0).toFixed(2);
                    ToTargetFormat($('#' + txtExcess.id));

                }
            }

            //            var CoPay = Number(txtCoPayment.value);
            //            var Excess = Number(txtExcess.value);
            //            var NonMedical = Number(txtNonMedical.value);
            //            var NetBill = Number(txtGrandTotal.value);

            var CoPay = Number(ToInternalFormat($('#' + txtCoPayment.id)));
            var Excess = Number(ToInternalFormat($('#' + txtExcess.id)));
            var NonMedical = Number(ToInternalFormat($('#' + txtNonMedical.id)));
            var NetBill = Number(ToInternalFormat($('#' + txtGrandTotal.id)));



            calcCopercent();
            // hdnNonMedical.value = NonMedical;
            //document.getElementById('<%= hdnCoPaymentFinal.ClientID %>').value = Number(txtCoPayment.value);
            //document.getElementById('<%= hdnExcess.ClientID %>').value = Number(txtExcess.value);
            document.getElementById('<%= hdnCoPaymentFinal.ClientID %>').value = Number(ToInternalFormat($('#' + txtCoPayment.id)));
            document.getElementById('<%= hdnExcess.ClientID %>').value = Number(ToInternalFormat($('#' + txtExcess.id)));

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


            ToTargetFormat($('#hdnCoPaymentFinal'));
            ToTargetFormat($('#hdnExcess'));


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
                                    <table border="0">
                                        <tr>
                                            <td align="center" width="40%">
                                                <label>
                                                    <asp:Label ID="Rs_MiscellaneousAmount" Text="Miscellaneous&Amount" runat="server"
                                                        meta:resourcekey="Rs_MiscellaneousAmountResource1"></asp:Label></label>
                                            </td>
                                            <td align="right" width="30%">
                                                <input id="btnAdd" type="button" class="dataheader1" style="width: 100px;" value="Add"
                                                    onclick="showModalPopup(event);" />
                                            </td>
                                            <td width="30%" align="right">
                                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                    meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="right">
                                    <asp:CheckBox ID="chkShowUnbilled" Text="Show Only unbilled items" AutoPostBack="True"
                                        runat="server" OnCheckedChanged="chkShowUnbilled_CheckedChanged" meta:resourcekey="chkShowUnbilledResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trRoomCharges" runat="server" style="display: none;">
                                <td colspan="3" align="left" style="height: 20px;">
                                    <b>
                                        <asp:Label ID="Rs_RoomCharges" Text="Room Charges" runat="server" meta:resourcekey="Rs_RoomChargesResource1"></asp:Label></b>
                                    <asp:HiddenField ID="hdn" runat="server" />
                                    <asp:HiddenField ID="hdnfrm" runat="server" />
                                    <asp:HiddenField ID="hdnroomtype" runat="server" />
                                </td>
                            </tr>
                            <tr class="dataheaderInvCtrl">
                                <td colspan="3" align="center">
                                    <asp:GridView ID="gvIndentRoomType" runat="server" GridLines="None" AutoGenerateColumns="False"
                                        OnRowDataBound="gvIndentRoomType_RowDataBound" Width="100%" OnRowCommand="gvIndentRoomType_RowCommand"
                                        meta:resourcekey="gvIndentRoomTypeResource1">
                                        <Columns>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource25">
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
                                                                <div id="divRoomDetails">
                                                                    <asp:GridView ID="gvIndentRoomDetails" runat="server" AutoGenerateColumns="False"
                                                                        OnRowDataBound="gvIndents_RowDataBound" Width="100%" meta:resourcekey="gvIndentRoomDetailsResource1">
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerStyle CssClass="dataheader1" />
                                                                        <Columns>
                                                                            <asp:BoundField HeaderText="ID" DataField="DetailsID" meta:resourcekey="BoundFieldResource17" />
                                                                            <asp:BoundField HeaderText="FeeType" DataField="FeeType" meta:resourcekey="BoundFieldResource18" />
                                                                            <asp:BoundField HeaderText="FeeID" DataField="FeeID" meta:resourcekey="BoundFieldResource19" />
                                                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource17">
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chkID" runat="server" Checked="True" Enabled="False" meta:resourcekey="chkIDResource2" />
                                                                                    <asp:Label ID="lblDescrip" runat="server" Text='<%# Eval("Description") %>' meta:resourcekey="lblDescripResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="From" meta:resourcekey="TemplateFieldResource18">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFrom" runat="server" Text='<%# Eval("FromDate","{0:dd/MM/yyyy hh:mm tt}") %>'
                                                                                        Visible="False" meta:resourcekey="lblFromResource1" />
                                                                                    <asp:TextBox ID="txtFrom" runat="server" Text='<%# Eval("FromDate","{0:dd/MM/yyyy hh:mm tt}") %>'
                                                                                        Width="130px" meta:resourcekey="txtFromResource1" />
                                                                                    <a runat="server" id="ahrImgBtnfrm">
                                                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                                    <asp:ImageButton ID="ImgBntCalcFrm" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                        CausesValidation="False" Style="display: none;" meta:resourcekey="ImgBntCalcFrmResource1" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="To" meta:resourcekey="TemplateFieldResource19">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblTo" runat="server" Text='<%# Eval("ToDate","{0:dd/MM/yyyy hh:mm tt}") %>'
                                                                                        Visible="False" meta:resourcekey="lblToResource1" />
                                                                                    <asp:Label ID="Comments" runat="server" Text='<%# Eval("Comments") %>' Visible="False"
                                                                                        meta:resourcekey="CommentsResource3"></asp:Label>
                                                                                    <asp:TextBox ID="txtTo" runat="server" Text='<%# Eval("ToDate","{0:dd/MM/yyyy hh:mm tt}") %>'
                                                                                        Width="130px" meta:resourcekey="txtToResource1" />
                                                                                    <a runat="server" id="ahrImgBtn">
                                                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                                    <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                        CausesValidation="False" Style="display: none;" meta:resourcekey="ImgBntCalcResource1" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="UnitPrice" meta:resourcekey="TemplateFieldResource20">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblComments" runat="server" Text='~' Style="display: none;" meta:resourcekey="lblCommentsResource3" />
                                                                                    <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                                                        Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                                                        meta:resourcekey="txtUnitPriceResource3"></asp:TextBox>
                                                                                    <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' runat="server" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource21">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                                        Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="30px"
                                                                                        meta:resourcekey="txtQuantityResource3"></asp:TextBox>
                                                                                    <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' runat="server" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource22">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                                                        Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" meta:resourcekey="txtAmountResource3"></asp:TextBox>
                                                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource20" />
                                                                            <asp:BoundField DataField="FromTable" HeaderText="From Table" meta:resourcekey="BoundFieldResource21" />
                                                                            <asp:TemplateField HeaderText="Discount" meta:resourcekey="TemplateFieldResource23">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtDiscount" runat="server" Style="text-align: right;" Text='<%# Eval("DiscountAmount") %>'
                                                                                          onkeypress="return ValidateOnlyNumeric(this);"   Width="60px" meta:resourcekey="txtDiscountResource4"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Eligible Room Rent" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtReimbursableAmount" runat="server" Enabled="false" Style="text-align: right;"
                                                                                        Text='<%#CalReimburse(Eval("unit"),Eval("Amount"),Eval("ReimbursableAmount")) %>'
                                                                                          onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"></asp:TextBox>
                                                                                    <asp:HiddenField ID="hdnOldReimbursableAmount" Value='<%#CalReimburse(Eval("unit"),Eval("Amount"),Eval("ReimbursableAmount")) %>'
                                                                                        runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Excess Room Rent" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtNonReimbursableAmount" runat="server" Enabled="false" Style="text-align: right;"
                                                                                        Text='<%# Eval("NonReimbursableAmount") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                        Width="60px"></asp:TextBox>
                                                                                    <asp:HiddenField ID="hdnOldNonReimbursableAmount" Value='<%# Eval("NonReimbursableAmount") %>'
                                                                                        runat="server" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                            <%--<asp:TemplateField HeaderText="Split Excess Rent"  Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkSplitExcessRent" runat="server" Checked="True"/>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>--%>
                                                                            <asp:TemplateField HeaderText="Is ReImbursable">
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" />
                                                                                    <asp:CheckBox ID="chkIsSelect" Style="display: none;" runat="server" Checked="false" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="lblClientID" runat="server" Text='<%# Eval("ClientID") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                                                        Style="display: none;"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
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
                                <td colspan="3" align="left" style="height: 35px">
                                    <div id="dvTreatmentCharges" runat="server">
                                        <b>
                                            <asp:Label ID="Rs_TreatmentCharges" Text="Treatment Charges" runat="server" meta:resourcekey="Rs_TreatmentChargesResource1"></asp:Label></b>
                                    </div>
                                </td>
                            </tr>
                            <tr class="dataheaderInvCtrl">
                                <td colspan="3" align="center">
                                    <div id="divIndentsitems">
                                        <asp:GridView ID="gvIndents" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvIndents1_RowDataBound"
                                            Width="100%" meta:resourcekey="gvIndentsResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <PagerStyle CssClass="dataheader1" />
                                            <Columns>
                                                <asp:BoundField HeaderText="ID" DataField="DetailsID" meta:resourcekey="BoundFieldResource1" />
                                                <asp:BoundField HeaderText="FeeType" DataField="FeeType" meta:resourcekey="BoundFieldResource2" />
                                                <asp:BoundField HeaderText="FeeID" DataField="FeeID" meta:resourcekey="BoundFieldResource3" />
                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%-- <asp:BoundField HeaderText="Description" DataField="Description" >
                                           
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </asp:BoundField>--%>
                                                <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="chkID" runat="server" Style="text-align: left;" Text='<%# Eval("Description") %>'
                                                            meta:resourcekey="chkIDResource1" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Service Code" meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtServiceCode" runat="server" Style="text-align: right;" Text='<%# Eval("ServiceCode") %>'
                                                            Width="60px" meta:resourcekey="txtServiceCodeResource1"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Comments" meta:resourcekey="TemplateFieldResource4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblComments" runat="server" Text='<%# Eval("Comments") %>' meta:resourcekey="lblCommentsResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%-- <asp:BoundField HeaderText="Comments" DataField="Comments" />--%>
                                                <asp:BoundField HeaderText="From Date" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                    meta:resourcekey="BoundFieldResource4">
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText="To" DataField="ToDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                    meta:resourcekey="BoundFieldResource5">
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Unit Price" meta:resourcekey="TemplateFieldResource5">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                            Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                            meta:resourcekey="txtUnitPriceResource1"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource6">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                            Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="40px"
                                                            meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource7">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                            Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnAmount" runat="server" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource6" />
                                                <asp:BoundField DataField="FromTable" HeaderText="From Table" meta:resourcekey="BoundFieldResource7" />
                                                <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource8">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtDiscount" runat="server" Style="text-align: right;" Text='<%# Eval("DiscountAmount") %>'
                                                              onkeypress="return ValidateOnlyNumeric(this);"   Width="60px" meta:resourcekey="txtDiscountResource1"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="Is ReImbursable"
                                                    meta:resourcekey="TemplateFieldResource9">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" meta:resourcekey="chkIsReImbursableItemResource1" />
                                                        <asp:CheckBox ID="chkIsSelect" Style="display: none;" runat="server" Checked="false" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Comments" Visible="false" meta:resourcekey="TemplateFieldResource10">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCommentsgvI" runat="server" Text='<%# Eval("Status") %>' meta:resourcekey="lblCommentsgvIResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ReimbursableAmount" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtReimbursableAmount" runat="server" Style="text-align: right;"
                                                            Text='<%# Eval("ReimbursableAmount") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                            Width="60px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="NonReimbursableAmount" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtNonReimbursableAmount" runat="server" Style="text-align: right;"
                                                            Text='<%# Eval("NonReimbursableAmount") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                            Width="60px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="lblClientID" runat="server" Text='<%# Eval("ClientID") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                            Style="display: none;"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="left" style="height: 35px;">
                                    <div id="dvpharmacy" runat="server">
                                        <asp:Label ID="Rs_Pharmacy" Text="Pharmacy" runat="server" meta:resourcekey="Rs_PharmacyResource1"></asp:Label></div>
                                </td>
                            </tr>
                            <tr class="dataheaderInvCtrl">
                                <td colspan="3" align="center">
                                    <div id="divMedicalItems">
                                        <asp:GridView ID="gvMedicalItems" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvPharmacy_RowDataBound"
                                            Width="100%" meta:resourcekey="gvMedicalItemsResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <PagerStyle CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:BoundField HeaderText="ID" DataField="DetailsID" meta:resourcekey="BoundFieldResource8" />
                                                <asp:BoundField HeaderText="FeeType" DataField="FeeType" meta:resourcekey="BoundFieldResource9" />
                                                <asp:BoundField HeaderText="FeeID" DataField="FeeID" meta:resourcekey="BoundFieldResource10" />
                                                <asp:BoundField HeaderText="Description" DataField="Description" meta:resourcekey="BoundFieldResource11" />
                                                <asp:BoundField HeaderText="Batch No" DataField="BatchNo" meta:resourcekey="BoundFieldResource12" />
                                                <asp:BoundField HeaderText="Expiry Date" DataFormatString="{0:MMM/yyyy }" DataField="ExpiryDate"
                                                    meta:resourcekey="BoundFieldResource13" />
                                                <asp:BoundField HeaderText="Date" DataField="FromDate" meta:resourcekey="BoundFieldResource14" />
                                                <asp:TemplateField HeaderText="Unit Price" meta:resourcekey="TemplateFieldResource11">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblComments" Visible="False" runat="server" meta:resourcekey="lblCommentsResource2" />
                                                        <asp:HiddenField runat="server" ID="hdnphyDate" Value='<%# bind("FromDate") %>' />
                                                        <asp:TextBox ID="txtUnitPrice" Style="text-align: right;" runat="server" MaxLength="10"
                                                            Text='<%# Eval("AMOUNT") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                            meta:resourcekey="txtUnitPriceResource2"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnOldPrice" Value='<%# Eval("AMOUNT") %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource12">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                            Text='<%# Eval("unit") %>'   onkeypress="return ValidateOnlyNumeric(this);"   Width="40px"
                                                            meta:resourcekey="txtQuantityResource2"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnOldQuantity" Value='<%# Eval("unit") %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource13">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                            Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" meta:resourcekey="txtAmountResource2"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnAmount" runat="server" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource15" />
                                                <asp:TemplateField HeaderText="Discount" ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource14">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtDiscount" runat="server" Style="text-align: right;" Text='<%# Eval("DiscountAmount") %>'
                                                              onkeypress="return ValidateOnlyNumeric(this);"   Width="60px" meta:resourcekey="txtDiscountResource2"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="IsReImbursable" meta:resourcekey="TemplateFieldResource15">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkIsReImbursableItem" runat="server" Checked="True" meta:resourcekey="chkIsReImbursableItemResource2" />
                                                        <asp:CheckBox ID="chkIsSelect" Style="display: none;" runat="server" Checked="false" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Comments" Visible="false" meta:resourcekey="TemplateFieldResource16">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCommentsgvMI" runat="server" Text='<%# Eval("Status") %>' meta:resourcekey="lblCommentsgvMIResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="FromTable" HeaderText="From Table" meta:resourcekey="BoundFieldResource16" />
                                                <asp:TemplateField HeaderText="ReimbursableAmount" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtReimbursableAmount" runat="server" Style="text-align: right;"
                                                            Text='<%# Eval("ReimbursableAmount") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                            Width="60px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="NonReimbursableAmount" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtNonReimbursableAmount" runat="server" Style="text-align: right;"
                                                            Text='<%# Eval("NonReimbursableAmount") %>'  onkeypress="return ValidateOnlyNumeric(this);" 
                                                            Width="60px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="lblClientID" runat="server" Text='<%# Eval("ClientID") %>'   onkeypress="return ValidateOnlyNumeric(this);"  
                                                            Style="display: none;"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="padding-top: 10px;">
                                    <table cellpadding="3" cellspacing="0" border="0" class="dataheaderInvCtrl"
                                        width="100%">
                                        <tr>
                                            <td rowspan="7" valign="top">
                                                <div style="display: none;">
                                                    <b>
                                                        <asp:Label ID="Rs_NonReImbursableItems" Text="Non-ReImbursable Items" runat="server"
                                                            meta:resourcekey="Rs_NonReImbursableItemsResource1"></asp:Label>
                                                        <asp:Label ID="Rs_MedicalItems" Text="MedicalItems" runat="server" meta:resourcekey="Rs_MedicalItemsResource1"></asp:Label>
                                                        <asp:Label ID="lblNonReimbuse" runat="server" Text="0.00" meta:resourcekey="lblNonReimbuseResource1"></asp:Label>
                                                        <asp:Label ID="lblReimburse" runat="server" Text="0.00" meta:resourcekey="lblReimburseResource1"></asp:Label>
                                                    </b>
                                                </div>
                                                <div id="divValues" runat="server" style="display: block; height: 200px; width: 700px;
                                                    overflow: auto;">
                                                    <asp:GridView ID="gvClientName" runat="server" AutoGenerateColumns="False" Width="100%"
                                                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="Dashed" BorderWidth="1px"
                                                        CellPadding="2" Font-Names="Verdana" Font-Size="8pt" GridLines="Both">
                                                        <RowStyle VerticalAlign="Top" ForeColor="#000066" />
                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Client Name">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="lblClientID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ClientID") %>'
                                                                        Style="display: none;"></asp:TextBox>
                                                                    <asp:Label ID="lblCopPercent" Text='<%# DataBinder.Eval(Container.DataItem, "CopaymentPercent") %>'
                                                                        runat="server" Style="display: none;"> </asp:Label>
                                                                    <asp:Label ID="lblCopaymentlogic" Text='<%# DataBinder.Eval(Container.DataItem, "Copaymentlogic") %>'
                                                                        runat="server" Style="display: none;"> </asp:Label>
                                                                    <asp:Label ID="lblClaimLogic" Text='<%# DataBinder.Eval(Container.DataItem, "ClaimLogic") %>'
                                                                        runat="server" Style="display: none;"> </asp:Label>
                                                                    <asp:Label ID="lblClientName" Text='<%# DataBinder.Eval(Container.DataItem, "ClientName") %>'
                                                                        runat="server">
                                                                    </asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Non-ReImbursable Items">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblNonMedicalAmount" Text='<%# DataBinder.Eval(Container.DataItem, "NonMedicalAmount") %>'
                                                                        runat="server"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Medical Items">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblMedicalAmount" Text="" runat="server"> </asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Pre-Auth Amount">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPreAuthAmount" Text='<%# DataBinder.Eval(Container.DataItem, "PreAuthAmount") %>'
                                                                        runat="server"> </asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Copay-Logic">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblCopaymentValue" Text="" runat="server"> </asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Actual Co-Pay Amount">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblCoPaymentAmount" Text="" runat="server"> </asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Towards Non Reimbursable Items">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblTowardsNonMedical" Text="" runat="server"> </asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Towards Co-Pay">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblTowardsCoPay" Text="" runat="server"> </asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Towards Pre-Auth and Medical">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPreandMedical" Text="" runat="server"> </asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                            <%-- <td width="22%">
                                                &nbsp;
                                            </td>--%>
                                            <td width="50%" align="right">
                                                <asp:Label ID="lblGross" runat="server" Text="Gross Bill Amount" class="defaultfontcolor"
                                                    meta:resourcekey="lblGrossResource1" />&nbsp;<span style="color: Red;"><asp:Label
                                                        ID="Rs_X" Text="(X)" runat="server" meta:resourcekey="Rs_XResource1"></asp:Label></span>
                                            </td>
                                            <td width="20%" align="right" class="details_value">
                                                <asp:HiddenField ID="hdnGross" runat="server" />
                                                <asp:TextBox ID="txtGross" runat="server" Text="0.00" TabIndex="1" CssClass="Txtboxsmall"
                                                    Enabled="False" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                                <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <table border="0">
                                                    <tr>
                                                        <td align="right" valign="top">
                                                            &nbsp;
                                                            <label id="tdDiscountLabel" runat="server">
                                                                <asp:Label ID="Rs_SelecttheDiscount" Text="Select the Discount" runat="server" meta:resourcekey="Rs_SelecttheDiscountResource1"></asp:Label></label>
                                                        </td>
                                                        <td align="left" valign="top">
                                                            &nbsp;<asp:DropDownList ID="ddDiscountPercent" ToolTip="Select the Discount" onChange="javascript:setDiscount();"
                                                                runat="server" meta:resourcekey="ddDiscountPercentResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblDiscount" runat="server" Text="Discount" class="defaultfontcolor"
                                                                meta:resourcekey="lblDiscountResource1" />&nbsp;<span style="color: Red;"><asp:Label
                                                                    ID="Rs_A" Text="(A)" runat="server" meta:resourcekey="Rs_AResource1"></asp:Label></span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtDiscount" runat="server" TabIndex="4" onkeyup="javascript:CorrectTotal();totalCalculate();"
                                                    Text="0.00" CssClass="Txtboxsmall" onblur="AddDiscountsCheck();ChangeFormat();totalCalculate(); ValidateDiscountReason();doCalcReimburse();"
                                                      onkeypress="return ValidateOnlyNumeric(this);"   />
                                            </td>
                                        </tr>
                                        <tr id="trDiscountReason" runat="server">
                                            <td align="right">
                                                <asp:Label ID="Label1" runat="server" Text="Reason for Discount" class="defaultfontcolor"
                                                    meta:resourcekey="Label1Resource1" />
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtDiscountReason" runat="server" TabIndex="5" CssClass="Txtboxsmall"
                                                    meta:resourcekey="txtDiscountReasonResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top">
                                                <asp:Label ID="Rs_Tax" Text="Tax" runat="server" meta:resourcekey="Rs_TaxResource1"></asp:Label><span
                                                    style="color: Red;">(B)</span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtTax" runat="server" CssClass="Txtboxsmall" Onchange="return CalcTax();"
                                                    meta:resourcekey="txtTaxResource1"></asp:TextBox>
                                                <asp:HiddenField ID="hdfTax" runat="server" />
                                                <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnManualTaxPercentage" runat="server" Value="0" />
                                                <div id="dvTaxDetails" align="left" runat="server" class="dataheaderInvCtrl">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr style="display: none;">
                                            <td align="right">
                                                <asp:Label ID="Rs_PreviousDue" Text="Previous Due" runat="server" meta:resourcekey="Rs_PreviousDueResource1"></asp:Label>&nbsp;<span
                                                    style="color: Red;">(C)</span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtPreviousDue" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtPreviousDueResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <img alt="" onclick="ChangeImage();" src="../Images/collapse.jpg" style="display: none;"
                                                    id="imgDue" />
                                                <a id="A1" href="javascript:animatedcollapse.toggle('Due');" runat="server" style="color: Black;
                                                    font-size: 11; text-decoration: underline;">
                                                    <asp:Label ID="Rs_ShowHideDueDetails" Text="Show/Hide Due Details" runat="server"
                                                        meta:resourcekey="Rs_ShowHideDueDetailsResource1"></asp:Label>
                                                </a>
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
                                                <asp:Label ID="Rs_ServiceChargePaid" Text="Service Charge Paid" runat="server" meta:resourcekey="Rs_ServiceChargePaidResource1"></asp:Label>&nbsp;<span
                                                    style="color: Red;">(C)</span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtPrevServiceCharge" runat="server" Text="0.00" Enabled="False"
                                                    TabIndex="6" CssClass="Txtboxsmall" meta:resourcekey="txtPrevServiceChargeResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td rowspan="12" valign="middle">
                                                <table border="1" id="tdMiniCreditbill" runat="server" style="width: 100%; height: 132px;
                                                    border-color: Red; display: none">
                                                    <tr>
                                                        <td colspan="2" align="center">
                                                            <b>Break-up for amount to be received</b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 80%;" align="left">
                                                            <asp:Label ID="lblNonReimbAmt" Text="Towards NonReimbursable Item" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%;" align="right">
                                                            <asp:Label ID="lblNonReimbAmttxt" Text="0.00" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="lblCopayament" Text="Towards Co-Payment" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblCopayamenttxt" Text="0.00" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="lblPreAuthAmt" Text="Towards Difference between Pre-Auth & Medical Items"
                                                                runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblPreAuthAmttxt" Text="0.00" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="lblTotal" Text="Total" runat="server" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="lblTotaltxt" Text="0.00" runat="server" Font-Bold="true"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="right">
                                                <b>
                                                    <asp:Label ID="Rs_AmountPaid" Text="Amount Paid" runat="server" meta:resourcekey="Rs_AmountPaidResource1"></asp:Label>
                                                </b>
                                                <asp:Label ID="Rs_IncludesServiceCharges" Text="(Includes Service Charges)" runat="server"
                                                    meta:resourcekey="Rs_IncludesServiceChargesResource1"></asp:Label>&nbsp;<span style="color: Red;">(D)</span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtPreviousAmountPaid" runat="server" Text="0.00" Enabled="False"
                                                    TabIndex="6" CssClass="Txtboxsmall" meta:resourcekey="txtPreviousAmountPaidResource1" />
                                            </td>
                                        </tr>
                                        <tr id="trAmountFromTPA" runat="server">
                                            <td align="right">
                                                <asp:Label ID="tpaDetails" Text="Amount Paid by TPA(Includes Service Charges)" runat="server"
                                                    meta:resourcekey="tpaDetailsResource1"></asp:Label>
                                                &nbsp;<span style="color: Red;"><asp:Label ID="Rs_F" Text="(E)" runat="server" meta:resourcekey="Rs_FResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtThirdParty" runat="server" Text="0.00" TabIndex="6" CssClass="Txtboxsmall"
                                                    meta:resourcekey="txtThirdPartyResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <b>
                                                    <asp:Label ID="Rs_AdvanceReceived" Text="Advance Received" runat="server" meta:resourcekey="Rs_AdvanceReceivedResource1"></asp:Label>
                                                </b>
                                                <asp:Label ID="Rs_IncludesSurgerypaymentsandServiceCharges" Text="(Includes Surgery payments and Service Charges)"
                                                    runat="server" meta:resourcekey="Rs_IncludesSurgerypaymentsandServiceChargesResource1"></asp:Label><span
                                                        style="color: Red;"><asp:Label ID="Rs_G" Text="(F)" runat="server" meta:resourcekey="Rs_GResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtRecievedAdvance" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtRecievedAdvanceResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label><span
                                                    style="color: Red;">
                                                    <asp:Label ID="Rs_H" Text="(G)" runat="server" meta:resourcekey="Rs_HResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtServiceCharge" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtServiceChargeResource1" />
                                                <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                <asp:HiddenField ID="hdnPrevServiceCharge" runat="server" Value="0" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="Rs_RoundOffAmount" Text="Round Off Amount" runat="server" meta:resourcekey="Rs_RoundOffAmountResource1"></asp:Label><span
                                                    style="color: Red;"> (H)</span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtRoundOff" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                                    CssClass="Txtboxsmall" meta:resourcekey="txtRoundOffResource1" />
                                                <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="lblGrandTotal" Style="color: Red" runat="server" Font-Bold="true"
                                                    Text="Net Payable Amount" class="defaultfontcolor" meta:resourcekey="lblGrandTotalResource1" />
                                                &nbsp;<span style="color: Red;"><asp:Label ID="Rs_Info" Text="(X+B+C+G+H)-((A+D+E+F) - I)"
                                                    runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label></span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtGrandTotal" Text="0" BackColor="DarkRed" Font-Bold="true" Style="font-weight: 400;
                                                    border-style: solid; border-width: 1px; border-color: Red;" Enabled="False" runat="server"
                                                    TabIndex="8" CssClass="Txtboxsmall" meta:resourcekey="txtGrandTotalResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="Rs_AmountRefunded" Font-Bold="true" Text="Amount Refunded" runat="server"
                                                    meta:resourcekey="Rs_AmountRefundedResource1"></asp:Label><span style="color: Red;">
                                                        (I)</span>
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtPreviousRefund" runat="server" Style="border-style: dashed; border-width: 1px;
                                                    border-color: Red;" TabIndex="8" Enabled="False" CssClass="Txtboxsmall" meta:resourcekey="txtPreviousRefundResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="Rs_AmounttoRefund" Style="color: Red" Font-Bold="true" Text="Amount to Refund"
                                                    runat="server" meta:resourcekey="Rs_AmounttoRefundResource1"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <%--<asp:CheckBox ID="ChkRefund" runat="server" Text="Yes" 
                                                    onClick="javascript:funcRefundChk();RefundExcess();" 
                                                    meta:resourcekey="ChkRefundResource1" />
                                                --%>
                                                <%-- RefundExcess function comment by suresh --%>
                                                <asp:CheckBox ID="ChkRefund" runat="server" Text="Yes" onClick="javascript:funcRefundChk();"
                                                    meta:resourcekey="ChkRefundResource1" />
                                                <asp:TextBox ID="txtRefundAmount" BackColor="DarkRed" runat="server" ForeColor="White"
                                                    Style="border-style: solid; border-width: 1px; border-color: Red;" TabIndex="8"
                                                    onkeyup="javascript:AmountRefundCheck();" Text="0.00" CssClass="Txtboxsmall"
                                                    onblur="AmountRefundCheck();"   onkeypress="return ValidateOnlyNumeric(this);"   meta:resourcekey="txtRefundAmountResource1" />
                                                <asp:HiddenField ID="hdnRefundAmt" Value="0" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div id="dvRefund" style="display: none">
                                                    <asp:Label ID="Rs_ReasonforRefund" Text="Reason for Refund" runat="server" meta:resourcekey="Rs_ReasonforRefundResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="reasonforRefund" style="display: none">
                                                    <asp:TextBox ID="txtReasonForRefund" runat="server" TabIndex="8" MaxLength="150"
                                                        CssClass="textBoxRightAlign" meta:resourcekey="txtReasonForRefundResource1" /></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div id="refundmode" style="display: none;">
                                                    <asp:Label ID="Rs_RefundMode" Text="Refund Mode" runat="server" meta:resourcekey="Rs_RefundModeResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="PayMode" style="display: none;">
                                                    <asp:DropDownList ID="ddlPayMode" runat="server" onchange="javascript:showHide(this.value);"
                                                        meta:resourcekey="ddlPayModeResource1">
                                                        <asp:ListItem Value="0" meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>
                                                        <asp:ListItem Value="1" meta:resourcekey="ListItemResource2">Cash</asp:ListItem>
                                                        <asp:ListItem Value="2" meta:resourcekey="ListItemResource3">Cheque</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="tdBankName" align="right">
                                                <div id="banknametxt" style="display: none;">
                                                    <asp:Label Text="Bank Name" runat="server" ID="lblBankName" meta:resourcekey="lblBankNameResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="bankname" style="display: none;">
                                                    <asp:TextBox ID="txtBankName" runat="server" MaxLength="150" CssClass="textBoxRightAlign"
                                                        meta:resourcekey="txtBankNameResource1"></asp:TextBox>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="tdCheque" align="right">
                                                <div id="CardNo" style="display: none;">
                                                    <asp:Label ID="lblCardNo" runat="server" Text="Cheque Number" meta:resourcekey="lblCardNoResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="CardNotxt" style="display: none;">
                                                    <asp:TextBox ID="txtCardNo" runat="server" MaxLength="150" CssClass="textBoxRightAlign"
                                                        meta:resourcekey="txtCardNoResource1"></asp:TextBox>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr runat="server" id="trNonReimburse">
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <div id="Div1" style="display: block">
                                                    <asp:Label ID="Rs_PaidAgainstNonMedicalItems" Text="Paid Against Non-MedicalItems"
                                                        runat="server" meta:resourcekey="Rs_PaidAgainstNonMedicalItemsResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="Div2" style="display: block">
                                                    <asp:TextBox ID="txtNonMedical" Enabled="False" runat="server" TabIndex="8" MaxLength="150"
                                                        Text="0.00" CssClass="Txtboxsmall" onblur="javascript:getPrecision(this);"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                        meta:resourcekey="txtNonMedicalResource1" /></div>
                                            </td>
                                        </tr>
                                        <tr runat="server" id="trCoPayment">
                                            <td>
                                            </td>
                                            <td align="right">
                                                &nbsp;
                                                <asp:Label ID="lblCopayment" runat="server" Text="Adjusted towards Co-Payment" />
                                            </td>
                                            <td align="right">
                                                <%-- <table border="1" align="right">
                                                    <tr>
                                                        <td align="right">--%>
                                                <%--</td>
                                                    </tr>
                                                </table>--%>
                                                <asp:TextBox ID="txtCoPayment" runat="server" TabIndex="8" MaxLength="150" Text="0.00"
                                                    CssClass="Txtboxsmall" onblur="javascript:getPrecision(this);customCoPayment();"
                                                    onfocus="javascript:prepareCopayment();"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                    meta:resourcekey="txtCoPaymentResource1" />
                                            </td>
                                            <td align="right">
                                                <div id="Div4" style="display: block">
                                                    <input type="hidden" value="0.00" id="hdnCoPayment" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr runat="server" id="trExcess">
                                            <td>
                                            </td>
                                            <td align="right">
                                                &nbsp;
                                                <asp:Label ID="Rs_ExcessAmountReceived" Text="Excess Amount Received" runat="server"
                                                    meta:resourcekey="Rs_ExcessAmountReceivedResource1"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <div id="Div5" style="display: block">
                                                    <asp:TextBox ID="txtExcess" Enabled="False" runat="server" TabIndex="8" MaxLength="150"
                                                        Text="0.00" CssClass="Txtboxsmall"   onkeypress="return ValidateOnlyNumeric(this);"   meta:resourcekey="txtExcessResource1" />
                                                </div>
                                            </td>
                                            <td align="right">
                                                <div id="Div6" style="display: block">
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
                                                        CssClass="textBoxRightAlign"    onkeypress="return ValidateOnlyNumeric(this);"    />
                                                </div>
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td>
                                            </td>
                                            <td align="right">
                                                &nbsp;
                                                <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Received" class="defaultfontcolor"
                                                    meta:resourcekey="lblAmountRecievedResource1" />
                                            </td>
                                            <td align="right">
                                                <asp:TextBox ID="txtAmountRecieved" runat="server" TabIndex="9" ReadOnly="True" CssClass="Txtboxsmall"
                                                    meta:resourcekey="txtAmountRecievedResource1" />
                                                <asp:HiddenField ID="hdnAmountReceived" runat="server" />
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
                                                <asp:Label ID="Label2" runat="server" Text="Pre Authorization Amount :" Font-Bold="True"
                                                    meta:resourcekey="Label2Resource1"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblPreAuthAmount" Text="0.00" runat="server" Font-Underline="true"
                                                    Font-Bold="True" meta:resourcekey="lblPreAuthAmountResource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trCoPaymentinfo" runat="server" style="display: none;">
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblCopaymentAmtofPercent" Text="Co-Payment @" runat="server" Font-Bold="True"></asp:Label>
                                                <asp:Label ID="txtCopercent" runat="server" Font-Underline="true" Font-Bold="True"></asp:Label>
                                                <asp:Label ID="Label3" Text=" %" runat="server" Font-Bold="True"></asp:Label>
                                                <asp:Label ID="lblOn" Text=" On " runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblCopaymentLogic" Font-Underline="true" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trActualCopayment" runat="server" style="display: none;">
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblActualCopayment" Text="Actual Co-Payment Amount :" runat="server"
                                                    Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblActualCopaymenttxt" Font-Underline="true" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="bottom">
                                                <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                            </td>
                                            <td align="center" colspan="2">
                                                <div>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:CheckBox onclick="javascript:ShowHideButton()" runat="server" ID="chkDischarge"
                                                                    Text="Discharge Patient" Font-Bold="True" meta:resourcekey="chkDischargeResource1" />
                                                            </td>
                                                            <td>
                                                                &nbsp;<asp:TextBox ID="txtDischargeDate" runat="server" ToolTip="Discharge Date"
                                                                    CssClass="Txtboxsmall" meta:resourcekey="txtDischargeDateResource1"></asp:TextBox>
                                                                <img onclick="return CheckDischarge()" style="cursor: hand;" id="imgdischarge" src="../Images/Calendar_scheduleHS.png"
                                                                    width="16" height="16" border="0" alt="Pick a date" />
                                                            </td>
                                                            <td id="tdChangeBillDate" style="display: none;" runat="server">
                                                                &nbsp;<asp:Label ID="lblBilldate" runat="server" Text="BillDate"></asp:Label>
                                                                &nbsp;<asp:TextBox ID="txtBillDate" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                <img onclick="return chkbilldate()" style="cursor: hand;" id="imgbildate" src="../Images/Calendar_scheduleHS.png"
                                                                    width="16" height="16" border="0" alt="Pick a date" />
                                                            </td>
                                                            <td align="right" id="tdChkisCredit" runat="server">
                                                                <asp:CheckBox ID="chkisCreditTransaction" Text="Credit Transaction" runat="server"
                                                                    class="defaultfontcolor" onclick="checkIsCredit();" meta:resourcekey="chkisCreditTransactionResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="display: none;" id="trPaymentControl" runat="server">
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
                                                <asp:Button ID="btnSave" runat="server" Text="Generate Bill" Style="display: none;"
                                                    CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    OnClientClick="return CheckBilling(this.id);" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnSaveTemp" runat="server" Text="Save Bill" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClientClick="return CheckBilling(this.id);"
                                                    OnClick="btnSaveBill_Click" meta:resourcekey="btnSaveTempResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnClose" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" Text="Close" OnClick="btnClose_Click" meta:resourcekey="btnCloseResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlOthers" runat="server" Style="display: none;" CssClass="modalPopup dataheaderPopup"
                            meta:resourcekey="pnlOthersResource1">
                            <center>
                                <div id="divOthers" style="width: 350px; height: 200px; padding-top: 5px; padding-left: 15px">
                                    <table width="90%" align="center">
                                        <tr style="display: none;">
                                            <td>
                                                <uc16:CreditLimt ID="ucCreditLimit" runat="server" />
                                            </td>
                                        </tr>
                                        <tr id="trAllowableDue" align="left" runat="server" style="display: none;">
                                            <td>
                                                <asp:HiddenField ID="hdnNeedOrgCreditLimit" runat="server" Value="N" />
                                                <asp:HiddenField ID="hdnPortTrust" runat="server" Value="N" />
                                                <asp:Label Font-Bold="true" ID="lblAllowDue" Text="Allowable Due" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblAllowDuetxt" runat="server"></asp:Label>
                                            </td>
                                        </tr>
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
                                                <asp:TextBox ID="txtAmnt" runat="server"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                    meta:resourcekey="txtAmntResource1"></asp:TextBox>
                                                <%--onblur="if(this.value!='')this.value=parseFloat(this.value).toFixed(2);" --%>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td>
                                                <label id="Label4" style="width: 155px;">
                                                    <asp:Label ID="lblDate" Text="Date" runat="server"></asp:Label></label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFromCF" runat="server" Width="150px" />
                                                <img onclick="return datePick('txtFromCF')" style="cursor: hand;" id="img1" src="../Images/Calendar_scheduleHS.png"
                                                    width="16" height="16" border="0" alt="Pick a date" />
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
                            PopupControlID="pnlOthers" CancelControlID="btnCancel" TargetControlID="hiddenTargetControlFormpeOthers"
                            DynamicServicePath="" Enabled="True">
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
                        <asp:HiddenField ID="hdnEligibleRoomAmount" runat="server" />
                        <asp:HiddenField ID="hdnPaymentLogic" runat="server" />
                        <asp:HiddenField ID="hdnTotalpaid" runat="server" />
                        <asp:HiddenField ID="hdntotalnonmedical" runat="server" />
                        <asp:HiddenField ID="hdnTotalmedical" runat="server" />
                        <asp:HiddenField ID="hdnpreauth" runat="server" />
                        <asp:HiddenField ID="hdnCopaymentpercent" runat="server" />
                        <asp:HiddenField ID="hdnCopaymentlogic" runat="server" />
                        <asp:HiddenField ID="hdnDeductionLogic" runat="server" />
                        <asp:HiddenField ID="hdnReimburseTxtIds" runat="server" />
                        <asp:HiddenField ID="hdnNonReimburseTxtIds" runat="server" />
                        <asp:HiddenField ID="hdnReimburseRoomRent" runat="server" />
                        <asp:HiddenField ID="hdnNonReimburseRoomRent" runat="server" />
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
    <asp:HiddenField ID="hdnMessages" runat="server" Value="" />

    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

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
                        //                        document.getElementById('txtDiscount').value =(((parseFloat(document.getElementById('txtDiscount').value) / parseFloat(document.getElementById('txtGross').value)) * 100) + (parseFloat(document.getElementById('txtGross').value) / 100) * parseFloat(k[0])).toFixed(2);
                        //                        document.getElementById('lblDiscount').innerText = " Discount %";
                        //                        document.getElementById('trDiscountReason').style.display = "block";
                    }
                    else {

                        // if ((l == 0) && (document.getElementById('txtDiscount').value != "" || document.getElementById('txtDiscount').value != "0.00")) {
                        if ((l == 0) && (document.getElementById('txtDiscount').value != "" || ToInternalFormat($("#txtDiscount")) != "0.00")) {

                            l++;
                            //document.getElementById('txtDiscount').value = parseFloat(document.getElementById('txtDiscount').value).toFixed(2) + parseFloat(k[0]).toFixed(2);
                            document.getElementById('txtDiscount').value = parseFloat(ToInternalFormat($("#txtDiscount"))).toFixed(2) + parseFloat(k[0]).toFixed(2);

                            ToTargetFormat($('#txtDiscount'));

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
            if (document.getElementById('<%=hdnNeedOrgCreditLimit.ClientID %>').value == "Y")
                document.getElementById('<%=trAllowableDue.ClientID %>').style.display = "block";
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
            //if (document.getElementById("txtAmnt").value.trim() == "" || Number(document.getElementById("txtAmnt").value) == 0) {
            if (document.getElementById("txtAmnt").value.trim() == "" || Number(ToInternalFormat($("#txtAmnt"))) == 0) {
                alert("Please Enter Fee Amount");
                document.getElementById("txtAmnt").focus();
                return false;
            }
            if (document.getElementById("txtFromCF").value.trim() == "") {
                alert("Please Enter Date");
                return false
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
            if (document.getElementById('hdnNeedOrgCreditLimit').value == "Y" && document.getElementById('hdnPortTrust').value == "N") {
                //var amt = document.getElementById("txtAmnt").value;
                //var allowedamt = document.getElementById('lblAllowDuetxt').innerHTML;

                var amt = ToInternalFormat($("#txtAmnt"));
                var allowedamt = ToInternalFormat($("#lblAllowDuetxt"));


                if (Number(amt) > Number(allowedamt)) {
                    alert('Collect Advance');
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


            //var excess = Number(txtExcess.value);
            var excess = Number(ToInternalFormat($('#' + txtExcess.id)));
            //var diffAmt = Number(txtCoPayment.value) - Number(hdnCoPayment.value);
            var diffAmt = Number(ToInternalFormat($('#' + txtCoPayment.id))) - Number(ToInternalFormat($('#' + hdnCoPayment.id)));

            if (diffAmt > 0) {
                if (diffAmt > excess) {
                    // txtCoPayment.value = parseFloat(Number(hdnCoPayment.value) + excess).toFixed(2);
                    txtCoPayment.value = parseFloat(Number(ToInternalFormat($('#' + hdnCoPayment.id))) + excess).toFixed(2);
                    txtExcess.value = parseFloat(0).toFixed(2);
                } else {
                    //txtCoPayment.value = parseFloat(Number(hdnCoPayment.value) + diffAmt).toFixed(2);
                    txtCoPayment.value = parseFloat(Number(ToInternalFormat($('#' + hdnCoPayment.id))) + diffAmt).toFixed(2);
                    txtExcess.value = parseFloat(excess - diffAmt).toFixed(2);
                }
            } else {
                diffAmt = (-1) * diffAmt;
                //txtCoPayment.value = parseFloat(Number(hdnCoPayment.value) - diffAmt).toFixed(2);
                txtCoPayment.value = parseFloat(Number(ToInternalFormat($('#' + hdnCoPayment.id))) - diffAmt).toFixed(2);
                //txtExcess.value = parseFloat(Number(txtExcess.value) + diffAmt).toFixed(2);
                txtExcess.value = parseFloat(Number(ToInternalFormat($('#' + txtExcess.id))) + diffAmt).toFixed(2);

            }

            ToTargetFormat($('#' + txtCoPayment.id));
            ToTargetFormat($('#' + txtExcess.id));
        }

        function prepareCopayment() {
            var hdnCoPayment = document.getElementById("hdnCoPayment");
            var txtCoPayment = document.getElementById("txtCoPayment");

            getPrecision(txtCoPayment);
            //            hdnCoPayment.value = txtCoPayment.value;
            hdnCoPayment.value = ToInternalFormat($('#' + txtCoPayment.id));
            ToTargetFormat($('#' + hdnCoPayment.id));

        }

        function RefundExcess() {
            // if (document.getElementById("ChkRefund").checked && Number(document.getElementById("txtExcess").value) > 0 && document.getElementById("chkisCreditTransaction").checked) {
            if (document.getElementById("ChkRefund").checked && Number(ToInternalFormat($("#txtExcess"))) > 0 && document.getElementById("chkisCreditTransaction").checked) {
                if (confirm("Do you want refund the Excess Amount Now")) {
                    // document.getElementById("txtRefundAmount").value = parseFloat(Number(document.getElementById("txtRefundAmount").value) + Number(document.getElementById("txtExcess").value)).toFixed(2);
                    document.getElementById("txtRefundAmount").value = parseFloat(Number(ToInternalFormat($("#txtRefundAmount"))) + Number(ToInternalFormat($("#txtExcess")))).toFixed(2);
                    document.getElementById("txtExcess").value = parseFloat(0).toFixed(2);
                }
            }
            //if (document.getElementById("ChkRefund").checked == false && Number(document.getElementById("txtRefundAmount").value) > 0 && document.getElementById("chkisCreditTransaction").checked) {
            if (document.getElementById("ChkRefund").checked == false && Number(ToInternalFormat($("#txtRefundAmount"))) > 0 && document.getElementById("chkisCreditTransaction").checked) {
                //document.getElementById("txtExcess").value = parseFloat(Number(document.getElementById("txtExcess").value) + Number(document.getElementById("txtRefundAmount").value)).toFixed(2);
                document.getElementById("txtExcess").value = parseFloat(Number(ToInternalFormat($("#txtExcess"))) + Number(ToInternalFormat($("#txtRefundAmount")))).toFixed(2);
                document.getElementById("txtRefundAmount").value = parseFloat(0).toFixed(2);

            }

            ToTargetFormat($('#txtExcess'));
            ToTargetFormat($('#txtRefundAmount'));
        }

        function setDiscount() {
            if ((document.getElementById('ddDiscountPercent').value) == 'select') {
                document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
                document.getElementById('txtDiscount').readOnly = false;
                ToTargetFormat($('#txtDiscount'));
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
                                //alert('Mismatch Day Between Admission & Discharge Date');
                            }
                            else {
                                //alert('Mismatch Day Between Billed & Discharge Date');
                            }
                            return true;
                        }
                    }
                }
                else if (monthFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {
                        //alert('Mismatch Month Between Admission & Discharge Date');
                    }
                    else {
                        //alert('Mismatch Month Between Billed & Discharge Date');
                    }
                    return true;
                }
            }
            else {
                if (bit == 0) {
                    //alert('Mismatch Year Between Admission & Discharge Date');
                }
                else {
                    //alert('Mismatch Year Between Billed & Discharge Date');
                }
                return true;
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
                                //alert('Mismatch Second(s) Between Admission & Discharge Time');
                            }
                            else {
                                //alert('Mismatch Second(s) Between Billed & Discharge Date');
                            }
                            return true;
                        }
                    }
                }
                else if (minFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {
                        //alert('Mismatch Minute(s) Between Admission & Discharge Time');
                    }
                    else {
                        //alert('Mismatch Minute(s) Between Billed & Discharge Time');
                    }
                    return true;
                }
            }
            else {
                if (bit == 0) {
                    //alert('Mismatch Hour(s) Between Admission & Discharge Time');
                }
                else {
                    //alert('Mismatch Hour(s) Between Billed & Discharge Time');
                }
                return true;
            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        function chkCustomTax(idval, dAmount) {

            // var sVal = Number(document.getElementById('txtTax').value);
            var sVal = Number(ToInternalFormat($("#txtTax")));

            // var sGrand = format_number(Number(document.getElementById('txtGross').value) - (Number(document.getElementById('txtDiscount').value)), 2);
            var sGrand = format_number(Number(ToInternalFormat($("#txtGross"))) - (Number(ToInternalFormat($("#txtDiscount")))), 2);
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
                // document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);

                ToTargetFormat($('#txtTax'));
                document.getElementById('hdnTaxAmount').value = format_number(ToInternalFormat($("#txtTax")), 2);

                ToTargetFormat($('#hdnTaxAmount'));
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
            ToTargetFormat($('#txtTax'));
            // document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);
            document.getElementById('hdnTaxAmount').value = format_number(ToInternalFormat($("#txtTax")), 2);
            ToTargetFormat($('#hdnTaxAmount'));

            totalCalculate();
            SetOtherCurrValues();
        }
    </script>

    <script language="javascript" type="text/javascript">

        function ShowCollectableAmount_old(totalPaid, totalNonMedical, totalMedical, Pre_AuthAmount, Co_PaymentPercentage, Co_PaymentLogic, Claim_DeductionLogic) {
            //    ShowCollectableAmount(var totalPaid , var totalNonMedical, var totalMedical, var Pre_AuthAmount, var Co_PaymentPercentage, var Co_PaymentLogic )
            /*
            * Step1: Calculate amount to be paid towards non-medical items
            * Step2: Calculate co-payment amount to be paid
            * Step3: Calculate difference between Pre-Auth and actual NetAmount
            * Step4: Calculate total (Step1 + Step2 + Step3)
            */

            var _totNonMedicalAmt = 0;
            var _balAfterNonMedicalAmt = 0;
            var _balAfterNonMedicalCoPayment = 0;
            var _actualCoPayment = 0;
            var _totCoPaymentToPay = 0;
            var _diffInBillledVsPreAuth = 0;
            var _grandTotal = 0;

            /****************Step1: Calculate amount to be paid towards non-medical items, Starts***************************************************/
            if (Number(totalPaid) > Number(totalNonMedical)) {
                _totNonMedicalAmt = 0;
            }
            else {
                _totNonMedicalAmt = (Number(totalNonMedical) - Number(totalPaid));
            }
            /*******************Step1: Calculate amount to be paid towards non-medical items, Ends***************************************************/

            /*******************Step2: Calculate co-payment amount to be paid **************************************************/
            if ((Number(totalPaid) - Number(totalNonMedical)) > 0) {
                _balAfterNonMedicalAmt = Number(totalPaid) - Number(totalNonMedical);
            }
            else {
                _balAfterNonMedicalAmt = 0;
            }

            if (Number(Co_PaymentLogic) == 0) {
                if (Number(totalMedical) < Number(Pre_AuthAmount)) {
                    _actualCoPayment = Number(totalMedical) * (Number(Co_PaymentPercentage) / 100);
                }
                else {
                    _actualCoPayment = Number(Pre_AuthAmount) * (Number(Co_PaymentPercentage) / 100);
                }
            }
            else if (Number(Co_PaymentLogic) == 1) {
                _actualCoPayment = Number(totalMedical) * (Number(Co_PaymentPercentage) / 100);
            }
            else if (Number(Co_PaymentLogic) == 2) {
                _actualCoPayment = Number(Pre_AuthAmount) * (Number(Co_PaymentPercentage) / 100);
            }

            if (Number(_balAfterNonMedicalAmt) > Number(_actualCoPayment)) {
                _totCoPaymentToPay = 0;
            }
            else {
                _totCoPaymentToPay = Number(_actualCoPayment) - Number(_balAfterNonMedicalAmt);
            }


            /*******************Step2: Calculate co-payment amount to be paid Ends **************************************************/
            if ((Number(_balAfterNonMedicalAmt) - Number(_actualCoPayment)) > 0) {
                _balAfterNonMedicalCoPayment = Number(_balAfterNonMedicalAmt) - Number(_actualCoPayment);
            }
            else {
                _balAfterNonMedicalCoPayment = 0;
            }


            /*******************Step3: Calculate difference between Pre-Auth and actual NetAmount, Starts ***************************/

            // Billed Amount
            if (Number(Claim_DeductionLogic) == 1) {

                if ((Number(totalMedical) - Number(_actualCoPayment)) > Number(Pre_AuthAmount)) {
                    if ((((Number(totalMedical) - Number(_actualCoPayment)) - Number(Pre_AuthAmount)) > Number(_balAfterNonMedicalCoPayment))) {
                        _diffInBillledVsPreAuth = (Number(totalMedical) - Number(_actualCoPayment)) - Number(Pre_AuthAmount) - Number(_balAfterNonMedicalCoPayment);


                    }
                    else {
                        //_balAfterNonMedicalCoPayment = 0;
                        _diffInBillledVsPreAuth = (Number(totalMedical) - Number(_actualCoPayment)) - Number(Pre_AuthAmount) - Number(_balAfterNonMedicalCoPayment);
                    }

                }
                else {
                    //_balAfterNonMedicalCoPayment = 0;
                    _diffInBillledVsPreAuth = (Number(totalMedical) - Number(_actualCoPayment)) - Number(Pre_AuthAmount) - Number(_balAfterNonMedicalCoPayment);
                }
            }

            //Pre Auth Amount
            else if (Number(Claim_DeductionLogic) == 2) {

                if (Number(totalMedical) > Number(Pre_AuthAmount)) {
                    if (Number(totalMedical) - Number(Pre_AuthAmount) > Number(_balAfterNonMedicalCoPayment)) {
                        _diffInBillledVsPreAuth = (Number(totalMedical) - Number(Pre_AuthAmount)) - Number(_balAfterNonMedicalCoPayment);
                    }
                    else {
                        //_diffInBillledVsPreAuth = 0;
                        _diffInBillledVsPreAuth = (Number(totalMedical) - Number(Pre_AuthAmount)) - Number(_balAfterNonMedicalCoPayment);
                    }
                }
                else {
                    //_diffInBillledVsPreAuth = 0;
                    _diffInBillledVsPreAuth = (Number(totalMedical) - Number(Pre_AuthAmount)) - Number(_balAfterNonMedicalCoPayment);
                }
            }

            //Lesser of Billed And Pre-Auth

            else if (Number(Claim_DeductionLogic) == 3) {
                if (Number(Pre_AuthAmount) < Number(totalMedical)) {
                    if (Number(totalMedical) > Number(Pre_AuthAmount)) {
                        if (Number(totalMedical) - Number(Pre_AuthAmount) > Number(_balAfterNonMedicalCoPayment)) {
                            _diffInBillledVsPreAuth = (Number(totalMedical) - Number(Pre_AuthAmount)) - Number(_balAfterNonMedicalCoPayment);
                        }
                        else {
                            //_diffInBillledVsPreAuth = 0;
                            _diffInBillledVsPreAuth = (Number(totalMedical) - Number(Pre_AuthAmount)) - Number(_balAfterNonMedicalCoPayment);
                        }
                    }
                    else {
                        //_diffInBillledVsPreAuth = 0;
                        _diffInBillledVsPreAuth = (Number(totalMedical) - Number(Pre_AuthAmount)) - Number(_balAfterNonMedicalCoPayment);
                    }
                }
                else {
                    if ((Number(totalMedical) - Number(_actualCoPayment)) > Number(Pre_AuthAmount)) {
                        if ((((Number(totalMedical) - Number(_actualCoPayment)) - Number(Pre_AuthAmount)) > Number(_balAfterNonMedicalCoPayment))) {
                            _diffInBillledVsPreAuth = (Number(totalMedical) - Number(_actualCoPayment)) - Number(Pre_AuthAmount) - Number(_balAfterNonMedicalCoPayment);


                        }
                        else {
                            //_balAfterNonMedicalCoPayment = 0;
                            _diffInBillledVsPreAuth = (Number(totalMedical) - Number(Pre_AuthAmount)) - Number(_balAfterNonMedicalCoPayment);
                        }

                    }
                    else {
                        //_balAfterNonMedicalCoPayment = 0;
                        _diffInBillledVsPreAuth = (Number(totalMedical) - Number(Pre_AuthAmount)) - Number(_balAfterNonMedicalCoPayment);

                    }
                }
            }



            /*******************Step3: Calculate difference between Pre-Auth and actual NetAmount, Starts ***************************/

            //        if(Number(totalMedical) > Number(Pre_AuthAmount))
            //        {
            //            if ((Number(totalMedical) - Number(Pre_AuthAmount)) > Number(_balAfterNonMedicalCoPayment)) {
            //                _diffInBillledVsPreAuth = (Number(totalMedical) - Number(Pre_AuthAmount)) - Number(_balAfterNonMedicalCoPayment);
            //            }
            //            else {
            //                _diffInBillledVsPreAuth = 0;
            //            }
            //        }
            //        else
            //        {
            //            _diffInBillledVsPreAuth = 0;
            //        }


            /*******************Step3: Calculate difference between Pre-Auth and actual NetAmount, Ends***************************/

            /******************* Step4: Calculate total (Step1 + Step2 + Step3), Starts *****************************************/

            if (_diffInBillledVsPreAuth > 0) {
                document.getElementById('lblPreAuthAmttxt').innerHTML = parseFloat(_diffInBillledVsPreAuth).toFixed(2);
                _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay) + Number(_diffInBillledVsPreAuth);

                ToTargetFormat($('#lblPreAuthAmttxt'));
            }
            else {
                //var rfn = document.getElementById('txtRefundAmount').value;
                var rfn = ToInternalFormat($("#txtRefundAmount"));

                document.getElementById('lblPreAuthAmttxt').innerHTML = "0.00";

                ToTargetFormat($('#lblPreAuthAmttxt'));

                _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay);

                if ((Number(_diffInBillledVsPreAuth) * -1) > Number(totalPaid)) {
                    if (Number(totalPaid) - (Number(_actualCoPayment) + Number(totalNonMedical)) > 0) {
                        if (_grandTotal == 0) {
                            document.getElementById('txtRefundAmount').value = (Number(totalPaid) - (Number(_actualCoPayment) + Number(totalNonMedical))).toFixed(2);
                            // document.getElementById('hdnRefundAmt').value = format_number(document.getElementById('txtRefundAmount').value, 2);
                            ToTargetFormat($('#txtRefundAmount'));
                            document.getElementById('hdnRefundAmt').value = format_number(ToInternalFormat($("#txtRefundAmount")), 2);
                            ToTargetFormat($('#hdnRefundAmt'));
                        }
                        else {
                            document.getElementById('txtRefundAmount').value = "0.00";
                            ToTargetFormat($('#txtRefundAmount'));
                            //document.getElementById('hdnRefundAmt').value = format_number(document.getElementById('txtRefundAmount').value, 2);
                            document.getElementById('hdnRefundAmt').value = format_number(ToInternalFormat($("#txtRefundAmount")), 2);
                            ToTargetFormat($('#hdnRefundAmt'));
                        }
                    }
                    else {
                        document.getElementById('txtRefundAmount').value = "0.00";
                        ToTargetFormat($('#txtRefundAmount'));
                        // document.getElementById('hdnRefundAmt').value = format_number(document.getElementById('txtRefundAmount').value, 2);
                        document.getElementById('hdnRefundAmt').value = format_number(ToInternalFormat($("#txtRefundAmount")), 2);
                        ToTargetFormat($('#hdnRefundAmt'));
                    }
                }
                else {
                    if (_grandTotal == 0) {
                        document.getElementById('txtRefundAmount').value = (Number(_diffInBillledVsPreAuth) * -1).toFixed(2);
                        ToTargetFormat($('#txtRefundAmount'));
                        //document.getElementById('hdnRefundAmt').value = format_number(document.getElementById('txtRefundAmount').value, 2);
                        document.getElementById('hdnRefundAmt').value = format_number(ToInternalFormat($("#txtRefundAmount")).value, 2);
                        ToTargetFormat($('#hdnRefundAmt'));
                    }
                    else {
                        document.getElementById('txtRefundAmount').value = "0.00";
                        ToTargetFormat($('#txtRefundAmount'));
                        //   document.getElementById('hdnRefundAmt').value = format_number(document.getElementById('txtRefundAmount').value, 2);
                        document.getElementById('hdnRefundAmt').value = format_number(ToInternalFormat($("#txtRefundAmount")), 2);
                        ToTargetFormat($('#hdnRefundAmt'));
                    }
                }
                //            document.getElementById('txtRefundAmount').value = (_diffInBillledVsPreAuth * -1).toFixed(2);
                //            document.getElementById('hdnRefundAmt').value = format_number(document.getElementById('txtRefundAmount').value, 2);


            }





            /******************* Step4: Calculate total (Step1 + Step2 + Step3), Ends *******************************************/

            document.getElementById('lblNonReimbAmttxt').innerHTML = parseFloat(_totNonMedicalAmt).toFixed(2);
            document.getElementById('lblCopayamenttxt').innerHTML = parseFloat(_totCoPaymentToPay).toFixed(2);

            document.getElementById('lblTotaltxt').innerHTML = parseFloat(Math.round(_grandTotal)).toFixed(2);

            ToTargetFormat($('#lblNonReimbAmttxt'));
            ToTargetFormat($('#lblCopayamenttxt'));
            ToTargetFormat($('#lblTotaltxt'));

        }
    </script>

    <script type="text/javascript" language="javascript">

        function ShowCollectableAmount(totalPaid, totalNonMedical, totalMedical, Pre_AuthAmount, Co_PaymentPercentage, Co_PaymentLogic, Claim_DeductionLogic, DiscountAmt) {
            //    ShowCollectableAmount(var totalPaid , var totalNonMedical, var totalMedical, var Pre_AuthAmount, var Co_PaymentPercentage, var Co_PaymentLogic )
            /*
            * Step1: Calculate amount to be paid towards non-medical items
            * Step2: Calculate co-payment amount to be paid
            * Step3: Calculate difference between Pre-Auth and actual NetAmount
            * Step4: Calculate total (Step1 + Step2 + Step3)
            */
            var _totNonMedicalAmt = 0;
            var _balAfterNonMedicalAmt = 0;
            var _balAfterNonMedicalCoPayment = 0;
            var _actualCoPayment = 0;
            var _totCoPaymentToPay = 0;
            var _diffInBillledVsPreAuth = 0;
            var _grandTotal = 0;
            var _grossBill = 0;
            var _claimAmount = 0;
            var _amountReceivable = 0;

            _grossBill = Number(totalMedical) + Number(totalNonMedical);

            /****************Step1: Calculate amount to be paid towards non-medical items, Starts***************************************************/
            if (Number(totalPaid) > Number(totalNonMedical)) {
                _totNonMedicalAmt = 0;
            }
            else {
                _totNonMedicalAmt = (Number(totalNonMedical) - Number(totalPaid));
            }
            /*******************Step1: Calculate amount to be paid towards non-medical items, Ends***************************************************/

            /*******************Step2: Calculate co-payment amount to be paid **************************************************/
            if ((Number(totalPaid) - Number(totalNonMedical)) > 0) {
                _balAfterNonMedicalAmt = Number(totalPaid) - Number(totalNonMedical);
            }
            else {
                _balAfterNonMedicalAmt = 0;
            }

            if (Number(Co_PaymentLogic) == 0) {
                if (Number(totalMedical) < Number(Pre_AuthAmount)) {
                    _actualCoPayment = Number(totalMedical) * (Number(Co_PaymentPercentage) / 100);
                }
                else {
                    _actualCoPayment = Number(Pre_AuthAmount) * (Number(Co_PaymentPercentage) / 100);
                }
            }
            else if (Number(Co_PaymentLogic) == 1) {
                _actualCoPayment = Number(totalMedical) * (Number(Co_PaymentPercentage) / 100);
            }
            else if (Number(Co_PaymentLogic) == 2) {
                _actualCoPayment = Number(Pre_AuthAmount) * (Number(Co_PaymentPercentage) / 100);
            }

            if (Number(_balAfterNonMedicalAmt) > Number(_actualCoPayment)) {
                _totCoPaymentToPay = 0;
            }
            else {
                _totCoPaymentToPay = Number(_actualCoPayment) - Number(_balAfterNonMedicalAmt);
            }


            /*******************Step2: Calculate co-payment amount to be paid Ends **************************************************/
            if ((Number(_balAfterNonMedicalAmt) - Number(_actualCoPayment)) > 0) {
                _balAfterNonMedicalCoPayment = Number(_balAfterNonMedicalAmt) - Number(_actualCoPayment);
            }
            else {
                _balAfterNonMedicalCoPayment = 0;
            }


            /*******************Step3: Calculate difference between Pre-Auth and actual NetAmount, Starts ***************************/

            // Billed Amount
            if (Number(Claim_DeductionLogic) == 1) {


                _claimAmount = Number(totalMedical) - Number(_actualCoPayment);

                if (Number(_claimAmount) > Number(Pre_AuthAmount)) {
                    _claimAmount = Number(Pre_AuthAmount);
                }

                _amountReceivable = Number(_grossBill) - Number(_claimAmount);

                if (Number(totalPaid) - Number(_amountReceivable) > 0) {
                    _diffInBillledVsPreAuth = 0;
                    document.getElementById('lblPreAuthAmttxt').innerHTML = _diffInBillledVsPreAuth.toFixed(2);
                    document.getElementById('txtRefundAmount').value = (Number(totalPaid) - Number(_amountReceivable) + Number(DiscountAmt)).toFixed(2);
                    ToTargetFormat($('#lblPreAuthAmttxt'));
                    ToTargetFormat($('#txtRefundAmount'));
                    //document.getElementById('hdnRefundAmt').value = Number(document.getElementById('txtRefundAmount').value);
                    document.getElementById('hdnRefundAmt').value = Number(ToInternalFormat($("#txtRefundAmount")));
                    ToTargetFormat($('#hdnRefundAmt'));
                }
                else {
                    _diffInBillledVsPreAuth = ((Number(_amountReceivable) - Number(totalPaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                    document.getElementById('lblPreAuthAmttxt').innerHTML = parseFloat(_diffInBillledVsPreAuth).toFixed(2);
                    document.getElementById('txtRefundAmount').value = "0.00";
                    ToTargetFormat($('#lblPreAuthAmttxt'));
                    ToTargetFormat($('#txtRefundAmount'));
                    //document.getElementById('txtRefundAmount').value = parseFloat(Number(document.getElementById('txtRefundAmount').value) + Number(DiscountAmt)).toFixed(2);
                    //document.getElementById('hdnRefundAmt').Value = document.getElementById('txtRefundAmount').value;
                    document.getElementById('txtRefundAmount').value = parseFloat(Number(ToInternalFormat($("#txtRefundAmount"))) + Number(DiscountAmt)).toFixed(2);
                    document.getElementById('hdnRefundAmt').Value = ToInternalFormat($("#txtRefundAmount"));
                    ToTargetFormat($('#txtRefundAmount'));
                    ToTargetFormat($('#hdnRefundAmt'));
                }
                _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay) + Number(_diffInBillledVsPreAuth);

            }

            //Pre Auth Amount
            else if (Number(Claim_DeductionLogic) == 2) {
                _claimAmount = Number(Pre_AuthAmount) - Number(_actualCoPayment);

                if (Number(_claimAmount) > Number(totalMedical)) {
                    _claimAmount = Number(totalMedical);
                }

                _amountReceivable = Number(_grossBill) - Number(_claimAmount);

                if (Number(totalPaid) - Number(_amountReceivable) > 0) {
                    _diffInBillledVsPreAuth = 0;
                    document.getElementById('lblPreAuthAmttxt').innerHTML = _diffInBillledVsPreAuth.toFixed(2);
                    document.getElementById('txtRefundAmount').value = (Number(totalPaid) - Number(_amountReceivable) + Number(DiscountAmt)).toFixed(2);
                    // document.getElementById('hdnRefundAmt').value = document.getElementById('txtRefundAmount').value;
                    ToTargetFormat($('#lblPreAuthAmttxt'));
                    ToTargetFormat($('#txtRefundAmount'));
                    document.getElementById('hdnRefundAmt').value = Number(ToInternalFormat($("#txtRefundAmount")));
                    ToTargetFormat($('#hdnRefundAmt'));

                }
                else {
                    _diffInBillledVsPreAuth = ((Number(_amountReceivable) - Number(totalPaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                    document.getElementById('lblPreAuthAmttxt').innerHTML = parseFloat(_diffInBillledVsPreAuth).toFixed(2);
                    document.getElementById('txtRefundAmount').value = "0.00";
                    ToTargetFormat($('#lblPreAuthAmttxt'));
                    ToTargetFormat($('#txtRefundAmount'));
                    // document.getElementById('txtRefundAmount').value = parseFloat(Number(document.getElementById('txtRefundAmount').value) + Number(DiscountAmt)).toFixed(2);
                    //document.getElementById('hdnRefundAmt').Value = document.getElementById('txtRefundAmount').value;
                    document.getElementById('txtRefundAmount').value = parseFloat(Number(ToInternalFormat($("#txtRefundAmount"))) + Number(DiscountAmt)).toFixed(2);
                    document.getElementById('hdnRefundAmt').Value = ToInternalFormat($("#txtRefundAmount"));
                    ToTargetFormat($('#txtRefundAmount'));
                    ToTargetFormat($('#hdnRefundAmt'));
                }
                _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay) + Number(_diffInBillledVsPreAuth);
            }

            //Lesser of Billed And Pre-Auth

            else if (Number(Claim_DeductionLogic) == 3) {
                if (Pre_AuthAmount < totalMedical) {
                    _claimAmount = Number(Pre_AuthAmount) - Number(_actualCoPayment);
                }
                else {
                    _claimAmount = Number(totalMedical) - Number(_actualCoPayment);
                }

                if (Number(_claimAmount) > Number(totalMedical)) {
                    _claimAmount = Number(totalMedical);
                }

                _amountReceivable = Number(_grossBill) - Number(_claimAmount);
            }
            if (Number(totalPaid) - Number(_amountReceivable) > 0) {
                _diffInBillledVsPreAuth = 0;
                document.getElementById('lblPreAuthAmttxt').innerHTML = _diffInBillledVsPreAuth.toFixed(2);
                document.getElementById('txtRefundAmount').value = (Number(totalPaid) - Number(_amountReceivable) + Number(DiscountAmt)).toFixed(2);
                ToTargetFormat($('#lblPreAuthAmttxt'));
                ToTargetFormat($('#txtRefundAmount'));
                // document.getElementById('hdnRefundAmt').value = Number(document.getElementById('txtRefundAmount')).value
                document.getElementById('hdnRefundAmt').value = Number(ToInternalFormat($("#txtRefundAmount")));
                ToTargetFormat($('#hdnRefundAmt'));

            }
            else {
                _diffInBillledVsPreAuth = ((Number(_amountReceivable) - Number(totalPaid)) - (Number(_totCoPaymentToPay) + Number(_totNonMedicalAmt)));
                document.getElementById('lblPreAuthAmttxt').innerHTML = parseFloat(_diffInBillledVsPreAuth).toFixed(2);
                document.getElementById('txtRefundAmount').value = "0.00";
                ToTargetFormat($('#lblPreAuthAmttxt'));
                ToTargetFormat($('#txtRefundAmount'));
                // document.getElementById('txtRefundAmount').value = parseFloat(Number(document.getElementById('txtRefundAmount').value) + Number(DiscountAmt)).toFixed(2);
                //document.getElementById('hdnRefundAmt').Value = document.getElementById('txtRefundAmount').value;

                document.getElementById('txtRefundAmount').value = parseFloat(Number(ToInternalFormat($("#txtRefundAmount"))) + Number(DiscountAmt)).toFixed(2);
                document.getElementById('hdnRefundAmt').Value = ToInternalFormat($("#txtRefundAmount"));
                ToTargetFormat($('#txtRefundAmount'));
                ToTargetFormat($('#hdnRefundAmt'));
            }
            _grandTotal = Number(_totNonMedicalAmt) + Number(_totCoPaymentToPay) + Number(_diffInBillledVsPreAuth);
            document.getElementById('lblNonReimbAmttxt').innerHTML = _totNonMedicalAmt.toFixed(2);
            document.getElementById('lblCopayamenttxt').innerHTML = _totCoPaymentToPay.toFixed(2);
            document.getElementById('lblActualCopaymenttxt').innerHTML = _actualCoPayment.toFixed(2);
            document.getElementById('lblTotaltxt').innerHTML = _grandTotal.toFixed(2);

            ToTargetFormat($('#lblNonReimbAmttxt'));
            ToTargetFormat($('#lblCopayamenttxt'));
            ToTargetFormat($('#lblActualCopaymenttxt'));
            ToTargetFormat($('#lblTotaltxt'));


        }
        if (document.getElementById('hdnRefundAmt').value > "1")
        // document.getElementById('txtRefundAmount').value = document.getElementById("hdnRefundAmt").value;
            document.getElementById('txtRefundAmount').value = ToInternalFormat($("#hdnRefundAmt"));
        ToTargetFormat($('#txtRefundAmount'));
   
    </script>

    </form>
</body>
</html>
