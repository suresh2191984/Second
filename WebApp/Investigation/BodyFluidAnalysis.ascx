<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BodyFluidAnalysis.ascx.cs"
    Inherits="Investigation_Body_Fluid_Analysis" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        height: 22px;
    }
    .style2
    {
        height: 21px;
    }
    .style3
    {
        width: 8%;
        height: 52px;
    }
    .style4
    {
        height: 23px;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>
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
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblPhysicalExamination" runat="server" Text="PHYSCIAL EXAMINATION"
                                Font-Bold="True" meta:resourcekey="lblPhysicalExaminationResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: normal; color: #000;" class="style2 font11">
                            <asp:Label ID="lblVolume" runat="server" Text="Volume" meta:resourcekey="lblVolumeResource1"></asp:Label>
                        </td>
                        <td class="style2">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtVolume" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtVolumeResource1"></asp:TextBox>
                        </td>
                        <td style="font-weight: normal; color: #000;" class="style2 font12">
                            <asp:Label ID="lblUVolume" Text="ml" runat="server" meta:resourcekey="lblUVolumeResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblColour" runat="server" Text="Colour" meta:resourcekey="lblColourResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtColour" CssClass="small" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" runat="server" meta:resourcekey="txtColourResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblAppearance" runat="server" Text="Appearance" meta:resourcekey="lblAppearanceResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtAppearance" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" runat="server" CssClass="small" meta:resourcekey="txtAppearanceResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblChemicalExamination" runat="server" Text="CHEMICAL EXAMINATION"
                                Font-Bold="True" meta:resourcekey="lblChemicalExaminationResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: normal; color: #000;" class="style1 font11">
                            <asp:Label ID="lblProtein" runat="server" Text="Protein" meta:resourcekey="lblProteinResource1"></asp:Label>
                        </td>
                        <td class="style1">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtProtein" MaxLength="50" onkeyup="javascript:return setCompletedStatus(this.id);"
                                runat="server" CssClass="small" meta:resourcekey="txtProteinResource1"></asp:TextBox>
                        </td>
                        <td style="font-weight: normal; color: #000;" class="style1 font12">
                            <asp:Label ID="lblUProtein" Text="mg/dl" runat="server" meta:resourcekey="lblUProteinResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSugar" runat="server" EnableTheming="True" Text="Sugar" meta:resourcekey="lblSugarResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSugar" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" runat="server" CssClass="small" meta:resourcekey="txtSugarResource1"></asp:TextBox>
                        </td>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUSugar" Text="mg/dl" runat="server" meta:resourcekey="lblUSugarResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMicroscopic" runat="server" Text="MICROSCOPIC EXAMINATION" Font-Bold="True"
                                meta:resourcekey="lblMicroscopicResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: normal; color: #000;" class="style4 font11">
                            <asp:Label ID="lblCellCount" runat="server" Text="CellCount" meta:resourcekey="lblCellCountResource1"></asp:Label>
                        </td>
                        <td class="style4">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtCellCount" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtCellCountResource1"></asp:TextBox>
                        </td>
                        <td style="font-weight: normal; color: #000;" class="style4 font12">
                            <asp:Label ID="lblUCellCount" Text="cells/cmm" runat="server" meta:resourcekey="lblUCellCountResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblCellType" runat="server" Text="CELLTYPE" Font-Bold="True" meta:resourcekey="lblCellTypeResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblNeutrophils" runat="server" Text="Neutrophils" meta:resourcekey="lblNeutrophilsResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtNeutrophils" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" runat="server" CssClass="small" meta:resourcekey="txtNeutrophilsResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lbllymphocytes" runat="server" Text="Lymphocytes" meta:resourcekey="lbllymphocytesResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtlymphocytes" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" runat="server" CssClass="small" meta:resourcekey="txtlymphocytesResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: normal; color: #000;" class="style3 font10">
                            <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                        </td>
                        <td style="font-weight: normal; color: #000;" class="style3 font10">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtRefRange" TextMode="MultiLine" CssClass="small" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                        </td>
                        <td colspan="2" class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtReason" TextMode="MultiLine" CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
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
                                meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                        </td>
                        <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                                onkeyup="javascript:return setCompletedStatus(this.id);" TabIndex="-1" TextMode="MultiLine"
                                CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
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
            <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
        </td>
        <td>
            <table>
                <tr>
                    <td>
                        <asp:DropDownList ForeColor="Black" ID="ddlStatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                            onChange="javascript:ShowStatusReason(this.id);" meta:resourcekey="ddlstatusResource1">
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
