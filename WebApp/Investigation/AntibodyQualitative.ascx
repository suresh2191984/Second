<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AntibodyQualitative.ascx.cs"
    Inherits="Investigation_AntibodyQualitative" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table class="w-100p defaultfontcolor">
    <tr>
        <td class="bold font10 h-20 w-19p a-center" colspan="4" style="color: #000;">
            <asp:Label runat="server" ID="lblName" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u>Edit</u></a>
        </td>
    </tr>
    <tr>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000;">
            <asp:Label runat="server" ID="lblQualitativeResult" Text="Qualitative Result" meta:resourcekey="lblQualitativeResultResource1"></asp:Label>
        </td>
        <td>
            <asp:HyperLink ID="hlnkAdd" Text="Add" Font-Underline="true" runat="server" ForeColor="#0033CC"
                onclick="javascript:changeSourceName(this.id);" meta:resourcekey="hlnkAddResource1"></asp:HyperLink>
        </td>
        <td class="font11 h-20 w-14p" style="font-weight: normal; color: #000;">
            <asp:DropDownList ForeColor="Black" ID="ddlData" CssClass="ddlsmall" runat="server"
                meta:resourcekey="ddlDataResource1">
            </asp:DropDownList>
            <asp:HiddenField ID="hdnDDL" runat="server" />
        </td>
        <td class="font11 h-20 w-19p" style="font-weight: normal; color: #000;">
            <asp:Label runat="server" ID="lblQuantitativeResult" Text="Quantitative Result" meta:resourcekey="lblQuantitativeResultResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtResult" CssClass="small" runat="server"
                meta:resourcekey="txtResultResource1"></asp:TextBox>
        </td>
        <td class="bold font10 h-20 w-8p" style="color: #000;">
            <asp:Label runat="server" ID="lblUOM" meta:resourcekey="lblUOMResource1"></asp:Label>
        </td>
        <td class="bold font10 h-50 w-8p" style="color: #000;">
            <table>
                <tr>
                    <td class="bold font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtRefRange" TextMode="MultiLine"
                            CssClass="small" TabIndex="-1" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                        <asp:HiddenField ID="hdnPanicXmlContent" runat="server" />
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
        <td class="w-14p">
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtReason" TabIndex="-1"
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
                </tr>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                            meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
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
    <asp:HiddenField runat="server" ID="hidVal" />
</table>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
