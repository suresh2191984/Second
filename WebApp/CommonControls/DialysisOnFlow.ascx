<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DialysisOnFlow.ascx.cs"
    Inherits="CommonControls_DialysisOnFlow" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" /> --%>
<asp:UpdatePanel ID="ctlOnFlowDialysis" runat="server">
    <ContentTemplate>
        <table class="onflowdefaultfontcolor">
            <tr>
                <td>
                    <asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="defaultfontcolor">
                    <asp:GridView ID="grdOnFlowDialysis" runat="server" AllowPaging="True" 
                        CellPadding="4" ForeColor="#333333" OnRowCreated="grdOnFlowDialysis_RowCreated" 
                        meta:resourcekey="grdOnFlowDialysisResource1">
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
