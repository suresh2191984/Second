<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientAddress.ascx.cs"
    Inherits="DischargeSummary_PatientAddress" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr id="trAddress" runat="server" style="display: none">
        <td>
            
             <asp:Label ID="lblAdd" runat="server" Font-Bold="True" 
                 meta:resourcekey="lblAddResource1"></asp:Label>
        </td>
    </tr>
    <tr valign="top" id="tdPermenantAddress" runat="server" style="display: none">
        <td valign="top" width="30%">
            <asp:Label ID="Rs_PERMANANTADDRESS" Text="PERMANANT ADDRESS:" runat="server" 
                meta:resourcekey="Rs_PERMANANTADDRESSResource1"></asp:Label>
            <br />
            <asp:Table ID="tblPermenantAddress" runat="server" CellSpacing="0" 
                meta:resourcekey="tblPermenantAddressResource1">
            </asp:Table>
        </td>
    </tr>
    <tr id="tdPresentAddress" runat="server" style="display: none">
        <td>
            <asp:Label ID="Rs_PRESENTADDRESS" Text="PRESENT ADDRESS:" runat="server" 
                meta:resourcekey="Rs_PRESENTADDRESSResource1"></asp:Label><br />
            <asp:Table ID="tblPresentAddress" runat="server" CellSpacing="0" 
                meta:resourcekey="tblPresentAddressResource1">
            </asp:Table>
        </td>
    </tr>
</table>
