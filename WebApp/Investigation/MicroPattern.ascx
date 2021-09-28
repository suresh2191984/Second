<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MicroPattern.ascx.cs"
    Inherits="Investigation_MicroPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script language="javascript" type="text/javascript">
    function ShowCyto() {

        if (document.getElementById('<%=ddlType.ClientID%>').options[document.getElementById('<%=ddlType.ClientID%>').selectedIndex].innerHTML == 'Quantitative') {
            document.getElementById('<%=Dtxt.ClientID%>').style.display = "block";
            document.getElementById('<%=Dresult.ClientID %>').style.display = "block";
        }
        else if (document.getElementById('<%=ddlType.ClientID%>').options[document.getElementById('<%=ddlType.ClientID%>').selectedIndex].innerHTML == 'Qualitative') {
            document.getElementById('<%=Dtxt.ClientID%>').style.display = "none";
            document.getElementById('<%=Dresult.ClientID%>').style.display = "block";
        }
        else {
            document.getElementById('<%=Dtxt.ClientID%>').style.display = "none";
            document.getElementById('<%=Dresult.ClientID%>').style.display = "none";
        }
    }
</script>

<table border="1" width="100%" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr>
        <td>
            <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="false" OnClick="lnkEdit_Click"
                ForeColor="Red"></asp:LinkButton>
        </td>
        <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
        <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
            visible="false"><u>Edit</u></a>
        <td>
            <asp:DropDownList ForeColor="Black" TabIndex="1" CssClass="ddl"
                ID="ddlSource" runat="server">
            </asp:DropDownList>
        </td>
        <td>
            <asp:DropDownList ForeColor="Black" TabIndex="1" ID="ddlMethod" CssClass="ddl"
                runat="server">
            </asp:DropDownList>
        </td>
        <td>
            <asp:DropDownList ForeColor="Black" ID="ddlType" TabIndex="1" CssClass="ddl"
                runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
            </asp:DropDownList>
        </td>
        <td>
            <div id="Dtxt" visible="true" runat="server">
                <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" TabIndex="1" CssClass="Txtboxsmall"
                    ID="txtValue" Width="40px"></asp:TextBox>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td style="width: 38%">
                        <div id="Dresult" visible="true" runat="server">
                            <asp:DropDownList ForeColor="Black" ID="ddlResult" TabIndex="1" CssClass="ddl"
                                runat="server">
                            </asp:DropDownList>
                        </div>
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
                                    <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1"
                                        meta:resourcekey="ddlstatusResource1" CssClass="ddl">
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
        <td colspan="2">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" Style="font-weight: normal;
                            font-size: 10px; color: #000; width: 30%;"></asp:Label><br />
                    </td>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server"
                            ID="txtReason" TextMode="MultiLine" CssClass="Txtboxsmall" Height="30px"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                        </ajc:AutoCompleteExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" Style="font-weight: normal;
                            font-size: 10px; color: #000; width: 30%;"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                            TabIndex="-1" TextMode="MultiLine"
                            CssClass="Txtboxsamll" Height="30px"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                        <asp:HiddenField ID="hdnRemarksID" runat="server" />
                        <asp:HiddenField ID="hidVal" runat="server" />
                        <asp:HiddenField ID="hidShow" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />

<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
