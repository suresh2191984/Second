<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UnprotectedSex.ascx.cs"
    Inherits="CommonControls_UnprotectedSex" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>

<script type="text/javascript">
   
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trUnprotectedSex" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblUnprotectedSex_1102" runat="server" Text="Unprotected sex with Non-Spouse" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_1102" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_1102" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_1102" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_1102" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td colspan="3">
                            <asp:TextBox ID="txtUnprotectedSex" runat="server"></asp:TextBox>
                            <asp:Label ID="lblOrigin" runat="server" Text="Country Of Origin">
                            </asp:Label>
                            <asp:DropDownList ID="ddlOrigin" runat="server">
                                <asp:ListItem Text="--Select--"></asp:ListItem>
                                <asp:ListItem Text="Africa"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
