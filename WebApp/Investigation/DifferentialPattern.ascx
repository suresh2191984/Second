<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DifferentialPattern.ascx.cs"
    Inherits="Investigation_DifferentialPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<table width="100%">
    <tr>
        <td colspan="3" style="font-weight: normal; font-size: 12px; height: 20px; color: #000;
            width: 19%;">
            <asp:Label ID="lblCaption" runat="server" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblCaptionResource1"></asp:Label>
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
                    <tr id="trSource1" runat="server" style="display: none;">
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 19%;
                            padding-left: 20px" runat="server">
                            <asp:Label ID="lblName1" runat="server"></asp:Label>
                        </td>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 83%;
                            padding-left: 20px" runat="server">
                            <asp:TextBox ID="txt1" runat="server"
                                CssClass="Txtboxsmall" onbeforepaste="BeforePaste_Event()"    onkeypress="return ValidateOnlyNumeric(this);"  
                                onPaste="Paste_Event()" Width="150"></asp:TextBox>
                            <asp:Label ID="lblUom1" runat="server" CssClass="blackfontcolor"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trSource2" runat="server" style="display: none;">
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 19%;
                            padding-left: 20px; padding-left: 20px" width="17%" runat="server">
                            <asp:Label ID="lblName2" runat="server"></asp:Label>
                        </td>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 83%;
                            padding-left: 20px" runat="server">
                            <asp:TextBox ID="txt2" runat="server"
                                CssClass="Txtboxsmall" onbeforepaste="BeforePaste_Event()"    onkeypress="return ValidateOnlyNumeric(this);"  
                                onPaste="Paste_Event()" Width="150"></asp:TextBox>
                            <asp:Label ID="lblUom2" runat="server" CssClass="blackfontcolor"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trSource3" runat="server" style="display: none;">
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 19%;
                            padding-left: 20px; padding-left: 20px" width="17%" runat="server">
                            <asp:Label ID="lblName3" runat="server"></asp:Label>
                        </td>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 83%;
                            padding-left: 20px" runat="server">
                            <asp:TextBox ID="txt3" runat="server"
                                CssClass="Txtboxsmall" onbeforepaste="BeforePaste_Event()"    onkeypress="return ValidateOnlyNumeric(this);"  
                                onPaste="Paste_Event()" Width="150"></asp:TextBox>
                            <asp:Label ID="lblUom3" runat="server" CssClass="blackfontcolor"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trSource4" runat="server" style="display: none;">
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 19%;
                            padding-left: 20px; padding-left: 20px" width="17%" runat="server">
                            <asp:Label ID="lblName4" runat="server"></asp:Label>
                        </td>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 83%;
                            padding-left: 20px" runat="server">
                            <asp:TextBox ID="txt4" runat="server"
                                CssClass="Txtboxsmall" onbeforepaste="BeforePaste_Event()"    onkeypress="return ValidateOnlyNumeric(this);"  
                                onPaste="Paste_Event()" Width="150"></asp:TextBox>
                            <asp:Label ID="lblUom4" runat="server" CssClass="blackfontcolor"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trSource5" runat="server" style="display: none;">
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 19%;
                            padding-left: 20px; padding-left: 20px" width="17%" runat="server">
                            <asp:Label ID="lblName5" runat="server"></asp:Label>
                        </td>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 83%;
                            padding-left: 20px" runat="server">
                            <asp:TextBox ID="txt5" runat="server"
                                CssClass="Txtboxsmall" onbeforepaste="BeforePaste_Event()"    onkeypress="return ValidateOnlyNumeric(this);"  
                                onPaste="Paste_Event()" Width="150"></asp:TextBox>
                            <asp:Label ID="lblUom5" runat="server" CssClass="blackfontcolor"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trSource6" runat="server" style="display: none;">
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 19%;
                            padding-left: 20px; padding-left: 20px" width="17%" runat="server">
                            <asp:Label ID="lblName6" runat="server"></asp:Label>
                        </td>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 83%;
                            padding-left: 20px" runat="server">
                            <asp:TextBox ID="txt6" runat="server"
                                CssClass="Txtboxsmall" onbeforepaste="BeforePaste_Event()"    onkeypress="return ValidateOnlyNumeric(this);"  
                                onPaste="Paste_Event()" Width="150"></asp:TextBox>
                            <asp:Label ID="lblUom6" runat="server" CssClass="blackfontcolor"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trSource7" runat="server" style="display: none;">
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 19%;
                            padding-left: 20px; padding-left: 20px" width="17%" runat="server">
                            <asp:Label ID="lblName7" runat="server"></asp:Label>
                        </td>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 83%;
                            padding-left: 20px" runat="server">
                            <asp:TextBox ID="txt7" runat="server"
                                CssClass="Txtboxsmall" onbeforepaste="BeforePaste_Event()"    onkeypress="return ValidateOnlyNumeric(this);"  
                                onPaste="Paste_Event()" Width="150"></asp:TextBox>
                            <asp:Label ID="lblUom7" runat="server" CssClass="blackfontcolor"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trSource8" runat="server" style="display: none;">
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 19%;
                            padding-left: 20px; padding-left: 20px" width="17%" runat="server">
                            <asp:Label ID="lblName8" runat="server"></asp:Label>
                        </td>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 83%;
                            padding-left: 20px" runat="server">
                            <asp:TextBox ID="txt8" runat="server"
                                CssClass="Txtboxsmall" onbeforepaste="BeforePaste_Event()"    onkeypress="return ValidateOnlyNumeric(this);"  
                                onPaste="Paste_Event()" Width="150"></asp:TextBox>
                            <asp:Label ID="lblUom8" runat="server" CssClass="blackfontcolor"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trSource9" runat="server" style="display: none;">
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 19%;
                            padding-left: 20px; padding-left: 20px" width="17%" runat="server">
                            <asp:Label ID="lblName9" runat="server"></asp:Label>
                        </td>
                        <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000; width: 83%;
                            padding-left: 20px" runat="server">
                            <asp:TextBox ID="txt9" runat="server"
                                CssClass="Txtboxsmall" onbeforepaste="BeforePaste_Event()"    onkeypress="return ValidateOnlyNumeric(this);"  
                                onPaste="Paste_Event()" Width="150"></asp:TextBox>
                            <asp:Label ID="lblUom9" runat="server" CssClass="blackfontcolor"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000; width: 8%;">
                            <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                        </td>
                        <td style="font-weight: bold; font-size: 10px; height: 20px; color: #000; width: 8%;">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server"
                                ID="txtRefRange" TextMode="MultiLine" CssClass="Txtboxsmall" Height="30px"
                                meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                            <asp:HiddenField ID="hdnXmlContent" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 8%;">
            <asp:HiddenField runat="server" ID="hidVal" />
            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
        </td>
        <td>
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
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
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 8%;">
            <asp:HiddenField runat="server" ID="HiddenField1" />
            <asp:Label ID="Label1" Text="Technical Remarks" runat="server"></asp:Label>
        </td>
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
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
