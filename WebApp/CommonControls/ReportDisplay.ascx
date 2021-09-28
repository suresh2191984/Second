<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReportDisplay.ascx.cs"
    Inherits="CommonControls_ReportDisplay" %>
<style type="text/css">
    </style>
<table style="border: solid 1px; width: 100%;" class="rooms">
    <tr>
        <td align="center" class="tdReportHeader">
            <asp:Label ID="lblGroup" runat="server" Text='<%# Eval("ReportGroupText") %>' meta:resourcekey="lblGroupResource1"></asp:Label>
        </td>
        </tr>
        <tr>
            <td style="overflow: auto">
                <asp:DataList ID="dlReports" runat="server" RepeatColumns="7" RepeatDirection="Horizontal"
                    OnLoad="Page_Load" meta:resourcekey="dlReportsResource1">
                    <HeaderTemplate>
                        <table style="font-family: Arial; font-size: 11px; padding-left: 15px; text-align: center;">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div id='dvFloor' runat="server">
                            <td id="tdCover" class="ReportButton">
                                <asp:HyperLink ID="lblReportLink" runat="server" Style="color: #fff;" NavigateUrl='<%# Eval("RedirectURL") %>'>
                                    <%--meta:resourcekey="lblReportLinkResource1"--%><asp:Label ID="lblReportName" runat="server" Font-Size=9
                                        Text='<%# Eval("ReportDisplayText") %>'> 
                                <%--meta:resourcekey="lblReportNameResource1"--%>></asp:Label>
                                </asp:HyperLink>
                                <asp:Label ID="lblReportPath" runat="server" Visible="False" CssClass="borderstyle22"
                                    Text='<%# Eval("ReportPath") %>'> <%--meta:resourcekey="lblReportPathResource1"--%></asp:Label><br />
                        </div>
                        </td> </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tr> </table>
                    </FooterTemplate>
                </asp:DataList>
            </td>
        </tr>
</table>
