<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RoutineInv.ascx.cs" Inherits="DischargeSummary_RoutineInv" %>
<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True" 
                meta:resourcekey="lblHeaderResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 5px">
            <asp:Literal ID="ltrRoutineInv" runat="server" 
                meta:resourcekey="ltrRoutineInvResource1"></asp:Literal>
        </td>
    </tr>
</table>