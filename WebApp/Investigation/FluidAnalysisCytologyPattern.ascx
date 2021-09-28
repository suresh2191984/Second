<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FluidAnalysisCytologyPattern.ascx.cs"
    Inherits="Investigation_FluidAnalysisCytologyPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table class="w-100p">
    <tr>
        <td class="font12 h-20" style="font-weight: normal; color: #000;" colspan="3">
            <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08%></u></a>
        </td>
    </tr>
    <tr class="h-5">
        <td colspan="3">
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlenabled" runat="server" meta:resourcekey="pnlenabledResource1">
                <table>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblEpithelialCells" runat="server" Text="Epithelial Cells" meta:resourcekey="lblEpithelialCellsResource1"></asp:Label>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:RadioButtonList ForeColor="Black" ID="rblEpithelial" runat="server" RepeatDirection="Horizontal"
                                meta:resourcekey="rblEpithelialResource1">
                                <%--<asp:ListItem Value="Absent" Selected="True" meta:resourcekey="ListItemResource1">Absent</asp:ListItem>
                                <asp:ListItem Value="Present" meta:resourcekey="ListItemResource2">Present</asp:ListItem>--%>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMalignantCells" runat="server" Text="Malignant Cells" meta:resourcekey="lblMalignantCellsResource1"></asp:Label>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:RadioButtonList ForeColor="Black" ID="rblMalignant" runat="server" RepeatDirection="Horizontal"
                                meta:resourcekey="rblMalignantResource1">
                                <asp:ListItem Value="Absent" Selected="True" meta:resourcekey="ListItemResource3">Absent</asp:ListItem>
                                <asp:ListItem Value="Present" meta:resourcekey="ListItemResource4">Present</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblNormalCells" runat="server" EnableTheming="True" Text="Normal Cells"
                                meta:resourcekey="lblNormalCellsResource1"></asp:Label>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:RadioButtonList ForeColor="Black" ID="rblNormal" runat="server" RepeatDirection="Horizontal"
                                meta:resourcekey="rblNormalResource1">
                              <%--  <asp:ListItem Value="Absent" meta:resourcekey="ListItemResource5">Absent</asp:ListItem>
                                <asp:ListItem Value="Present" Selected="True" meta:resourcekey="ListItemResource6">Present</asp:ListItem>--%>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                                meta:resourceKey="Rs_CommentsResource1"></asp:Label>
                        </td>
                        <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtReason" TabIndex="-1"
                                TextMode="MultiLine" CssClass="small" 
                                meta:resourceKey="txtReasonResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                            </ajc:AutoCompleteExtender>
                            <asp:HiddenField ID="hdnRemarksID" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                                meta:resourceKey="lblMedRemarksResource1"></asp:Label>
                        </td>
                        <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                                TabIndex="-1" TextMode="MultiLine" CssClass="small" 
                                meta:resourceKey="txtMedRemarksResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                            </ajc:AutoCompleteExtender>
                            <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20" style="font-weight: normal; color: #000;">
            <asp:Label ID="Rs_Status1" Text="Status" runat="server" meta:resourcekey="Rs_Status1Resource1"></asp:Label>
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
                                        CssClass="ddlsmall" onmousedown="expandDropDownList(this);" 
                                        onblur="collapseDropDownList(this);" 
                                        meta:resourcekey="ddlStatusReasonResource1">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
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
            <asp:HiddenField runat="server" ID="hidValCyp" />
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
