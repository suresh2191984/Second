<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HematPattern10.ascx.cs"
    Inherits="Investigation_HematPattern10" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<style type="text/css">
    .style1
    {
        width: 9%;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>
<table border="0" width="100%" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr>
        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 16%">
            <asp:Label runat="server" ID="lblName" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource2"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource2"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u>Edit</u></a>
        </td>
        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 10%">
            <asp:Label runat="server" ID="lblControl" Text="Control PT" meta:resourcekey="lblControlResource2"></asp:Label>
        </td>
        <td class="style1">
            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" CssClass="Txtboxsmall"
                ID="txtControl" Width="40px" meta:resourcekey="txtControlResource2"></asp:TextBox>
        </td>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000; width: 8%;">
            <asp:Label ID="lblmins" runat="server" Text="Secs" meta:resourcekey="lblminsResource2"></asp:Label>
        </td>
        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 10%">
            <asp:Label runat="server" ID="lblPatient" Text="Patient PT" meta:resourcekey="lblPatientResource2"></asp:Label>
        </td>
        <td style="width: 7%">
            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" CssClass="Txtboxsmall"
                ID="txtPatient" Width="40px" meta:resourcekey="txtPatientResource2"></asp:TextBox>
        </td>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000; width: 6%;">
            <asp:Label ID="Label1" runat="server" Text="Secs" meta:resourcekey="Label1Resource2"></asp:Label>
        </td>
        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 2%">
            <div runat="server" id="Dshow" visible="true">
                <table>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lblINR" Text="INR" meta:resourcekey="lblINRResource2"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" CssClass="Txtboxsmall"
                                ID="txtINR" Width="40px" meta:resourcekey="txtINRResource2"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
        <td style="font-weight: bold; font-size: 10px; color: #000; width: 8%;">
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource2"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server"
                            TabIndex="-1" ID="txtRefRange" TextMode="MultiLine" CssClass="Txtboxsmall"
                            Height="30px" meta:resourcekey="txtRefRangeResource2"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td style="font-weight: bold; font-size: 10px; color: #000; width: 8%;">
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server"
                            TabIndex="-1" ID="txtReason" TextMode="MultiLine" CssClass="Txtboxsmall"
                            Height="30px" meta:resourcekey="txtReasonResource2"></asp:TextBox>
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
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;">
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
        <td style="width: 14%;display:none;">
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="lblDilution" Text="Dilution" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtDilution" TabIndex="-1"
                            CssClass="Txtboxsmall"
                            Width="45px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
        <td style="width: 14%">
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
                    <td id="tdDeltaCheck" runat="server" align="center" style="width: 15%; display: none;"
                        valign="middle">
                        <a id="ADeltaTag" runat="server" onclick="CallShowPopUp(this.id);" style="display: block;
                            font-size: larger; color: Red"><u>Δ</u></a>
                    </td>
                    <td id="tdBetaCheck" runat="server" align="center" style="width: 15%; display: none;"
                        valign="middle">
                        <a id="ABetaTag" runat="server" onclick="CallShowBetaPopUp(this.id);" style="display: block;
                            font-size: large; color: Red"><u>Δ</u></a>
                        <asp:Label ID="lblPVisitID" runat="server" Style="display: none;"></asp:Label>
                        <asp:Label ID="lblPatternID" runat="server" Style="display: none;"></asp:Label>
                        <asp:Label ID="lblInvID" runat="server" Style="display: none;"></asp:Label>
                        <asp:Label ID="lblOrgID" runat="server" Style="display: none;"></asp:Label>
                        <asp:Label ID="lblPatternClassName" runat="server" Style="display: none;"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <asp:HiddenField runat="server" ID="hidVal" />
            <asp:HiddenField runat="server" ID="hidISI" />
        </td>
    </tr>
</table>

<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />