<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FluidAnalysisCellsPattern.ascx.cs"
    Inherits="Investigation_FluidAnalysisCellsPattern" %>
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
        <td>
            &nbsp;
        </td>
    </tr>
    <tr class="h-5">
        <td colspan="3">
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlEnable" runat="server" meta:resourcekey="pnlEnableResource1">
                <table>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSpecimen" runat="server" Text="Specimen" meta:resourcekey="lblSpecimenResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="True" 
                                ID="txtSpecimen" runat="server" MaxLength="50"
                                meta:resourcekey="txtSpecimenResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblTotal" runat="server" Text="Total WBC Count" meta:resourcekey="lblTotalResource1"></asp:Label>
                            &nbsp;
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtTotal" CssClass="small" 
                                runat="server" MaxLength="50"
                                meta:resourcekey="txtTotalResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUTotal" Text="cells/cumm" runat="server" meta:resourcekey="lblUTotalResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMononuclear" runat="server" Text="Mononuclear Cells" meta:resourcekey="lblMononuclearResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txtMonoCells" MaxLength="50"
                                runat="server" meta:resourcekey="txtMonoCellsResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUMononuclear" runat="server" Text="cells/cumm" meta:resourcekey="lblUMononuclearResource1"></asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblTechnique" runat="server" EnableTheming="True" Text="Differential Count -"
                                meta:resourcekey="lblTechniqueResource1"></asp:Label>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblLymphocytes" runat="server" Text="Lymphocytes" meta:resourcekey="lblLymphocytesResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="small" ForeColor="Black" Font-Bold="true" ID="txtLymphocytes" MaxLength="50"
                                runat="server" meta:resourcekey="txtLymphocytesResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblULymphocytes" Text="%" runat="server" meta:resourcekey="lblULymphocytesResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMonocytes" runat="server" Text="Monocytes" meta:resourcekey="lblMonocytesResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="small" ForeColor="Black" Font-Bold="true" ID="txtMonocytes" MaxLength="50"
                                runat="server" meta:resourcekey="txtMonocytesResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUMonocytes" Text="%" runat="server" meta:resourcekey="lblUMonocytesResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblNeutrophils" runat="server" Text="Neutrophils" meta:resourcekey="lblNeutrophilsResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="small" ForeColor="Black" Font-Bold="true" ID="txtNeutrophils" MaxLength="50"
                                runat="server" meta:resourcekey="txtNeutrophilsResource1"></asp:TextBox>
                        </td>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUNeutrophils" Text="%" runat="server" meta:resourcekey="lblUNeutrophilsResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblRBC" runat="server" Text="RBC" meta:resourcekey="lblRBCResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtRBC" CssClass="small" MaxLength="50" runat="server"
                                meta:resourcekey="txtRBCResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblURBC" Text="cells/cumm" runat="server" meta:resourcekey="lblURBCResource1"></asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblOthers" runat="server" Text="Others" meta:resourcekey="lblOthersResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txtOthers" MaxLength="50" runat="server"
                                meta:resourcekey="txtOthersResource1"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                                meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" TextMode="MultiLine"
                                CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
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
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                                meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                        </td>
                        <td colspan="3">
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
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="w-50p">
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
                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
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
    </tr>
    <tr>
        <td>
            <asp:HiddenField runat="server" ID="hidValCep" />
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
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
