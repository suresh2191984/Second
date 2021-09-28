<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReminderDisplay.ascx.cs"
    Inherits="CommonControls_ReminderDisplay" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript">
    function CheckDeferDate() {
        var Information = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") : "Information";
        var userMsg = SListForAppMsg.Get("CommonControls_ReminderDisplay_ascx_01") != null ? SListForAppMsg.Get("CommonControls_ReminderDisplay_ascx_01") : "Enter The Defer Date";
        if (document.getElementById('ReminderDisplay1_gvRemainder_ctl02_txtDeferDate').value == '') {
    
            if (userMsg != null) {
                //alert(userMsg);
                ValidationWindow(UserMsg, Information);
            } else {
            ValidationWindow(UserMsg, Information);
                //alert("Enter The Defer Date");
            }
            document.getElementById('ReminderDisplay1_gvRemainder_ctl02_txtDeferDate').focus();
            return false;
        }
        return true;
    } 
</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table class="w-100p">
            <tr>
                <td>
                    <asp:Label ID="lblRemainderDetail" runat="server" Text="Reminder Display" 
                        CssClass="tdHeaderBGColor" meta:resourcekey="lblRemainderDetailResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="defaultfontcolor w-100p">
                    <asp:GridView ID="gvRemainder" runat="server" CssClass="gridView w-96p m-auto" AutoGenerateColumns="False"
                        OnRowCommand="gvRemainder_RowCommand" OnRowCancelingEdit="gvRemainder_RowCancelingEdit"
                        OnRowDataBound="gvRemainder_RowDataBound" meta:resourcekey="gvRemainderResource1">
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:Label ID="lblRemainderID" runat="server" Text='<%# Bind("ReminderID") %>' 
                                        meta:resourcekey="lblRemainderIDResource1"></asp:Label>
                                </ItemTemplate>
                                <ControlStyle></ControlStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="remindDate" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Remainder date"
                                meta:resourcekey="BoundFieldResource1">
                                <HeaderStyle CssClass="w-10p" />
                                <ItemStyle CssClass="w-10p" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Notes" HeaderText="Notes" meta:resourcekey="BoundFieldResource2">
                                <HeaderStyle CssClass="w-35p" />
                                <ItemStyle CssClass="w-35p" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Close" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Button ID="btnClose" runat="server" Text="Close" CommandName="Close" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" meta:resourcekey="btnCloseResource1" />
                                </ItemTemplate>
                                <HeaderStyle CssClass="w-4p" />
                                <ItemStyle CssClass="w-4p a-center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Defer Date" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:Button Text="Select" ID="btnShow" runat="server" CommandName="ShowDefer" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" meta:resourcekey="btnShowResource1" />
                                </ItemTemplate>
                                <HeaderStyle CssClass="w-4p" />
                                <ItemStyle CssClass="a-center w-4p" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Set Defer Date" meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:Panel ID="pnlDefer" runat="server" Visible="False" CssClass="w-100p" 
                                        meta:resourcekey="pnlDeferResource1">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-32p">
                                                    <asp:TextBox ID="txtDeferDate" runat="server" CssClass="small" TabIndex="3" 
                                                        size="8" ValidationGroup="MKE" meta:resourcekey="txtDeferDateResource1" />
                                                    <asp:ImageButton ImageUrl="~/images/Calendar_scheduleHS.png" ID="ibtnDefer" 
                                                        runat="server" meta:resourcekey="ibtnDeferResource1" />
                                                </td>
                                                <td class="w-31p">
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtDeferDate"
                                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtDeferDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDeferDate"
                                                        PopupButtonID="ibtnDefer" Format="dd/MM/yyyy" Enabled="True" />
                                                </td>
                                                <td class="w-18p">
                                                    <asp:Button ID="btnSave" runat="server" CommandName="Defer" Text="Defer" OnClientClick="return CheckDeferDate()"
                                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                        meta:resourcekey="btnSaveResource1" />
                                                </td>
                                                <td class="w-19p">
                                                    <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn"
                                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                                </td>
                                            </tr>
                                        </table
                                    </asp:Panel>
                                </ItemTemplate>
                                <HeaderStyle CssClass="w-50p"></HeaderStyle>
                                <ItemStyle CssClass="w-47p" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <input type="hidden" id="hdnSelectedRowIndex" runat="server" value="-1" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
