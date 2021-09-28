<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserRoleControl.ascx.cs" Inherits="CommonControls_UserRoleControl" %>

<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<table>


    <tr>
        <td>
            <asp:Label ID="Label1" runat="server" Text="Select Roles" 
                CssClass="defaultfontcolor" 
    meta:resourcekey="Label1Resource1" ></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlRoles"   CssClass ="ddlsmall" runat="server" 
                AutoPostBack="True" 
    OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged" 
    meta:resourcekey="ddlRolesResource1">
            </asp:DropDownList>
        </td>
    </tr>
</table>
