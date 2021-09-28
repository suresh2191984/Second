<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WidelPattern.ascx.cs"
    Inherits="Investigation_WidelPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        width: 611px;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>

<table border="0ss" width="100%" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr>
        <td style="font-weight: Bold; font-size: 11px; color: #000;">
            <asp:Label runat="server" ID="lblName" meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u>Edit</u></a>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlenabled" runat="server" meta:resourcekey="pnlenabledResource1">
                <table>
                    <tr>
                        <td class="style1">
                            <table width="60%">
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                        <label>
                                            <asp:Label ID="Rs_Type" Text="Type" runat="server" meta:resourcekey="Rs_TypeResource1"></asp:Label></label>
                                    </td>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 20%">
                                        <label>
                                            <asp:Label ID="Rs_Dilution" Text="Dilution" runat="server" meta:resourcekey="Rs_DilutionResource1"></asp:Label></label>
                                    </td>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 20%">
                                        <label>
                                            <asp:Label ID="Rs_Result" Text="Result" runat="server" meta:resourcekey="Rs_ResultResource1"></asp:Label></label>
                                    </td>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 20%">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <asp:Panel ID="pn4122" runat="server" meta:resourcekey="pn4122Resource1">
                                <table width="60%">
                                    <tr>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:Label ID="lblname2" runat="server" Text="S. Typhi O" meta:resourcekey="lblname2Resource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtdilution2"
                                                runat="server" Width="82px" meta:resourcekey="txtdilution2Resource1"></asp:TextBox>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:DropDownList ForeColor="Black" ID="ddlresult2" runat="server" CssClass="ddl" Width="100px"
                                                meta:resourcekey="ddlresult2Resource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:HyperLink ID="hlnkAdd1" Text="Add" Font-Underline="True" runat="server" ForeColor="#0033CC"
                                                onclick="javascript:changeSourceName(this.id);" meta:resourcekey="hlnkAdd1Resource1"></asp:HyperLink>
                                            <asp:HiddenField ID="hdnDDL1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <asp:Panel ID="pn4121" runat="server" meta:resourcekey="pn4121Resource1">
                                <table width="60%">
                                    <tr>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:Label ID="lblname1" runat="server" Text="S. Typhi H" meta:resourcekey="lblname1Resource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtdilution1"
                                                runat="server" Width="83px" meta:resourcekey="txtdilution1Resource1"></asp:TextBox>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:DropDownList ForeColor="Black" ID="ddlresult1" runat="server" CssClass="ddl" Width="100px"
                                                meta:resourcekey="ddlresult1Resource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:HyperLink ID="hlnkAdd2" Text="Add" Font-Underline="True" runat="server" ForeColor="#0033CC"
                                                onclick="javascript:changeSourceName(this.id);" meta:resourcekey="hlnkAdd2Resource1"></asp:HyperLink>
                                            <asp:HiddenField ID="hdnDDL2" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <asp:Panel ID="pn4123" runat="server" meta:resourcekey="pn4123Resource1">
                                <table width="60%">
                                    <tr>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:Label ID="lblname3" runat="server" Text="S. Paratyphi AH" meta:resourcekey="lblname3Resource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtdilution3"
                                                runat="server" Width="81px" meta:resourcekey="txtdilution3Resource1"></asp:TextBox>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:DropDownList ForeColor="Black" ID="ddlresult3" runat="server" CssClass="ddl" Width="100px"
                                                meta:resourcekey="ddlresult3Resource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:HyperLink ID="hlnkAdd3" runat="server" ForeColor="#0033CC" onclick="javascript:changeSourceName(this.id);"
                                                meta:resourcekey="hlnkAdd3Resource1" Text="Add"></asp:HyperLink>
                                            <asp:HiddenField ID="hdnDDL3" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <asp:Panel ID="pn4124" runat="server" meta:resourcekey="pn4124Resource1">
                                <table width="60%">
                                    <tr>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:Label ID="lblname4" runat="server" Text="S. Paratyphi BH" meta:resourcekey="lblname4Resource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtdilution4"
                                                runat="server" Width="80px" meta:resourcekey="txtdilution4Resource1"></asp:TextBox>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:DropDownList ForeColor="Black" ID="ddlresult4" runat="server" CssClass="ddl" Width="100px"
                                                meta:resourcekey="ddlresult4Resource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                                            <asp:HyperLink ID="hlnkAdd4" runat="server" ForeColor="#0033CC" onclick="javascript:changeSourceName(this.id);"
                                                meta:resourcekey="hlnkAdd4Resource1" Text="Add"></asp:HyperLink>
                                            <asp:HiddenField ID="hdnDDL4" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <table width="40%">
                                <tr>
                                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 20%">
                                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                                    </td>
                                    <td style="font-weight: normal; font-size: 10px; height: 30px; color: #000; width: 20%">
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtRefRange"
                                            TextMode="MultiLine" CssClass="Txtboxsmall" Height="30px" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td>
            <table width="40%">
                <tr>
                    <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                        <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                    </td>
                    <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
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
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="40%">
                <tr>
                    <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                    </td>
                    <td style="width: 20%">
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
                    <td style="font-weight: normal; font-size: 11px; color: #000; width: 20%">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server"></asp:Label>
                    </td>
                    <td style="width: 20%">
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                            TabIndex="-1" TextMode="MultiLine"
                            CssClass="Txtboxsmall" Height="30px" Width="122px"></asp:TextBox>
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
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />