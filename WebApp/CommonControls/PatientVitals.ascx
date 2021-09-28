<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientVitals.ascx.cs"
    Inherits="CommonControls_PatientVitals" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript">
    function CalBMI() {
        var valHeight = document.getElementById('<%= txtHeight.ClientID %>').value;
        var valWeight = document.getElementById('<%= txtWeight.ClientID %>').value;

        document.getElementById('<%= txtBMI.ClientID %>').readOnly = true;
        document.getElementById('<%= txtBMI.ClientID %>').value = '';
        document.getElementById('<%= lblBMIVitalsName.ClientID %>').style.display = "none";
        document.getElementById('<%= txtBMI.ClientID %>').style.display = "none";

        if (valHeight != '' && valHeight != 0 && valWeight != '' & valWeight != 0) {
            var valDiv = (valHeight * valHeight) / 10000;
            var valBMI = valWeight / valDiv;
            valBMI = valBMI.toFixed(2);
            document.getElementById('<%= txtBMI.ClientID %>').value = valBMI;
            document.getElementById('<%= txtBMI.ClientID %>').style.display = "block";
            document.getElementById('<%= lblBMIVitalsName.ClientID %>').style.display = "block";
        }


    }
    function CalWHR() {
        var valWaist = document.getElementById('<%= txtWaistCircumference.ClientID %>').value;
        var valHip = document.getElementById('<%= txtHipCircumference.ClientID %>').value;
        if (valWaist != '' && valWaist != 0 && valHip != '' & valHip != 0) {
            var valWHR = valWaist / valHip;
            valWHR = valWHR.toFixed(2);
            document.getElementById('<%= txtWHR.ClientID %>').value = valWHR;
            document.getElementById('<%= txtWHR.ClientID %>').visible = true;
        }
        else {
            document.getElementById('<%= txtWHR.ClientID %>').value = '';
            document.getElementById('<%= txtWHR.ClientID %>').visible = false;
            document.getElementById('<%= lblWHRVitalsName.ClientID %>').visible = false;
        }

    }
</script>

<%--<div id="divVT1" onclick="showResponses('tcEMR_tpExamination_PatientVitalsControl_divVT1','tcEMR_tpExamination_PatientVitalsControl_divVT2','divVT3',1);"
    style="cursor: pointer; display: block;" runat="server">
    &nbsp;<img src="../Images/showBids.gif" alt="Show" />
    <asp:Label ID="Label31" Text="Vitals" Font-Bold="True" runat="server" />
</div>
<div id="divVT2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('tcEMR_tpExamination_PatientVitalsControl_divVT1','tcEMR_tpExamination_PatientVitalsControl_divVT2','divVT3',0);"
    runat="server">
    &nbsp;<img src="../Images/hideBids.gif" alt="hide" />
    <asp:Label ID="Label32" Text="Vitals" Font-Bold="True" runat="server" />
</div>
<div id="divVT3" style="display: none; width: 100%;border:1;border-color:Red;" title="Vitals">
    <asp:Panel runat="server" ID="pnlError" GroupingText="Errors" Visible="False" CssClass="defaultfontcolor"
        meta:resourcekey="pnlErrorResource1">
        <table class="defaultfontcolor" onload="fn();">
            <tr>
                <td>
                    <asp:Literal ID="lblError" runat="server"></asp:Literal>
                </td>
            </tr>
        </table>
    </asp:Panel>--%>
<asp:Panel ID="pnlGeneral" GroupingText="General" runat="server" meta:resourcekey="pnlGeneralResource1">
    <table cellpadding="0" cellspacing="5" border="0">
        <tr>
            <td style="visibility: hidden">
                <asp:Label ID="lblTempVitalsID" runat="server" meta:resourcekey="lblTempVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td>
                <asp:Label ID="lblTempVitalsName" runat="server" meta:resourcekey="lblTempVitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtTemp" Text="5" runat="server" MaxLength="5" size="5" meta:resourcekey="txtTempResource1"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblTempUOMCode" runat="server" meta:resourcekey="lblTempUOMCodeResource1"></asp:Label>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblPulseVitalsID" runat="server" meta:resourcekey="lblPulseVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td>
                <asp:Label ID="lblPulseVitalsName" runat="server" meta:resourcekey="lblPulseVitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtPulse" runat="server" MaxLength="3" size="5" meta:resourcekey="txtPulseResource1"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblPulseUOMCode" runat="server" meta:resourcekey="lblPulseUOMCodeResource1"></asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td style="visibility: hidden">
                <asp:Label ID="lblHeightVitalsID" runat="server" meta:resourcekey="lblHeightVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td>
                <asp:Label ID="lblHeightVitalsName" runat="server" meta:resourcekey="lblHeightVitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtHeight" runat="server" MaxLength="3" size="5" onblur="CalBMI()"
                    meta:resourcekey="txtHeightResource1"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblHeightUOMCode" runat="server" meta:resourcekey="lblHeightUOMCodeResource1"></asp:Label>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblWeightVitalsID" runat="server" meta:resourcekey="lblWeightVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td>
                <asp:Label ID="lblWeightVitalsName" runat="server" meta:resourcekey="lblWeightVitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtWeight" runat="server" MaxLength="5" size="5" onblur="CalBMI()"
                    meta:resourcekey="txtWeightResource1"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblWeightUOMCode" runat="server" meta:resourcekey="lblWeightUOMCodeResource1"></asp:Label>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblBMIVitalsID" runat="server" meta:resourcekey="lblWeightVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td>
                <asp:Label ID="lblBMIVitalsName" runat="server" meta:resourcekey="lblBMIResource1"
                    ForeColor="Maroon"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtBMI" runat="server" MaxLength="5" size="5" meta:resourcekey="txtBMIResource1"></asp:TextBox>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblBMIValueVitalsName" runat="server" Font-Bold="True" meta:resourcekey="lblBMIValueResource1"
                    ForeColor="Maroon"></asp:Label>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblBMIUOMCode" runat="server" meta:resourcekey="lblBMIUOMCodeResource1"></asp:Label>&nbsp;
            </td>
        </tr>
        <tr>
            <td style="visibility: hidden">
                <asp:Label ID="lblSpO2VitalsID" runat="server" meta:resourcekey="lblSpO2VitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td>
                <asp:Label ID="lblSpO2VitalsName" runat="server" meta:resourcekey="lblSpO2VitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtSpO2" runat="server" MaxLength="5" size="5" meta:resourcekey="txtSpO2Resource1"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblSpO2UOMCode" runat="server" meta:resourcekey="lblSpO2UOMCodeResource1"></asp:Label>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblRRVitalsID" runat="server" meta:resourcekey="lblRRVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td>
                <asp:Label ID="lblRRVitalsName" runat="server" meta:resourcekey="lblRRVitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtRR" runat="server" MaxLength="5" size="5" meta:resourcekey="txtRRResource1"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblRRUOMCode" runat="server" meta:resourcekey="lblRRUOMCodeResource1"></asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td style="visibility: hidden">
                <asp:Label ID="lblWaistCircumferenceVitalsID" runat="server" meta:resourcekey="lblWaistCircumferenceVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td>
                <asp:Label ID="lblWaistCircumferenceVitalsName" runat="server" meta:resourcekey="lblWaistCircumferenceVitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtWaistCircumference" runat="server" onblur="CalWHR()" MaxLength="5"
                    size="5" meta:resourcekey="txtWaistCircumferenceResource1"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblWaistCircumferenceUOMCode" runat="server" meta:resourcekey="lblWaistCircumferenceUOMCodeResource1"></asp:Label>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblHipCircumferenceVitalsID" runat="server" meta:resourcekey="lblHipCircumferenceVitalsIDResource1"></asp:Label>&nbsp;
            </td>
            <td>
                <asp:Label ID="lblHipCircumferenceVitalsName" runat="server" meta:resourcekey="lblHipCircumferenceVitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtHipCircumference" runat="server" onblur="CalWHR()" MaxLength="5"
                    size="5" meta:resourcekey="txtHipCircumferenceResource1"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblHipCircumferenceUOMCode" runat="server" meta:resourcekey="lblHipCircumferenceUOMCodeResource1"></asp:Label>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblWHRVitalsID" runat="server" meta:resourcekey="lblWeightVitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblWHRVitalsName" runat="server" meta:resourcekey="lblWeightVitalsNameResource1"
                    ForeColor="Maroon"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtWHR" ReadOnly="True" runat="server" MaxLength="5" size="5" 
                    meta:resourcekey="txtWHRResource1"></asp:TextBox>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblWHRValueVitalsName" runat="server" Font-Bold="True" meta:resourcekey="lblWeightVitalsNameResource1"
                    ForeColor="Maroon"></asp:Label>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblWHRUOMCode" runat="server" meta:resourcekey="lblWHRUOMCodeResource1"></asp:Label>&nbsp;
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="pnlBP" GroupingText="Blood Pressure" runat="server" meta:resourcekey="pnlBPResource1">
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td style="visibility: hidden">
                <asp:Label ID="lblSBPVitalsID" runat="server" meta:resourcekey="lblSBPVitalsIDResource1"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblSBPVitalsName" runat="server" meta:resourcekey="lblSBPVitalsNameResource1"></asp:Label>
                /<asp:Label ID="lblDBPVitalsName" runat="server" meta:resourcekey="lblDBPVitalsNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtSBP" runat="server" MaxLength="3" size="5" Width="30px" meta:resourcekey="txtSBPResource1"></asp:TextBox>
                /<asp:TextBox ID="txtDBP" runat="server" MaxLength="3" size="5" Width="30px" meta:resourcekey="txtDBPResource1"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblDBPUOMCode" runat="server" Visible="False" meta:resourcekey="lblDBPUOMCodeResource1"></asp:Label>
                <asp:Label ID="lblSBPUOMCode" runat="server" meta:resourcekey="lblSBPUOMCodeResource1"></asp:Label>
            </td>
            <td style="visibility: hidden">
                <asp:Label ID="lblDBPVitalsID" runat="server" meta:resourcekey="lblDBPVitalsIDResource1"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblValiddate" Text="Capture Date" runat="server" 
                    meta:resourcekey="lblValiddateResource1" />
            </td>
            <td>
                <asp:TextBox ID="txtValidate" CssClass="Txtboxsmall" runat="server" 
                    meta:resourcekey="txtValidateResource1"></asp:TextBox>
                
            <asp:ImageButton ID="ImageButton1" runat="server" 
                    ImageUrl="~/images/Calendar_scheduleHS.png"  
                    OnClientClick="javascript:return CaptureDate();" 
                    meta:resourcekey="ImageButton1Resource1"   />
            </td>
        </tr>
    </table>
</asp:Panel>
<%--</div>--%>

<script type="text/javascript" >
    function CaptureDate() {
        NewCal('<%= txtValidate.ClientID %>', 'ddmmyyyy', true, 12);
        return false;
    }
</script>