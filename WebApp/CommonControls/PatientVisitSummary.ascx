<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientVisitSummary.ascx.cs"
    Inherits="CommonControls_PatientVisitSummary" %>
<style type="text/css">
    .style1
    {
        width: 179px;
    }
    .style2
    {
        width: 145px;
    }
    .style3
    {
        width: 17%;
    }
    .style4
    {
        width: 107px;
    }
</style>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="defaultfontcolor">
    <tr>
        <td align="left" class="style3" style="width:15%">
            <asp:Label ID="Rs_Pat_No" runat="server" Text="Patient Number :" meta:resourcekey="Rs_Pat_NoResource1"></asp:Label>
        </td>
        <td align="left" class="style1" style="width:18%">
            <asp:Label ID="lblPno" Style="font-weight: bold;" runat="server" meta:resourcekey="lblPnoResource1"></asp:Label>
        </td>
        <td align="left" class="style3" style="width:15%">
            &nbsp;
        </td>
        <td align="left" class="style2" style="width:20%">
            &nbsp;
        </td>
        <td align="left" class="style3" style="width:20%">
            &nbsp;</td>
        <td align="left" class="style4" style="width:10%">
            &nbsp;</td>
        <td align="left" class="style4" style="width:10%">
            &nbsp;</td>
    </tr>
    <tr>
        <td align="left" class="style3" style="width:15%">
            <asp:Label ID="lOpVisits" Text="No. of. OP Visits:" runat="server" meta:resourcekey="lOpVisitsResource1"></asp:Label>
        </td>
        <td align="left" class="style1" style="width:18%">
            <asp:Label ID="lblOPVisits" Style="font-weight: bold;" runat="server" meta:resourcekey="lblOPVisitsResource1"></asp:Label>
        </td>
        <td align="left" class="style3" style="width:15%">
            <asp:Label ID="lIpVisits" Text="No. of. IP Visits:" runat="server" meta:resourcekey="lIpVisitsResource1"></asp:Label>
        </td>
        <td align="left" class="style2" style="width:20%">
            <asp:Label ID="lblIPVisits" Style="font-weight: bold;" runat="server" meta:resourcekey="lblIPVisitsResource1"></asp:Label>
        </td>
        <td align="left" class="style3" style="width:20%;text-align:right;">
            &nbsp;</td>
    </tr>
    <tr>
        <td align="left" class="style3" style="width:15%">
            <asp:Label ID="lPreVisitDate" Text="Previous Visit Date:" runat="server" meta:resourcekey="lPreVisitDateResource1"></asp:Label>
        </td>
        <td align="left" class="style1" style="width:18%">
            <asp:Label ID="lblPreVisitDate" Style="font-weight: bold;" runat="server" meta:resourcekey="lblPreVisitDateResource1"></asp:Label>
        </td>
        <td align="left" class="style3" style="width:15%">
            <asp:Label ID="lPreVisitType" Text="Previous Visit Type:" runat="server" meta:resourcekey="lPreVisitTypeResource1"></asp:Label>
        </td>
        <td align="left" class="style2" style="width:20%">
            <asp:Label ID="lblPreVisitType" Style="font-weight: bold;text-align:left;" runat="server" meta:resourcekey="lblPreVisitTypeResource1"></asp:Label>
        </td>
        <td align="left" class="style3" style="width:20%">
            &nbsp;</td>
        <td align="left" class="style4" style="width:10%">
            &nbsp;</td>
        <td align="left" class="style4" style="width:10%">
            &nbsp;</td>
    </tr>
</table>
