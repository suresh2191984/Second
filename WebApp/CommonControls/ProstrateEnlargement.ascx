<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProstrateEnlargement.ascx.cs"
    Inherits="CommonControls_ProstrateEnlargement" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>

<script type="text/javascript">
   
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trProstrateEnlargement" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblProstrateEnlargement_958" runat="server" Text="ProstrateEnlagement" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_958" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_958" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_958" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_958" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td colspan="3">
                            <asp:TextBox ID="txtProstrateEnlargement" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
