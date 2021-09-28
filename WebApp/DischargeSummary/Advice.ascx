<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Advice.ascx.cs" Inherits="DischargeSummary_Advice" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr align ="left">
   
        <td id="tdGeneral" runat="server" style="display:none">
          <asp:Label ID ="lbltitle"  Text="General Advice :" runat ="server"  Font-Bold ="true" ></asp:Label>
            <asp:Label ID="lblAdvice" runat="server" Font-Bold="True" meta:resourcekey="lblAdviceResource1"></asp:Label>
        </td>
    </tr>
    <tr>
  
        <td id="tdGeneralValue" runat="server" style="display:none">
            <asp:Table ID="tblAdvice" runat="server" CellSpacing="0" meta:resourcekey="tblAdviceResource1">
            </asp:Table>
        </td>
    </tr>
    <tr>
        <td id="tdNutritionH" runat="server" style="display:none">
            <asp:Label ID="lblNutrition" runat="server" Font-Bold="True"  Text="Nutrition Advice"></asp:Label>
        </td>
    </tr>
    <tr>
        <td id="tdNutValue" runat="server" style="display:none">
            <asp:Table ID="tblNutAdv" runat="server" CellSpacing="0">
            </asp:Table>
        </td>
    </tr>
    <tr runat="server" style="display: none;" id="trGeneralAdvice">
        <td>
            <asp:Label ID="Rs_Info" Text="Report to hospital in case of the following issues:"
                runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label><br />
            <asp:Table ID="tblGeneralAdvice" runat="server" CellSpacing="0" meta:resourcekey="tblGeneralAdviceResource1">
            </asp:Table>
        </td>
    </tr>
</table>
