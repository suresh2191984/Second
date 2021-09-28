<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FluidAnalysisChemistryPattern.ascx.cs"
    Inherits="Investigation_FluidAnalysisChemistryPattern" %>
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
                visible="false"><u>
                    <%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %>
                </u></a>
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
                            <asp:Label ID="lblAlbumins" runat="server" Text="Albumin" meta:resourcekey="lblAlbuminsResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtAlbumins" CssClass="small"
                                MaxLength="50" runat="server" meta:resourcekey="txtTotalProteinsResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUTotalProteins" Text="mg/dl" runat="server" meta:resourcekey="lblUTotalProteinsResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblTotalProteins0" runat="server" Text="Total Protein" meta:resourcekey="lblTotalProteins0Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtTotalProteins" MaxLength="50"
                                CssClass="small" runat="server" meta:resourcekey="txtAlbuminsResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUAlbumins" Text="mg/dl" runat="server" meta:resourcekey="lblUAlbuminsResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblGlucose" runat="server" EnableTheming="True" Text="Glucose" meta:resourcekey="lblGlucoseResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtGlucose" ForeColor="Black" Font-Bold="true" MaxLength="50" runat="server"
                                CssClass="small" meta:resourcekey="txtGlucoseResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUGlucose" Text="mg/dl" runat="server" meta:resourcekey="lblUGlucoseResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblLDH" runat="server" Text="LDH" meta:resourcekey="lblLDHResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtLDH" MaxLength="50" runat="server"
                                CssClass="small" meta:resourcekey="txtLDHResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblULDH" Text="mg/dl" runat="server" meta:resourcekey="lblULDHResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblLactate" runat="server" Text="Lactate" meta:resourcekey="lblLactateResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtLactate" MaxLength="50" runat="server"
                                CssClass="small" meta:resourcekey="txtLactateResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblULactate" Text="mg/dl" runat="server" meta:resourcekey="lblULactateResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblAmmonia" runat="server" Text="Ammonia" meta:resourcekey="lblAmmoniaResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtAmmonia" MaxLength="50" runat="server"
                                CssClass="small" meta:resourcekey="txtAmmoniaResource1"></asp:TextBox>
                        </td>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblUAmmonia" Text="mg/dl" runat="server" meta:resourcekey="lblUAmmoniaResource1"></asp:Label>
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
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                        </td>
                        <td colspan="2" class="font11 h-20" style="font-weight: normal;  color: #000;">
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
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
                        </td>
                        <td colspan="2" class="font11 h-20" style="font-weight: normal; color: #000;">
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
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                            meta:resourcekey="ddlstatusResource1">
                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="font10 h-10" style="font-weight: normal;  color: #000;">
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
                    <td>
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                        CssClass="ddlsmall"  onmousedown="expandDropDownList(this);"
                                        onblur="collapseDropDownList(this);">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox" class="w-100" >
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddlsmall" >
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
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
