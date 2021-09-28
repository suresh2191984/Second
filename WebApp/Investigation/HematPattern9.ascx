<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HematPattern9.ascx.cs"
    Inherits="Investigation_HematPattern9" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<table>
    <tr>
        <td>
            <asp:CheckBox runat="server" ID="chkName"
                CssClass="defaultfontcolor" AutoPostBack="True" 
                OnCheckedChanged="chkName_CheckedChanged" meta:resourcekey="chkNameResource1" />
        </td>
        <td>
            <div id="dShow" runat="server" visible="false">
                <asp:TextBox ForeColor="Black" runat="server" CssClass="Txtboxsmall"
                    ID="txtValue" meta:resourcekey="txtValueResource1"></asp:TextBox>
            </div>
        </td>
        <td>
            <asp:HiddenField runat="server" ID="hidVal" />
        </td>
    </tr>
</table>
