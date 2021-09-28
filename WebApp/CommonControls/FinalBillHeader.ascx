<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FinalBillHeader.ascx.cs" Inherits="CommonControls_FinalBillHeader" %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr runat="server" id="trTpaname" style="display:none;">
        <td style="width: 100%" align="left" >
             <asp:Label ID="lblTpaText" runat="server" Text="Client / Insurance Provider:" 
                 style="font-size:small;font-weight: 700" meta:resourcekey="lblTpaTextResource1"></asp:Label>
             <asp:Label ID="lblTpaName" runat="server" Font-Bold="True" 
                 style="font-size:small;font-weight: 700" meta:resourcekey="lblTpaNameResource1"></asp:Label> 
             
        </td>
    </tr>
    <tr>
    <td style="width: 100%" align="left">
    <asp:Table ID="tblCRCPresc" runat="server" CellSpacing="0" CellPadding="1" 
            meta:resourcekey="tblCRCPrescResource1">
                            </asp:Table>
    </td>
    </tr>
</table>
