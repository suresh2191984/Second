<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DiagnoseWithICD.ascx.cs" Inherits="CommonControls_DiagnoseWithICD" %>

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="trDiagnosis" runat="server" style="display: none;">
    <tr runat="server" style="display:block;" id="tdICDHeader">
        <td style="font-weight: bold; height: 20px; color: #000;" id="tdD" runat="server">
            
              <asp:Label ID="lblHeader" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Table ID="tblDiagnoseWithICD" runat="server" CellSpacing="4" CellPadding="3">
            </asp:Table>
        </td>
      
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
