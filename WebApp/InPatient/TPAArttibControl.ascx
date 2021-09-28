<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TPAArttibControl.ascx.cs"
    Inherits="InPatient_TPAArttibControl" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
<table width="40%" border="0" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr>
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 19%;">
            <asp:Label ID="lblName" runat="server" Text="Name" 
                meta:resourcekey="lblNameResource1"></asp:Label>
        </td>
        <td style="width: 21%">
            <asp:TextBox ID="txtValue" runat="server" CssClass="Txtboxsmall" 
            Width="130px" style="margin-left: 0px" meta:resourcekey="txtValueResource1" ></asp:TextBox>
            <%--<ajc:FilteredTextBoxExtender ID="fltTextbox"  runat="server"></ajc:FilteredTextBoxExtender>--%>
        </td>
    </tr>
</table>
