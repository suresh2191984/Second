<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Department.ascx.cs" Inherits="CommonControls_Department" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
            <ProgressTemplate>
                <div id="progressBackgroundFilter" class="a-center">
                </div>
                <div id="processMessage" class="a-center w-20p">
                    <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" 
                        meta:resourcekey="Rs_PleasewaitResource1" />
                    <br />
                    <br />
                    <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                        meta:resourcekey="img1Resource1" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:Panel ID="pnlLocation" Width="300px" runat="server" CssClass="w-100 modalPopup dataheaderPopup"
            Style="display: none" meta:resourcekey="pnlLocationResource1">
            <br />
            <table class="a-center">
                <tr>
                    <td>
                        <asp:Label ID="Rs_SelectDepartment" runat="server" Text="Select Department :" meta:resourcekey="Rs_SelectDepartmentResource1"></asp:Label>
                        <asp:DropDownList ID="ddlLocation" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlLocationResource1">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="h-20">
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn w-70" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" OnClick="btnOk_Click" meta:resourcekey="btnOkResource1" />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn w-70" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                    </td>
                </tr>
            </table>
            <br />
        </asp:Panel>
        <ajc:ModalPopupExtender ID="mpeAttributeLocation" runat="server" TargetControlID="btnDummy"
            PopupControlID="pnlLocation" CancelControlID="btnCancel" DropShadow="false" Drag="false"
            BackgroundCssClass="modalBackground" />
        <input type="button" id="btnDummy" runat="server" style="display: none;" />
        
       

    </ContentTemplate>
</asp:UpdatePanel>
