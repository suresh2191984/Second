<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EMROPCaseSheet.ascx.cs" Inherits="CommonControls_EMROPCaseSheet" %>
<%@ Register Src="../Investigation/BioChemistryDisplay.ascx" TagName="BioChemistry"
    TagPrefix="uc6" %>
<%@ Register Src="../Investigation/ClinicalDisplay.ascx" TagName="ClinicalDisplay"
    TagPrefix="uc7" %>
<%@ Register Src="../Investigation/HemotologyDisplay.ascx" TagName="HemotologyDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../Investigation/MicroBioDiplay.ascx" TagName="MicroBioDiplay" TagPrefix="uc9" %>

<%@ Register Src="Advice.ascx" TagName="Advice" TagPrefix="uc12" %>
<%@ Register src="ErrorDisplay.ascx" tagname="ErrorDisplay" tagprefix="uc1" %>
<%@ Register src="PatientPrescription.ascx" tagname="Patientprescription1" tagprefix="uc3" %>
<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />

<table cellspacing="1" style="height: auto;" width="100%" border="0" id="tblCaseSheet" runat="server" >
    <tr align="center" valign="top">
        <td>
            <asp:Label ID="lblPrescription" CssClass="defaultfontcolorCaseSheet" 
                runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
    <td>
    <uc3:Patientprescription1 ID ="patientprescription" runat ="server" />
    
    </td>
    
    </tr>
   
    
</table>

