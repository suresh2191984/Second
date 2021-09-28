<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AttenderDetails.ascx.cs"
    Inherits="CommonControls_AttenderDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table border="0" cellpadding="0" cellspacing="2" width="100%" class="dataheader3">
    <tr>
        <td>
            <asp:Label ID="lblAttenderName" runat="server" Text="Attender Name" meta:resourcekey="lblAttenderNameResource1" />
        </td>
        <td>
            <asp:TextBox ID="txtATTName" runat="server" onblur="ConverttoUpperCase(this.id);"
                AutoCompleteType="DisplayName" MaxLength="55" meta:resourcekey="txtATTNameResource1"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="lblAddress" runat="server" Text="Address" meta:resourcekey="lblAddressResource1" />
        </td>
        <td>
            <asp:TextBox ID="txtAddress" runat="server" onblur="ConverttoUpperCase(this.id);"
                AutoCompleteType="DisplayName" MaxLength="55" meta:resourcekey="txtAddressResource1"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="lblRelation" runat="server" Text="Relationship" meta:resourcekey="lblRelationResource1" />
        </td>
        <td>
            <asp:DropDownList ID="ddlRelation" runat="server" meta:resourcekey="ddlRelationResource1">
            </asp:DropDownList>
        </td>
        <td>
            <asp:Label ID="lblContactno" runat="server" Text="Contact No" meta:resourcekey="lblContactnoResource1" />
        </td>
        <td>
            <asp:TextBox ID="txtContactNo" runat="server" MaxLength="20" AutoCompleteType="DisplayName"
                meta:resourcekey="txtContactNoResource1"></asp:TextBox>
            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtMobile"
                TargetControlID="txtContactNo" Enabled="True">
            </ajc:FilteredTextBoxExtender>
        </td>
    </tr>
</table>
