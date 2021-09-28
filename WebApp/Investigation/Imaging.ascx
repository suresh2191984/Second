<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Imaging.ascx.cs" Inherits="Investigation_Imaging" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table class="w-100p">
    <tr>
        <td class="a-center font12 h-20 w-10p" style="font-weight: normal; color: #000;">
            <asp:Label runat="server" ID="lblName" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %></u></a>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlenabled" runat="server" meta:resourcekey="pnlenabledResource1">
                <table>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblInvDetails" Text="Investigation Details" meta:resourcekey="lblInvDetailsResource1"></asp:Label>
                        </td>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ID="txtInvDetails" onkeyup="javascript:return setCompletedStatus(this.id);"
                                runat="server" CssClass="small" TextMode="MultiLine" meta:resourcekey="txtInvDetailsResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblinvFinidings" runat="server" Text="Investigation Findings" meta:resourcekey="lblinvFinidingsResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtinvFinidings" onkeyup="javascript:return setCompletedStatus(this.id);"
                                CssClass="small" runat="server" TextMode="MultiLine" meta:resourcekey="txtinvFinidingsResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblImpression" runat="server" Text="Impression" meta:resourcekey="lblImpressionResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtImpression" onkeyup="javascript:return setCompletedStatus(this.id);"
                                CssClass="small" runat="server" TextMode="MultiLine" meta:resourcekey="txtImpressionResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="bold font10 h-8 w-20p" style="color: #000;">
                            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                                meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:TextBox runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                ID="txtReason" TextMode="MultiLine" CssClass="textbox_pattern small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
            </ajc:AutoCompleteExtender>
            <asp:HiddenField ID="hdnRemarksID" runat="server" />
            <asp:Label ID="lblMedRemarks" Text="Medical Remarks" CssClass="bold font10 h-8 w-20p"
                runat="server" Style="color: #000;" 
                meta:resourcekey="lblMedRemarksResource1"></asp:Label><br />
            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                onkeyup="javascript:return setCompletedStatus(this.id);" TabIndex="-1" TextMode="MultiLine"
                CssClass="textbox_pattern small" meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
            </ajc:AutoCompleteExtender>
            <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
            <table>
                <tr>
                    <td>
                        &nbsp;
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
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" onChange="javascript:ShowStatusReason(this.id);"
                            CssClass="ddlsmall" meta:resourcekey="ddlstatusResource1">
                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                        CssClass="ddlsmall" onmousedown="expandDropDownList(this);" 
                                        onblur="collapseDropDownList(this);" 
                                        meta:resourcekey="ddlStatusReasonResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox" class="w-100">
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
        <td>
            &nbsp;
        </td>
    </tr>
    <asp:HiddenField runat="server" ID="hidVal" />
</table>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
