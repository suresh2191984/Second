<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CardiovascularExam.ascx.cs"
    Inherits="HealthPackageControls_CardiovascularExam" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<style type="text/css">
    .style1
    {
        width: 50px;
        height: 121px;
    }
    .style2
    {
        height: 121px;
    }
</style>


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

<div id="divCV1" onclick="showResponses('tcEMR_tpExamination_CardiovascularExam1_divCV1','tcEMR_tpExamination_CardiovascularExam1_divCV2','divCV3',1);"  
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label31" Text="Cardiovascular Examination" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divCV2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_CardiovascularExam1_divCV1','tcEMR_tpExamination_CardiovascularExam1_divCV2','divCV3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label32" Text="Cardiovascular Examination" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divCV3" style="display: none;width:100%" title="Cardiovascular Examination">
<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblCardiovascularExamination_880" runat="server" 
                Text="CARDIOVASCULAR EXAMINATION" 
                meta:resourcekey="lblCardiovascularExamination_880Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkPulseRhythm_881" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkPulseRhythm_881" runat="server" Text="Pulse Rhythm" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkPulseRhythm_881Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkPulseRhythm_881" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr class="defaultfontcolor">
                    <td style="width: 22%">
                        <asp:Label ID="lblFindings_47" runat="server" Text="Findings" 
                            meta:resourcekey="lblFindings_47Resource1"></asp:Label>
                    </td>
                    <td style="width: 22%">
                        <asp:DropDownList ID="ddlFindings_47" onmouseover="maxWidth(this.id);" runat="server" 
                            meta:resourcekey="ddlFindings_47Resource1" Width="157px">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR1" visible="true" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkPulseVolume_882" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkPulseVolume_882" runat="server" Text="Pulse Volume" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkPulseVolume_882Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkPulseVolume_882" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr class="defaultfontcolor">
                    <td style="width: 22%">
                        <asp:Label ID="lblFindings_48" runat="server" Text="Findings" 
                            meta:resourcekey="lblFindings_48Resource1"></asp:Label>
                    </td>
                    <td style="width: 22%">
                        <asp:DropDownList ID="ddlFindings_48" runat="server" 
                            meta:resourcekey="ddlFindings_48Resource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR2" visible="true" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkPulseCharacter_883" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkPulseCharacter_883" runat="server" Text="Pulse Character" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkPulseCharacter_883Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkPulseCharacter_883" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr>
                    <td style="width: 22%">
                        <asp:Label ID="lblFindings_49" runat="server" Text="Findings" 
                            meta:resourcekey="lblFindings_49Resource1"></asp:Label>
                    </td>
                    <td style="width: 22%">
                        <asp:DropDownList ID="ddlFindings_49" onmouseover="maxWidth(this.id);"  runat="server" 
                            meta:resourcekey="ddlFindings_49Resource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR3" visible="true" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkPeripheralPulses_884" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkPeripheralPulses_884" runat="server" Text="Peripheral Pulses"
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkPeripheralPulses_884Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkPeripheralPulses_884" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 22%">
                                <asp:Label ID="lblFindingsSigns_50" runat="server" Text="Findings/Signs" 
                                    meta:resourcekey="lblFindingsSigns_50Resource1"></asp:Label>
                            </td>
                            <td style="width: 22%">
                                <asp:DropDownList ID="ddlFindingsSigns_50" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlFindingsSigns_50_SelectedIndexChanged" 
                                    meta:resourcekey="ddlFindingsSigns_50Resource1">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 12%">
                                <uc8:EMR ID="EMR11" visible="true" runat="server" />
                            </td>
                            <td id="trLocation_51" runat="server" style="display: none;width: 42%">
                                <asp:Label ID="lblLocation_51" runat="server" Text="Location" 
                                    meta:resourcekey="lblLocation_51Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlLocation_51" runat="server" 
                                    meta:resourcekey="ddlLocation_51Resource1">
                                </asp:DropDownList>
                            </td>
                            <td id="tdLocation_51" runat="server" style="display: none;">
                                <uc8:EMR ID="EMR4" visible="true" runat="server" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlFindingsSigns_50" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkApexBeat_885" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkApexBeat_885" runat="server" Text="Apex Beat" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkApexBeat_885Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkApexBeat_885" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 22%">
                                <asp:Label ID="lblFindings_52" runat="server" Text="Findings" 
                                    meta:resourcekey="lblFindings_52Resource1"></asp:Label>
                            </td>
                            <td style="width: 22%">
                                <asp:DropDownList ID="ddlFindings_52" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlFindings_52_SelectedIndexChanged" 
                                    meta:resourcekey="ddlFindings_52Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR5" visible="true" runat="server" />
                            </td>
                            <td id="trTypesofabnormalitiess_53" runat="server" style="display: block;width: 22%">
                                <asp:Label ID="lblTypesofabnormalitiess_53" runat="server" 
                                    Text="Types of abnormalities" 
                                    meta:resourcekey="lblTypesofabnormalitiess_53Resource1"></asp:Label>
                            </td>
                            <td style="width: 22%">
                                <asp:DropDownList ID="ddlTypesofabnormalitiess_53" runat="server" 
                                    meta:resourcekey="ddlTypesofabnormalitiess_53Resource1">
                                </asp:DropDownList>
                            </td>
                            <td id="tdTypesofabnormalitiess_53" runat="server" style="display: block;">
                                <uc8:EMR ID="EMR6" visible="true" runat="server" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlFindings_52" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    
    
    <tr id="trchkHeartSounds_886" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkHeartSounds_886" runat="server" Text="Heart Sounds"
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkHeartSounds_886Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkHeartSounds_886" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 22%">
                                <asp:Label ID="lblFindings_54" runat="server" Text="Findings" 
                                    meta:resourcekey="lblFindings_54Resource1"></asp:Label>
                            </td>
                            <td style="width: 22%">
                                <asp:DropDownList ID="ddlFindings_54" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlFindings_54_SelectedIndexChanged" 
                                    meta:resourcekey="ddlFindings_54Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR7" visible="true" runat="server" />
                            </td>
                            <td id="trTypesofabnormalitiess_55" runat="server" style="display: block;width: 22%">
                                <asp:Label ID="lblTypesofabnormalitiess_55" runat="server" Text="Types of abnormalities" 
                                    meta:resourcekey="lblTypesofabnormalitiess_55Resource1"></asp:Label>
                            </td>
                            <td style="width: 22%">
                                <asp:DropDownList ID="ddlTypesofabnormalitiess_55" runat="server" 
                                    meta:resourcekey="ddlTypesofabnormalitiess_55Resource1">
                                </asp:DropDownList>
                            </td>
                            <td id="tdTypesofabnormalitiess_55" runat="server" style="display: none;">
                                <uc8:EMR ID="EMR8" visible="true" runat="server" />
                            </td>
                            <td id="divddlTypesofabnormalitiess_55" runat="server" style="display: none" class="style2">
                                    <asp:TextBox ID="txtOthers_433" runat="server" 
                                        meta:resourcekey="txtOthers_433Resource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate> 
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlFindings_54" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    
    
    <%--<tr id="trchkHeartSounds_886" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkHeartSounds_886" runat="server" Text="Heart Sounds" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkHeartSounds_886Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>--%>
    
    
    
    
    <%--<tr  id="tr1chkHeartSounds_886" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%">
                        <tr>
                            <td class="style1">
                                <asp:Label ID="lblFindings_54" runat="server" Text="Findings" 
                                    meta:resourcekey="lblFindings_54Resource1"></asp:Label>
                            </td>
                            <td class="style2">
                                <asp:DropDownList ID="ddlFindings_54" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlFindings_54_SelectedIndexChanged" 
                                    meta:resourcekey="ddlFindings_54Resource1">
                                </asp:DropDownList>
                            </td>
                            <td class="style2">
                                <uc8:EMR ID="EMR7" visible="false" runat="server" />
                            </td>
                            <td id="trTypesofabnormalitiess_55" runat="server" style="display: none;" class="style2">
                                <asp:Label ID="lblTypesofabnormalitiess_55" runat="server" 
                                    Text="Types of abnormalities" 
                                    meta:resourcekey="lblTypesofabnormalitiess_55Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlTypesofabnormalitiess_55" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlTypesofabnormalitiess_55_SelectedIndexChanged" 
                                    meta:resourcekey="ddlTypesofabnormalitiess_55Resource1">
                                </asp:DropDownList>
                                <td id="tdTypesofabnormalitiess_55" runat="server" style="display: none;" class="style2">
                                    <uc8:EMR ID="EMR8" runat="server" />
                                </td>
                                <td id="divddlTypesofabnormalitiess_55" runat="server" style="display: none" class="style2">
                                    <asp:TextBox ID="txtOthers_433" runat="server" 
                                        meta:resourcekey="txtOthers_433Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlFindings_54" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>--%>
    <tr id="trchkHeartMummurs_887" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkHeartMummurs_887" runat="server" Text="Heart Mummurs" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkHeartMummurs_887Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkHeartMummurs_887" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 22%">
                                <asp:Label ID="lblFindings_56" runat="server" Text="Findings" 
                                    meta:resourcekey="lblFindings_56Resource1"></asp:Label>
                            </td>
                            <td style="width: 22%">
                                <asp:DropDownList ID="ddlFindings_56" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlFindings_56_SelectedIndexChanged" 
                                    meta:resourcekey="ddlFindings_56Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR9" visible="true" runat="server" />
                            </td>
                            <td id="trTypesofabnormalitiess_57" runat="server" style="display: none;width: 22%">
                                <asp:Label ID="lblTypesofabnormalitiess_57" runat="server" 
                                    Text="Types of abnormalities" 
                                    meta:resourcekey="lblTypesofabnormalitiess_57Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlTypesofabnormalitiess_57" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlTypesofabnormalitiess_57_SelectedIndexChanged" 
                                    meta:resourcekey="ddlTypesofabnormalitiess_57Resource1">
                                </asp:DropDownList>
                                </td>
                                <td id="tdTypesofabnormalitiess_57" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR10" Visible="true" runat="server" />
                                </td>
                                <td id="divddlTypesofabnormalitiess_57" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_216" runat="server" 
                                        meta:resourcekey="txtOthers_216Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlFindings_56" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
</div> 