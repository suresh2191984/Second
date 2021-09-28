<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GeneralExamination.ascx.cs"
    Inherits="DischargeSummary_GeneralExamination" %>
<table cellpadding="0" cellspacing="0" border="0" width="80%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td >
            
             <asp:Label ID="lblGE" runat="server" Font-Bold="True" 
                 meta:resourcekey="lblGEResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Table ID="tblGeneralExam" runat="server" CellSpacing="0" 
                meta:resourcekey="tblGeneralExamResource1">
            </asp:Table>
        </td>
    </tr>
    <tr id="trNegativeExam" runat="server" style="display: none">
        <td>
            <asp:Label ID="lblGeneralExam" runat="server" 
                meta:resourcekey="lblGeneralExamResource1"></asp:Label>
        </td>
    </tr>
    
</table>
