<%@ Control Language="C#" AutoEventWireup="true" CodeFile="KMHPatientDetails.ascx.cs"
    Inherits="DischargeSummary_KMHPatientDetails" %>
<table cellpadding="1" cellspacing="0" border="0" width="100%">
    <tr>
        <td colspan="4">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblNameT" runat="server" Text="NAME" Font-Bold="True" 
                meta:resourcekey="lblNameTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblNameV" runat="server" meta:resourcekey="lblNameVResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblAgeSexT" runat="server" Text="AGE/SEX" Font-Bold="True" 
                meta:resourcekey="lblAgeSexTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblAgeSexV" runat="server" 
                meta:resourcekey="lblAgeSexVResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblDOAT" runat="server" Text="DATE OF ADMISSION" 
                Font-Bold="True" meta:resourcekey="lblDOATResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblDOAV" runat="server" meta:resourcekey="lblDOAVResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblDODT" runat="server" Text="DATE OF DISCHARGE" 
                Font-Bold="True" meta:resourcekey="lblDODTResource1"></asp:Label>
        </td>
        <td colspan="3" nowrap="nowrap">
            <asp:Label ID="lblDODV" runat="server" meta:resourcekey="lblDODVResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblPIDT" runat="server" Text="PATIENT NO" Font-Bold="True" 
                meta:resourcekey="lblPIDTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblPIDV" runat="server" meta:resourcekey="lblPIDVResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblIPNOT" runat="server" Text="IP NO" Font-Bold="True" 
                meta:resourcekey="lblIPNOTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblIPNOV" runat="server" meta:resourcekey="lblIPNOVResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblUnitT" runat="server" Text="UNIT/WARD" Font-Bold="True" 
                meta:resourcekey="lblUnitTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblUnitV" runat="server" meta:resourcekey="lblUnitVResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblConsultantT" runat="server" Text="CONSULTANT PHYSICIAN" 
                Font-Bold="True" meta:resourcekey="lblConsultantTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblConsultantV" runat="server" 
                meta:resourcekey="lblConsultantVResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblBGT" runat="server" Text="BLOOD GROUP" Font-Bold="True" 
                meta:resourcekey="lblBGTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblBGV" runat="server" meta:resourcekey="lblBGVResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblSurgeonT" runat="server" Text="CONSULTANT SURGEON" 
                Font-Bold="True" meta:resourcekey="lblSurgeonTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblSurgeonV" runat="server" 
                meta:resourcekey="lblSurgeonVResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td nowrap="nowrap">
            <asp:Label ID="lblTODT" runat="server" Text="TYPE OF DISCHARGE" 
                Font-Bold="True" meta:resourcekey="lblTODTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblTODV" runat="server" meta:resourcekey="lblTODVResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblSPT" runat="server" Text="SPECIALTY" Font-Bold="True" 
                meta:resourcekey="lblSPTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblSPV" runat="server" meta:resourcekey="lblSPVResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td nowrap="nowrap" style="vertical-align: text-top;">
            <asp:Label ID="lblAddressT" runat="server" Text="ADDRESS" Font-Bold="True" 
                meta:resourcekey="lblAddressTResource1"></asp:Label>
        </td>
        <td nowrap="nowrap" colspan="3">
            <asp:Table ID="tblPermenantAddress" runat="server" CellSpacing="0" 
                meta:resourcekey="tblPermenantAddressResource1">
            </asp:Table>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <hr style="color: Black; height: 0.5px;" />
        </td>
    </tr>
</table>
