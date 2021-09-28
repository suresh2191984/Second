<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AbdominalExam.ascx.cs"
    Inherits="HealthPackageControls_AbdominalExam" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">

    function showContent(id) {

        var chkvalue = id.split('_');
        var trid = chkvalue[0] + "_tr1" + chkvalue[1] + "_" + chkvalue[2];
        if (document.getElementById(id).checked == true) {
            document.getElementById(trid).style.display = 'block';
        }
        else {
            document.getElementById(trid).style.display = 'none';
        }

    }
    
</script>
<div id="divAE1" onclick="showResponses('tcEMR_tpExamination_AbdominalExam1_divAE1','tcEMR_tpExamination_AbdominalExam1_divAE2','divAE3',1);"  
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label31" Text="Abdominal Examination" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divAE2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_AbdominalExam1_divAE1','tcEMR_tpExamination_AbdominalExam1_divAE2','divAE3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label32" Text="Abdominal Examination" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divAE3" style="display: none;width:100%" title="Abdominal Examination">

<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblAbdominalExamination_888" runat="server" 
                Text="ABDOMINAL EXAMINATION" 
                meta:resourcekey="lblAbdominalExamination_888Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkAbdominalInspection_889" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkAbdominalInspection_889" runat="server" Text="Abdominal Inspection"
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkAbdominalInspection_889Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkAbdominalInspection_889" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr class="defaultfontcolor">
                    <td style="width: 100px">
                        <asp:Label ID="lblInspection_58" runat="server" Text="Inspection" 
                            meta:resourcekey="lblInspection_58Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlInspection_58" runat="server" 
                            meta:resourcekey="ddlInspection_58Resource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR1" visible="true" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkAbdominalPalpation_890" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkAbdominalPalpation_890" runat="server" Text="Abdominal Palpation"
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkAbdominalPalpation_890Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkAbdominalPalpation_890" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr class="defaultfontcolor">
                    <td style="width: 100px">
                        <asp:Label ID="lblPalpation_59" runat="server" Text="Palpation" 
                            meta:resourcekey="lblPalpation_59Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPalpation_59" runat="server" 
                            meta:resourcekey="ddlPalpation_59Resource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR2" visible="true" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkLiver_891" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkLiver_891" runat="server" Text="Liver" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkLiver_891Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkLiver_891" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="lblType_60" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_60Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_60" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_60_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_60Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR3" visible="true" runat="server" />
                            </td>
                            <td id="trDescription_61" runat="server" style="display: none;">
                                <asp:Label ID="lblDescription_61" runat="server" Text="Description" 
                                    meta:resourcekey="lblDescription_61Resource1"></asp:Label>
                                <asp:TextBox ID="txtDescription_234" runat="server" 
                                    meta:resourcekey="txtDescription_234Resource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_60" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkSpleen_892" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkSpleen_892" runat="server" Text="Spleen" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkSpleen_892Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkSpleen_892" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_62" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_62Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_62" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_62_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_62Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR4" visible="true" runat="server" />
                            </td>
                            <td id="trDescription_63" runat="server" style="display: none;">
                                <asp:Label ID="lblDescription_63" runat="server" Text="Description" 
                                    meta:resourcekey="lblDescription_63Resource1"></asp:Label>
                                <asp:TextBox ID="txtDescription_238" runat="server" 
                                    meta:resourcekey="txtDescription_238Resource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_62" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkKidneys_893" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkKidneys_893" runat="server" Text="Kidneys" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkKidneys_893Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkKidneys_893" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_64" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_64Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_64" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_64_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_64Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR5" visible="true" runat="server" />
                            </td>
                            <td id="trDescription_65" runat="server" style="display: none;">
                                <asp:Label ID="lblDescription_65" runat="server" Text="Description" 
                                    meta:resourcekey="lblDescription_65Resource1"></asp:Label>
                                <asp:TextBox ID="txtDescription_246" runat="server" 
                                    meta:resourcekey="txtDescription_246Resource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_64" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkOtherFindings_914" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkOtherFindings_914" runat="server" Text="Other Findings" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkOtherFindings_914Resource1" />
                    </td>
                    <td class="defaultfontcolor" id="tr1chkOtherFindings_914" runat="server" style="display: none;">
                        <asp:Label ID="lblOtherFindings_98" runat="server" Text="OtherFindings" 
                            Visible="False" meta:resourcekey="lblOtherFindings_98Resource1"></asp:Label>
                        <asp:TextBox ID="txtOtherFindings_439" runat="server" 
                            meta:resourcekey="txtOtherFindings_439Resource1"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</div>
