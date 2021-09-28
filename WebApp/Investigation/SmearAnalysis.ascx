<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SmearAnalysis.ascx.cs"
    Inherits="Investigation_SmearAnalysis" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table class="w-80p">
    <tr>
        <td class="font12 h-20" style="font-weight: normal; color: #000;" colspan="3">
            <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %></u></a>
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
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSpecimenNo" runat="server" Text="Specimen No" meta:resourcekey="lblSpecimenNoResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSpecimenNo" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtSpecimenNoResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblGross" runat="server" Text="Gross" meta:resourcekey="lblGrossResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtGross" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMicroscopy" runat="server" Text="Microscopy" Font-Bold="True" meta:resourcekey="lblMicroscopyResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSpecimen" runat="server" Text="Specimen" meta:resourcekey="lblSpecimenResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSpecimen" onkeyup="javascript:return setCompletedStatus(this.id);"
                                CssClass="small" MaxLength="50" runat="server" TextMode="MultiLine" meta:resourcekey="txtSpecimenResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000; vertical-align: text-top;">
                            <asp:Label ID="lblDescription" runat="server" Text="Technical Remarks" 
                                meta:resourcekey="lblDescriptionResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDescription" CssClass="small" runat="server" TextMode="MultiLine"
                                meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                TargetControlID="txtDescription" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                            </ajc:AutoCompleteExtender>
                            <asp:HiddenField ID="hdnRemarksID" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000; vertical-align: text-top;">
                            <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                                meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                                TabIndex="-1" TextMode="MultiLine" CssClass="small" 
                                meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                            </ajc:AutoCompleteExtender>
                            <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblInterPretation" runat="server" Text="InterPretation" meta:resourcekey="lblInterPretationResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtInterPretation" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtInterPretationResource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20" style="font-weight: normal; color: #000;">
            <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
        </td>
        <td>
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
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                            meta:resourcekey="ddlstatusResource1">
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
            <asp:HiddenField runat="server" ID="hidValChp" />
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
