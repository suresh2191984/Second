<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FluidPattern.ascx.cs"
    Inherits="Investigation_FluidPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>
<table class="style1">
    <tr>
        <td>
            <asp:Label ID="lblName" runat="server" Text="Label" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>
        </td>
        <td>
            &nbsp;
        </td>
        <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
            <%=Resources.Investigation_ClientDisplay.Investigation_FluidPattern_ascx_01 %> &nbsp;
            <asp:TextBox ForeColor="Black" ToolTip="Technical Remarks" Font-Bold="true" ID="txtReason"
                runat="server" TextMode="MultiLine" CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
            </ajc:AutoCompleteExtender>
            <asp:HiddenField ID="hdnRemarksID" runat="server" />
        </td>
        <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
           <%=Resources.Investigation_ClientDisplay.Investigation_FluidPattern_ascx_02 %> &nbsp;
            <asp:TextBox ForeColor="Black" ToolTip="Medical Remarks" Font-Bold="true" runat="server"
                ID="txtMedRemarks" TabIndex="-1" TextMode="MultiLine" CssClass="small"
			meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
            </ajc:AutoCompleteExtender>
            <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            <table>
                <tr>
                    <td>
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                            meta:resourcekey="ddlstatusResource1">
                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="font10 h-10" style="font-weight: normal; color: #000;">
                        <table id="tdInvStatusReason1" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblReason" Text="Reason" runat="server" 
                                        meta:resourcekey="lblReasonResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOpinionUser" runat="server" Text="User" 
                                        meta:resourcekey="lblOpinionUserResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                        CssClass="ddlsmall"  onmousedown="expandDropDownList(this);"
                                        onblur="collapseDropDownList(this);" 
                                        meta:resourcekey="ddlStatusReasonResource1">
                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox w-100">
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddlsmall" meta:resourcekey="ddlOpinionUserResource1">
                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlEnable" runat="server" meta:resourcekey="pnlEnableResource1">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Specimen Volume" meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtValue" runat="server" CssClass="small"
                                meta:resourcekey="txtValueResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ForeColor="Black" Font-Bold="true" ID="lblUOM" runat="server" meta:resourcekey="lblUOMResource1"></asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Color" meta:resourcekey="Label3Resource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" runat="server" ID="ddlData1"
                                meta:resourcekey="ddlData1Resource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Appearance" meta:resourcekey="Label5Resource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" runat="server" ID="ddlData2"
                                meta:resourcekey="ddlData2Resource1">
                            </asp:DropDownList>
                            <asp:HiddenField runat="server" ID="hidVal" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
