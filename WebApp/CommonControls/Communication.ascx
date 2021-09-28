<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Communication.ascx.cs"
    Inherits="CommonControls_Communication" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table border="0" id="tblMsgCount" runat="server">
    <tr>
        <td align="center">
            <asp:LinkButton ID="lblCount" Text='' Font-Bold="True" runat="server" OnClick="lblCount_Click"></asp:LinkButton>
        </td>
    </tr>
</table>
