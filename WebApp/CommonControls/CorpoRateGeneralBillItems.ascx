<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CorpoRateGeneralBillItems.ascx.cs" Inherits="CommonControls_CorpoRateGeneralBillItems" %>
<script language="javascript" type="text/javascript">
    function selGBI()
    {
        var drpGBI = document.getElementById('<%= ddlGBI.ClientID %>');
        var GBIName = drpGBI.options[drpGBI.selectedIndex].text;
        var GBI = document.getElementById('<%= hdnddlGBI.ClientID %>').value.split('^');
        //---------------------------------GeneralBillItems Dropdown
        for (var i = 0; i < GBI.length - 1; i++) {
            var GBIVALUE = GBI[i];
            var GBISplit = GBIVALUE.split(':');
            if (GBISplit[0].trim() == GBIName) {
                var GBIName = GBIVALUE;
            }
        }
        // ---------------------------------------------------------
        if (GBIName == "--Select--") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\CorpoRateGeneralBillItems.ascx_1');
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
        <asp:HiddenField ID="hdnddlGBI" runat="server" />
    </td>
    <td>
        <input type="button" id="btnAdd" onclick="selGBI();"  class="btn" value="Add" />
    </td>
</tr>
</table>

