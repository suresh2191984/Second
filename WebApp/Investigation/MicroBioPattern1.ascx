<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MicroBioPattern1.ascx.cs"
    Inherits="Investigation_MicroBioPattern1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<style type="text/css">
    .style1
    {
        height: 20px;
        width: 99px;
    }
    .style2
    {
        width: 99px;
    }
    .style3
    {
        width: 139px;
    }
    .style4
    {
        height: 20px;
    }
    .style5
    {
        width: 139px;
        height: 20px;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>
<table class="w-80p">
    <tr>
        <td class="font12 h-20" style="font-weight: normal; color: #000;" colspan="3">
            <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u>Edit</u></a>
        </td>
        <td class="style3">
            &nbsp;
        </td>
    </tr>
    <tr class="h-5">
        <td colspan="3">
        </td>
        <td class="style3">
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlenabled" runat="server" meta:resourcekey="pnlenabledResource1">
                <table>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSpecimen" runat="server" Text="Specimen" meta:resourcekey="lblSpecimenResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSpecimen" runat="server" MaxLength="50" CssClass="small"
                                meta:resourcekey="txtSpecimenResource1"></asp:TextBox>
                        </td>
                        <td class="font11 style1" style="font-weight: normal; color: #000;">
                            &nbsp;
                        </td>
                        <td class="style3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 style4" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSource" runat="server" Text="Source" meta:resourcekey="lblSourceResource1"></asp:Label>
                        </td>
                        <td class="style4">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSource" runat="server" MaxLength="50"
                                CssClass="small" meta:resourcekey="txtSourceResource1"></asp:TextBox>
                        </td>
                        <td class="style1 font11" style="font-weight: normal; color: #000;">
                        </td>
                        <td class="style5">
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblDay1" runat="server" Text="Day 1" meta:resourcekey="lblDay1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtDay1" runat="server" MaxLength="50"
                                CssClass="small" meta:resourcekey="txtDay1Resource1"></asp:TextBox>
                        </td>
                        <td class="style1 font11" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblResult1" runat="server" Text="Result" meta:resourcekey="lblResult1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtResult1" runat="server" MaxLength="50"
                                CssClass="small" meta:resourcekey="txtResult1Resource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblDay2" runat="server" Text="Day 2" meta:resourcekey="lblDay2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtDay2" runat="server" MaxLength="50"
                                CssClass="small" meta:resourcekey="txtDay2Resource1"></asp:TextBox>
                        </td>
                        <td class="style1 font11" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblResult2" runat="server" Text="Result" meta:resourcekey="lblResult2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtResult2" runat="server" MaxLength="50"
                                CssClass="small" meta:resourcekey="txtResult2Resource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblDay3" runat="server" Text="Day 3" meta:resourcekey="lblDay3Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtDay3" runat="server" MaxLength="50"
                                CssClass="small" meta:resourcekey="txtDay3Resource1"></asp:TextBox>
                        </td>
                        <td class="style1 font11" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblResult3" runat="server" Text="Result" meta:resourcekey="lblResult3Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtResult3" runat="server" MaxLength="50"
                                CssClass="small" meta:resourcekey="txtResult3Resource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblDay4" runat="server" Text="Day 4" meta:resourcekey="lblDay4Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtDay4" runat="server" MaxLength="50"
                                CssClass="small" meta:resourcekey="txtDay4Resource1"></asp:TextBox>
                        </td>
                        <td class="style1 font11 " style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblResult4" runat="server" Text="Result" meta:resourcekey="lblResult4Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtResult4" runat="server" MaxLength="50"
                                CssClass="small" meta:resourcekey="txtResult4Resource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblClinicalDiagnosis" runat="server" Text="Clinical Diagnosis" meta:resourcekey="lblClinicalDiagnosisResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtClinicalDiagnosis" runat="server"
                                CssClass="small" MaxLength="50" meta:resourcekey="txtClinicalDiagnosisResource1"></asp:TextBox>
                        </td>
                        <td class="style1 font11 " style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblClinicalNotes" runat="server" Text="Clinical Notes" meta:resourcekey="lblClinicalNotesResource1"></asp:Label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtClinicalNotes" runat="server"
                                CssClass="small" TextMode="MultiLine" meta:resourcekey="txtClinicalNotesResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMethodUsed" runat="server" Text="Method Used" meta:resourcekey="lblMethodUsedResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtMethodsUsed" MaxLength="50"
                                CssClass="small" runat="server" meta:resourcekey="txtMethodsUsedResource1"></asp:TextBox>
                        </td>
                        <td style="font-weight: normal; color: #000;" class="style1 font11 ">
                            <asp:Label ID="lblStainUsed" runat="server" Text="Stain(S) Used" meta:resourcekey="lblStainUsedResource1"></asp:Label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtStainUsed" MaxLength="50"
                                CssClass="small" runat="server" meta:resourcekey="txtStainUsedResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblTechnique" runat="server" EnableTheming="True" Text="Technique"
                                meta:resourcekey="lblTechniqueResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtTechnique" MaxLength="50"
                                CssClass="small" runat="server" meta:resourcekey="txtTechniqueResource1"></asp:TextBox>
                        </td>
                        <td class="style2">
                            &nbsp;
                        </td>
                        <td class="style3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMicroscopy" runat="server" Text="Microscopy" meta:resourcekey="lblMicroscopyResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <FCKeditorV2:FCKeditor ID="txtGross" runat="server" Width="600px" Height="300px"
                                ToolbarSet="Biospy">
                            </FCKeditorV2:FCKeditor>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblImpression" runat="server" Text="Impression" meta:resourcekey="lblImpressionResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <FCKeditorV2:FCKeditor ID="txtImpression" runat="server" Width="600px" Height="300px"
                                ToolbarSet="Biospy">
                            </FCKeditorV2:FCKeditor>
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
                                    <asp:Label ID="lblReason" Text="Reason" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOpinionUser" runat="server" Text="User" />
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
                                        CssClass="ddlsmall" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox" class="w-100">
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddlsmall">
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
        <td class="style2">
            &nbsp;
        </td>
        <td class="style3">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <table>
                <tr>
                    <td class="font11 h-20" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                    </td>
                    <td class="font11 h-40" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" TextMode="MultiLine"
                            CssClass="small" TabIndex="-1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnRemarksID" runat="server" />
                    </td>
                    <td class="font11 h-20" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
                    </td>
                    <td class="font11 h-40" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                            TabIndex="-1" TextMode="MultiLine" CssClass="small"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                    </td>
                    <td class="style2">
                        <asp:HiddenField runat="server" ID="hidVal" />
                        &nbsp;
                    </td>
                    <td class="style3">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />