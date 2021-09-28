<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintBarcode.aspx.cs" Inherits="Admin_PrintBarcode" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>BarcodePrint</title>
    <style type="text/css" media="print">
        .noprint
        {
            display: none;
        }
        #tblBarcode tr
        {
            page-break-after: always;
        }
    </style>
    <script language="javascript" type="text/javascript">
        function SilentPrint() {
            window.print();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <table class="noprint">
        <tr>
            <td>
                <input type="button" id="btnPrint" value="Print" name="Print" onclick="SilentPrint();" />
            </td>
        </tr>
    </table>
     <%--<asp:Table ID="tblBarcode" runat="server" CellPadding="0" CellSpacing="0" Border="0"
        Width="100%">
    </asp:Table--%>
    <div id="divPrint" runat="server">    
    </div> 
    </form>
</body>
</html>
