<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RoomSummary.ascx.cs" Inherits="DischargeSummary_RoomSummary" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            
            <asp:Label ID="lblTP" runat="server" Font-Bold="True" 
                meta:resourcekey="lblTPResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Table ID="tblPlan" runat="server" CellSpacing="0" CellPadding="4" 
                Border="1" meta:resourcekey="tblPlanResource1">
            </asp:Table>
        </td>
    </tr>
   
</table>