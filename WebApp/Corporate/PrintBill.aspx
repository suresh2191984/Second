<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintBill.aspx.cs" Inherits="Corporate_PrintBill" %>

<%@ Register Src="../CommonControls/PrintPrescription.ascx" TagName="PrintPrescription"
    TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/INVBillPrint.ascx" TagName="BillPrint" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PharmacyHeader.ascx" TagName="Header" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc12" %>
<%--<%@ Register Src="../CommonControls/RefundBillPrint.ascx" TagName="Refundbill" TagPrefix="uc13" %>--%>
<%@ Register Src="~/CommonControls/NMCPharmaBillPrint.ascx" TagName="NMCPrint" TagPrefix="NMCBillPrint" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>

    <script language="javascript" type="text/javascript">
        window.name = "BillWindow";
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
  <table id="Table1" border="0" width="100%" cellpadding="0" cellspacing="0" style="display: block;font-family: Verdana; font-size: 11px;"  runat="server">
        <tr>
            <td runat="server" id="tdPrints" enableviewstate="false">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
 
<script language="javascript" type="text/javascript">
    document.getElementById('tdPrints').style.display = "block";
    window.print();
    window.focus();
</script>

