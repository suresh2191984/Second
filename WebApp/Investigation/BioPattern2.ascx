<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BioPattern2.ascx.cs" Inherits="Investigation_BioPattern2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        width: 39px;
    }
    .listMain
    {
        width: 350px !important;
    }
   
    .resultCapgrid span
    {
        width: 145px;
    }
    .csspName span
    {
        width:211px;
    }
    .cssvName span, .cssvName a
     {
        display: table-cell;
        width:95px;
    }
    .cssUnitName span{
        width:75px;
    }
    .csstxtName textarea{ height:20px!important;}
</style>
<table class="defaultfontcolor w-100p">
    <tr>
        <td id="tdPatientDetails" runat="server" class="bold font12 h-20 w-30p" style="display: none">
            <table class="w-100p h-20">
                <tr>
                    <td class="w-45p a-left csspName">
                        <asp:Label runat="server" ID="lblPatientName" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
                        <asp:Label runat="server" ID="lblPatientNumber" 
                            meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
                        <asp:Label runat="server" ID="lblPatientVisitID" 
                            meta:resourcekey="lblPatientVisitIDResource1"></asp:Label>
                    </td>
                    <td class="w-10p a-left cssvName">
                        <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Font-Underline="True"
                            ForeColor="Blue" TabIndex="-1" 
                            meta:resourcekey="lnkPDFReportPreviewerResource1"></asp:LinkButton>
                    </td>
                    <td class="w-40p">
                        <asp:Label runat="server" ID="lblAge" meta:resourcekey="lblAgeResource1"></asp:Label>
                        <span>/</span>
                        <asp:Label runat="server" ID="lblSex" meta:resourcekey="lblSexResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td id="tdInvName" runat="server" class="font11 h-20 w-11p csspName" style="font-weight: normal;
            color: #000; display: table-cell;">
            <asp:Label runat="server" ID="lblName" meta:resourcekey="lblNameResource1"></asp:Label>
</br>
<asp:Label ID="lblbarcodeno" runat="server" ForeColor="Blue" ></asp:Label> 
            <asp:Label ID="lblTestStatus" runat="server" BackColor="Yellow" Width="15px"
                meta:resourcekey="lblTestStatusResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>
        </td>
        <td class="padding0">
            <%--<asp:HyperLink ID="hlnkAdd" Text="Add" Font-Underline="True" runat="server" ForeColor="#0033CC"
                onclick="javascript:changeSourceName(this.id);" meta:resourcekey="hlnkAddResource1"></asp:HyperLink>--%>
        </td>
        <td class="w-11p">
            <div id="DFemale" runat="server">
               <%-- <asp:DropDownList ForeColor="Black" ID="ddlData" runat="server" CssClass="ddlsmall"
                    onmousedown="expandDropDownList1(this);" onblur="collapseDropDownList1(this);"
                    meta:resourcekey="ddlDataResource1">--%>
                    <asp:DropDownList ForeColor="Black" ID="ddlData" runat="server" CssClass="ddlsmall"
                    meta:resourcekey="ddlDataResource1">
                </asp:DropDownList>
                <asp:HiddenField ID="hdnDDL" runat="server" />
            </div>
        </td>
        <td class="w-11p padding0 ieDMale">
            <div id="DMale" runat="server">
                <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="True" ID="txtResult" runat="server"
                          meta:resourcekey="txtResultResource1"></asp:TextBox>
            </div>
        </td>
        <td class="bold font10 h-20 padding0" style="color: #000;">
            <div runat="server" id="DUom">
                <asp:Label runat="server" ID="lblUOM" meta:resourcekey="lblUOMResource1"></asp:Label>
                <asp:HiddenField runat="server" ID="hidVal" />
            </div>
        </td>
        <td class="bold font10 h-20 padding0" style="color: #000;">
            <img alt="Device Value" id="imgDeviceValue" style="cursor: pointer;" visible="false"
                runat="server" />
        </td>
        <td class="font10 w-8p padding0" style="font-weight: normal; color: #000;">
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtRefRange" TextMode="MultiLine"
                            CssClass="small" meta:resourcekey="txtRefRangeResource1" TabIndex="-1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-8p" align="center">
            <table class="tblAbnormal">
                <tr>
                    <td class="font10 h-10 a-center" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblIsAbnormal" Text="Abnormal" runat="server" meta:resourcekey="lblIsAbnormalResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 a-center" style="font-weight: normal; color: #000;">
                        <span id="spanIsAbnormal" style="cursor: pointer;" runat="server">
                            <asp:TextBox ID="txtIsAbnormal" Enabled="False" runat="server" CssClass="w-10 h-10"
                                Style="background: white;" TabIndex="-1" 
                            meta:resourcekey="txtIsAbnormalResource1"></asp:TextBox>
                        </span>
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-14p">
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                    </td>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" TabIndex="-1" ID="txtReason"
                            TextMode="MultiLine" CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnRemarksID" runat="server" />
                    </td>
                    <td class="font10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
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
                        <asp:Label ID="lblDilution" Text="Dilution" runat="server" meta:resourcekey="lblDilutionResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="font10 w-8p" style="font-weight: normal; color: #000;">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtDilution" TabIndex="-1"
                            CssClass="textbox_pattern small" meta:resourcekey="txtDilutionResource1"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-30p">
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td class="font10 h-10" style="font-weight: normal; color: #000;">
                        <table id="tdInvStatusReason1" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblReason" Text="Reason" runat="server" meta:resourcekey="lblReasonResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOpinionUser" runat="server" Text="User" meta:resourcekey="lblOpinionUserResource1" />
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
                                         onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                        meta:resourcekey="ddlStatusReasonResource1" CssClass="ddlsmall">
                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox" class="w-100">
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddlsmall" meta:resourcekey="ddlOpinionUserResource1">
                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td id="tdBetaCheck" runat="server" class="a-center v-middle w-25p" style="display: none;">
                        <a id="ABetaTag" runat="server" onclick="CallShowBetaPopUp(this.id);" style="display: block;
                            font-size: large; color: Red"><u>Δ</u></a>
                        <asp:Label ID="lblPVisitID" runat="server" Style="display: none;" meta:resourcekey="lblPVisitIDResource1"></asp:Label>
                        <asp:Label ID="lblPatternID" runat="server" Style="display: none;" meta:resourcekey="lblPatternIDResource1"></asp:Label>
                        <asp:Label ID="lblInvID" runat="server" Style="display: none;" meta:resourcekey="lblInvIDResource1"></asp:Label>
                        <asp:Label ID="lblOrgID" runat="server" Style="display: none;" meta:resourcekey="lblOrgIDResource1"></asp:Label>
                        <asp:Label ID="lblPatternClassName" runat="server" Style="display: none;" meta:resourcekey="lblPatternClassNameResource1"></asp:Label>
                        <asp:HiddenField ID="hdnddlData" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
<asp:HiddenField ID="hdnUID" runat="server" Value="0" />
<asp:HiddenField ID="hdnLabNo" runat="server" Value="0" />
<asp:HiddenField ID="hdnGroupID" runat="server" Value="0" />
<asp:HiddenField ID="hdnGroupName" runat="server" Value="" />
<asp:HiddenField ID="hdnPackageID" runat="server" Value="0" />
<asp:HiddenField ID="hdnPackageName" runat="server" Value="0" />
<asp:HiddenField ID="hdnAutoApproveLoginID" runat="server" Value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<asp:HiddenField ID="hdnIsAbnormal" runat="server" Value="" />
<asp:HiddenField ID="hdnIsAutoValidate" runat="server" Value="" />
