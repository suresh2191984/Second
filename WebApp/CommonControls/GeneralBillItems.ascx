<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GeneralBillItems.ascx.cs" Inherits="CommonControls_GeneralBillItems" %>
<script language="javascript" type="text/javascript">
    function selGBI()
    {
        var drpGBI = document.getElementById('<%= ddlGBI.ClientID %>');
        var GBIName = drpGBI.options[drpGBI.selectedIndex].text;
        if (GBIName == "--Select--") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\GeneralBillItems.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert('Please Select any one Bill Item'); }
            document.getElementById('<%= ddlGBI.ClientID %>').focus();
        }
        else {
            var amtVal = GBIName.split('<%= CurrencyName %>')[1].split('-')[1];
            CmdAddBillItemsType_onclick('GEN', drpGBI.value, 0, GBIName.split('<%=CurrencyName %>')[0].split(':')[0], 1, amtVal, amtVal);
        }
    }
</script>
<table id="tblGBI" runat="server">
<tr>
    <td>
        <asp:DropDownList ID="ddlGBI" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlGBIResource1">
        </asp:DropDownList>
    </td>
    <td>
        <input type="button" id="btnAdd" onclick="selGBI();"  class="btn" value="Add" />
    </td>
</tr>
</table>