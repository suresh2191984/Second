<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TreatmentPlan.ascx.cs"
    Inherits="DischargeSummary_TreatmentPlan" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            
            <asp:Label ID="lblTP" runat="server" Font-Bold="true"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Table ID="tblPlan" runat="server" CellSpacing="0" CellPadding="4">
            </asp:Table>
        </td>
    </tr>
   
</table>
