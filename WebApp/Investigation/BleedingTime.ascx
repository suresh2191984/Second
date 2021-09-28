<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BleedingTime.ascx.cs"
    Inherits="Investigation_BleedingTime" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        width: 8%;
        height: 10px;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>
<table class="defaultfontcolor w-100p">
    <tr>
        <td class="font10 h-20 w-15p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblName" runat="server" Text="Name" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %></u></a>
        </td>
        <td class="w-8p">
            <asp:TextBox ID="txtmins" CssClass="small" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                meta:resourcekey="txtminsResource1"></asp:TextBox>
        </td>
        <td class="bold font10 h-20 w-6p" style="color: #000;">
            <asp:Label ID="lblUOM1" runat="server" meta:resourcekey="lblUOM1Resource1"></asp:Label>
        </td>
        <td class="w-8p">
            <asp:TextBox ID="txtSecs" CssClass="small" runat="server" meta:resourcekey="txtSecsResource1"></asp:TextBox>
        </td>
        <td class="bold font10 h-20 w-6p" style="color: #000;">
            <asp:Label ID="lblUOM2" runat="server" meta:resourcekey="lblUOM2Resource1"></asp:Label>
        </td>
        <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
            <table>
                <tr>
                    <td style="font-weight: normal; color: #000;" class="style1 font10">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtRefRange" TabIndex="-1"
                            TextMode="MultiLine" CssClass="small"  meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-14p">
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                            meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                    </td>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                            meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox runat="server" ID="txtReason" CssClass="small" TabIndex="-1" TextMode="MultiLine"
                             meta:resourcekey="txtReasonResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnRemarksID" runat="server" />
                    </td>
                    <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                            TabIndex="-1" TextMode="MultiLine" CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
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
        </td>
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
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" meta:resourcekey="ddlstatusResource1"
                            CssClass="ddlsmall">
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
                    <td id="tdDeltaCheck" class="a-center w-15p v-middle" runat="server" style="display: none;">
                        <a id="ADeltaTag" runat="server" onclick="CallShowPopUp(this.id);" style="display: block;
                            font-size: larger; color: Red"><u>Δ</u></a>
                    </td>
                    <td id="tdBetaCheck" class="a-center w-15p v-middle" runat="server" style="display: none;">
                        <a id="ABetaTag" runat="server" onclick="CallShowBetaPopUp(this.id);" style="display: block;
                            font-size: large; color: Red"><u>Δ</u></a>
                        <asp:Label ID="lblPVisitID" runat="server" Style="display: none;" 
                            meta:resourcekey="lblPVisitIDResource1"></asp:Label>
                        <asp:Label ID="lblPatternID" runat="server" Style="display: none;" 
                            meta:resourcekey="lblPatternIDResource1"></asp:Label>
                        <asp:Label ID="lblInvID" runat="server" Style="display: none;" 
                            meta:resourcekey="lblInvIDResource1"></asp:Label>
                        <asp:Label ID="lblOrgID" runat="server" Style="display: none;" 
                            meta:resourcekey="lblOrgIDResource1"></asp:Label>
                        <asp:Label ID="lblPatternClassName" runat="server" Style="display: none;" 
                            meta:resourcekey="lblPatternClassNameResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
