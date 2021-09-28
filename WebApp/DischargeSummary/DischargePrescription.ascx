<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DischargePrescription.ascx.cs"
    Inherits="DischargeSummary_DischargePrescription" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
 <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td >
           
            <asp:Label ID="lblDP" runat="server" Font-Bold="True" 
                meta:resourcekey="lblDPResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Table ID="tblprescription" runat="server" CellSpacing="0" CellPadding="7" 
                meta:resourcekey="tblprescriptionResource1">
            </asp:Table>
        </td>
    </tr>
   
</table>
