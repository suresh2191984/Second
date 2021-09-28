<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmissionVitals.ascx.cs"
    Inherits="DischargeSummary_AdmissionVitals" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
<tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>            
            <asp:Label ID="lblAdmissionVitals" runat="server" Font-Bold="True" 
                meta:resourcekey="lblAdmissionVitalsResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Table ID="tblgeneralExamination" runat="server" CellSpacing="0" BorderWidth="0px"
                CellPadding="8" GridLines="Both" 
                meta:resourcekey="tblgeneralExaminationResource1">
            </asp:Table>
        </td>
    </tr>
    
</table>
