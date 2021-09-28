<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollectDueAmount.aspx.cs"
    Inherits="Billing_CollectDueAmount" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/DepositUsage.ascx" TagName="DepositUsage" TagPrefix="ucDU" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>--%>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt" runat="server">
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">

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

        //        $(function() {
        //            ChangeDDLItemListWidth();
        //        });

        function Checked(ChkID, DisID, PayID) {

            var grid = document.getElementById('gvDueDetails');
            var GrdLenth = grid.rows.length;
            var txtPayingAmt = 0;
            var ChkboxID = document.getElementById(ChkID).id;
            document.getElementById('txtGross').value = "0.00";
            document.getElementById('txtGrandTotal').value = "0.00";
            ToTargetFormat($('#txtGrandTotal'));
            ToTargetFormat($('#txtGross'));

            for (var i = 1; i < GrdLenth; i++) {
                if (grid.rows[i].cells[0].childNodes[0].checked == true) {
                    //  grid.rows[i].cells[8].childNodes[0].value = parseFloat(Number(grid.rows[i].cells[6].innerText) - Number(grid.rows[i].cells[7].childNodes[0].value)).toFixed(2);
                    //var Gros = Number(grid.rows[i].cells[8].childNodes[0].value);

                    grid.rows[i].cells[8].childNodes[0].value = parseFloat(Number(ToInternalFormat($('#' + grid.rows[i].cells[6].childNodes[0].id))) - Number(ToInternalFormat($('#' + grid.rows[i].cells[7].childNodes[0].id)))).toFixed(2);
                    ToTargetFormat($('#' + grid.rows[i].cells[8].childNodes[0].id));
                    var Gros = Number(ToInternalFormat($('#' + grid.rows[i].cells[8].childNodes[0].id)));

                    txtPayingAmt += Gros;
                    document.getElementById('txtGross').value = parseFloat(txtPayingAmt).toFixed(2);
                    document.getElementById('txtGrandTotal').value = parseFloat(txtPayingAmt).toFixed(2);
                    ToTargetFormat($('#txtGrandTotal'));
                    ToTargetFormat($('#txtGross'));
                }
                else {
                    grid.rows[i].cells[7].childNodes[0].value = "0.00";
                    grid.rows[i].cells[8].childNodes[0].value = "0.00";

                    ToTargetFormat($('#' + grid.rows[i].cells[7].childNodes[0].id));
                    ToTargetFormat($('#' + grid.rows[i].cells[8].childNodes[0].id));
                }

            }
            SetOtherCurrValues();
        }
        function CheckWriteOff(ChkWriteOff, lblRemainingDue, txtDiscount, txtPayingAmt, lblWriteOffAmt, hdnWriteOffAmt) {
            var ChkWriteOff = document.getElementById(ChkWriteOff);
            var lblRemainingDue = document.getElementById(lblRemainingDue);
            var txtDiscount = document.getElementById(txtDiscount);
            var txtPayingAmt = document.getElementById(txtPayingAmt);
            var lblWriteOffAmt = document.getElementById(lblWriteOffAmt);
            if (ChkWriteOff.checked) {
                //                lblWriteOffAmt.innerHTML = Number(Number(lblRemainingDue.innerHTML) - (Number(txtDiscount.value) + Number(txtPayingAmt.value))).toFixed(2);
                //                document.getElementById(hdnWriteOffAmt).value = lblWriteOffAmt.innerHTML;
                lblWriteOffAmt.innerHTML = Number(Number(ToInternalFormat($('#' + lblRemainingDue.id))) - (Number(ToInternalFormat($('#' + txtDiscount.id))) + Number(ToInternalFormat($('#' + txtPayingAmt.id))))).toFixed(2);
                ToTargetFormat($('#' + lblWriteOffAmt.id));
                document.getElementById(hdnWriteOffAmt).value = lblWriteOffAmt.innerHTML;
                ToTargetFormat($('#' + hdnWriteOffAmt.id));
                document.getElementById('hdnWriteOff').value = 1;
                $('#' + txtPayingAmt.id).attr('enabled', true);
                
            }
            if (!ChkWriteOff.checked) {
                lblWriteOffAmt.innerHTML = Number(0).toFixed(2);
                document.getElementById(hdnWriteOffAmt).value = Number(0).toFixed(2);
                ToTargetFormat($('#' + hdnWriteOffAmt.id));
                ToTargetFormat($('#' + lblWriteOffAmt.id));
                document.getElementById('hdnWriteOff').value = 0;
                $('#' + txtPayingAmt.id).attr('disabled', false);

            }

        }
        //Changes  By Arivalagan.k for javaScript to Jquery ///
        function DisAmt(ChkID, DisID, PayID) {
            var AlertType = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert');
            var obj1 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_01') == null ? "Amount Should not greater than Due amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_01');
            var obj2 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_02') == null ? "Amount provided is greater than the net amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_02');
            var grid = document.getElementById('gvDueDetails');
            var GrdLenth = grid.rows.length;
            var txtDiscount = 0;
            var txtPayingAmt = 0;
            var EnableAlert = 0;
            var DisAmtID = document.getElementById(DisID).id;
            document.getElementById('txtGross').value = "0.00";
            ToTargetFormat($('#txtGross'));
            //            $('#grdRefund').find('input:checkbox[id$="chkRefund"]').each(function() {
            //                var isChecked = $(this).prop("checked");
            //                if (isChecked) {

            //                    flag = 1;
            //                }
            //            });
            $("#gvDueDetails tr").each(function() {
                if ($(this).find('input:checkbox').is(':checked')) {
                    //alert("your check box in this row is checked");

                    var tds = $(this).closest('tr').find('td');
                    var Discounttds = tds.eq(7);
                    txtDiscount = txtDiscount = Number(Discounttds.find('input').val());
                    var ExistAmttds = tds.eq(6);
                    var ExistAmt = Number(ExistAmttds.find('span').text());
                    var Setvalamt = tds.eq(8);
                    var Discountamtid = Discounttds.find($('input[id$="txtDiscountAmt"]'));
                    if (DisAmtID == Discountamtid[0].id) {
                        if (DisAmtID == Discountamtid[0].id && txtDiscount > ExistAmt) {
                            Discounttds.find('input').val("0.00");
                            Setvalamt.find('input').val(parseFloat(Number(ExistAmt)).toFixed(2));
                            EnableAlert = 1;
                        }

                        else {
                            var Amt = ExistAmt - txtDiscount;
                            Setvalamt.find('input').val(parseFloat(Number(Amt)).toFixed(2));
                        }

                    }
                    var Gros = Number(Setvalamt.find('input').val());
                    txtPayingAmt += Gros;
                    $('#txtPayingAmt').val(txtPayingAmt);
                    document.getElementById('txtGross').value = parseFloat(txtPayingAmt).toFixed(2);
                    document.getElementById('txtGrandTotal').value = parseFloat(txtPayingAmt).toFixed(2);
                    ToTargetFormat($('#txtGross'));
                    ToTargetFormat($('#txtGrandTotal'));
                    if (txtDiscount > 0) {
                        document.getElementById('hdnDiscountFlag').value = 1;
                    }
                    else {
                        document.getElementById('hdnDiscountFlag').value = 0;
                    }
                }
                else {
                }
            });
            //Code Commented By Arivalagan.k for  not  suport cross browser///
            //            for (var i = 1; i < GrdLenth; i++) {
            //                // var grd = grid.rows[i].cells[0].childNodes[i].id ;
            //                if (grid.rows[i].cells[0].childNodes[0].checked == true) {
            //                    //                    txtDiscount = Number(grid.rows[i].cells[7].childNodes[0].value);
            //                    //                    var ExistAmt = Number(grid.rows[i].cells[6].innerText);

            //                    txtDiscount = Number(ToInternalFormat($('#' + grid.rows[i].cells[7].childNodes[0].id)));
            //                    var ExistAmt = Number(ToInternalFormat($('#' + grid.rows[i].cells[6].childNodes[0].id)));

            //                    if (DisAmtID == grid.rows[i].cells[7].childNodes[0].id) {
            //                        //                        var Amt = Number(grid.rows[i].cells[6].innerText) - Number(txtDiscount);
            //                        var Amt = Number(ToInternalFormat($('#' + grid.rows[i].cells[6].childNodes[0].id))) - Number(txtDiscount);
            //                        grid.rows[i].cells[8].childNodes[0].value = parseFloat(Number(Amt)).toFixed(2);

            //                        ToTargetFormat($('#' + grid.rows[i].cells[8].childNodes[0].id));
            //                    }
            //                    if (DisAmtID == grid.rows[i].cells[7].childNodes[0].id && txtDiscount > ExistAmt) {
            //                        grid.rows[i].cells[7].childNodes[0].value = "0.00";
            //                        alert('Amount Should not greater than Due amount');
            //                        grid.rows[i].cells[8].childNodes[0].value = parseFloat(ExistAmt).toFixed(2);
            //                        ToTargetFormat($('#' + grid.rows[i].cells[7].childNodes[0].id));
            //                        ToTargetFormat($('#' + grid.rows[i].cells[8].childNodes[0].id));

            //                    }
            //                    //var Gros = Number(grid.rows[i].cells[8].childNodes[0].value);
            //                    var Gros = Number(ToInternalFormat($('#' + grid.rows[i].cells[8].childNodes[0].id)));
            //                    txtPayingAmt += Gros;
            //                    document.getElementById('txtGross').value = parseFloat(txtPayingAmt).toFixed(2);
            //                    document.getElementById('txtGrandTotal').value = parseFloat(txtPayingAmt).toFixed(2);
            //                    ToTargetFormat($('#txtGross'));
            //                    ToTargetFormat($('#txtGrandTotal'));
            //                    if (txtDiscount > 0) {
            //                        document.getElementById('hdnDiscountFlag').value = 1;
            //                    }
            //                    else {
            //                        document.getElementById('hdnDiscountFlag').value = 0;
            //                    }
            //                }
            //                else {
            //                    grid.rows[i].cells[7].childNodes[0].value = "0.00";
            //                    grid.rows[i].cells[8].childNodes[0].value = "0.00";
            //                    ToTargetFormat($('#' + grid.rows[i].cells[7].childNodes[0].id));
            //                    ToTargetFormat($('#' + grid.rows[i].cells[8].childNodes[0].id));
            //                }

            //            }
            SetOtherCurrValues();
            if (EnableAlert == 1) {
                ValidationWindow(obj1, AlertType);
                return false;
            }
        }
        function SumPayAmt(ChkID, DisID, PayID) {
            var AlertType = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert');
            var obj1 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_01') == null ? "Amount Should not greater than Due amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_01');
            var obj2 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_02') == null ? "Amount provided is greater than the net amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_02');
            var grid = document.getElementById('gvDueDetails');
            var GrdLenth = grid.rows.length;
            var txtDiscount = 0;
            var txtPayingAmt = 0;
            var DisAmtID = document.getElementById(DisID).id;
            var PayingID = document.getElementById(PayID).id;
            document.getElementById('txtGross').value = "0.00";
            ToTargetFormat($('#txtGross'));
            $("#gvDueDetails tr").each(function() {

                if ($(this).find('input:checkbox').is(':checked')) {
                    var tds = $(this).closest('tr').find('td');
                    var Discounttds = tds.eq(7);
                    txtDiscount = txtDiscount = Number(Discounttds.find('input').val());
                    var ExistAmttds = tds.eq(6);
                    var ExistAmt = Number(ExistAmttds.find('span').text());
                    var Setvalamt = tds.eq(8);
                    var Amt = txtDiscount + Setvalamt;
                    if (Amt > ExistAmt) {
                        ValidationWindow(obj1, AlertType);
                        //alert('Amount Should not greater than Due amount');
                        document.getElementById(PayID).value = parseFloat(Number(ExistAmt) - Number(ToInternalFormat($('#' + document.getElementById(DisID).id)))).toFixed(2);
                        ToTargetFormat($('#' + document.getElementById(PayID).id));
                    }
                    var Gros = Number(Setvalamt.find('input').val());
                    txtPayingAmt += Gros;
                    document.getElementById('txtGross').value = Number(txtPayingAmt).toFixed(2);
                    document.getElementById('txtGrandTotal').value = Number(txtPayingAmt).toFixed(2);
                    ToTargetFormat($('#txtGross'));
                    ToTargetFormat($('#txtGrandTotal'));
                }
                else {

                }
            });
            //Code Commented By Arivalagan.k for  not  suport cross browser///
            //            for (var i = 1; i < GrdLenth; i++) {
            //                //var grd = grid.rows[i].cells[0].childNodes[0].id;
            //                if (grid.rows[i].cells[0].childNodes[0].checked == true) {
            //                    //  var Amt = Number(grid.rows[i].cells[8].childNodes[0].value) + Number(grid.rows[i].cells[7].childNodes[0].value);
            //                    // var ExistAmt = Number(grid.rows[i].cells[6].innerText);
            //                    var Amt = Number(ToInternalFormat($('#' + grid.rows[i].cells[8].childNodes[0].id))) + Number(ToInternalFormat($('#' + grid.rows[i].cells[7].childNodes[0].id)));
            //                    var ExistAmt = Number(ToInternalFormat($('#' + grid.rows[i].cells[6].childNodes[0].id)));

            //                    if (Amt > ExistAmt) {
            //                        alert('Amount Should not greater than Due amount');
            //                        //document.getElementById(PayID).value = parseFloat(Number(ExistAmt) - Number(document.getElementById(DisID).value)).toFixed(2);
            //                        document.getElementById(PayID).value = parseFloat(Number(ExistAmt) - Number(ToInternalFormat($('#' + document.getElementById(DisID).id)))).toFixed(2);
            //                        ToTargetFormat($('#' + document.getElementById(PayID).id));
            //                    }
            //                    // var Gros = Number(grid.rows[i].cells[8].childNodes[0].value);
            //                    var Gros = Number(ToInternalFormat($('#' + grid.rows[i].cells[8].childNodes[0].id)));
            //                    txtPayingAmt += Gros;
            //                    document.getElementById('txtGross').value = Number(txtPayingAmt).toFixed(2);
            //                    document.getElementById('txtGrandTotal').value = Number(txtPayingAmt).toFixed(2);

            //                    ToTargetFormat($('#txtGross'));
            //                    ToTargetFormat($('#txtGrandTotal'));
            //                }
            //                else {
            //                    grid.rows[i].cells[7].childNodes[0].value = "0.00";
            //                    grid.rows[i].cells[8].childNodes[0].value = "0.00";
            //                    ToTargetFormat($('#' + grid.rows[i].cells[7].childNodes[0].id));
            //                    ToTargetFormat($('#' + grid.rows[i].cells[8].childNodes[0].id));
            //                }
            //            }
            SetOtherCurrValues();
        }
        //End Changes  By Arivalagan.k for javaScript to Jquery ///



        function CheckedCal(txtExistDueAmt, chkitem) {
            var gridChkBox = document.getElementById(chkitem);
            var txtGridAmount = txtExistDueAmt;

            //alert(txtGridAmount);
            if (gridChkBox.checked) {
                // var chkgross = Number(document.getElementById('txtGross').value) + Number(txtGridAmount);
                var chkgross = Number(ToInternalFormat($('#txtGross'))) + Number(txtGridAmount);

                document.getElementById('txtGross').value = format_number(Number(chkgross), 2);
                document.getElementById('txtGrandTotal').value = format_number(Number(chkgross), 2);
                document.getElementById('Rshiden').value = format_number(Number(chkgross), 2);
                document.getElementById('hdnChangedGrandValue').value = format_number(Number(chkgross), 2);
                ToTargetFormat($('#txtGross'));
                ToTargetFormat($('#txtGrandTotal'));
                ToTargetFormat($('#Rshiden'));
                ToTargetFormat($('#hdnChangedGrandValue'));

            }
            else {
                // var chkgross = Number(document.getElementById('txtGross').value) - Number(txtGridAmount);
                var chkgross = Number(ToInternalFormat($('#txtGross'))) + Number(txtGridAmount);
                document.getElementById('txtGross').value = format_number(Number(chkgross), 2);
                document.getElementById('txtGrandTotal').value = format_number(Number(chkgross), 2);
                document.getElementById('hdnChangedGrandValue').value = format_number(Number(chkgross), 2);
                ToTargetFormat($('#txtGross'));
                ToTargetFormat($('#txtGrandTotal'));
                ToTargetFormat($('#hdnChangedGrandValue'));
            }
            // alert(document.getElementById('hdnGross').value);
            SetOtherCurrValues();

        }
        function checkIsCredit() {

            if (document.getElementById('chkisCreditTransaction').checked == true) {
                if (!document.getElementById('txtAmountRecieved').value > 0) {
                    document.getElementById('txtAmountRecieved').value = '0.00';
                    document.getElementById('hdnAmountReceived').value = '0.00';
                }
                document.getElementById('txtAmountRecieved').disabled = true;
                ToTargetFormat($('#txtAmountRecieved'));
                ToTargetFormat($('#hdnAmountReceived'));
            }
        }
        function closeData() {
            document.getElementById('<%= btnClose.ClientID %>').click();
        }
        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var AlertType = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_CollectDuBilling_CollectDueAmount_aspx_AlerteAmount_Alert');
            var obj1 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_01') == null ? "Amount Should not greater than Due amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_01');
            var obj2 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_02') == null ? "Amount provided is greater than the net amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_02');
            var ConValue = "OtherCurrencyDisplay1";

            sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 4);
            var valchck = Number(sNetValue);
            if (valchck >= Number(sVal)) {
                sVal = format_number(sVal, 2);
                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                var pScrAmt = Number(pScr) * Number(CurrRate);
                var pAmt = Number(sVal) * Number(CurrRate);

                document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
                document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2)

                ToTargetFormat($('#txtServiceCharge'));
                ToTargetFormat($('#hdnServiceCharge'));

                // var amtRec = document.getElementById('hdnDepositUsed').value;
                var amtRec = ToInternalFormat($('#hdnDepositUsed'));
                amtRec = 0;
                document.getElementById('hdnAmountReceived').value = format_number(Number(amtRec) + Number(pAmt), 2);
                document.getElementById('txtAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);

                //                document.getElementById('hdnAmountReceived').value = pAmt;
                //                document.getElementById('txtAmountRecieved').value = pAmt;

                ToTargetFormat($('#hdnAmountReceived'));
                ToTargetFormat($('#txtAmountRecieved'));

                var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

                document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
                document.getElementById('hdnChangedGrandValue').value = format_number(Number(pTotal), 2);

                ToTargetFormat($('#txtGrandTotal'));
                ToTargetFormat($('#hdnChangedGrandValue'));

                SetOtherCurrValues();
                return true;
            }
            else {
                ValidationWindow(obj2, AlertType);
            //    alert('Amount provided is greater than the net amount')
                return false;
            }
        }

        function validate(bid) {
            //            $get(bid).disabled = true;
            //            javascript: __doPostBack(bid, '');
			var AlertType = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert');
            var vChequeValidateDate = SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_13') == null ? "Please enter the Valid cheque Date" : SListForAppMsg.Get('CommonControls_PaymentTypeDetails_ascx_13');
            var ctlDp = document.getElementById('PaymentType_ddlPaymentType');
            var PaymentTypeID = ctlDp.options[ctlDp.selectedIndex].value.split('~')[0];
            var IsValidMonth = ctlDp.options[ctlDp.selectedIndex].value.split('~')[3];
            var ChequeValidDate = document.getElementById('PaymentType_txtDate').value;
            var GetTotalDays = parseInt(IsValidMonth) * 30;
            var oneDay = 24 * 60 * 60 * 1000;
            var TodayDate = new Date();
            var DayFormat = TodayDate.format("MM/dd/yyyy");
            var TodayMonth = DayFormat.split('/')[0];
            var TodayDay = DayFormat.split('/')[1];
            var TodayYear = DayFormat.split('/')[2];
            var GetDate = new Date(TodayYear, TodayMonth, TodayDay);
            var GetPaymentDate = "";
            var day = "";
            var month = "";
            var Year = "";
            var TargetDate = "0";
            var diffDays = "0"
            if (ChequeValidDate != "") {
                GetPaymentDate = ChequeValidDate.split('/');
                day = GetPaymentDate[0];
                month = (GetPaymentDate[1]);
                Year = GetPaymentDate[2];
                TargetDate = new Date(Year, month, day);
                diffDays = (GetDate.getTime(TodayYear, TodayMonth, TodayDay) - TargetDate.getTime(Year, month, day)) / (oneDay);

                if (PaymentTypeID == "2" && (parseInt(GetTotalDays) < parseInt(diffDays) || (GetDate.getTime(TodayYear, TodayMonth, TodayDay) > TargetDate.getTime(Year, month, day)))) {
                    //alert("Please enter the Valid cheque Date");
                    ValidationWindow(vChequeValidateDate, AlertType);
                    //return false;
                }
            }
			
            if (PaymentSaveValidationQuickBill()) {
                
            var obj1 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_01') == null ? "Amount Should not greater than Due amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_01');
            var obj2 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_02') == null ? "Amount provided is greater than the net amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_02');
            var obj3 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_03') == null ? "Select Discount reason" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_03');
           
            var obj4 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_04') == null ? "Please Enter Authorise By" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_04'); 
            var obj6 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_06') == null ? "Please Collect Whole Due Amount." : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_06');
			if (document.getElementById('hdnDiscountFlag').value > 0) {
                if (document.getElementById('ddlDiscountReason').options[document.getElementById('ddlDiscountReason').selectedIndex].value == "0") {
                    //alert('Select Discount reason');
                    ValidationWindow(obj3, AlertType);
                    document.getElementById('ddlDiscountReason').focus();
                    return false;
                }
                if (document.getElementById('txtAuthorised').value == '') {
                   //alert('Please Enter Authorise By');
                    ValidationWindow(obj4, AlertType);
                    return false;
                }
            }
            var alte = PaymentSaveValidation();
            var WriteOff = 0;
            var DiscountFlag = 0;
            WriteOff = document.getElementById('hdnWriteOff').value;
            DiscountFlag = document.getElementById('hdnDiscountFlag').value;
            if (alte == true) {
                //document.getElementById('btnSave').style.display = 'none';
                // if (Number($get('txtGrandTotal').value) <= 0) {
                if (Number(ToInternalFormat($('#txtGrandTotal'))) <= 0 && WriteOff == 0 && DiscountFlag == 0) {
                    //alert('Please Select at lease one Bill Item.');
                    var obj5 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_05') == null ? "Please Select at lease one Bill Item." : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_05');
                    ValidationWindow(obj5, AlertType); 
                    return false;
                }
                // if (Number($get('txtAmountRecieved').value) < Number($get('txtGrandTotal').value)) {
                if (Number(ToInternalFormat($('#txtAmountRecieved'))) < Number(ToInternalFormat($('#txtGrandTotal')))) {
                    var obj6 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_06') == null ? "Please Collect Whole Due Amount." : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_06');
                    //                 if (Number($get('txtAmountRecieved').value) <Number(document.getElementById('Rshiden').value )) {
                  //  alert('Please Collect Whole Due Amount.');
                    ValidationWindow(obj6, AlertType);
                    return false;
                } else {
                    $get('btnSave').disabled = true;
                    javascript: __doPostBack(bid, '');
                    return true;
                    }
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }

        }

        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);
            sVal = Number(Number(sVal) - Number(TotalAmount));
            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);

            document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2);
            document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
            ToTargetFormat($('#txtServiceCharge'));
            ToTargetFormat($('#hdnServiceCharge'));

            // var amtRec = document.getElementById('hdnDepositUsed').value;
            var amtRec = ToInternalFormat($('#hdnDepositUsed'));
            amtRec = 0;
            document.getElementById('hdnAmountReceived').value = format_number(Number(sVal) + Number(amtRec), 2);
            document.getElementById('txtAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);
            //            document.getElementById('hdnAmountReceived').value = format_number(sVal, 2);
            //            document.getElementById('txtAmountRecieved').value = format_number(sVal, 2);

            ToTargetFormat($('#hdnAmountReceived'));
            ToTargetFormat($('#txtAmountRecieved'));

            totalCalculate();

            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

            document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
            ToTargetFormat($('#txtGrandTotal'));
            SetOtherCurrValues();

        }
        
    </script>

    <script language="javascript" type="text/javascript">
        function totalCalculate() {
            var AlertType = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert');
            var obj7 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_07') == null ? "Discount Cannot be Greater than Gross Amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_07');
            //            var GrossAmount = document.getElementById('<%= hdnGross.ClientID %>').value;
            var GrossAmount = ToInternalFormat($('#<%= hdnGross.ClientID %>'));
            //            var DiscountAmount = document.getElementById('<%= txtDiscount.ClientID  %>').value;
            var DiscountAmount = ToInternalFormat($('#<%= txtDiscount.ClientID  %>'));
            var GrandTotal = document.getElementById('<%= txtGrandTotal.ClientID  %>');
            //            var PreviousReceived = document.getElementById('<%= txtPreviousAmountPaid.ClientID %>').value;
            var PreviousReceived = ToInternalFormat($('#<%= txtPreviousAmountPaid.ClientID %>'));

            var PreviousDue = parseFloat(0).toFixed(2);

            var AdvanceReceivd = parseFloat(0).toFixed(2);

            var RefundAmount = document.getElementById('<%= txtRefundAmount.ClientID %>');

            PreviousReceived = chkIsnumber(PreviousReceived);
            GrossAmount = chkIsnumber(GrossAmount);
            DiscountAmount = chkIsnumber(DiscountAmount);
            PreviousDue = chkIsnumber(PreviousDue);
            AdvanceReceivd = chkIsnumber(AdvanceReceivd);

            if ((Number(GrossAmount) - Number(DiscountAmount)) < 0) {
                //alert('Discount Cannot be Greater than Gross Amount');
                ValidationWindow(obj7, AlertType);
                document.getElementById('<%= txtDiscount.ClientID  %>').value = GrossAmount;
                ToTargetFormat($('#<%= txtDiscount.ClientID  %>'));
                totalCalculate();
                //GrandTotal.value = document.getElementById('<%= hdnGross.ClientID %>').value;
            }
            else {
                var totGrossAmount = format_number((Number(GrossAmount) + Number(PreviousDue) - (Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd))), 2);


                if (Number(totGrossAmount) > 0) {
                    GrandTotal.value = totGrossAmount
                    RefundAmount.value = 0;
                    ToTargetFormat($('#' + GrandTotal.id));
                    ToTargetFormat($('#' + RefundAmount.id));
                }
                else {
                    GrandTotal.value = 0;
                    RefundAmount.value = format_number((Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd)) - (Number(GrossAmount) + Number(PreviousDue)), 2);
                    ToTargetFormat($('#' + GrandTotal.id));
                    ToTargetFormat($('#' + RefundAmount.id));
                }
                //RefundAmount
                SetOtherCurrValues();
            }
        }
        function ValidateDiscountReason() {
            //            if (document.getElementById('txtDiscount').value > 0) {
            if (ToInternalFormat($('#txtDiscount')) > 0) {


            }
            else {
                document.getElementById('trDiscountReason').style.display = "none";
            }
        }

        function ChangeFormat() {
            var AlertType = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert');
            var obj8 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_08') == null ? "Discount Amount is greater than Gross value" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_08');
            //            document.getElementById('txtDiscount').value = format_number(document.getElementById('txtDiscount').value, 2);
            //            document.getElementById('txtAmountRecieved').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            //            document.getElementById('hdnAmountReceived').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            //            var gross = document.getElementById('txtGross').value;
            //            var discount = document.getElementById('txtDiscount').value;

            document.getElementById('txtDiscount').value = format_number(ToInternalFormat($('#txtDiscount')), 2);
            document.getElementById('txtAmountRecieved').value = format_number(ToInternalFormat($('#txtAmountRecieved')), 2);
            document.getElementById('hdnAmountReceived').value = format_number(ToInternalFormat($('#txtAmountRecieved')), 2);
            ToTargetFormat($('#txtDiscount'));
            ToTargetFormat($('#txtAmountRecieved'));
            ToTargetFormat($('#hdnAmountReceived'));
            var gross = ToInternalFormat($('#txtGross'));
            var discount = ToInternalFormat($('#txtDiscount'));

            if ((Number(gross)) < (Number(discount))) {
                document.getElementById('txtDiscount').value = "0.0";
                ToTargetFormat($('#txtDiscount'));
                totalCalculate();
                //alert('Discount Amount is greater than Gross value');
                ValidationWindow(obj8, AlertType);
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
                    ToTargetFormat($('#' + document.getElementById(DiscountCntrls[iCnt].id)));
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
                    //  DiscountAmount = Number(chkIsnumber(document.getElementById(DiscountCntrls[iCnt]).value)) + Number(DiscountAmount);
                    DiscountAmount = Number(chkIsnumber(ToInternalFormat($('#' + document.getElementById(DiscountCntrls[iCnt]).id)))) + Number(DiscountAmount);
                }
            }

            //            if (Number(DiscountControl.value) < Number(DiscountAmount)) {
            //                DiscountControl.value = Number(DiscountAmount);
            //            }

            if (Number(ToInternalFormat($('#' + DiscountControl.id))) < Number(DiscountAmount)) {
                DiscountControl.value = Number(DiscountAmount);
                ToTargetFormat($('#' + DiscountControl.id));
            }
            return false;
        }
        function DiscountAuthSelectedOver(source, eventArgs) {
            var AlertType = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert');
            var obj9 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_09') == null ? "Please select discount authroise from the list" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_09');
            $find('AutoAuthorizer')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoAuthorizer')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    ValidationWindow(obj9, AlertType);
                    //alert('Please select discount authroise from the list');
                    document.getElementById('txtAuthorised').value = '';
                }
            };
        }
        function DiscountAuthSelected(source, eventArgs) {
            document.getElementById('hdnDiscountApprovedBy').value = eventArgs.get_value();
        }
        function HomeClick() {
            window.location.assign("../Billing/PatientDueDetails.aspx?IsPopup=Y");
        }
    </script>

    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="Nodata" runat="server" visible="false">
            <asp:Label ID="lblMessage" runat="server" Text="No Data Available for the selected patient"
                meta:resourcekey="lblMessageResource1"></asp:Label>
            <asp:Button ID="Button1" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                Text="Back" OnClick="btnClose_Click" meta:resourcekey="Button1Resource1" />
        </div>
        <div id="YesData" runat="server">
            <table class="w-100p">
                <tr>
                    <td colspan="3">
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="a-center">
                        <asp:GridView ID="gvDueDetails" runat="server" CssClass="gridView w-100p" AutoGenerateColumns="False"
                            OnRowDataBound="gvDueDetails_RowDataBound" meta:resourcekey="gvDueDetailsResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="select" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" Checked="True" meta:resourcekey="chkSelectResource1" />
                                        <asp:HiddenField ID="hdnPatientID" runat="server" Value='<%# Eval("PatientID") %>' />
                                        <asp:HiddenField ID="hdnPatientDueID" runat="server" Value='<%# Eval("PatientDueID") %>' />
                                        <asp:HiddenField ID="hdnVisiID" runat="server" Value='<%# Eval("VisitID") %>' />
                                        <asp:HiddenField ID="hdnFinalBillID" runat="server" Value='<%# Eval("FinalBillID") %>' />
                                        <asp:HiddenField ID="hdnDiscountedAmount" runat="server" Value='<%# Eval("DiscountAmt") %>' />
                                        <asp:HiddenField ID="hdnHasHealthCard" runat="server" Value='<%# Eval("ClientName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Patient No." DataField="PatientNumber" meta:resourcekey="BoundFieldResource1" />
                                <asp:BoundField HeaderText="BillNo." DataField="BillNo" meta:resourcekey="BoundFieldResource2" />
                                <asp:BoundField HeaderText="Patient Name" DataField="PatientName" meta:resourcekey="BoundFieldResource3" />
                                <asp:BoundField HeaderText="Due Amount" DataField="DueAmount" meta:resourcekey="BoundFieldResource4" />
                                <asp:BoundField HeaderText="Due Paid" DataField="DuePaidAmt" meta:resourcekey="BoundFieldResource5" />
                                <asp:TemplateField HeaderText="Existing Due" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRemainingDue" runat="server" Text='<%# Bind("ExistingDue") %>'
                                            meta:resourcekey="lblRemainingDueResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField HeaderText="Remaining Due" DataField="ExistingDue" />--%>
                                <asp:TemplateField HeaderText="Discount Amount" meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDiscountAmt" runat="server" CssClass="biltextb" Text="0.00" Width="60px"
                                            Style="text-align: right" meta:resourcekey="txtDiscountAmtResource1"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PayingAmt" meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPayingAmt" runat="server" CssClass="biltextb" Text="0.00" Width="60px"
                                            Style="text-align: right" meta:resourcekey="txtPayingAmtResource1" onkeydown="chkPayAmt()"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Discounted Amount" DataField="DiscountAmt" meta:resourcekey="BoundFieldResource6">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Write Off Amount" meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWriteOffAmt" runat="server" Text='<%# Bind("InvoiceAmount") %>'></asp:Label>
                                        <asp:HiddenField ID="hdnWriteOffAmt" runat="server" Value="0.00" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Write Off" meta:resourcekey="TemplateFieldResource6">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkWriteOff" runat="server" meta:resourcekey="chkWriteOffResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr id="trAmtDetails" runat="server" style="display: none;">
                    <td colspan="3" class="paddingT10">
                        <table class="w-100p">
                            <tr>
                                <td class="a-right w-25p">
                                </td>
                                <td class="a-right w-65p">
                                    <asp:Label ID="lblGross" runat="server" Text="Gross Bill Amount" class="defaultfontcolor"
                                        meta:resourcekey="lblGrossResource1" />
                                </td>
                                <td class="a-right">
                                    <asp:HiddenField ID="hdnGross" runat="server" />
                                    <asp:TextBox ID="txtGross" runat="server" Text="0.00" TabIndex="1" CssClass="Txtboxsmall"
                                        Enabled="False" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                    <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right" style="display: none;">
                                </td>
                                <td class="a-right" style="display: none;">
                                    <div style="display: none;">
                                        <asp:Label ID="Rs_SelectCorporate" Text="Select Corporate" runat="server" meta:resourcekey="Rs_SelectCorporateResource1"></asp:Label>
                                        <asp:DropDownList ID="ddlCorporate" onchange="javascript:calculateDiscountForCorporate();"
                                            runat="server" meta:resourcekey="ddlCorporateResource1">
                                        </asp:DropDownList>
                                    </div>
                                    <asp:Label ID="lblDiscount" runat="server" Text="Discount" class="defaultfontcolor"
                                        meta:resourcekey="lblDiscountResource1" />
                                </td>
                                <td class="a-right" style="display: none">
                                    <asp:TextBox ID="txtDiscount" ReadOnly="True" runat="server" TabIndex="4" onkeyup="totalCalculate();"
                                        Text="0.00" CssClass="Txtboxsmall" onblur="AddDiscountsCheck();ChangeFormat();totalCalculate();"
                                         onkeypress="return ValidateOnlyNumeric(this);"  meta:resourcekey="txtDiscountResource1" />
                                </td>
                            </tr>
                            <tr id="trDiscountReason" style="display: none;">
                                <td class="a-right">
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblReasonforDiscount" runat="server" Text="Reason for Discount" class="defaultfontcolor"
                                        meta:resourcekey="lblReasonforDiscountResource1" />
                                </td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtDiscountReason" CssClass="Txtboxsmall" runat="server" TabIndex="5"
                                        meta:resourcekey="txtDiscountReasonResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblDiscountReason" runat="server" Text="Discount Reason" meta:resourcekey="lblDiscountReasonResource1" ></asp:Label>
                                </td>
                                <td class="a-right">
                                    <span class="richcombobox" style="width: 155px;">
                                        <asp:DropDownList ID="ddlDiscountReason" Width="155px" runat="server" CssClass="ddl">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblAuthorised" runat="server" Text="Authorise By" meta:resourcekey="lblAuthorisedResource1"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtAuthorised" autocomplete="off" CssClass="AutoCompletesearchBox"
                                        runat="server" Width="130px" />
                                    <ajc:AutoCompleteExtender ID="AutoAuthorizer" runat="server" CompletionInterval="10"
                                        FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                        Enabled="True" MinimumPrefixLength="1" ServiceMethod="getUserNamesWithNameandLoginID"
                                        ServicePath="~/WebService.asmx" TargetControlID="txtAuthorised" OnClientItemOver="DiscountAuthSelectedOver"
                                        OnClientItemSelected="DiscountAuthSelected">
                                    </ajc:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr id="trPreviousDue" runat="server" style="display: none">
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblPreviousDue" runat="server" Text=" Previous Due" meta:resourcekey="lblPreviousDueResource1"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtPreviousDue" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                        CssClass="Txtboxsmall" meta:resourcekey="txtPreviousDueResource1" />
                                </td>
                            </tr>
                            <tr id="trAmountPaid" runat="server" style="display: none">
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblAmountPaid" runat="server" Text="Amount Paid" meta:resourcekey="lblAmountPaidResource1"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtPreviousAmountPaid" runat="server" Text="0.00" Enabled="False"
                                        TabIndex="6" CssClass="Txtboxsmall" meta:resourcekey="txtPreviousAmountPaidResource1" />
                                </td>
                            </tr>
                            <tr id="trAdvancedPaid" runat="server" style="display: none">
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblAdvancePaid" runat="server" Text="Advance Paid" meta:resourcekey="lblAdvancePaidResource1"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtRecievedAdvance" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                        CssClass="Txtboxsmall" meta:resourcekey="txtRecievedAdvanceResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    <div id="trDepositUsage" runat="server">
                                        <ucDU:DepositUsage ID="DepositUsageCtrl" runat="server" BaseControlID="txtGrandTotal"
                                            TargetControlID="hdnDepositUsed" OtherCurrencyControlID="OtherCurrencyDisplay1"
                                            DisplayControlID="txtAmountRecieved" />
                                    </div>
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtServiceCharge" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                        CssClass="Txtboxsmall" meta:resourcekey="txtServiceChargeResource1" />
                                    <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblGrandTotal" runat="server" Text="Net Payable Amount" class="defaultfontcolor"
                                        meta:resourcekey="lblGrandTotalResource1" />
                                </td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtGrandTotal" Enabled="False" runat="server" TabIndex="8" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtGrandTotalResource1" />
                                    <asp:HiddenField ID="hdnChangedGrandValue" runat="server" Value="0.00" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="Rs_PreviousRefund" Text="Previous Refund" runat="server" meta:resourcekey="Rs_PreviousRefundResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtPreviousRefund" runat="server" TabIndex="8" Enabled="False" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtPreviousRefundResource1" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="Rs_AmounttoRefund" Text="Amount to Refund" runat="server" meta:resourcekey="Rs_AmounttoRefundResource1"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <asp:CheckBox ID="ChkRefund" runat="server" Text="Yes" onClick="javascript:funcRefundChk();"
                                        meta:resourcekey="ChkRefundResource1" />
                                    <asp:TextBox ID="txtRefundAmount" runat="server" TabIndex="8" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtRefundAmountResource1" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="Rs_ReasonforRefund" Text="Reason for Refund" runat="server" meta:resourcekey="Rs_ReasonforRefundResource1"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <div id="reasonforRefund" style="display: none">
                                        <asp:TextBox ID="txtReasonForRefund" runat="server" TabIndex="8" MaxLength="150"
                                            Width="150px" meta:resourcekey="txtReasonForRefundResource1" /></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Recieved" class="defaultfontcolor"
                                        meta:resourcekey="lblAmountRecievedResource1" />
                                </td>
                                <td class="a-right">
                                    <asp:TextBox ID="txtAmountRecieved" runat="server" TabIndex="9" ReadOnly="True" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtAmountRecievedResource1" />
                                    <asp:HiddenField ID="hdnAmountReceived" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    &nbsp;
                                </td>
                                <td class="a-right">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNeedWriteOffApproval" runat="server" Text="Need WriteOff Approval From"
                                        Font-Bold="true" meta:resourcekey="lblNeedWriteOffApprovalResource1"></asp:Label>
                                    <asp:CheckBoxList ID="chkAssignTotask" onclick="javascript:dispTask(this.id);" runat="server">
                                    </asp:CheckBoxList>
                                </td>
                            </tr>
                            <tr id="trbtnWriteOff" runat="server" style="display: none">
                                <td colspan="5" class="a-center">
                                    <asp:Button ID="btnWriteOff" runat="server" Text="Generate Task" CssClass="btn" OnClick="btnWriteOff_Click" />
                                </td>
                            </tr>
                            <tr id="trPaymentControl" runat="server">
                                <td colspan="3">
                                    <%--                                       <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>--%>

                                    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

                                    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

                                    <uc13:paymentType ID="PaymentType" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trBtns" runat="server">
                                <td colspan="3">
                                    <asp:Button ID="btnSave" runat="server" Text="Generate Bill" CssClass="btn" onmouseout="this.className='btn'"
                                        OnClientClick="return validate(this.id);" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    &nbsp;<asp:Button ID="btnClose" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                        Text="Close" OnClick="btnClose1_Click" meta:resourcekey="btnCloseResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnTempService" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnDiscountArray" runat="server" />
    <asp:HiddenField ID="Rshiden" runat="server" />
    <asp:HiddenField ID="hdnYesData" runat="server" Value="0" />
    <asp:HiddenField ID="hdnWriteOff" runat="server" Value="0" />
    <asp:HiddenField ID="hdnDiscountFlag" runat="server" Value="0" />
    <asp:HiddenField ID="hdnDiscountApprovedBy" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input id="hdnDepositUsed" runat="server" type="hidden" value="0.00" />

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function chkPayAmt() {
            $("#ddlDiscountReason").focus();
            return false;
        }
        function ChkWriteOffAproval() {
            if (document.getElementById('chkAssignTotask').checked == true) {
                document.getElementById('trPaymentControl').style.display = "none";
                document.getElementById('trBtns').style.display = "none";
                document.getElementById('trbtnWriteOff').style.display = "block";
            }
            else {
                document.getElementById('trPaymentControl').style.display = "block";
                document.getElementById('trBtns').style.display = "block";
                document.getElementById('trbtnWriteOff').style.display = "none";
            }
        }
        function dispTask(id) {
            var flag = 0;
            var cboxObj = document.getElementById(id);
            var cboxList = cboxObj.getElementsByTagName('input');
            for (var i = 0; i < cboxList.length; i++) {
                if (cboxList[i].checked) {
                    flag = 1;
                    break;
                }
            }
            if (flag == 1) {
                document.getElementById('trPaymentControl').style.display = "none";
                document.getElementById('trBtns').style.display = "none";
                document.getElementById('trbtnWriteOff').style.display = "block";
            }
            else {
                document.getElementById('trPaymentControl').style.display = "block";
                document.getElementById('trBtns').style.display = "block";
                document.getElementById('trbtnWriteOff').style.display = "none";
            }
        }
        function closeData() {
            document.getElementById('<%= btnClose.ClientID %>').click();
        }

        function doCalcDue(txtUnitPrice, txtQuantity, txtAmount, hdnTotalAmount,
                            hdnOldPrice, hdnOldQuantity, txtGross, txtDiscount,
                            txtRecievedAdvance, txtGrandTotal, hdnGross,
                            txtindDiscount, hdnDiscountArray, hdnNonMedicalItem,
                            lblNonReimbuse, nonReimburseChkBoxID, flag) {
            var AlertType = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert');
            var obj10 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_10') == null ? "Discount cannot be greater than amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_10');
            var obj11 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_11') == null ? "Task Assigned to" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_11');
            var Quantity = document.getElementById(txtQuantity);
            var UnitPrice = document.getElementById(txtUnitPrice);
            var Amount = document.getElementById(txtAmount);
            var hdnAmount = document.getElementById(hdnTotalAmount);

            var OldPrice = document.getElementById(hdnOldPrice);
            var OldQuantity = document.getElementById(hdnOldQuantity);

            //var oldAmt = Number(OldPrice.value) * Number(OldQuantity.value);
            var oldAmt = Number(ToInternalFormat($('#' + OldPrice.id))) * Number(ToInternalFormat($('#' + OldQuantity.id)));

            var Gross = document.getElementById(txtGross);
            var Discount = document.getElementById(txtDiscount);
            var RecievedAdvance = document.getElementById(txtRecievedAdvance);
            var GrandTotal = document.getElementById(txtGrandTotal);

            //            var OldPricetoDelete = chkIsnumber(OldPrice.value);
            //            var OldQuantitytoDelete = chkIsnumber(OldQuantity.value);

            var OldPricetoDelete = chkIsnumber(ToInternalFormat($('#' + OldPrice.id)));
            var OldQuantitytoDelete = chkIsnumber(ToInternalFormat($('#' + OldQuantity.id)));

            var hdnGrossBillAmount = document.getElementById(hdnGross);
            var OldAmounttoDelete = format_number((Number(OldPricetoDelete) * Number(OldQuantitytoDelete)), 2);


            var IndividualDiscount = document.getElementById(txtindDiscount);
            if (IndividualDiscount == "" || IndividualDiscount == null) {
                IndividualDiscount = parseFloat(0).toFixed(2);
            }



            //            Quantity.value = chkIsnumber(Quantity.value);
            //            UnitPrice.value = chkIsnumber(UnitPrice.value);


            Quantity.value = chkIsnumber(ToInternalFormat($('#' + Quantity.id)));
            UnitPrice.value = chkIsnumber(ToInternalFormat($('#' + UnitPrice.id)));
            ToTargetFormat($('#' + Quantity.id));
            ToTargetFormat($('#' + UnitPrice.id));

            //            UnitPrice.value = format_number(Number(UnitPrice.value), 2);
            //            Amount.value = format_number((Number(Quantity.value) * Number(UnitPrice.value)), 2);
            //            hdnAmount.value = Amount.value;

            UnitPrice.value = format_number(Number(ToInternalFormat($('#' + UnitPrice.id))), 2);
            Amount.value = format_number((Number(ToInternalFormat($('#' + Quantity.id))) * Number(ToInternalFormat($('#' + UnitPrice.id)))), 2);
            hdnAmount.value = ToInternalFormat($('#' + Amount.id));

            ToTargetFormat($('#' + UnitPrice.id));
            ToTargetFormat($('#' + Amount.id));
            ToTargetFormat($('#' + hdnAmount.id));

            //var newAmt = Amount.value;
            var newAmt = ToInternalFormat($('#' + Amount.id));

            //            Gross.value = format_number((Number(Gross.value) + Number(Amount.value) - Number(OldAmounttoDelete)), 2);
            //            hdnGrossBillAmount.value = Gross.value;

            Gross.value = format_number((Number(ToInternalFormat($('#' + Gross.id))) + Number(ToInternalFormat($('#' + Amount.id))) - Number(OldAmounttoDelete)), 2);
            ToTargetFormat($('#' + Gross.id));
            hdnGrossBillAmount.value = ToInternalFormat($('#' + Gross.id));
            ToTargetFormat($('#' + hdnGrossBillAmount.id));

            //if (Number(Amount.value) < Number(chkIsnumber(IndividualDiscount.value))) {
            if (Number(ToInternalFormat($('#' + Amount.id))) < Number(chkIsnumber(ToInternalFormat($('#' + IndividualDiscount.id))))) {
                ValidationWindow(obj10, AlertType);
                //alert('Discount cannot be greater than amount');
                //IndividualDiscount.value = parseFloat(Amount.value).toFixed(2);
                IndividualDiscount.value = parseFloat(ToInternalFormat($('#' + Amount.id))).toFixed(2);
                ToTargetFormat($('#' + IndividualDiscount.id));
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
                    // DiscountAmount = Number(chkIsnumber(document.getElementById(DiscountCntrls[iCnt]).value)) + Number(DiscountAmount);
                    DiscountAmount = Number(chkIsnumber(ToInternalFormat($('#' + document.getElementById(DiscountCntrls[iCnt]).id)))) + Number(DiscountAmount);
                }
            }

            Discount.value = parseFloat(DiscountAmount).toFixed(2);
            ToTargetFormat($('#' + Discount.id));
            //            OldPrice.value = UnitPrice.value;
            //            OldQuantity.value = Quantity.value;
            OldPrice.value = ToInternalFormat($('#' + UnitPrice.id));
            OldQuantity.value = ToInternalFormat($('#' + Quantity.id));
            ToTargetFormat($('#' + OldPrice.id));
            ToTargetFormat($('#' + OldQuantity.id));
            totalCalculate();
            ValidateDiscountReason();

            if (flag != "ROOM") {
                var gridChkBox = document.getElementById(nonReimburseChkBoxID);
                var hdnNonMedical = document.getElementById(hdnNonMedicalItem);
                var lblNonReimbuse = document.getElementById(lblNonReimbuse);
                if (gridChkBox != undefined) {
                    if (gridChkBox.checked) {
                        //nothing
                    }
                    else {
                        // lblNonReimbuse.innerHTML = hdnNonMedical.value = parseFloat(parseFloat(hdnNonMedical.value) + (newAmt - oldAmt)).toFixed(2);
                        lblNonReimbuse.innerHTML = hdnNonMedical.value = parseFloat(parseFloat(ToInternalFormat($('#' + hdnNonMedical.id))) + (newAmt - oldAmt)).toFixed(2);
                        ToTargetFormat($('#' + lblNonReimbuse.id));
                        ToTargetFormat($('#' + hdnNonMedical.id));
                    }
                    doCalcReimburse();
                }
            }
            //    }

        }
       
    </script>

    <script language="javascript" type="text/javascript">
        function SetOtherCurrValues() {
            var pnetAmt = 0;
            //pnetAmt = document.getElementById('txtGrandTotal').value == "" ? "0" : document.getElementById('txtGrandTotal').value;
            pnetAmt = document.getElementById('txtGrandTotal').value == "" ? "0" : ToInternalFormat($('#txtGrandTotal'));
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }
        if (document.getElementById('hdnYesData').value == 1) {
            document.getElementById('trAmtDetails').style.display = "block";
            GetCurrencyValues();
        }
        if (document.getElementById('hdnYesData').value == 0) {
            document.getElementById('YesData').style.display = "none";
            document.getElementById('trAmtDetails').style.display = "none";

        }
        
                
    </script>

    <div id="iframeBill1">
    </div>
    </form>

    <script language="javascript" type="text/javascript">
        function OpenIframe(FinalBillID, patientVisitID) {
            var AlertType = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_Alert');
            var obj10 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_10') == null ? "Discount cannot be greater than amount" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_10');
            var obj11 = SListForAppMsg.Get('Billing_CollectDueAmount_aspx_11') == null ? "Task Assigned to" : SListForAppMsg.Get('Billing_CollectDueAmount_aspx_11');
            $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + patientVisitID + "&isFullBill=Y&finalBillID=" + FinalBillID + "&actionType=DefaultPrint&type=printreport&invstatus=approve&HashealthCard=Y' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
        }
        function TaskMsg(Name) {

            if (Name != null) {
                ValidationWindow(obj11 + Name, AlertType);
                //alert('Task Assigned to' + Name);
            }

            window.location.href('../Billing/PatientDueDetails.aspx');
        }
        
    </script>

</body>
</html>
