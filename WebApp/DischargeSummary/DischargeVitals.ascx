<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DischargeVitals.ascx.cs" Inherits="DischargeSummary_DischargeVitals" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
 <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            
             <asp:Label ID="lblDV" runat="server" Font-Bold="True" 
                 meta:resourcekey="lblDVResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Table ID="tbDischargeVitals" runat="server" CellSpacing="0" BorderWidth="0px"
                CellPadding="8" meta:resourcekey="tbDischargeVitalsResource1">
            </asp:Table>
        </td>
    </tr>
   
</table>
