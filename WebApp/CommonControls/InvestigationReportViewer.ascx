<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvestigationReportViewer.ascx.cs"
    Inherits="CommonControls_InvestigationReportViewer" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<table>
    <tr>
        <td>
            <asp:HiddenField ID="hdnVisitID" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:DataList ID="grdResult" runat="server" CellPadding="4" ForeColor="#333333" OnItemDataBound="grdResult_ItemDataBound"
                ItemStyle-VerticalAlign="Top" RepeatDirection="Horizontal" OnItemCommand="grdResult_ItemCommand"
                meta:resourcekey="grdResultResource1">
                <ItemStyle VerticalAlign="Top"></ItemStyle>
                <ItemTemplate>
                    <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                        cellspacing="0" border="0">
                        <tr>
                            <td valign="top">
                                <table cellpadding="5" class="colorforcontentborder" style="border-collapse: collapse;"
                                    cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td class="Duecolor" style="height: 20px;">
                                            <asp:Label ID="Rs_Report" runat="server" Text=" Report"></asp:Label>
                                            <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'></asp:Label>
                                            <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'> 
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table cellpadding="5" class="colorforcontent" style="border-collapse: collapse;"
                                    cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td style="font-weight: normal;">
                                            <asp:DataList ID="dlChildInvName" RepeatColumns="1" runat="server" OnItemCommand="dlChildInvName_ItemCommand"
                                                Width="100%" meta:resourcekey="dlChildInvNameResource1">
                                                <ItemStyle VerticalAlign="Top" />
                                                <ItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblInvname" Text='<%# Eval("InvestigationName") %>'
                                                                    meta:resourcekey="lblInvnameResource1"></asp:Label>
                                                                <asp:Label runat="server" Visible="False" ID="lblInvID" Text='<%# Eval("InvestigationID") %>'
                                                                    meta:resourcekey="lblInvIDResource1"></asp:Label>
                                                                <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                    meta:resourcekey="lblReportIDResource2"></asp:Label>
                                                                <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                    meta:resourcekey="lblReportnameResource2"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="True" Font-Underline="True"
                                                                    runat="server" Visible="False" Text="Show" CommandName="ShowReport"> 
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="color: #000000; height: 20px;" align="center">
                                            <asp:LinkButton ID="lnkShowReport" ForeColor="Black" runat="server" Text="ShowReport"
                                                CommandName="ShowReport" Font-Underline="True" meta:resourcekey="lnkShowReportResource1"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
            <asp:Label ID="lblErrorMessage" runat="server" meta:resourcekey="lblErrorMessageResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <rsweb:ReportViewer ID="ReportViewer" runat="server" Visible="False" 
                ProcessingMode="Remote" Font-Names="Verdana" Font-Size="8pt" meta:resourcekey="ReportViewerResource1">
                <ServerReport ReportServerUrl="" />
            </rsweb:ReportViewer>
        </td>
    </tr>
</table>
