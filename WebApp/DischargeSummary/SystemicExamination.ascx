<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SystemicExamination.ascx.cs"
    Inherits="DischargeSummary_SystemicExamination" %>
<%@ Register src="Musculoskeletal.ascx" tagname="Musculoskeletal" tagprefix="uc1" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblSE" runat="server" Font-Bold="True" 
                meta:resourcekey="lblSEResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Table ID="tblSystamaticExamination" runat="server" CellSpacing="0" 
                meta:resourcekey="tblSystamaticExaminationResource1">
            </asp:Table>
        </td>
    </tr>
    <tr>
    <td>
 
        <uc1:Musculoskeletal ID="Musculoskeletal1" runat="server" />
    </td>
    </tr>
</table>
