<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HematPattern7.ascx.cs"
    Inherits="Investigation_HematPattern7" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        height: 20px;
        width: 12%;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr>
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 18%;">
            <asp:Label runat="server" ID="lblName" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u>Edit</u></a>
        </td>
        <td style="font-weight: normal; font-size: 10px; color: #000;" class="style1">
            <asp:RadioButtonList ForeColor="Black" runat="server"
                ID="rdolist" AutoPostBack="True" OnSelectedIndexChanged="rdolist_SelectedIndexChanged"
                meta:resourcekey="rdolistResource1">
            </asp:RadioButtonList>
        </td>
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 10%;">
            <asp:DropDownList ForeColor="Black" ID="ddlShow" CssClass="ddl"
                runat="server" Visible="False" meta:resourcekey="ddlShowResource1">
            </asp:DropDownList>
            <asp:HiddenField runat="server" ID="hidVal" />
        </td>
        <td style="font-weight: normal; font-size: 10px; color: #000; width: 10%;">
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 10%;">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 10%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtRefRange"
                            TextMode="MultiLine" CssClass="Txtboxsmall" Height="30px" Width="128px" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td style="font-weight: normal; font-size: 10px; color: #000; width: 14%;">
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 10%;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 10%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason"
                            TextMode="MultiLine" CssClass="Txtboxsmall" Height="30px" meta:resourcekey="txtReasonResource1"></asp:TextBox>
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
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 10%;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 10%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                            TabIndex="-1" TextMode="MultiLine"
                            CssClass="Txtboxsmall" Height="30px"></asp:TextBox>
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
    </tr>
    <tr>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000;">
            <asp:CheckBox runat="server"
                ID="chkName1" AutoPostBack="True" OnCheckedChanged="chkName1_CheckedChanged"
                Visible="False" meta:resourcekey="chkName1Resource1" />
        </td>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000;" colspan="2">
            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" CssClass="Txtboxsmall"
                ID="txtValue1" Visible="False" meta:resourcekey="txtValue1Resource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000;" colspan="2">
            <asp:CheckBox runat="server" onclick="javascript:return setCompletedStatus(this.id);"
                ID="chkName2" AutoPostBack="True" OnCheckedChanged="chkName2_CheckedChanged"
                Visible="False" meta:resourcekey="chkName2Resource1" />
        </td>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000;" colspan="2">
            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" CssClass="Txtboxsmall"
                ID="txtValue2" Visible="False" meta:resourcekey="txtValue2Resource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000;" colspan="2">
            <asp:CheckBox runat="server"
                ID="chkName3" AutoPostBack="True" OnCheckedChanged="chkName3_CheckedChanged"
                Visible="False" meta:resourcekey="chkName3Resource1" />
        </td>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000;" colspan="2">
            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" CssClass="Txtboxsmall"
                ID="txtValue3" Visible="False" meta:resourcekey="txtValue3Resource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000;">
            &nbsp;
        </td>
        <td style="font-weight: bold; font-size: 10px; color: #000;" class="style1">
            &nbsp;
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />