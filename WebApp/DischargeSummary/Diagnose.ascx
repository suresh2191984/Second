<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Diagnose.ascx.cs" Inherits="DischargeSummary_Diagnose" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc5" %>
<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr id="trDiagnosis" runat="server" style="display: none">
        <td>
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td>
                        <asp:Label ID="lblDiagnose" runat="server" Font-Bold="True" 
                            meta:resourcekey="lblDiagnoseResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Table ID="tbldiagnosis" runat="server" CellSpacing="0" 
                            meta:resourcekey="tbldiagnosisResource1">
                        </asp:Table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trICDDiagnosis" runat="server" style="display: none">
        <td>
            <uc5:DiagnoseWithICD ID="DiagnoseWithICD1" runat="server" />
        </td>
    </tr>
</table>
