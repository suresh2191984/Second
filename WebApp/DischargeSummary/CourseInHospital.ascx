<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CourseInHospital.ascx.cs"
    Inherits="DischargeSummary_CourseInHospital" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblHC" runat="server" Font-Bold="True" 
                meta:resourcekey="lblHCResource1"></asp:Label>
        </td>
    </tr>
    <tr id="trCourseHospital" runat="server" style="display: none">
        <td style="color: Black;">
            <asp:Label ID="ltrHospitalcourse" runat="server" ForeColor="Black" 
                meta:resourcekey="ltrHospitalcourseResource1"></asp:Label>
        </td>
    </tr>   
    <tr id="trCRCPresc" runat="server" style="display: none">
        <td>
            <asp:Table ID="tblCRCPresc" runat="server" CellSpacing="0" CellPadding="7" 
                meta:resourcekey="tblCRCPrescResource1">
            </asp:Table>
        </td>
    </tr>
</table>
