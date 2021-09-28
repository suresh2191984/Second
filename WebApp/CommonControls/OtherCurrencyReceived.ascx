<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OtherCurrencyReceived.ascx.cs"
    Inherits="CommonControls_OtherCurrencyReceived" %>
<table id="tbOtherCurr" runat="server">
    <tr id="tbAmountPayble" class="bg-row" runat="server">
        <td>
            <asp:Label ID="Rs_Amou_PayIn" runat="server" Text="Amount Payable In" 
                meta:resourcekey="Rs_Amou_PayInResource1"></asp:Label>
            <asp:Label ID="lblOtherCurrPaybleName" runat="server" 
                meta:resourcekey="lblOtherCurrPaybleNameResource1"></asp:Label>
            :
        </td>
        <td>
            <asp:Label ID="lblOtherCurrPaybleAmount" runat="server" Text="0" 
                meta:resourcekey="lblOtherCurrPaybleAmountResource1"></asp:Label>
            <input type="hidden" id="hdnOterCurrPayble" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Rs_Amou_RecIn" runat="server" Text="Amount Received In" 
                meta:resourcekey="Rs_Amou_RecInResource1"></asp:Label>
            <asp:Label ID="lblOtherCurrRecdName" runat="server" 
                meta:resourcekey="lblOtherCurrRecdNameResource1"></asp:Label>
            <input type="hidden" id="hdnOterCurrReceived" runat="server" />
            <input type="hidden" id="hdnOterCurrServiceCharge" runat="server" />
            :
        </td>
        <td>
            <asp:Label ID="lblOtherCurrRecdAmount" runat="server" Text="0" 
                meta:resourcekey="lblOtherCurrRecdAmountResource1"></asp:Label>
        </td>
    </tr>
</table>

<script>
    

</script>

