<%@ Control Language="C#" AutoEventWireup="true" CodeFile="History.ascx.cs" Inherits="DischargeSummary_History" %>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblH" runat="server" Font-Bold="True" 
                meta:resourcekey="lblHResource1"></asp:Label>
        </td>
    </tr>
    <tr runat="server" id="trH" style="display:none;">
        <td>
            <asp:Table ID="tblHistory" runat="server" CellSpacing="0" 
                meta:resourcekey="tblHistoryResource1">
            </asp:Table>
          
        </td>
    </tr>   
    <tr runat="server" id="trDH" style="display:none;">
        <td>
            <asp:Literal ID="ltrDetailHistory" runat="server" 
                meta:resourcekey="ltrDetailHistoryResource1"></asp:Literal>
        </td>
    </tr>
</table>
