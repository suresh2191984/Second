<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConsolidateReport.aspx.cs"
    Inherits="Printing_ConsolidateReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/OPCaseSheet.ascx" TagName="OPCaseSheet" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/BillPrint.ascx" TagName="BillPrint" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/RakshithBillPrint.ascx" TagName="RakshithBillPrint"
    TagPrefix="uc3" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table border="0" cellpadding="0" cellspacing="0" width="70%">
        <tr>
            <td>
                <uc1:OPCaseSheet ID="OPCaseSheet1" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
            <asp:Panel ID="pnlBillPrint" runat="server"></asp:Panel>
               <%-- <uc2:BillPrint ID="BillPrint1" runat="server" />
                <uc3:RakshithBillPrint ID="rakshithbillPrint" runat="server" />--%>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
