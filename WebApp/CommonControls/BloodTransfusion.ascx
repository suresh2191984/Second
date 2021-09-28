<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BloodTransfusion.ascx.cs"
    Inherits="CommonControls_BloodTransfusion" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trBloodTransfusion" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblBloodTransfusion_961" runat="server" Text="BloodTransfusion" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_961" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_961" Text="No" runat="server" GroupName="radioExtend" onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_961" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_961" runat="server" style="display: none">
                <table cellpadding="0" align="right" width="100%">
                    <tr>
                        <td>
                            <asp:TextBox ID="txtBloodTransfusion" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
