<%@ Control Language="C#" AutoEventWireup="true" CodeFile="aPTTPattern.ascx.cs" Inherits="Investigation_aPTTPattern" %>
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
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_HEMATOLOGY_ascx_01 %></u></a>
        </td>
        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 10%">
            <asp:Label runat="server" ID="lblControl" Text="Control aPTT" meta:resourcekey="lblControlResource1"></asp:Label>
        </td>
        <td class="style1">
            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                ID="txtControl" Width="40px" CssClass="Txtboxverysmall" meta:resourcekey="txtControlResource1"></asp:TextBox>
        </td>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000; width: 8%;">
            <asp:Label ID="lblmins" runat="server" Text="Secs" meta:resourcekey="lblminsResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 10%">
            <asp:Label runat="server" ID="lblPatient" Text="Patient aPTT" meta:resourcekey="lblPatientResource1"></asp:Label>
        </td>
        <td style="width: 7%">
            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                ID="txtPatient" Width="40px" CssClass="Txtboxverysmall" meta:resourcekey="txtPatientResource1"></asp:TextBox>
        </td>
        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000; width: 6%;">
            <asp:Label ID="Label1" runat="server" Text="Secs" meta:resourcekey="Label1Resource1"></asp:Label>
        </td>
        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 2%;
            display: none;">
            <div runat="server" id="Dshow" visible="true">
                <table>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lblINR" Text="INR" meta:resourcekey="lblINRResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                                ID="txtINR" Width="40px" CssClass="Txtboxverysmall" meta:resourcekey="txtINRResource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
        <td style="font-weight: bold; font-size: 10px; height: 40px; color: #000; width: 8%;">
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 40px; color: #000; width: 8%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" onkeyup="javascript:return setCompletedStatus(this.id);"
                            TabIndex="-1" ID="txtRefRange" TextMode="MultiLine" CssClass="Txtboxsmall"
                            Height="90%" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td style="font-weight: bold; font-size: 10px; height: 40px; color: #000; width: 8%;">
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 50px; color: #000; width: 8%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" onkeyup="javascript:return setCompletedStatus(this.id);"
                            TabIndex="-1" TextMode="MultiLine" CssClass="Txtboxsmall" Height="84%"></asp:TextBox>
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
                    <td style="font-weight: normal; font-size: 10px; height: 50px; color: #000; width: 8%;">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                            onkeyup="javascript:return setCompletedStatus(this.id);" TabIndex="-1" TextMode="MultiLine"
                            CssClass="Txtboxsmall" Height="84%"></asp:TextBox>
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
        <td style="width: 50%">
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
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" onChange="javascript:ShowStatusReason(this.id);"
                            meta:resourcekey="ddlstatusResource1">
                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
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
        <td>
            <asp:HiddenField runat="server" ID="hidVal" />
            <asp:HiddenField runat="server" ID="hidISI" />
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
