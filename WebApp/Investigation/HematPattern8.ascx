<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HematPattern8.ascx.cs"
    Inherits="Investigation_HematPattern8" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script language="javascript" type="text/javascript">
    function HemathideControl(id, Showtxt, Text) {
        //alert(id);
        var splirid = id.split('_');
        //alert(Text);
        if (Text == 'Present') {
            var id = splirid[0] + "_" + Showtxt;
            //alert(splirid[0]);
            //alert(document.getElementById(splirid[0] + "_" + Showtxt).value);
            document.getElementById(splirid[0] + "_" + Showtxt).style.display = 'block';
        }
        else {
            document.getElementById(splirid[0] + "_" + Showtxt).style.display = 'none';
        }
    }
</script>

<table border="0" width="100%" cellpadding="0" cellspacing="0" class="defaultfontcolor">
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
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 25%">
            <asp:RadioButtonList ForeColor="Black"
                runat="server" ID="rdolist" OnSelectedIndexChanged="rdolist_SelectedIndexChanged"
                RepeatDirection="Horizontal" meta:resourcekey="rdolistResource1">
            </asp:RadioButtonList>
        </td>
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 8%">
            <%--            <div id="dShow" runat="server" visible="false">--%>
            <asp:TextBox runat="server" ID="txtValue" Width="70px" Style="display: none;" meta:resourcekey="txtValueResource1"></asp:TextBox>
            <%-- </div>--%>
        </td>
        <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;">
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
        <td style="font-weight: normal; font-size: 10px; color: #000; width: 14%">
            <asp:HiddenField runat="server" ID="hidVal" />
            <table>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal; font-size: 10px; color: #000; width: 8%;">
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
        <td style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 36%">
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
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
