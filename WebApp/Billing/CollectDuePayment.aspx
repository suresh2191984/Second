<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollectDuePayment.aspx.cs"
    Inherits="Billing_CollectDuePayment" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Due Collection Detail</title>
   <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script type="text/javascript">

//        function ShowAlertMsg(key) {
//            
//            var userMsg = SListForApplicationMessages.Get(key);
//            if (userMsg != null) {
//                alert(userMsg);
//            }
//            else if (key == "Billing\\CollectDuePayment.aspx.cs_1") {
//            alert('Due amount written-off successfully');
//            }
//            return true;
//        }
//
        function ShowAlertMsg(key) {

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else{
                alert('Due amount written-off successfully');
                return false;
            }
            return true;
        }
    
    
        function DefaultText() {

            document.getElementById('txtReceivedAmount').value = "";
        }
        function DueCheckValidation() {
            var returndatavalue = SaveValidation();
            if (returndatavalue == true) {
                var amtRec = document.getElementById('txtReceivedAmount').value == '' ? 0 : document.getElementById('txtReceivedAmount').value;
                document.getElementById('txtTotalAmount').value == '' ? 0 : document.getElementById('txtTotalAmount').value;
                if (document.getElementById('chkWriteoffdues').checked) {
                    if (Number(amtRec) > 0) {
                        if (checkedval()) {
                            if (CheckWriteoffdues()) {
                                return true;
                            }
                            return false;
                        }
                        return false;
                    }
                    else {
                        if (CheckWriteoffdues()) {
                            return true;
                        }
                        return false;
                    }
                }
                else {
                    if (checkedval()) {
                        return true;
                    }
                    return false;
                }
            }
            return false;
        }
        function checkedval() {
            if (document.getElementById('txtReceivedAmount').value == '' ||
                         Number(document.getElementById('txtReceivedAmount').value) <= 0) {

                userMsg = SListForApplicationMessages.Get('Billing\\CollectDuePayment.aspx_7');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Provide received amount');
                    return false;
                }
                return false;
            }
            if (Number(document.getElementById('txtReceivedAmount').value) >
                            Number(document.getElementById('txtTotalAmount').value)) {
                            userMsg = SListForApplicationMessages.Get('Billing\\CollectDuePayment.aspx_8');
                            if (userMsg != null) {
                                alert(userMsg);
                                return false;
                            }
                            else {
                                alert('Check received amount');
                                return false;
                            }
                document.getElementById('txtReceivedAmount').focus();
                return false;
            }
            return true;
        }
        function CheckWriteoffdues() {
            var total = document.getElementById('txtTotalAmount').value;
            var recamt = document.getElementById('txtReceivedAmount').value;
            var msg;
            var OrgCurrency = '<%= Session["OrgCurrency"]%>';
            msg = "Are you sure you want to Write-off due Amount " + OrgCurrency + " : " + (Number(total) - Number(recamt)) + "?";
            var agree = confirm(msg);
            if (agree)
                return true;
            else
                return false;
        }
        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            return true;
        }
        function DeleteAmountValue(tmpPaymentAmount, tmpTotalAmount, tmpServiceCharge) { }

    </script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSave">

    <script language="javascript" type="text/javascript">



        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {

            //            var sVal = document.getElementById('txtReceivedAmount').value;
            //            var sNetValue = document.getElementById('txtTotalAmount').value;
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


            if (Number(sNetValue) >= Number(sVal)) {
                sVal = format_number(sVal, 2);
                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                var pScrAmt = Number(pScr) * Number(CurrRate);
                var pAmt = Number(sVal) * Number(CurrRate);

                document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
                document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2)
                document.getElementById('txtReceivedAmount').value = pAmt;
                document.getElementById('hdnAmountReceived').value = pAmt;
                var pTotal = Number(Number(sNetValue)) * Number(CurrRate);


                document.getElementById('txtTotalAmount').value = format_number(Number(pTotal), 2);

                return true;
            }
            else {
            userMsg = SListForApplicationMessages.Get('Billing\\CollectDuePayment.aspx_9');
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                alert('Amount provided is greater than net amount');
                return false;
            }
                return false;
            }
        }


        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            //            var sVal = document.getElementById('txtReceivedAmount').value;
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

            document.getElementById('txtReceivedAmount').value = format_number(sVal, 2);
            document.getElementById('hdnAmountReceived').value = format_number(sVal, 2);


            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

            document.getElementById('txtTotalAmount').value = format_number(Number(pTotal), 2);

            //            var sNetValue = document.getElementById('txtTotalAmount').value;
            //            document.getElementById('txtTotalAmount').value = format_number(Number(sNetValue) - Number(ServiceCharge), 2);

        }



        function chkCreditPament() {

        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
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
                            </li>
                        </ul>
                        <table border="0" id="tbDueDetails" runat="server" cellpadding="0" cellspacing="0"
                            width="100%">
                            <tr>
                                <td>
                                    <uc6:DueDetail ID="ucDueDetail" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <label>
                                        <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                    </label>
                                    <asp:TextBox ID="txtServiceCharge" Enabled="False" runat="server" Text="0.00" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtServiceChargeResource1" />
                                    <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <label>
                                        <asp:Label ID="Rs_TotalDueAmount" Text="Total Due Amount" runat="server" meta:resourcekey="Rs_TotalDueAmountResource1"></asp:Label>
                                    </label>
                                    <asp:TextBox ID="txtTotalAmount" runat="server" Enabled="False" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtTotalAmountResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <label>
                                        <asp:Label ID="Rs_ReceivedAmount" Text="Received Amount" runat="server" meta:resourcekey="Rs_ReceivedAmountResource1"></asp:Label>
                                    </label>
                                    <asp:TextBox ID="txtReceivedAmount" runat="server" ReadOnly="True" CssClass="Txtboxsmall"
                                        meta:resourcekey="txtReceivedAmountResource1" />
                                    <asp:HiddenField ID="hdnAmountReceived" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="padding-right: 110px;">
                                    <label>
                                        <asp:Label ID="Rs_WriteoffdueAmount" Text="Write-off-due Amount" runat="server" meta:resourcekey="Rs_WriteoffdueAmountResource1"></asp:Label>
                                    </label>
                                    <asp:CheckBox ID="chkWriteoffdues" runat="server" meta:resourcekey="chkWriteoffduesResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc9:paymentType ID="PaymentType" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnSave" Text="Save" runat="server" CssClass="btn" 
                                        onmouseout="this.className='btn'" OnClick="btnWriteoffDues_Click" OnClientClick="return DueCheckValidation()"
                                        meta:resourcekey="btnSaveResource1" />
                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" 
                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                                <%-- --%>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">

        function SetOtherCurrValues() {

            pnetAmt = document.getElementById('txtTotalAmount').value == "" ? "0" : document.getElementById('txtTotalAmount').value;
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }

        GetCurrencyValues();
    
    </script>

</body>
</html>
