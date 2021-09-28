<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IPBreakupAmount.ascx.cs"
    Inherits="CommonControls_IPBreakupAmount" %>
<table border="1" runat="server" style="width: 100%; height: 132px;
    border-color: Red;">
    <tr>
        <td colspan="2" align="center">
            <b>Break-up for amount to be received</b>
        </td>
    </tr>
    <tr>
        <td style="width: 80%;" align="left">
            <asp:Label ID="lblNonReimbAmt" Text="Towards NonReimbursable Item" 
                runat="server" meta:resourcekey="lblNonReimbAmtResource1"></asp:Label>
        </td>
        <td style="width: 20%;" align="right">
            <asp:Label ID="lblNonReimbAmttxt" runat="server" 
                meta:resourcekey="lblNonReimbAmttxtResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="left">
            <asp:Label ID="lblCopayament" Text="Towards Co-Payment" runat="server" 
                meta:resourcekey="lblCopayamentResource1"></asp:Label>
        </td>
        <td align="right">
            <asp:Label ID="lblCopayamenttxt" runat="server" 
                meta:resourcekey="lblCopayamenttxtResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="left">
            <asp:Label ID="lblPreAuthAmt" Text="Towards Difference between Pre-Auth & Medical Items"
                runat="server" meta:resourcekey="lblPreAuthAmtResource1"></asp:Label>
        </td>
        <td align="right">
            <asp:Label ID="lblPreAuthAmttxt" runat="server" 
                meta:resourcekey="lblPreAuthAmttxtResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="right">
            <asp:Label ID="lblTotal" Text="Total" runat="server" Font-Bold="True" 
                meta:resourcekey="lblTotalResource1"></asp:Label>
        </td>
        <td align="right">
            <asp:Label ID="lblTotaltxt" runat="server" Font-Bold="True" 
                meta:resourcekey="lblTotaltxtResource1"></asp:Label>
        </td>
    </tr>
</table>

<script type="text/javascript">
 function BreakAmountDisplay(lblNonReimbAmttxt,lblCopayamenttxt,lblPreAuthAmttxt,lblTotaltxt)
 {
    document.getElementById('<%= lblNonReimbAmttxt.ClientID %>').innerHTML=lblNonReimbAmttxt;
    document.getElementById('<%= lblCopayamenttxt.ClientID %>').innerHTML=lblCopayamenttxt;
    document.getElementById('<%= lblPreAuthAmttxt.ClientID %>').innerHTML=lblPreAuthAmttxt;
    document.getElementById('<%= lblTotaltxt.ClientID %>').innerHTML=lblTotaltxt;
    ToTargetFormat($('#'+'<%= lblNonReimbAmttxt.ClientID %>'));
    ToTargetFormat($('#'+'<%= lblCopayamenttxt.ClientID %>'));
    ToTargetFormat($('#'+'<%= lblPreAuthAmttxt.ClientID %>'));
    ToTargetFormat($('#'+'<%= lblTotaltxt.ClientID %>'));
 }
</script>
