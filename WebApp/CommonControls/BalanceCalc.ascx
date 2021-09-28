<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BalanceCalc.ascx.cs" Inherits="CommonControls_BalanceCalc" %>
<table>
    <tr>
        <td>
            <asp:Label ID="lblEnterAmount" runat="server" Text="Enter Given Amount" meta:resourcekey="lblEnterAmount1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtGivenAmount" Enabled="false" onchange="javascript:BalaceCalculation();" Style="text-align: right"
                runat="server" CssClass="textBoxRightAlign" Text="0.00" meta:resourcekey="txtGivenAmount1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblBalanceAmount" runat="server" Text="Balance Amount" meta:resourcekey="lblBalanceAmount1"></asp:Label>
        </td>
        <td align="right">
            <asp:Label ID="lblBalanceAmountTxt" runat="server" Font-Bold="True" ForeColor="Red"
                Text="0.00" meta:resourcekey="lblBalanceAmountTxt1"></asp:Label>
            <asp:HiddenField ID="hdnBalanceAmount" runat="server" Value="0" />
        </td>
    </tr>
    <asp:HiddenField ID="hdnBalancectrlNetValue" runat="server" Value="0" />
</table>
<script type="text/javascript" language="javascript">
    function BalaceCalculation() {
        var TotalNetvalue = document.getElementById('<%= hdnBalancectrlNetValue.ClientID %>').value;  //ToInternalFormat($('#<%= hdnBalancectrlNetValue.ClientID %>'));
        var GivenAmount = ToInternalFormat($('#<%= txtGivenAmount.ClientID %>'));
        var BalanceToGive = Number(GivenAmount) - Number(TotalNetvalue);
        if (Number(BalanceToGive) <= 0) {
            document.getElementById('<%= hdnBalanceAmount.ClientID %>').value = "0.00";
            settoPaymentControl(ToTargetFormat($('#<%= txtGivenAmount.ClientID %>')));
        }
        else {
            document.getElementById('<%= hdnBalanceAmount.ClientID %>').value = BalanceToGive;
            settoPaymentControl(ToTargetFormat($('#<%= hdnBalancectrlNetValue.ClientID %>')));
        }
        document.getElementById('<%= lblBalanceAmountTxt.ClientID %>').innerHTML = parseFloat(ToTargetFormat($('#<%= hdnBalanceAmount.ClientID %>'))).toFixed(2);
    }
    function setNetToBalanceControl(Netvalue) {
        document.getElementById('<%= txtGivenAmount.ClientID %>').value = 0.00;
        document.getElementById('<%= lblBalanceAmountTxt.ClientID %>').innerHTML = '0.00';
        settoPaymentControl(ToTargetFormat($('#<%= txtGivenAmount.ClientID %>')));
        if (Number(Netvalue) > 0) {
            document.getElementById('<%= hdnBalancectrlNetValue.ClientID %>').value = Netvalue;
            document.getElementById('<%= txtGivenAmount.ClientID %>').disabled = false;
        }
        else {
            document.getElementById('<%= hdnBalancectrlNetValue.ClientID %>').value = 0
            document.getElementById('<%= txtGivenAmount.ClientID %>').disabled = true;
        }
    }
    function ClearBalanceCalcControl() {
        document.getElementById('<%= txtGivenAmount.ClientID %>').value = 0.00;
        document.getElementById('<%= txtGivenAmount.ClientID %>').disabled = true;
        document.getElementById('<%= hdnBalancectrlNetValue.ClientID %>').value = 0;
        document.getElementById('<%= hdnBalanceAmount.ClientID %>').value = 0;
    }
</script>