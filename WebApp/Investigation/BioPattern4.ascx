<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BioPattern4.ascx.cs" Inherits="Investigation_BioPattern4" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table class="w-100p defaultfontcolor">
    <tr>
        <td id="tdInvName" runat="server" class="font11 h-20 w-19" style="font-weight: normal;
            color: #000; display: table-cell;">
            <asp:Label runat="server" ID="lblName" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                 <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>
        </td>
        <td id="tdPatientDetails" runat="server" class="bold font12 h-20 w-25p" style="color: #000;
            display: none">
            <table class="w-85p h-20">
                <tr>
                    <td class="w-35p">
                        <asp:Label runat="server" ID="lblPatientName"></asp:Label>
                    </td>
                    <td class="w-30p">
                        <asp:Label runat="server" ID="lblAge"></asp:Label>
                    </td>
                    <td class="w-20p">
                        <asp:Label runat="server" ID="lblSex"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-10p">
            <asp:DropDownList ID="ddlData" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlDataResource1">
            </asp:DropDownList>
        </td>
        <td>
            <asp:DropDownList ID="ddlType" CssClass="ddlsmall" runat="server" AutoPostBack="True"
                OnSelectedIndexChanged="ddlType_SelectedIndexChanged" meta:resourcekey="ddlTypeResource1">
            </asp:DropDownList>
        </td>
        <td>
            <div id="divHCGResult" runat="server">
                <asp:TextBox ID="txtResult" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                    meta:resourcekey="txtResultResource1" CssClass="small"></asp:TextBox>
                <asp:Label runat="server" ID="lblUOM" meta:resourcekey="lblUOMResource1"></asp:Label>
            </div>
        </td>
        <td>
            <div id="divHCGQual" runat="server">
                <asp:DropDownList ID="ddlResult" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlResultResource1"
                    TabIndex="1">
                </asp:DropDownList>
            </div>
        </td>
        <td>
            <asp:HiddenField runat="server" ID="hidVal" />
        </td>
        <td class="bold font10 h-20 w-8p" style="color: #000;">
            <table>
                <tr>
                    <td class="font10 h-20 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                    <td class="font10 h-20 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblIsAbnormal" Text="Abnormal" runat="server" meta:resourcekey="lblIsAbnormalResource1"></asp:Label>
                    </td>
                    <td class="font10 h-20 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                    </td>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" TabIndex="-1" ID="txtRefRange"
                            TextMode="MultiLine" CssClass="small" Text="Reference range" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                    </td>
                    <td>
                        <span id="spanIsAbnormal" style="cursor: pointer;" runat="server">
                            <asp:TextBox ID="txtIsAbnormal" CssClass="w-10 h-10" Enabled="false" runat="server"
                                Style="background: white;" TabIndex="-1"></asp:TextBox>
                        </span>
                    </td>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" TabIndex="-1"
                            TextMode="MultiLine" CssClass="small" Text="Comments" meta:resourcekey="txtReasonResource1"></asp:TextBox>
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
        <td class="w-14p" style="display: none;">
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblDilution" Text="Dilution" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtDilution" TabIndex="-1"
                            CssClass="small"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-20p">
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
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<asp:HiddenField ID="hdnIsAutoValidate" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
