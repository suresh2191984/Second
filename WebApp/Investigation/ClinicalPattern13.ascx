<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ClinicalPattern13.ascx.cs"
    Inherits="Investigation_ClinicalPattern13" %>
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
        <td class="w-14p">
            <asp:DropDownList ID="ddlSource" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlSourceResource1">
            </asp:DropDownList>
        </td>
        <td class="w-9p">
            <asp:DropDownList ID="ddlMethod" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlMethodResource1">
            </asp:DropDownList>
        </td>
        <td class="w-12p">
            <asp:DropDownList ID="ddlResult" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlResultResource1">
            </asp:DropDownList>
        </td>
        <td class="bold font10 h-20 w-8p" style="color: #000;">
            <table>
                <tr>
                    <td class=" font10 h-20 w-8p" style="font-weight: normal; color: #000;">
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
        <td class="w-13p">
            <table>
                <tr>
                    <td class="font10 h-20 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                            meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                    </td>
                    <td class="font10 h-20 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                            meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" TabIndex="-1" ID="txtReason"
                            TextMode="MultiLine" CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnRemarksID" runat="server" />
                    </td>
                    <td class=" font10 w-8p" style="font-weight: normal; color: #000;">
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
        <td>
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td class="font10 h-20" style="font-weight: normal; color: #000;">
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
