<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Department.ascx.cs" Inherits="PlatFormControls_Department" %>
<asp:Panel ID="pnlLocation"  runat="server" meta:resourcekey="pnlLocationResource1">
    <br />
    <table class="a-center w-100p searchPanel">
        <tr>
            <td>
                <asp:Label ID="Rs_SelectDepartment" runat="server" Text="Select Department :" meta:resourcekey="Rs_SelectDepartmentResource1"></asp:Label>
                <asp:DropDownList ID="ddlLocation" runat="server" meta:resourcekey="ddlLocationResource1" CssClass="small">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn" 
                    onmouseout="this.className='btn'"  OnClick="btnOk_Click" meta:resourcekey="btnOkResource1" />
                
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" meta:resourcekey="btnCancel"  />
            </td>
        </tr>
    </table>
    <br />
</asp:Panel>
<ajc:ModalPopupExtender ID="mpeAttributeLocation" runat="server" TargetControlID="btnDummy"
    PopupControlID="pnlLocation" CancelControlID="btnCancel" DropShadow="false" Drag="false"
    BackgroundCssClass="modalBackground" />
<input type="button" id="btnDummy" runat="server" meta:resourcekey="btnDummy" class="hide" />
<asp:Panel ID="pnlRole"  runat="server" 
    meta:resourcekey="pnlRoleResource1" class="hide">
    <br />
    <table class="a-center">
        <tr>
            <td>
                <asp:Label ID="Rs_SelectOrganisation" runat="server" Text="Select Organization "
                    meta:resourcekey="Rs_SelectOrganisationResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlOrg" runat="server" CssClass="small" OnSelectedIndexChanged="ddlOrg_SelectedIndexChanged"
                    AutoPostBack="True" meta:resourcekey="ddlOrgResource1">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Rs_SelectRole" runat="server" Text="Select Role " meta:resourcekey="Rs_SelectRoleResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="small" OnSelectedIndexChanged="ddlRole_SelectedIndexChanged"
                    AutoPostBack="True" meta:resourcekey="ddlRoleResource1">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Rs_Location" runat="server" Text="Select Location " meta:resourcekey="Rs_LocationResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlLocation1" CssClass="small" runat="server" 
                    meta:resourcekey="ddlLocation1Resource1">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblTaskNotification" runat="server" Text=" Task Notification " meta:resourcekey="lblTaskNotification"></asp:Label>
            </td>
            <td>
                <asp:CheckBox ID="chkTaskNotification" runat="server" 
                    meta:resourcekey="chkTaskNotificationResource1" />
            </td>
        </tr>
        <tr>
            <td >
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td class="a-center" colspan="2">
                <asp:Button ID="btnRoleOK" runat="server" Text="OK" CssClass="btn" 
                    OnClick="btnRoleOK_Click" meta:resourcekey="btnRoleOKResource1" />
                
                <asp:Button ID="btnRoleCancel" runat="server" Text="Cancel" CssClass="btn" meta:resourcekey="btnRoleCancel"
                     />
            </td>
        </tr>
    </table>
    <br />
</asp:Panel>
<ajc:ModalPopupExtender ID="mpeLocationAndRole" runat="server" TargetControlID="btnRoleDummy"
    PopupControlID="pnlRole" CancelControlID="btnRoleCancel" DropShadow="false" Drag="false"
    BackgroundCssClass="modalBackground" />
<input type="button" id="btnRoleDummy" runat="server" class="hide" meta:resourcekey="btnRoleDummy"  />
<%-- </ContentTemplate>
</asp:UpdatePanel>--%>
