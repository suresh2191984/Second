<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RespiratorySystem.ascx.cs"
    Inherits="HealthPackageControls_RespiratorySystem" %>
<%@ Register Src="~/EMR/EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
<div id="divRS1" onclick="showResponses('tcEMR_tpExamination_ucRS_divRS1','tcEMR_tpExamination_ucRS_divRS2','divRS3',1);"  
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label31" Text="Respiratory System" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divRS2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucRS_divRS1','tcEMR_tpExamination_ucRS_divRS2','divRS3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label32" Text="Respiratory System" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divRS3" style="display: none;width:100%" title="Respiratory System">
<table border="0" cellpadding="0" width="100%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblRespiratorySystem_877" runat="server" 
                Text="Respiratory System" meta:resourcekey="lblRespiratorySystem_877Resource1"></asp:Label>
        </td>
    </tr>
    <tr id="trchkTrachea_878" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkTrachea_878" runat="server" Text="Trachea" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkTrachea_878Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkTrachea_878" runat="server" style="display: none;">
        <td>
            <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                <tr>
                    <td style="width: 100px">
                        <asp:Label ID="lblType_43" runat="server" Text="Type" 
                            meta:resourcekey="lblType_43Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlType_43" runat="server" onactivate="maxWidth(this.id);" ondeactivate="restoreWidth(this.id);" 
                            meta:resourcekey="ddlType_43Resource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <uc8:EMR ID="EMR1" visible="true" runat="server" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkPostTracheostomy_156" runat="server" 
                            Text="Post Tracheostomy" meta:resourcekey="chkPostTracheostomy_156Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
        </td>
    </tr>
    <tr id="trchkBreathSounds_879" runat="server" style="display: block;">
        <td>
            <table cellpadding="0">
                <tr class="defaultfontcolor">
                    <td>
                        <asp:CheckBox ID="chkBreathSounds_879" runat="server" Text="Breath Sounds" 
                            onclick="javascript:showExamPKGContents(this.id);" 
                            meta:resourcekey="chkBreathSounds_879Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkBreathSounds_879" runat="server" style="display: none;">
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table border="1" cellpadding="0" align="center" width="100%" class="dataheaderInvCtrl">
                        <tr>
                            <td style="width: 50px">
                                <asp:Label ID="lblType_45" runat="server" Text="Type" 
                                    meta:resourcekey="lblType_45Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType_45" runat="server" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlType_45_SelectedIndexChanged" 
                                    meta:resourcekey="ddlType_45Resource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <uc8:EMR ID="EMR2" visible="true" runat="server" />
                            </td>
                            <td id="trType_45" runat="server" style="display: none;">
                                <asp:Label ID="lblAbnormalities_46" runat="server" Text="Location" 
                                    meta:resourcekey="lblAbnormalities_46Resource1"></asp:Label>
                                <asp:DropDownList ID="ddlAbnormalities_46" runat="server" onactivate="maxWidth(this.id);" ondeactivate="restoreWidth(this.id);" AutoPostBack="True" 
                                    OnSelectedIndexChanged="ddlAbnormalities_46_SelectedIndexChanged" 
                                    meta:resourcekey="ddlAbnormalities_46Resource1">
                                </asp:DropDownList>
                                <td id="tdType_45" runat="server" style="display: none;">
                                    <uc8:EMR ID="EMR3" visible="true" runat="server" />
                                </td>
                                <td id="divddlAbnormalities_46" runat="server" style="display: none">
                                    <asp:TextBox ID="txtAbnormalitiesOthers_165" runat="server" 
                                        meta:resourcekey="txtAbnormalitiesOthers_165Resource1"></asp:TextBox>
                                </td>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlType_45" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
</div> 
