<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuotationFormat.aspx.cs"
    Inherits="Waters_QuotationFormat" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="contentdata">
        <asp:Panel ID="Panel1" runat="server">
            <table style="display: table;" class="w-100p">
                <tr>
                    <td class="v-top">
                        <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                            Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                            <ServerReport ReportServerUrl="" />
                        </rsweb:ReportViewer>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
