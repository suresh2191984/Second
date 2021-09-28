<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OralCavity.ascx.cs" Inherits="HealthPackageControls_OralCavity" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">

    
</script>
<div id="divOC1" onclick="showResponses('tcEMR_tpExamination_OralCavity1_divOC1','tcEMR_tpExamination_OralCavity1_divOC2','divOC3',1);"  
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label31" Text="Oral Cavity" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divOC2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_OralCavity1_divOC1','tcEMR_tpExamination_OralCavity1_divOC2','divOC3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label32" Text="Oral Cavity" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divOC3" style="display: none;width:100%" title="Oral Cavity">
<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblOralCavity_894" runat="server" Text="ORAL CAVITY" 
                meta:resourcekey="lblOralCavity_894Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkGeneralAppearance_895" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkGeneralAppearance_895" runat="server" Text="General Appearance"
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkGeneralAppearance_895Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkGeneralAppearance_895" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr>
                    <td style="width: 60px">
                        <asp:Label ID="lblType_66" runat="server" Text="Type" 
                            meta:resourcekey="lblType_66Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlType_66" runat="server" 
                            onchange="javascript:showExamPKGOthers(this.id);" 
                            meta:resourcekey="ddlType_66Resource1">
                        </asp:DropDownList>
                        <td>
                            <uc8:EMR ID="EMR1" visible="true" runat="server" />
                        </td>
                        <td id="divddlType_66" runat="server" style="display: none" align="left">
                            <asp:TextBox ID="txtOthers_252" runat="server" 
                                meta:resourcekey="txtOthers_252Resource1"></asp:TextBox>
                        </td>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trchkTeeth_896" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkTeeth_896" runat="server" Text="Teeth" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkTeeth_896Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkTeeth_896" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_67" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_67Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_67" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_67_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_67Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR2" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_68" runat="server" style="display: none">
                                <asp:Label ID="lblAbnormalities_68" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_68Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_68" runat="server" OnSelectedIndexChanged="ddlAbnormalities_68_SelectedIndexChanged"
                                    AutoPostBack="True" meta:resourcekey="ddlAbnormalities_68Resource1">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_68" runat="server" style="display: none">
                                    <uc8:EMR ID="EMR4" Visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_68" runat="server" style="display: none" align="left">
                                    <asp:TextBox ID="txtOthers_263" runat="server" 
                                        meta:resourcekey="txtOthers_263Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_67" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkTongue_897" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkTongue_897" runat="server" Text="Tongue" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkTongue_897Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkTongue_897" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_69" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_69Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_69" runat="server" OnSelectedIndexChanged="ddlType_69_SelectedIndexChanged"
                                    AutoPostBack="True" meta:resourcekey="ddlType_69Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR3" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_70" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_70" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_70Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_70" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_70_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_70Resource1">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_70" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR5" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_70" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_275" runat="server" 
                                        meta:resourcekey="txtOthers_275Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_69" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkTonsils_898" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkTonsils_898" runat="server" Text="Tonsils" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkTonsils_898Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkTonsils_898" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_71" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_71Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_71" runat="server" OnSelectedIndexChanged="ddlType_71_SelectedIndexChanged"
                                    AutoPostBack="True" meta:resourcekey="ddlType_71Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR6" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_72" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_72" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_72Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_72" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_72_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_72Resource1">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_72" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR7" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_72" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_283" runat="server" 
                                        meta:resourcekey="txtOthers_283Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_71" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr id="trchkPharynx_899" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkPharynx_899" runat="server" Text="Pharynx" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkPharynx_899Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkPharynx_899" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_73" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_73Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_73" runat="server" OnSelectedIndexChanged="ddlType_73_SelectedIndexChanged"
                                    AutoPostBack="True" meta:resourcekey="ddlType_73Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR8" visible="true" runat="server" />
                            </td>
                            <td id="trAbnormalities_74" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_74" runat="server" Text="Abnormalities" 
                                    meta:resourcekey="lblAbnormalities_74Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_74" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_74_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_74Resource1">
                                </asp:DropDownList>
                                <td id="tdAbnormalities_74" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR9" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_74" runat="server" style="display: none">
                                    <asp:TextBox ID="txtOthers_290" runat="server" 
                                        meta:resourcekey="txtOthers_290Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_73" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
</div> 