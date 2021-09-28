<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Diagnosticsl.ascx.cs"
    Inherits="EMR_Diagnosticsl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblDiagnostics_894" runat="server" Text="DIAGNOSTICS" 
                meta:resourcekey="lblDiagnostics_894Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkECG_2" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkECG_2" runat="server" Text="ECG" 
                            onclick="javascript:showDiagnosticsPKGContents(this.id);" 
                            meta:resourcekey="chkECG_2Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkECG_2" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="pnl" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_1" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_1Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_1" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_1_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_1Resource1" CssClass="ddlsmall">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR1" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_2" runat="server" style="display: none">
                                <asp:Label ID="lblAbnormalities_2" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_2Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_2" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_2_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_2Resource1" CssClass="ddlsmall">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_2" runat="server" style="display: none">
                                    <uc8:EMR ID="EMR2" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_2" runat="server" style="display: none" align="left">
                                    <asp:TextBox ID="txtOthers_33" runat="server" 
                                        meta:resourcekey="txtOthers_33Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkEchocardiogram_3" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkEchocardiogram_3" runat="server" Text="Echocardiogram" 
                            onclick="javascript:showDiagnosticsPKGContents(this.id);" 
                            meta:resourcekey="chkEchocardiogram_3Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkEchocardiogram_3" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" width="100%" class="dataheaderInvCtrl">
                <tr>
                    <td style="width: 80px">
                        <asp:Label ID="lblMyocardium_3" runat="server" Text="Myocardium" 
                            meta:resourcekey="lblMyocardium_3Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlMyocardium_3" runat="server" 
                            onchange="javascript:showDiagnosticsPKGOthers(this.id);" 
                            meta:resourcekey="ddlMyocardium_3Resource1" CssClass="ddlsmall">
                        </asp:DropDownList>
                        <td>
                            <uc8:EMR ID="EMR3" visible="true" runat="server" />
                        </td>
                        <td id="divddlMyocardium_3" runat="server" style="display: none">
                            <asp:TextBox ID="txtOthers_50" runat="server" 
                                meta:resourcekey="txtOthers_50Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkRwma_51" runat="server" Text="RWMA" 
                                meta:resourcekey="chkRwma_51Resource1" />
                        </td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblValveAbnormality_5" runat="server" Text="Valve Abnormality" 
                            meta:resourcekey="lblValveAbnormality_5Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlValveAbnormality_5" runat="server" 
                            onchange="javascript:showDiagnosticsPKGOthers(this.id);" 
                            meta:resourcekey="ddlValveAbnormality_5Resource1" CssClass="ddlsmall">
                        </asp:DropDownList>
                        <td>
                            <uc8:EMR ID="EMR4" visible="true" runat="server" />
                        </td>
                        <td id="divddlValveAbnormality_5" runat="server" style="display: none">
                            <asp:TextBox ID="txtOthers_84" runat="server" 
                                meta:resourcekey="txtOthers_84Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblEjectionFraction_6" runat="server" Text="Ejection Fraction" 
                                meta:resourcekey="lblEjectionFraction_6Resource1"></asp:Label>
                            <asp:TextBox ID="txtEjectionFraction_85" runat="server" Width="50px" 
                                meta:resourcekey="txtEjectionFraction_85Resource1" CssClass="Txtboxverysmall"></asp:TextBox>
                            <asp:Label ID="lblUom_85" runat="server" Text="%" 
                                meta:resourcekey="lblUom_85Resource1"></asp:Label>
                        </td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblOtherLesions_7" runat="server" Text="Other Lesions" 
                            meta:resourcekey="lblOtherLesions_7Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtOtherLesions_86" runat="server" 
                            meta:resourcekey="txtOtherLesions_86Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkTreadmillTest_4" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkTreadmillTest_4" runat="server" Text="Treadmill Test" 
                            onclick="javascript:showDiagnosticsPKGContents(this.id);" 
                            meta:resourcekey="chkTreadmillTest_4Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkTreadmillTest_4" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr class="defaultfontcolor">
                    <td style="width: 200px">
                        <asp:Label ID="lblTreadmillTestResult_8" runat="server" 
                            Text="Treadmill Test Result" 
                            meta:resourcekey="lblTreadmillTestResult_8Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlTreadmillTestResult_8" runat="server" 
                            meta:resourcekey="ddlTreadmillTestResult_8Resource1" CssClass="ddlsmall">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR5" visible="true" runat="server" />
                    </td>
                </tr>
                <tr class="defaultfontcolor" id="trlblSRECG_9" runat="server" style="display: block;">
                    <td>
                        <asp:Label ID="lblSRECG_9" runat="server" Text="Stress Related ECG Changes" 
                            meta:resourcekey="lblSRECG_9Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:CheckBoxList ID="chkSRECG_9" runat="server" RepeatColumns="2"
                            onclick="javascript:showDiagnosticsCHKPKGOthers(this.id);" 
                            meta:resourcekey="chkSRECG_9Resource1">
                        </asp:CheckBoxList>
                        <div id="divchkSRECG_9" runat="server" style="display: none">
                            <asp:TextBox ID="txtOthers_108" runat="server" 
                                meta:resourcekey="txtOthers_108Resource1"></asp:TextBox>
                        </div>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR6" visible="true" runat="server" />
                    </td>
                </tr>
                <tr class="defaultfontcolor">
                    <td>
                        <asp:Label ID="lblAssociatedSymptoms_10" runat="server" 
                            Text="Associated Symptoms" meta:resourcekey="lblAssociatedSymptoms_10Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:CheckBoxList ID="chkAssociatedSymptoms_10" runat="server"
                            RepeatColumns="4" 
                            onclick="javascript:showDiagnosticsCHKPKGOthers(this.id);" 
                            meta:resourcekey="chkAssociatedSymptoms_10Resource1">
                        </asp:CheckBoxList>
                        <div id="divchkAssociatedSymptoms_10" runat="server" style="display: none">
                            <asp:TextBox ID="txtOthers_112" runat="server" 
                                meta:resourcekey="txtOthers_112Resource1"></asp:TextBox>
                        </div>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR7" visible="true" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMPHR_11" runat="server" Text="MPHR" 
                            meta:resourcekey="lblMPHR_11Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMPHR_113" runat="server" Width="75px" 
                            meta:resourcekey="txtMPHR_113Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                        <asp:Label ID="lblUom_113" runat="server" Text="bpm" 
                            meta:resourcekey="lblUom_113Resource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMAHR_12" runat="server" Text="MAHR" 
                            meta:resourcekey="lblMAHR_12Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMAHR_114" runat="server" Width="75px" 
                            meta:resourcekey="txtMAHR_114Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                        <asp:Label ID="lblUom_114" runat="server" Text="bpm" 
                            meta:resourcekey="lblUom_114Resource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblWorkLoad_13" runat="server" Text="Work Load" 
                            meta:resourcekey="lblWorkLoad_13Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtWorkLoad_115" runat="server" Width="75px" 
                            meta:resourcekey="txtWorkLoad_115Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                        <asp:Label ID="lblUom_115" runat="server" Text="METS" 
                            meta:resourcekey="lblUom_115Resource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkMPS_5" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkMPS_5" runat="server" Text="Myocardial Perfusion Study" 
                            onclick="javascript:showDiagnosticsPKGContents(this.id);" 
                            meta:resourcekey="chkMPS_5Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkMPS_5" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr>
                    <td style="width: 50px">
                        <asp:Label ID="lblType_14" runat="server" Text="Type" 
                            meta:resourcekey="lblType_14Resource1"></asp:Label>
                    </td>
                    <td style="width: 258px">
                        <asp:DropDownList ID="ddlType_14" runat="server" 
                            onclick="javascript:showDiagnosticsPKGOthers(this.id);" 
                            meta:resourcekey="ddlType_14Resource1" CssClass="ddlsmall">
                        </asp:DropDownList>
                        <div id="divddlType_14" runat="server" style="display: none">
                            <asp:TextBox ID="txtOthers_124" runat="server" 
                                meta:resourcekey="txtOthers_124Resource1"></asp:TextBox>
                        </div>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR8" visible="true" runat="server" />
                    </td>
                    <td id="trDescription_15" runat="server" style="display: block;">
                        <asp:Label ID="lblDescription_15" runat="server" Text="Description" 
                            meta:resourcekey="lblDescription_15Resource1"></asp:Label>
                        <asp:TextBox ID="txtDescription_125" runat="server" 
                            meta:resourcekey="txtDescription_125Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkMVS_6" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkMVS_6" runat="server" Text="Myocardial Viability Study" 
                            onclick="javascript:showDiagnosticsPKGContents(this.id);" 
                            meta:resourcekey="chkMVS_6Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkMVS_6" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr>
                    <td style="width: 50px">
                        <asp:Label ID="lblType_16" runat="server" Text="Type" 
                            meta:resourcekey="lblType_16Resource1"></asp:Label>
                    </td>
                    <td style="width: 258px">
                        <asp:DropDownList ID="ddlType_16" runat="server" 
                            onclick="javascript:showDiagnosticsPKGOthers(this.id);" 
                            meta:resourcekey="ddlType_16Resource1" CssClass="ddlsmall">
                        </asp:DropDownList>
                        <div id="divddlType_16" runat="server" style="display: none">
                            <asp:TextBox ID="txtOthers_134" runat="server" 
                                meta:resourcekey="txtOthers_134Resource1"></asp:TextBox>
                        </div>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR9" visible="true" runat="server" />
                    </td>
                    <td id="trDescription_17" runat="server" style="display: block;">
                        <asp:Label ID="lblDescription_17" runat="server" Text="Description" 
                            meta:resourcekey="lblDescription_17Resource1"></asp:Label>
                        <asp:TextBox ID="txtDescription_135" runat="server" 
                            meta:resourcekey="txtDescription_135Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkCoronaryAngiogram_7" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkCoronaryAngiogram_7" runat="server" Text="Coronary Angiogram"
                            onclick="javascript:showDiagnosticsPKGContents(this.id);" 
                            meta:resourcekey="chkCoronaryAngiogram_7Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkCoronaryAngiogram_7" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="coronarypnl" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 220px">
                                <asp:Label ID="lblCAR_18" runat="server" Text="Coronary Angiogram Result" 
                                    meta:resourcekey="lblCAR_18Resource1"></asp:Label>
                            </td>
                            <td style="width: 258px">
                                <asp:DropDownList ID="ddlCAR_18" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlCAR_18_SelectedIndexChanged" 
                                    meta:resourcekey="ddlCAR_18Resource1" CssClass="ddlsmall">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR10" visible="true" runat="server" />
                            </td>
                            <td id="trCAR_18" runat="server" style="display: none;">
                                <asp:Label ID="lblCoronaryVessel_19" runat="server" Text="Coronary Vessel" 
                                    meta:resourcekey="lblCoronaryVessel_19Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlCoronaryVessel_19" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlCoronaryVessel_19_SelectedIndexChanged" 
                                    meta:resourcekey="ddlCoronaryVessel_19Resource1" CssClass="ddlsmall">
                                </asp:DropDownList>
                                <div id="divddlCoronaryVessel_19" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_162" runat="server" 
                                        meta:resourcekey="txtOthers_162Resource1"></asp:TextBox>
                                </div>
                            </td>
                            <td id="tdCAR_18" runat="server" style="display: none;">
                                <uc8:EMR ID="EMR11" visible="true" runat="server" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkOtherDiagnostics_8" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkOtherDiagnostics_8" runat="server" Text="Other Diagnostics"
                            onclick="javascript:showDiagnosticsPKGContents(this.id);" 
                            meta:resourcekey="chkOtherDiagnostics_8Resource1" />
                    </td>
                    <td class="defaultfontcolor" id="tr1chkOtherDiagnostics_8" runat="server" style="display: none;">
                        <asp:Label ID="lblOtherDiagnostics_20" runat="server" Text="OtherFindings" 
                            Visible="False" meta:resourcekey="lblOtherDiagnostics_20Resource1"></asp:Label>
                        <asp:TextBox ID="txtOtherDiagnostics_163" runat="server" 
                            meta:resourcekey="txtOtherDiagnostics_163Resource1" CssClass="Txtboxsmall"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
