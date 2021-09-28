<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AbnormalBleedingDisorders.ascx.cs"
    Inherits="CommonControls_AbnormalBleedingDisorders" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trAbnormal" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblAbnormal_1099" runat="server" Text="Abnormal Bleeding Disorders"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_1099" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_1099" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_1099" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_1099" runat="server" style="display: none">
                <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                    <tr>
                        <td colspan="3">
                            <asp:TextBox ID="txtAbnormal" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>


