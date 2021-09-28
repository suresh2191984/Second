<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImagingWithFCKEditor.ascx.cs"
    Inherits="Investigation_ImagingWithFCKEditor" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<table class="w-100p">
    <tr>
        <td class="a-center font12 h-20 w-10p" style="font-weight: normal;
            color: #000;">
            <asp:Label runat="server" ID="lblName"> </asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="false" OnClick="lnkEdit_Click"
                ForeColor="Red"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false">
                <u>
                <%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %>
                </u>
                </a>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlV" runat="server">
                <table class="w-100p">
                    <tr>
                        <td class="font11 w-15p" style="font-weight: normal; color: #000;">
                            <asp:Label runat="server" ID="lblPerfPhysician" Text="Select Reporting Radiologist"> </asp:Label>
                        </td>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:DropDownList ForeColor="Black" ID="ddlperfPhysician" CssClass="ddlsmall"
                                runat="server">
                            </asp:DropDownList>
                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                        </td>
                        <td class="a-right font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:LinkButton ID="lnkAutoSave" runat="server" Text="AutoSave" ForeColor="Black"
                                OnClick="lnkAutoSave_Click"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11" style="font-weight: normal; color: #000;">
                            <%=Resources.Investigation_ClientDisplay.Investigation_ImagingWithFCKEditor_ascx_02 %>
                        </td>
                        <td class="font11 a-left" style="font-weight: normal; color: #000;">
                            <asp:DropDownList ForeColor="Black" ID="ddlInvResultTemplate" CssClass="ddlsmall"
                                AutoPostBack="false" runat="server" EnableViewState="true" OnSelectedIndexChanged="ddlInvResultTemplate_SelectedIndexChanged">
                            </asp:DropDownList>
                            &nbsp;&nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11" style="font-weight: normal; color: #000;">
                            <%-- Select Modality--%>
                        </td>
                        <td>
                            <asp:Button ID="btnGo" runat="server" Text="Load Template" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" OnClick="btnGo_Click" />
                        </td>
                        <td style="font-weight: normal; color: #000;">
                            <asp:DropDownList Visible="false" ForeColor="Black" ID="ddlDept" AutoPostBack="false"
                                CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            &nbsp;&nbsp;
                            <asp:Button Visible="false" ID="btnFilter" runat="server" Text="Filter" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnFilter_Click" />
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="a-left">
            <table class="w-100p">
                <tr>
                    <td>
                        &nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                        <asp:Panel ID="pnlShow" Enabled="true" runat="server">
                            <table class="w-80p">
                                <tr>
                                    <td class="a-left font11 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label Font-Bold="true" runat="server" ID="lblInvDetails" Text="Technique"> </asp:Label>
                                    </td>
                                    <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                        <FCKeditorV2:FCKeditor ID="fckInvDetails" runat="server" Width="580px" Height="150px">
                                        </FCKeditorV2:FCKeditor>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left font11 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label Font-Bold="true" ID="lblFindings" runat="server" Text="Findings"> </asp:Label>
                                    </td>
                                    <td>
                                        <FCKeditorV2:FCKeditor ID="FCKinvFinidings" runat="server" Width="580px" Height="280px">
                                        </FCKeditorV2:FCKeditor>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left font11 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label Font-Bold="true" ID="lblImpression" runat="server" Text="Conclusion"> </asp:Label>
                                    </td>
                                    <td>
                                        <FCKeditorV2:FCKeditor ID="FCKImpression" runat="server" Width="580px" Height="220px">
                                        </FCKeditorV2:FCKeditor>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblAddNotes" Visible="false" runat="server" Text="Additional Notes"> </asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtAddNotes" Visible="false"
                                            runat="server" TextMode="MultiLine" CssClass="small"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="a-left font10 h-8 w-20p" style="color: #000;">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <table>
                <tr>
                    <td>
                        <%=Resources.Investigation_ClientDisplay.Investigation_ImagingWithFCKEditor_ascx_03 %>
                    </td>
                    <td>
                        <table>
                            <tr>
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
                                    <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" CssClass="ddlsmall"
                                        TabIndex="-1" onChange="javascript:ShowStatusReason(this.id);" meta:resourcekey="ddlstatusResource1">
                                        <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" CssClass="ddlsmall" runat="server" TabIndex="-1"
                                                     onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
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
        </td>
    </tr>
    <asp:HiddenField runat="server" ID="hidVal" />
</table>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<script language="javascript" type="text/javascript">

    function fnenable(ID) {
        alert("FEN" + ID);
        var oEditor = FCKeditorAPI.GetInstance('5331~~0_fckInvDetails');
        alert(oEditor);
        oEditor.EditorDocument.body.disabled = true
    }
</script>

