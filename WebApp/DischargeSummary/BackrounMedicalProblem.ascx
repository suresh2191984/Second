<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BackrounMedicalProblem.ascx.cs"
    Inherits="DischargeSummary_BackrounMedicalProblem" %>
<table cellpadding="0" cellspacing="0" border="0" width="80%">
 <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td >
            
              <asp:Label ID="lblBMP" runat="server" Font-Bold="True" 
                  meta:resourcekey="lblBMPResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Table ID="tblBackgroundProblems" runat="server" CellSpacing="0" 
                meta:resourcekey="tblBackgroundProblemsResource1">
            </asp:Table>
        </td>
    </tr>
    <tr id="trNegativeHistory" runat="server" style="display: none">
        <td>
            <asp:Label ID="lblBackgroundProblems" runat="server" 
                meta:resourcekey="lblBackgroundProblemsResource1"></asp:Label>
        </td>
    </tr>
   
</table>
