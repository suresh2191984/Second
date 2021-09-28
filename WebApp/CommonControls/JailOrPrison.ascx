<%@ Control Language="C#" AutoEventWireup="true" CodeFile="JailOrPrison.ascx.cs"
    Inherits="CommonControls_JailOrPrison" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>

<script type="text/javascript">
   
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trLockup" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblLockup_1111" runat="server" Text="Lockup,Jail Or Prison(for more than 72 hours)" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_1111" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_1111" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                      <%--  <asp:RadioButton ID="rdoUnknown_995" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />--%>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_1111" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td colspan="3">
                            <asp:TextBox ID="txtLockup" runat="server"></asp:TextBox>
                            <%--<asp:Label ID="lblOrigin" runat="server" Text="Country Of Origin">
                            </asp:Label>
                            <asp:DropDownList ID="ddlOrigin" runat="server">
                                <asp:ListItem Text="--Select--"></asp:ListItem>
                                <asp:ListItem Text="Africa"></asp:ListItem>
                            </asp:DropDownList>--%>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
