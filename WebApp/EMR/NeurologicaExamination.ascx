<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NeurologicaExamination.ascx.cs"
    Inherits="HealthPackageControls_NeurologicaExamination" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">

//     function showContent(id) {
//         var chkvalue = id.split('_');

//         var trid = chkvalue[0] + "_tr1" + chkvalue[1] + "_" + chkvalue[2];
//         if (document.getElementById(id).checked == true) {
//             document.getElementById(trid).style.display = 'block';
//         }
//         else {
//             document.getElementById(trid).style.display = 'none';
//         }

//     }

   
    
</script>

<div id="divNE1" onclick="showResponses('tcEMR_tpExamination_NeurologicaExamination1_divNE1','tcEMR_tpExamination_NeurologicaExamination1_divNE2','divNE3',1);"  
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label31" Text="Neurological Examination" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divNE2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_NeurologicaExamination1_divNE1','tcEMR_tpExamination_NeurologicaExamination1_divNE2','divNE3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label32" Text="Neurological Examination" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divNE3" style="display: none;width:100%" title="Neurological Examination">
<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblNeurologicalExamination_900" runat="server" 
                Text="NEUROLOGICAL EXAMINATION" 
                meta:resourcekey="lblNeurologicalExamination_900Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkCranialNerves_901" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkCranialNerves_901" runat="server" Text="Cranial Nerves" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkCranialNerves_901Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkCranialNerves_901" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr class="defaultfontcolor">
                            <td style="width: 100px">
                                <asp:Label ID="lblType_75" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_75Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_75" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_75_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_75Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR1" visible="true" runat="server" />
                            </td>
                        </tr>
                        <tr class="defaultfontcolor" id="trAbnormalities_76" runat="server" style="display: none;">
                            <td style="width: 100px" runat="server">
                                <asp:Label ID="lblAbnormalities_76" runat="server" Text="Abnormalities"></asp:Label>
                            </td>
                            <td runat="server">
                                <asp:CheckBoxList ID="chkAbnormalities_76" runat="server"
                                    RepeatColumns="4">
                                </asp:CheckBoxList>
                            </td>
                            <td runat="server">
                                <uc8:EMR ID="EMR13" visible="true" runat="server" />
                            </td>
                            <td class="defaultfontcolor" id="tdAbnormalities_76" runat="server" style="display: none;">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_75" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkSensorySystem_902" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkSensorySystem_902" runat="server" Text="Sensory System" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkSensorySystem_902Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkSensorySystem_902" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_77" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_77Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_77" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_77_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_77Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR2" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_78" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_78" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_78Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_78" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_78_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_78Resource1">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_78" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR3" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_78" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_339" runat="server" 
                                        meta:resourcekey="txtOthers_339Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_77" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkReflexes_903" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkReflexes_903" runat="server" Text="Reflexes" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkReflexes_903Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkReflexes_903" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_79" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_79Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_79" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_79_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_79Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR4" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_80" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_80" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_80Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_80" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_80_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_80Resource1">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_80" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR11" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_80" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_347" runat="server" 
                                        meta:resourcekey="txtOthers_347Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_79" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkMotorSystem_904" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkMotorSystem_904" runat="server" Text="Motor System" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkMotorSystem_904Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkMotorSystem_904" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_81" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_81Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_81" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_81_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_81Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR5" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_82" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_82" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_82Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_82" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_82_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_82Resource1">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_82" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR6" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_82" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_358" runat="server" 
                                        meta:resourcekey="txtOthers_358Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_81" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkMusculoSkeletalsystem_905" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkMusculoSkeletalsystem_905" runat="server" Text="Musculo Skeletal system"
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkMusculoSkeletalsystem_905Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkMusculoSkeletalsystem_905" runat="server"
        style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_83" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_83Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_83" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_83_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_83Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR7" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_84" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_84" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_84Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_84" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_84_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_84Resource1">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_84" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR8" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_84" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_367" runat="server" 
                                        meta:resourcekey="txtOthers_367Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_83" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkGait_906" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkGait_906" runat="server" Text="Gait" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkGait_906Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkGait_906" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_85" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_85Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_85" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_85_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_85Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR9" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_86" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_86" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_86Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_86" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_86_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_86Resource1">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_86" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR10" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_86" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_384" runat="server" 
                                        meta:resourcekey="txtOthers_384Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_85" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
</div>
