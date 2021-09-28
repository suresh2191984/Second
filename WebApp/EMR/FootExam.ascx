<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FootExam.ascx.cs" Inherits="HealthPackageControls_FootExam" %>
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

<%--Foot Examination--%>
<div id="divFE1" onclick="showResponses('tcEMR_tpExamination_ucFoot_divFE1','tcEMR_tpExamination_ucFoot_divFE2','divFE3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label31" Text="Foot Examination" Font-Bold="True" runat="server" />
</div>
<div id="divFE2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_ucFoot_divFE1','tcEMR_tpExamination_ucFoot_divFE2','divFE3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label32" Text="Foot Examination" Font-Bold="True" runat="server" />
</div>
<div id="divFE3" style="display: none; width: 100%;border:1;border-color:Red;" title="Foot Examination">
<table border="0" cellpadding="0" width="98%" class="dataheaderInvCtrl">
    <tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="Label2" runat="server" Text="FOOT EXAMINATION"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td>
            <asp:CheckBox ID="chkPeripheral_934" runat="server" Text="Peripheral Neuropathy"
                onclick="javascript:showExamPKGContents(this.id);" />
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkPeripheral_934" runat="server" style="display: none;">
        <td colspan="2">
            <table class="dataheaderInvCtrl" style="width: 100%;">
                <tr>
                    <td>
                        <table style="width: 75%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPeripheralRight_934" runat="server" CssClass="defaultfontcolor" Text="Right Foot"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblPeripheralLeft_934" runat="server" CssClass="defaultfontcolor" Text="Left Foot"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtPeripheralRight_934" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPeripheralLeft_934" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR18" Visible="false" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td>
            <asp:CheckBox ID="chkPedalOedema_935" runat="server" Text="Pedal Oedema" onclick="javascript:showExamPKGContents(this.id);" />
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkPedalOedema_935" runat="server" style="display: none;">
        <td colspan="2">
            <table class="dataheaderInvCtrl" style="width: 100%;">
                <tr>
                    <td>
                        <table style="width: 75%;">
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblPedalRight_100" runat="server" CssClass="defaultfontcolor" Text="Right Foot"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblPedalLeft_101" runat="server" CssClass="defaultfontcolor" Text="Left Foot"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ddlPedalRight_100" runat="server"></asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR1" Visible="true" runat="server" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPedalLeft_101" runat="server"></asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR38" Visible="true" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td>
            <asp:CheckBox ID="chkFoot_936" runat="server" Text="Foot or Toe Deformity" onclick="javascript:showExamPKGContents(this.id);" />
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkFoot_936" runat="server" style="display: none;">
        <td colspan="2">
            <table class="dataheaderInvCtrl" style="width: 100%;">
                <tr>
                    <td>
                        <table style="width: 75%;">
                            <tr>
                                <td>
                                    <asp:Label ID="Label5" runat="server" CssClass="defaultfontcolor" Text="Right Foot"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label10" runat="server" CssClass="defaultfontcolor" Text="Left Foot"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ddlFootRight_102" runat="server"></asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR2" Visible="true" runat="server" />
                                </td>
                               <td>
                                    <asp:DropDownList ID="ddlFootLeft_103" runat="server"></asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR39" Visible="true" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td>
            <asp:CheckBox ID="chkFootUl_937" runat="server" Text="Foot Ulcer" onclick="javascript:showExamPKGContents(this.id);" />
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkFootUl_937" runat="server" style="display: none;">
        <td colspan="2">
            <table class="dataheaderInvCtrl" style="width: 100%;">
                <tr>
                    <td>
                        <table style="width: 75%;">
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" CssClass="defaultfontcolor" Text="Right Foot"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label13" runat="server" CssClass="defaultfontcolor" Text="Left Foot"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtFootUlRight_937" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFootUlLeft_937" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR40" Visible="false" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td>
            <asp:CheckBox ID="chkInfection_938" runat="server" Text="Infection" onclick="javascript:showExamPKGContents(this.id);" />
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkInfection_938" runat="server" style="display: none;">
        <td colspan="2">
            <table class="dataheaderInvCtrl" style="width: 100%;">
                <tr>
                    <td>
                        <table style="width: 75%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblInfectionRight_938" runat="server" CssClass="defaultfontcolor" Text="Right Foot"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblInfectionLeft_938" runat="server" CssClass="defaultfontcolor" Text="Left Foot"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtInfectionRight_938" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtInfectionLeft_938" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR41" Visible="false" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td>
            <asp:CheckBox ID="chkPeripheralPulse_939" runat="server" Text="Peripheral Pulses"
                onclick="javascript:showExamPKGContents(this.id);" />
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkPeripheralPulse_939" runat="server" style="display: none;">
        <td colspan="2">
            <table class="dataheaderInvCtrl" style="width: 100%;">
                <tr>
                    <td>
                        <table style="width: 75%;">
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Label16" runat="server" CssClass="defaultfontcolor" Text="Right Foot"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label17" runat="server" CssClass="defaultfontcolor" Text="Left Foot"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ddlPeripheralRight_104" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR3" Visible="true" runat="server" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPeripheralLeft_105" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR42" Visible="true" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="defaultfontcolor">
        <td>
            <asp:CheckBox ID="chkFootRisk_940" runat="server" Text="Foot Risk Assessment" onclick="javascript:showExamPKGContents(this.id);" />
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr class="defaultfontcolor" id="tr1chkFootRisk_940" runat="server" style="display: none;">
        <td colspan="2">
            <table class="dataheaderInvCtrl" style="width: 100%;">
                <tr>
                    <td>
                        <table style="width: 75%;">
                            <tr>
                                <td>
                                    <%--<asp:Label ID="Label18" runat="server" CssClass="defaultfontcolor" Text="Right Foot"></asp:Label>--%>
                                </td>
                                <td>
                                    <%--<asp:Label ID="Label19" runat="server" CssClass="defaultfontcolor" Text="Left Foot"></asp:Label>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ddlFootRiskRight_106" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <%--<asp:TextBox ID="txtFootRiskLeft_106" runat="server"></asp:TextBox>--%>
                                </td>
                                <td>
                                    <uc8:EMR ID="EMR43" Visible="true" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</div> 