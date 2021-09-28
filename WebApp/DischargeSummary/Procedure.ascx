<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Procedure.ascx.cs" Inherits="DischargeSummary_Procedure" %>
<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblProcedures" runat="server" Font-Bold="True" 
                meta:resourcekey="lblProceduresResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 5px">
            <asp:Literal ID="ltrProcedureDesc" runat="server" 
                meta:resourcekey="ltrProcedureDescResource1"></asp:Literal>
        </td>
    </tr>
</table>
