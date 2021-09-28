<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StoneAnalysis.ascx.cs"
    Inherits="Investigation_StoneAnalysis" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table class="w-70p">
    <tr>
        <td class="font12 h-20 a-center w-10p" colspan="2" style="font-weight: normal; color: #000;">
            <asp:Label runat="server" ID="lblName" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08%></u></a>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlStone" runat="server" meta:resourcekey="pnlStoneResource1">
                <table>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_NoofStones" Text="No of Stones" runat="server" meta:resourcekey="Rs_NoofStonesResource1"></asp:Label>
                        </td>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSamples" CssClass="small" runat="server" 
                                meta:resourcekey="txtSamplesResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_LargestStoneSize" Text="Largest Stone Size" runat="server" meta:resourcekey="Rs_LargestStoneSizeResource1"></asp:Label>
                        </td>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" CssClass="small"  Font-Bold="true" ID="txtSize" runat="server" meta:resourcekey="txtSizeResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_StoneStructureShape" Text="Stone Structure & Shape" runat="server"
                                meta:resourcekey="Rs_StoneStructureShapeResource1"></asp:Label>
                        </td>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtStructure" CssClass="small"  runat="server"
                                meta:resourcekey="txtStructureResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMicroscopy" runat="server" Text="Composition" meta:resourcekey="lblMicroscopyResource1"></asp:Label>
                        </td>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtCompsition" runat="server"
                                TextMode="MultiLine" CssClass="small"  meta:resourcekey="txtCompsitionResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Label1" runat="server" Text="Impression" meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtImpression" runat="server"
                                TextMode="MultiLine" CssClass="small"  meta:resourcekey="txtImpressionResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                        </td>
                        <td class="v-top">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" TextMode="MultiLine"
                                CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                            </ajc:AutoCompleteExtender>
                            <asp:HiddenField ID="hdnRemarksID" runat="server" />
                            &nbsp;&nbsp;<br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
                        </td>
                        <td class="v-top">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                                TabIndex="-1" TextMode="MultiLine" CssClass="small"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                            </ajc:AutoCompleteExtender>
                            <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                            &nbsp;&nbsp;<br />
                            <br />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
            <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
        </td>
        <td class="v-top">
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td class="font11 h-20 w-10p" style="font-weight: normal; color: #000;">
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
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox" class="w-100">
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
    <asp:HiddenField runat="server" ID="hidVal" />
</table>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
