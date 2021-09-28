<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ClinicalPattern12.ascx.cs"
    Inherits="Investigation_ClinicalPattern12" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table class="w-100p defaultfontcolor">
    <tr>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000;">
            <asp:Label runat="server" ID="lblName" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>
        </td>
        <td class="v-middle w-2p">
            <asp:HyperLink ID="hlnkAdd" Text="Add" runat="server" ForeColor="#0033CC" onclick="javascript:changeSourceName(this.id);"
                meta:resourcekey="hlnkAddResource1"></asp:HyperLink>
        </td>
        <td class="w-9p">
            <asp:DropDownList ForeColor="Black" ID="ddlData" runat="server" meta:resourcekey="ddlDataResource1"
                CssClass="ddlsmall">
            </asp:DropDownList>
            <asp:HiddenField ID="hdnDDL" runat="server" />
        </td>
        <td class="w-8p">
            <asp:TextBox ForeColor="Black" ID="txtResult" runat="server" meta:resourcekey="txtResultResource1"
                CssClass="small"></asp:TextBox>
        </td>
        <td class="font11 h-20 w-5p" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblUom" runat="server" meta:resourcekey="lblUomResource1"></asp:Label>
        </td>
        <td class="bold h-20 font10 w-8p" style="color: #000;">
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" TabIndex="-1" ID="txtRefRange"
                            TextMode="MultiLine" CssClass="small" 
                            meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-9p a-center">
            <table>
                <tr>
                    <td class="font10 h-10" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblIsAbnormal" Text="Abnormal" runat="server" meta:resourcekey="lblIsAbnormalResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10" style="font-weight: normal; color: #000;">
                        <span id="spanIsAbnormal" style="cursor: pointer;" runat="server">
                            <asp:TextBox ID="txtIsAbnormal" Enabled="False" runat="server" CssClass="w-10 h-10"
                                Style="background: white;" TabIndex="-1" 
                            meta:resourcekey="txtIsAbnormalResource1"></asp:TextBox>
                        </span>
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-8p">
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
                    <td class="font10  w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" TabIndex="-1" ID="txtReason"
                            TextMode="MultiLine" CssClass="small" 
                            meta:resourcekey="txtReasonResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnRemarksID" runat="server" />
                    </td>
                    <td class="font10 w-8p" style="font-weight: normal; color: #000;">
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
        <td class="w-14p">
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
                    <td id="tdDeltaCheck" class="v-middle w-15p a-center" runat="server" style="display: none;">
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
                        <asp:HiddenField ID="hdnddlData" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <asp:HiddenField runat="server" ID="hidVal" />
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
