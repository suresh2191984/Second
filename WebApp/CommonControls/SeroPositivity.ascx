<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SeroPositivity.ascx.cs"
    Inherits="CommonControls_SeroPositivity" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
--%>

<script type="text/javascript">
   
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trSeroPositivity" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblSeroPositivity_949" runat="server" Text="SeroPositivity" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_949" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_949" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_949" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr align="left">
        <td>
        </td>
        <td align="left">
            <div id="divrdoYes_949" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkHiv" Text="HIV" runat="server" />
                            <asp:CheckBox ID="chkHepititisC" Text="HepititisC" runat="server" />
                            <asp:CheckBox ID="chkHepititisB" Text="HepititisB" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
