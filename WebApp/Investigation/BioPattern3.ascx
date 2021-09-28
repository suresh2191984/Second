<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BioPattern3.ascx.cs" Inherits="Investigation_BioPattern3" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style>
    .resultCapgrid span
    {
        width: 145px;
    }
    .csspName span
    {
        width: 211px;
    }
    .cssvName span, .cssvName a
    {
        display: table-cell;
        width: 95px;
    }
    .cssUnitName span
    {
        width: 75px;
    }
    .csstxtName textarea
    {
        height: 20px !important;
    }
    .expandClass.expandDdl
    {
        margin: 26px 0 0 0;
        position: absolute;
        top:0;
    }
</style>

<script type="text/javascript">

    function expandDDL() {
        var ddlDataArray = $("select[id$=ddlData]");
        var ddlDataArrayCount = ddlDataArray.length;

        for (var k = 0; k < ddlDataArrayCount; k++) {
            var curobj = ddlDataArray[k];
            var obj = $(curobj).val();
            var selText = $(curobj).find("option:selected").text();
          var selLength = selText.length;
            var flength = (selLength * 7) + 30;
            if (flength < 260) {

                $(curobj).attr("class", "expandClass ddlsmall");
            }
            else {
                $(curobj).attr("class", "ddlsmall");
            }
            // alert(flength);
            $(curobj).css("width", flength + "px");


        }
    }
    $(document).ready(function() {

        expandDDL();
    });
 
</script>

<table class="w-100p defaultfontcolor">
    <tr>
        <td id="tdPatientDetails" runat="server" class="w-30p h-20 bold font12" style="color: #000;
            display: none">
            <table class="w-100p h-20" cellpadding="2" cellspacing="2">
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
        <td id="tdInvName" runat="server" style="font-weight: normal; color: #000; display: table-cell;"
            class="w-11p h-20 font11 csspName">
            <asp:Label ID="Label1" runat="server" Text="Name" meta:resourcekey="lblNameResource1"></asp:Label>
            <asp:Label runat="server" ID="lblName" meta:resourcekey="lblNameResource1"></asp:Label>
</br>
 <asp:Label ID="lblbarcodeno" runat="server" ForeColor="Blue" ></asp:Label> 
            <asp:Label ID="lblTestStatus" Width="15px" runat="server" BackColor="Yellow" Text=""
                meta:resourcekey="lblTestStatusResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>
        </td>
        <td class="v-middle">
            <asp:HyperLink ID="hlnkAdd" Text="Add" Font-Underline="True" runat="server" ForeColor="#0033CC"
                onclick="javascript:changeSourceName(this.id);" meta:resourcekey="hlnkAddResource1"></asp:HyperLink>
        </td>
        <td class="w-89p">
            <table class="w-100p">
                <tr>
                    <td colspan="6" class="a-left" style="position:relative">
                        <asp:DropDownList ID="ddlData" ForeColor="Black" runat="server" meta:resourcekey="ddlDataResource1"
                            CssClass="ddlsmall expandDdl">
                        </asp:DropDownList>
                        <asp:HiddenField ID="hdnDDL" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="color: #000;" class="font10 h-20 bold cssUnitName padding0 w-37p">
                        <asp:Label runat="server" ID="lblUOM" meta:resourcekey="lblUOMResource1"></asp:Label>
                    </td>
                    <td style="color: #000;" class="font10 h-20 bold padding0">
                        <img alt="Device Value" id="imgDeviceValue" style="cursor: pointer;" visible="false"
                            runat="server" />
                    </td>
                    <td style="color: #000;" class="w-8p font10">
                        <table>
                            <tr>
                                <td style="color: #000;" class="w-8p font10 h-20">
                                    <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="color: #000;" class="w-14p font10">
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" TabIndex="-1" ID="txtRefRange"
                                        TextMode="MultiLine" CssClass="small" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                                    <asp:HiddenField ID="hdnXmlContent" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="w-9p" align="center">
                        <table class="tblAbnormal">
                            <tr>
                                <td style="color: #000;" class="w-10p font10 h-10 a-center">
                                    <asp:Label ID="lblIsAbnormal" Text="Abnormal" runat="server" meta:resourcekey="lblIsAbnormalResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: normal; color: #000;" class="font10 a-center">
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
                                <td style="color: #000;" class="font10 h-10 w-8p">
                                    <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                </td>
                                <td style="color: #000;" class="w-8p h-10 font10">
                                    <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtReason" TabIndex="-1"
                                        TextMode="MultiLine" CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                        TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                    </ajc:AutoCompleteExtender>
                                    <asp:HiddenField ID="hdnRemarksID" runat="server" />
                                </td>
                                <td style="color: #000;" class="w-8p font10">
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
                                <td style="color: #000;" class="w-8p h-10 font10">
                                    <asp:Label ID="lblDilution" Text="Dilution" runat="server" meta:resourcekey="lblDilutionResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="color: #000;" class="w-8p h-10 font10">
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtDilution" TabIndex="-1"
                                        CssClass="small" meta:resourcekey="txtDilutionResource1"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="w-40p">
                        <table>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td style="color: #000;" class="h-10 font10">
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
                                                <span class="richcombobox w-100">
                                                    <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                                        CssClass="ddlsmall" meta:resourcekey="ddlOpinionUserResource1">
                                                        <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="tdBetaCheck" runat="server" class="a-center w-25p v-middle ABetaTag" style="display: none;">
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
        </td>
    </tr>
</table>
<asp:HiddenField runat="server" ID="hidVal" />
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
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
