<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CastPattern.ascx.cs" Inherits="Investigation_CastPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        width: 19%;
        height: 32px;
    }
    .style2
    {
        width: 18%;
        height: 32px;
    }
    .style3
    {
        width: 13%;
        height: 32px;
    }
    .style4
    {
        width: 50%;
        height: 32px;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>

<table border="0" width="100%" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr>
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 18%;"
            rowspan="2">
            <asp:Label ID="lblName" runat="server" Text="Name" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u>Edit</u></a>
        </td>
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 18%;">
            <asp:DropDownList ForeColor="Black" ID="ddlCasts" runat="server" CssClass="ddl"
                AutoPostBack="True" OnSelectedIndexChanged="ddlCasts_SelectedIndexChanged" meta:resourcekey="ddlCastsResource1">
            </asp:DropDownList>
            <asp:Label runat="server" ID="lblUOM" Text="cells/hpf" meta:resourcekey="lblUOMResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;"
            rowspan="2">
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server"
                            ID="txtRefRange" TextMode="MultiLine" CssClass="Txtboxsmall" Height="30px"
                            meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;"
            rowspan="2">
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                    </td>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server"
                            ID="txtReason" TextMode="MultiLine" CssClass="Txtboxsmall" Height="30px" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnRemarksID" runat="server" />
                    </td>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                            TabIndex="-1" TextMode="MultiLine"
                            CssClass="Txtboxsmall" Height="30px" meta:resourcekey="txtReasonResource1"></asp:TextBox>
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
        <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;"
            rowspan="2">
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000;">
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
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddl"
                            meta:resourcekey="ddlstatusResource1">
                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1" CssClass="ddl"
                                        Width="100px" normalWidth="100px" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                                         <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox" style="width: 100px;">
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddl" Width="100px">
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
        </td>
    </tr>
    <tr>
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 18%;">
            <asp:HyperLink ID="hlnkAdd" Text="Add" Font-Underline="True" runat="server" ForeColor="#0033CC"
                onclick="javascript:changeSourceName(this.id);" meta:resourcekey="hlnkAddResource1"></asp:HyperLink>
            <asp:HiddenField ID="hdnDDL" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
        <td colspan="3">
            <div id="divCastsPresent" visible="false" runat="server">
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="font-weight: bold; font-size: 10px; color: #000; width: 8%;">
                            <asp:CheckBoxList ForeColor="Black" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                                ID="chkCasts" meta:resourcekey="chkCastsResource1">
                            </asp:CheckBoxList>
                            <asp:HiddenField ID="hidVal" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>

<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />