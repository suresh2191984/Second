<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SkinPiercingActivity.ascx.cs"
    Inherits="CommonControls_SkinPiercingActivity" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trSkinPiercingActivity" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblSkinPiercingActivity_1107" runat="server" Text="SkinPiercingActivity" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_1107" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_1107" Text="No" runat="server" GroupName="radioExtend" onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_1107" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_1107" runat="server" style="display: none">
                <table cellpadding="0" align="right" width="100%">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkTattoo" Text="Tattoo" runat="server"></asp:CheckBox>
                            <asp:CheckBox ID="chkBodyPiercing" Text="Body Piercing" runat="server"></asp:CheckBox>
                            <asp:CheckBox ID="chkEarPiercing" Text="Ear Piercing" runat="server"></asp:CheckBox>
                            <asp:CheckBox ID="chkAcupuncture" Text="Acupuncture" runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
