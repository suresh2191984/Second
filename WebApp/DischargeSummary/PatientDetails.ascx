<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientDetails.ascx.cs"
    Inherits="DischargeSummary_PatientDetails" %>
<table id="Table1" cellpadding="0" runat="server" cellspacing="0" border="0" width="100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td style="font-weight: bold; height: 20px;">
            <asp:Label ID="lblPatientDetail" runat="server" 
                meta:resourcekey="lblPatientDetailResource1"></asp:Label>
        </td>
    </tr>
    <%--<tr id="trCIP" runat="server" style="display:none;">
        <td>
            <asp:Label ID="lblCIPNoH" runat="server" Font-Bold="true"></asp:Label><asp:Label ID="lblCIPNoV"
                runat="server"></asp:Label>
        </td>
    </tr>--%>
</table>
