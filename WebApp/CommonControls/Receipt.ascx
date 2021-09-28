<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Receipt.ascx.cs" Inherits="CommonControls_Receipt" %>
<asp:Panel ID="pnlPrint" runat="server" Visible="False" 
    meta:resourcekey="pnlPrintResource1">
    <table>
        <tr>
            <td>
                <asp:Label ID="lDT" runat="server" meta:resourcekey="lDTResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="tCont" runat="server" meta:resourcekey="tContResource1"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Panel>
