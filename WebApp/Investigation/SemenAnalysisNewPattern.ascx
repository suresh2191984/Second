<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SemenAnalysisNewPattern.ascx.cs"
    Inherits="Investigation_SemenAnalysisNewPattern" %>
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
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblPhysicalExamination" runat="server" Text="PHYSICAL EXAMINATION"
                                Font-Bold="True" meta:resourcekey="lblPhysicalExaminationResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblVolume" runat="server" Text="Volume" meta:resourcekey="lblVolumeResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtVolume" CssClass="small" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" runat="server" meta:resourcekey="txtVolumeResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUVolume" Text="ml" runat="server" meta:resourcekey="lblUVolumeResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblLiquification" runat="server" Text="Liquification" meta:resourcekey="lblLiquificationResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtLiquification" CssClass="small"
                                onkeyup="javascript:return setCompletedStatus(this.id);" MaxLength="50" runat="server"
                                meta:resourcekey="txtLiquificationResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lbluLiquification" Text="Mts" runat="server" meta:resourcekey="lbluLiquificationResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblViscosity" runat="server" Text="Viscosity" meta:resourcekey="lblViscosityResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtViscosity" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtViscosityResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblPH" runat="server" Text="PH" meta:resourcekey="lblPHResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtPH" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtPHResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblChemicalExamination" runat="server" Text="CHEMICAL EXAMINATION"
                                Font-Bold="True" meta:resourcekey="lblChemicalExaminationResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblReaction" runat="server" Text="Reaction" meta:resourcekey="lblReactionResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtReaction" MaxLength="50" onkeyup="javascript:return setCompletedStatus(this.id);"
                                runat="server" CssClass="small" meta:resourcekey="txtReactionResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <%--                   <tr>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                            <asp:Label ID="lblSpermCount1" runat="server" Text="" Font-Bold="True"
                                meta:resourcekey="lblSpermCount1Resource1"></asp:Label>
                        </td>
                    </tr>--%>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSpermCount" runat="server" EnableTheming="True" Text="Sperm Count"
                                Font-Bold="True"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSpermCount" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtSpermCountResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUSpermCount" Text="million/ml" runat="server" meta:resourcekey="lblUSpermCountResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMotility" runat="server" Text="MOTILITY" Font-Bold="True" meta:resourcekey="lblMotilityResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblRapid" runat="server" Text="A-Rapid Progressive Motility" meta:resourcekey="lblRapidResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtRapid" CssClass="small" onkeyup="javascript:return setCompletedStatus(this.id);"
                                onblur="checkMotility();" MaxLength="50" runat="server" meta:resourcekey="txtRapidResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblURapid" Text="%" runat="server" meta:resourcekey="lblURapidResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSluggish" runat="server" Text="B-Sluggish Progressive Motility"
                                meta:resourcekey="lblSluggishResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSluggish" onkeyup="javascript:return setCompletedStatus(this.id);"
                                onblur="checkMotility();" MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtSluggishResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUSluggish" Text="%" runat="server" meta:resourcekey="lblUSluggishResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblNon" runat="server" Text="C-Non Progressive Motility" meta:resourcekey="lblNonResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtnon" onkeyup="javascript:return setCompletedStatus(this.id);"
                                onblur="checkMotility();" MaxLength="50" runat="server" CssClass="small" meta:resourcekey="txtnonResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUNon" Text="%" runat="server" meta:resourcekey="lblUNonResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblNoMotility" runat="server" Text="D-No Motility" meta:resourcekey="lblNoMotilityResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtNoMotility" onkeyup="javascript:return setCompletedStatus(this.id);"
                                onblur="checkMotility();" MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtNoMotilityResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUNoMotility" Text="%" runat="server" meta:resourcekey="lblUNoMotilityResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMorphology" runat="server" Text="Morphology" Font-Bold="True" meta:resourcekey="lblMorphologyResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblNormal" runat="server" Text="Normal" meta:resourcekey="lblNormalResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtNormal" onkeyup="javascript:return setCompletedStatus(this.id);"
                                onblur="checkMorphology();" MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtNormalResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUNormal" Text="%" runat="server" meta:resourcekey="lblUNormalResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblPinGiant" runat="server" Text="Pin,Giant&Amorphous Heads" meta:resourcekey="lblPinGiantResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtPinGiant" onkeyup="javascript:return setCompletedStatus(this.id);"
                                onblur="checkMorphology();" MaxLength="50" CssClass="small" runat="server" meta:resourcekey="txtPinGiantResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUPinGiant" Text="%" runat="server" meta:resourcekey="lblUPinGiantResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;" colspan="2">
                            <asp:Label ID="lblMicroscopicfindings" runat="server" Text="OTHER MICROSCOPIC FINDINGS"
                                Font-Bold="True"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblWbc" Text="WBCs" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtWbcs" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUwbcss" Text="/hpf" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblRBC" Text="RBCs" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtRbcs" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; s color: #000;">
                            <asp:Label ID="lblUrbcs" Text="/hpf" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblEpithelialcells" Text="Epithelial Cells" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtEpithelial" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUEpithelial" Text="/hpf" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSpermagglutinate" Text="Sperm agglutinates" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSpermagglutinates" onkeyup="javascript:return setCompletedStatus(this.id);"
                                MaxLength="50" CssClass="small" runat="server"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUSpermagglutinates" Text="/hpf" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                        </td>
                        <td class="font10 h-40 w-8p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtRefRange" TextMode="MultiLine" CssClass="textbox_pattern small" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                        </td>
                        <td colspan="2" class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtReason" TextMode="MultiLine" CssClass="textbox_pattern small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
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
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
                        </td>
                        <td class="font11 h-20" colspan="2" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                                onkeyup="javascript:return setCompletedStatus(this.id);" TabIndex="-1" TextMode="MultiLine"
                                CssClass="textbox_pattern small"></asp:TextBox>
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
        <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
            <asp:Label ID="Rs_Status" Text="Status" runat="server"></asp:Label>
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
                        <asp:DropDownList ForeColor="Black" ID="ddlStatus" runat="server" CssClass="ddlsmall"
                            TabIndex="-1" onChange="javascript:ShowStatusReason(this.id);" meta:resourcekey="ddlstatusResource1">
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
                                    <span class="richcombobox w-100">
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
        <td>
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
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<script language="javascript" type="text/javascript">
    function checkMotility() {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vLess = SListForAppMsg.Get('Investigation_SemenAnalysisNewPattern_ascx_01') == null ? "Motility total value less than 100" : SListForAppMsg.Get('Investigation_SemenAnalysisNewPattern_ascx_01');
        var vGreater = SListForAppMsg.Get('Investigation_SemenAnalysisNewPattern_ascx_02') == null ? "Motility total value greater than 100" : SListForAppMsg.Get('Investigation_SemenAnalysisNewPattern_ascx_02');
     
         var val1 = parseInt(document.getElementById("5085~~0_txtRapid").value);
         var val2 = parseInt(document.getElementById("5085~~0_txtSluggish").value);
         var val3 = parseInt(document.getElementById("5085~~0_txtnon").value);
         var val4 = parseInt(document.getElementById("5085~~0_txtNoMotility").value);
         var resVal = val1 + val1 + val3 + val4;

         if (document.getElementById("5085~~0_txtRapid").value != '' && document.getElementById("5085~~0_txtSluggish").value != '' && document.getElementById("5085~~0_txtnon").value != '' && document.getElementById("5085~~0_txtNoMotility").value != '') {
             if (resVal < 100) {
                 //alert('Motility total value less than 100');
                 ValidationWindow(vLess, AlertType);
             }
             if (resVal > 100) {
                 //alert('Motility total value greater than 100');
                 ValidationWindow(vGreater, AlertType);

             }
         }


     }

     function checkMorphology() {
         var val5 = parseInt(document.getElementById("5085~~0_txtPinGiant").value);
         var val6 = parseInt(document.getElementById("5085~~0_txtNormal").value);

         var resVal1 = val5 + val6;

         if (document.getElementById("5085~~0_txtPinGiant").value != '' && document.getElementById("5085~~0_txtNormal").value != '') {
             if (resVal1 < 100) {
                 alert('Morphology total value less than 100');

             }
             if (resVal1 > 100) {
                 alert('Morphology total value greater than 100');

             }
         }


     }
</script>

<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
