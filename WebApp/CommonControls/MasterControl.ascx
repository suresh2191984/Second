<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MasterControl.ascx.cs"
    Inherits="CommonControls_MasterControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script language="javascript" type="text/javascript">
    function showModelPopup() {
        var mPopup = $find('<%= mdlMaster.ClientID %>');
        mPopup.show();
        return false;
    }
</script>

<asp:Button ID="hdnMaster" runat="server" Style="display: none" meta:resourcekey="hdnMasterResource1" />
<%--<asp:Button runat="server" id="hdnMaster" />--%>
<a href="#" onclick="javascript:showModelPopup()" style="font-size: 13px; color: Red">
    <asp:Label ID="lblName" Text="Add new" runat="server" meta:resourcekey="lblNameResource1" /></a>
<ajc:ModalPopupExtender ID="mdlMaster" runat="server" BackgroundCssClass="modalBackground"
    PopupControlID="pnlMaster" TargetControlID="hdnMaster" DynamicServicePath=""
    Enabled="True">
</ajc:ModalPopupExtender>
<asp:Panel ID="pnlMaster" BorderWidth="1px" Width="30%" CssClass="modalPopup dataheaderPopup"
    runat="server" meta:resourcekey="pnlMasterResource1">
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="Rs_EnterTestname" runat="server" Text="Enter Test name :" Font-Bold="True"
                    meta:resourcekey="Rs_EnterTestnameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtName" runat="server" meta:resourcekey="txtNameResource1"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Button ID="btnSave" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                    onmouseover="this.className='btn btnhov'" Text="Save" OnClick="btnSave_Click"
                    meta:resourcekey="btnSaveResource1" />
            </td>
            <td align="left">
                <asp:Button ID="btnCancel" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                    onmouseover="this.className='btn btnhov'" Text="Close" meta:resourcekey="btnCancelResource1" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label runat="server" ID="lblStatus" meta:resourcekey="lblStatusResource1"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Panel>
