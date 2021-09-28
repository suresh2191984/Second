<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DepositUsage.ascx.cs"
    Inherits="UserControl_DepositUsage" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    function setValueToTargetControl() {
        if (document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value == "") {
            document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value = 0.00;
        }

        if (document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value != "") {
            if (document.getElementById('<%=hdnTargetControlValue.ClientID %>').value != "") {
                document.getElementById(document.getElementById('<%=hdnTargetControlName.ClientID %>').value).value = parseFloat(parseFloat(document.getElementById(document.getElementById('<%=hdnTargetControlName.ClientID %>').value).value) - parseFloat(document.getElementById('<%=hdnTargetControlValue.ClientID %>').value)).toFixed(2);
                document.getElementById(document.getElementById('<%=hdnDisplayControlName.ClientID %>').value).value = parseFloat(parseFloat(document.getElementById(document.getElementById('<%=hdnDisplayControlName.ClientID %>').value).value) - parseFloat(document.getElementById('<%=hdnTargetControlValue.ClientID %>').value)).toFixed(2);
            }
            if (parseFloat(document.getElementById('<%=lblDepositBalance.ClientID %>').innerText) < parseFloat(document.getElementById('DepositUsageCtrl_txtAmountToBeUsed').value)) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\DepositUsage.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else { alert("Please check the Net Value, Amount Received and re-enter Amount to be used."); }
                document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value = parseFloat(0).toFixed(2);
                document.getElementById('<%=txtAmountToBeUsed.ClientID %>').select();
            }
            if (parseFloat(parseFloat(parseFloat(document.getElementById(document.getElementById('<%=hdnTargetControlName.ClientID %>').value).value) + parseFloat(document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value)).toFixed(2)) > parseFloat(parseFloat(document.getElementById(document.getElementById('<%=hdnBaseControlName.ClientID %>').value).value).toFixed(2))) {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\DepositUsage.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert("Please check the Net Value, Amount Received and re-enter Amount to be used.");
                }
                document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value = parseFloat(0).toFixed(2);
                document.getElementById('<%=txtAmountToBeUsed.ClientID %>').select();
            }
            else {

                document.getElementById(document.getElementById('<%=hdnTargetControlName.ClientID %>').value).value = parseFloat(parseFloat(document.getElementById(document.getElementById('<%=hdnTargetControlName.ClientID %>').value).value) + parseFloat(document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value)).toFixed(2);
                document.getElementById(document.getElementById('<%=hdnDisplayControlName.ClientID %>').value).value = parseFloat(parseFloat(document.getElementById(document.getElementById('<%=hdnDisplayControlName.ClientID %>').value).value) + parseFloat(document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value)).toFixed(2);
                document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value = parseFloat(document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value).toFixed(2);
            }

            document.getElementById('<%=hdnTargetControlValue.ClientID %>').value = parseFloat(document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value).toFixed(2);
            document.getElementById('<%=hdnDepositCurrentUsage.ClientID %>').value = parseFloat(document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value).toFixed(2);

        }
        if (typeof doCalcReimburse == 'function') {
            doCalcReimburse();

        }
        if (typeof SetReceivedOtherCurr == 'function') {
            var ConValue = "<%=OtherCurrencyControlID %>";
            var pNewAmt = Number(document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value) - Number(document.getElementById('<%=hdnOldAmountUsed.ClientID %>').value);
            var pOldAmt = getOtherCurrAmtValues("REC", ConValue);

            var pNetAmt = Number(pOldAmt) + Number(pNewAmt);
            SetReceivedOtherCurr(pNetAmt, 0, ConValue);
        }


    }
    function Depositclear() {
        if ((document.getElementById(document.getElementById('<%=hdnDisplayControlName.ClientID %>').value).value) == '') {
            document.getElementById(document.getElementById('<%=hdnDisplayControlName.ClientID %>').value).value = 0;
        }
        document.getElementById(document.getElementById('<%=hdnDisplayControlName.ClientID %>').value).value = parseFloat(parseFloat(document.getElementById(document.getElementById('<%=hdnDisplayControlName.ClientID %>').value).value) - parseFloat(document.getElementById('<%=hdnTargetControlValue.ClientID %>').value)).toFixed(2);
        document.getElementById('<%=hdnTargetControlValue.ClientID %>').value = parseFloat(0).toFixed(2);
        document.getElementById(document.getElementById('<%=hdnTargetControlName.ClientID %>').value).value = parseFloat(0).toFixed(2);
        document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value = parseFloat(0).toFixed(2);
        document.getElementById('<%=hdnDepositCurrentUsage.ClientID %>').value = parseFloat(0).toFixed(2);
        document.getElementById('<%=hdnOldAmountUsed.ClientID %>').value = parseFloat(0).toFixed(2);


    }
    function unCheckDepositUsage() {
        document.getElementById('<%=chkUseDeposit.ClientID %>').checked = false;
        document.getElementById('<%=tdDeposit.ClientID %>').style.display = "none";
        Depositclear();
    }
    function showHideUsageTab() {
        if (document.getElementById('<%=chkUseDeposit.ClientID %>').checked) {
            document.getElementById('<%=usageTab.ClientID %>').style.display = "block";
        }
        else {
            document.getElementById('<%=usageTab.ClientID %>').style.display = "none";
        }
        Depositclear();
    }

    function setDepositValues(patientID, depositID, totalAmountDeposited, totalDepositUsed) {
        document.getElementById('<%=hdnPatientID.ClientID %>').value = patientID;
        document.getElementById('<%=hdnDepositID.ClientID %>').value = depositID;

        document.getElementById('<%=hdnAmountDeposited.ClientID %>').value = parseFloat(totalAmountDeposited).toFixed(2);
        document.getElementById('<%=hdnDepositUsed.ClientID %>').value = parseFloat(totalDepositUsed).toFixed(2);
        document.getElementById('<%=hdnDepositBalance.ClientID %>').value = parseFloat(parseFloat(totalAmountDeposited).toFixed(2) - parseFloat(totalDepositUsed).toFixed(2)).toFixed(2);

        document.getElementById('<%=lblAmountDeposited.ClientID %>').innerText = parseFloat(totalAmountDeposited).toFixed(2);
        document.getElementById('<%=lblDepositUsed.ClientID %>').innerText = parseFloat(totalDepositUsed).toFixed(2);
        document.getElementById('<%=lblDepositBalance.ClientID %>').innerText = parseFloat(parseFloat(totalAmountDeposited).toFixed(2) - parseFloat(totalDepositUsed).toFixed(2)).toFixed(2);
        if (totalAmountDeposited > 0) {
            document.getElementById('<%=tdDeposit.ClientID %>').style.display = "block";
        }
    }
    function SetPerValues() {
        document.getElementById('<%=hdnOldAmountUsed.ClientID %>').value = document.getElementById('<%=txtAmountToBeUsed.ClientID %>').value;
    }
</script>

<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td runat="server" id="tdDeposit" style="display: none;">
            <asp:CheckBox ID="chkUseDeposit" runat="server" Text="Use Deposit" Font-Bold="True"
                onclick="javascript:showHideUsageTab();" meta:resourcekey="chkUseDepositResource1" />
        </td>
    </tr>
    <tr>
        <td>
            <table id="usageTab" runat="server" cellpadding="3" cellspacing="0" border="0" width="100%"
                style="display: none;">
                <tr style="display: none;">
                    <td>
                        <asp:Label ID="Rs_SwipeyourCardhere" runat="server" Text="Swipe your Card here:"
                            meta:resourcekey="Rs_SwipeyourCardhereResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCardNo" runat="server" CssClass="textBoxRightAlign" meta:resourcekey="txtCardNoResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_TotalAmountDeposited" runat="server" Text="Total Amount Deposited:"
                            meta:resourcekey="Rs_TotalAmountDepositedResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAmountDeposited" Font-Bold="True" runat="server" meta:resourcekey="lblAmountDepositedResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_TotalDepositUsed" runat="server" Text="Total Deposit Used:" meta:resourcekey="Rs_TotalDepositUsedResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDepositUsed" Font-Bold="True" runat="server" meta:resourcekey="lblDepositUsedResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_AvailableDepositBalance" runat="server" Text="Available Deposit Balance:"
                            meta:resourcekey="Rs_AvailableDepositBalanceResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDepositBalance" Font-Bold="True" runat="server" meta:resourcekey="lblDepositBalanceResource1"></asp:Label>
                    </td>
                </tr>
                <tr style="display: none;" id="trRefund" runat="server">
                    <td>
                        <asp:Label ID="Rs_RefundedDepositAmount" Text="Refunded Deposit Amount" runat="server"
                            meta:resourcekey="Rs_RefundedDepositAmountResource1" />:
                    </td>
                    <td>
                        <asp:Label ID="lblRefundAmt" Font-Bold="True" runat="server" meta:resourcekey="lblRefundAmtResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_EntertheAmounttobeused" runat="server" Text="Enter the Amount to be used:"
                            meta:resourcekey="Rs_EntertheAmounttobeusedResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmountToBeUsed" Width="90px" onfocus="SetPerValues();" runat="server"
                            CssClass="textBoxRightAlign" value="0.00"    onkeypress="return ValidateOnlyNumeric(this);"  
                            onblur="javascript:setValueToTargetControl();" meta:resourcekey="txtAmountToBeUsedResource1"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdnBaseControlName" runat="server" />
            <asp:HiddenField ID="hdnTargetControlName" runat="server" />
            <asp:HiddenField ID="hdnDisplayControlName" runat="server" />
            <asp:HiddenField ID="hdnTargetControlValue" Value="0.00" runat="server" />
            <asp:HiddenField ID="hdnPatientID" runat="server" />
            <asp:HiddenField ID="hdnDepositID" runat="server" />
            <asp:HiddenField ID="hdnAmountDeposited" runat="server" />
            <asp:HiddenField ID="hdnDepositUsed" runat="server" />
            <asp:HiddenField ID="hdnDepositBalance" runat="server" />
            <asp:HiddenField ID="hdnDepositCurrentUsage" runat="server" />
            <asp:HiddenField ID="hdnOldAmountUsed" Value="0.00" runat="server" />
        </td>
    </tr>
</table>
